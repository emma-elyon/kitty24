# Kitty24 Script

Programming Language for the Kitty24 fantasy console.

Functionality inspired by C, syntax inspired by Rust.



## Literals

Literals are 24-bit signed integers.

* `42` (decimal)
* `0xD983` (hexadecimal)
* `0b10101111` (binary)



## Constants

Constants in the global scope can either be defined directly, or in terms of
other constants.

* `const QUESTION = 42`
* `const ANSWER = QUESTION * 6 * 7`



## Variables

To declare a variable, use `let`:

```rust
let x = ANSWER
let y = x + 320
```

Declaring a variable shadows it in the current scope:

```rust
let x = 3
let y = 4
let y = y * y
{
	let x = 4
	let z = x // 4
}
let z = x // 3
```

To assign a value to an existing variable, omit the `let`:

```rust
let y = 4
y = y * 12 - 6 // y = 42
```



## Memory access

Access memory directly with absolute addresses:

```rust
let pixels_addr = 0x800000
[0xFF0000] = [pixels_addr]
[0xFF0001] = [pixels_addr + 1]
```

Any expression is a valid memory address.

Up to three bytes (24 bits) can be loaded or stored at the same time:

```rust
let midi = (256 << 8) + x
[0xFE0002]:2 = midi

let first_three_pixels = [0xFF0000]:3
```



## Conditionals

The keywords `if` and `else` are used to manage control flow:

```rust
if x > 42 {
	x = 42
} else {
	x = x + 1
}
```

An `if`-`else`-block is itself and expression with the value of the last
expression in whichever branch was selected:

```rust
let new_x = if x < 320 {
	0
} else {
	x - 320
}
```


## Loops

The keyword `while` defines a loop:

```rust
let x = 0
let y = 1
while x < 12 {
	y = y * 2
	x = x + 1
}
```



## Functions

Functions are declared with a name and optional parameters. The last expression
of the function is returned:

```rust
square(n) {
	n * n
}
```

Advanced: functions can also be written directly in assembly by using the `asm`
keyword:

```rust
square(n) asm {
	ld r1, rB
	mul r1, r1, r1
}
```



## Multiple expressions

Multiple expressions can be assigned to multiple variables:

```rust
let x, y = ANSWER, 32
```

Functions and conditionals can also return multiple expressions:

```rust
let div, mod = divmod(x, 7)
let dx, dy, dz = if x < 0 {
	-1, 0, 1
} else {
	1, 10, 100
}
```



## Interrupts

An interrupt handler function  for a specific interrupt can be defined by using
the interrupt ID, followed by `!`:

```rust
4!() {
	[0xFE0000] = x
}
```

The interrupt ID can be any constant expression:

```rust
VERTICAL_BLANK!() {
	[0xFE0000] = x
}
```

Some interrupts provide optional arguments:

```rust
KEY_DOWN!(code) {
	if code == 65 {
		x = x - 1
	}
	if code == 68 {
		x = x + 1
	}
}
```