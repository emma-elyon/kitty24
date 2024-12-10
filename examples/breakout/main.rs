mod shader;
mod stage;

use assembler::Assembler;
use compiler::Compiler;
use miniquad::{*, conf::Platform};
use virtual_machine::*;

use stage::Stage;

fn main() -> Result<(), std::io::Error> {
    let source = std::fs::read_to_string("examples/breakout.kitty.script").unwrap();
    
    let assembly = match Compiler::compile(&source) {
        Ok(assembly) => assembly.join("\n"),
        Err(error) => panic!("{}", error)
	};
	
	// std::fs::write("breakout.kitty.asm", &assembly).unwrap();
	
	// let assembly = std::fs::read_to_string("breakout.kitty.asm").unwrap();
	
	let rom = match Assembler::assemble(&assembly) {
		Ok(rom) => rom,
		Err(error) => {
			panic!("{}", error);
		},
	};

	let virtual_machine = VirtualMachine::new(rom, |exit_code| {
		std::process::exit(exit_code[1] as i32)
	}, false);

	let platform = Platform::default();
	
	let config = conf::Conf {
		window_width: 1280,
		window_height: 720,
		high_dpi: true,
		platform,
		..Default::default()
	};
	
	miniquad::start(
		config,
		|context| Box::new(Stage::new(context, virtual_machine))
	);
	
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
