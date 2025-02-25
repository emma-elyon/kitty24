mod shader;
mod stage;

use std::{borrow::Cow, env, fs::File, io::BufWriter};

use assembler::Assembler;
use compiler::Compiler;
use miniquad::{conf::Platform, *};
use png::{BitDepth, ColorType};
use virtual_machine::*;

use crate::stage::Stage;

fn main() -> Result<(), std::io::Error> {
    for argument in env::args() {
        if argument.starts_with("--4color=") {
            let path = argument["--4color=".len()..].to_string();
            return convert_to_4_color_png(&path);
        }
    }

    let path = env::args().nth(1).unwrap_or("kitty24/debug".to_string());

    let assembly = match Compiler::build(&path) {
        Ok(assembly) => assembly.join("\n"),
        Err(error) => {
            eprintln!("{}", error);
            return Err(error);
        }
    };

    std::fs::write("debug.kitty.asm", assembly).unwrap();

    let assembly = std::fs::read_to_string("debug.kitty.asm").unwrap();

    let rom = match Assembler::assemble(&assembly) {
        Ok(rom) => rom,
        Err(error) => {
            panic!("{}", error);
        }
    };

    let virtual_machine = VirtualMachine::new(
        rom,
        |exit_code| std::process::exit(exit_code[1] as i32),
        true,
    );

    let platform = Platform::default();
    // platform.swap_interval = Some(60); // Some(240);

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

fn _main() -> Result<(), std::io::Error> {
    // eprint_sin8_table();

    let path = env::args()
        .nth(1)
        .unwrap_or("boot.kitty.script".to_string());
    let source = std::fs::read_to_string(path).unwrap();

    let assembly = match Compiler::compile(&source) {
        Ok(assembly) => assembly.join("\n"),
        Err(error) => {
            eprintln!("{}", error);
            return Err(error);
        }
    };

    std::fs::write("boot.kitty.asm", assembly).unwrap();

    let assembly = std::fs::read_to_string("boot.kitty.asm").unwrap();

    let rom = match Assembler::assemble(&assembly) {
        Ok(rom) => rom,
        Err(error) => {
            panic!("{}", error);
        }
    };

    let virtual_machine = VirtualMachine::new(
        rom,
        |exit_code| std::process::exit(exit_code[1] as i32),
        true,
    );

    let platform = Platform::default();
    // platform.swap_interval = Some(60); // Some(240);

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

// TODO: External tool
// TODO: Build into the emulator
fn convert_to_4_color_png(path: &str) -> Result<(), std::io::Error> {
    let decoder = png::Decoder::new(File::open(path)?);
    let mut reader = decoder.read_info().unwrap();
    let mut buffer = vec![0; reader.output_buffer_size()];
    let mut output = vec![];

    let info = reader.next_frame(&mut buffer).unwrap();
    let (width, height) = (info.width, info.height);
    let line_size = info.line_size;
    if info.bit_depth == BitDepth::Eight && info.color_type == ColorType::Indexed {
        let bytes = &buffer[..info.buffer_size()];
        for line in bytes.chunks(line_size) {
            for chunk in line.chunks(4) {
                let mut value = 0;
                for (index, &byte) in chunk.iter().enumerate() {
                    if byte <= 0b11 {
                        value |= byte << (3 - index) * 2
                    } else {
                        eprintln!("{}: Only first 4 palette colors expected, gnoring", path);
                        return Ok(());
                    }
                }
                output.push(value);
            }
        }
    } else if info.bit_depth == BitDepth::Two && info.color_type == ColorType::Indexed {
        eprintln!("{}: 2 bit indexed PNG already, ignoring", path);
        return Ok(());
    } else {
        eprintln!("{}: 8 bit indexed PNG expected, ignoring", path);
        return Ok(());
    }

    let file = File::create(path)?;
    let ref mut buffered_writer = BufWriter::new(file);
    let mut encoder = png::Encoder::new(buffered_writer, width, height);
    encoder.set_color(ColorType::Indexed);
    encoder.set_depth(BitDepth::Two);
    let palette = Cow::from(vec![0, 255, 255, 255, 0, 255, 255, 255, 0, 255, 255, 255]);
    encoder.set_palette(palette);
    let mut writer = encoder.write_header().unwrap();
    writer.write_image_data(&output).unwrap();

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

fn _eprint_sin8_table() {
    for i in 0..256 {
        let sin = (i as f32 / 256.0 * std::f32::consts::TAU).sin();
        let sin8 = ((sin * 0.5 + 0.5) * 255.0).round() as u8;
        eprintln!("[SIN + {}] = {}", i, sin8)
    }
}
