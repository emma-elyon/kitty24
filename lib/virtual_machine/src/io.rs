//TODO: Figure out if this entire IO concept should be memory mapped as well.

use std::fs;

use crate::VirtualMachine;

pub const PORT:  usize = 0xF00000;
pub const ADDRESS: usize = 0xF00003;
pub const LENGTH:   usize = 0xF00006;
pub const STATUS:   usize = 0xF00009;

// --- Machine (editor only?) ---
pub const RUN: usize         = 0x000080; // O: Run ROM from named file/folder
pub const _LOAD: usize        = 0x000081; // O: Load ROM from named file/folder into 0x010000, and jump to 0x000000?

// --- File system (editor only?) ---
pub const OPEN: usize        = 0x000090; // O: Open named file or folder
pub const READ: usize        = 0x000091; // I: Read binary data from open file
pub const WRITE: usize       = 0x000092; // O: Write binary data to open file
pub const _APPEND: usize      = 0x000093; // O: Append binary data to open file
pub const _READ_PNG: usize    = 0x000094; // I: Read PNG as data from open file
pub const _WRITE_PNG: usize   = 0x000095; // I: Write data as PNG to open file
pub const _READ_PNG2: usize   = 0x000096; // I: Read 2-bit PNG as data from open file
pub const _WRITE_PNG2: usize  = 0x000097; // I: Write 2-bit data as PNG to open file
// pub const REMOVE: usize      = 0x000018;
pub const READ_META: usize = 0x000098;

pub const CHANGE_DIR: usize  = 0x0000A0; // O: Change to named directory in kitty24/*
pub const READ_DIR: usize    = 0x0000A1; // I: List directory contents in kitty24/*
pub const WRITE_DIR: usize    = 0x0000A2; // O: Make directory in kitty24/*
										  //

// --- Audio ---
pub const PCM: usize = 0x000040; // O: Fill PCM buffer
// pub const PCM_BUFFER: usize = 0x001201; // I: PCM buffer empty sample count; could be stat register for 0xFA004X

// --- Graphics ---


pub trait IO {
	fn write(&mut self, address: u32, length: u32) -> usize;
    fn change_dir(&mut self, address: u32, length: u32) -> usize;
    fn read_dir(&mut self, address: u32, length: u32) -> usize;
	fn write_dir(&mut self, address: u32, length: u32) -> usize;
    fn read_metadata(&mut self, address: u32, length: u32) -> usize;
}

// TODO: Honor self.current_directory in write_dir
impl<F> IO for VirtualMachine<F> where F: FnMut([u32; 16]) {
	fn change_dir(&mut self, address: u32, length: u32) -> usize {
		let mut path = String::new();
		for i in address..address + length {
			path += &self.ram[i].escape_ascii().to_string();
		}
		if length == 0 {
			self.current_directory = String::new();
		} else {
			self.current_directory = path + "/";
		}
		length as usize
	}

    fn read_dir(&mut self, address: u32, length: u32) -> usize {
		match fs::read_dir("kitty24/".to_owned() + &self.current_directory) {
			Ok(read_dir) => {
				let mut cycles = 0;
				let mut offset = 0;
				for entry in read_dir {
					if let Ok(entry) = entry {
						let file_name = entry.file_name();
						let file_name_bytes = file_name.to_str().unwrap().bytes();
						let file_name_length = file_name_bytes.len();
						for (i, byte) in file_name_bytes.enumerate() {
							let index = offset + i;
							if index >= length as usize {
								self.ram[STATUS as u32 + 0] = (length >> 16) as u8;
								self.ram[STATUS as u32 + 1] = (length >> 8) as u8;
								self.ram[STATUS as u32 + 2] = (length >> 0) as u8;
								return length as usize;
							}
							self.ram[address + index as u32] = byte;
							cycles += 1;
						}
						offset += file_name_length;
						eprintln!("READ DIR FILE \"{}\"", file_name.to_str().unwrap());
						self.ram[address + offset as u32] = b'\n';
						offset += 1;
						cycles += 1;
					} else {
						eprintln!("{}", entry.err().unwrap());
					}
				}
				self.ram[STATUS as u32 + 0] = (offset >> 16) as u8;
				self.ram[STATUS as u32 + 1] = (offset >> 8) as u8;
				self.ram[STATUS as u32 + 2] = (offset >> 0) as u8;
				eprintln!("IO BLOCKS FOR {} cycles", cycles);
				cycles
			},
			Err(error) => {
				eprintln!("{}", error);
				0
			},
		}
	}
	
	fn write_dir(&mut self, address: u32, length: u32) -> usize {
		let mut path = String::new();
		for i in address..address + length {
			path += &self.ram[i].escape_ascii().to_string();
		}
		let path = "kitty24/".to_owned() + &self.current_directory + &path;
		if let Ok(metadata) = fs::metadata(&path) {
			if metadata.is_dir() {
				self.ram[STATUS as u32 + 0] = 0;
				self.ram[STATUS as u32 + 1] = 0;
				self.ram[STATUS as u32 + 2] = 0;
			} else {
				self.ram[STATUS as u32 + 0] = 0;
				self.ram[STATUS as u32 + 1] = 0;
				self.ram[STATUS as u32 + 2] = 1;
			}
		} else {
			match fs::create_dir(&path) {
				Ok(_) => {
					self.ram[STATUS as u32 + 0] = 0;
					self.ram[STATUS as u32 + 1] = 0;
					self.ram[STATUS as u32 + 2] = 0;
				},
				Err(error) => {
					eprintln!("ERROR: {}", error);
					self.ram[STATUS as u32 + 0] = 0;
					self.ram[STATUS as u32 + 1] = 0;
					self.ram[STATUS as u32 + 2] = 1;
				}
			}
		}
		length as usize
	}
	
	// TODO: Inject metadata up to `length`.
	fn read_metadata(&mut self, address: u32, _length: u32) -> usize {
		if let Some(file_name) = &self.open_file_name {
			match fs::metadata(file_name) {
				Ok(metadata) => {
					self.ram[address] = if metadata.is_file() {
						eprintln!("META FILE: {}", file_name);
						b'F'
					} else if metadata.is_dir() {
						eprintln!("META FOLDER: {}", file_name);
						b'D'
					} else {
						eprintln!("META UNKNOWN: {}", file_name);
						b'?'
					};
					return 1;
				},
				Err(error) => eprintln!("ERROR: {}", error),
			}
		} else {
			eprintln!("NO OPEN FILES FOR META");
		}
		0
	}

    fn write(&mut self, address: u32, length: u32) -> usize {
		if let Some(file_name) = &self.open_file_name {
			let mut bytes = vec![];
			for i in address..address + length {
				bytes.push(self.ram[i]);
			}
			match fs::write(file_name, bytes.as_slice()) {
				Ok(()) => {},
				Err(error) => eprintln!("{}", error),
			}
			length as usize
		} else {
			0
		}
    }
}