mod shader;
mod stage;

use assembler::Assembler;
use compiler::Compiler;
use miniquad::{conf::Platform, *};
use virtual_machine::*;

use stage::Stage;

fn main() -> Result<(), std::io::Error> {
	let path = "examples/twister";

	let assembly = match Compiler::build(&path) {
		Ok(assembly) => assembly.join("\n"),
		Err(error) => {
			eprintln!("{}", error);
			return Err(error);
		}
	};

	std::fs::write("twister.kitty.asm", &assembly).unwrap();

	let assembly = std::fs::read_to_string("twister.kitty.asm").unwrap();

	let rom = match Assembler::assemble(&assembly) {
		Ok(rom) => rom,
		Err(error) => {
			panic!("{}", error);
		}
	};

	println!("{} bytes of ROM", rom.len());

	let virtual_machine = VirtualMachine::new(
		rom,
		|exit_code| std::process::exit(exit_code[1] as i32),
		false,
	);

	let platform = Platform::default();

	let config = conf::Conf {
		window_width: 1280,
		window_height: 720,
		high_dpi: true,
		platform,
		..Default::default()
	};

	miniquad::start(config, |context| {
		Box::new(Stage::new(context, virtual_machine))
	});

	Ok(())
}

fn _eprint_rom(rom: &[u8]) {
	for (index, byte) in rom.iter().enumerate() {
		eprint!("{:02X} ", byte);
		if index % 3 == 2 {
			eprintln!()
		}
	}
}
