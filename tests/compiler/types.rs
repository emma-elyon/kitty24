use super::assert_exit_codes;

#[test]
fn u8_type() {
	let source = r"
		main() {
			let a: u8 = 255
			let b: u8 = 1
			a, b
		}
	";
	assert_exit_codes(source, &[255, 1])
}

#[test]
#[should_panic]
fn u8_i8_type_error() {
	let source = r"
		main() {
			let a: u8 = 255
			let b: i8 = -1
			a + b
		}
	";
	assert_exit_codes(source, &[254])
}