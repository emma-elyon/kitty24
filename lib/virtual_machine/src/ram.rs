use std::ops::{Index, IndexMut};

use common::{memory::BLIT_MODE, *};

/// Responsible for accessing RAM.
pub struct Ram {
	/// All 16 MiB of RAM.
	memory: Vec<u8>,
}

impl Ram {
	/// Get a new RAM block with the given ROM loaded at the beginning.
	pub fn new(rom: Vec<u8>) -> Self {
		let mut memory = vec![0; memory::SIZE];
		memory[..rom.len()].clone_from_slice(&rom);

		// Set up initial palette remap table.
		// TODO: Figure out if this should be boot ROM or something.
		for i in 0..256 {
			memory[memory::BLOCK_REMAP + i] = i as u8;
		}
		Self { memory }
	}

	/// Perform a blocking block transfer of bytes, returning cycles spent.
	// TODO: Lots. Like squash/stretch, truncate/repeat, mirror, 0-mask
	pub fn block_transfer(&mut self) -> usize {
		let src_modulo = ((self.memory[memory::BLOCK_SRC_MOD + 0] as u32) << 8)
			| ((self.memory[memory::BLOCK_SRC_MOD + 1] as u32) << 0);
		let src_width = ((self.memory[memory::BLOCK_SRC_WIDTH + 0] as u32) << 8)
			| ((self.memory[memory::BLOCK_SRC_WIDTH + 1] as u32) << 0);
		let src_height = ((self.memory[memory::BLOCK_SRC_HEIGHT + 0] as u32) << 8)
			| ((self.memory[memory::BLOCK_SRC_HEIGHT + 1] as u32) << 0);
		let src_address = ((self.memory[memory::BLOCK_SRC_ADDRESS + 0] as u32) << 16)
			| ((self.memory[memory::BLOCK_SRC_ADDRESS + 1] as u32) << 8)
			| ((self.memory[memory::BLOCK_SRC_ADDRESS + 2] as u32) << 0);
		let dst_modulo = ((self.memory[memory::BLOCK_DST_MOD + 0] as u32) << 8)
			| ((self.memory[memory::BLOCK_DST_MOD + 1] as u32) << 0);
		let dst_width = ((self.memory[memory::BLOCK_DST_WIDTH + 0] as u32) << 8)
			| ((self.memory[memory::BLOCK_DST_WIDTH + 1] as u32) << 0);
		let dst_height = ((self.memory[memory::BLOCK_DST_HEIGHT + 0] as u32) << 8)
			| ((self.memory[memory::BLOCK_DST_HEIGHT + 1] as u32) << 0);
		let dst_address = ((self.memory[memory::BLOCK_DST_ADDRESS + 0] as u32) << 16)
			| ((self.memory[memory::BLOCK_DST_ADDRESS + 1] as u32) << 8)
			| ((self.memory[memory::BLOCK_DST_ADDRESS + 2] as u32) << 0);

		let cycles = (src_width.max(dst_width).max(1) * src_height.max(dst_height).max(1)) as usize;
		// NOTE: This used to be divided by three:
		// let cycles = cycles / 3 + cycles % 3;

		// eprintln!("BLOCK TRANSFER {}×{} ({} cycles)", src_width, src_height, cycles);

		let blit_mode = self[BLIT_MODE as u32];
		let blit_0 = blit_mode & 0b01 == 0b00;
		let blit_2 = blit_mode & 0b10 == 0b10;

		// TODO: `blit_no_0 | blit_2` ignore pixel value 0b00 up to four times per byte
		if src_modulo == 0 {
			// Linear source transfer.
			// TODO: Support bigger dsts than srcs
			for src_offset in 0..src_width * src_height {
				if dst_modulo == 0 {
					// Linear destination transfer.
					let dst_offset = src_offset * dst_width * dst_height / src_width / src_height;
					let pixel = self[src_address + src_offset];
					if blit_0 || blit_2 || pixel != 0 {
						if blit_2 {
							let byte = ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 0) & 0x03)]
								& 0x03) << 0) | ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 2) & 0x03)]
								& 0x03) << 2) | ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 4) & 0x03)]
								& 0x03) << 4) | ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 6) & 0x03)]
								& 0x03) << 6);
							self[dst_address + dst_offset] = byte
						} else {
							self[dst_address + dst_offset] =
								self[memory::BLOCK_REMAP as u32 + pixel as u32];
						}
					}
				} else {
					// Block destination transfer.
					let src_x = src_offset % src_width;
					let src_y = src_offset / src_width;
					let dst_offset = src_x * dst_width / src_width
						+ src_y * dst_height / src_height * dst_modulo;
					let pixel = self[src_address + src_offset];
					if blit_0 || blit_2 || pixel != 0 {
						if blit_2 {
							let byte = ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 0) & 0x03)]
								& 0x03) << 0) | ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 2) & 0x03)]
								& 0x03) << 2) | ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 4) & 0x03)]
								& 0x03) << 4) | ((self
								[memory::BLOCK_REMAP as u32 + ((pixel as u32 >> 6) & 0x03)]
								& 0x03) << 6);
							self[dst_address + dst_offset] = byte
						} else {
							self[dst_address + dst_offset] =
								self[memory::BLOCK_REMAP as u32 + pixel as u32];
						}
					}
				}
			}
		} else {
			// Block source transfer.
			let width = src_width.max(dst_width);
			let height = src_height.max(dst_height);
			let using_src_width = src_width >= dst_width;
			let using_src_height = src_height >= dst_height;
			for y in 0..height {
				for x in 0..width {
					if using_src_width {
						let dst_x = x * dst_width / src_width;
						if using_src_height {
							let dst_y = y * dst_height / src_height;
							let dst_offset = dst_x + dst_y * dst_modulo;
							let src_offset = x + y * src_modulo;
							let pixel = self[src_address + src_offset];
							if blit_0 || blit_2 || pixel > 0 {
								if blit_2 {
									let byte = ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 0) & 0x03)]
										& 0x03) << 0) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 2) & 0x03)]
										& 0x03) << 2) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 4) & 0x03)]
										& 0x03) << 4) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 6) & 0x03)]
										& 0x03) << 6);
									self[dst_address + dst_offset] = byte
								} else {
									self[dst_address + dst_offset] = pixel;
								}
							}
						} else {
							let src_y = y * src_height / dst_height;
							let src_offset = x + src_y * src_modulo;
							let dst_offset = dst_x + y * dst_modulo;
							let pixel = self[src_address + src_offset];
							if blit_0 || blit_2 || pixel > 0 {
								if blit_2 {
									let byte = ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 0) & 0x03)]
										& 0x03) << 0) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 2) & 0x03)]
										& 0x03) << 2) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 4) & 0x03)]
										& 0x03) << 4) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 6) & 0x03)]
										& 0x03) << 6);
									self[dst_address + dst_offset] = byte
								} else {
									self[dst_address + dst_offset] = pixel;
								}
							}
						}
					} else {
						let src_x = x * src_width / dst_width;
						if using_src_height {
							let dst_y = y * dst_height / src_height;
							let dst_offset = x + dst_y * dst_modulo;
							let src_offset = src_x + y * src_modulo;
							let pixel = self[src_address + src_offset];
							if blit_0 || blit_2 || pixel > 0 {
								self[dst_address + dst_offset] = pixel;
							}
						} else {
							let src_y = y * src_height / dst_height;
							let src_offset = src_x + src_y * src_modulo;
							let dst_offset = x + y * dst_modulo;
							let pixel = self[src_address + src_offset];
							if blit_0 || blit_2 || pixel > 0 {
								if blit_2 {
									let byte = ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 0) & 0x03)]
										& 0x03) << 0) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 2) & 0x03)]
										& 0x03) << 2) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 4) & 0x03)]
										& 0x03) << 4) | ((self[memory::BLOCK_REMAP as u32
										+ ((pixel as u32 >> 6) & 0x03)]
										& 0x03) << 6);
									self[dst_address + dst_offset] = byte
								} else {
									self[dst_address + dst_offset] = pixel;
								}
							}
						}
					}
				}
			}
		}

		cycles
	}
}

impl Index<u32> for Ram {
	type Output = u8;

	/// Load value from memory.
	fn index(&self, index: u32) -> &Self::Output {
		// TODO: Determine performance gain of `get_unchecked`.
		&self.memory[index as usize & memory::MASK]
	}
}

impl IndexMut<u32> for Ram {
	/// Get a mutable reference to a byte of memory.
	fn index_mut(&mut self, index: u32) -> &mut Self::Output {
		&mut self.memory[index as usize & memory::MASK]
	}
}

// TODO: Look into Range access.
