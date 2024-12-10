use super::*;

#[test]
fn signed_24() -> Result<(), String> {
    assert_exit_code(
		r"
			let r1, $8040
            shl r1, 8
            or  r1, $20
		",
        (0x804020 as i32) << 8 >> 8
	)
}
