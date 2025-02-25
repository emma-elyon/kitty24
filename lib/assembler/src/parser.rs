use pest::{
	iterators::{Pair, Pairs},
	Parser,
};
use std::{io::ErrorKind, num::ParseIntError};

// extern crate virtual_machine;

use crate::ast::*;

const DEFAULT_BYTE_COUNT: usize = 3;

#[derive(Parser)]
#[grammar = "kitty-asm.pest"]
pub struct KittyAsmParser;

/// Parse AST from parser output.
fn parse_program(program: Pairs<Rule>) -> Result<Program, std::io::Error> {
	let mut statements = Vec::new();

	for statement in program {
		statements.push(parse_statement(statement)?);
	}

	Ok(Program { statements })
}

/// Parse a single statement, either an instruction or a label definition.
fn parse_statement(statement: Pair<Rule>) -> Result<Statement, std::io::Error> {
	match statement.as_rule() {
		// let r, 42
		Rule::Instruction => Ok(Statement::Instruction(parse_instruction(statement)?)),

		// label:
		Rule::LabelDefinition => Ok(Statement::Label(parse_label(statement))),

		Rule::EOI => Ok(Statement::EndOfInput),

		_ => unreachable!("{:?}", statement),
	}
}

/// Parse as either an I-, IF-, M-, R-, or RS-instruction.
fn parse_instruction(instruction: Pair<Rule>) -> Result<Instruction, std::io::Error> {
	let instruction = instruction.into_inner().next().unwrap();
	match instruction.as_rule() {
		Rule::Or => Ok(Instruction::Or(r(instruction, 0)?)),
		Rule::Nor => Ok(Instruction::Nor(r(instruction, 0)?)),
		Rule::And =>
		// Default was 0x0000FF, is now 0; virtual machine only ignores 0.
		{
			Ok(Instruction::And(r(instruction, 0)?))
		}
		Rule::Xor => Ok(Instruction::Xor(r(instruction, 0)?)),
		Rule::Add => Ok(Instruction::Add(r(instruction, 0)?)),
		Rule::Sub => Ok(Instruction::Sub(r(instruction, 0)?)),
		Rule::Mul => Ok(Instruction::Mul(r(instruction, 1)?)),
		Rule::ShiftLeft => Ok(Instruction::ShiftLeft(rs(instruction)?)),
		Rule::ShiftRight => Ok(Instruction::ShiftRight(rs(instruction)?)),
		Rule::RotateLeft => Ok(Instruction::RotateLeft(rs(instruction)?)),
		Rule::RotateRight => Ok(Instruction::RotateRight(rs(instruction)?)),
		Rule::ArithmeticShiftRight => Ok(Instruction::ArithmeticShiftRight(rs(instruction)?)),
		Rule::Less => Ok(Instruction::Less(r(instruction, 0)?)),
		Rule::SignedLess => Ok(Instruction::SignedLess(r(instruction, 0)?)),
		Rule::If => Ok(Instruction::If(if_(instruction)?)),
		Rule::Let => Ok(Instruction::Let(i(instruction)?)),
		Rule::Load => Ok(Instruction::Load(m(instruction)?)),
		Rule::Store => Ok(Instruction::Store(m(instruction)?)),
		Rule::Pop => Ok(Instruction::Pop(m(instruction)?)),
		Rule::Push => Ok(Instruction::Push(m(instruction)?)),
		Rule::Data => Ok(Instruction::Data(data(instruction)?)),
		_ => unreachable!("{:?}", instruction),
	}
}

/// Parse global or local label. Local label names are stored as-is in the AST.
fn parse_label(label: Pair<Rule>) -> Label {
	let pair = label.into_inner().next().unwrap();
	match pair.as_rule() {
		Rule::Label => Label::Global(pair.as_str().to_string()),
		Rule::LocalLabel => Label::Local(pair.as_str().to_string()),
		_ => unreachable!(),
	}
}

/// Parse I-instruction, 16-bit immediate (`let r1, 23456`).
///
/// `Register ~ "," ~ Value16`
fn i(instruction: Pair<Rule>) -> Result<I, std::io::Error> {
	let mut arguments = instruction.clone().into_inner();

	let destination: Register = arguments.next().unwrap().try_into()?;
	let immediate: IImmediate = arguments.next().unwrap().try_into()?;

	Ok(I {
		destination,
		immediate,
	})
}

/// Parse IF-instruction, 16-bit immediate branch on non-zero (`if r1, label`).
///
/// `Register ~ "," ~ RelativeValue16`
fn if_(instruction: Pair<Rule>) -> Result<IF, std::io::Error> {
	let mut arguments = instruction.clone().into_inner();

	let argument = arguments.next().unwrap();
	match argument.as_rule() {
		Rule::Register => Ok(IF {
			destination: argument.try_into()?,
			immediate: arguments.next().unwrap().try_into()?,
		}),
		_ => Ok(IF {
			destination: Register::R0,
			immediate: argument.try_into()?,
		}),
	}
}

/// Parse M-instruction, memory access (`ld r1, r4, 15, 2`)
///
/// Register ~ ("," ~ Register)? ~ (("," ~ SignedNumber10) ~ ("," ~ Number2)?)?
fn m(instruction: Pair<Rule>) -> Result<M, std::io::Error> {
	let mut arguments = instruction.clone().into_inner();

	// The first argument is always the destination register.
	let destination: Register = arguments.next().unwrap().try_into()?;

	let mut source: Option<Register> = None;
	let mut immediate: Option<u16> = None;
	let mut byte_count: Option<u8> = None;

	// Parse the second argument, if any.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			Rule::Register => source = Some(argument.try_into()?),

			Rule::SignedDecimal10 => immediate = Some(parse_10(argument)?),

			_ => unreachable!("{}", argument),
		}
	} else {
		// No second argument, we're running with implicit `ld r1, r1, 0, 3`
		source = Some(destination.clone());
		immediate = Some(0);
		byte_count = Some(DEFAULT_BYTE_COUNT as u8);
	}

	// If the second argument was an immediate, the third argument has to be the
	// byte count, or left out.
	if immediate.is_some() && byte_count.is_none() {
		byte_count = if let Some(byte_count) = arguments.next() {
			Some(parse_2(byte_count)?)
		} else {
			Some(0)
		}
	} else if let Some(argument) = arguments.next() {
		// If the second argument was the source register, the third argument
		// has to be the immediate, or left out.
		immediate = Some(parse_10(argument)?);
	} else {
		// In case the immediate is left out, use implicit `ld r1, r2, 0, 3`
		immediate = Some(0);
		byte_count = Some(DEFAULT_BYTE_COUNT as u8);
	}

	// At this point we're guaranteed to have values for source and immediate.
	let source = source.unwrap_or(destination.clone());
	let immediate = immediate.unwrap_or(0);

	// If there is a fourth argument, it has to be the byte count.
	let byte_count = if let Some(argument) = arguments.next() {
		parse_2(argument)?
	} else {
		byte_count.unwrap_or(DEFAULT_BYTE_COUNT as u8)
	};

	Ok(M {
		destination,
		source,
		immediate,
		byte_count,
	})
}

/// Parse R-instruction, register-register (`add r1, r4, r9, 2`)
///
/// `Register ~ ("," ~ Register){0, 1} ~ ("," ~ Value8)?`
fn r(instruction: Pair<Rule>, default: u8) -> Result<R, std::io::Error> {
	let mut arguments = instruction.clone().into_inner();

	let destination: Register = arguments.next().unwrap().try_into()?;

	let mut source = None;
	let mut target = None;
	let mut immediate = None;

	// Parse the second argument, if any.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			Rule::Register => source = Some(argument.try_into()?),

			Rule::Number8 | Rule::Label8 => immediate = Some(argument.try_into()?),

			_ => unreachable!(),
		}
	} else {
		return Err(std::io::Error::new(
			ErrorKind::InvalidInput,
			format!("Too few arguments to {}", instruction),
		));
	}

	// Parse the third argument, if any.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			Rule::Register => target = Some(argument.try_into()?),

			Rule::Number8 | Rule::Label8 => immediate = Some(argument.try_into()?),

			_ => unreachable!(),
		}
	}

	// Parse the fourth argument, if any. Guaranteed immediate.
	if let Some(argument) = arguments.next() {
		immediate = Some(argument.try_into()?);
	}

	// Assign default values to any missing arguments.
	let source = source.unwrap_or(destination.clone());
	let target = target.unwrap_or(Register::R0);
	let immediate = immediate.unwrap_or(RImmediate::Constant(default));

	Ok(R {
		destination,
		source,
		target,
		immediate,
	})
}

/// Parse RS-instruction, register-register shift (`shl r1, r1, r0, 8`)
fn rs(instruction: Pair<Rule>) -> Result<RS, std::io::Error> {
	let mut arguments = instruction.clone().into_inner();

	let destination: Register = arguments.next().unwrap().try_into()?;

	let mut source = None;
	let mut target = None;
	let mut immediate = None;

	// Parse the second argument, if any.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			Rule::Register => source = Some(argument.try_into()?),

			Rule::Number5 => immediate = Some(parse_5(argument)?),

			_ => unreachable!(),
		}
	} else {
		return Err(std::io::Error::new(
			ErrorKind::InvalidInput,
			format!("Too few arguments to {}", instruction),
		));
	}

	// Parse the third argument, if any.
	if let Some(argument) = arguments.next() {
		match argument.as_rule() {
			Rule::Register => target = Some(argument.try_into()?),

			Rule::Number5 => immediate = Some(parse_5(argument)?),

			_ => unreachable!(),
		}
	}

	// Parse the fourth argument, if any. Guaranteed immediate.
	if let Some(argument) = arguments.next() {
		immediate = Some(parse_5(argument)?);
	}

	// Assign default values to any missing arguments.
	let source = source.unwrap_or(destination.clone());
	let target = target.unwrap_or(Register::R0);
	let immediate = immediate.unwrap_or(0);

	Ok(RS {
		destination,
		source,
		target,
		immediate,
	})
}

fn data(instruction: Pair<Rule>) -> Result<Vec<u8>, std::io::Error> {
	let mut arguments = instruction.into_inner();
	let mut bytes = Vec::new();
	while let Some(byte) = arguments.next() {
		bytes.push(u8::from_str_radix(byte.as_str(), 0x10).map_err(parse_error)?);
	}
	Ok(bytes)
}

fn parse_16(number: Pair<Rule>) -> Result<u16, std::io::Error> {
	let number = number.into_inner().next().unwrap();
	match number.as_rule() {
		Rule::Hexadecimal16 => u16::from_str_radix(number.as_str(), 0x10).map_err(parse_error),

		Rule::Binary16 => u16::from_str_radix(number.as_str(), 0b10).map_err(parse_error),

		Rule::Decimal16 => number.as_str().parse::<u16>().map_err(parse_error),

		Rule::SignedDecimal16 => number
			.as_str()
			.parse::<i16>()
			.map(|number| number as u16)
			.map_err(parse_error),

		_ => unreachable!(),
	}
}

fn parse_u16(number: Pair<Rule>) -> Result<u16, std::io::Error> {
	let number = number.into_inner().next().unwrap();
	match number.as_rule() {
		Rule::Hexadecimal16 => u16::from_str_radix(number.as_str(), 0x10).map_err(parse_error),

		Rule::Binary16 => u16::from_str_radix(number.as_str(), 0b10).map_err(parse_error),

		Rule::Decimal16 => number.as_str().parse::<u16>().map_err(parse_error),

		_ => unreachable!(),
	}
}

fn parse_10(number: Pair<Rule>) -> Result<u16, std::io::Error> {
	match number.as_rule() {
		Rule::Hexadecimal10 => u16::from_str_radix(number.as_str(), 0x10).map_err(parse_error),

		Rule::Binary10 => u16::from_str_radix(number.as_str(), 0b10).map_err(parse_error),

		Rule::SignedDecimal10 => number
			.as_str()
			.parse::<i16>()
			.map(|number| number as u16)
			.map_err(parse_error),

		_ => unreachable!("{:?}", number),
	}
}

/// 8-bit number, either `$hexadecimal`, `$binary`, or `decimal`.
fn parse_8(number: Pair<Rule>) -> Result<u8, std::io::Error> {
	let number = number.into_inner().next().unwrap();
	match number.as_rule() {
		Rule::Hexadecimal8 => u8::from_str_radix(number.as_str(), 0x10).map_err(parse_error),

		Rule::Binary8 => u8::from_str_radix(number.as_str(), 0b10).map_err(parse_error),

		Rule::Decimal8 => number.as_str().parse::<u8>().map_err(parse_error),

		_ => unreachable!(),
	}
}

/// 5-bit number, either `$hexadecimal`, `$binary`, or `decimal`.
fn parse_5(number: Pair<Rule>) -> Result<u8, std::io::Error> {
	let pair = number.into_inner().next().unwrap();
	match pair.as_rule() {
		Rule::Hexadecimal5 => u8::from_str_radix(pair.as_str(), 0x10).map_err(parse_error),

		Rule::Binary5 => u8::from_str_radix(pair.as_str(), 0b10).map_err(parse_error),

		Rule::Decimal5 => pair.as_str().parse::<u8>().map_err(parse_error),

		_ => unreachable!("{:?}", pair),
	}
}

/// 2-bit number, either `$hexadecimal`, `$binary`, or `decimal`.
fn parse_2(number: Pair<Rule>) -> Result<u8, std::io::Error> {
	let pair = number.into_inner().next().unwrap();
	match pair.as_rule() {
		Rule::Hexadecimal2 => u8::from_str_radix(pair.as_str(), 0x10).map_err(parse_error),

		Rule::Binary2 => u8::from_str_radix(pair.as_str(), 0b10).map_err(parse_error),

		Rule::Decimal2 => pair.as_str().parse::<u8>().map_err(parse_error),

		_ => unreachable!(),
	}
}

/// Transform [ParseIntError] into [std::io::Error]
fn parse_error(error: ParseIntError) -> std::io::Error {
	std::io::Error::new(ErrorKind::InvalidInput, error)
}

fn parse_i_number(value: Pair<Rule>) -> Result<IImmediate, std::io::Error> {
	Ok(IImmediate::Constant(parse_u16(value)?))
}

fn parse_i_label(value: Pair<Rule>) -> Result<IImmediate, std::io::Error> {
	let mut arguments = value.into_inner();
	let label = arguments.next().unwrap();
	let string = label.as_str().to_string();
	let bytes = arguments.next().unwrap();
	let (byte_index, length) = match bytes.as_rule() {
		Rule::ByteIndex => {
			let index = parse_byte_index(bytes)?;
			(index, index)
		}
		Rule::ByteRange => parse_byte_range(bytes)?,
		_ => unreachable!(),
	};
	match label.as_rule() {
		Rule::Label => Ok(IImmediate::Label {
			label: Label::Global(string),
			byte_index,
			length,
		}),

		Rule::LocalLabel => Ok(IImmediate::Label {
			label: Label::Local(string),
			byte_index,
			length,
		}),

		_ => unreachable!(),
	}
}

fn parse_if_number(value: Pair<Rule>) -> Result<IFImmediate, std::io::Error> {
	Ok(IFImmediate::Constant(parse_16(value)?))
}

fn parse_if_label(value: Pair<Rule>) -> IFImmediate {
	IFImmediate::Label(Label::Global(value.as_str().to_string()))
}

fn parse_if_local_label(value: Pair<Rule>) -> IFImmediate {
	IFImmediate::Label(Label::Local(value.as_str().to_string()))
}

fn parse_r_number(value: Pair<Rule>) -> Result<RImmediate, std::io::Error> {
	Ok(RImmediate::Constant(parse_8(value)?))
}

fn parse_r_label(value: Pair<Rule>) -> Result<RImmediate, std::io::Error> {
	let mut arguments = value.into_inner();
	let label = arguments.next().unwrap();
	let string = label.as_str().to_string();
	let byte_index = parse_byte_index(arguments.next().unwrap())?;
	match label.as_rule() {
		Rule::Label => Ok(RImmediate::Label {
			label: Label::Global(string),
			byte_index,
		}),

		Rule::LocalLabel => Ok(RImmediate::Label {
			label: Label::Local(string),
			byte_index,
		}),

		_ => unreachable!(),
	}
}

fn parse_byte_index(value: Pair<Rule>) -> Result<u8, std::io::Error> {
	value
		.as_str()
		.parse::<u8>()
		.map_err(|error| std::io::Error::new(ErrorKind::InvalidInput, error))
}

fn parse_byte_range(value: Pair<Rule>) -> Result<(u8, u8), std::io::Error> {
	let mut byte_range = value.into_inner();
	let byte_index = parse_byte_index(byte_range.next().unwrap())?;
	let to = parse_byte_index(byte_range.next().unwrap())?;
	let length = to - byte_index + 1;
	Ok((byte_index, length))
}

impl TryFrom<&str> for Program {
	type Error = std::io::Error;

	fn try_from(value: &str) -> Result<Self, Self::Error> {
		match KittyAsmParser::parse(Rule::Program, value) {
			Ok(program) => parse_program(program),
			Err(error) => Err(std::io::Error::new(ErrorKind::InvalidInput, error)),
		}
	}
}

impl TryFrom<Pair<'_, Rule>> for Register {
	type Error = std::io::Error;

	fn try_from(value: Pair<Rule>) -> Result<Self, Self::Error> {
		let register = match value.as_str().to_lowercase().as_str() {
			"r0" => Register::R0,
			"r1" => Register::R1,
			"r2" => Register::R2,
			"r3" => Register::R3,
			"r4" => Register::R4,
			"r5" => Register::R5,
			"r6" => Register::R6,
			"r7" => Register::R7,
			"r8" => Register::R8,
			"r9" => Register::R9,
			"ra" => Register::RA,
			"rb" => Register::RB,
			"rc" => Register::RC,
			"rd" => Register::RD,
			"re" => Register::RE,
			"rf" => Register::RF,
			_ => {
				return Err(std::io::Error::new(
					ErrorKind::InvalidInput,
					format!("Not a register: {}", value),
				))
			}
		};
		Ok(register)
	}
}

impl TryFrom<Pair<'_, Rule>> for IImmediate {
	type Error = std::io::Error;

	fn try_from(value: Pair<Rule>) -> Result<Self, Self::Error> {
		match value.as_rule() {
			Rule::Unsigned16 => parse_i_number(value),
			Rule::Label16 => parse_i_label(value),
			_ => unreachable!(),
		}
	}
}

impl TryFrom<Pair<'_, Rule>> for IFImmediate {
	type Error = std::io::Error;

	fn try_from(value: Pair<Rule>) -> Result<Self, Self::Error> {
		match value.as_rule() {
			Rule::Number16 => parse_if_number(value),
			Rule::Label => Ok(parse_if_label(value)),
			Rule::LocalLabel => Ok(parse_if_local_label(value)),
			_ => unreachable!(),
		}
	}
}

impl TryFrom<Pair<'_, Rule>> for RImmediate {
	type Error = std::io::Error;

	fn try_from(value: Pair<Rule>) -> Result<Self, Self::Error> {
		match value.as_rule() {
			Rule::Number8 => parse_r_number(value),
			Rule::Label8 => parse_r_label(value),
			_ => unreachable!(),
		}
	}
}
