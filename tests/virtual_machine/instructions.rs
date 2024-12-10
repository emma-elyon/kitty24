use super::*;

#[test]
fn or() -> Result<(), String> {
	assert_exit_code("or r1, r2, r4, %10101000", 2 | 4 | 0b10101000)
}

#[test]
fn nor() -> Result<(), String> {
	assert_exit_code("nor r1, r2, r4, %10101000", !(2 | 4 | 0b10101000))
}

#[test]
fn and() -> Result<(), String> {
	assert_exit_code("and r1, r2, r3, 56", 2 & 3 & 56)
}

#[test]
fn and_with_r0() -> Result<(), String> {
	assert_exit_code("and r1, r2, r0, 56", 2 & 56)
}

#[test]
fn and_with_0() -> Result<(), String> {
	assert_exit_code("and r1, r2, r3, 0", 2 & 3)
}

#[test]
fn and_with_ff() -> Result<(), String> {
	assert_exit_code(
		r"
			let r2, $4000
			and r1, r2, r3, $FF
		",
		0x4000 & 3 & 0xFF
	)
}

#[test]
fn and_with_fff() -> Result<(), String> {
	assert_exit_code(
		r"
			let r2, $FFF
			let r3, $FADE
			and r1, r2, r3, 0
		",
		0xADE
	)
}

#[test]
fn and_with_ffff() -> Result<(), String> {
	assert_exit_code(
		r"
			let r2, $F0F0
			shl r2, 8
			or  r2, $F0
			let r3, $FFFF
			and r1, r2, r3, 0
		",
		0xF0F0
	)
}

#[test]
fn xor() -> Result<(), String> {
	assert_exit_code("xor r1, r2, r3, 56", 2 ^ 3 ^ 56)
}

#[test]
fn add() -> Result<(), String> {
	assert_exit_code("add r1, r2, r3, 45", 2 + 3 + 45)
}

#[test]
fn add_with_overflow() -> Result<(), String> {
	assert_exit_code(
		r"
			let r2, $FFFF
			shl r2, 8
			let r3, $FFFF
			shl r3, 8
			add r1, r2, r3, 3
		",
		((0xFFFF00 + 0xFFFF00 + 3) & 0xFFFFFF) << 8 >> 8
	)
}

#[test]
fn add_with_signed() -> Result<(), String> {
	assert_parse_errors(
		r"
			let r2, $FFFF
			shl r2, 8
			or  r2, $FE
			let r3, $FFFF
			shl r3, 8
			or  r3, $FD
			add r1, r2, r3, -4
		"
	)
}

#[test]
fn add_with_unsigned() -> Result<(), String> {
	assert_exit_code("add r1, r2, r3, 234", 2 + 3 + 234)
}

#[test]
fn sub() -> Result<(), String> {
	assert_exit_code("sub r1, r2, r3, 4", 2 - 3 - 4)
}

#[test]
#[allow(overflowing_literals)]
fn sub_with_underflow() -> Result<(), String> {
	assert_exit_code(
		r"
			let r2, 0
			let r3, $FFFF
			shl r3, 8
			or  r3, $FF
			sub r1, r2, r3, 4
		",
		0 - ((0xFFFFFF as i32) << 8 >> 8) - 4
	)
}

#[test]
fn sub_with_signed() -> Result<(), String> {
	assert_parse_errors(
		r"
			let r2, $FFFF
			shl r2, 8
			or  r2, $FE
			let r3, $FFFF
			shl r3, 8
			or  r3, $FD
			sub r1, r2, r3, -4
		"
	)
}

#[test]
fn sub_with_unsigned() -> Result<(), String> {
	assert_exit_code("sub r1, r2, r3, 234", 2 - 3 - 234)
}

#[test]
fn mul() -> Result<(), String> {
	assert_exit_code("mul r1, r2, r3, 45", 2 * 3 * 45)
}

#[test]
#[allow(arithmetic_overflow)]
fn mul_with_overflow() -> Result<(), String> {
	assert_exit_code(
		r"
			let r2, $8000
			let r3, $8000
			mul r1, r2, r3, $80
		",
		(0x8000 * 0x8000 * 0x80) & 0xFFFFFF
	)
}

#[test]
fn mul_with_signed() -> Result<(), String> {
	assert_parse_errors(
		r"
			let r2, $FFFF
			shl r2, 8
			or  r2, $FE
			let r3, $FFFF
			shl r3, 8
			or  r3, $FD
			mul r1, r2, r3, -4
		"
	)
}

#[test]
fn shl() -> Result<(), String> {
	assert_exit_code("shl r1, r2, r3, 4", 2 << 3 + 4)
}

#[test]
fn shl_with_signed() -> Result<(), String> {
	assert_parse_errors("shl r1, r2, r3, -4")
}

#[test]
fn shr() -> Result<(), String> {
	assert_exit_code("shr r1, rD, r2, 1", 0xD >> 2 + 1)
}

#[test]
fn rotl() -> Result<(), String> {
	let n = 8;
	let r = 3;
	let i = 30;
	assert_exit_code("rotl r1, r8, r3, 30", n << ((r + i) % 24) | n >> (24 - (r + i) % 24))
}

#[test]
fn rotr() -> Result<(), String> {
	let n = 8;
	let r = 3;
	let i = 30;
	assert_exit_code("rotr r1, r8, r3, 30", n >> ((r + i) % 24) | n << (24 - (r + i) % 24))
}

#[test]
fn ashr() -> Result<(), String> {
	assert_exit_code(
		r"
			let  rD, $FFFF
			shl  rD, 8
			ashr r1, rD, 4
		",
		-256 >> 4,
	)
}

#[test]
fn less() -> Result<(), String> {
	assert_exit_code("less r1, r5, r4, 2", 1)
}

#[test]
fn less_with_greater() -> Result<(), String> {
	assert_exit_code("less r1, r5, r4, 0", 0)
}

#[test]
fn less_with_sign_bit() -> Result<(), String> {
	assert_exit_code(
		r"
			let  r2, $FFFF
			shl  r2, 8
			less r1, r2, r3, 0
		",
		0
	)
}

#[test]
fn sles() -> Result<(), String> {
	assert_exit_code("sles r1, r5, r4, 2", 1)
}

#[test]
fn sles_with_greater() -> Result<(), String> {
	assert_exit_code("sles r1, r5, r4, 0", 0)
}

#[test]
fn sles_with_sign_bit() -> Result<(), String> {
	assert_exit_code(
		r"
			let  r2, $FFFF
			shl  r2, 8
			sles r1, r2, r3, 0
		",
		1
	)
}

#[test]
fn if_() -> Result<(), String> {
    assert_exit_code(
		r"
			let r1, 2
            if  r1, 6
            let r1, 3
		",
        2
	)
}

#[test]
fn if_with_zero() -> Result<(), String> {
    assert_exit_code(
		r"
			let r1, 0
            if  r1, 6
            let r1, 3
		",
        3
	)
}

#[test]
fn if_with_default() -> Result<(), String> {
    assert_exit_code(
		r"
			let r1, 2
            if  6
            let r1, 3
		",
        2
	)
}

#[test]
fn let_() -> Result<(), String> {
	assert_exit_code("let r1, 256", 256)
}

#[test]
fn let_with_signed() -> Result<(), String> {
	assert_parse_errors("let r1, -1")
}

#[test]
fn let_with_unsigned() -> Result<(), String> {
	assert_exit_code("let r1, $FF00", 0xFF00)
}

#[test]
fn load_store() -> Result<(), String> {
    assert_exit_code(
		r"
			let r2, $4243
			shl r2, 8
			or  r2, $44
            let rD, $8000
            st  rD, r2
            ld  r1, rD
		",
        0x424344
	)
}

#[test]
fn load_store_with_default() -> Result<(), String> {
    assert_exit_code(
		r"
			let r2, $4243
			shl r2, 8
			or  r2, $44
            let rD, $8000
            st  rD, r2
            ld  rD
			or  r1, rD
		",
		0x424344
	)
}

#[test]
fn load_store_with_offset() -> Result<(), String> {
    assert_exit_code(
		r"
			let r2, $4243
			shl r2, 8
			or  r2, $44
            let rD, $8000
            st  rD, r2, 15
			add rD, 3
            ld  r1, rD, 12
		",
		0x424344
	)
}

#[test]
fn load_store_with_signed_offset() -> Result<(), String> {
    assert_exit_code(
		r"
			let r2, $4243
			shl r2, 8
			or  r2, $44
            let rD, $8000
            st  rD, r2, -15
			add rD, 3
            ld  r1, rD, -18
		",
		0x424344
	)
}

#[test]
fn load_store_with_byte_count() -> Result<(), String> {
    assert_exit_code(
		r"
			let r2, $4243
			shl r2, 8
			or  r2, $44
            let rD, $8000
            st  rD, r2, 0, 2
            ld  r1, rD, 0, 2
		",
        0x4344
	)
}

#[test]
fn push_pop() -> Result<(), String> {
    assert_exit_code(
		r"
			let  r2, $4243
			shl  r2, 8
			or   r2, $44
            let  rD, $8000
            push rD, r2
            pop  r1, rD
		",
		0x424344
	)
}

#[test]
fn push_pop_with_default() -> Result<(), String> {
    assert_exit_code(
		r"
			let  r2, $4243
			shl  r2, 8
			or   r2, $44
            let  rD, $8000
            push rD, r2
            pop  rD
			or   r1, rD
		",
		0x424344 + 3
	)
}

#[test]
fn push_pop_with_offset() -> Result<(), String> {
    assert_exit_code(
		r"
			let  r2, $4243
			shl  r2, 8
			or   r2, $44
            let  rD, $8000
            push rD, r2, 15
			add  rD, 3
            pop  r1, rD, 12
		",
		0x424344
	)
}

#[test]
fn push_pop_with_byte_count() -> Result<(), String> {
    assert_exit_code(
		r"
			let  r2, $4243
			shl  r2, 8
			or   r2, $44
            let  rD, $8000
            push rD, r2, 15, 2
			add  rD, 3
            pop  r1, rD, 12, 2
		",
        0x4344
	)
}