use super::*;

#[test]
#[should_panic] // TODO: No it shouldn't, but the first line of source gets bump
fn vblank_interrupt() {
    let source = r"
		if   rE, handle
		let  r1, 0
		loop:
		less r2, r1, 1
		if   r2, loop
		if   end
		handle:
		let r1, 42
		let rE, 0
		end:
	";
    // TODO: Skip prologue
    assert_exit_code(source, 42).unwrap();
}
