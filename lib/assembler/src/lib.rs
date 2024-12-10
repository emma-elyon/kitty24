use std::{collections::HashMap, io::ErrorKind};

extern crate pest;
#[macro_use]
extern crate pest_derive;

mod ast;
mod parser;

use common::processor::{*, Op::*};

use ast::{*, Shift};

/// Constructs machine code ROM from kitty-assembly source.
pub struct Assembler {
	/// Current instruction address being assembled, to relate label definitions
	/// and references to.
	address: u32,

	/// Current global label, to relate local labels to.
	///
	/// Local labels start with `.`, and have the previous non-local label
	/// prepended to their name, so `.loop` might become `main.loop` in terms of
	/// lookup.
	///
	/// Local labels defined before any non-local labels do not get a prefix,
	/// this making it possible to have a non-local label start with `.`. This
	/// can never be referenced again after the first global label, though.
	label: String,

	/// Map of strings to absolute addresses of defined labels.
	label_addresses: HashMap<String, u32>,

	/// Map of references to defined labels.
	label_references: Vec<LabelReference>, 
}

/// References a ROM address offset with a label, and optionally a byte range.
enum LabelReference {
	/// `length` bytes of a label address, from byte_index.
	Absolute16 { address: u32, label: String, byte_index: u8, length: u8 },

	/// One byte of a label address, at byte_index.
	Absolute8 { address: u32, label: String, byte_index: u8 },

	/// Expands to two bytes' signed offset from a label.
	Relative16 { address: u32, label: String },
}

impl Assembler {
	/// Parse and assemble ROM from kitty-assembly source.
	pub fn assemble(source: &str) -> Result<Vec<u8>, std::io::Error> {
		let program: Program = source.try_into()?;
		let mut assembler = Assembler::default();
		assembler.assemble_program(program)
	}

	/// Assemble ROM from Program AST.
	fn assemble_program(&mut self, program: Program)
	-> Result<Vec<u8>, std::io::Error> {
		let mut rom = Vec::new();

		// Assemble each instruction, deferring label resolution until after
		// every instruction has been assembled.
		for statement in program.statements {
			if let Some(bytes) = self.assemble_statement(statement) {
				rom.extend(bytes);
				self.address = rom.len() as u32;
			}
		}
		
		// Resolve label references, replacing empty bytes in the assembled ROM
		// with the label value they should have.
		for reference in &self.label_references {
			// Resolve the insertion address, and the bytes to inject.
			let (reference_address, bytes) = self.resolve_reference(reference)?;

			// Insert the bytes at the reference address in the ROM.
			for (index, byte) in bytes.iter().enumerate() {
				let address = reference_address as usize + index;
				rom[address] = *byte;
			}
		}
		
		Ok(rom)
	}
	
	/// Assemble instruction or add label definition, deferring label
	/// resolution.
	fn assemble_statement(&mut self, statement: Statement)
	-> Option<Vec<u8>> {
		match statement {
			Statement::Instruction(instruction) =>
				Some(self.assemble_instruction(instruction)),

			Statement::Label(label) => {
				self.assemble_label(label);
				None
			},
			
			Statement::EndOfInput => None
		}
	}
	
	/// Assemble instruction of type [R], [RS], [I], [IF], or [M].
	fn assemble_instruction(&mut self, instruction: Instruction)
	-> Vec<u8> {
		match instruction {
			Instruction::Or(r) =>
				self.assemble_r(r, Or),
			Instruction::Nor(r) =>
				self.assemble_r(r, Nor),
			Instruction::And(r) =>
				self.assemble_r(r, And),
			Instruction::Xor(r) =>
				self.assemble_r(r, Xor),
			Instruction::Add(r) =>
				self.assemble_r(r, Add),
			Instruction::Sub(r) =>
				self.assemble_r(r, Sub),
			Instruction::Mul(r) =>
				self.assemble_r(r, Mul),
			Instruction::ShiftLeft(rs) =>
				self.assemble_rs(rs, Shift::ShiftLeft),
			Instruction::ShiftRight(rs) =>
				self.assemble_rs(rs, Shift::ShiftRight),
			Instruction::RotateLeft(rs) =>
				self.assemble_rs(rs, Shift::RotateLeft),
			Instruction::RotateRight(rs) =>
				self.assemble_rs(rs, Shift::RotateRight),
			Instruction::ArithmeticShiftRight(rs) =>
				self.assemble_rs(rs, Shift::ArithmeticShiftRight),
			Instruction::SignedLess(r) =>
				self.assemble_r(r, SignedLess),
			Instruction::Less(r) =>
				self.assemble_r(r, Less),
			Instruction::If(if_) =>
				self.assemble_if(if_),
			Instruction::Let(i) =>
				self.assemble_i(i),
			Instruction::Load(m) =>
				self.assemble_m(m, Load),
			Instruction::Store(m) =>
				self.assemble_m(m, Store),
			Instruction::Pop(m) =>
				self.assemble_m(m, Pop),
			Instruction::Push(m) =>
				self.assemble_m(m, Push),
			Instruction::Data(data) =>
				self.assemble_data(data),
		}
	}
	
	/// Add label with address to lookup table, used later for resolving label
	/// references.
	fn assemble_label(&mut self, label: Label) {
		match label {
			// Non-local label is added directly, and the global label is
			// updated.
			Label::Global(string) => {
				self.label = string.clone();
				self.label_addresses.insert(string, self.address);
			},

			// Local label has global label prepended.
			Label::Local(string) => {
				let label = format!("{}.{}", self.label, string);
				self.label_addresses.insert(label, self.address);
			}
		}
	}

	/// Assemble 16-bit immediate instruction; `let`.
	fn assemble_i(&mut self, i: I) -> Vec<u8> {
		let operation: u8 = Let.into();
		let destination: u8 = i.destination.into();
		let mut immediate = 0;

		// For `let`, the immediate might be a label reference byte range.
		match i.immediate {
			IImmediate::Constant(value) => immediate = value,
			IImmediate::Label { label, byte_index, length } =>
				self.assemble_label_reference_16(label, byte_index, length),
		};

		vec![
		   operation << 4 | destination,
		   (immediate >> 8) as u8,
		   immediate as u8,
		]
	}
	
	/// Assemble 16-bit immediate branch on non-zero instruction; `if`.
	fn assemble_if(&mut self, if_: IF) -> Vec<u8> {
		let operation: u8 = If.into();
		let destination: u8 = if_.destination.into();
		let mut immediate = 0;

		// For `if`, the immediate might be a relative label reference.
		match if_.immediate {
			IFImmediate::Constant(value) => immediate = value,
			IFImmediate::Label(label) =>
				self.assemble_relative_label_reference(label),
		};

		vec![
		   operation << 4 | destination,
		   (immediate >> 8) as u8,
		   immediate as u8,
		]
	}
	
	/// Assemble memory access instruction; `ld`, `st`, `pop`, `push`.
	fn assemble_m(&mut self, m: M, op: Op) -> Vec<u8> {
		let operation: u8 = op.clone().into();
		let destination: u8 = m.destination.into();
		let source: u8 = m.source.into();
		let byte_count = m.byte_count;
		let immediate = m.immediate;
		
		// `ld` and `pop` have their instruction source and destination
		// registers flipped, to ease decoding by the virtual machine.
		match op {
			Load | Pop => vec![
			   operation << 4 | source,
			   destination << 4 | byte_count << 2 | (immediate >> 8) as u8 & 0b11,
			   immediate as u8
			],
			_ => vec![
			   operation << 4 | destination,
			   source << 4 | byte_count << 2 | (immediate >> 8) as u8 & 0b11,
			   immediate as u8
			]
		}
	}
	
	/// Register-register instruction. `or`, `and`, `add`, `mul`, etc.
	fn assemble_r(&mut self, r: R, op: Op) -> Vec<u8> {
		let operation: u8 = op.into();
		let destination: u8 = r.destination.into();
		let source: u8 = r.source.into();
		let target: u8 = r.target.into();
		let mut immediate = 0;

		// For R-instructions, the immediate might be a single byte label
		// reference.
		match r.immediate {
			RImmediate::Constant(value) => immediate = value,
			RImmediate::Label { label, byte_index } =>
				self.assemble_label_reference_8(label, byte_index)
		};

		vec![
			operation << 4 | destination,
			source << 4 | target,
			immediate
		]
	}
	
	/// Register-register shift instruction. `shl`, `shr`, `rotl`, `rotr`,
	/// `ashl`.
	fn assemble_rs(&mut self, rs: RS, shift: Shift) -> Vec<u8> {
		let operation: u8 = Shift.into();
		let destination: u8 = rs.destination.into();
		let source: u8 = rs.source.into();
		let target: u8 = rs.target.into();
		let immediate = rs.immediate;
		let kind: u8 = shift.into();
		vec![
			operation << 4 | destination,
			source << 4 | target,
			kind << 5 | immediate
		]
	}
	
	/// Raw data storage. This is just an excessive identity function currently.
	fn assemble_data(&mut self, data: Vec<u8>) -> Vec<u8> {
		data
	}
	
	/// 16-bit relative label reference, used for `if`.
	fn assemble_relative_label_reference(&mut self, label: Label) {
		let address = self.address;
		match label {
			// Global labels are used as is.
			Label::Global(label) => {
				let label_reference = LabelReference::Relative16 {
					address,
					label
				};
				self.label_references.push(label_reference);
			}

			// Local labels have the current global label prepended.
			Label::Local(label) => {
				let label = format!("{}.{}", self.label, label);
				let label_reference = LabelReference::Relative16 {
					address,
					label
				};
				self.label_references.push(label_reference);
			}
		}
	}

	/// 8-bit absolute label byte, used for R-instructions.
	fn assemble_label_reference_8(&mut self, label: Label, byte_index: u8) {
		let address = self.address;
		match label {
			// Global labels are used as is.
			Label::Global(label) => {
				let label_reference = LabelReference::Absolute8 {
					address,
					label,
					byte_index
				};
				self.label_references.push(label_reference);
			}

			// Local labels have the current global label prepended.
			Label::Local(label) => {
				let label = format!("{}.{}", self.label, label);
				let label_reference = LabelReference::Absolute8 {
					address,
					label,
					byte_index
				};
				self.label_references.push(label_reference);
			}
		}
	}
	
	/// 16-bit absolute label byte range, used for `let`.
	fn assemble_label_reference_16(
		&mut self,
		label: Label,
		byte_index: u8,
		length: u8
	) {
		let address = self.address;
		match label {
			// Global labels are used as is.
			Label::Global(label) => {
				let label_reference = LabelReference::Absolute16 {
					address,
					label,
					byte_index,
					length
				};
				self.label_references.push(label_reference);
			}

			// Local labels have the current global label prepended.
			Label::Local(label) => {
				let label = format!("{}.{}", self.label, label);
				let label_reference = LabelReference::Absolute16 {
					address,
					label,
					byte_index,
					length
				};
				self.label_references.push(label_reference);
			}
		}
	}
	
	/// Returns insertion address and label address bytes to insert.
	fn resolve_reference(&self, reference: &LabelReference)
	-> Result<(u32, Vec<u8>), std::io::Error> {
		match reference {
			// 16-bit absolute label reference. Used for `let`.
			LabelReference::Absolute16 { address, label, byte_index, length } =>
				self.resolve_absolute16(*address, label, *byte_index, *length),

			// 8-bit absolute label reference. Used for R-instructions.
			LabelReference::Absolute8 { address, label, byte_index } =>
				self.resolve_absolute8(*address, label, *byte_index),

			// 16-bit relative label reference. Used for `if`.
			LabelReference::Relative16 { address, label } =>
				self.resolve_relative16(*address, label),
		}
	}

	/// Resolves label reference to address, selecting `length` address bytes
	/// (up to two) from `byte_index`.
	fn resolve_absolute16(
		&self,
		address: u32,
		label: &str,
		byte_index: u8,
		length: u8,
	) -> Result<(u32, Vec<u8>), std::io::Error> {
		// Look up the label definition's absolute address.
		if let Some(&label_address) = self.label_addresses.get(label) {
			// Insert bytes one byte into the instruction to skip opcode and
			// destination register.
			let byte_offset = 1;
			
			// Insert label address bytes at the reference address' immediate
			// byte offset.
			let reference_address = address + byte_offset;
			
			// Collect bytes from the absolute address, skipping the high byte
			// of the four bytes (it's always zero as only 24 bits are
			// supported.)
			let address_bytes = label_address.to_be_bytes();
			let bytes = match length {
				// In case only one byte is specified, zero out the high byte.
				1 => vec![0, address_bytes[byte_index as usize + 1]],
				
				// Else use two bytes.
				2 => vec![
					address_bytes[byte_index as usize + 1],
					address_bytes[byte_index as usize + 2]
				],
				_ => return Err(std::io::Error::new(
					ErrorKind::InvalidInput,
					format!(
						"Too large byte range: [{}:{}]",
						byte_index,
						byte_index + length - 1,
					)
				))
			};
			
			// Return insertion ROM address, and label address bytes to insert.
			Ok((reference_address, bytes))
		} else {
			Err(std::io::Error::new(
				ErrorKind::NotFound,
				format!("Label not found: '{}'", label)
			))
		}
	}
	
	/// Resolves label reference to address, selecting `length` address bytes
	/// (up to two) from `byte_index`.
	fn resolve_absolute8(
		&self,
		address: u32,
		label: &str,
		byte_index: u8,
	) -> Result<(u32, Vec<u8>), std::io::Error> {
		// Look up the label definition's absolute address.
		if let Some(&label_address) = self.label_addresses.get(label) {
			// Insert bytes two bytes into the instruction to skip opcode,
			// destination-, source-, and target registers.
			let byte_offset = 2;

			// Insert label address bytes at the reference address' immediate
			// byte offset.
			let reference_address = address + byte_offset;
			
			// Collect byte from the absolute address, skipping the high byte of
			// the four bytes (It's always zero as only 24 bits are supported.)
			let address_bytes = label_address.to_be_bytes();
			let bytes = vec![address_bytes[byte_index as usize + 1]];

			// Return insertion ROM address, and label address byte to insert.
			Ok((reference_address, bytes))
		} else {
			Err(std::io::Error::new(
				ErrorKind::NotFound,
				format!("Label not found: '{}'", label)
			))
		}
	}
	
	fn resolve_relative16(
		&self,
		address: u32,
		label: &str,
	) -> Result<(u32, Vec<u8>), std::io::Error> {
		// Look up the label definition's absolute address.
		if let Some(&label_address) = self.label_addresses.get(label) {
			// Insert bytes one byte into the instruction to skip opcode and
			// destination register.
			let byte_offset = 1;
			
			// Insert relative label address bytes at the reference address'
			// immediate byte offset.
			let reference_address = address + byte_offset;
			
			// Calculate relative offset bytes.
			let address_offset = label_address as i32 - address as i32;
			let bytes = (address_offset as i16).to_be_bytes().to_vec();
			
			// Return insertion ROM address, and relative label offset bytes
			// to insert.
			Ok((reference_address, bytes))
		} else {
			Err(std::io::Error::new(
				ErrorKind::NotFound,
				format!("Label not found: '{}'", label)
			))
		}
	}
}

impl Default for Assembler {
    fn default() -> Self {
        Self {
			address: 0,
			label: String::new(),
			label_addresses: HashMap::new(),
			label_references: Vec::new(),
		}
    }
}

impl From<Shift> for u8 {
    fn from(value: Shift) -> Self {
		match value {
			Shift::ShiftLeft => 0b000,
			Shift::ShiftRight => 0b001,
			Shift::RotateLeft => 0b010,
			Shift::RotateRight => 0b011,
			Shift::ArithmeticShiftRight => 0b101,
		}
    }
}

impl From<Register> for u8 {
    fn from(value: Register) -> Self {
		match value {
			Register::R0 => 0,
			Register::R1 => 1,
			Register::R2 => 2,
			Register::R3 => 3,
			Register::R4 => 4,
			Register::R5 => 5,
			Register::R6 => 6,
			Register::R7 => 7,
			Register::R8 => 8,
			Register::R9 => 9,
			Register::RA => 0xA,
			Register::RB => 0xB,
			Register::RC => 0xC,
			Register::RD => 0xD,
			Register::RE => 0xE,
			Register::RF => 0xF,
		}
    }
}

/*
/// Parse and assemble ROM from kitty-assembly source.
pub fn assemble(source: &str) -> Result<Vec<u8>, std::io::Error> {
	// match KittyAsmParser::parse(Rule::Program, source) {
	// 	Ok(program) => assemble_program(program),
	// 	Err(error) => Err(
	// 		std::io::Error::new(
	// 			ErrorKind::InvalidInput,
	// 			error,
	// 		)
	// 	)
	// }
}

fn assemble_program(program: Program) -> Result<Vec<u8>, std::io::Error> {
	let mut rom = Vec::new();
	let mut label_definitions = HashMap::new();
	let mut label_references = HashMap::new();
	for statement in program.statements {
		let bytes = match statement {
			Statement::Instruction(instruction) =>
				assemble_instruction(instruction)?,
			Statement::Label(label) => todo!(),
		};
		rom.extend(bytes);
	}
	Ok(rom)
}

/// Assemble ROM from parser output.
fn _assemble_program(program: Pairs<Rule>) -> Result<Vec<u8>, std::io::Error> {
	let mut rom = Vec::new();
	let mut label_definitions = HashMap::new();
	let mut label_references = HashMap::new();
	let mut address = 0;
	
	// Local labels start with ".", and have the previous non-local label
	// prepended to their name, so `.loop` becomes `main.loop` in terms of
	// lookup.
	// Local labels defined before any non-local labels do not get a prefix,
	// thus making it possible to have a non-local label start with `.`
	let mut scope = String::new();

	// Assemble each instruction, deferring label resolution until after every
	// instruction has been assembled.
	for statement in program {
		match statement.as_rule() {
			// let r, 42
			Rule::Instruction => {
				let instruction = statement.into_inner().next().unwrap();
				let (bytes, label) = assemble_instruction(instruction)?;
				let length = bytes.len();
				rom.extend(bytes);
				
				// Store label references with address and offset for relative
				// addressing in the label resolution step.
				if let Some((label, offset)) = label {
					label_references.insert(label, (address, offset, scope.clone()));
				}

				address += length;
			},
			
			// routine:
			Rule::LabelDefinition => {
				let statement = statement.into_inner().next().unwrap();
				match statement.as_rule() {
					// Non-local label is added directly, scope is updated.
					Rule::Label => {
						let label = statement.as_str().to_string();

						// Store label definitions with address for the label
						// resolution step.
						label_definitions.insert(label.clone(), address);

						// Update scope to refer to this non-local label.
						scope = label;
						
						eprintln!("{}:", scope);
					},
					
					// Local label has scope prepended.
					Rule::LocalLabel => {
						let label = statement.as_str();
						
						// Prepend current scope.
						let label = format!("{}.{}", scope, label);

						// Store label definitions with address for the label
						// resolution step.
						label_definitions.insert(label.clone(), address);

						eprintln!("{}:", label);
					},
					
					_ => unreachable!("{:?}", statement)
				}
			},

			Rule::EOI => { }
			_ => unimplemented!("{:?}", statement)
		}
	}
	
	// Resolve labels, replacing empty bytes in the assembled ROM with the label
	// value they should have.
	for (pair, (instruction_address, immediate_offset, scope)) in label_references {
		// The exact byte index for injecting the label value into the assembled
		// ROM.
		let injection_address = instruction_address + immediate_offset as usize;

		match pair.as_rule() {
			// Relative label, used for IF-instructions.
			Rule::Label => {
				let label = pair.as_str();
				
				// Look up the label definition's absolute address.
				if let Some(&label_address) = label_definitions.get(label) {
					let relative_offset =
						label_address as i32 - instruction_address as i32;
					let relative_offset = relative_offset as i16;
					let x = relative_offset >> 8;
					let y = relative_offset & 0xFF;
					rom[injection_address] = x as u8;
					rom[injection_address + 1] = y as u8;
				} else {
					return Err(
						std::io::Error::new(
							ErrorKind::NotFound,
							format!(
								"Label not found in {:?}: {:?}",
								label_definitions,
								pair
							),
						)
					)
				}
			},

			// Relative local label, used for IF-instructions.
			Rule::LocalLabel => {
				let label = format!("{}.{}", scope, pair.as_str());
				
				eprintln!("ref '{}'", label.clone());
				
				// Look up the label definition's absolute address.
				if let Some(&label_address) = label_definitions.get(label.as_str()) {
					let relative_offset =
						label_address as i32 - instruction_address as i32;
					let relative_offset = relative_offset as i16;
					let x = relative_offset >> 8;
					let y = relative_offset & 0xFF;
					rom[injection_address] = x as u8;
					rom[injection_address + 1] = y as u8;
				} else {
					return Err(
						std::io::Error::new(
							ErrorKind::NotFound,
							format!(
								"Label not found in {:?}: {:?}",
								label_definitions,
								pair
							),
						)
					)
				}
			},
			
			// Absolute 8-bit label segment, used for R-instructions.
			Rule::Label8 => {
				let mut arguments = pair.clone().into_inner();
				let label = arguments.next().unwrap().as_str();

				// Look up the label definition's absolute address.
				if let Some(&label_address) = label_definitions.get(label) {
					let byte_index =  arguments
						.next()
						.unwrap()
						.as_str()
						.parse::<u8>()
						.unwrap() as usize;
					let bytes = (label_address as u32).to_be_bytes();
					// The top byte should be skipped, because kitty24
					// only uses 24 lower bits, in big endian.
					let byte = bytes[byte_index + 1];
					rom[injection_address] = byte;
				} else {
					return Err(
						std::io::Error::new(
							ErrorKind::NotFound,
							format!(
								"Label not found in {:?}: {:?}",
								label_definitions,
								pair
							),
						)
					)
				}
			}
			
			// Absolute 16-bit label segment, used for I-instructions.
			Rule::Label16 => {
				let mut arguments = pair.clone().into_inner();
				let label = arguments.next().unwrap().as_str();
				
				// Look up the label definition's absolute address.
				if let Some(&label_address) = label_definitions.get(label) {
					let argument =  arguments.next().unwrap();
					match argument.as_rule() {
						// Several (hopefully two) bytes requested, as a range.
						Rule::ByteRange => {
							let mut arguments = argument.into_inner();
							let from = arguments
								.next()
								.unwrap()
								.as_str()
								.parse::<u8>()
								.unwrap() as usize;
							let to = arguments
								.next()
								.unwrap()
								.as_str()
								.parse::<u8>()
								.unwrap() as usize;
							// Only proceed if exactly two bytes are requested.
							if to - from == 1 {
								let bytes = (label_address as u32).to_be_bytes();
								// The top byte should be skipped, because kitty24
								// only uses 24 lower bits, in big endian.
								let x = bytes[from + 1];
								let y = bytes[to + 1];
								rom[injection_address] = x;
								rom[injection_address + 1] = y;
								
							} else {
								return Err(
									std::io::Error::new(
										ErrorKind::InvalidInput,
										format!("Invalid byte range: {}", pair),
									)
								)
							}
						}
						
						// One byte requested.
						Rule::ByteIndex => {
							let byte_index = argument
								.as_str()
								.parse::<u8>()
								.unwrap() as usize;
							let bytes = (label_address as u32).to_be_bytes();
							// The top byte should be skipped, because kitty24
							// only uses 24 lower bits, in big endian.
							let byte = bytes[byte_index + 1];
							// We're inserting one byte in a spot for two bytes,
							// so zero out the high byte.
							rom[injection_address] = 0;
							rom[injection_address + 1] = byte;
						}
						_ => unreachable!()
					}
				} else {
					return Err(
						std::io::Error::new(
							ErrorKind::NotFound,
							format!(
								"Label not found in {:?}: {:?}",
								label_definitions,
								pair
							),
						)
					)
				}
			},
			
			_ => todo!("{}", pair),
		}
	}

	Ok(rom)
}

/// Assemble instruction according to its format (I, IF, M, R, RS)
fn assemble_instruction(instruction: Pair<Rule>) -> LabelResult {
	match instruction.as_rule() {
		Rule::Or => r(instruction, Or),
		Rule::Nor => r(instruction, Nor),
		Rule::And => r(instruction, And),
		Rule::Xor => r(instruction, Xor),
		Rule::Add => r(instruction, Add),
		Rule::Sub => r(instruction, Sub),
		Rule::Mul => r(instruction, Mul),
		Rule::ShiftLeft => rs(instruction),
		Rule::ShiftRight => rs(instruction),
		Rule::RotateLeft => rs(instruction),
		Rule::RotateRight => rs(instruction),
		Rule::ArithmeticShiftRight => rs(instruction),
		Rule::Less => r(instruction, Less),
		Rule::SignedLess => r(instruction, SignedLess),
		Rule::If => if_(instruction, If),
		Rule::Let => i(instruction, Let),
		Rule::Load => m(instruction, Load),
		Rule::Store => m(instruction, Store),
		Rule::Push => m(instruction, Push),
		Rule::Pop => m(instruction, Pop),
		_ => unreachable!()
	}
}

/// `Register ~ "," ~ Value16`
fn i(instruction: Pair<Rule>, op: Op) -> LabelResult {
	let mut arguments = instruction.into_inner();

	let operation = u8::from(op);

	// Assemble destination register.
	let register = arguments.next().unwrap().as_str();
	let register = register_index(register);

	// Assemble immediate.
	let immediate = arguments.next().unwrap();
	let (immediate, label) = read_value16(immediate);
	
	Ok(
		(
			vec![
				operation << 4 | register,
				(immediate >> 8) as u8,
				immediate as u8,
			],
			label.map(|label| (label, 1)),
		)
	)
}

/// `Register ~ "," ~ RelativeValue16`
fn if_(instruction: Pair<Rule>, op: Op) -> LabelResult {
	let mut arguments = instruction.into_inner();

	let operation = u8::from(op);

	// Assemble destination register.
	let register = arguments.next().unwrap().as_str();
	let register = register_index(register);

	// Assemble immediate.
	let immediate = arguments.next().unwrap();
	let (immediate, label) = read_relative_value16(immediate);
	
	Ok(
		(
			vec![
				operation << 4 | register,
				(immediate >> 8) as u8,
				immediate as u8,
			],
			label.map(|label| (label, 1)),
		)
	)
}

/// `Register ~ ("," ~ Register)? ~ (("," ~ Number2) ~ ("," ~ SignedNumber10)?)?`
//  ld r1, r2, 3, -15
//  ld r1, r2, 3
//  ld r1, 3
//  ld r1
fn m(instruction: Pair<Rule>, op: Op) -> LabelResult {
	let mut arguments = instruction.into_inner();
	
	let operation = u8::from(op);
	
	// Assemble destination register.
	let register = arguments.next().unwrap().as_str();
	let register = register_index(register);
	
	let mut source = None;
	let mut bytes = None;
	let mut immediate = None;

	// Determine whether the second argument is a register (source) or a value
	// (bytes).
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			// Second argument is a register (source)
			Rule::Register => 
				source = Some(register_index(argument.as_str())),
			
			Rule::Number2 =>
				bytes = Some(read_number2(argument)),

			_ => unreachable!()
		}
	} else {
		// No second argument, we're running with implicit `ld r1, r1, 1, 0`
		source = Some(register);
		bytes = Some(1);
		immediate = Some(0);
	}
	
	// If the second argument was a byte count, the third argument has to be the
	// immediate (or left out).
	if bytes.is_some() && immediate.is_none() {
		immediate = if let Some(immediate) = arguments.next() {
			Some(read_signed_number10(immediate))
		} else {
			Some(0)
		};
	
	// If the second argument was the source register, the third argument has to
	// be the byte count, or left out.
	} else if let Some(argument) = arguments.next() {
		bytes = Some(read_number2(argument));
	
	// In case the byte count is left out, set default values.
	} else {
		source = source.or(Some(register));
		bytes = Some(1);
		immediate = Some(0);
	}

	// At this point we're guaranteed to have values for source and byte count.
	let source = source.unwrap();
	let bytes = bytes.unwrap();
	
	// If there is a fourth argument, it has to be the immediate.
	let immediate = if let Some(argument) = arguments.next() {
		Some(read_signed_number10(argument))
	} else {
		immediate.or(Some(0))
	};

	// We now have all the values.
	let immediate = immediate.unwrap();
	
	Ok(
		(
			vec![
				operation << 4 | register,
				source << 4 | bytes << 2 | ((immediate as u16) >> 8) as u8,
				immediate as u8
			],
			None,
		)
	)
}

	

/// `Register ~ ("," ~ Register){1, 2}? ~ ("," ~ Value8)?`
fn r(instruction: Pair<Rule>, op: Op) -> LabelResult {
	let mut arguments = instruction.clone().into_inner();

	let operation = u8::from(op.clone());
	
	// Assemble destination register.
	let register = arguments.next().unwrap().as_str();
	let register = register_index(register);

	let mut source = None;
	let mut target = None;
	let mut immediate = None;
	let mut label = None;
	
	// Determine whether the second argument is a register (source) or a value.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			// Second argument is a register (source)
			Rule::Register =>
				source = Some(register_index(argument.as_str())),

			// Second argument is a value (immediate)
			Rule::Number8 =>
				immediate = Some(read_value8(argument)),
			
			// Second argument is a label (immediate)
			Rule::Label8 => {
				immediate = Some(0);
				label = Some((argument, 2));
			}

			_ => unreachable!("{:?}", argument)
		}
	} else {
		return Err(
			std::io::Error::new(
				ErrorKind::NotFound,
				format!("Too few arguments to {}", instruction),
			)
		);
	}
	
	// Determine whether the third argument is a register (source/target) or a
	// value.
	if immediate.is_none() {
		if let Some(argument) = arguments.next() {
			match argument.as_rule() {
				// Third argument is a register (source/target)
				Rule::Register => {
					let register = Some(register_index(argument.as_str()));
					if source.is_none() {
						source = register
					} else {
						target = register
					}
				},

				// Third argument is a value (immediate)
				Rule::Number8 =>
					immediate = Some(read_value8(argument)),

				// Second argument is a label (immediate)
				Rule::Label8 => {
					immediate = Some(0);
					label = Some((argument, 2));
				}

				_ => unreachable!("{:?}", argument)
			}
		}
	}
	
	// If there is a fourth argument, it has to be the immediate.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			// Immediate is a value.
			Rule::Number8 =>
				immediate = Some(read_value8(argument)),
				
			// Immediate is a label.
			Rule::Label8 => {
				immediate = Some(0);
				label = Some((argument, 2));
			}
			
			_ => unreachable!()
		}
	}
	
	// To avoid pointless instructions, `mul` immediate defaults to `1` instead
	// of `0`, and `and` immediate defaults to `$FF` (mask out nothing).
	// Note: In case of an immediate label, the default won't apply anyway.
	let default = match op {
		Mul => 1,
		And => 0xFF,
		_ => 0,
	};

	// Assign default values to arguments.
	// If source is not given, the destination register is assumed source.
	let source = source.unwrap_or(register);
	let target = target.unwrap_or(0);
	let immediate = immediate.unwrap_or(default);

	Ok(
		(
			vec![
				operation << 4 | register,
				source << 4 | target,
				immediate
			],
			label,
		)
	)
}

/// `Register ~ ("," ~ Register){1, 2} ~ ("," ~ Number5)?`
fn rs(instruction: Pair<Rule>) -> LabelResult {
	let mut arguments = instruction.clone().into_inner();
	
	// Determine the operation kind code based on the instruction.
	let kind = match instruction.as_rule() {
		Rule::ShiftLeft => 0b000,
		Rule::ShiftRight => 0b001,
		Rule::RotateLeft => 0b010,
		Rule::RotateRight => 0b011,
		Rule::ArithmeticShiftRight => 0b101,
		_ => unreachable!()
	};
	
	// Assemble destination register.
	let register = arguments.next().unwrap().as_str();
	let register = register_index(register);

	let operation = u8::from(Shift);
	let mut source = None;
	let mut target = None;
	let mut immediate = None;
	
	// Determine whether the second argument is a register (source) or a value.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			// Second argument is a register (source)
			Rule::Register =>
				source = Some(register_index(argument.as_str())),

			// Second argument is a value (immediate)
			Rule::Number5 =>
				immediate = Some(read_number5(argument)),

			_ => unreachable!("{:?}", argument)
		}
	} else {
		return Err(
			std::io::Error::new(
				ErrorKind::NotFound,
				format!("Too few arguments to {}", instruction),
			)
		);
	}
	
	// Determine whether the third argument is a register (source/target) or a
	// value.
	if immediate.is_none() {
		if let Some(argument) = arguments.next() {
			match argument.as_rule() {
				// Third argument is a register (source/target)
				Rule::Register => {
					let register = Some(register_index(argument.as_str()));
					if source.is_none() {
						source = register
					} else {
						target = register
					}
				},

				// Third argument is a value (immediate)
				Rule::Number5 =>
					immediate = Some(read_number5(argument)),

				_ => unreachable!()
			}
		}
	}
	
	// If there is a fourth argument, it has to be the immediate.
	if let Some(argument) = arguments.next() {
		immediate = Some(read_number5(argument));
	}
	
	// Assign default values to arguments.
	// If source is not given, the destination register is assumed source.
	let source = source.unwrap_or(register);
	let target = target.unwrap_or(0);
	let immediate = immediate.unwrap_or(0);

	// Assemble instruction.
	Ok(
		(
			vec![
				operation << 4 | register,
				source << 4 | target,
				kind << 5 | immediate,
			],
			None,
		)
	)
}

/// Register index [0, 15] based on name
fn register_index(register: &str) -> u8 {
	match register {
		"r0" => 0x0,
		"r1" => 0x1,
		"r2" => 0x2,
		"r3" => 0x3,
		"r4" => 0x4,
		"r5" => 0x5,
		"r6" => 0x6,
		"r7" => 0x7,
		"r8" => 0x8,
		"r9" => 0x9,
		"rA" => 0xA,
		"rB" => 0xB,
		"rC" => 0xC,
		"rD" => 0xD,
		"rE" => 0xE,
		"rF" => 0xF,
		_ => panic!("Unknown register: {}", register)
	}
}

fn read_number2(value: Pair<Rule>) -> u8 {
	match value.as_rule() {
		// $2
		Rule::Hexadecimal2 =>
			u8::from_str_radix(value.as_str(), 0x10).unwrap(),

		// %10
		Rule::Binary2 =>
			u8::from_str_radix(value.as_str(), 0b10).unwrap(),

		// 2
		Rule::Decimal2 =>
			value.as_str().parse::<u8>().unwrap(),

		_ => unreachable!()
	}
}

fn read_number5(number: Pair<Rule>) -> u8 {
	let number = number.into_inner().next().unwrap();
	match number.as_rule() {
		// $1A
		Rule::Hexadecimal5 =>
			u8::from_str_radix(number.as_str(), 0x10).unwrap(),

		// %10101
		Rule::Binary5 =>
			u8::from_str_radix(number.as_str(), 0b10).unwrap(),

		// 30
		Rule::Decimal5 =>
			number.as_str().parse::<u8>().unwrap(),

		_ => unreachable!("{:?}", number)
	}
}

/// Value, immediate (or label?)
fn read_value8(value: Pair<Rule>) -> u8 {
	match value.as_rule() {
		Rule::Number8 => read_number8(value),

		_ => unreachable!()
	}
}

/// Number, either `$hexadecimal`, `%binary`, or `decimal`.
fn read_number8(number: Pair<Rule>) -> u8 {
	let number = number.into_inner().next().unwrap();
	match number.as_rule() {
		// $F0
		Rule::Hexadecimal8 =>
			u8::from_str_radix(number.as_str(), 0x10).unwrap(),
		
		// %11010100
		Rule::Binary8 =>
			u8::from_str_radix(number.as_str(), 0b10).unwrap(),

		// %11010100
		Rule::Decimal8 =>
			number.as_str().parse::<u8>().unwrap(),

		_ => unreachable!()
	}
}

fn read_value16(value: Pair<Rule>) -> (u16, Option<Pair<Rule>>) {
	match value.as_rule() {
		Rule::Number16 => (read_number16(value), None),
		
		Rule::Label16 => (0, Some(value)),

		_ => unreachable!("{}", value)
	}
}

fn read_relative_value16(value: Pair<Rule>) -> (u16, Option<Pair<Rule>>) {
	match value.as_rule() {
		Rule::Number16 => (read_number16(value), None),
		
		Rule::Label | Rule::LocalLabel => (0, Some(value)),

		_ => unreachable!("{}", value)
	}
}

fn read_number16(number: Pair<Rule>) -> u16 {
	let number = number.into_inner().next().unwrap();

	match number.as_rule() {
		// $FC84
		Rule::Hexadecimal16 =>
			u16::from_str_radix(number.as_str(), 0x10).unwrap(),

		// %1101010011110000
		Rule::Binary16 =>
			u16::from_str_radix(number.as_str(), 0b10).unwrap(),

		// $FC84
		Rule::Decimal16 =>
			number.as_str().parse::<u16>().unwrap(),

		Rule::SignedDecimal16 =>
			number.as_str().parse::<i16>().unwrap() as u16,

		_ => unreachable!("{:?}", number.as_rule())
	}
}

fn read_signed_number10(number: Pair<Rule>) -> i16 {
	let negative = number.as_str().starts_with('-') as i16;
	
	let value = number.as_str().parse::<u16>().unwrap() as i16;
	
	value * (1 - negative) - value * negative
}
*/