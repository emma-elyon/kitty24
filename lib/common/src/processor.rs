const OR: u8 = 0x0;
const NOR: u8 = 0x1;
const AND: u8 = 0x2;
const XOR: u8 = 0x3;
const ADD: u8 = 0x4;
const SUB: u8 = 0x5;
const MUL: u8 = 0x6;
const SHIFT: u8 = 0x7;
const LESS: u8 = 0x8;
const SIGNED_LESS: u8 = 0x9;
const IF: u8 = 0xA;
const LET: u8 = 0xB;
const LOAD: u8 = 0xC;
const STORE: u8 = 0xD;
const POP: u8 = 0xE;
const PUSH: u8 = 0xF;

#[derive(Clone, Debug, PartialEq, Eq, Hash)]
/// Operations numbered by opcode.
pub enum Op {
    Or,
	Nor,
	And,
	Xor,
	Add,
	Sub,
	Mul,
	Shift,
	Less,
	SignedLess,
	If,
	Let,
	Load,
	Store,
	Pop,
	Push,
}

impl From<u8> for Op {
    fn from(value: u8) -> Self {
		match value {
			OR => Op::Or,
			NOR => Op::Nor,
			AND => Op::And,
			XOR => Op::Xor,
			ADD => Op::Add,
			SUB => Op::Sub,
			MUL => Op::Mul,
			SHIFT => Op::Shift,
			LESS => Op::Less,
			SIGNED_LESS => Op::SignedLess,
			IF => Op::If,
			LET => Op::Let,
			LOAD => Op::Load,
			STORE => Op::Store,
			POP => Op::Pop,
			PUSH => Op::Push,
			// TODO: Determine performance impact of this panic.
			_ => panic!("Unknown opcode: {}", value)
		}
    }
}

impl From<Op> for u8 {
    fn from(value: Op) -> Self {
		match value {
			Op::Or => OR,
			Op::Nor => NOR,
			Op::And => AND,
			Op::Xor => XOR,
			Op::Add => ADD,
			Op::Sub => SUB,
			Op::Mul => MUL,
			Op::Shift => SHIFT,
			Op::Less => LESS,
			Op::SignedLess => SIGNED_LESS,
			Op::If => IF,
			Op::Let => LET,
			Op::Load => LOAD,
			Op::Store => STORE,
			Op::Pop => POP,
			Op::Push => PUSH,
		}
    }
}