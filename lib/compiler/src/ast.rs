pub struct Program {
	pub namespaces: Vec<Namespace>,
	pub script_functions: Vec<Function>,
	pub assembly_functions: Vec<AssemblyFunction>,
	pub interrupt_handlers: Vec<InterruptHandler>,
	pub declarations: Vec<GlobalDeclaration>,
	pub constants: Vec<Constant>,
}

pub struct Namespace {
	pub name: String,
	pub script_functions: Vec<Function>,
	pub assembly_functions: Vec<AssemblyFunction>,
	pub declarations: Vec<GlobalDeclaration>,
	pub constants: Vec<Constant>,
}

pub struct Function {
	pub name: String,
	pub parameters: Parameters,
	pub block: Block,
}

pub struct AssemblyFunction {
	pub name: String,
	pub parameters: Parameters,
	pub assembly: String,
}

pub struct InterruptHandler {
	pub interrupt: Interrupt,
	pub parameters: Parameters,
	pub block: Block,
}

pub struct Parameters(pub Vec<String>);

#[derive(Clone, Debug)]
pub struct Declarations(pub Vec<String>);

#[derive(Clone, Debug)]
pub struct Expressions(pub Vec<Expression>);

#[derive(Clone, Debug)]
pub struct References(pub Vec<String>);

pub struct GlobalDeclaration {
	pub name: String,
	pub value: Option<u32>,
}

pub struct Constant {
	pub name: String,
	pub expression: Expression,
}

#[derive(Clone, Debug)]
pub struct Block {
	pub statements: Vec<Statement>,
}

#[derive(Clone, Debug)]
pub struct ElseIf {
	pub predicate: Expression,
	pub block: Block,
}

#[derive(Clone, Debug)]
pub enum Statement {
	Assignment(References, Expressions),
	Break(Option<String>),
	Continue(Option<String>),
	Block(Block),
	While(Option<String>, Expression, Block),
	Loop(Block),
	Declaration(Declarations),
	Definition(Declarations, Expressions),
	ExpressionList(Expressions),
	Label(String),
	Goto(String),
	Return(Expressions),
	Store(Expression, u8, Expression), // TODO: ExpressionList <=> ExpressionList?
}

#[derive(Clone, Debug)]
pub enum Expression {
	Constant(u32),
	Load(Box<Expression>, u8),
	Variable(String),
	Conditional(Box<Expression>, Block, Option<Block>),
	ConditionalMultiple(Box<Expression>, Block, Vec<ElseIf>, Option<Block>),
	Call(String, Vec<Expression>),
	StringLiteral(String),
	CharacterLiteral(u32),
	PrefixOperation(PrefixOperator, Box<Expression>),
	InfixOperation(InfixOperator, Box<Expression>, Box<Expression>),
}

#[derive(Clone, Debug)]
pub enum PrefixOperator {
	ArithmeticNegation,
	BitwiseNegation,
	LogicalNegation,
}

#[derive(Clone, Debug)]
pub enum InfixOperator {
	Addition,
	Subtraction,
	Multiplication,
	BitwiseConjunction,
	BitwiseDisjunction,
	BitwiseExclusiveDisjunction,
	BitwiseNegationDisjunction,
	LogicalConjunction,
	LogicalDisjunction,
	Equality,
	Inequality,
	Less,
	LessEquality,
	Greater,
	GreaterEquality,
	ArithmeticShiftRight,
	ShiftLeft,
	ShiftRight,
	RotateLeft,
	RotateRight,
}

pub enum Interrupt {
	Constant(u8),
	Identifier(String),
}

pub trait Cardinal {
	fn cardinality(&self) -> usize;
}

impl Cardinal for Block {
	fn cardinality(&self) -> usize {
		if let Some(statement) = self.statements.last() {
			statement.cardinality()
		} else {
			0
		}
	}
}

impl Cardinal for Statement {
	fn cardinality(&self) -> usize {
		match self {
			Statement::Declaration(_) => 0,
			Statement::Definition(_, _) => 0,
			Statement::Assignment(_, _) => 0, // TODO: maybe assignments also return values?
			Statement::Label(_) => 0,
			Statement::Goto(_) => 0,
			Statement::Store(_, _, _) => 0,
			Statement::While(_, _, _) => 0, // TODO: maybe loops also return values?
			Statement::Loop(_) => 0,        // TODO: maybe loops also return values?
			Statement::Block(block) => block.cardinality(),
			Statement::ExpressionList(expressions) => {
				let mut cardinality = 0;
				for expression in &expressions.0 {
					cardinality += expression.cardinality()
				}
				cardinality
			}
			Statement::Return(expressions) => {
				let mut cardinality = 0;
				for expression in &expressions.0 {
					cardinality += expression.cardinality()
				}
				cardinality
			}
			Statement::Break(_) => 0,
			Statement::Continue(_) => 0,
		}
	}
}

impl Cardinal for Expression {
	fn cardinality(&self) -> usize {
		match self {
			Expression::Constant(_) => 1,
			Expression::Load(_, _) => 1,
			Expression::Variable(_) => 1,
			Expression::Conditional(_, positive, negative) => positive.cardinality().min(
				negative
					.clone()
					.map(|negative| negative.cardinality())
					.or(Some(0))
					.unwrap(),
			),
			Expression::ConditionalMultiple(_, positive, _nested, negative) =>
			// TODO: Nested cardinality
			{
				positive.cardinality().min(
					negative
						.clone()
						.map(|negative| negative.cardinality())
						.or(Some(0))
						.unwrap(),
				)
			}
			// FIXME: Functions don't know how many values they return, so just
			// go through all of them
			Expression::Call(_, _) => usize::MAX,
			Expression::PrefixOperation(_, _) => 1,
			// TODO: Support `{ 1, 2 } * { 2, 3 } = { 2, 6 }
			// TODO: Support `{ 1, 2 } * 3 = { 3, 6 }
			// TODO: Support `2 * { 2, 3 } = { 4, 6 }
			Expression::InfixOperation(_, _, _) => 1,
			Expression::StringLiteral(_) => 1,
			Expression::CharacterLiteral(_) => 1,
		}
	}
}
