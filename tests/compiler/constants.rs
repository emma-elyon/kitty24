use super::assert_exit_codes;

#[test]
fn constant_value() {
    let source = r"
		const X = 44
		const Y, Z = 5, -4

		main() {
			let a = X - Y - Z - 1
			a
		}
	";
    assert_exit_codes(source, &[42]);
}

#[test]
fn constant_expression() {
    let source = r"
		const X = 44
		const Y, Z = 5, 4 - X

		main() {
			let a = X - Y - Z - 1
			let b = a + X
			b
		}
	";
    assert_exit_codes(source, &[44 - 5 + 40 - 1 + 44]);
}
