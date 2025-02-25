use std::{cmp::Reverse, collections::BinaryHeap};

const REGISTER_COUNT: usize = 16;
const REGISTER_EVENT_CAUSE: u8 = 0xE;
pub const REGISTER_PROGRAM_COUNTER: u8 = 0xF;
const REGISTER_MASK: usize = common::memory::MASK;
const EVENT_COUNT: usize = 256;

/// Responsible for accessing registers, and handling events.
pub struct Cpu {
	/// Each register is 24 bits, stored in a u32 that is masked on read.
	registers: [u32; REGISTER_COUNT],

	/// Whenever a prioritized interrupt happens, the current registers are
	/// pushed on the stack.
	contexts: [[u32; REGISTER_COUNT]; EVENT_COUNT],

	/// Pending event priority queue.
	event_queue: BinaryHeap<Reverse<u8>>,
}

impl Cpu {
	pub fn get(&self, register: u8) -> u32 {
		// TODO: Determine performance gain of `get_unchecked`.
		// TODO: Find a good name for the 0xFFFFFF constant.
		self.registers[register as usize] & REGISTER_MASK as u32
	}

	/// Store value in register.
	pub fn set(&mut self, register: u8, value: u32) {
		match register {
			0 => {}
			REGISTER_EVENT_CAUSE => self.cause_event(value),
			register => self.registers[register as usize] = value,
		}
	}

	/// Move to interrupt handler when an event cause/interrupt request happens.
	/// TODO: Doesn't have to be `pub` if the virtual machine uses `set()`.
	pub fn cause_event(&mut self, event_cause: u32) {
		let program_counter = self.registers[REGISTER_PROGRAM_COUNTER as usize];

		// Ignore if we're halted.
		if program_counter == REGISTER_MASK as u32 {
			return;
		}

		// TODO: Include arguments to the current event cause, maybe.
		let current_event_cause = self.registers[REGISTER_EVENT_CAUSE as usize] as u8;

		if event_cause == 0 {
			if let Some(Reverse(next_event_cause)) = self.event_queue.pop() {
				// If event cause is manually cleared, we can pull the highest priority
				// event from the queue and jump to it.
				// let event_cause =
				// ((self.event_arguments[next_event_cause as usize] as u32) << 8) |
				// next_event_cause as u32;
				// self.registers[REGISTER_EVENT_CAUSE as usize] = event_cause;
				// self.registers[REGISTER_PROGRAM_COUNTER as usize] = 0;
				self.registers = self.contexts[next_event_cause as usize].clone();
			} else {
				if current_event_cause > 0 {
					// There's no next event, so we can reset the registers.
					self.registers = self.contexts[event_cause as usize].clone();
				} else {
					// Undefined or no behaviour.
				}
			}
		} else {
			if current_event_cause > 0 && current_event_cause < event_cause as u8 {
				// Current event has higher priority, so queue the incoming
				// event, and store its arguments.
				self.event_queue.push(Reverse(event_cause as u8));
				// self.event_arguments[event_cause as u8 as usize] = (event_cause >> 8) as u16;
				self.contexts[event_cause as u8 as usize] = self.registers.clone();
				self.contexts[event_cause as u8 as usize][REGISTER_EVENT_CAUSE as usize] =
					event_cause;
				self.contexts[event_cause as u8 as usize][REGISTER_PROGRAM_COUNTER as usize] = 0;
			} else if current_event_cause > event_cause as u8 {
				// New event has higher priority, so queue the existing event,
				// and jump to the new one.
				self.event_queue.push(Reverse(current_event_cause));
				self.contexts[current_event_cause as usize] = self.registers.clone();
				self.registers[REGISTER_EVENT_CAUSE as usize] = event_cause;
				self.registers[REGISTER_PROGRAM_COUNTER as usize] = 0;
			} else if current_event_cause == 0 {
				// There's no current event, so we can jump to the new one.
				self.contexts[current_event_cause as usize] = self.registers.clone();
				self.registers[REGISTER_EVENT_CAUSE as usize] = event_cause;
				self.registers[REGISTER_PROGRAM_COUNTER as usize] = 0;
			} else {
				// Event cause == current event cause > 0, undefined or no
				// behaviour; currently no behaviour.
			}
		}
	}
}

impl Default for Cpu {
	fn default() -> Self {
		Self {
			registers: [0; REGISTER_COUNT],
			contexts: [[0; REGISTER_COUNT]; EVENT_COUNT],
			event_queue: BinaryHeap::new(),
		}
	}
}
