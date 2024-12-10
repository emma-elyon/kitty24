use super::*;

#[test]
fn r_instruction_r_r_r_i() -> Result<(), String> {
	assert_exit_code("sub r1, r2, r5, 12", 2 - 5 - 12)
}

#[test]
fn r_instruction_r_r_r() -> Result<(), String> {
	assert_exit_code("sub r1, r2, r5", 2 - 5)
}

#[test]
fn r_instruction_r_r_i() -> Result<(), String> {
	assert_exit_code("sub r1, r2, 3", 2 - 3)
}

#[test]
fn r_instruction_r_r() -> Result<(), String> {
	assert_exit_code("sub r1, r7", 7)
}

#[test]
fn r_instruction_r_i() -> Result<(), String> {
	assert_exit_code("sub r1, 2", 1 - 2)
}

#[test]
fn r_instruction_r() -> Result<(), String> {
	assert_parse_errors("sub r1")
}

#[test]
fn r_instruction_i() -> Result<(), String> {
	assert_parse_errors("sub 1")
}
