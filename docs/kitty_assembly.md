# Kitty24 Assembly

Arguments surrounded with `[]` are optional, and have default values given in
the instruction tables.

Parts of 24-bit label addresses can be referenced as `label[0:1]` for the upper
two bytes, `label[2]` for the lower byte, and so on.

For `if`, labels can be specified directly; `if r1, label`. This branches to
`label` within ~64 KiB of the instruction, if `r1 != 0`.


## I: Immediate 16-bit instructions

### Assembly format

`op register, immediate`.

Immediate is unsigned for `let`.

Immediate is signed for `if`, and can be a relative label.

### Assembly instruction

Instruction | Operation                | `[r0]`
------------|--------------------------|-------
`if  r, i`  | `PC <- PC + i if r != 0` | 1
`let  r, i` | `r <- i`                 | N/A

### Bit structure

`oooo rrrr iiiiiiiiiiiiiiii`.



## M: Memory access instructions

### Assembly format

`op register, [source,] [immediate,] [byte_count]`.

### Assembly defaults

* `source` defaults to destination `register` if omitted.
* `immediate` defaults to `0`.
* `byte_count` defaults to `3`, a full 24-bit word.

### Assembly instructions

Instruction       | Operation
------------------|-----------------
`ld   r, s, i, b` | `r <- [s + i]:b`
`st   r, s, i, b` | `[r + i]:b <- s`
`pop  r, s, i, b` | `r <- [s + i]:b`, `s <- s + b`
`push r, s, i, b` | `r <- r - b`, `[r + i]:b <- s`

`[address]:byte_count`: `byte_count` bytes in memory at `address`.

### Bit structure

TODO (is the immediate signed?)


## R: Register-Register instructions

### Assembly format

`op register, [source,] [target,] [immediate]`.

At least one of `source`, `target`, and `immediate` has to be present.

### Assembly defaults

* `source` defaults to destination `register` if omitted.
* `target` defaults to the ignored `r0` register if omitted.
* `immediate` defaults to the operation's identity, often `0`.

### Assembly instructions

Instruction       | Operation                     |  `[r0]` | `[i]`
------------------|-------------------------------|--------:|-------:
`or   r, s, t, i` | `r <- s \| t \| i`            |       0 |       0
`nor  r, s, t, i` | `r <- ~(s \| t \| i)`         |       0 |       0
`and  r, s, t, i` | `r <- s & t & i`              | $FFFFFF | $FFFFFF
`xor  r, s, t, i` | `r <- s ^ t ^ i`              |       0 |       0
`add  r, s, t, i` | `r <- s + t + i`              |       0 |       0
`sub  r, s, t, i` | `r <- s - t - i`              |       0 |       0
`mul  r, s, t, i` | `r <- s * t * i`              |       1 |       1
`shl  r, s, t, i` | `r <- s << t + i`             |       0 |       0
`shr  r, s, t, i` | `r <- s >> t + i`             |       0 |       0
`rotl r, s, t, i` | `r <- s <<< t + i`            |       0 |       0
`rotr r, s, t, i` | `r <- s >>> t + i`            |       0 |       0
`ashr r, s, t, i` | `r <- s ->> t + i`            |       0 |       0
`less r, s, t, i` | `r <- s < t + i`              |       0 |       0
`sles r, s, t, i` | `r <- s < t + i`, signed      |       0 |       0

* `<<<`: Rotate left
* `>>>`: Rotate right
* `->>`: Arithmetic (sign-extending) shift right

### Bit structure

For logic- and arithmetic instructions: `oooo rrrr ssss tttt iiiiiiii`.

For shift- and rotate instructions, the immediate is split into 3 bits `p` for
selecting the type of shift, followed by 5 bits `i` for unsigned shift amount:
`oooo rrrr ssss tttt ppp iiiii`,