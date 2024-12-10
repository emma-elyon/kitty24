use super::assert_exit_codes;

#[test]
fn function_parameters() {
	let source = r"
		add(a, b) {
			a + b
		}

		main() {
			add(5, five())
		}
		
		five {
			5
		}
	";
	assert_exit_codes(source, &[10]);
}
