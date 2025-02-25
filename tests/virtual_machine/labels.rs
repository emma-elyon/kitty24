use super::*;

#[test]
fn relative_global_label() -> Result<(), String> {
	assert_exit_code(
		r"
			let r1, 10
			main:
				sub r1, 1
                if r1, main
		",
		0,
	)
}

#[test]
fn relative_local_label() -> Result<(), String> {
	assert_exit_code(
		r"
			main:
			let r1, 50
            .loop:
				sub r1, 1
                if r1, .loop
            other:
			.loop:
				add r1, 1
				less r2, r1, 20
				if r2, .loop
		",
		20,
	)
}

#[test]
fn absolute_global_label() -> Result<(), String> {
	const OFFSET: usize = 0x123456;
	let mut source = String::new();
	for _ in 0..OFFSET {
		source += "or r0, r0, r0, 0\n";
	}
	let source = source
		+ r"
		let r1, main[0:1]
		shl r1, 8
		main:
		or  r1, main[2]
	";
	assert_exit_code(
		&source,
		PROLOGUE_BYTE_COUNT as i32 + 3 * OFFSET as i32 + 3 * 2,
	)
}

#[test]
fn absolute_global_label_with_three_bytes() -> Result<(), String> {
	let source = r"
		main:
		let rF, main[0:2]
	";
	assert_parse_errors(&source)
}

#[test]
fn absolute_local_label() -> Result<(), String> {
	const OFFSET: usize = 0x123456;
	let mut source = String::new();
	for _ in 0..OFFSET {
		source += "or r0, r0, r0, 0\n";
	}
	let source = source
		+ r"
		main:
		let r1, .loop[0:1]
		shl r1, 8
		.loop:
		or  r1, .loop[2]
	";
	assert_exit_code(
		&source,
		PROLOGUE_BYTE_COUNT as i32 + 3 * OFFSET as i32 + 3 * 2,
	)
}
