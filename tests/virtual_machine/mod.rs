use std::rc::Rc;

use assembler::Assembler;
use virtual_machine::*;

mod instructions;
mod interrupts;
mod labels;
mod optional_arguments;
mod signed;

const PROLOGUE: &str = r"
let r1, $1
let r2, $2
let r3, $3
let r4, $4
let r5, $5
let r6, $6
let r7, $7
let r8, $8
let r9, $9
let rA, $A
let rB, $B
let rC, $C
let rD, $D
";
#[allow(dead_code)] // TODO: Figure out why this counts as dead code.
pub const PROLOGUE_BYTE_COUNT: usize = 39;

const EPILOGUE: &str = r"
let rD, $FFFF
shl rD, 8
or  rF, rD, $FF
";

pub fn assert_exit_code(source: &str, exit_code: i32) -> Result<(), String> {
	let source = [PROLOGUE, source, EPILOGUE].join("\n");
	let rom = Assembler::assemble(&source).map_err(|_| "Parse error")?;
	let mut result = Rc::new(0);
	let mut virtual_machine = VirtualMachine::new(
		rom,
		|exit_code| *Rc::get_mut(&mut result).unwrap() = exit_code[1],
		false,
	);
	let mut display = vec![0; DISPLAY_BUFFER_SIZE];
	for _ in 0..60 {
		virtual_machine.run(&mut display, None);
	}
	assert_eq!((*result << 8) as i32 >> 8, exit_code);
	Ok(())
}

#[allow(dead_code)] // TODO: Figure out why this counts as dead code.
pub fn assert_parse_errors(source: &str) -> Result<(), String> {
	let source = [PROLOGUE, source, EPILOGUE].join("\n");
	let rom = Assembler::assemble(&source);
	match rom {
		Err(_) => Ok(()),
		Ok(_) => Err("Expected error".to_string()),
	}
}

#[should_panic]
pub fn _assert_runtime_errors(source: &str) -> Result<(), String> {
	let source = [PROLOGUE, source, EPILOGUE].join("\n");
	let rom = Assembler::assemble(&source).map_err(|_| "Parse error")?;
	let mut display = vec![0; DISPLAY_BUFFER_SIZE];
	VirtualMachine::new(rom, |_| {}, false).run(&mut display, None);
	Err("Expected panic".to_string())
}
