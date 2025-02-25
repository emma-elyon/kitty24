pub struct Program {
	pub statements: Vec<Statement>,
}

pub enum Statement {
	Instruction(Instruction),
	Label(Label),
	EndOfInput,
}

pub enum Instruction {
	Or(R),
	Nor(R),
	And(R),
	Xor(R),
	Add(R),
	Sub(R),
	Mul(R),
	ShiftLeft(RS),
	ShiftRight(RS),
	RotateLeft(RS),
	RotateRight(RS),
	ArithmeticShiftRight(RS),
	SignedLess(R),
	Less(R),
	If(IF),
	Let(I),
	Load(M),
	Store(M),
	Pop(M),
	Push(M),
	Data(Vec<u8>),
}

#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub enum Label {
	Global(String),
	Local(String),
}

pub struct I {
	pub destination: Register,
	pub immediate: IImmediate,
}

pub struct IF {
	pub destination: Register,
	pub immediate: IFImmediate,
}

pub struct M {
	pub destination: Register,
	pub source: Register,
	pub byte_count: u8,
	pub immediate: u16,
}

pub struct R {
	pub destination: Register,
	pub source: Register,
	pub target: Register,
	pub immediate: RImmediate,
}

pub struct RS {
	pub destination: Register,
	pub source: Register,
	pub target: Register,
	pub immediate: u8,
}

#[derive(Debug)]
pub enum IImmediate {
	Constant(u16),
	Label {
		label: Label,
		byte_index: u8,
		length: u8,
	},
}

pub enum IFImmediate {
	Constant(u16),
	Label(Label),
}

pub enum RImmediate {
	Constant(u8),
	Label { label: Label, byte_index: u8 },
}

pub enum Shift {
	ShiftLeft,
	ShiftRight,
	RotateLeft,
	RotateRight,
	ArithmeticShiftRight,
}

#[derive(Clone)]
pub enum Register {
	R0,
	R1,
	R2,
	R3,
	R4,
	R5,
	R6,
	R7,
	R8,
	R9,
	RA,
	RB,
	RC,
	RD,
	RE,
	RF,
}
