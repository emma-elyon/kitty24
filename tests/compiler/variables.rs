use super::assert_exit_codes;

#[test]
fn constant_value() {
	let source = r"
		main() {
			let a = -1
			a
		}
	";
	assert_exit_codes(source, &[0xFFFFFF]);
}
