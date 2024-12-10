use super::assert_exit_codes;

#[test]
fn namespace_function() {
	let source = r"
		foo {
			bar() {
				foo::baz()
			}
			
			baz() {
				42
			}
		}
	
		main() {
			foo::bar()
		}
	";
	assert_exit_codes(source, &[42])
}

#[test]
fn namespace_constant() {
	let source = r"
		foo {
			const BAR = 42
		}
	
		main() {
			foo::BAR
		}
	";
	assert_exit_codes(source, &[42])
}

#[test]
fn namespace_global() {
	let source = r"
		foo {
			let bar = 41
		}
	
		main() {
			foo::bar = foo::bar + 1
			foo::bar
		}
	";
	assert_exit_codes(source, &[42])
}