use std::{
	collections::HashMap,
	fs::{self, read_dir, File},
	io::ErrorKind,
	path::Path,
};

extern crate pest;
#[macro_use]
extern crate pest_derive;

mod ast;
mod parser;

use ast::*;
use png::{BitDepth, ColorType};

/// Compiler for kitty-script.
pub struct Compiler {
	/// Current offset into the stack, for registering memory locations of new
	/// variables.
	///
	/// Updated on every push and pop.
	stack_offset: i32,

	/// Map of identifiers to stack offsets, for referencing memory locations of
	/// existing variables.
	///
	/// Updated on variable declaration.
	variables: HashMap<String, i32>,

	/// Map of identifiers to labels, for referencing memory locations of
	/// existing global variables.
	global_variables: HashMap<String, String>,

	/// Map of identifiers to values, for inserting constant values into
	/// expressions.
	constants: HashMap<String, u32>,

	/// List of strings, for addressing string literals
	strings: Vec<String>,

	/// Running label count, for ensuring generated label uniqueness.
	label_count: usize,

	/// While loop label stack, for break and continue
	while_labels: Vec<(Option<String>, usize)>,

	/// Current namespace name.
	namespace: Option<String>,

	/// TODO: Document
	interrupts: Vec<u8>,
}

// TODO:
// * More comments (in rust and assembly)
// * Compound assignment (+=, &=, ^=, etc.) maybe
// * Indentation in generated assembly.
// * `goto` could unwind stack based on how many/which scopes it breaks? That
//   seems very hard to analyze, though
//
// DONE!
// * Emit the most naïve/safe `let`, `ifeq`, and maybe `ld`/`st` assembly
// * local labels
// * Consider a `Block` as a `Statement` (anonymous scopes)
// * Use rD for stack end pointer.
// * Use rC for disposable register (is this necessary?)
// * blocks with local variables
// * add `compile_block`, use in compile_conditional and compile_function.
// * don't let declarations include assignments in the AST
//   (split into declare and assign on parse)
// * a, b = b, a (swap)
// * struct Compiler (always passing stack_index and variables is silly~).
// * Use rB for stack base pointer.
impl Compiler {
	/// Compile folder of kitty-files into a single ROM.
	pub fn build(folder_path: &str) -> Result<Vec<String>, std::io::Error> {
		let paths = read_dir(folder_path)?; // TODO: Error handling omg.

		eprintln!("Building {}.kitty ...", folder_path);

		let mut include_sources = vec![];
		let mut include_resources = vec![];

		// TODO: Recurse, support subfolders.
		for path in paths {
			let path = path?.path();
			if path.is_dir() {
				for entry in path.read_dir().unwrap() {
					let path = entry.unwrap().path();
					eprintln!(
						"Found resource: {}",
						path.file_name().unwrap().to_str().unwrap()
					);
					include_resources.push(path);
				}
			} else {
				if path
					.file_name()
					.unwrap()
					.to_str()
					.unwrap()
					.ends_with(".kitty.script")
				{
					eprintln!(
						"Found source: {}",
						path.file_name().unwrap().to_str().unwrap()
					);
					include_sources.push(path);
				} else {
					eprintln!("Ignored {}", path.file_name().unwrap().to_str().unwrap());
				}
			}
		}

		let mut sources = vec![];
		let mut resources: Vec<String> = vec![];

		for path in include_sources {
			sources.push(fs::read_to_string(path)?);
		}

		for path in include_resources {
			let file_stem = path.file_stem().unwrap().to_str().unwrap();
			let file_stem = file_stem.replace(".kitty", "");
			resources.push(format!("/{}:", file_stem));
			if let Some(extension) = path.extension() {
				match extension.to_str().unwrap() {
					"png" => {
						resources.push(Compiler::compile_png(path)?.join("\n"));
					}
					extension => {
						eprintln!(
							"Including unknown file type \"{}\" as binary data",
							extension
						);
						resources.push(Compiler::compile_data(path)?.join("\n"));
					}
				}
			} else {
				eprintln!("Including unknown file \"{}\" as binary data", file_stem);
				resources.push(Compiler::compile_data(path)?.join("\n"));
			}
		}

		let constants = std::fs::read_to_string("lib/compiler/lib/const.kitty.script").unwrap();
		let core = std::fs::read_to_string("lib/compiler/lib/core.kitty.script").unwrap();
		let math = std::fs::read_to_string("lib/compiler/lib/math.kitty.script").unwrap();
		let trig = std::fs::read_to_string("lib/compiler/lib/trig.kitty.script").unwrap();
		let gfx = std::fs::read_to_string("lib/compiler/lib/gfx.kitty.script").unwrap();
		let mem = std::fs::read_to_string("lib/compiler/lib/mem.kitty.script").unwrap();
		let text = std::fs::read_to_string("lib/compiler/lib/text.kitty.script").unwrap();
		let io = std::fs::read_to_string("lib/compiler/lib/io.kitty.script").unwrap();
		let blit = std::fs::read_to_string("lib/compiler/lib/blit.kitty.script").unwrap();
		let libraries = core + &math + &trig + &gfx + &mem + &text + &io + &blit;
		let source = constants + &libraries + sources.join("\n").as_str();
		let program: Program = source.as_str().try_into()?;
		let mut compiler = Self::default();
		let mut compiled = compiler.compile_program(program)?;
		compiled.extend(resources);

		eprintln!("Built {}.kitty", folder_path);

		let terminess = "/terminess:\n".to_owned()
			+ &Compiler::compile_png("lib/compiler/lib/res/terminess.png")
				.unwrap()
				.join("\n");
		let terminess2 = "/terminess2:\n".to_owned()
			+ &Compiler::compile_png("lib/compiler/lib/res/terminess2.png")
				.unwrap()
				.join("\n");
		compiled.push(terminess);
		compiled.push(terminess2);

		Ok(compiled)
	}

	/// Compile kitty-script into unoptimized kitty-assembly.
	pub fn compile(source: &str) -> Result<Vec<String>, std::io::Error> {
		let constants = std::fs::read_to_string("lib/compiler/lib/const.kitty.script").unwrap();
		let core = std::fs::read_to_string("lib/compiler/lib/core.kitty.script").unwrap();
		let math = std::fs::read_to_string("lib/compiler/lib/math.kitty.script").unwrap();
		let trig = std::fs::read_to_string("lib/compiler/lib/trig.kitty.script").unwrap();
		let gfx = std::fs::read_to_string("lib/compiler/lib/gfx.kitty.script").unwrap();
		let mem = std::fs::read_to_string("lib/compiler/lib/mem.kitty.script").unwrap();
		let text = std::fs::read_to_string("lib/compiler/lib/text.kitty.script").unwrap();
		let io = std::fs::read_to_string("lib/compiler/lib/io.kitty.script").unwrap();
		let blit = std::fs::read_to_string("lib/compiler/lib/blit.kitty.script").unwrap();
		let libraries = core + &math + &trig + &gfx + &mem + &text + &io + &blit;
		let source = constants + &libraries + source;
		let program: Program = source.as_str().try_into()?;
		let mut compiler = Compiler::default();
		let mut compiled = compiler.compile_program(program)?;

		let terminess = "/terminess:\n".to_owned()
			+ &Compiler::compile_png("lib/compiler/lib/res/terminess.png")
				.unwrap()
				.join("\n");
		let terminess2 = "/terminess2:\n".to_owned()
			+ &Compiler::compile_png("lib/compiler/lib/res/terminess2.png")
				.unwrap()
				.join("\n");
		compiled.push(terminess);
		compiled.push(terminess2);

		Ok(compiled)
	}

	fn compile_png<P>(path: P) -> Result<Vec<String>, std::io::Error>
	where
		P: AsRef<Path>,
	{
		let decoder = png::Decoder::new(File::open(path)?);
		let mut reader = decoder.read_info().unwrap();
		let mut buffer = vec![0; reader.output_buffer_size()];
		let mut output = vec![];

		let info = reader.next_frame(&mut buffer).unwrap();
		let line_size = info.line_size;
		if info.bit_depth == BitDepth::Eight && info.color_type == ColorType::Indexed {
			let bytes = &buffer[..info.buffer_size()];

			output.push("data".to_string());
			for chunk in bytes.chunks(40) {
				let mut line = String::new();
				for byte in chunk {
					let data = format!("{:02X}", byte);
					line += &data;
				}
				output.push(line);
			}
		} else if info.bit_depth == BitDepth::Two && info.color_type == ColorType::Indexed {
			// eprintln!("Not yet implemented: 2 bit indexed PNG conversion to Kitty24 format");
			let bytes = &buffer[..info.buffer_size()];
			let mut lines = vec![];

			output.push("data".to_string());

			for chunk in bytes.chunks(line_size) {
				let mut line = vec![];
				for &byte in chunk {
					line.push((byte >> 6) & 0b11);
					line.push((byte >> 4) & 0b11);
					line.push((byte >> 2) & 0b11);
					line.push((byte >> 0) & 0b11);
				}
				lines.push(line);
			}

			let mut bytes = vec![];
			for y in 0..info.height as usize / 2 {
				for x in 0..info.width as usize / 2 {
					let line0 = &lines[y * 2 + 0];
					let line1 = &lines[y * 2 + 1];
					let byte = (line0[x * 2 + 0] << 6)
						| (line0[x * 2 + 1] << 4)
						| (line1[x * 2 + 0] << 2)
						| (line1[x * 2 + 1] << 0);
					bytes.push(byte);
				}
			}

			for chunk in bytes.chunks(40) {
				let mut line = String::new();
				for byte in chunk {
					let data = format!("{:02X}", byte);
					line += &data;
				}
				output.push(line);
			}
		} else {
			eprintln!("Only 8 bit indexed PNGs are supported");
		}

		Ok(output)
	}

	fn compile_data<P>(path: P) -> Result<Vec<String>, std::io::Error>
	where
		P: AsRef<Path>,
	{
		let mut output = vec![];
		output.push("data".to_string());
		for chunk in fs::read(path)?.chunks(40) {
			let mut line = String::new();
			for byte in chunk {
				let data = format!("{:02X}", byte);
				line += &data;
			}
			output.push(line);
		}
		// FIXME: Strings currently are null-terminated, so for safety reasons
		// we have to insert a null byte at the end of every data file :(
		output.push("00".to_string());
		Ok(output)
	}

	fn compile_program(&mut self, program: Program) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		// Set up stack on first run.
		assembly.extend([
			format!("; jump to event handler if not booting"),
			format!("if   rE, __interrupt"),
			// format!("if   rE, __interrupt"),
			format!(""),
			format!("; set up main return address"),
			format!("let  rA, $FFFF"),
			format!("shl  rA, 8"),
			format!("or   rA, $FF"),
			format!(""),
			// format!("; set up stack on first run"),
			// format!("let  rC, $FFFF"),
			// format!("shl  rC, 16"),
			// format!("or   rC, $FF"),
			// Note: no longer needed since stack starts from $000000 and grows
			// down (so functionally $FF0000 - $FFFFFF)
			// NOTE: Moved stack to top of heap, at $F80000
			format!("let  rC, $F800"),
			format!("shl  rC, 8"),
			format!("or   rC, $00"),
			format!(""),
			format!("; jump to main"),
			format!("let  rD, main[0:1]"),
			format!("shl  rD, 8"),
			format!("or   rF, rD, main[2]"),
			format!(""),
			format!("; delegate events"),
			format!("__interrupt:"),
			format!("let  rD, __handle_interrupt[0:1]"),
			format!("shl  rD, 8"),
			format!("or   rF, rD, __handle_interrupt[2]"),
		]);

		// Add constants, resolving their expressions or returning an error.
		for Constant { name, expression } in program.constants {
			let value = self.resolve_constant(expression)?;
			self.constants.insert(name, value);
		}

		// Add global declarations so they can be accessed in namespaces.
		for declaration in program.declarations {
			assembly.extend(self.compile_global_declaration(declaration)?);
		}

		// Compile every namespace.
		// TODO: Compile global declarations first so they can refer to each
		// other.
		for namespace in program.namespaces {
			for Constant { name, expression } in namespace.constants {
				let value = self.resolve_constant(expression)?;
				self.constants
					.insert(format!("{}::{}", namespace.name, name), value);
			}
			self.namespace = Some(namespace.name);
			for declaration in namespace.declarations {
				assembly.extend(self.compile_global_declaration(declaration)?);
			}
			for function in namespace.script_functions {
				assembly.extend(self.compile_function(function)?);
			}
			for function in namespace.assembly_functions {
				assembly.extend(self.compile_assembly_function(function)?);
			}
			self.namespace = None;
		}

		// Compile the rest of the program.
		for function in program.script_functions {
			assembly.extend(self.compile_function(function)?);
		}
		for function in program.assembly_functions {
			assembly.extend(self.compile_assembly_function(function)?);
		}
		for handler in program.interrupt_handlers {
			assembly.extend(self.compile_interrupt_handler(handler)?);
		}

		// Set up event handlers jump table.
		// TODO: Disable events that aren't listened for.
		// Might still want a sparse jump table in that case.
		const INSTRUCTIONS_PER_JUMP_TABLE_ENTRY: usize = 3;
		const INSTRUCTION_SIZE: usize = 3;
		assembly.extend([
			format!("__handle_interrupt:"),
			format!("and  rD, rE, $FF"),
			format!("sub  rD, 1"),
			format!(
				"mul  rD, {}",
				INSTRUCTIONS_PER_JUMP_TABLE_ENTRY * INSTRUCTION_SIZE
			),
			format!("add  rF, rF, rD"),
		]);

		// Add jump table entries for registered interrupts.
		// TODO: Add arguments. Remember to change
		for interrupt in 1..=0xFF {
			if self.interrupts.contains(&interrupt) {
				assembly.extend([
					format!("let rD, __interrupt_{}[0:1]", interrupt),
					format!("shl rD, 8"),
					format!("or rF, rD, __interrupt_{}[2]", interrupt),
				]);
			} else {
				assembly.extend([
					format!("let  rE, 0"),
					format!("let  rE, 0"),
					format!("let  rE, 0"),
				]);
			}
		}

		// Add string literals for encountered strings.
		for (index, string) in self.strings.iter().enumerate() {
			assembly.push(format!("__string_{}:", index));
			assembly.push(format!("data"));
			let bytes = string.as_bytes();
			assembly.push(format!("{:06X}", bytes.len()));
			// eprintln!("Found string {}: \"{}\"", index, string);
			for chunk in bytes.chunks(40) {
				let mut data = String::new();
				for byte in chunk {
					data += format!("{:02X}", byte).as_str();
				}
				assembly.push(data);
			}
			// assembly.push(format!("00")); // Null-terminated strings.
		}

		Ok(assembly)
	}

	fn compile_global_declaration(
		&mut self,
		declaration: GlobalDeclaration,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let label = format!("__var_{}", self.label_count);

		self.label_count += 1;

		assembly.push(format!("{}:", label));

		if let Some(namespace) = &self.namespace {
			self.global_variables
				.insert(format!("{}::{}", namespace, declaration.name), label);
		} else {
			self.global_variables.insert(declaration.name, label);
		}

		assembly.push(format!("data"));

		if let Some(value) = declaration.value {
			assembly.push(format!("{:06X}", value))
		} else {
			assembly.push(format!("000000"));
		}

		Ok(assembly)
	} //

	fn compile_function(&mut self, function: Function) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		// self.return_variables.push(self.variables.clone());
		let variables = self.variables.clone();
		let stack_offset = self.stack_offset;

		// Register parameters as local variables.
		for (index, parameter) in function.parameters.0.iter().enumerate() {
			self.variables
				.insert(parameter.to_string(), index as i32 * 3);
		}

		// Add function label and prologue.
		let name = if let Some(namespace) = &self.namespace {
			format!("{}::{}", namespace, function.name)
		} else {
			function.name
		};
		assembly.extend([
			format!("{}:", name),
			format!("\tor   rB, rC ; reset stack base pointer"),
		]);

		// Compile each statement in the function block.
		assembly.extend(self.compile_block(function.block)?);

		// Add function epilogue.
		assembly.extend([
			format!("\tor   rC, rB ; reset stack pointer"),
			format!("\tor   rF, rA ; return to rA"),
		]);

		// Clear registered parameters.
		self.variables = variables;
		self.stack_offset = stack_offset;

		Ok(assembly)
	}

	fn compile_assembly_function(
		&mut self,
		function: AssemblyFunction,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let name = if let Some(namespace) = &self.namespace {
			format!("{}::{}", namespace, function.name)
		} else {
			function.name
		};
		assembly.extend([
			format!("{}:", name),
			format!("\tor   rB, rC ; reset stack base pointer"),
		]);

		assembly.push(function.assembly);

		assembly.extend([
			format!("\tor   rC, rB ; reset stack pointer"),
			format!("\tor   rF, rA ; return to rA"),
		]);

		Ok(assembly)
	}

	fn compile_interrupt_handler(
		&mut self,
		handler: InterruptHandler,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let variables = self.variables.clone();
		let stack_offset = self.stack_offset;

		// Register parameters as local variables.
		for (index, identifier) in handler.parameters.0.iter().enumerate() {
			self.variables
				.insert(identifier.to_string(), index as i32 * 3);
		}

		// Add interrupt label and prologue.
		let interrupt = match handler.interrupt {
			Interrupt::Constant(constant) => constant,
			Interrupt::Identifier(identifier) => {
				if let Some(&value) = self.constants.get(&identifier) {
					value as u8
				} else {
					return Err(std::io::Error::new(
						ErrorKind::NotFound,
						format!("{} not found in {:?}", identifier, self.constants.keys()),
					));
				}
			}
		};

		self.interrupts.push(interrupt);

		assembly.extend([
			format!("__interrupt_{}:", interrupt),
			format!("\tshr  rD, rE, 8"),
			format!("\tpush rC, rD"),
			format!("\tor   rB, rC ; reset stack base pointer"),
		]);

		// TODO: Verify that we don't need to modify stack offset before this
		// block.

		// Compile each statement in the function block.
		assembly.extend(self.compile_block(handler.block)?);

		// Add interrupt epilogue.
		assembly.extend([
			format!("\tor   rC, rB ; reset stack pointer"),
			format!("\tadd  rC, 3 ; remove interrupt argument from stack"),
			format!("\tlet  rE, 0 ; return from interrupt"),
		]);

		// Clear registered parameters.
		self.variables = variables;
		self.stack_offset = stack_offset;

		Ok(assembly)
	}

	fn compile_block(&mut self, block: Block) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		// Clone the variables that existed when entering the block.
		let variables = self.variables.clone();
		let stack_offset = self.stack_offset;

		// Compile each statement in the block.
		for statement in block.statements {
			assembly.extend(["".to_string(), "".to_string()]);
			assembly.extend(self.compile_statement(statement)?);
		}

		// Reset the stack pointer.
		// TODO: Not required at the end of functions, where rC <- rB.
		let stack_difference = (self.stack_offset - stack_offset).abs();
		if stack_difference > 0 {
			assembly.push(format!("\tadd  rC, ${:X}", stack_difference));
		}

		// Reset the variables to what existed when entering the block.
		self.variables = variables;
		self.stack_offset = stack_offset;

		Ok(assembly)
	}

	fn compile_statement(&mut self, statement: Statement) -> Result<Vec<String>, std::io::Error> {
		match statement {
			// let a
			Statement::Declaration(identifiers) => self.compile_declaration(identifiers.0),

			// let a = 1
			Statement::Definition(identifiers, expressions) => {
				self.compile_definition(identifiers.0, expressions.0)
			}

			// a = 1
			Statement::Assignment(identifiers, expressions) => {
				self.compile_assignment(identifiers.0, expressions.0)
			}

			// a, 1
			Statement::ExpressionList(expressions) => self.compile_expression_list(expressions.0),

			// { }
			Statement::Block(block) => self.compile_block(block),

			// A:
			Statement::Label(label) => self.compile_label(label),

			// goto A
			Statement::Goto(label) => self.compile_goto(label),

			// while i < 10 { }
			Statement::While(label, expression, block) => {
				self.compile_while(label, expression, block)
			}

			// loop { }
			Statement::Loop(block) => self.compile_loop(block),

			// [3000 + i] = 42
			Statement::Store(address, byte_count, expression) => {
				self.compile_store(address, byte_count, expression)
			}

			Statement::Return(expressions) => self.compile_return(expressions.0),

			Statement::Break(label) => self.compile_break(label),

			Statement::Continue(label) => self.compile_continue(label),
		}
	}

	fn compile_expression(
		&mut self,
		expression: Expression,
	) -> Result<Vec<String>, std::io::Error> {
		match expression {
			// 5
			Expression::Constant(constant) => self.compile_constant(constant),

			// x
			Expression::Variable(identifier) => self.compile_variable(identifier),

			// if p { 2 } else { 3 }
			Expression::Conditional(predicate, positive, negative) => {
				self.compile_conditional(*predicate, positive, negative)
			}

			// if p { 2 } else if q { 3 } else { 4 }
			Expression::ConditionalMultiple(predicate, positive, nested, negative) => {
				self.compile_nested_conditional(*predicate, positive, nested, negative)
			}

			// f(2, 3)
			Expression::Call(identifier, parameters) => self.compile_call(identifier, parameters),

			// !x
			Expression::PrefixOperation(operator, expression) => {
				self.compile_prefix_operation(operator, *expression)
			}

			// 5 + x
			Expression::InfixOperation(operator, a, b) => {
				self.compile_infix_operation(operator, *a, *b)
			}

			// [5 + x]
			Expression::Load(address, byte_count) => self.compile_load(*address, byte_count),

			// "5 + x"
			Expression::StringLiteral(string) => self.compile_string_literal(string),

			Expression::CharacterLiteral(value) => self.compile_character_literal(value),
		}
	}

	fn compile_constant(&mut self, constant: u32) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		assembly.extend([
			format!("\tlet  r1, ${:X} ; {}", constant >> 8, constant),
			format!("\tshl  r1, 8"),
			format!("\tor   r1, ${:X}", constant & 0xFF),
		]);

		Ok(assembly)
	}

	fn compile_variable(&mut self, identifier: String) -> Result<Vec<String>, std::io::Error> {
		if let Some(offset) = self.variables.get(&identifier) {
			Ok(vec![format!("\tld   r1, rB, {} ; {}", offset, identifier)])
		} else if let Some(label) = self.global_variables.get(&identifier) {
			Ok(vec![
				format!("\tlet  r1, {}[0:1]", label),
				format!("\tshl  r1, 8"),
				format!("\tor   r1, {}[2]", label),
				format!("\tld   r1"),
			])
		} else if let Some(value) = self.constants.get(&identifier) {
			// TODO: Verify that the u8 cast is what we want to do everywhere
			Ok(vec![
				format!("\tlet  r1, {}", value >> 8),
				format!("\tshl  r1, 8"),
				format!("\tor   r1, {}", *value as u8),
			])
		} else if identifier.starts_with("/") {
			// Assume that the file data exists or will exist in the assembly.
			Ok(vec![
				format!("\tlet  r1, {}[0:1]", identifier),
				format!("\tshl  r1, 8"),
				format!("\tor   r1, {}[2]", identifier),
			])
		} else {
			Err(std::io::Error::new(
				ErrorKind::NotFound,
				format!(
					"Undeclared {} in {:?}, {:?}, and {:?}",
					identifier,
					self.variables.keys(),
					self.global_variables.keys(),
					self.constants.keys(),
				),
			))
		}
	}

	fn compile_prefix_operation(
		&mut self,
		operator: PrefixOperator,
		expression: Expression,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = self.compile_expression(expression)?;

		match operator {
			// -x
			PrefixOperator::ArithmeticNegation => assembly.push(format!("\tsub  r1, r0, r1")),

			// ~x
			PrefixOperator::BitwiseNegation => assembly.push(format!("\tnor  r1, r0, r1")),

			// !x
			PrefixOperator::LogicalNegation => {
				assembly.push(format!("\tless r1, 1"));
			}
		}

		Ok(assembly)
	}

	fn compile_infix_operation(
		&mut self,
		operator: InfixOperator,
		a: Expression,
		b: Expression,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = self.compile_expression(a)?;

		match operator {
			// &&, lazy and, short circuits
			InfixOperator::LogicalConjunction => {
				let label_index = self.label_count;
				self.label_count += 1;
				assembly.extend([
					format!("\tless r1, 1"),
					format!("\tif   r1, __skip_{}", label_index),
				]);
				assembly.extend(self.compile_expression(b)?);
				assembly.extend([
					format!("\tless r1, 1"),
					format!("\t__skip_{}:", label_index),
					format!("\txor  r1, 1"),
				]);
				return Ok(assembly);
			}

			// ||, lazy or, short circuits
			InfixOperator::LogicalDisjunction => {
				let label_index = self.label_count;
				self.label_count += 1;
				assembly.extend([
					format!("\tless r1, 1"),
					format!("\tless r1, 1"), // Two `less r, 1` == `!!r`
					format!("\tif   r1, __skip_{}", label_index),
				]);
				assembly.extend(self.compile_expression(b)?);
				assembly.extend([
					format!("\tless r1, 1"),
					format!("\tless r1, 1"),
					format!("\t__skip_{}:", label_index), // TODO: Maybe move line one up
				]);
				return Ok(assembly);
			}
			_ => {}
		}

		assembly.push(format!("\tpush rC, r1"));
		self.stack_offset -= 3;
		assembly.extend(self.compile_expression(b)?);
		assembly.push(format!("\tpop  r2, rC"));
		self.stack_offset += 3;

		match operator {
			InfixOperator::Addition =>
			// +
			{
				assembly.push(format!("\tadd  r1, r2, r1"))
			}
			InfixOperator::Subtraction =>
			// -
			{
				assembly.push(format!("\tsub  r1, r2, r1"))
			}
			InfixOperator::Multiplication =>
			// *
			{
				assembly.push(format!("\tmul  r1, r2, r1"))
			}
			InfixOperator::BitwiseConjunction =>
			// &
			{
				assembly.push(format!("\tand  r1, r2, r1"))
			}
			InfixOperator::BitwiseDisjunction =>
			// |
			{
				assembly.push(format!("\tor   r1, r2, r1"))
			}
			InfixOperator::BitwiseExclusiveDisjunction =>
			// ^
			{
				assembly.push(format!("\txor  r1, r2, r1"))
			}
			InfixOperator::BitwiseNegationDisjunction =>
			// ?
			{
				assembly.push(format!("\tnor  r1, r2, r1"))
			}
			InfixOperator::Equality =>
			// ==
			{
				assembly.extend([format!("\tsub  r1, r2, r1"), format!("\tless r1, 1")])
			}
			InfixOperator::Inequality =>
			// !=
			{
				assembly.extend([
					format!("\tsub  r1, r2, r1"),
					format!("\tless r1, 1"),
					format!("\tless r1, 1"),
				])
			}
			InfixOperator::Less =>
			// <
			{
				assembly.push(format!("\tless r1, r2, r1"))
			}
			InfixOperator::LessEquality =>
			// <=
			{
				assembly.extend([format!("\tless r1, r1, r2"), format!("\tless r1, 1")])
			}
			InfixOperator::Greater =>
			// >
			{
				assembly.push(format!("\tless r1, r1, r2"))
			}
			InfixOperator::GreaterEquality =>
			// >=
			{
				assembly.extend([format!("\tless r1, r2, r1"), format!("\tless r1, 1")])
			}
			InfixOperator::ArithmeticShiftRight =>
			// ->>
			{
				assembly.push(format!("\tashr r1, r2, r1"))
			}
			InfixOperator::ShiftLeft =>
			// <<
			{
				assembly.push(format!("\tshl  r1, r2, r1"))
			}
			InfixOperator::ShiftRight =>
			// >>
			{
				assembly.push(format!("\tshr  r1, r2, r1"))
			}
			InfixOperator::RotateLeft =>
			// <<<
			{
				assembly.push(format!("\trotl r1, r2, r1"))
			}
			InfixOperator::RotateRight =>
			// >>>
			{
				assembly.push(format!("\trotr r1, r2, r1"))
			}
			_ => unreachable!(),
		}

		Ok(assembly)
	}

	/// [address].
	fn compile_load(
		&mut self,
		address: Expression,
		byte_count: u8,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		assembly.extend(self.compile_expression(address)?);

		assembly.extend([format!("\tld   r1, 0, {}", byte_count)]);

		Ok(assembly)
	}

	/// "string"
	fn compile_string_literal(&mut self, string: String) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		if let Some(index) = self.strings.iter().position(|s| *s == string) {
			// String already exists, use its label.
			assembly.push(format!("let  rD, __string_{}[0:1]", index));
			assembly.push(format!("shl  rD, 8"));
			assembly.push(format!("or   r1, rD, __string_{}[2]", index));
		} else {
			let index = self.strings.len();
			assembly.push(format!("let  rD, __string_{}[0:1]", index));
			assembly.push(format!("shl  rD, 8"));
			assembly.push(format!("or   r1, rD, __string_{}[2]", index));
			self.strings.push(string.clone());
		}

		Ok(assembly)
	}

	/// 'CHA'
	fn compile_character_literal(&mut self, value: u32) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		assembly.extend([
			format!("\tlet  r1, ${:X} ; ${:X}", value >> 8, value),
			format!("\tshl  r1, 8"),
			format!("\tor   r1, ${:X}", value & 0xFF),
		]);

		Ok(assembly)
	}

	fn compile_label(&self, label: String) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		assembly.push(format!("{}:", label));

		Ok(assembly)
	}

	fn compile_goto(&self, label: String) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		assembly.extend([
			format!("\tlet  rD, {}[0:1]", label),
			format!("\tshl  rD, 8"),
			format!("\tor   rF, rD, {}[2]", label),
		]);

		Ok(assembly)
	}

	fn compile_while(
		&mut self,
		label: Option<String>,
		expression: Expression,
		block: Block,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let label_index = self.label_count;

		self.label_count += 2;

		self.while_labels.push((label, label_index));

		assembly.push(format!("__while_{}:", label_index));

		assembly.extend(self.compile_expression(expression)?);

		assembly.extend([
			format!("\tless r1, 1"),
			format!("\tif   r1, __end_{}", label_index + 1),
		]);

		assembly.extend(self.compile_block(block)?);

		assembly.extend([
			format!("\tif   __while_{}", label_index),
			format!("\t__end_{}:", label_index + 1),
		]);

		self.while_labels.pop();

		Ok(assembly)
	}

	fn compile_loop(&mut self, block: Block) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let label_index = self.label_count;

		self.label_count += 1;

		assembly.push(format!("__loop_{}:", label_index));

		assembly.extend(self.compile_block(block)?);

		assembly.push(format!("\tif   __loop_{}", label_index));

		Ok(assembly)
	}

	/// [address] = expression.
	// TODO: Byte counts (default is 1 byte)
	fn compile_store(
		&mut self,
		address: Expression,
		byte_count: u8,
		expression: Expression,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		assembly.extend(self.compile_expression(address)?);

		assembly.push(format!("\tpush rC, r1"));

		assembly.extend(self.compile_expression(expression)?);

		assembly.extend([
			format!("\tpop  r2, rC"),
			format!("\tst   r2, r1, 0, {}", byte_count),
		]);

		Ok(assembly)
	}

	/// return expression
	fn compile_return(
		&mut self,
		expressions: Vec<Expression>,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let expression_count = expressions.len();
		for expression in expressions {
			assembly.extend(self.compile_expression(expression)?);
			assembly.push(format!("\tpush rC, r1"));
			self.stack_offset -= 3;
		}
		for index in 0..expression_count {
			let offset = expression_count - index;
			assembly.push(format!("\tpop  r{:X}, rC", offset));
			self.stack_offset += 3;
		}

		// Add function epilogue (yes, in the middle of everywhere.
		assembly.extend([
			format!("\tor   rC, rB ; reset stack pointer"),
			format!("\tor   rF, rA ; return to rA"),
		]);

		Ok(assembly)
	}

	/// break while loop
	fn compile_break(&mut self, label: Option<String>) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let (_, index) = match label {
			Some(label) => self
				.while_labels
				.iter()
				.find(|label_index| Some(label.clone()) == label_index.0)
				.unwrap(), // TODO: Compiler error: label loop not found in stack
			None => self.while_labels.last().unwrap(), // TODO: Compiler error: break with no loop
		};

		assembly.extend([
			format!("let  rD, __end_{}[0:1]", index + 1),
			format!("shl  rD, 8"),
			format!("or   rF, rD, __end_{}[2]", index + 1),
		]);

		Ok(assembly)
	}

	/// continue while loop
	fn compile_continue(&mut self, label: Option<String>) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let (_, index) = match label {
			Some(label) => self
				.while_labels
				.iter()
				.find(|label_index| Some(label.clone()) == label_index.0)
				.unwrap(), // TODO: Compiler error: label loop not found in stack
			None => self.while_labels.last().unwrap(), // TODO: Compiler error: break with no loop
		};

		assembly.extend([
			format!("let  rD, __while_{}[0:1]", index),
			format!("shl  rD, 8"),
			format!("or   rF, rD, __while_{}[2]", index),
		]);

		Ok(assembly)
	}

	/// if `predicate` { `positive` } else { `negative` }
	fn compile_conditional(
		&mut self,
		predicate: Expression,
		positive: Block,
		negative: Option<Block>,
	) -> Result<Vec<String>, std::io::Error> {
		// The predicate is always evaluated first.
		let mut assembly = self.compile_expression(predicate)?;

		let label_index = self.label_count;

		self.label_count += 2;

		// If the predicate was true, skip over the jump-to-else
		assembly.extend([
			format!("\tif   r1, 12"),
			format!("\tlet  rD, __else_{}[0:1]", label_index),
			format!("\tshl  rD, 8"),
			format!("\tor   rF, rD, __else_{}[2]", label_index),
		]);

		// Add the block for true.
		// TODO: Check if label_count can increment here.
		assembly.extend(self.compile_block(positive)?);

		// Then jump to end.
		assembly.extend([
			format!("\tlet  rD, __end_{}[0:1]", label_index + 1),
			format!("\tshl  rD, 8"),
			format!("\tor   rF, rD, __end_{}[2]", label_index + 1),
		]);

		assembly.push(format!("\t__else_{}:", label_index));

		// Add all the statements for false, if any.
		if let Some(block) = negative {
			assembly.extend(self.compile_block(block)?);
		}

		assembly.push(format!("\t__end_{}:", label_index + 1));

		Ok(assembly)
	}

	/// if `predicate` { `positive` } (else if `predicate` { `nested` }) else { `negative` }
	fn compile_nested_conditional(
		&mut self,
		predicate: Expression,
		positive: Block,
		nested: Vec<ElseIf>,
		negative: Option<Block>,
	) -> Result<Vec<String>, std::io::Error> {
		// The predicate is always evaluated first.
		let mut assembly = self.compile_expression(predicate)?;

		let positive_block = self.compile_block(positive)?;

		let mut label_index = self.label_count;
		let end_index = label_index + 1;
		// let label_count = nested.len() + 2 as usize;

		self.label_count += 2;

		// If the predicate was false, skip the positive blocck.
		assembly.extend([
			format!("\tless r1, 1"),
			format!("\tif   r1, __else_if_{}", label_index),
		]);

		// If the predicate was true, execute the positive block.
		assembly.extend(positive_block);

		// Then jump to the end
		assembly.extend([
			format!("\tlet  rD, __end_{}[0:1]", end_index),
			format!("\tshl  rD, 8"),
			format!("\tor   rF, rD, __end_{}[2]", end_index),
		]);

		// Collect all the nested blocks and predicates.
		let mut predicates_and_blocks = vec![];
		for ElseIf { predicate, block } in nested {
			predicates_and_blocks.push((
				self.compile_expression(predicate).unwrap(),
				self.compile_block(block).unwrap(),
			));
		}

		for (predicate, block) in predicates_and_blocks {
			assembly.extend([format!("\t__else_if_{}:", label_index)]);

			label_index = self.label_count;
			self.label_count += 1;

			assembly.extend(predicate.clone());

			// If the predicate was false, skip the positive block and go to the
			// next else-if.
			assembly.extend([
				format!("\tless r1, 1"),
				format!("\tif   r1, __else_if_{}", label_index),
			]);

			assembly.extend(block.clone());

			// Then jump to the end
			assembly.extend([
				format!("\tlet  rD, __end_{}[0:1]", end_index),
				format!("\tshl  rD, 8"),
				format!("\tor   rF, rD, __end_{}[2]", end_index),
			]);
		}

		// HACK: Extra else_if label to catch the last else-if block.
		assembly.extend([format!("\t__else_if_{}:", label_index)]);

		// Add all the statements for all-false, if any.
		if let Some(block) = negative {
			assembly.extend(self.compile_block(block)?);
		}

		assembly.push(format!("\t__end_{}:", end_index));

		Ok(assembly)
	}

	fn compile_declaration(
		&mut self,
		identifiers: Vec<String>,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		for identifier in &identifiers {
			self.stack_offset -= 3;
			if self.variables.get(identifier).is_none() {
				// Declare new variable.
				self.variables
					.insert(identifier.to_string(), self.stack_offset);
			} else {
				// Shadow previous variable.
				let reference = self.variables.get_mut(identifier).unwrap();
				*reference = self.stack_offset;
			}
		}

		assembly.push(format!("\tsub  rC, {:X}", identifiers.len() * 3));

		Ok(assembly)
	}

	fn compile_definition(
		&mut self,
		identifiers: Vec<String>,
		expressions: Vec<Expression>,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = self.compile_declaration(identifiers.clone())?;

		assembly.extend(self.compile_assignment(identifiers, expressions)?);

		Ok(assembly)
	}

	fn compile_assignment(
		&mut self,
		identifiers: Vec<String>,
		expressions: Vec<Expression>,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let mut identifier_index = 0;
		for expression in expressions {
			assembly.extend(self.compile_expression(expression.clone())?);
			let from = identifier_index;
			let to = (identifier_index + expression.cardinality()).min(identifiers.len());
			for (register_index, identifier) in identifiers[from..to].iter().enumerate() {
				if let Some(&stack_offset) = self.variables.get(identifier) {
					assembly.push(format!(
						"\tst   rB, r{:X}, {}",
						register_index + 1,
						stack_offset,
					))
				} else if let Some(label) = self.global_variables.get(identifier) {
					assembly.extend([
						format!("\tlet  rD, {}[0:1]", label),
						format!("\tshl  rD, 8"),
						format!("\tor   rD, {}[2]", label),
						format!("\tst   rD, r{:X}", register_index + 1),
					])
				} else {
					return Err(std::io::Error::new(
						ErrorKind::NotFound,
						format!("{}: Not found", identifier),
					));
				}
			}
			identifier_index += expression.cardinality();
			// if identifier_index >= identifiers.len() {
			// break;
			// }
		}

		Ok(assembly)
	}

	fn compile_call(
		&mut self,
		identifier: String,
		expressions: Vec<Expression>,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		// Store the current function's stack base and return address on the stack.
		assembly.extend([format!("\tpush rC, rB"), format!("\tpush rC, rA")]);

		self.stack_offset -= 6;

		assembly.extend(self.compile_expression_list(expressions.clone())?);

		// Store each parameter expression evaluation result on the stack.
		for i in 0..expressions.len() {
			let register_index = expressions.len() - i;
			assembly.push(format!("\tpush rC, r{:X}", register_index));
		}

		// Set the new return address, jump to the function, reset the stack
		// pointer and stack base pointer
		assembly.extend([
			format!("\tadd  rA, rF, 9"), // pre-incr. PC => add 9 instead of 12
			format!("\tlet  rD, {}[0:1]", identifier),
			format!("\tshl  rD, 8"),
			format!("\tor   rF, rD, {}[2]", identifier),
			format!("\tadd  rC, {}", expressions.len() * 3), // fix stack offset
			format!("\tpop  rA, rC"),
			format!("\tpop  rB, rC"),
		]);

		self.stack_offset += 6;

		Ok(assembly)
	}

	fn compile_expression_list(
		&mut self,
		expressions: Vec<Expression>,
	) -> Result<Vec<String>, std::io::Error> {
		let mut assembly = Vec::new();

		let expression_count = expressions.len();
		for expression in expressions {
			assembly.extend(self.compile_expression(expression)?);
			assembly.push(format!("\tpush rC, r1"));
			self.stack_offset -= 3;
		}
		for index in 0..expression_count {
			let offset = expression_count - index;
			assembly.push(format!("\tpop  r{:X}, rC", offset));
			self.stack_offset += 3;
		}

		Ok(assembly)
	}

	fn resolve_constant(&mut self, expression: Expression) -> Result<u32, std::io::Error> {
		match expression {
			Expression::Constant(value) => Ok(value),

			Expression::Load(_, _) => Err(std::io::Error::new(
				ErrorKind::InvalidInput,
				"Can't access memory in a constant expression",
			)),

			Expression::Variable(name) => {
				if let Some(&value) = self.constants.get(&name) {
					Ok(value)
				} else {
					Err(std::io::Error::new(
						ErrorKind::NotFound,
						format!("\"{}\" not found in {:?}", name, self.constants.keys()),
					))
				}
			}

			Expression::Conditional(_, _, _) => todo!(),

			Expression::Call(_, _) => todo!(),

			Expression::PrefixOperation(operator, expression) => match operator {
				PrefixOperator::ArithmeticNegation => {
					Ok((-(self.resolve_constant(*expression)? as i32) << 8 >> 8) as u32 & 0xFFFFFF)
				}

				PrefixOperator::BitwiseNegation => todo!(),

				PrefixOperator::LogicalNegation => todo!(),
			},

			Expression::InfixOperation(operator, a, b) => match operator {
				InfixOperator::Addition => {
					Ok((self.resolve_constant(*a)? + self.resolve_constant(*b)?) & 0xFFFFFF)
				}

				InfixOperator::Subtraction => {
					Ok((self.resolve_constant(*a)? - self.resolve_constant(*b)?) & 0xFFFFFF)
				}
				InfixOperator::Multiplication => {
					Ok((self.resolve_constant(*a)? * self.resolve_constant(*b)?) & 0xFFFFFF)
				}
				InfixOperator::BitwiseConjunction => todo!(),
				InfixOperator::BitwiseDisjunction => todo!(),
				InfixOperator::BitwiseExclusiveDisjunction => todo!(),
				InfixOperator::BitwiseNegationDisjunction => todo!(),
				InfixOperator::LogicalConjunction => todo!(),
				InfixOperator::LogicalDisjunction => todo!(),
				InfixOperator::Equality => todo!(),
				InfixOperator::Inequality => todo!(),
				InfixOperator::Less => todo!(),
				InfixOperator::LessEquality => todo!(),
				InfixOperator::Greater => todo!(),
				InfixOperator::GreaterEquality => todo!(),
				InfixOperator::ArithmeticShiftRight => todo!(),
				InfixOperator::ShiftLeft => {
					Ok((self.resolve_constant(*a)? << self.resolve_constant(*b)?) & 0xFFFFFF)
				}
				InfixOperator::ShiftRight => todo!(),
				InfixOperator::RotateLeft => todo!(),
				InfixOperator::RotateRight => todo!(),
			},

			Expression::StringLiteral(_) => todo!(),
			Expression::CharacterLiteral(value) => Ok(value),
			Expression::ConditionalMultiple(_, _, _, _) => todo!(),
		}
	}
}

impl Default for Compiler {
	fn default() -> Self {
		Self {
			stack_offset: 0,
			variables: HashMap::new(),
			global_variables: HashMap::new(),
			label_count: 0,
			while_labels: Vec::new(),
			interrupts: Vec::new(),
			constants: HashMap::new(),
			strings: Vec::new(),
			namespace: None,
		}
	}
}
