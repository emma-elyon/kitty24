use std::{error::Error, io::ErrorKind};

use pest::{
	iterators::{Pair, Pairs},
	pratt_parser::{Assoc, Op, PrattParser},
	Parser,
};

use crate::ast::*;

#[derive(Parser)]
#[grammar = "kitty-script.pest"]
struct KittyScriptParser;

impl TryFrom<&str> for Program {
	type Error = std::io::Error;

	fn try_from(string: &str) -> Result<Self, Self::Error> {
		KittyScriptParser::parse(Rule::Program, string)
			.map_err(parse_error)?
			.try_into()
	}
}

impl TryFrom<Pairs<'_, Rule>> for Program {
	type Error = std::io::Error;

	fn try_from(pairs: Pairs<'_, Rule>) -> Result<Self, Self::Error> {
		let mut assembly_functions = Vec::new();
		let mut script_functions: Vec<Function> = Vec::new();
		let mut interrupt_handlers = Vec::new();
		let mut declarations = Vec::new();
		let mut constants = Vec::new();
		let mut namespaces = Vec::new();

		for unit in pairs {
			match unit.as_rule() {
				Rule::Function => script_functions.push(unit.try_into()?),

				Rule::AssemblyFunction => assembly_functions.push(unit.into()),

				Rule::Interrupt => interrupt_handlers.push(unit.try_into()?),

				Rule::GlobalDeclaration => declarations.extend(parse_global_declaration(unit)?),

				Rule::GlobalConst => constants.extend(parse_global_const(unit)?),

				Rule::Namespace => namespaces.push(unit.try_into()?),

				Rule::EOI => {}

				_ => unimplemented!(),
			}
		}

		Ok(Program {
			script_functions,
			assembly_functions,
			interrupt_handlers,
			declarations,
			constants,
			namespaces,
		})
	}
}

impl TryFrom<Pair<'_, Rule>> for Namespace {
	type Error = std::io::Error;

	fn try_from(value: Pair<'_, Rule>) -> Result<Self, Self::Error> {
		let mut pairs = value.into_inner();
		let mut assembly_functions = Vec::new();
		let mut script_functions: Vec<Function> = Vec::new();
		let mut declarations = Vec::new();
		let mut constants = Vec::new();

		let name = pairs.next().unwrap().as_str().to_string();

		for unit in pairs {
			match unit.as_rule() {
				Rule::Function => script_functions.push(unit.try_into()?),

				Rule::AssemblyFunction => assembly_functions.push(unit.into()),

				Rule::GlobalDeclaration => declarations.extend(parse_global_declaration(unit)?),

				Rule::GlobalConst => constants.extend(parse_global_const(unit)?),

				Rule::EOI => {}

				_ => unimplemented!(),
			}
		}

		Ok(Namespace {
			name,
			script_functions,
			assembly_functions,
			declarations,
			constants,
		})
	}
}

impl TryFrom<Pair<'_, Rule>> for Function {
	type Error = std::io::Error;

	fn try_from(pair: Pair<Rule>) -> Result<Self, Self::Error> {
		let mut pairs = pair.into_inner();
		Ok(Function {
			name: pairs.next().unwrap().as_str().to_string(),
			parameters: pairs.next().unwrap().into(),
			block: pairs.next().unwrap().try_into()?,
		})
	}
}

impl From<Pair<'_, Rule>> for AssemblyFunction {
	fn from(pair: Pair<'_, Rule>) -> Self {
		let mut pairs = pair.into_inner();
		AssemblyFunction {
			name: pairs.next().unwrap().as_str().to_string(),
			parameters: pairs.next().unwrap().into(),
			assembly: pairs.next().unwrap().as_str().to_string(),
		}
	}
}

impl TryFrom<Pair<'_, Rule>> for InterruptHandler {
	type Error = std::io::Error;

	fn try_from(pair: Pair<'_, Rule>) -> Result<Self, Self::Error> {
		let mut pairs = pair.into_inner();
		Ok(InterruptHandler {
			interrupt: pairs.next().unwrap().try_into()?,
			parameters: pairs.next().unwrap().into(),
			block: pairs.next().unwrap().try_into()?,
		})
	}
}

impl TryFrom<Pair<'_, Rule>> for Block {
	type Error = std::io::Error;

	fn try_from(value: Pair<'_, Rule>) -> Result<Self, Self::Error> {
		let mut statements = Vec::new();
		for statement in value.into_inner().next().unwrap().into_inner() {
			statements.push(statement.try_into()?);
		}
		Ok(Block { statements })
	}
}

impl From<Pair<'_, Rule>> for Parameters {
	fn from(value: Pair<'_, Rule>) -> Self {
		let mut parameters = Vec::new();
		for parameter in value.into_inner() {
			parameters.push(parameter.as_str().to_string());
		}
		Parameters(parameters)
	}
}

impl TryFrom<Pair<'_, Rule>> for Interrupt {
	type Error = std::io::Error;

	fn try_from(pair: Pair<'_, Rule>) -> Result<Self, Self::Error> {
		let interrupt = match pair.as_rule() {
			Rule::Constant => Interrupt::Constant(parse_constant(pair)? as u8),
			Rule::Identifier => Interrupt::Identifier(pair.as_str().to_string()),
			_ => unreachable!(),
		};
		Ok(interrupt)
	}
}

impl TryFrom<Pair<'_, Rule>> for Statement {
	type Error = std::io::Error;

	fn try_from(pair: Pair<'_, Rule>) -> Result<Self, Self::Error> {
		let inner_pair = pair.clone().into_inner().next().unwrap();
		let mut pairs = inner_pair.clone().into_inner();
		let statement = match inner_pair.as_rule() {
			Rule::Definition => Statement::Definition(
				pairs.next().unwrap().into_inner().into(),
				pairs.next().unwrap().into_inner().try_into()?,
			),
			Rule::Declaration => Statement::Declaration(pairs.next().unwrap().into_inner().into()),
			Rule::Assignment => Statement::Assignment(
				pairs.next().unwrap().into_inner().into(),
				pairs.next().unwrap().into_inner().try_into()?,
			),
			Rule::ExpressionList => Statement::ExpressionList(pairs.try_into()?),
			Rule::Block => Statement::Block(inner_pair.try_into()?),
			Rule::LabelDefinition => Statement::Label(pairs.next().unwrap().as_str().to_string()),
			Rule::Goto => Statement::Goto(pairs.next().unwrap().as_str().to_string()),
			Rule::While => Statement::While(
				None,
				pairs.next().unwrap().try_into()?,
				pairs.next().unwrap().try_into()?,
			),
			Rule::LabelWhile => Statement::While(
				Some(pairs.next().unwrap().as_str().to_string()),
				pairs.next().unwrap().try_into()?,
				pairs.next().unwrap().try_into()?,
			),
			Rule::Loop => Statement::Loop(pairs.next().unwrap().try_into()?),
			Rule::Store => {
				let address = pairs.next().unwrap().try_into()?;
				let pair = pairs.next().unwrap();
				match pair.as_rule() {
					Rule::Expression => {
						let expression = pair.try_into()?;
						Statement::Store(address, 1, expression)
					}
					Rule::ByteCount => {
						let byte_count = pair.as_str().parse::<u8>().unwrap();
						let expression = pairs.next().unwrap().try_into()?;
						Statement::Store(address, byte_count, expression)
					}
					_ => unreachable!("{}", pair),
				}
			}
			Rule::Return => Statement::Return(
				pairs
					.next()
					.map(|pair| pair.into_inner().try_into().unwrap())
					.unwrap_or(Expressions(Vec::new())),
			),
			Rule::Break => Statement::Break(pairs.next().map(|pair| pair.as_str().to_string())),
			Rule::Continue => {
				Statement::Continue(pairs.next().map(|pair| pair.as_str().to_string()))
			}
			_ => unreachable!("\n{}: \"{}\"\n{}", pair, pair.as_str(), get_context(&pair)),
		};
		Ok(statement)
	}
}

impl From<Pair<'_, Rule>> for ElseIf {
	fn from(value: Pair<'_, Rule>) -> Self {
		let mut pairs = value.into_inner();
		let predicate = pairs.next().unwrap().try_into().unwrap();
		let block = pairs.next().unwrap().try_into().unwrap();
		ElseIf { predicate, block }
	}
}

impl From<Pairs<'_, Rule>> for Declarations {
	fn from(pairs: Pairs<'_, Rule>) -> Self {
		let mut identifiers = Vec::new();
		for pair in pairs {
			identifiers.push(pair.as_str().to_string());
		}
		Declarations(identifiers)
	}
}

impl TryFrom<Pairs<'_, Rule>> for Expressions {
	type Error = std::io::Error;

	fn try_from(pairs: Pairs<'_, Rule>) -> Result<Self, Self::Error> {
		let mut expressions = Vec::new();
		for pair in pairs {
			expressions.push(pair.try_into()?);
		}
		Ok(Expressions(expressions))
	}
}

impl From<Pairs<'_, Rule>> for References {
	fn from(pairs: Pairs<'_, Rule>) -> Self {
		let mut identifiers = Vec::new();
		for pair in pairs {
			identifiers.push(pair.as_str().to_string());
		}
		References(identifiers)
	}
}

impl TryFrom<Pair<'_, Rule>> for Expression {
	type Error = std::io::Error;

	fn try_from(pair: Pair<'_, Rule>) -> Result<Self, Self::Error> {
		PrattParser::new()
			.op(Op::infix(Rule::LogicalDisjunction, Assoc::Left))
			.op(Op::infix(Rule::LogicalConjunction, Assoc::Left))
			.op(Op::infix(Rule::Equality, Assoc::Left)
				| Op::infix(Rule::Inequality, Assoc::Left)
				| Op::infix(Rule::Less, Assoc::Left)
				| Op::infix(Rule::LessEquality, Assoc::Left)
				| Op::infix(Rule::Greater, Assoc::Left)
				| Op::infix(Rule::GreaterEquality, Assoc::Left))
			.op(Op::infix(Rule::BitwiseConjunction, Assoc::Left))
			.op(Op::infix(Rule::BitwiseExclusiveDisjunction, Assoc::Left))
			.op(Op::infix(Rule::BitwiseDisjunction, Assoc::Left))
			.op(Op::infix(Rule::BitwiseNegationDisjunction, Assoc::Left))
			.op(Op::infix(Rule::ArithmeticShiftRight, Assoc::Left)
				| Op::infix(Rule::ShiftLeft, Assoc::Left)
				| Op::infix(Rule::ShiftRight, Assoc::Left)
				| Op::infix(Rule::RotateLeft, Assoc::Left)
				| Op::infix(Rule::RotateRight, Assoc::Left))
			.op(Op::infix(Rule::Addition, Assoc::Left) | Op::infix(Rule::Subtraction, Assoc::Left))
			.op(Op::infix(Rule::Multiplication, Assoc::Left))
			.op(Op::prefix(Rule::ArithmeticNegation)
				| Op::prefix(Rule::BitwiseNegation)
				| Op::prefix(Rule::LogicalNegation))
			.map_primary(parse_primary_expression)
			.map_prefix(parse_prefix_expression)
			.map_infix(parse_infix_expression)
			.parse(pair.into_inner())
	}
}

fn parse_error(error: pest::error::Error<Rule>) -> std::io::Error {
	map_error(error.to_string())
}

fn map_error<E>(error: E) -> std::io::Error
where
	E: Into<Box<dyn Error + Send + Sync>>,
{
	std::io::Error::new(ErrorKind::InvalidInput, error)
}

fn parse_primary_expression(pair: Pair<Rule>) -> Result<Expression, std::io::Error> {
	let expression = match pair.as_rule() {
		Rule::Expression => pair.try_into()?,
		Rule::Constant => Expression::Constant(parse_constant(pair)?),
		Rule::Identifier => Expression::Variable(pair.as_str().to_string()),
		Rule::Conditional => {
			let mut pairs = pair.into_inner();
			let predicate = pairs.next().unwrap().try_into()?;
			let positive_block = pairs.next().unwrap();
			let positive_block = positive_block.try_into()?;
			if let Some(negative_block) = pairs.next() {
				let negative_block = negative_block.try_into()?;
				Expression::Conditional(Box::new(predicate), positive_block, Some(negative_block))
			} else {
				Expression::Conditional(Box::new(predicate), positive_block, None)
			}
		}
		Rule::ConditionalMultiple => {
			// else if
			let mut pairs = pair.into_inner();
			let predicate = pairs.next().unwrap().try_into()?;
			let positive_block = pairs.next().unwrap();
			let positive_block = positive_block.try_into()?;
			let mut negative_block = None;
			let mut nested_conditionals = vec![];
			for pair in pairs {
				match pair.as_rule() {
					Rule::ElseIf => {
						nested_conditionals.push(TryInto::<ElseIf>::try_into(pair).unwrap());
					}
					Rule::Block => {
						negative_block = Some(TryInto::<Block>::try_into(pair)?);
					}
					_ => unreachable!("\n{}\n{}", pair.as_str(), get_context(&pair)),
				}
			}
			Expression::ConditionalMultiple(
				Box::new(predicate),
				positive_block,
				nested_conditionals,
				negative_block,
			)
		}
		Rule::Call => {
			let mut pairs = pair.into_inner();
			let identifier = pairs.next().unwrap().as_str().to_string();
			let mut expressions = Vec::new();
			if let Some(expression_list) = pairs.next() {
				let expression_pairs = expression_list.into_inner();
				for expression in expression_pairs {
					expressions.push(expression.try_into()?);
				}
			}
			Expression::Call(identifier, expressions)
		}
		Rule::Load => {
			let mut pairs = pair.into_inner();
			let address = pairs.next().unwrap().try_into()?;
			let byte_count = if let Some(byte_count) = pairs.next() {
				byte_count.as_str().parse::<u8>().unwrap()
			} else {
				1
			};
			Expression::Load(Box::new(address), byte_count)
		}
		Rule::StringLiteral => {
			let pairs = pair.clone().into_inner();
			// let pairs = pairs.next().unwrap().into_inner();
			let mut string = String::new();
			for pair in pairs {
				string = string
					+ match pair.as_rule() {
						Rule::StringRaw => pair.as_str(),
						Rule::StringEscapePredefined => match pair.as_str() {
							"n" => "\n",
							// "\r" => "\r", // Unused on Kitty24
							"t" => "\t",
							"\\" => "\\",
							"0" => "0",
							"\"" => "\"",
							// "\\\'" => "\'", // Does not need escaping
							s => s,
						},
						_ => unreachable!("{}", pair),
					}
			}
			// eprintln!("PARSED \"{}\" (from \"{}\")", string, pair.as_str());
			Expression::StringLiteral(string)
		}
		Rule::CharacterLiteral => {
			let mut pairs = pair.clone().into_inner();
			let a = parse_character_literal(pairs.next().unwrap())? as u32;
			let b = pairs
				.next()
				.map(|pair| parse_character_literal(pair).unwrap() as u32);
			let c = pairs
				.next()
				.map(|pair| parse_character_literal(pair).unwrap() as u32);
			let a = a
				<< if b.is_none() {
					0
				} else if c.is_none() {
					8
				} else {
					16
				};
			let b = if b.is_none() {
				0
			} else if c.is_none() {
				b.unwrap()
			} else {
				b.unwrap() << 8
			};
			let c = if c.is_none() { 0 } else { c.unwrap() };
			// eprintln!("CHARLIT: {} (from \"{}\")", a | b | c, pair.as_str());
			Expression::CharacterLiteral(a | b | c)
		}
		_ => unreachable!("{}", pair),
	};
	Ok(expression)
}

fn parse_character_literal(pair: Pair<Rule>) -> std::io::Result<u8> {
	match pair.as_rule() {
		Rule::CharacterRaw => Ok(*pair.as_str().as_bytes().first().unwrap()),
		Rule::CharacterEscapePredefined => match pair.as_str() {
			"n" => Ok(b'\n'),
			// "\r" => "\r", // Unused on Kitty24
			"t" => Ok(b'\t'),
			"\\" => Ok(b'\\'),
			"0" => Ok(b'0'),
			"\'" => Ok(b'\''),
			// "\\\'" => "\'", // Does not need escaping
			s => Ok(*s.as_bytes().first().unwrap()),
		},
		_ => unreachable!("{}", pair),
	}
}

fn parse_prefix_expression(
	pair: Pair<Rule>,
	expression: std::io::Result<Expression>,
) -> std::io::Result<Expression> {
	let operator = match pair.as_rule() {
		Rule::ArithmeticNegation => PrefixOperator::ArithmeticNegation,
		Rule::BitwiseNegation => PrefixOperator::BitwiseNegation,
		Rule::LogicalNegation => PrefixOperator::LogicalNegation,
		_ => todo!("{}", pair),
	};
	Ok(Expression::PrefixOperation(operator, Box::new(expression?)))
}

fn parse_infix_expression(
	lhs: std::io::Result<Expression>,
	pair: Pair<Rule>,
	rhs: std::io::Result<Expression>,
) -> std::io::Result<Expression> {
	let operator = match pair.as_rule() {
		Rule::Addition => InfixOperator::Addition,
		Rule::Subtraction => InfixOperator::Subtraction,
		Rule::Multiplication => InfixOperator::Multiplication,
		Rule::BitwiseConjunction => InfixOperator::BitwiseConjunction,
		Rule::BitwiseDisjunction => InfixOperator::BitwiseDisjunction,
		Rule::BitwiseExclusiveDisjunction => InfixOperator::BitwiseExclusiveDisjunction,
		Rule::BitwiseNegationDisjunction => InfixOperator::BitwiseNegationDisjunction,
		Rule::LogicalConjunction => InfixOperator::LogicalConjunction,
		Rule::LogicalDisjunction => InfixOperator::LogicalDisjunction,
		Rule::Equality => InfixOperator::Equality,
		Rule::Inequality => InfixOperator::Inequality,
		Rule::Less => InfixOperator::Less,
		Rule::LessEquality => InfixOperator::LessEquality,
		Rule::Greater => InfixOperator::Greater,
		Rule::GreaterEquality => InfixOperator::GreaterEquality,
		Rule::ArithmeticShiftRight => InfixOperator::ArithmeticShiftRight,
		Rule::ShiftLeft => InfixOperator::ShiftLeft,
		Rule::ShiftRight => InfixOperator::ShiftRight,
		Rule::RotateLeft => InfixOperator::RotateLeft,
		Rule::RotateRight => InfixOperator::RotateRight,
		_ => unreachable!(),
	};
	Ok(Expression::InfixOperation(
		operator,
		Box::new(lhs?),
		Box::new(rhs?),
	))
}

fn parse_global_declaration(pair: Pair<Rule>) -> Result<Vec<GlobalDeclaration>, std::io::Error> {
	let mut declarations = Vec::new();
	let mut arguments = pair.into_inner();
	let identifier_pairs = arguments.next().unwrap().into_inner();
	if let Some(constant_pairs) = arguments.next() {
		let constant_pairs = constant_pairs.into_inner();
		// TODO: a, b, c = 4, 5 // implicitly uninitialized c, or syntax error
		for (identifier, constant) in identifier_pairs.zip(constant_pairs) {
			declarations.push(GlobalDeclaration {
				name: identifier.as_str().to_string(),
				value: Some(parse_constant(constant)?),
			});
		}
	} else {
		for identifier in identifier_pairs {
			declarations.push(GlobalDeclaration {
				name: identifier.to_string(),
				value: None,
			});
		}
	}

	Ok(declarations)
}

fn parse_global_const(pair: Pair<Rule>) -> Result<Vec<Constant>, std::io::Error> {
	let mut constants = Vec::new();
	let mut arguments = pair.into_inner();
	let identifier_pairs = arguments.next().unwrap().into_inner();
	let constant_pairs = arguments.next().unwrap();
	let constant_pairs = constant_pairs.into_inner();
	for (identifier, constant) in identifier_pairs.zip(constant_pairs) {
		constants.push(Constant {
			name: identifier.as_str().to_string(),
			expression: constant.try_into()?,
		});
	}
	Ok(constants)
}

fn parse_constant(pair: Pair<Rule>) -> Result<u32, std::io::Error> {
	let pair = pair.into_inner().next().unwrap();
	match pair.as_rule() {
		Rule::Decimal => parse_decimal(pair),
		Rule::Hexadecimal => parse_hexadecimal(pair),
		Rule::Binary => parse_binary(pair),
		_ => unreachable!("{:?}", pair),
	}
}

fn parse_hexadecimal(pair: Pair<Rule>) -> std::io::Result<u32> {
	let value = i32::from_str_radix(&pair.as_str()[2..], 0x10).map_err(map_parse_error(pair))?;
	Ok((value << 8) as u32 >> 8)
}

fn parse_decimal(pair: Pair<Rule>) -> std::io::Result<u32> {
	let value = pair
		.as_str()
		.parse::<i32>()
		.map_err(map_parse_error(pair))?;
	Ok((value << 8) as u32 >> 8)
}

fn parse_binary(pair: Pair<Rule>) -> std::io::Result<u32> {
	let value = i32::from_str_radix(&pair.as_str()[2..], 0b10).map_err(map_parse_error(pair))?;
	Ok((value << 8) as u32 >> 8)
}

fn map_parse_error<E>(pair: Pair<Rule>) -> impl Fn(E) -> std::io::Error
where
	E: Into<Box<dyn Error + Send + Sync>>,
{
	let (line, column) = pair.line_col();
	let string = pair.as_str().to_string().clone();
	move |error| {
		std::io::Error::new(
			ErrorKind::InvalidInput,
			format!(
				"{}\n{}\nat line {}, column {}",
				error.into(),
				string,
				line,
				column
			),
		)
	}
}

fn get_context(pair: &Pair<Rule>) -> String {
	let input = pair.get_input();
	let lines = input.split("\n").collect::<Vec<_>>();
	let mut context = String::new();
	for i in -3..=3 {
		let line_index = pair.line_col().0 as isize + i - 1;
		if line_index >= 0 && (line_index as usize) < lines.len() {
			if i == 0 {
				context +=
					format!("{:4} > {}\n", line_index + 1, lines[line_index as usize]).as_str();
			} else {
				context +=
					format!("{:4} | {}\n", line_index + 1, lines[line_index as usize]).as_str();
			}
		}
	}
	context
}
