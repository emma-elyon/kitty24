pub enum Event {
	None,
	Timer,
	Pcm(u16),
	HBlank,
	VBlank,
	KeyDown(u16),
	KeyUp(u16),
	Text(u8),
}

impl From<Event> for u32 {
	fn from(value: Event) -> Self {
		match value {
			Event::None => 0,
			Event::Timer => 1,
			Event::Pcm(length) => 2 | (length as u32) << 8,
			Event::HBlank => 3,
			Event::VBlank => 4,
			Event::KeyDown(key) => 5 | (key as u32) << 8,
			Event::KeyUp(key) => 6 | (key as u32) << 8,
			Event::Text(character) => 7 | (character as u32) << 8,
		}
	}
}
