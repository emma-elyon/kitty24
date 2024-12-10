use super::assert_exit_codes;

#[test]
fn break_script() {
    let source = r"
		main() {
			let foo = 0
			while foo < 100 {
				if foo == 42 {
					break
				}
				foo = foo + 1
			}
			foo
		}
	";
    assert_exit_codes(source, &[42])
}

#[test]
fn break_label_script() {
	let source = r"
		main() {
			let foo = 0
			let bar = 12
			outer while foo < 100 {
				bar = 12
				while bar < 200 {
					bar = bar * bar
					if foo == 42 {
						break outer
					}
				}
				bar = bar * 3
				foo = foo + 1
			}
			foo, bar
		}
	";
	assert_exit_codes(source, &[42, 144])
}

#[test]
fn continue_script() {
	let source = r"
		main() {
			let foo = 0
			let bar = 0
			while foo < 100 {
				foo = foo + 1
				if bar > 41 {
					continue
				}
				bar = bar + 1
			}
			bar
		}
	";
	assert_exit_codes(source, &[42])
}

#[test]
fn continue_label_script() {
	let source = r"
		main() {
			let foo = 0
			let bar = 0
			outer while foo < 100 {
				foo = foo + 1
				while bar > 41 {
					continue outer
				}
				bar = bar + 1
			}
			bar
		}
	";
	assert_exit_codes(source, &[42])
}

#[test]
fn return_script() {
	let source = r"
		add(a, b) {
			if a > b {
				return 42
			} else {
				return a + b
			}
		}
		main() {
			let x = add(3, 4)
			if x > 6 {
				return 100 - x
			}
			return x
		}
	";
	assert_exit_codes(source, &[93])
}

#[test]
fn return_multiple_script() {
	let source = r"
		mix(a, b) {
			if a > b {
				return 42
			} else {
				return a + b
			}
		}
		main() {
			let x = mix(3, 4)
            let y = mix(4, 3)
			if x > 6 {
				return 100 - x, y
			}
			return x, 100 - y
		}
	";
	assert_exit_codes(source, &[93, 42])
}

#[test]
fn nested_if_script() {
	let source = r"
		main() {
			let x = 44
			if x > 0 {
				let y = 3
				if y > 0 {
					y = y - 1
				}
				x = x - y
			}
			x
		}
	";
	assert_exit_codes(source, &[42]);
}

#[test]
fn if_else_if_script() {
    let source = r"
		main() {
			let x = 46
            let y = 0
			if x < 40 {
				y = 3
            } else if x < 45 {
				y = 5
			} else if x < 50 {
				y = 4
			} else {
				y = 6
			}
            x - y
		}
    ";
    assert_exit_codes(source, &[42])
}

#[test]
fn nested_if_else_if_script() {
    let source = r"
        main() {
            let x, y = 46, 0
            if x < 40 {
                y = 3
            } else if x < 50 {
                if x < 43 {
                    y = 5
                } else if x < 47 {
                    y = 4
                } else {
                    y = 6
                }
            } else {
                y = 5
            }
            x - y
		}
    ";
    assert_exit_codes(source, &[42])
}

#[test]
fn nested_while_script() {
	let source = r"
		main() {
			let x = 2
			while x > 0 {
				let y = 3
				while y > 0 {
					y = y - 1
				}
				x = x - 1
			}
			42
		}
	";

	assert_exit_codes(source, &[42]);
}

#[test]
fn local_variable_script() {
	let source = r"
		main() {
			let b = 21
			b
		}
	";

	assert_exit_codes(source, &[21]);
}

#[test]
fn recursion_script() {
	let source = r"
		fib(n) {
			if n == 0 || n == 1 {
				n
			} else {
				fib(n - 1) + fib(n - 2)
			}
		}

		main() {
			fib(8)
		}
	";

	assert_exit_codes(source, &[21]);
}

#[test]
fn vblank_script() {
	let source = r"
		let b = 1
		let c = 2

		main() {
			while b {
				c = 3
			}
			42, c
		}
		
		VBLANK!() {
			b = 0
		}
	";

	assert_exit_codes(source, &[42, 3]);
}

#[test]
fn logical_conjunction_script() {
	let source = r"
		main() {
			let b = 43
			let c = 44
			let d = 45
			let e = 46
			let f = 47
			let g = 48
			if 1 && 2 && 0 {
				b = b - 1
			}
			if 1 && 2 && 3 {
				c = c - 2
			}
			if 0 && 1 && 2 {
				d = d - 3
			}
			if 1 && 0 && 2 {
				e = e - 4
			}
			if 1 && 0 {
				f = f - 5
			}
			if 0 && 1 {
				g = g - 6
			}
			b, c, d, e, f, g
		}
	";

	assert_exit_codes(source, &[43, 42, 45, 46, 47, 48]);
}

#[test]
fn memory_direct_script() {
	let source = r"
		main() {
			[16384] = 240
			let b = [16384]
			b
		}
	";

	assert_exit_codes(source, &[240]);
}

#[test]
fn less_comparison_script() {
	let source = r"
		main() {
			2 < 3, 3 < 2, 2 <= 3, 3 <= 2, 3 <= 3
		}
	";

	assert_exit_codes(
		source,
		&[
			(2 < 3) as u32,
			(3 < 2) as u32,
			(2 <= 3) as u32,
			(3 <= 2) as u32,
			(3 <= 3) as u32,
		]
	);
}

#[test]
fn greater_comparison_script() {
	let source = r"
		main() {
			2 > 3, 3 > 2, 2 >= 3, 3 >= 2, 3 >= 3
		}
	";

	assert_exit_codes(
		source,
		&[
			(2 > 3) as u32,
			(3 > 2) as u32,
			(2 >= 3) as u32,
			(3 >= 2) as u32,
			(3 >= 3) as u32,
		]
	);
}

#[test]
fn equals_comparison_script() {
	let source = r"
		main() {
			2 == 3, 3 == 2, 3 == 3, 2 != 3, 3 != 2, 3 != 3
		}
	";

	assert_exit_codes(
		source,
		&[
			(2 == 3) as u32,
			(3 == 2) as u32,
			(3 == 3) as u32,
			(2 != 3) as u32,
			(3 != 2) as u32,
			(3 != 3) as u32,
		]
	);
}

#[test]
fn function_return_script() {
	let source = r"
		main() {
			let c, d = 35, 7
			let e = add(c, d)
			e
		}
		
		add(a, b) {
			a + b
		}
	";
	
	assert_exit_codes(source, &[42])
}

#[test]
fn function_return_multiple_script() {
	let source = r"
		main() {
			let c, d = 35, 7
			let e, f = add_sub(c, d)
			e, f
		}
		
		add_sub(a, b) {
			a + b, a - b
		}
	";
	
	assert_exit_codes(source, &[42, 28])
}

#[test]
fn assembly_arguments_script() {
	let source = r"
		main() {
			let c = sub_asm(49, 7)
			c
		}
		
		sub_asm(a, b) asm {
			ld   r2, rB, 3
			ld   r1, rB, 0
			sub  r1, r1, r2
		}
	";
	
	assert_exit_codes(source, &[42])
}