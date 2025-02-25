use super::assert_exit_codes;

#[test]
fn operator_unary_boolean_negation() {
    let source = r#"
        main() {
			let foo, bar, baz = 0, 1, 2
            !foo, !bar, !baz
		}
	"#;
    assert_exit_codes(source, &[1, 0, 0]);
}

#[test]
fn operator_binary_and() {
    let source = r#"
        main() {
			let foo = 0xF0D0D0
			foo, foo & 0xFFFF
		}
	"#;
    assert_exit_codes(source, &[0xF0D0D0, 0xD0D0]);
}
