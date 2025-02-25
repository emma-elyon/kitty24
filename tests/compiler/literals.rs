use super::assert_exit_codes;

#[test]
fn decimal_literal() {
	let source = r"
		const X = 20

		main() {
			let a = 20 + X
			a + 2
		}
	";
	assert_exit_codes(source, &[42]);
}

#[test]
fn hexadecimal_literal() {
	let source = r"
		const X = 0x20

		main() {
			let a = 0x20 + X
			a + 0x2
		}
	";
	assert_exit_codes(source, &[0x20 + 0x20 + 2]);
}

#[test]
fn binary_literal() {
	let source = r"
		const X = 0b10

		main() {
			let a = 0b10 + X
			a + 0b1
		}
	";
	assert_exit_codes(source, &[0b10 + 0b10 + 1]);
}

#[test]
fn string_literal() {
	let source = r#"
        main() {
			let foo = "ABC"
            [foo], [foo + 1], [foo + 2]
		}
	"#;
	assert_exit_codes(source, &[0x41, 0x42, 0x43]);
}

#[test]
fn character_literal() {
	let source = r#"
        main() {
			let foo, bar, baz = 'A', 'B', 'C'
            foo, bar, baz
		}
	"#;
	assert_exit_codes(source, &[0x41, 0x42, 0x43]);
}

#[test]
fn characters_literal() {
	let source = r#"
        main() {
			let foo = 'ABC'
			let bar = 'DEF'
            foo, bar
		}
	"#;
	assert_exit_codes(source, &[0x414243, 0x444546]);
}
