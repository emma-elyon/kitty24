mod cpu;
mod apu;
mod ram;
mod op;
mod event;
mod io;

use std::{sync::{Arc, Mutex}, collections::VecDeque, fs};

use common::memory;

use cpu::*;
use apu::*;
use ram::*;
use event::*;
use io::*;
pub use op::{Op, Op::*};

// Presentation
const WIDTH_LOW: usize = 320;
const HEIGHT_LOW: usize = 180;

const SCALE_HIGH: usize = 2;
pub const WIDTH_HIGH: usize = WIDTH_LOW * SCALE_HIGH;
pub const HEIGHT_HIGH: usize = HEIGHT_LOW * SCALE_HIGH;

const DISPLAY_BYTES_PER_PIXEL: usize = 4;
/// In bytes.
pub const DISPLAY_BUFFER_SIZE: usize = WIDTH_HIGH * HEIGHT_HIGH * DISPLAY_BYTES_PER_PIXEL;
pub const AUDIO_BUFFER_SIZE: usize = 4096;

// Operation
// const FRAMEBUFFER_SIZE: usize = WIDTH_LOW * HEIGHT_LOW;
const FRAMEBUFFER_ADDRESS: usize = 0xFF0000;
const FRAMEBUFFER_SIZE: usize = WIDTH_LOW * HEIGHT_LOW;
const RESOLUTION_MAP_ADDRESS: usize = FRAMEBUFFER_ADDRESS + FRAMEBUFFER_SIZE;
// const SCANLINES: usize = HEIGHT_LOW.next_power_of_two();
const SCANLINES: usize = (HEIGHT_LOW * 4).next_power_of_two();
const HIDDEN_SCANLINES: usize = SCANLINES - HEIGHT_LOW;

pub const CYCLES_PER_FRAME: usize = 1024 * 1024;
const CYCLES_PER_SCANLINE: usize = CYCLES_PER_FRAME / SCANLINES;

const SAMPLE_RATE: usize = 48000;

/// kitty24 Virtual Machine / emulator
pub struct VirtualMachine<F> where F: FnMut([u32; 16]) {
	boot: bool,
	cpu: Cpu,
	apu: Apu,
	ram: Ram,
	rom: Vec<u8>,
	exit: F,
	halted: bool,
	keys: Vec<u16>,
	palette: Vec<[u8; 3]>,
	
	/// Cycles remaining of the current block transfer or IO
	blocked_cycles: usize,
	
	/// Name of currently open file, if any.
	open_file_name: Option<String>,
    
	/// Name of current directory, relative to the kitty24 root.
	current_directory: String,
}

impl<F> VirtualMachine<F> where F: FnMut([u32; 16]) {
	/// Construct virtual machine preloaded with `rom`.
	pub fn new(rom: Vec<u8>, exit: F, boot: bool) -> Self {
		let boot_rom = read_rom("kitty24/boot").unwrap();
		Self {
			boot: true,
			cpu: Cpu::default(),
			apu: Apu::default(),
			ram: Ram::new(if boot { boot_rom } else { rom.clone() }),
			rom,
			exit,
			halted: false,
			keys: Vec::new(),
			palette: vec![
				// [Taffy 16 Palette](https://lospec.com/palette-list/taffy-16)
				// by [PineappleOnPizza](https://lospec.com/pinetreepizza)
				[0x22, 0x25, 0x33],
				[0x62, 0x75, 0xBA],
				[0xA3, 0xC0, 0xE6],
				[0xFA, 0xFF, 0xFC],
				[0xFF, 0xAB, 0x7B],
				[0xFF, 0x6C, 0x7A],
				[0xDC, 0x43, 0x5B],
				[0x3F, 0x48, 0xC2],
				[0x44, 0x8D, 0xE7],
				[0x2B, 0xDB, 0x72],
				[0xA7, 0xF5, 0x47],
				[0xFF, 0xEB, 0x33],
				[0xF5, 0x89, 0x31],
				[0xDB, 0x4B, 0x3D],
				[0xA6, 0x3D, 0x57],
				[0x36, 0x35, 0x4D],
			],
			blocked_cycles: 0,
			open_file_name: None,
            current_directory: String::new(),
		}
	}
	
	pub fn reboot(&mut self) {
		let boot_rom = read_rom("kitty24/boot").unwrap();
		self.boot = true;
		self.ram = Ram::new(boot_rom);
		self.cpu = Cpu::default();
		self.apu = Apu::default();
		self.blocked_cycles = 0;
		self.halted = false;
		self.open_file_name = None;
		self.current_directory = String::new();
	}
	
	/// Update the current key state, emitting any down- or up events
	/// (in that order).
	pub fn set_keys(&mut self, keys: &Vec<u16>) {
		for &key in keys {
			if !self.keys.contains(&key) {
				self.cpu.cause_event(Event::KeyDown(key).into());
				// eprintln!("key {} down", key)
			}
		}
		for &key in &self.keys {
			if !keys.contains(&key) {
				self.cpu.cause_event(Event::KeyUp(key).into());
				// eprintln!("key {} up", key)
			}
		}
		self.keys.clone_from(keys);
	}
	
	pub fn set_text(&mut self, text: Vec<u8>) {
		for character in text {
			self.cpu.cause_event(Event::Text(character).into());
			// eprintln!("char {}", character.escape_ascii().to_string())
		}
	}
	
	/// Run for one frame, returning busy cycle count.
	pub fn run(&mut self, display: &mut Vec<u8>, audio: Option<&Arc<Mutex<VecDeque<f32>>>>) -> usize {
		let mut busy_cycles = 0;

		// self.cpu.cause_event(Event::Timer.into());

		// Update audio.
		if let Some(audio) = audio {
			let mut buffer = audio.lock().unwrap();
			let length = buffer.len();
			let mut samples = vec![];

            // Square wave channel.
			let volume = self.ram[memory::AUDIO0_VOLUME as u32] as f32 / 255.0;
            let duty = (self.ram[memory::AUDIO0_DUTY as u32] as f32 / 255.0) * 0.5;
			let frequency_high = self.ram[memory::AUDIO0_PITCH as u32] as f32;
			let frequency_low = self.ram[memory::AUDIO0_PITCH as u32 + 1] as f32 / 256.0;
			let increment = 440.0 * 2.0f32.powf(((frequency_high + frequency_low) as f32 - 69.0) / 12.0) / SAMPLE_RATE as f32;
			let max_sample = AUDIO_BUFFER_SIZE as isize - length as isize - 1;
			for i in 0..=max_sample {
				let alpha = i as f32 / max_sample as f32;
				let phase = (self.apu.square.phase + increment) % 1.0;
				let volume = self.apu.square.volume * (1.0 - alpha) + volume * alpha;
				samples.push((phase - duty).signum() * volume);
				self.apu.square.phase = phase;
			}
			self.apu.square.volume = volume;

            // Triangle wave channel.
			let volume = self.ram[memory::AUDIO1_VOLUME as u32] as f32 / 255.0;
            let duty = (self.ram[memory::AUDIO1_DUTY as u32] as f32 / 255.0) * 0.5;
			let frequency_high = self.ram[memory::AUDIO1_PITCH as u32] as f32;
			let frequency_low = self.ram[memory::AUDIO1_PITCH as u32 + 1] as f32 / 256.0;
			let increment = 440.0 * 2.0f32.powf(((frequency_high + frequency_low) as f32 - 69.0) / 12.0) / SAMPLE_RATE as f32;
			let max_sample = AUDIO_BUFFER_SIZE as isize - length as isize - 1;
			for i in 0..=max_sample {
				let alpha = i as f32 / max_sample as f32;
				let phase = (self.apu.triangle.phase + increment) % 1.0;
				let volume = self.apu.triangle.volume * (1.0 - alpha) + volume * alpha;
				let saw = (phase * (0.5 + duty) - duty) * 2.0;
				let triangle = saw.abs() * 2.0 - 1.0;
				let sample = samples[i as usize];
				samples[i as usize] = sample + triangle * volume;
				// buffer.push_back(triangle * volume);
				self.apu.triangle.phase = phase;
			}
			self.apu.triangle.volume = volume;
			
			// PCM "channel".
			// TODO: Don't cause events if there's no actual use of it (how do
			// we know that? A memory mapped on/off toggle somewhere?
            // ... or just rely on the PCM interrupt enable? Nah, we may be out
			// of step with the interrupt handlers...
            if self.ram[memory::PCM_ENABLE as u32] > 0 {
				let max_sample = AUDIO_BUFFER_SIZE as isize - length as isize;
				for i in 0..max_sample {
					if let Some(pcm_sample) = self.apu.pcm.buffer.pop_front() {
						let pcm = (pcm_sample as f32 / 255.0) * 2.0 - 1.0;
						let sample = samples[i as usize];
						samples[i as usize] = sample + pcm;
					} else {
						eprintln!("PCM buffer underflow");
						break;
					}
				}
				let request_samples = AUDIO_BUFFER_SIZE - self.apu.pcm.buffer.len(); // - 1; // Why -1?
				if request_samples > 0 {
					self.cpu.cause_event(Event::Pcm(request_samples as u16).into());
				}
			}
			
			buffer.extend(samples);
		}

		for y in 0..HEIGHT_LOW {
			// Update machine.
			busy_cycles += self.step(CYCLES_PER_SCANLINE);
			
			// Render scanline to display buffer
			for x in 0..WIDTH_LOW {
				let offset = x + y * WIDTH_LOW;
				let address = FRAMEBUFFER_ADDRESS + offset;
				let display_index = x * SCALE_HIGH + y * WIDTH_HIGH * SCALE_HIGH;
				let display_index = display_index * DISPLAY_BYTES_PER_PIXEL;
				let palette_index = self.ram[address as u32];
                let resolution_address = RESOLUTION_MAP_ADDRESS + (offset >> 3);
                let mask = (1 << (offset & 0b111)) as u8;
                let high_res_mode = (self.ram[resolution_address as u32] & mask) != 0;
                if high_res_mode {
					let palette_indices = [
						(palette_index >> 6) & 0x3,
						(palette_index >> 4) & 0x3,
						(palette_index >> 2) & 0x3,
						(palette_index >> 0) & 0x3,
					];
                    let pixels = [
						self.palette[palette_indices[0] as usize],
						self.palette[palette_indices[1] as usize],
						self.palette[palette_indices[2] as usize],
						self.palette[palette_indices[3] as usize],
					];
					for (index, i) in [0, 1, WIDTH_HIGH, WIDTH_HIGH + 1].iter().enumerate() {
						let pixels = pixels[index];
						let pixel_index = display_index + i * DISPLAY_BYTES_PER_PIXEL;
						display[pixel_index + 0] = pixels[0];
						display[pixel_index + 1] = pixels[1];
						display[pixel_index + 2] = pixels[2];
						display[pixel_index + 3] = 255;
					}
				} else {
                    let pixel = if palette_index < 0xF0 {
                        // [0, palette_index, 0]
                        // HACK: mirror system palette for now.
                        // let palette_index = palette_index & 0xF;
                        // self.palette[palette_index as usize]
						// NOTE: This is currently being done in ROM
						
						// NEW NOTE: not anymore, using system palette
						// everywhere for now~
                        let palette_index = palette_index & 0xF;
                        self.palette[palette_index as usize]
                    } else { // System palette.
                        let palette_index = palette_index - 0xF0;
                        self.palette[palette_index as usize]
                    };
                    let (red, green, blue) = (pixel[0], pixel[1], pixel[2]);
                    for i in [0, 1, WIDTH_HIGH, WIDTH_HIGH + 1] {
                        let pixel_index = display_index + i * DISPLAY_BYTES_PER_PIXEL;
                        display[pixel_index + 0] = red;
                        display[pixel_index + 1] = green;
                        display[pixel_index + 2] = blue;
                        display[pixel_index + 3] = 255;
                    }
				}
			}
		}

		
		self.cpu.cause_event(Event::VBlank.into());

		busy_cycles += self.step(CYCLES_PER_SCANLINE * HIDDEN_SCANLINES);

		if busy_cycles >= CYCLES_PER_FRAME - 48576 {
			eprintln!(
				"Busy at {:6X} {:?}",
				self.cpu.get(REGISTER_PROGRAM_COUNTER),
				Op::from((self.ram[self.cpu.get(REGISTER_PROGRAM_COUNTER)] >> 4) as u8),
			);
		} else if busy_cycles < 1024 {
			eprintln!(
				"Idle at {:6X} {:2X}",
				self.cpu.get(REGISTER_PROGRAM_COUNTER),
				((self.ram[self.cpu.get(REGISTER_PROGRAM_COUNTER)] >> 4) as u8),
			);
		}

		busy_cycles
	}
	
	/// Step machine for `cycles` instructions.
	fn step(&mut self, cycles: usize) -> usize {
		let mut busy_cycles = 0;
		let mut previous_program_counter = 0;

		for _ in 0..cycles {
			// Skip if we're in a block transfer or IO operation.
			if self.blocked_cycles > 0 {
				self.blocked_cycles -= 1;
				busy_cycles += 1;
				continue;
			}

			// Fetch the next instruction.
			let program_counter = self.cpu.get(REGISTER_PROGRAM_COUNTER);
			if program_counter != previous_program_counter {
				previous_program_counter = program_counter;
				busy_cycles += 1;
			}

			// Halt and catch fire.
			if program_counter == 0xFFFFFF {
				if self.boot {
					for (index, byte) in self.rom.iter().enumerate() {
						self.ram[index as u32] = *byte;
					}
					self.cpu.set(REGISTER_PROGRAM_COUNTER, 0);
					self.boot = false;
					continue;
				} else {
					let exit_code = [
						self.cpu.get(0x0),
						self.cpu.get(0x1),
						self.cpu.get(0x2),
						self.cpu.get(0x3),
						self.cpu.get(0x4),
						self.cpu.get(0x5),
						self.cpu.get(0x6),
						self.cpu.get(0x7),
						self.cpu.get(0x8),
						self.cpu.get(0x9),
						self.cpu.get(0xA),
						self.cpu.get(0xB),
						self.cpu.get(0xC),
						self.cpu.get(0xD),
						self.cpu.get(0xE),
						self.cpu.get(0xF),
					];
					// println!("r1: {:X} ({})", self.cpu.get(0x1) & 0xFFFFFF, self.cpu.get(0x1));
					// println!("r2: {:X} ({})", self.cpu.get(0x2) & 0xFFFFFF, self.cpu.get(0x2));
					// println!("r3: {:X} ({})", self.cpu.get(0x3) & 0xFFFFFF, self.cpu.get(0x3));
					// println!("r4: {:X} ({})", self.cpu.get(0x4) & 0xFFFFFF, self.cpu.get(0x4));
					// println!("r5: {:X} ({})", self.cpu.get(0x5) & 0xFFFFFF, self.cpu.get(0x5));
					// println!("r6: {:X} ({})", self.cpu.get(0x6) & 0xFFFFFF, self.cpu.get(0x6));
					// println!("r7: {:X} ({})", self.cpu.get(0x7) & 0xFFFFFF, self.cpu.get(0x7));
					// println!("r8: {:X} ({})", self.cpu.get(0x8) & 0xFFFFFF, self.cpu.get(0x8));
					// println!("r9: {:X} ({})", self.cpu.get(0x9) & 0xFFFFFF, self.cpu.get(0x9));
					// println!("rA: {:X} ({})", self.cpu.get(0xA) & 0xFFFFFF, self.cpu.get(0xA));
					// println!("rB: {:X} ({})", self.cpu.get(0xB) & 0xFFFFFF, self.cpu.get(0xB));
					// println!("rC: {:X} ({})", self.cpu.get(0xC) & 0xFFFFFF, self.cpu.get(0xC));
					// println!("rD: {:X} ({})", self.cpu.get(0xD) & 0xFFFFFF, self.cpu.get(0xD));
					// println!("rE: {:X} ({})", self.cpu.get(0xE) & 0xFFFFFF, self.cpu.get(0xE));
					// println!("rF: {:X} ({})", self.cpu.get(0xF) & 0xFFFFFF, self.cpu.get(0xF));
					self.halted = true;
					(self.exit)(exit_code);
					return busy_cycles
				}
			}

			// Increment the program counter.
			// TODO: Determine if this should happen after executing the
			// instruction (in which case re-read the register).
			self.cpu.set(REGISTER_PROGRAM_COUNTER, program_counter + 3);
			
			// Decode the instruction.
			let opcode_register = self.ram[program_counter];
			let argument_0 = self.ram[program_counter + 1];
			let argument_1 = self.ram[program_counter + 2];
			let opcode = opcode_register >> 4;
			let register = opcode_register & 0xF;

			// Execute the instruction.
			let op: Op = opcode.into();
			match op {
				// I: 16 bit immediate instruction.
				If | Let =>
					self.i(op, register, argument_0, argument_1),
				
				// M: Memory load/store instruction.
				Load | Store | Pop | Push =>
					self.m(op, register, argument_0, argument_1),
				
				// R: Register-register instruction.
				Or | Nor | And | Xor | Add | Sub | Mul |
				Shift | Less | SignedLess =>
					self.r(op, register, argument_0, argument_1)
			}
		}
		
		busy_cycles
	}
	
	/// I: 16 bit immediate instruction.
	fn i(
		&mut self,
		op: Op,
		register: u8,
		immediate_high: u8,
		immediate_low: u8,
	) {
		// Decode 16 bit immediate.
		let immediate =
			i16::from_be_bytes([immediate_high, immediate_low]);

		match op {
			// if r, i16
			// PC <- PC + i16 if r != 0
			If => {
				let register_value = self.cpu.get(register) as i32;
				let condition = (register_value != 0 || register == 0) as i32;
				let immediate = condition * (immediate as i32 - 3); // FIXME: Magic number due to preincrement PC.
				let program_counter = self.cpu.get(REGISTER_PROGRAM_COUNTER) as i32;
				let value = (program_counter + immediate) as u32;
				self.cpu.set(REGISTER_PROGRAM_COUNTER, value);
			},

			// let r, u16
			// r <- u16
			Let => self.cpu.set(register, immediate as u16 as u32),
			_ => unreachable!()
		}
	}
	
	/// M: Memory load/store instruction.
	fn m(
		&mut self,
		op: Op,
		register: u8,
		source_byte_count_immediate_high: u8,
		immediate_low: u8,
	) {
		// Extract source register, byte count, and immediate.
		let source = source_byte_count_immediate_high >> 4;
		let byte_count = source_byte_count_immediate_high >> 2 & 0b11;
		let byte_count = byte_count as u32;
		let immediate_high = source_byte_count_immediate_high & 0b11;
		let immediate = i16::from_be_bytes([immediate_high, immediate_low]);

		// Sign-extend 10-bit immediate
		let immediate = immediate << 6;
		let immediate = immediate >> 6;
		let immediate = immediate as i32;

		// Read current register values.
		let register_value = self.cpu.get(register);
		let source_value = self.cpu.get(source);
		
		// Calculate the absolute memory address to access.
		let address = (register_value as i32 + immediate) as u32;
		
		// Execute the operation.
		match op {
			// ld s, r, b, i10
			// s <- [r + i]:b
			Load => {
				// Read bytes into the lower bytes of the register.
				// TODO: Remove non-deterministic time loop.
				let mut value = 0;
				for i in 0..byte_count {
					let byte = self.ram[address + i] as u32;
					let shift = 8 * (byte_count - 1) - 8 * i;
					value |= byte << shift;
				}
				self.cpu.set(source, value);
			},
			
			// st r, s, b, i10
			// [r + i]:b <- s
			Store => {
				// Store lower bytes from the register.
				let value = source_value;
				for i in 0..byte_count {
					let shift = 8 * (byte_count - 1) - 8 * i;
					self.ram[address + i] = (value >> shift) as u8
				}
				self.blocked_cycles += self.trigger_memory(address);
				// if address == memory::BLOCK_DST_ADDRESS as u32 {
				// 	self.blocked_cycles = self.ram.block_transfer();
				// }
			},

			// pop s, r, b, i10
			// s <- [r + i]:b, r <- r + b
			Pop => {
				// Load bytes into the lower bytes of the source register.
				// TODO: Remove non-deterministic time loop.
				let mut value = 0;
				for i in 0..byte_count {
					let byte = self.ram[address + i] as u32;
					let shift = 8 * (byte_count - 1) - 8 * i;
					value |= byte << shift;
				}
				self.cpu.set(source, value);
				
				// Increment address register.
                let register_value = self.cpu.get(register);
				self.cpu.set(register, register_value + byte_count);
			},
			
			// push r, s, b, i10
			// [r + i]:b <- s, r <- r - b
			Push => {
				// Decrement address register.
				self.cpu.set(register, register_value - byte_count);
				let register_value = register_value - byte_count;
				let address = (register_value as i32 + immediate) as u32;

				// Store lower bytes from the register.
				// TODO: Remove non-deterministic time loop.
				let value = source_value;
				for i in 0..byte_count {
					let shift = 8 * (byte_count - 1) - 8 * i;
					self.ram[address + i] = (value >> shift) as u8
				}
				self.blocked_cycles += self.trigger_memory(address);
			},
			_ => unreachable!()
		}
	}
	
	fn r(
		&mut self,
		op: Op,
		register: u8,
		source_target: u8,
		immediate: u8,
	) {
		// Decode instruction.
		let source = source_target >> 4;
		let target = source_target & 0xF;
		let immediate = immediate as u32;
		
		// Read source and target register values.
		let source_value = self.cpu.get(source);
		let target_value = self.cpu.get(target);
		
		// Execute the operation.
		let value = match op {
			Or => source_value | target_value | immediate,
			Nor => !(source_value | target_value | immediate),
			And => {
				// Register 0 defaults to 0xFFFFFF for `and`
				let source_value = source_value.max((source == 0) as u32 * 0xFFFFFF);
				let target_value = target_value.max((target == 0) as u32 * 0xFFFFFF);
				// Immediate never masks out everything, instead masking out nothing.
				let immediate = immediate.max((immediate == 0) as u32 * 0xFFFFFF);
				source_value & target_value & immediate
			}
			Xor => source_value ^ target_value ^ immediate,
			Add => source_value + target_value + immediate,
			Sub => source_value - target_value - immediate,
			Mul => {
				// Register 0 defaults to 1 for `mul`.
				let source_value = source_value.max((source == 0) as u32);
				let target_value = target_value.max((target == 0) as u32);
				source_value * target_value * immediate
			},
			Shift => {
				// TODO: Look into negative shifts, probably in the assembler;
				// shl r1, -3 => r1 << -3 => r1 >> 3
				let kind = immediate >> 5 & 0b111;
				let immediate = immediate & 0b11111;
				let shift = target_value + immediate;
				match kind {
					// shl r, s, t, i5
					// r <- s << t + i5
					0b000 => source_value << shift,

					// shr r, s, t, i5
					// r <- s >> t + i5
					0b001 => source_value >> shift,

					// rotl r, s, t, i5
					// r <- s <<< t + i5
					0b010 =>
						source_value << shift % 24 |
						source_value >> 24 - shift % 24,

					// rotr r, s, t, i5
					// r <- s >>> t + i5
					0b011 =>
						source_value >> shift % 24 |
						source_value << 24 - shift % 24,

					// ashl ???
					0b100 => unimplemented!("PC: {:X}", self.cpu.get(REGISTER_PROGRAM_COUNTER)),

					// ashr r, s, t, i5
					// r <- s >>+ t + i5
					0b101 => ((source_value as i32) << 8 >> 8 >> shift) as u32, 

					// arol ???
					0b110 => unimplemented!(),

					// aror ???
					0b111 => unimplemented!("PC: {:X}", self.cpu.get(REGISTER_PROGRAM_COUNTER)),
					_ => unreachable!()
				}
			}
			Less => (source_value < target_value + immediate) as u32,
			SignedLess => {
				let source_value = (source_value as i32) << 8 >> 8;
				let target_value = (target_value as i32) << 8 >> 8;
                let signed_immediate = ((immediate as i32) << 24 >> 24) as u32;
				(source_value < target_value + signed_immediate as i32) as u32
			}
			_ => unreachable!()
		};

		// Write back.
		self.cpu.set(register, value);
	}
	
	fn trigger_memory(&mut self, address: u32) -> usize {
		match address as usize {
			memory::BLOCK_DST_ADDRESS => self.ram.block_transfer(),
			io::LENGTH => self.io(),
			_ => 0,
		}
	}
	
	fn io(&mut self) -> usize {
		let port =
			((self.ram[io::PORT as u32 + 0] as u32) << 16) |
			((self.ram[io::PORT as u32 + 1] as u32) <<  8) |
			((self.ram[io::PORT as u32 + 2] as u32) <<  0);

		let address =
			((self.ram[io::ADDRESS as u32 + 0] as u32) << 16) |
			((self.ram[io::ADDRESS as u32 + 1] as u32) <<  8) |
			((self.ram[io::ADDRESS as u32 + 2] as u32) <<  0);

		let length =
			((self.ram[io::LENGTH as u32 + 0] as u32) << 16) |
			((self.ram[io::LENGTH as u32 + 1] as u32) <<  8) |
			((self.ram[io::LENGTH as u32 + 2] as u32) <<  0);
		
		match port as usize {
			io::PCM => self.pcm(address, length),
			io::RUN => self.run_rom(address, length),
			io::OPEN => self.open(address, length),
			io::READ => self.read(address, length),
			io::WRITE => self.write(address, length),
			io::READ_META => self.read_metadata(address, length),
			io::CHANGE_DIR => self.change_dir(address, length),
			io::READ_DIR => self.read_dir(address, length),
			io::WRITE_DIR => self.write_dir(address, length),
			n => {
				eprintln!("IO: {}", n);
				0
			}
		}
	}

	fn pcm(&mut self, address: u32, length: u32) -> usize {
		for i in 0..length {
			self.apu.pcm.buffer.push_back(self.ram[address + i])
		}
		length as usize
	}
	
	fn run_rom(&mut self, address: u32, length: u32) -> usize {
		let prefix = String::from("kitty24/");
		let mut path = String::new();
		
		for i in address..address + length {
			path += &self.ram[i].escape_ascii().to_string();
		}
        
        match read_rom(&(prefix + &path)) {
			Ok(rom) => {
				self.ram = Ram::new(rom);
				self.cpu = Cpu::default();
				self.apu = Apu::default();
				eprintln!("RUN \"{}\"", path);
			},
			Err(error) => eprintln!("ERROR \"{}\" {}", path, error),
		}
		
		0
	}
	
	fn open(&mut self, address: u32, length: u32) -> usize {
		let prefix = String::from("kitty24/") + &self.current_directory;
		let mut path = String::new();
		for i in address..address + length {
			path += &self.ram[i].escape_ascii().to_string();
		}
		let path = prefix + &path;
		if let Ok(metadata) = fs::metadata(&path) {
			if metadata.is_file() {
				self.open_file_name = Some(path.clone());
				eprintln!("FILE: {} {:?}", path, metadata.modified());
			} else if metadata.is_dir() {
				self.open_file_name = Some(path.clone());
				eprintln!("FOLDER: {} {:?}", path, metadata.modified());
			} else {
				self.open_file_name = None;
				eprintln!("UNKNOWN META: {} {:?}", path, metadata.file_type());
			}
		} else {
			self.open_file_name = Some(path.clone());
			eprintln!("OPEN: File not found (yet): \"{}\"", path);
		}
		length as usize
	}
	
	/// Read contents from open file into `address`, at most `length` bytes
	fn read(&mut self, address: u32, length: u32) -> usize {
		if let Some(file_name) = &self.open_file_name {
			if let Ok(bytes) = fs::read(file_name) {
				for i in 0..length as usize {
					if bytes.len() > i {
						self.ram[address + i as u32] = bytes[i];
					} else {
						self.ram[io::STATUS as u32 + 0] = (i >> 16) as u8;
						self.ram[io::STATUS as u32 + 1] = (i >> 8) as u8;
						self.ram[io::STATUS as u32 + 2] = (i >> 0) as u8;
						return i
					}
				}
				self.ram[io::STATUS as u32 + 0] = (length >> 16) as u8;
				self.ram[io::STATUS as u32 + 1] = (length >> 8) as u8;
				self.ram[io::STATUS as u32 + 2] = (length >> 0) as u8;
				length as usize
			} else {
				eprintln!("ERROR: Some file error, probably was a directory: \"{}\"", file_name);
				0
			}
		} else {
			eprintln!("ERROR: No open file");
			0
		}
	}
}

fn read_rom(path: &str) -> Result<Vec<u8>, std::io::Error> {
	if fs::metadata(path).unwrap().is_dir() {
		let assembly = compiler::Compiler::build(path)?;
		// std::fs::write(format!("{}.kitty.asm", path), assembly.join("\n").as_bytes()).unwrap();
		// eprintln!("{}", assembly.join("\n"));
		let rom = assembler::Assembler::assemble(&assembly.join("\n"))?;
		std::fs::write(format!("{}.kitty", path), rom.clone()).unwrap();
		Ok(rom)
	} else {
		let rom = std::fs::read(path)?;
		Ok(rom)
	}
}

