use std::rc::Rc;

use assembler::Assembler;
use compiler::Compiler;
use virtual_machine::{VirtualMachine, DISPLAY_BUFFER_SIZE};

// mod constants;
// mod literals;
// mod parameters;
// mod script;
// mod types;
// mod variables;
mod core;

fn assert_exit_codes(source: &str, exit_codes: &[u32]) {
	let assembly = Compiler::compile(source).unwrap().join("\n");

	// eprintln!("{}", assembly);

	let rom = Assembler::assemble(&assembly).unwrap();

	let mut result = Rc::new(vec![0; exit_codes.len()]);
	let mut virtual_machine = VirtualMachine::new(
		rom,
		|exit_code| {
			let results = Rc::get_mut(&mut result).unwrap();
			for i in 0..results.len() {
				results[i] = exit_code[i + 1];
			}
		},
		false,
	);

	let mut display = vec![0; DISPLAY_BUFFER_SIZE];
	for _ in 0..60 {
		virtual_machine.run(&mut display, None);
	}

	assert_eq!(*result, exit_codes);
}

#[test]
fn add_2_and_2() {
	assert_eq!(4, 2 + 2)
}
