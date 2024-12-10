use super::assert_exit_codes;

#[test]
fn allocate_call() {
	let source = r"
        main() {
			init_allocator()
			let foo = 'ABC'
			let bar = 'DEF'
			let ptr = allocate(1000)
			let ptr2 = allocate(6)
			let ptr3 = allocate(6)
			if ptr > 0 {
				[ptr + 0]:3 = foo
				[ptr + 3]:3 = bar
			}
			if ptr2 > 0 {
				[ptr2 + 0]:3 = bar
				[ptr2 + 3]:3 = foo
			}
			[ptr + 0]:3, [ptr + 3], [ptr + 4], [ptr + 5], [ptr2]:3, ptr2 - ptr, ptr3 - ptr2
		}
	";
	assert_exit_codes(source, &[0x414243, 0x44, 0x45, 0x46, 0x444546, 1024, 8])
}

#[test]
fn allocate_lots() {
	let source = r"
        main() {
			init_allocator()
			let a = allocate(6)
			let i = 0
			while i < 64 {
				let c = allocate(6)
				if c == 0 {
					return 42
				}
				i = i + 1
			}
			let b = allocate(6)
			a, b - a
		}
	";
	assert_exit_codes(source, &[0x800001, 8 + 64 * 8])
}

#[test]
fn deallocate_call() {
	let source = r"
		main() {
			init_allocator()
			let foo = 'ABC'
			let ptr = allocate(3)
			if ptr != 0 {
				let result = deallocate(ptr, 3)
				if result != 0 {
					return result
				}
			}
			let ptr2 = allocate(3)
			let ptr3 = allocate(6)
			ptr2 == ptr, ptr2 + 3 == ptr3
		}
	";
	assert_exit_codes(source, &[1, 1])
}

#[test]
fn allocate_deallocate_lots() {
	let source = r"
		main() {
			init_allocator()
			let i = 1
			let pre = allocate(1)
			[pre] = 0xDE
			while i < 1024 * 1024 {
				let ptr = allocate(i)
				deallocate(ptr)
				i = i * 2
			}
			let post = allocate(1)
			[post] = 0xAD
			[pre], [post], i, post - pre
		}
	";
	assert_exit_codes(source, &[0xDE, 0xAD, 1024 * 1024, 1 + 1])
}

#[test]
fn allocate_deallocate_list() {
	let source = r"
		let list = 0
		main() {
			init_allocator()
			list = allocate(256 * 3)
			[list]:3 = 0
			let i = 1
			let pre = allocate(1)
			[pre] = 0xDE
			while i < 256 {
				let rand = hash(i)
				let ptr = allocate(rand & 0xFFF)
				[list + 3 + i * 3]:3 = ptr
				i = i * 2
			}
			let i = 255
			while i < 256 {
				let ptr = [list + 3 + i * 3]:3
				deallocate(ptr)
				i = i - 1
			}
			let post = allocate(1)
			[post] = 0xAD
			[pre], [post], i, post - pre
		}
	";
	assert_exit_codes(source, &[0xDE, 0xAD, 0xFFFFFF, 1 + 1])
}

#[test]
fn deallocate_merge() {
	let source = r"
		main() {
			init_allocator()
			let i = 0
			let a = allocate(1)
			deallocate(a)
			let b = allocate(256)
			deallocate(b)
			let c = allocate(65536)
			// b - a
			a, b, b - a, a == b, a == c
		}
	";
	assert_exit_codes(source, &[0x800001, 0x800001, 0, 1, 1])
}