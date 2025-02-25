use std::collections::VecDeque;

// The Audio Processing Unit is responsible for audio timing.
#[derive(Default)]
pub struct Apu {
	// pub frame: usize,
	// pub phase: f32,
	pub buffer: VecDeque<f32>,
	pub square: Square,
	pub triangle: Triangle,
	pub pcm: Pcm,
	// pub volume: f32,
	// pub duty: f32,
}

#[derive(Default)]
pub struct Square {
	pub phase: f32,
	pub volume: f32,
}

#[derive(Default)]
pub struct Triangle {
	pub phase: f32,
	pub volume: f32,
}

#[derive(Default)]
pub struct Pcm {
	pub buffer: VecDeque<u8>,
}
