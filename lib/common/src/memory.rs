// Size
pub const SIZE: usize = usize::pow(2, BITS as u32);
pub const MASK: usize = SIZE - 1;

// Map
pub const AUDIO: usize = 0xFA0000;
pub const AUDIO0_VOLUME: usize = 0xFA0000;
pub const AUDIO0_DUTY: usize = 0xFA0001;
pub const AUDIO0_PITCH: usize = 0xFA0002;
pub const AUDIO1_VOLUME: usize = 0xFA0010;
pub const AUDIO1_DUTY: usize = 0xFA0011;
pub const AUDIO1_PITCH: usize = 0xFA0012;
pub const AUDIO2_VOLUME: usize = 0xFA0020;
pub const AUDIO2_DUTY: usize = 0xFA0021;
pub const AUDIO2_PITCH: usize = 0xFA0022;
pub const AUDIO3_VOLUME: usize = 0xFA0030;
pub const AUDIO3_DUTY: usize = 0xFA0031;
pub const AUDIO3_PITCH: usize = 0xFA0032;
pub const PCM_VOLUME: usize = 0xFA0040;
pub const PCM_DUTY: usize = 0xFA0041;
pub const PCM_FREQ: usize = 0xFA0042;
pub const PCM_ENABLE: usize = 0xFA0044;
pub const FRAMEBUFFER: usize = 0xFB0000; // Actually currently wrong 0xFF0000
pub const RESOLUTION: usize = 0xFBE100;
pub const PALETTE: usize = 0xFBFD20;
pub const SYSTEM_PALETTE: usize = 0xFBFFF0;
pub const FONT: usize = 0xFC0000;
pub const BLOCK_TRANSFER: usize = 0xFC1200;
pub const BLOCK_SRC_MOD: usize = 0xFC1200;
pub const BLOCK_SRC_WIDTH: usize = 0xFC1202; // flip_x
pub const BLOCK_SRC_HEIGHT: usize = 0xFC1204; // flip_y
pub const BLOCK_SRC_ADDRESS: usize = 0xFC1206;
// pub const COPY_MASK:        usize = 0xFC1209;
pub const BLOCK_DST_MOD: usize = 0xFC1210;
pub const BLOCK_DST_WIDTH: usize = 0xFC1212; // rot
pub const BLOCK_DST_HEIGHT: usize = 0xFC1214; // mask on
pub const BLOCK_DST_ADDRESS: usize = 0xFC1216; // Write triggers block transfer.
pub const BLIT_MODE: usize = 0xF90020;
pub const BLOCK_REMAP: usize = 0xF90200;
pub const STACK: usize = 0xFF0000;

const BITS: usize = 24;

/*
000000	007FFF	32,768 B	Standard Library
008000	00FFFF	32,768 B	Core ROM
010000	7FFFFF	8,323,072 B	ROM Bank
800000	EFFFFF	7,340,032 B	Work RAM
F00000	F7FFFF	524,288 B	IO
F80000	F9FFFF	131,072 B	Reserved
FA0000	FAFFFF	65,536 B	Audio
FB0000	FBE0FF	57,600 B	Framebuffer
FBE100	FBFD1F	7,200 B	Resolution attributes
FBFD20	FBFFEF	720 B	Custom palette
FBFFF0	FBFFFF	16 B	System palette index
FC0000	FC11FF	4,608 B	Standard font
FC1200	FC121F	32 B	Byte Block Transfer
FC1200	FCFFFF	60,928 B	Reserved
FD0000	FEFFFF	131,072 B	Reserved
FF0000	FFFFFF	65,536 B	Initial stack (64 KiB)
*/
