; jump to event handler if not booting
if   rE, __interrupt

; set up main return address
let  rA, $FFFF
shl  rA, 8
or   rA, $FF

let  rC, $F800
shl  rC, 8
or   rC, $00

; jump to main
let  rD, main[0:1]
shl  rD, 8
or   rF, rD, main[2]

; delegate events
__interrupt:
let  rD, __handle_interrupt[0:1]
shl  rD, 8
or   rF, rD, __handle_interrupt[2]
__var_0:
data
000000
math::sin8:
	or   rB, rC ; reset stack base pointer


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	ld   r1, rB, 0 ; x
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	and  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 1
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
math::init_sin8:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	add  rA, rF, 9
	let  rD, mem::init_allocator[0:1]
	shl  rD, 8
	or   rF, rD, mem::init_allocator[2]
	add  rC, 0
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	push rC, rB
	push rC, rA
	let  r1, $1 ; 256
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, mem::allocate[0:1]
	shl  rD, 8
	or   rF, rD, mem::allocate[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	let  rD, __var_0[0:1]
	shl  rD, 8
	or   rD, __var_0[2]
	st   rD, r1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 128
	shl  r1, 8
	or   r1, $80
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 131
	shl  r1, 8
	or   r1, $83
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 134
	shl  r1, 8
	or   r1, $86
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 137
	shl  r1, 8
	or   r1, $89
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 140
	shl  r1, 8
	or   r1, $8C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 143
	shl  r1, 8
	or   r1, $8F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 146
	shl  r1, 8
	or   r1, $92
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 7
	shl  r1, 8
	or   r1, $7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 149
	shl  r1, 8
	or   r1, $95
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 152
	shl  r1, 8
	or   r1, $98
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 155
	shl  r1, 8
	or   r1, $9B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 158
	shl  r1, 8
	or   r1, $9E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 11
	shl  r1, 8
	or   r1, $B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 162
	shl  r1, 8
	or   r1, $A2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 165
	shl  r1, 8
	or   r1, $A5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 13
	shl  r1, 8
	or   r1, $D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 167
	shl  r1, 8
	or   r1, $A7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 14
	shl  r1, 8
	or   r1, $E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 170
	shl  r1, 8
	or   r1, $AA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 173
	shl  r1, 8
	or   r1, $AD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 16
	shl  r1, 8
	or   r1, $10
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 176
	shl  r1, 8
	or   r1, $B0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 17
	shl  r1, 8
	or   r1, $11
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 179
	shl  r1, 8
	or   r1, $B3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 18
	shl  r1, 8
	or   r1, $12
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 182
	shl  r1, 8
	or   r1, $B6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 19
	shl  r1, 8
	or   r1, $13
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 185
	shl  r1, 8
	or   r1, $B9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 188
	shl  r1, 8
	or   r1, $BC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 21
	shl  r1, 8
	or   r1, $15
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 190
	shl  r1, 8
	or   r1, $BE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 22
	shl  r1, 8
	or   r1, $16
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 193
	shl  r1, 8
	or   r1, $C1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 23
	shl  r1, 8
	or   r1, $17
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 196
	shl  r1, 8
	or   r1, $C4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 24
	shl  r1, 8
	or   r1, $18
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 198
	shl  r1, 8
	or   r1, $C6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 25
	shl  r1, 8
	or   r1, $19
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 201
	shl  r1, 8
	or   r1, $C9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 26
	shl  r1, 8
	or   r1, $1A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 203
	shl  r1, 8
	or   r1, $CB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 27
	shl  r1, 8
	or   r1, $1B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 206
	shl  r1, 8
	or   r1, $CE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 28
	shl  r1, 8
	or   r1, $1C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 208
	shl  r1, 8
	or   r1, $D0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 29
	shl  r1, 8
	or   r1, $1D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 211
	shl  r1, 8
	or   r1, $D3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 30
	shl  r1, 8
	or   r1, $1E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 213
	shl  r1, 8
	or   r1, $D5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 31
	shl  r1, 8
	or   r1, $1F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 215
	shl  r1, 8
	or   r1, $D7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 32
	shl  r1, 8
	or   r1, $20
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 218
	shl  r1, 8
	or   r1, $DA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 33
	shl  r1, 8
	or   r1, $21
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 220
	shl  r1, 8
	or   r1, $DC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 34
	shl  r1, 8
	or   r1, $22
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 222
	shl  r1, 8
	or   r1, $DE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 35
	shl  r1, 8
	or   r1, $23
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 224
	shl  r1, 8
	or   r1, $E0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 36
	shl  r1, 8
	or   r1, $24
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 226
	shl  r1, 8
	or   r1, $E2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 37
	shl  r1, 8
	or   r1, $25
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 228
	shl  r1, 8
	or   r1, $E4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 38
	shl  r1, 8
	or   r1, $26
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 230
	shl  r1, 8
	or   r1, $E6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 39
	shl  r1, 8
	or   r1, $27
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 232
	shl  r1, 8
	or   r1, $E8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 40
	shl  r1, 8
	or   r1, $28
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 234
	shl  r1, 8
	or   r1, $EA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 41
	shl  r1, 8
	or   r1, $29
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 235
	shl  r1, 8
	or   r1, $EB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 42
	shl  r1, 8
	or   r1, $2A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 237
	shl  r1, 8
	or   r1, $ED
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 43
	shl  r1, 8
	or   r1, $2B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 238
	shl  r1, 8
	or   r1, $EE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 44
	shl  r1, 8
	or   r1, $2C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 45
	shl  r1, 8
	or   r1, $2D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 241
	shl  r1, 8
	or   r1, $F1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 46
	shl  r1, 8
	or   r1, $2E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 243
	shl  r1, 8
	or   r1, $F3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 47
	shl  r1, 8
	or   r1, $2F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 244
	shl  r1, 8
	or   r1, $F4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 48
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 245
	shl  r1, 8
	or   r1, $F5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 49
	shl  r1, 8
	or   r1, $31
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 246
	shl  r1, 8
	or   r1, $F6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 50
	shl  r1, 8
	or   r1, $32
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 248
	shl  r1, 8
	or   r1, $F8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 51
	shl  r1, 8
	or   r1, $33
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 249
	shl  r1, 8
	or   r1, $F9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 52
	shl  r1, 8
	or   r1, $34
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 53
	shl  r1, 8
	or   r1, $35
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 54
	shl  r1, 8
	or   r1, $36
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 251
	shl  r1, 8
	or   r1, $FB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 55
	shl  r1, 8
	or   r1, $37
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 252
	shl  r1, 8
	or   r1, $FC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 56
	shl  r1, 8
	or   r1, $38
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 57
	shl  r1, 8
	or   r1, $39
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 58
	shl  r1, 8
	or   r1, $3A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 59
	shl  r1, 8
	or   r1, $3B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 60
	shl  r1, 8
	or   r1, $3C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 61
	shl  r1, 8
	or   r1, $3D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 62
	shl  r1, 8
	or   r1, $3E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 63
	shl  r1, 8
	or   r1, $3F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 64
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 65
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 66
	shl  r1, 8
	or   r1, $42
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 67
	shl  r1, 8
	or   r1, $43
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 68
	shl  r1, 8
	or   r1, $44
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 69
	shl  r1, 8
	or   r1, $45
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 70
	shl  r1, 8
	or   r1, $46
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 71
	shl  r1, 8
	or   r1, $47
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 72
	shl  r1, 8
	or   r1, $48
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 73
	shl  r1, 8
	or   r1, $49
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 252
	shl  r1, 8
	or   r1, $FC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 74
	shl  r1, 8
	or   r1, $4A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 251
	shl  r1, 8
	or   r1, $FB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 75
	shl  r1, 8
	or   r1, $4B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 76
	shl  r1, 8
	or   r1, $4C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 77
	shl  r1, 8
	or   r1, $4D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 249
	shl  r1, 8
	or   r1, $F9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 78
	shl  r1, 8
	or   r1, $4E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 248
	shl  r1, 8
	or   r1, $F8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 79
	shl  r1, 8
	or   r1, $4F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 246
	shl  r1, 8
	or   r1, $F6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 80
	shl  r1, 8
	or   r1, $50
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 245
	shl  r1, 8
	or   r1, $F5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 81
	shl  r1, 8
	or   r1, $51
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 244
	shl  r1, 8
	or   r1, $F4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 82
	shl  r1, 8
	or   r1, $52
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 243
	shl  r1, 8
	or   r1, $F3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 83
	shl  r1, 8
	or   r1, $53
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 241
	shl  r1, 8
	or   r1, $F1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 84
	shl  r1, 8
	or   r1, $54
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 85
	shl  r1, 8
	or   r1, $55
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 238
	shl  r1, 8
	or   r1, $EE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 86
	shl  r1, 8
	or   r1, $56
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 237
	shl  r1, 8
	or   r1, $ED
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 87
	shl  r1, 8
	or   r1, $57
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 235
	shl  r1, 8
	or   r1, $EB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 88
	shl  r1, 8
	or   r1, $58
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 234
	shl  r1, 8
	or   r1, $EA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 89
	shl  r1, 8
	or   r1, $59
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 232
	shl  r1, 8
	or   r1, $E8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 90
	shl  r1, 8
	or   r1, $5A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 230
	shl  r1, 8
	or   r1, $E6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 91
	shl  r1, 8
	or   r1, $5B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 228
	shl  r1, 8
	or   r1, $E4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 92
	shl  r1, 8
	or   r1, $5C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 226
	shl  r1, 8
	or   r1, $E2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 93
	shl  r1, 8
	or   r1, $5D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 224
	shl  r1, 8
	or   r1, $E0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 94
	shl  r1, 8
	or   r1, $5E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 222
	shl  r1, 8
	or   r1, $DE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 95
	shl  r1, 8
	or   r1, $5F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 220
	shl  r1, 8
	or   r1, $DC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 96
	shl  r1, 8
	or   r1, $60
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 218
	shl  r1, 8
	or   r1, $DA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 97
	shl  r1, 8
	or   r1, $61
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 215
	shl  r1, 8
	or   r1, $D7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 98
	shl  r1, 8
	or   r1, $62
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 213
	shl  r1, 8
	or   r1, $D5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 99
	shl  r1, 8
	or   r1, $63
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 211
	shl  r1, 8
	or   r1, $D3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 100
	shl  r1, 8
	or   r1, $64
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 208
	shl  r1, 8
	or   r1, $D0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 101
	shl  r1, 8
	or   r1, $65
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 206
	shl  r1, 8
	or   r1, $CE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 102
	shl  r1, 8
	or   r1, $66
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 203
	shl  r1, 8
	or   r1, $CB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 103
	shl  r1, 8
	or   r1, $67
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 201
	shl  r1, 8
	or   r1, $C9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 104
	shl  r1, 8
	or   r1, $68
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 198
	shl  r1, 8
	or   r1, $C6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 105
	shl  r1, 8
	or   r1, $69
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 196
	shl  r1, 8
	or   r1, $C4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 106
	shl  r1, 8
	or   r1, $6A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 193
	shl  r1, 8
	or   r1, $C1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 107
	shl  r1, 8
	or   r1, $6B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 190
	shl  r1, 8
	or   r1, $BE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 108
	shl  r1, 8
	or   r1, $6C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 188
	shl  r1, 8
	or   r1, $BC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 109
	shl  r1, 8
	or   r1, $6D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 185
	shl  r1, 8
	or   r1, $B9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 110
	shl  r1, 8
	or   r1, $6E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 182
	shl  r1, 8
	or   r1, $B6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 111
	shl  r1, 8
	or   r1, $6F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 179
	shl  r1, 8
	or   r1, $B3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 112
	shl  r1, 8
	or   r1, $70
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 176
	shl  r1, 8
	or   r1, $B0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 113
	shl  r1, 8
	or   r1, $71
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 173
	shl  r1, 8
	or   r1, $AD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 114
	shl  r1, 8
	or   r1, $72
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 170
	shl  r1, 8
	or   r1, $AA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 115
	shl  r1, 8
	or   r1, $73
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 167
	shl  r1, 8
	or   r1, $A7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 116
	shl  r1, 8
	or   r1, $74
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 165
	shl  r1, 8
	or   r1, $A5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 117
	shl  r1, 8
	or   r1, $75
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 162
	shl  r1, 8
	or   r1, $A2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 118
	shl  r1, 8
	or   r1, $76
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 158
	shl  r1, 8
	or   r1, $9E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 119
	shl  r1, 8
	or   r1, $77
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 155
	shl  r1, 8
	or   r1, $9B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 120
	shl  r1, 8
	or   r1, $78
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 152
	shl  r1, 8
	or   r1, $98
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 121
	shl  r1, 8
	or   r1, $79
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 149
	shl  r1, 8
	or   r1, $95
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 122
	shl  r1, 8
	or   r1, $7A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 146
	shl  r1, 8
	or   r1, $92
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 123
	shl  r1, 8
	or   r1, $7B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 143
	shl  r1, 8
	or   r1, $8F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 124
	shl  r1, 8
	or   r1, $7C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 140
	shl  r1, 8
	or   r1, $8C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 125
	shl  r1, 8
	or   r1, $7D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 137
	shl  r1, 8
	or   r1, $89
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 126
	shl  r1, 8
	or   r1, $7E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 134
	shl  r1, 8
	or   r1, $86
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 127
	shl  r1, 8
	or   r1, $7F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 131
	shl  r1, 8
	or   r1, $83
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 128
	shl  r1, 8
	or   r1, $80
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 127
	shl  r1, 8
	or   r1, $7F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 129
	shl  r1, 8
	or   r1, $81
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 124
	shl  r1, 8
	or   r1, $7C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 130
	shl  r1, 8
	or   r1, $82
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 121
	shl  r1, 8
	or   r1, $79
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 131
	shl  r1, 8
	or   r1, $83
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 118
	shl  r1, 8
	or   r1, $76
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 132
	shl  r1, 8
	or   r1, $84
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 115
	shl  r1, 8
	or   r1, $73
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 133
	shl  r1, 8
	or   r1, $85
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 112
	shl  r1, 8
	or   r1, $70
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 134
	shl  r1, 8
	or   r1, $86
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 109
	shl  r1, 8
	or   r1, $6D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 135
	shl  r1, 8
	or   r1, $87
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 106
	shl  r1, 8
	or   r1, $6A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 136
	shl  r1, 8
	or   r1, $88
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 103
	shl  r1, 8
	or   r1, $67
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 137
	shl  r1, 8
	or   r1, $89
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 100
	shl  r1, 8
	or   r1, $64
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 138
	shl  r1, 8
	or   r1, $8A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 97
	shl  r1, 8
	or   r1, $61
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 139
	shl  r1, 8
	or   r1, $8B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 93
	shl  r1, 8
	or   r1, $5D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 140
	shl  r1, 8
	or   r1, $8C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 90
	shl  r1, 8
	or   r1, $5A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 141
	shl  r1, 8
	or   r1, $8D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 88
	shl  r1, 8
	or   r1, $58
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 142
	shl  r1, 8
	or   r1, $8E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 85
	shl  r1, 8
	or   r1, $55
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 143
	shl  r1, 8
	or   r1, $8F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 82
	shl  r1, 8
	or   r1, $52
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 144
	shl  r1, 8
	or   r1, $90
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 79
	shl  r1, 8
	or   r1, $4F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 145
	shl  r1, 8
	or   r1, $91
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 76
	shl  r1, 8
	or   r1, $4C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 146
	shl  r1, 8
	or   r1, $92
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 73
	shl  r1, 8
	or   r1, $49
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 147
	shl  r1, 8
	or   r1, $93
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 70
	shl  r1, 8
	or   r1, $46
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 148
	shl  r1, 8
	or   r1, $94
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 67
	shl  r1, 8
	or   r1, $43
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 149
	shl  r1, 8
	or   r1, $95
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 65
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 150
	shl  r1, 8
	or   r1, $96
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 62
	shl  r1, 8
	or   r1, $3E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 151
	shl  r1, 8
	or   r1, $97
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 59
	shl  r1, 8
	or   r1, $3B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 152
	shl  r1, 8
	or   r1, $98
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 57
	shl  r1, 8
	or   r1, $39
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 153
	shl  r1, 8
	or   r1, $99
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 54
	shl  r1, 8
	or   r1, $36
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 154
	shl  r1, 8
	or   r1, $9A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 52
	shl  r1, 8
	or   r1, $34
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 155
	shl  r1, 8
	or   r1, $9B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 49
	shl  r1, 8
	or   r1, $31
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 156
	shl  r1, 8
	or   r1, $9C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 47
	shl  r1, 8
	or   r1, $2F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 157
	shl  r1, 8
	or   r1, $9D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 44
	shl  r1, 8
	or   r1, $2C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 158
	shl  r1, 8
	or   r1, $9E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 42
	shl  r1, 8
	or   r1, $2A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 159
	shl  r1, 8
	or   r1, $9F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 40
	shl  r1, 8
	or   r1, $28
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 160
	shl  r1, 8
	or   r1, $A0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 37
	shl  r1, 8
	or   r1, $25
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 161
	shl  r1, 8
	or   r1, $A1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 35
	shl  r1, 8
	or   r1, $23
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 162
	shl  r1, 8
	or   r1, $A2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 33
	shl  r1, 8
	or   r1, $21
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 163
	shl  r1, 8
	or   r1, $A3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 31
	shl  r1, 8
	or   r1, $1F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 164
	shl  r1, 8
	or   r1, $A4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 29
	shl  r1, 8
	or   r1, $1D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 165
	shl  r1, 8
	or   r1, $A5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 27
	shl  r1, 8
	or   r1, $1B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 166
	shl  r1, 8
	or   r1, $A6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 25
	shl  r1, 8
	or   r1, $19
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 167
	shl  r1, 8
	or   r1, $A7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 23
	shl  r1, 8
	or   r1, $17
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 168
	shl  r1, 8
	or   r1, $A8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 21
	shl  r1, 8
	or   r1, $15
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 169
	shl  r1, 8
	or   r1, $A9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 170
	shl  r1, 8
	or   r1, $AA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 18
	shl  r1, 8
	or   r1, $12
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 171
	shl  r1, 8
	or   r1, $AB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 17
	shl  r1, 8
	or   r1, $11
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 172
	shl  r1, 8
	or   r1, $AC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 173
	shl  r1, 8
	or   r1, $AD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 14
	shl  r1, 8
	or   r1, $E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 174
	shl  r1, 8
	or   r1, $AE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 175
	shl  r1, 8
	or   r1, $AF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 11
	shl  r1, 8
	or   r1, $B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 176
	shl  r1, 8
	or   r1, $B0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 177
	shl  r1, 8
	or   r1, $B1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 178
	shl  r1, 8
	or   r1, $B2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 7
	shl  r1, 8
	or   r1, $7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 179
	shl  r1, 8
	or   r1, $B3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 180
	shl  r1, 8
	or   r1, $B4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 181
	shl  r1, 8
	or   r1, $B5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 182
	shl  r1, 8
	or   r1, $B6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 183
	shl  r1, 8
	or   r1, $B7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 184
	shl  r1, 8
	or   r1, $B8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 185
	shl  r1, 8
	or   r1, $B9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 186
	shl  r1, 8
	or   r1, $BA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 187
	shl  r1, 8
	or   r1, $BB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 188
	shl  r1, 8
	or   r1, $BC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 189
	shl  r1, 8
	or   r1, $BD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 190
	shl  r1, 8
	or   r1, $BE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 191
	shl  r1, 8
	or   r1, $BF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 192
	shl  r1, 8
	or   r1, $C0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 193
	shl  r1, 8
	or   r1, $C1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 194
	shl  r1, 8
	or   r1, $C2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 195
	shl  r1, 8
	or   r1, $C3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 196
	shl  r1, 8
	or   r1, $C4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 197
	shl  r1, 8
	or   r1, $C5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 198
	shl  r1, 8
	or   r1, $C6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 199
	shl  r1, 8
	or   r1, $C7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 200
	shl  r1, 8
	or   r1, $C8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 201
	shl  r1, 8
	or   r1, $C9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 202
	shl  r1, 8
	or   r1, $CA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 203
	shl  r1, 8
	or   r1, $CB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 204
	shl  r1, 8
	or   r1, $CC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 205
	shl  r1, 8
	or   r1, $CD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 206
	shl  r1, 8
	or   r1, $CE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 7
	shl  r1, 8
	or   r1, $7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 207
	shl  r1, 8
	or   r1, $CF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 208
	shl  r1, 8
	or   r1, $D0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 209
	shl  r1, 8
	or   r1, $D1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 11
	shl  r1, 8
	or   r1, $B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 210
	shl  r1, 8
	or   r1, $D2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 211
	shl  r1, 8
	or   r1, $D3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 14
	shl  r1, 8
	or   r1, $E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 212
	shl  r1, 8
	or   r1, $D4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 213
	shl  r1, 8
	or   r1, $D5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 17
	shl  r1, 8
	or   r1, $11
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 214
	shl  r1, 8
	or   r1, $D6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 18
	shl  r1, 8
	or   r1, $12
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 215
	shl  r1, 8
	or   r1, $D7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 216
	shl  r1, 8
	or   r1, $D8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 21
	shl  r1, 8
	or   r1, $15
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 217
	shl  r1, 8
	or   r1, $D9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 23
	shl  r1, 8
	or   r1, $17
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 218
	shl  r1, 8
	or   r1, $DA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 25
	shl  r1, 8
	or   r1, $19
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 219
	shl  r1, 8
	or   r1, $DB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 27
	shl  r1, 8
	or   r1, $1B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 220
	shl  r1, 8
	or   r1, $DC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 29
	shl  r1, 8
	or   r1, $1D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 221
	shl  r1, 8
	or   r1, $DD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 31
	shl  r1, 8
	or   r1, $1F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 222
	shl  r1, 8
	or   r1, $DE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 33
	shl  r1, 8
	or   r1, $21
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 223
	shl  r1, 8
	or   r1, $DF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 35
	shl  r1, 8
	or   r1, $23
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 224
	shl  r1, 8
	or   r1, $E0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 37
	shl  r1, 8
	or   r1, $25
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 225
	shl  r1, 8
	or   r1, $E1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 40
	shl  r1, 8
	or   r1, $28
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 226
	shl  r1, 8
	or   r1, $E2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 42
	shl  r1, 8
	or   r1, $2A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 227
	shl  r1, 8
	or   r1, $E3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 44
	shl  r1, 8
	or   r1, $2C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 228
	shl  r1, 8
	or   r1, $E4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 47
	shl  r1, 8
	or   r1, $2F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 229
	shl  r1, 8
	or   r1, $E5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 49
	shl  r1, 8
	or   r1, $31
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 230
	shl  r1, 8
	or   r1, $E6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 52
	shl  r1, 8
	or   r1, $34
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 231
	shl  r1, 8
	or   r1, $E7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 54
	shl  r1, 8
	or   r1, $36
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 232
	shl  r1, 8
	or   r1, $E8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 57
	shl  r1, 8
	or   r1, $39
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 233
	shl  r1, 8
	or   r1, $E9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 59
	shl  r1, 8
	or   r1, $3B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 234
	shl  r1, 8
	or   r1, $EA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 62
	shl  r1, 8
	or   r1, $3E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 235
	shl  r1, 8
	or   r1, $EB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 65
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 236
	shl  r1, 8
	or   r1, $EC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 67
	shl  r1, 8
	or   r1, $43
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 237
	shl  r1, 8
	or   r1, $ED
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 70
	shl  r1, 8
	or   r1, $46
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 238
	shl  r1, 8
	or   r1, $EE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 73
	shl  r1, 8
	or   r1, $49
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 239
	shl  r1, 8
	or   r1, $EF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 76
	shl  r1, 8
	or   r1, $4C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 79
	shl  r1, 8
	or   r1, $4F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 241
	shl  r1, 8
	or   r1, $F1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 82
	shl  r1, 8
	or   r1, $52
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 242
	shl  r1, 8
	or   r1, $F2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 85
	shl  r1, 8
	or   r1, $55
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 243
	shl  r1, 8
	or   r1, $F3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 88
	shl  r1, 8
	or   r1, $58
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 244
	shl  r1, 8
	or   r1, $F4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 90
	shl  r1, 8
	or   r1, $5A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 245
	shl  r1, 8
	or   r1, $F5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 93
	shl  r1, 8
	or   r1, $5D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 246
	shl  r1, 8
	or   r1, $F6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 97
	shl  r1, 8
	or   r1, $61
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 247
	shl  r1, 8
	or   r1, $F7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 100
	shl  r1, 8
	or   r1, $64
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 248
	shl  r1, 8
	or   r1, $F8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 103
	shl  r1, 8
	or   r1, $67
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 249
	shl  r1, 8
	or   r1, $F9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 106
	shl  r1, 8
	or   r1, $6A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 109
	shl  r1, 8
	or   r1, $6D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 251
	shl  r1, 8
	or   r1, $FB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 112
	shl  r1, 8
	or   r1, $70
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 252
	shl  r1, 8
	or   r1, $FC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 115
	shl  r1, 8
	or   r1, $73
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 118
	shl  r1, 8
	or   r1, $76
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 121
	shl  r1, 8
	or   r1, $79
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 124
	shl  r1, 8
	or   r1, $7C
	pop  r2, rC
	st   r2, r1, 0, 1
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
gfx::sprite:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 3 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, 1
	shl  r1, 8
	or   r1, 64
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3


	push rC, rB
	push rC, rA
	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, 9 ; width
	push rC, r1
	ld   r1, rB, 12 ; height
	push rC, r1
	ld   r1, rB, 9 ; width
	push rC, r1
	ld   r1, rB, -3 ; dst_address
	push rC, r1
	ld   r1, rB, 9 ; width
	push rC, r1
	ld   r1, rB, 12 ; height
	push rC, r1
	let  r1, 1
	shl  r1, 8
	or   r1, 64
	push rC, r1
	pop  r8, rC
	pop  r7, rC
	pop  r6, rC
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r8
	push rC, r7
	push rC, r6
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, blit::blit[0:1]
	shl  rD, 8
	or   rF, rD, blit::blit[2]
	add  rC, 24
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	add  rC, $3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
gfx::clear:
	or   rB, rC ; reset stack base pointer
; ld   r1, rB, 0  ; color
		ld   r1, rB, 2, 1  ; color as u8
		shl  rD, r1, 8  ; color << 8
		or   rD, rD, r1 ; color << 8 | color
		shl  rD, rD, 8  ; color << 16 | color << 8
		or   r1, rD, r1 ; r1 = color << 16 | color << 8 | color
		let  rD, $FFE1
		shl  rD, 8
		let  r2, $FF00
		shl  r2, 8
		.do_while:
			push rD, r1
			less r3, r2, rD
			if   r3, .do_while
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
gfx::rectangle_fill:
	or   rB, rC ; reset stack base pointer
ld   r5, rB, 12
		ld   r4, rB, 9
		ld   r3, rB, 6
		ld   r2, rB, 3
		ld   r1, rB, 0
		let  rD, $FF00
		shl  rD, 8
		let  r6, 0 ; dy
		.do_while:
			let  r7, 0 ; dx
			add  r8, r1, rD ; ax
			add  r9, r2, r6 ; ay
			push rC, rD
			let  rD, 320
			mul  r9, r9, rD
			.do_while_inner:
				add   rD, r8, r7
				add   rD, rD, r9
				st    rD, r5, 0, 1
				add   r7, 1 ; dx += 1
				less  rD, r7, r3
				if    rD, .do_while_inner
			add  r6, 1
			less r7, r6, r4
			pop  rD, rC
			if   r7, .do_while
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
__var_1:
data
000000
mem::copy:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	ld   r1, rB, 0 ; src_address
	push rC, r1
	ld   r1, rB, 6 ; length
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	ld   r1, rB, 3 ; dst_address
	push rC, r1
	ld   r1, rB, 6 ; length
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r8, rC
	pop  r7, rC
	pop  r6, rC
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r8
	push rC, r7
	push rC, r6
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, blit::blit0[0:1]
	shl  rD, 8
	or   rF, rD, blit::blit0[2]
	add  rC, 24
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
mem::set:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 3 ; dst_address
	push rC, r1
	ld   r1, rB, 0 ; byte
	pop  r2, rC
	st   r2, r1, 0, 1


	push rC, rB
	push rC, rA
	ld   r1, rB, 3 ; dst_address
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	ld   r1, rB, 3 ; dst_address
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; length
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r8, rC
	pop  r7, rC
	pop  r6, rC
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r8
	push rC, r7
	push rC, r6
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, blit::blit0[0:1]
	shl  rD, 8
	or   rF, rD, blit::blit0[2]
	add  rC, 24
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
mem::init_allocator:
	or   rB, rC ; reset stack base pointer


	let  r1, __var_1[0:1]
	shl  r1, 8
	or   r1, __var_1[2]
	ld   r1
	less r1, 1
	if   r1, 12
	let  rD, __else_2[0:1]
	shl  rD, 8
	or   rF, rD, __else_2[2]


	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 22
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	let  rD, __var_1[0:1]
	shl  rD, 8
	or   rD, __var_1[2]
	st   rD, r1
	let  rD, __end_3[0:1]
	shl  rD, 8
	or   rF, rD, __end_3[2]
	__else_2:
	__end_3:
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
mem::allocate:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 0 ; requested_size
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 0


	sub  rC, 3
	push rC, rB
	push rC, rA
	ld   r1, rB, 0 ; requested_size
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, next_pow2[0:1]
	shl  rD, 8
	or   rF, rD, next_pow2[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -3


	sub  rC, 3
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	st   rB, r1, -6


__while_4:
	ld   r1, rB, -6 ; address
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	less r1, 1
	less r1, 1
	if   r1, __skip_6
	ld   r1, rB, -6 ; address
	push rC, r1
	let  r1, 49152
	shl  r1, 8
	or   r1, 0
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	__skip_6:
	xor  r1, 1
	less r1, 1
	if   r1, __end_5


	sub  rC, 3
	ld   r1, rB, -6 ; address
	ld   r1, 0, 1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, -9 ; block
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 31
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -12


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -12 ; block_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -15


	sub  rC, 3
	ld   r1, rB, -9 ; block
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -18


	sub  rC, 3
	ld   r1, rB, -15 ; block_size
	push rC, r1
	ld   r1, rB, -3 ; requested_size_next_pow2
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	st   rB, r1, -21


	sub  rC, 3
	ld   r1, rB, -15 ; block_size
	push rC, r1
	ld   r1, rB, -3 ; requested_size_next_pow2
	pop  r2, rC
	less r1, r1, r2
	less r1, 1
	st   rB, r1, -24


	ld   r1, rB, -18 ; is_free
	less r1, 1
	if   r1, __skip_7
	ld   r1, rB, -21 ; is_big
	less r1, 1
	__skip_7:
	xor  r1, 1
	less r1, 1
	if   r1, __skip_8
	ld   r1, rB, -24 ; is_small
	less r1, 1
	__skip_8:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_9


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -12 ; block_size_log2
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, -6 ; address
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
	let  rD, __end_10[0:1]
	shl  rD, 8
	or   rF, rD, __end_10[2]
	__else_if_9:
	ld   r1, rB, -18 ; is_free
	less r1, 1
	if   r1, __skip_11
	ld   r1, rB, -24 ; is_small
	less r1, 1
	less r1, 1
	__skip_11:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_13


	sub  rC, 3
	ld   r1, rB, -12 ; block_size_log2
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -27


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -27 ; new_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -30


	sub  rC, 3
	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -30 ; new_size
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -33


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -27 ; new_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, -33 ; buddy
	push rC, r1
	ld   r1, rB, -27 ; new_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1
	add  rC, $9
	let  rD, __end_10[0:1]
	shl  rD, 8
	or   rF, rD, __end_10[2]
	__else_if_13:
	ld   r1, rB, -21 ; is_big
	less r1, 1
	less r1, 1
	if   r1, __skip_12
	ld   r1, rB, -24 ; is_small
	less r1, 1
	__skip_12:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_14


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -3 ; requested_size_next_pow2
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6
	let  rD, __end_10[0:1]
	shl  rD, 8
	or   rF, rD, __end_10[2]
	__else_if_14:


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -15 ; block_size
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6
	__end_10:
	push rC, r1
	pop  r1, rC
	add  rC, $12
	if   __while_4
	__end_5:


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	add  rC, $6
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
mem::free:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 0 ; address
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 0


	sub  rC, 3
	ld   r1, rB, 0 ; address
	ld   r1, 0, 1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 31
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -3


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	sub  rC, 3
	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -6 ; block_size
	pop  r2, rC
	xor  r1, r2, r1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, -9 ; buddy
	ld   r1, 0, 1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -12


__while_15:
	ld   r1, rB, -12 ; buddy_is_free
	less r1, 1
	if   r1, __skip_17
	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 22
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	__skip_17:
	xor  r1, 1
	less r1, 1
	if   r1, __end_16


	sub  rC, 3
	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -6 ; block_size
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -15


	ld   r1, rB, -15 ; buddy_is_left
	if   r1, 12
	let  rD, __else_18[0:1]
	shl  rD, 8
	or   rF, rD, __else_18[2]


	ld   r1, rB, -9 ; buddy
	st   rB, r1, 0
	let  rD, __end_19[0:1]
	shl  rD, 8
	or   rF, rD, __end_19[2]
	__else_18:
	__end_19:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3


	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -6 ; block_size
	pop  r2, rC
	xor  r1, r2, r1
	st   rB, r1, -9


	ld   r1, rB, -9 ; buddy
	ld   r1, 0, 1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -12
	add  rC, $3
	if   __while_15
	__end_16:
	add  rC, $C
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
text::text:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 0 ; string
	ld   r1, 0, 3
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, 0 ; string
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	sub  rC, 3
	ld   r1, rB, -6 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, 3 ; x
	st   rB, r1, -12


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -15


__while_20:
	ld   r1, rB, -15 ; i
	push rC, r1
	ld   r1, rB, -3 ; length
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_21


	sub  rC, 3
	let  r1, /terminess[0:1]
	shl  r1, 8
	or   r1, /terminess[2]
	push rC, r1
	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -18


	push rC, rB
	push rC, rA
	ld   r1, rB, -18 ; char_offset
	push rC, r1
	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 3 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	push rC, r1
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, block_transfer[0:1]
	shl  rD, 8
	or   rF, rD, block_transfer[2]
	add  rC, 12
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -6 ; char_addr
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, -6 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -9


	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; $A
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_22[0:1]
	shl  rD, 8
	or   rF, rD, __else_22[2]


	ld   r1, rB, -12 ; sx
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 3


	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 6
	let  rD, __end_23[0:1]
	shl  rD, 8
	or   rF, rD, __end_23[2]
	__else_22:


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	__end_23:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -15 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -15
	add  rC, $3
	if   __while_20
	__end_21:


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, -12 ; sx
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_24[0:1]
	shl  rD, 8
	or   rF, rD, __else_24[2]


	ld   r1, rB, -12 ; sx
	st   rB, r1, 3
	let  rD, __end_25[0:1]
	shl  rD, 8
	or   rF, rD, __end_25[2]
	__else_24:
	__end_25:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	pop  r2, rC
	pop  r1, rC
	add  rC, $F
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
text::text2:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 0 ; string
	ld   r1, 0, 3
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, 0 ; string
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	sub  rC, 3
	ld   r1, rB, -6 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, 3 ; x
	st   rB, r1, -12


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -15


__while_26:
	ld   r1, rB, -15 ; i
	push rC, r1
	ld   r1, rB, -3 ; length
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_27


	sub  rC, 3
	let  r1, /terminess2[0:1]
	shl  r1, 8
	or   r1, /terminess2[2]
	push rC, r1
	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -18


	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; $A
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	less r1, 1
	if   r1, __else_if_28


	ld   r1, rB, -12 ; sx
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 3


	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 6
	let  rD, __end_29[0:1]
	shl  rD, 8
	or   rF, rD, __end_29[2]
	__else_if_28:
	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; $9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	less r1, 1
	if   r1, __else_if_30


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	let  rD, __end_29[0:1]
	shl  rD, 8
	or   rF, rD, __end_29[2]
	__else_if_30:


	push rC, rB
	push rC, rA
	ld   r1, rB, -18 ; char_offset
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 3 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	push rC, r1
	pop  r8, rC
	pop  r7, rC
	pop  r6, rC
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r8
	push rC, r7
	push rC, r6
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, blit2[0:1]
	shl  rD, 8
	or   rF, rD, blit2[2]
	add  rC, 24
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	__end_29:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -15 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -15


	ld   r1, rB, -6 ; char_addr
	push rC, r1
	ld   r1, rB, -15 ; i
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 1
	st   rB, r1, -9
	add  rC, $3
	if   __while_26
	__end_27:


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, -12 ; sx
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_31[0:1]
	shl  rD, 8
	or   rF, rD, __else_31[2]


	ld   r1, rB, -12 ; sx
	st   rB, r1, 3
	let  rD, __end_32[0:1]
	shl  rD, 8
	or   rF, rD, __end_32[2]
	__else_31:
	__end_32:
	push rC, r1
	pop  r1, rC
	add  rC, $F
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::open:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, 0
	shl  r1, 8
	or   r1, 144
	push rC, r1
	ld   r1, rB, 0 ; string
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 0 ; string
	ld   r1, 0, 3
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::io[0:1]
	shl  rD, 8
	or   rF, rD, io::io[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::read:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, 0
	shl  r1, 8
	or   r1, 145
	push rC, r1
	ld   r1, rB, 0 ; buffer
	push rC, r1
	ld   r1, rB, 3 ; length
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::io[0:1]
	shl  rD, 8
	or   rF, rD, io::io[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::allocate_read_to_string:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	ld   r1, rB, 0 ; string
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, io::open[0:1]
	shl  rD, 8
	or   rF, rD, io::open[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	sub  rC, 3
	push rC, rB
	push rC, rA
	let  r1, $100 ; 65536
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, allocate[0:1]
	shl  rD, 8
	or   rF, rD, allocate[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -3


	sub  rC, 3
	push rC, rB
	push rC, rA
	ld   r1, rB, -3 ; buffer
	push rC, r1
	let  r1, $100 ; 65536
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r2, rC
	pop  r1, rC
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::read[0:1]
	shl  rD, 8
	or   rF, rD, io::read[2]
	add  rC, 6
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -6


	sub  rC, 3
	push rC, rB
	push rC, rA
	ld   r1, rB, -6 ; length
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, allocate[0:1]
	shl  rD, 8
	or   rF, rD, allocate[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -9


	ld   r1, rB, -9 ; result
	push rC, r1
	ld   r1, rB, -6 ; length
	pop  r2, rC
	st   r2, r1, 0, 3


	push rC, rB
	push rC, rA
	ld   r1, rB, -3 ; buffer
	push rC, r1
	ld   r1, rB, -9 ; result
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -6 ; length
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, mem::copy[0:1]
	shl  rD, 8
	or   rF, rD, mem::copy[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	push rC, rB
	push rC, rA
	ld   r1, rB, -3 ; buffer
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, mem::free[0:1]
	shl  rD, 8
	or   rF, rD, mem::free[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -9 ; result
	push rC, r1
	pop  r1, rC
	add  rC, $9
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::write:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, 0
	shl  r1, 8
	or   r1, 146
	push rC, r1
	ld   r1, rB, 0 ; buffer
	push rC, r1
	ld   r1, rB, 3 ; length
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::io[0:1]
	shl  rD, 8
	or   rF, rD, io::io[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::read_metadata:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, 0
	shl  r1, 8
	or   r1, 152
	push rC, r1
	ld   r1, rB, 0 ; buffer
	push rC, r1
	ld   r1, rB, 3 ; length
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::io[0:1]
	shl  rD, 8
	or   rF, rD, io::io[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::change_directory:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, 0
	shl  r1, 8
	or   r1, 160
	push rC, r1
	ld   r1, rB, 0 ; string
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 0 ; string
	ld   r1, 0, 3
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::io[0:1]
	shl  rD, 8
	or   rF, rD, io::io[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::read_directory:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, 0
	shl  r1, 8
	or   r1, 161
	push rC, r1
	ld   r1, rB, 0 ; buffer
	push rC, r1
	ld   r1, rB, 3 ; length
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::io[0:1]
	shl  rD, 8
	or   rF, rD, io::io[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::run:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	push rC, r1
	ld   r1, rB, 0 ; string
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 0 ; string
	ld   r1, 0, 3
	push rC, r1
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, io::io[0:1]
	shl  rD, 8
	or   rF, rD, io::io[2]
	add  rC, 9
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io::io:
	or   rB, rC ; reset stack base pointer


	let  r1, 61440
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 0 ; port
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 61440
	shl  r1, 8
	or   r1, 3
	push rC, r1
	ld   r1, rB, 3 ; address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 61440
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 6 ; length
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 61440
	shl  r1, 8
	or   r1, 9
	ld   r1, 0, 3
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
blit::blit:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 1
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 9 ; src_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 3 ; src_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	ld   r1, rB, 6 ; src_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	ld   r1, rB, 21 ; dst_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 15 ; dst_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	ld   r1, rB, 18 ; dst_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 12 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
blit::blit0:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 9 ; src_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 3 ; src_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	ld   r1, rB, 6 ; src_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	ld   r1, rB, 21 ; dst_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 15 ; dst_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	ld   r1, rB, 18 ; dst_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 12 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
blit::blit2:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 1
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 9 ; src_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 3 ; src_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	ld   r1, rB, 6 ; src_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	ld   r1, rB, 21 ; dst_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 15 ; dst_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	ld   r1, rB, 18 ; dst_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 12 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
blit::blit20:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 9 ; src_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 3 ; src_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	ld   r1, rB, 6 ; src_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	ld   r1, rB, 21 ; dst_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 15 ; dst_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	ld   r1, rB, 18 ; dst_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 12 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
blit::palette:
	or   rB, rC ; reset stack base pointer


	let  r1, 63746
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 0 ; from
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 3 ; to
	pop  r2, rC
	st   r2, r1, 0, 1
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
init_allocator:
	or   rB, rC ; reset stack base pointer


	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 22
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
allocate:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 0 ; requested_size
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 0


	sub  rC, 3
	push rC, rB
	push rC, rA
	ld   r1, rB, 0 ; requested_size
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, next_pow2[0:1]
	shl  rD, 8
	or   rF, rD, next_pow2[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -3


	sub  rC, 3
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	st   rB, r1, -6


__while_33:
	ld   r1, rB, -6 ; address
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	less r1, 1
	less r1, 1
	if   r1, __skip_35
	ld   r1, rB, -6 ; address
	push rC, r1
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 22
	pop  r2, rC
	shl  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	__skip_35:
	xor  r1, 1
	less r1, 1
	if   r1, __end_34


	sub  rC, 3
	ld   r1, rB, -6 ; address
	ld   r1, 0, 1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, -9 ; block
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 127
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -12


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -12 ; block_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -15


	sub  rC, 3
	ld   r1, rB, -9 ; block
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -18


	sub  rC, 3
	ld   r1, rB, -15 ; block_size
	push rC, r1
	ld   r1, rB, -3 ; requested_size_next_pow2
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	st   rB, r1, -21


	sub  rC, 3
	ld   r1, rB, -15 ; block_size
	push rC, r1
	ld   r1, rB, -3 ; requested_size_next_pow2
	pop  r2, rC
	less r1, r1, r2
	less r1, 1
	st   rB, r1, -24


	ld   r1, rB, -18 ; is_free
	less r1, 1
	if   r1, __skip_36
	ld   r1, rB, -21 ; is_big
	less r1, 1
	__skip_36:
	xor  r1, 1
	less r1, 1
	if   r1, __skip_37
	ld   r1, rB, -24 ; is_small
	less r1, 1
	__skip_37:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_38


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -12 ; block_size_log2
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, -6 ; address
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
	let  rD, __end_39[0:1]
	shl  rD, 8
	or   rF, rD, __end_39[2]
	__else_if_38:
	ld   r1, rB, -18 ; is_free
	less r1, 1
	if   r1, __skip_40
	ld   r1, rB, -24 ; is_small
	less r1, 1
	less r1, 1
	__skip_40:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_42


	sub  rC, 3
	ld   r1, rB, -12 ; block_size_log2
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -27


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -27 ; new_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -30


	sub  rC, 3
	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -30 ; new_size
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -33


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -27 ; new_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, -33 ; buddy
	push rC, r1
	ld   r1, rB, -27 ; new_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1
	add  rC, $9
	let  rD, __end_39[0:1]
	shl  rD, 8
	or   rF, rD, __end_39[2]
	__else_if_42:
	ld   r1, rB, -21 ; is_big
	less r1, 1
	less r1, 1
	if   r1, __skip_41
	ld   r1, rB, -24 ; is_small
	less r1, 1
	__skip_41:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_43


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -3 ; requested_size_next_pow2
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6
	let  rD, __end_39[0:1]
	shl  rD, 8
	or   rF, rD, __end_39[2]
	__else_if_43:


	ld   r1, rB, -6 ; address
	push rC, r1
	ld   r1, rB, -15 ; block_size
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6
	__end_39:
	push rC, r1
	pop  r1, rC
	add  rC, $12
	if   __while_33
	__end_34:


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	add  rC, $6
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
deallocate:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 0 ; address
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 0


	sub  rC, 3
	ld   r1, rB, 0 ; address
	ld   r1, 0, 1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 127
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -3


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	sub  rC, 3
	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -6 ; block_size
	pop  r2, rC
	xor  r1, r2, r1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, -9 ; buddy
	ld   r1, 0, 1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -12


__while_44:
	ld   r1, rB, -12 ; buddy_is_free
	less r1, 1
	if   r1, __skip_46
	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 22
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	__skip_46:
	xor  r1, 1
	less r1, 1
	if   r1, __end_45


	sub  rC, 3
	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -6 ; block_size
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -15


	ld   r1, rB, -15 ; buddy_is_left
	if   r1, 12
	let  rD, __else_47[0:1]
	shl  rD, 8
	or   rF, rD, __else_47[2]


	ld   r1, rB, -9 ; buddy
	st   rB, r1, 0
	let  rD, __end_48[0:1]
	shl  rD, 8
	or   rF, rD, __end_48[2]
	__else_47:
	__end_48:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3


	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -3 ; block_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -6 ; block_size
	pop  r2, rC
	xor  r1, r2, r1
	st   rB, r1, -9


	ld   r1, rB, -9 ; buddy
	ld   r1, 0, 1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -12
	add  rC, $3
	if   __while_44
	__end_45:
	add  rC, $C
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
allocate_helper:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 3 ; address
	push rC, r1
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 22
	pop  r2, rC
	shl  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_49[0:1]
	shl  rD, 8
	or   rF, rD, __else_49[2]


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
	let  rD, __end_50[0:1]
	shl  rD, 8
	or   rF, rD, __end_50[2]
	__else_49:
	__end_50:
	push rC, r1
	pop  r1, rC


__while_51:
	ld   r1, rB, 3 ; address
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	less r1, 1
	less r1, 1
	if   r1, __skip_53
	ld   r1, rB, 3 ; address
	push rC, r1
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 22
	pop  r2, rC
	shl  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	__skip_53:
	xor  r1, 1
	less r1, 1
	if   r1, __end_52


	sub  rC, 3
	ld   r1, rB, 3 ; address
	ld   r1, 0, 1
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, -3 ; block
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 127
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -6


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -6 ; block_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, -3 ; block
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -12


	sub  rC, 3
	ld   r1, rB, -9 ; block_size
	push rC, r1
	ld   r1, rB, 0 ; requested_size_next_pow2
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	st   rB, r1, -15


	sub  rC, 3
	ld   r1, rB, -9 ; block_size
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	push rC, r1
	ld   r1, rB, 0 ; requested_size_next_pow2
	pop  r2, rC
	less r1, r2, r1
	st   rB, r1, -18


	ld   r1, rB, -12 ; is_free
	less r1, 1
	if   r1, __skip_54
	ld   r1, rB, -15 ; is_big
	less r1, 1
	__skip_54:
	xor  r1, 1
	less r1, 1
	if   r1, __skip_55
	ld   r1, rB, -18 ; is_small
	less r1, 1
	__skip_55:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_56


	ld   r1, rB, 3 ; address
	push rC, r1
	ld   r1, rB, -6 ; block_size_log2
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, 3 ; address
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
	let  rD, __end_57[0:1]
	shl  rD, 8
	or   rF, rD, __end_57[2]
	__else_if_56:
	ld   r1, rB, -12 ; is_free
	less r1, 1
	if   r1, __skip_58
	ld   r1, rB, -18 ; is_small
	less r1, 1
	less r1, 1
	__skip_58:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_60


	sub  rC, 3
	ld   r1, rB, -6 ; block_size_log2
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -21


	sub  rC, 3
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -21 ; new_size_log2
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -24


	sub  rC, 3
	ld   r1, rB, 3 ; address
	push rC, r1
	ld   r1, rB, -24 ; new_size
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -27


	ld   r1, rB, 3 ; address
	push rC, r1
	ld   r1, rB, -21 ; new_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, -27 ; buddy
	push rC, r1
	ld   r1, rB, -21 ; new_size_log2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 128
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1
	add  rC, $9
	let  rD, __end_57[0:1]
	shl  rD, 8
	or   rF, rD, __end_57[2]
	__else_if_60:
	ld   r1, rB, -15 ; is_big
	less r1, 1
	less r1, 1
	if   r1, __skip_59
	ld   r1, rB, -18 ; is_small
	less r1, 1
	__skip_59:
	xor  r1, 1
	less r1, 1
	if   r1, __else_if_61


	ld   r1, rB, 3 ; address
	push rC, r1
	ld   r1, rB, 0 ; requested_size_next_pow2
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	let  rD, __end_57[0:1]
	shl  rD, 8
	or   rF, rD, __end_57[2]
	__else_if_61:


	ld   r1, rB, 3 ; address
	push rC, r1
	ld   r1, rB, -9 ; block_size
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	__end_57:
	push rC, r1
	pop  r1, rC
	add  rC, $12
	if   __while_51
	__end_52:


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
next_pow2:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 0 ; n
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, 0 ; n
	push rC, r1
	ld   r1, rB, 0 ; n
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	or   r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, 0 ; n
	push rC, r1
	ld   r1, rB, 0 ; n
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	or   r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, 0 ; n
	push rC, r1
	ld   r1, rB, 0 ; n
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	or   r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, 0 ; n
	push rC, r1
	ld   r1, rB, 0 ; n
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	or   r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, 0 ; n
	push rC, r1
	ld   r1, rB, 0 ; n
	push rC, r1
	let  r1, $0 ; 16
	shl  r1, 8
	or   r1, $10
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	or   r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, 0 ; n
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, 0 ; n
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
div_mod:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -3


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -6


	sub  rC, 3
	let  r1, $0 ; 24
	shl  r1, 8
	or   r1, $18
	st   rB, r1, -9


__while_62:
	ld   r1, rB, -9 ; i
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	less r1, r1, r2
	less r1, 1
	if   r1, __end_63


	ld   r1, rB, -6 ; r
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	shl  r1, r2, r1
	push rC, r1
	ld   r1, rB, 0 ; dividend
	push rC, r1
	ld   r1, rB, -9 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	and  r1, r2, r1
	pop  r2, rC
	or   r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, -6 ; r
	push rC, r1
	ld   r1, rB, 3 ; divisor
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_64[0:1]
	shl  rD, 8
	or   rF, rD, __else_64[2]


	ld   r1, rB, -6 ; r
	push rC, r1
	ld   r1, rB, 3 ; divisor
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, -3 ; q
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	ld   r1, rB, -9 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	pop  r2, rC
	shl  r1, r2, r1
	pop  r2, rC
	or   r1, r2, r1
	st   rB, r1, -3
	let  rD, __end_65[0:1]
	shl  rD, 8
	or   rF, rD, __end_65[2]
	__else_64:
	__end_65:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -9 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -9
	if   __while_62
	__end_63:


	ld   r1, rB, -3 ; q
	push rC, r1
	ld   r1, rB, -6 ; r
	push rC, r1
	pop  r2, rC
	pop  r1, rC
	add  rC, $9
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
hash:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 0 ; input
	push rC, r1
	let  r1, $9277 ; 9598901
	shl  r1, 8
	or   r1, $B5
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $564B ; 5655301
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, -3 ; state
	push rC, r1
	ld   r1, rB, -3 ; state
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	ld   r1, rB, -3 ; state
	pop  r2, rC
	xor  r1, r2, r1
	push rC, r1
	let  r1, $8EF2 ; 9368281
	shl  r1, 8
	or   r1, $D9
	pop  r2, rC
	mul  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, -6 ; word
	push rC, r1
	let  r1, $0 ; 14
	shl  r1, 8
	or   r1, $E
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	ld   r1, rB, -6 ; word
	pop  r2, rC
	xor  r1, r2, r1
	push rC, r1
	pop  r1, rC
	add  rC, $6
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
sin8:
	or   rB, rC ; reset stack base pointer


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 0 ; x
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	and  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 1
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
init_sin8:
	or   rB, rC ; reset stack base pointer


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 128
	shl  r1, 8
	or   r1, $80
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 131
	shl  r1, 8
	or   r1, $83
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 134
	shl  r1, 8
	or   r1, $86
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 137
	shl  r1, 8
	or   r1, $89
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 140
	shl  r1, 8
	or   r1, $8C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 143
	shl  r1, 8
	or   r1, $8F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 146
	shl  r1, 8
	or   r1, $92
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 7
	shl  r1, 8
	or   r1, $7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 149
	shl  r1, 8
	or   r1, $95
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 152
	shl  r1, 8
	or   r1, $98
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 155
	shl  r1, 8
	or   r1, $9B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 158
	shl  r1, 8
	or   r1, $9E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 11
	shl  r1, 8
	or   r1, $B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 162
	shl  r1, 8
	or   r1, $A2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 165
	shl  r1, 8
	or   r1, $A5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 13
	shl  r1, 8
	or   r1, $D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 167
	shl  r1, 8
	or   r1, $A7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 14
	shl  r1, 8
	or   r1, $E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 170
	shl  r1, 8
	or   r1, $AA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 173
	shl  r1, 8
	or   r1, $AD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 16
	shl  r1, 8
	or   r1, $10
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 176
	shl  r1, 8
	or   r1, $B0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 17
	shl  r1, 8
	or   r1, $11
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 179
	shl  r1, 8
	or   r1, $B3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 18
	shl  r1, 8
	or   r1, $12
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 182
	shl  r1, 8
	or   r1, $B6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 19
	shl  r1, 8
	or   r1, $13
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 185
	shl  r1, 8
	or   r1, $B9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 188
	shl  r1, 8
	or   r1, $BC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 21
	shl  r1, 8
	or   r1, $15
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 190
	shl  r1, 8
	or   r1, $BE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 22
	shl  r1, 8
	or   r1, $16
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 193
	shl  r1, 8
	or   r1, $C1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 23
	shl  r1, 8
	or   r1, $17
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 196
	shl  r1, 8
	or   r1, $C4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 24
	shl  r1, 8
	or   r1, $18
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 198
	shl  r1, 8
	or   r1, $C6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 25
	shl  r1, 8
	or   r1, $19
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 201
	shl  r1, 8
	or   r1, $C9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 26
	shl  r1, 8
	or   r1, $1A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 203
	shl  r1, 8
	or   r1, $CB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 27
	shl  r1, 8
	or   r1, $1B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 206
	shl  r1, 8
	or   r1, $CE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 28
	shl  r1, 8
	or   r1, $1C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 208
	shl  r1, 8
	or   r1, $D0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 29
	shl  r1, 8
	or   r1, $1D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 211
	shl  r1, 8
	or   r1, $D3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 30
	shl  r1, 8
	or   r1, $1E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 213
	shl  r1, 8
	or   r1, $D5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 31
	shl  r1, 8
	or   r1, $1F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 215
	shl  r1, 8
	or   r1, $D7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 32
	shl  r1, 8
	or   r1, $20
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 218
	shl  r1, 8
	or   r1, $DA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 33
	shl  r1, 8
	or   r1, $21
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 220
	shl  r1, 8
	or   r1, $DC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 34
	shl  r1, 8
	or   r1, $22
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 222
	shl  r1, 8
	or   r1, $DE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 35
	shl  r1, 8
	or   r1, $23
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 224
	shl  r1, 8
	or   r1, $E0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 36
	shl  r1, 8
	or   r1, $24
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 226
	shl  r1, 8
	or   r1, $E2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 37
	shl  r1, 8
	or   r1, $25
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 228
	shl  r1, 8
	or   r1, $E4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 38
	shl  r1, 8
	or   r1, $26
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 230
	shl  r1, 8
	or   r1, $E6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 39
	shl  r1, 8
	or   r1, $27
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 232
	shl  r1, 8
	or   r1, $E8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 40
	shl  r1, 8
	or   r1, $28
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 234
	shl  r1, 8
	or   r1, $EA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 41
	shl  r1, 8
	or   r1, $29
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 235
	shl  r1, 8
	or   r1, $EB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 42
	shl  r1, 8
	or   r1, $2A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 237
	shl  r1, 8
	or   r1, $ED
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 43
	shl  r1, 8
	or   r1, $2B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 238
	shl  r1, 8
	or   r1, $EE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 44
	shl  r1, 8
	or   r1, $2C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 45
	shl  r1, 8
	or   r1, $2D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 241
	shl  r1, 8
	or   r1, $F1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 46
	shl  r1, 8
	or   r1, $2E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 243
	shl  r1, 8
	or   r1, $F3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 47
	shl  r1, 8
	or   r1, $2F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 244
	shl  r1, 8
	or   r1, $F4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 48
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 245
	shl  r1, 8
	or   r1, $F5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 49
	shl  r1, 8
	or   r1, $31
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 246
	shl  r1, 8
	or   r1, $F6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 50
	shl  r1, 8
	or   r1, $32
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 248
	shl  r1, 8
	or   r1, $F8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 51
	shl  r1, 8
	or   r1, $33
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 249
	shl  r1, 8
	or   r1, $F9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 52
	shl  r1, 8
	or   r1, $34
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 53
	shl  r1, 8
	or   r1, $35
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 54
	shl  r1, 8
	or   r1, $36
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 251
	shl  r1, 8
	or   r1, $FB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 55
	shl  r1, 8
	or   r1, $37
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 252
	shl  r1, 8
	or   r1, $FC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 56
	shl  r1, 8
	or   r1, $38
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 57
	shl  r1, 8
	or   r1, $39
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 58
	shl  r1, 8
	or   r1, $3A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 59
	shl  r1, 8
	or   r1, $3B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 60
	shl  r1, 8
	or   r1, $3C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 61
	shl  r1, 8
	or   r1, $3D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 62
	shl  r1, 8
	or   r1, $3E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 63
	shl  r1, 8
	or   r1, $3F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 64
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 65
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 66
	shl  r1, 8
	or   r1, $42
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 67
	shl  r1, 8
	or   r1, $43
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 68
	shl  r1, 8
	or   r1, $44
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 69
	shl  r1, 8
	or   r1, $45
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 70
	shl  r1, 8
	or   r1, $46
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 71
	shl  r1, 8
	or   r1, $47
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 72
	shl  r1, 8
	or   r1, $48
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 73
	shl  r1, 8
	or   r1, $49
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 252
	shl  r1, 8
	or   r1, $FC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 74
	shl  r1, 8
	or   r1, $4A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 251
	shl  r1, 8
	or   r1, $FB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 75
	shl  r1, 8
	or   r1, $4B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 76
	shl  r1, 8
	or   r1, $4C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 77
	shl  r1, 8
	or   r1, $4D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 249
	shl  r1, 8
	or   r1, $F9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 78
	shl  r1, 8
	or   r1, $4E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 248
	shl  r1, 8
	or   r1, $F8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 79
	shl  r1, 8
	or   r1, $4F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 246
	shl  r1, 8
	or   r1, $F6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 80
	shl  r1, 8
	or   r1, $50
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 245
	shl  r1, 8
	or   r1, $F5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 81
	shl  r1, 8
	or   r1, $51
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 244
	shl  r1, 8
	or   r1, $F4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 82
	shl  r1, 8
	or   r1, $52
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 243
	shl  r1, 8
	or   r1, $F3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 83
	shl  r1, 8
	or   r1, $53
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 241
	shl  r1, 8
	or   r1, $F1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 84
	shl  r1, 8
	or   r1, $54
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 85
	shl  r1, 8
	or   r1, $55
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 238
	shl  r1, 8
	or   r1, $EE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 86
	shl  r1, 8
	or   r1, $56
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 237
	shl  r1, 8
	or   r1, $ED
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 87
	shl  r1, 8
	or   r1, $57
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 235
	shl  r1, 8
	or   r1, $EB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 88
	shl  r1, 8
	or   r1, $58
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 234
	shl  r1, 8
	or   r1, $EA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 89
	shl  r1, 8
	or   r1, $59
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 232
	shl  r1, 8
	or   r1, $E8
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 90
	shl  r1, 8
	or   r1, $5A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 230
	shl  r1, 8
	or   r1, $E6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 91
	shl  r1, 8
	or   r1, $5B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 228
	shl  r1, 8
	or   r1, $E4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 92
	shl  r1, 8
	or   r1, $5C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 226
	shl  r1, 8
	or   r1, $E2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 93
	shl  r1, 8
	or   r1, $5D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 224
	shl  r1, 8
	or   r1, $E0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 94
	shl  r1, 8
	or   r1, $5E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 222
	shl  r1, 8
	or   r1, $DE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 95
	shl  r1, 8
	or   r1, $5F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 220
	shl  r1, 8
	or   r1, $DC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 96
	shl  r1, 8
	or   r1, $60
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 218
	shl  r1, 8
	or   r1, $DA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 97
	shl  r1, 8
	or   r1, $61
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 215
	shl  r1, 8
	or   r1, $D7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 98
	shl  r1, 8
	or   r1, $62
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 213
	shl  r1, 8
	or   r1, $D5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 99
	shl  r1, 8
	or   r1, $63
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 211
	shl  r1, 8
	or   r1, $D3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 100
	shl  r1, 8
	or   r1, $64
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 208
	shl  r1, 8
	or   r1, $D0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 101
	shl  r1, 8
	or   r1, $65
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 206
	shl  r1, 8
	or   r1, $CE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 102
	shl  r1, 8
	or   r1, $66
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 203
	shl  r1, 8
	or   r1, $CB
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 103
	shl  r1, 8
	or   r1, $67
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 201
	shl  r1, 8
	or   r1, $C9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 104
	shl  r1, 8
	or   r1, $68
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 198
	shl  r1, 8
	or   r1, $C6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 105
	shl  r1, 8
	or   r1, $69
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 196
	shl  r1, 8
	or   r1, $C4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 106
	shl  r1, 8
	or   r1, $6A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 193
	shl  r1, 8
	or   r1, $C1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 107
	shl  r1, 8
	or   r1, $6B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 190
	shl  r1, 8
	or   r1, $BE
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 108
	shl  r1, 8
	or   r1, $6C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 188
	shl  r1, 8
	or   r1, $BC
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 109
	shl  r1, 8
	or   r1, $6D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 185
	shl  r1, 8
	or   r1, $B9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 110
	shl  r1, 8
	or   r1, $6E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 182
	shl  r1, 8
	or   r1, $B6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 111
	shl  r1, 8
	or   r1, $6F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 179
	shl  r1, 8
	or   r1, $B3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 112
	shl  r1, 8
	or   r1, $70
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 176
	shl  r1, 8
	or   r1, $B0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 113
	shl  r1, 8
	or   r1, $71
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 173
	shl  r1, 8
	or   r1, $AD
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 114
	shl  r1, 8
	or   r1, $72
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 170
	shl  r1, 8
	or   r1, $AA
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 115
	shl  r1, 8
	or   r1, $73
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 167
	shl  r1, 8
	or   r1, $A7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 116
	shl  r1, 8
	or   r1, $74
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 165
	shl  r1, 8
	or   r1, $A5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 117
	shl  r1, 8
	or   r1, $75
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 162
	shl  r1, 8
	or   r1, $A2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 118
	shl  r1, 8
	or   r1, $76
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 158
	shl  r1, 8
	or   r1, $9E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 119
	shl  r1, 8
	or   r1, $77
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 155
	shl  r1, 8
	or   r1, $9B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 120
	shl  r1, 8
	or   r1, $78
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 152
	shl  r1, 8
	or   r1, $98
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 121
	shl  r1, 8
	or   r1, $79
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 149
	shl  r1, 8
	or   r1, $95
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 122
	shl  r1, 8
	or   r1, $7A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 146
	shl  r1, 8
	or   r1, $92
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 123
	shl  r1, 8
	or   r1, $7B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 143
	shl  r1, 8
	or   r1, $8F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 124
	shl  r1, 8
	or   r1, $7C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 140
	shl  r1, 8
	or   r1, $8C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 125
	shl  r1, 8
	or   r1, $7D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 137
	shl  r1, 8
	or   r1, $89
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 126
	shl  r1, 8
	or   r1, $7E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 134
	shl  r1, 8
	or   r1, $86
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 127
	shl  r1, 8
	or   r1, $7F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 131
	shl  r1, 8
	or   r1, $83
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 128
	shl  r1, 8
	or   r1, $80
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 127
	shl  r1, 8
	or   r1, $7F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 129
	shl  r1, 8
	or   r1, $81
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 124
	shl  r1, 8
	or   r1, $7C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 130
	shl  r1, 8
	or   r1, $82
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 121
	shl  r1, 8
	or   r1, $79
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 131
	shl  r1, 8
	or   r1, $83
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 118
	shl  r1, 8
	or   r1, $76
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 132
	shl  r1, 8
	or   r1, $84
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 115
	shl  r1, 8
	or   r1, $73
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 133
	shl  r1, 8
	or   r1, $85
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 112
	shl  r1, 8
	or   r1, $70
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 134
	shl  r1, 8
	or   r1, $86
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 109
	shl  r1, 8
	or   r1, $6D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 135
	shl  r1, 8
	or   r1, $87
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 106
	shl  r1, 8
	or   r1, $6A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 136
	shl  r1, 8
	or   r1, $88
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 103
	shl  r1, 8
	or   r1, $67
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 137
	shl  r1, 8
	or   r1, $89
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 100
	shl  r1, 8
	or   r1, $64
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 138
	shl  r1, 8
	or   r1, $8A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 97
	shl  r1, 8
	or   r1, $61
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 139
	shl  r1, 8
	or   r1, $8B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 93
	shl  r1, 8
	or   r1, $5D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 140
	shl  r1, 8
	or   r1, $8C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 90
	shl  r1, 8
	or   r1, $5A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 141
	shl  r1, 8
	or   r1, $8D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 88
	shl  r1, 8
	or   r1, $58
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 142
	shl  r1, 8
	or   r1, $8E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 85
	shl  r1, 8
	or   r1, $55
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 143
	shl  r1, 8
	or   r1, $8F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 82
	shl  r1, 8
	or   r1, $52
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 144
	shl  r1, 8
	or   r1, $90
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 79
	shl  r1, 8
	or   r1, $4F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 145
	shl  r1, 8
	or   r1, $91
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 76
	shl  r1, 8
	or   r1, $4C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 146
	shl  r1, 8
	or   r1, $92
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 73
	shl  r1, 8
	or   r1, $49
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 147
	shl  r1, 8
	or   r1, $93
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 70
	shl  r1, 8
	or   r1, $46
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 148
	shl  r1, 8
	or   r1, $94
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 67
	shl  r1, 8
	or   r1, $43
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 149
	shl  r1, 8
	or   r1, $95
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 65
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 150
	shl  r1, 8
	or   r1, $96
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 62
	shl  r1, 8
	or   r1, $3E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 151
	shl  r1, 8
	or   r1, $97
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 59
	shl  r1, 8
	or   r1, $3B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 152
	shl  r1, 8
	or   r1, $98
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 57
	shl  r1, 8
	or   r1, $39
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 153
	shl  r1, 8
	or   r1, $99
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 54
	shl  r1, 8
	or   r1, $36
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 154
	shl  r1, 8
	or   r1, $9A
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 52
	shl  r1, 8
	or   r1, $34
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 155
	shl  r1, 8
	or   r1, $9B
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 49
	shl  r1, 8
	or   r1, $31
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 156
	shl  r1, 8
	or   r1, $9C
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 47
	shl  r1, 8
	or   r1, $2F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 157
	shl  r1, 8
	or   r1, $9D
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 44
	shl  r1, 8
	or   r1, $2C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 158
	shl  r1, 8
	or   r1, $9E
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 42
	shl  r1, 8
	or   r1, $2A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 159
	shl  r1, 8
	or   r1, $9F
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 40
	shl  r1, 8
	or   r1, $28
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 160
	shl  r1, 8
	or   r1, $A0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 37
	shl  r1, 8
	or   r1, $25
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 161
	shl  r1, 8
	or   r1, $A1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 35
	shl  r1, 8
	or   r1, $23
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 162
	shl  r1, 8
	or   r1, $A2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 33
	shl  r1, 8
	or   r1, $21
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 163
	shl  r1, 8
	or   r1, $A3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 31
	shl  r1, 8
	or   r1, $1F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 164
	shl  r1, 8
	or   r1, $A4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 29
	shl  r1, 8
	or   r1, $1D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 165
	shl  r1, 8
	or   r1, $A5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 27
	shl  r1, 8
	or   r1, $1B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 166
	shl  r1, 8
	or   r1, $A6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 25
	shl  r1, 8
	or   r1, $19
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 167
	shl  r1, 8
	or   r1, $A7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 23
	shl  r1, 8
	or   r1, $17
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 168
	shl  r1, 8
	or   r1, $A8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 21
	shl  r1, 8
	or   r1, $15
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 169
	shl  r1, 8
	or   r1, $A9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 170
	shl  r1, 8
	or   r1, $AA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 18
	shl  r1, 8
	or   r1, $12
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 171
	shl  r1, 8
	or   r1, $AB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 17
	shl  r1, 8
	or   r1, $11
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 172
	shl  r1, 8
	or   r1, $AC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 173
	shl  r1, 8
	or   r1, $AD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 14
	shl  r1, 8
	or   r1, $E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 174
	shl  r1, 8
	or   r1, $AE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 175
	shl  r1, 8
	or   r1, $AF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 11
	shl  r1, 8
	or   r1, $B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 176
	shl  r1, 8
	or   r1, $B0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 177
	shl  r1, 8
	or   r1, $B1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 178
	shl  r1, 8
	or   r1, $B2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 7
	shl  r1, 8
	or   r1, $7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 179
	shl  r1, 8
	or   r1, $B3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 180
	shl  r1, 8
	or   r1, $B4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 181
	shl  r1, 8
	or   r1, $B5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 182
	shl  r1, 8
	or   r1, $B6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 183
	shl  r1, 8
	or   r1, $B7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 184
	shl  r1, 8
	or   r1, $B8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 185
	shl  r1, 8
	or   r1, $B9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 186
	shl  r1, 8
	or   r1, $BA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 187
	shl  r1, 8
	or   r1, $BB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 188
	shl  r1, 8
	or   r1, $BC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 189
	shl  r1, 8
	or   r1, $BD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 190
	shl  r1, 8
	or   r1, $BE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 191
	shl  r1, 8
	or   r1, $BF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 192
	shl  r1, 8
	or   r1, $C0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 193
	shl  r1, 8
	or   r1, $C1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 194
	shl  r1, 8
	or   r1, $C2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 195
	shl  r1, 8
	or   r1, $C3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 196
	shl  r1, 8
	or   r1, $C4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 197
	shl  r1, 8
	or   r1, $C5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 198
	shl  r1, 8
	or   r1, $C6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 199
	shl  r1, 8
	or   r1, $C7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 200
	shl  r1, 8
	or   r1, $C8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 2
	shl  r1, 8
	or   r1, $2
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 201
	shl  r1, 8
	or   r1, $C9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 202
	shl  r1, 8
	or   r1, $CA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 203
	shl  r1, 8
	or   r1, $CB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 204
	shl  r1, 8
	or   r1, $CC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 5
	shl  r1, 8
	or   r1, $5
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 205
	shl  r1, 8
	or   r1, $CD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 206
	shl  r1, 8
	or   r1, $CE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 7
	shl  r1, 8
	or   r1, $7
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 207
	shl  r1, 8
	or   r1, $CF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 208
	shl  r1, 8
	or   r1, $D0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 209
	shl  r1, 8
	or   r1, $D1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 11
	shl  r1, 8
	or   r1, $B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 210
	shl  r1, 8
	or   r1, $D2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 211
	shl  r1, 8
	or   r1, $D3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 14
	shl  r1, 8
	or   r1, $E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 212
	shl  r1, 8
	or   r1, $D4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 213
	shl  r1, 8
	or   r1, $D5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 17
	shl  r1, 8
	or   r1, $11
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 214
	shl  r1, 8
	or   r1, $D6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 18
	shl  r1, 8
	or   r1, $12
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 215
	shl  r1, 8
	or   r1, $D7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 216
	shl  r1, 8
	or   r1, $D8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 21
	shl  r1, 8
	or   r1, $15
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 217
	shl  r1, 8
	or   r1, $D9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 23
	shl  r1, 8
	or   r1, $17
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 218
	shl  r1, 8
	or   r1, $DA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 25
	shl  r1, 8
	or   r1, $19
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 219
	shl  r1, 8
	or   r1, $DB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 27
	shl  r1, 8
	or   r1, $1B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 220
	shl  r1, 8
	or   r1, $DC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 29
	shl  r1, 8
	or   r1, $1D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 221
	shl  r1, 8
	or   r1, $DD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 31
	shl  r1, 8
	or   r1, $1F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 222
	shl  r1, 8
	or   r1, $DE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 33
	shl  r1, 8
	or   r1, $21
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 223
	shl  r1, 8
	or   r1, $DF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 35
	shl  r1, 8
	or   r1, $23
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 224
	shl  r1, 8
	or   r1, $E0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 37
	shl  r1, 8
	or   r1, $25
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 225
	shl  r1, 8
	or   r1, $E1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 40
	shl  r1, 8
	or   r1, $28
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 226
	shl  r1, 8
	or   r1, $E2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 42
	shl  r1, 8
	or   r1, $2A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 227
	shl  r1, 8
	or   r1, $E3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 44
	shl  r1, 8
	or   r1, $2C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 228
	shl  r1, 8
	or   r1, $E4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 47
	shl  r1, 8
	or   r1, $2F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 229
	shl  r1, 8
	or   r1, $E5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 49
	shl  r1, 8
	or   r1, $31
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 230
	shl  r1, 8
	or   r1, $E6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 52
	shl  r1, 8
	or   r1, $34
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 231
	shl  r1, 8
	or   r1, $E7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 54
	shl  r1, 8
	or   r1, $36
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 232
	shl  r1, 8
	or   r1, $E8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 57
	shl  r1, 8
	or   r1, $39
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 233
	shl  r1, 8
	or   r1, $E9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 59
	shl  r1, 8
	or   r1, $3B
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 234
	shl  r1, 8
	or   r1, $EA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 62
	shl  r1, 8
	or   r1, $3E
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 235
	shl  r1, 8
	or   r1, $EB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 65
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 236
	shl  r1, 8
	or   r1, $EC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 67
	shl  r1, 8
	or   r1, $43
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 237
	shl  r1, 8
	or   r1, $ED
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 70
	shl  r1, 8
	or   r1, $46
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 238
	shl  r1, 8
	or   r1, $EE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 73
	shl  r1, 8
	or   r1, $49
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 239
	shl  r1, 8
	or   r1, $EF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 76
	shl  r1, 8
	or   r1, $4C
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 79
	shl  r1, 8
	or   r1, $4F
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 241
	shl  r1, 8
	or   r1, $F1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 82
	shl  r1, 8
	or   r1, $52
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 242
	shl  r1, 8
	or   r1, $F2
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 85
	shl  r1, 8
	or   r1, $55
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 243
	shl  r1, 8
	or   r1, $F3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 88
	shl  r1, 8
	or   r1, $58
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 244
	shl  r1, 8
	or   r1, $F4
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 90
	shl  r1, 8
	or   r1, $5A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 245
	shl  r1, 8
	or   r1, $F5
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 93
	shl  r1, 8
	or   r1, $5D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 246
	shl  r1, 8
	or   r1, $F6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 97
	shl  r1, 8
	or   r1, $61
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 247
	shl  r1, 8
	or   r1, $F7
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 100
	shl  r1, 8
	or   r1, $64
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 248
	shl  r1, 8
	or   r1, $F8
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 103
	shl  r1, 8
	or   r1, $67
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 249
	shl  r1, 8
	or   r1, $F9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 106
	shl  r1, 8
	or   r1, $6A
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 250
	shl  r1, 8
	or   r1, $FA
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 109
	shl  r1, 8
	or   r1, $6D
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 251
	shl  r1, 8
	or   r1, $FB
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 112
	shl  r1, 8
	or   r1, $70
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 252
	shl  r1, 8
	or   r1, $FC
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 115
	shl  r1, 8
	or   r1, $73
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 253
	shl  r1, 8
	or   r1, $FD
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 118
	shl  r1, 8
	or   r1, $76
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 254
	shl  r1, 8
	or   r1, $FE
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 121
	shl  r1, 8
	or   r1, $79
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 63488
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 124
	shl  r1, 8
	or   r1, $7C
	pop  r2, rC
	st   r2, r1, 0, 1
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
set_high_resolution:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	push rC, rB
	push rC, rA
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, allocate[0:1]
	shl  rD, 8
	or   rF, rD, allocate[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -3


	ld   r1, rB, -3 ; byte
	push rC, r1
	let  r1, $0 ; 255
	shl  r1, 8
	or   r1, $FF
	pop  r2, rC
	st   r2, r1, 0, 1


	push rC, rB
	push rC, rA
	ld   r1, rB, -3 ; byte
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	let  r1, 65505
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 0 ; x
	push rC, r1
	ld   r1, rB, 3 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; width
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	ld   r1, rB, 9 ; height
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	pop  r8, rC
	pop  r7, rC
	pop  r6, rC
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r8
	push rC, r7
	push rC, r6
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, blit0[0:1]
	shl  rD, 8
	or   rF, rD, blit0[2]
	add  rC, 24
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	push rC, rB
	push rC, rA
	ld   r1, rB, -3 ; byte
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	push rC, r1
	pop  r2, rC
	pop  r1, rC
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, deallocate[0:1]
	shl  rD, 8
	or   rF, rD, deallocate[2]
	add  rC, 6
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC
	add  rC, $3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
set_low_resolution:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -3


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -6


__while_66:
	ld   r1, rB, -6 ; dy
	push rC, r1
	ld   r1, rB, 9 ; height
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_67


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, 3 ; y
	push rC, r1
	ld   r1, rB, -6 ; dy
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	st   rB, r1, -12


__while_68:
	ld   r1, rB, -9 ; dx
	push rC, r1
	ld   r1, rB, 6 ; width
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_69


	sub  rC, 3
	ld   r1, rB, 0 ; x
	push rC, r1
	ld   r1, rB, -9 ; dx
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -15


	let  r1, 65505
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -15 ; x_offset
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -12 ; y_offset
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	shr  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -3 ; byte
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, -9 ; dx
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -9
	add  rC, $3
	if   __while_68
	__end_69:


	ld   r1, rB, -6 ; dy
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6
	add  rC, $6
	if   __while_66
	__end_67:
	add  rC, $6
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
block_transfer:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 1
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 6 ; width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	ld   r1, rB, 9 ; height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 6 ; width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	ld   r1, rB, 9 ; height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 3 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
memcopy:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 6 ; length
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 6 ; length
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 3 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
blit0:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 0
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 9 ; src_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 3 ; src_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	ld   r1, rB, 6 ; src_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	ld   r1, rB, 21 ; dst_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 15 ; dst_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	ld   r1, rB, 18 ; dst_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 12 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
blit2:
	or   rB, rC ; reset stack base pointer


	let  r1, 63744
	shl  r1, 8
	or   r1, 32
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 2
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 1
	pop  r2, rC
	or   r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1


	let  r1, 64530
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 9 ; src_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 2
	push rC, r1
	ld   r1, rB, 3 ; src_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 4
	push rC, r1
	ld   r1, rB, 6 ; src_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 0 ; src_address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 64530
	shl  r1, 8
	or   r1, 16
	push rC, r1
	ld   r1, rB, 21 ; dst_stride
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 18
	push rC, r1
	ld   r1, rB, 15 ; dst_width
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 20
	push rC, r1
	ld   r1, rB, 18 ; dst_height
	pop  r2, rC
	st   r2, r1, 0, 2


	let  r1, 64530
	shl  r1, 8
	or   r1, 22
	push rC, r1
	ld   r1, rB, 12 ; dst_address
	pop  r2, rC
	st   r2, r1, 0, 3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
text:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 0 ; address
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, -3 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -6


	sub  rC, 3
	ld   r1, rB, 3 ; x
	st   rB, r1, -9


__while_70:
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	ld   r1, rB, -6 ; character
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_71


	sub  rC, 3
	let  r1, /terminess[0:1]
	shl  r1, 8
	or   r1, /terminess[2]
	push rC, r1
	ld   r1, rB, -6 ; character
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -12


	push rC, rB
	push rC, rA
	ld   r1, rB, -12 ; char_offset
	push rC, r1
	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 3 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	push rC, r1
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, block_transfer[0:1]
	shl  rD, 8
	or   rF, rD, block_transfer[2]
	add  rC, 12
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -3 ; char_addr
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3


	ld   r1, rB, -3 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -6


	ld   r1, rB, -6 ; character
	push rC, r1
	let  r1, $0 ; $A
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_72[0:1]
	shl  rD, 8
	or   rF, rD, __else_72[2]


	ld   r1, rB, -9 ; sx
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 3


	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 6
	let  rD, __end_73[0:1]
	shl  rD, 8
	or   rF, rD, __end_73[2]
	__else_72:


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	__end_73:
	push rC, r1
	pop  r1, rC
	add  rC, $3
	if   __while_70
	__end_71:


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, -9 ; sx
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_74[0:1]
	shl  rD, 8
	or   rF, rD, __else_74[2]


	ld   r1, rB, -9 ; sx
	st   rB, r1, 3
	let  rD, __end_75[0:1]
	shl  rD, 8
	or   rF, rD, __end_75[2]
	__else_74:
	__end_75:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	pop  r2, rC
	pop  r1, rC
	add  rC, $9
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
text_sized:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 0 ; address
	ld   r1, 0, 3
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, 0 ; address
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	sub  rC, 3
	ld   r1, rB, -6 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, 3 ; x
	st   rB, r1, -12


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -15


__while_76:
	ld   r1, rB, -15 ; i
	push rC, r1
	ld   r1, rB, -3 ; length
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_77


	sub  rC, 3
	let  r1, /terminess[0:1]
	shl  r1, 8
	or   r1, /terminess[2]
	push rC, r1
	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -18


	push rC, rB
	push rC, rA
	ld   r1, rB, -18 ; char_offset
	push rC, r1
	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 3 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	push rC, r1
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, block_transfer[0:1]
	shl  rD, 8
	or   rF, rD, block_transfer[2]
	add  rC, 12
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -6 ; char_addr
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, -6 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -9


	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; $A
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_78[0:1]
	shl  rD, 8
	or   rF, rD, __else_78[2]


	ld   r1, rB, -12 ; sx
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 3


	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 6
	let  rD, __end_79[0:1]
	shl  rD, 8
	or   rF, rD, __end_79[2]
	__else_78:


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	__end_79:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -15 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -15
	add  rC, $3
	if   __while_76
	__end_77:


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, -12 ; sx
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_80[0:1]
	shl  rD, 8
	or   rF, rD, __else_80[2]


	ld   r1, rB, -12 ; sx
	st   rB, r1, 3
	let  rD, __end_81[0:1]
	shl  rD, 8
	or   rF, rD, __end_81[2]
	__else_80:
	__end_81:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	pop  r2, rC
	pop  r1, rC
	add  rC, $F
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
text2:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 0 ; address
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, -3 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -6


	sub  rC, 3
	ld   r1, rB, 3 ; x
	st   rB, r1, -9


__while_82:
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	ld   r1, rB, -6 ; character
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_83


	sub  rC, 3
	let  r1, /terminess2[0:1]
	shl  r1, 8
	or   r1, /terminess2[2]
	push rC, r1
	ld   r1, rB, -6 ; character
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -12


	push rC, rB
	push rC, rA
	ld   r1, rB, -12 ; char_offset
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 3 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	push rC, r1
	pop  r8, rC
	pop  r7, rC
	pop  r6, rC
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r8
	push rC, r7
	push rC, r6
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, blit2[0:1]
	shl  rD, 8
	or   rF, rD, blit2[2]
	add  rC, 24
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -3 ; char_addr
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3


	ld   r1, rB, -3 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -6


	ld   r1, rB, -6 ; character
	push rC, r1
	let  r1, $0 ; $A
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_84[0:1]
	shl  rD, 8
	or   rF, rD, __else_84[2]


	ld   r1, rB, -9 ; sx
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 3


	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 6
	let  rD, __end_85[0:1]
	shl  rD, 8
	or   rF, rD, __end_85[2]
	__else_84:


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	__end_85:
	push rC, r1
	pop  r1, rC
	add  rC, $3
	if   __while_82
	__end_83:


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, -9 ; sx
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_86[0:1]
	shl  rD, 8
	or   rF, rD, __else_86[2]


	ld   r1, rB, -9 ; sx
	st   rB, r1, 3
	let  rD, __end_87[0:1]
	shl  rD, 8
	or   rF, rD, __end_87[2]
	__else_86:
	__end_87:
	push rC, r1
	pop  r1, rC
	add  rC, $9
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
text_with_size2:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 0 ; address
	ld   r1, 0, 3
	st   rB, r1, -3


	sub  rC, 3
	ld   r1, rB, 0 ; address
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	sub  rC, 3
	ld   r1, rB, -6 ; char_addr
	ld   r1, 0, 1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, 3 ; x
	st   rB, r1, -12


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -15


__while_88:
	ld   r1, rB, -15 ; i
	push rC, r1
	ld   r1, rB, -3 ; length
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_89


	sub  rC, 3
	let  r1, /terminess2[0:1]
	shl  r1, 8
	or   r1, /terminess2[2]
	push rC, r1
	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -18


	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; $A
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	less r1, 1
	if   r1, __else_if_90


	ld   r1, rB, -12 ; sx
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, 3


	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 6
	let  rD, __end_91[0:1]
	shl  rD, 8
	or   rF, rD, __end_91[2]
	__else_if_90:
	ld   r1, rB, -9 ; character
	push rC, r1
	let  r1, $0 ; $9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	less r1, 1
	if   r1, __else_if_92


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	let  rD, __end_91[0:1]
	shl  rD, 8
	or   rF, rD, __end_91[2]
	__else_if_92:


	push rC, rB
	push rC, rA
	ld   r1, rB, -18 ; char_offset
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 3 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	push rC, r1
	pop  r8, rC
	pop  r7, rC
	pop  r6, rC
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r8
	push rC, r7
	push rC, r6
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, blit2[0:1]
	shl  rD, 8
	or   rF, rD, blit2[2]
	add  rC, 24
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, 3 ; x
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, 3
	__end_91:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -15 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -15


	ld   r1, rB, -6 ; char_addr
	push rC, r1
	ld   r1, rB, -15 ; i
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 1
	st   rB, r1, -9
	add  rC, $3
	if   __while_88
	__end_89:


	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, -12 ; sx
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_93[0:1]
	shl  rD, 8
	or   rF, rD, __else_93[2]


	ld   r1, rB, -12 ; sx
	st   rB, r1, 3
	let  rD, __end_94[0:1]
	shl  rD, 8
	or   rF, rD, __end_94[2]
	__else_93:
	__end_94:
	push rC, r1
	pop  r1, rC
	add  rC, $F
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
number_to_hex_string:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	push rC, rB
	push rC, rA
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, allocate[0:1]
	shl  rD, 8
	or   rF, rD, allocate[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -3


	ld   r1, rB, -3 ; string
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_95[0:1]
	shl  rD, 8
	or   rF, rD, __else_95[2]


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
	let  rD, __end_96[0:1]
	shl  rD, 8
	or   rF, rD, __end_96[2]
	__else_95:
	__end_96:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -3 ; string
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -3 ; string
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $3030 ; $303030
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -3 ; string
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $3030 ; $303030
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	st   r2, r1, 0, 3


	sub  rC, 3
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	st   rB, r1, -6


__while_97:
	ld   r1, rB, 0 ; number
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	less r1, r1, r2
	less r1, 1
	if   r1, __end_98


	sub  rC, 3
	ld   r1, rB, 0 ; number
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -9


	ld   r1, rB, -3 ; string
	push rC, r1
	ld   r1, rB, -6 ; i
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -9 ; digit
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_99[0:1]
	shl  rD, 8
	or   rF, rD, __else_99[2]


	ld   r1, rB, -9 ; digit
	push rC, r1
	let  r1, $0 ; $30
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	let  rD, __end_100[0:1]
	shl  rD, 8
	or   rF, rD, __end_100[2]
	__else_99:


	ld   r1, rB, -9 ; digit
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	push rC, r1
	let  r1, $0 ; $41
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	__end_100:
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, 0 ; number
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, -6 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -6
	add  rC, $3
	if   __while_97
	__end_98:


	ld   r1, rB, -3 ; string
	push rC, r1
	pop  r1, rC
	add  rC, $6
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
number_to_hex_string_buffer:
	or   rB, rC ; reset stack base pointer


	ld   r1, rB, 3 ; buffer
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, 3 ; buffer
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $3030 ; $303030
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, 3 ; buffer
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $3030 ; $303030
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	st   r2, r1, 0, 3


	sub  rC, 3
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	st   rB, r1, -3


__while_101:
	ld   r1, rB, 0 ; number
	push rC, r1
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	less r1, r1, r2
	less r1, 1
	if   r1, __end_102


	sub  rC, 3
	ld   r1, rB, 0 ; number
	push rC, r1
	let  r1, $0 ; 15
	shl  r1, 8
	or   r1, $F
	pop  r2, rC
	and  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, 3 ; buffer
	push rC, r1
	ld   r1, rB, -3 ; i
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -6 ; digit
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_103[0:1]
	shl  rD, 8
	or   rF, rD, __else_103[2]


	ld   r1, rB, -6 ; digit
	push rC, r1
	let  r1, $0 ; $30
	shl  r1, 8
	or   r1, $30
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	let  rD, __end_104[0:1]
	shl  rD, 8
	or   rF, rD, __end_104[2]
	__else_103:


	ld   r1, rB, -6 ; digit
	push rC, r1
	let  r1, $0 ; 10
	shl  r1, 8
	or   r1, $A
	pop  r2, rC
	sub  r1, r2, r1
	push rC, r1
	let  r1, $0 ; $41
	shl  r1, 8
	or   r1, $41
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	__end_104:
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, 0 ; number
	push rC, r1
	let  r1, $0 ; 4
	shl  r1, 8
	or   r1, $4
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, 0


	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -3
	add  rC, $3
	if   __while_101
	__end_102:


	ld   r1, rB, 3 ; buffer
	push rC, r1
	pop  r1, rC
	add  rC, $3
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
io:
	or   rB, rC ; reset stack base pointer


	let  r1, 61440
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, 0 ; port
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 61440
	shl  r1, 8
	or   r1, 3
	push rC, r1
	ld   r1, rB, 3 ; address
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 61440
	shl  r1, 8
	or   r1, 6
	push rC, r1
	ld   r1, rB, 6 ; length
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 61440
	shl  r1, 8
	or   r1, 9
	ld   r1, 0, 3
	push rC, r1
	pop  r1, rC
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
main:
	or   rB, rC ; reset stack base pointer


__loop_105:
	if   __loop_105
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
clear:
	or   rB, rC ; reset stack base pointer
; ld   r1, rB, 0  ; color
	ld   r1, rB, 2, 1  ; color as u8
	shl  rD, r1, 8  ; color << 8
	or   rD, rD, r1 ; color << 8 | color
	shl  rD, rD, 8  ; color << 16 | color << 8
	or   r1, rD, r1 ; r1 = color << 16 | color << 8 | color
	let  rD, $FFE1
	shl  rD, 8
	let  r2, $FF00
	shl  r2, 8
	.do_while:
		push rD, r1
		less r3, r2, rD
		if   r3, .do_while
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
rectangle_fill:
	or   rB, rC ; reset stack base pointer
ld   r5, rB, 12
	ld   r4, rB, 9
	ld   r3, rB, 6
	ld   r2, rB, 3
	ld   r1, rB, 0
	let  rD, $FF00
	shl  rD, 8
	let  r6, 0 ; dy
	.do_while:
		let  r7, 0 ; dx
		add  r8, r1, rD ; ax
		add  r9, r2, r6 ; ay
		push rC, rD
		let  rD, 320
		mul  r9, r9, rD
		.do_while_inner:
			add   rD, r8, r7
			add   rD, rD, r9
			st    rD, r5, 0, 1
			add   r7, 1 ; dx += 1
			less  rD, r7, r3
			if    rD, .do_while_inner
		add  r6, 1
		less r7, r6, r4
		pop  rD, rC
		if   r7, .do_while
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
vertical_line:
	or   rB, rC ; reset stack base pointer
ld   r4, rB, 9 ; color
	ld   r3, rB, 6 ; h
	ld   r2, rB, 3 ; y
	ld   r1, rB, 0 ; x
    let  rD, $FF00 ; FRAMEBUFFER
	shl  rD, 8
	let  r5, 320 ; WIDTH
	add  r8, r1, rD ; r8 = FRAMEBUFFER + x
	.do_while:
        mul  r9, r2, r5 ; r9 = y * WIDTH
        add  r7, r8, r9 ; r7 = x + y * WIDTH = index
        st   r7, r4, 0, 1 ; [index] = color
        add  r2, 1 ; y += 1
        sub  r3, 1 ; h -= 1
        if   r3, .do_while
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
__handle_interrupt:
and  rD, rE, $FF
sub  rD, 1
mul  rD, 9
add  rF, rF, rD
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
/hello:
data
5265746963756C6174696E672073706C696E65737E
00
/terminess:
data
03000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000003000000000003000000
00000300000000000300000000000300000000000000000000000300000000000300000000000000
00000000000000000000000000000003000300000003000300000003000300000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000030003000000030003000003030303030000030003000000030003
00000303030303000003000300000003000300000000000000000000000000000000000000000000
00000000000003000000000303030000030003000300030003000000000303030000000003000300
03000300030000030303000000000300000000000000000000000000000000000000000000030000
03000300030003000003000300000000000300000000030000000000030003000003000300030003
00000300000000000000000000000000000000000000000000000000000003000000000300030000
00030003000000000300000000030300030003000003000003000003000000030300030000000000
00000000000000000000000000000000030000000000030000000000030000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000003000000000300000000030000000000030000000000030000
00000003000000000000030000000000000300000000000000000000000000000000000000000000
00000000000300000000000003000000000000030000000000030000000000030000000000030000
00000300000000030000000000000000000000000000000000000000000000000000000000000000
00000000000000000003000300000000030000000303030303000000030000000003000300000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000300000000000300000003030303030000000300000000000300000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000003000000000003000000000300000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000003030303
03000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000300000000000300000000000000000000000000000000000000000000000000000000000000
03000000000003000000000300000000000300000000030000000000030000000003000000000003
00000000000000000000000000000000000000000000000000000000000303030000030000000300
03000003030003000300030003030000030003000000030003000000030000030303000000000000
00000000000000000000000000000000000000000000030000000003030000000000030000000000
03000000000003000000000003000000000003000000000303030000000000000000000000000000
00000000000000000000000000030303000003000000030003000000030000000000030000000003
00000000030000000003000000000303030303000000000000000000000000000000000000000000
00000000000303030000030000000300000000000300000003030000000000000300000000000300
03000000030000030303000000000000000000000000000000000000000000000000000000000000
03000000000303000000030003000003000003000300000003000303030303000000000003000000
00000300000000000000000000000000000000000000000000000000030303030300030000000000
03000000000003030303000000000000030000000000030003000000030000030303000000000000
00000000000000000000000000000000000000000003030300000300000000000300000000000303
03030000030000000300030000000300030000000300000303030000000000000000000000000000
00000000000000000000000003030303030000000000030000000000030000000003000000000003
00000000030000000000030000000000030000000000000000000000000000000000000000000000
00000000000303030000030000000300030000000300000303030000030000000300030000000300
03000000030000030303000000000000000000000000000000000000000000000000000000030303
00000300000003000300000003000300000003000003030303000000000003000000000003000003
03030000000000000000000000000000000000000000000000000000000000000000000000000000
00000300000000000300000000000000000000000000000000000300000000000300000000000000
00000000000000000000000000000000000000000000000000000000000000000000030000000000
03000000000000000000000000000000000003000000000003000000000300000000000000000000
00000000000000000000000000000000000000000000030000000003000000000300000000030000
00000000030000000000000300000000000003000000000000000000000000000000000000000000
00000000000000000000000000000000030303030300000000000000000000000000030303030300
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000003000000000000030000000000000300000000000003000000000300000000030000000003
00000000000000000000000000000000000000000000000000000000000303030000030000000300
03000000030000000003000000000300000000000000000000000300000000000300000000000000
00000000000000000000000000000000000000000003030300000300000003000300000303000300
03000300030003000300030000030300030000000000000303030300000000000000000000000000
00000000000000000000000000030303000003000000030003000000030003000000030003030303
03000300000003000300000003000300000003000000000000000000000000000000000000000000
00000000030303030000030000000300030000000300030303030000030000000300030000000300
03000000030003030303000000000000000000000000000000000000000000000000000000030303
00000300000003000300000000000300000000000300000000000300000000000300000003000003
03030000000000000000000000000000000000000000000000000000030303000000030000030000
03000000030003000000030003000000030003000000030003000003000003030300000000000000
00000000000000000000000000000000000000000303030303000300000000000300000000000303
03030000030000000000030000000000030000000000030303030300000000000000000000000000
00000000000000000000000003030303030003000000000003000000000003030303000003000000
00000300000000000300000000000300000000000000000000000000000000000000000000000000
00000000000303030000030000000300030000000000030000000000030003030300030000000300
03000000030000030303000000000000000000000000000000000000000000000000000003000000
03000300000003000300000003000303030303000300000003000300000003000300000003000300
00000300000000000000000000000000000000000000000000000000000303030000000003000000
00000300000000000300000000000300000000000300000000000300000000030303000000000000
00000000000000000000000000000000000000000000030303000000000300000000000300000000
00030000000000030000030000030000030000030000000303000000000000000000000000000000
00000000000000000000000003000000030003000003000003000300000003030000000003030000
00000300030000000300000300000300000003000000000000000000000000000000000000000000
00000000030000000000030000000000030000000000030000000000030000000000030000000000
03000000000003030303030000000000000000000000000000000000000000000000000003000000
03000303000303000300030003000300030003000300000003000300000003000300000003000300
00000300000000000000000000000000000000000000000000000000030000000300030000000300
03030000030003000300030003000003030003000000030003000000030003000000030000000000
00000000000000000000000000000000000000000003030300000300000003000300000003000300
00000300030000000300030000000300030000000300000303030000000000000000000000000000
00000000000000000000000003030303000003000000030003000000030003000000030003030303
00000300000000000300000000000300000000000000000000000000000000000000000000000000
00000000000303030000030000000300030000000300030000000300030000000300030000000300
03000300030000030303000000000000030000000000000000000000000000000000000003030303
00000300000003000300000003000300000003000303030300000300030000000300000300000300
00000300000000000000000000000000000000000000000000000000000303030000030000000300
03000000000000030303000000000000030000000000030003000000030000030303000000000000
00000000000000000000000000000000000000000303030303000000030000000000030000000000
03000000000003000000000003000000000003000000000003000000000000000000000000000000
00000000000000000000000003000000030003000000030003000000030003000000030003000000
03000300000003000300000003000003030300000000000000000000000000000000000000000000
00000000030000000300030000000300030000000300000300030000000300030000000300030000
00000300000000000300000000000000000000000000000000000000000000000000000003000000
03000300000003000300000003000300000003000300030003000300030003000303000303000300
00000300000000000000000000000000000000000000000000000000030000000300030000000300
00030003000000000300000000000300000000030003000003000000030003000000030000000000
00000000000000000000000000000000000000000300000003000300000003000003000300000003
00030000000003000000000003000000000003000000000003000000000000000000000000000000
00000000000000000000000003030303030000000000030000000003000000000300000000030000
00000300000000000300000000000303030303000000000000000000000000000000000000000000
00000000000303030000000300000000000300000000000300000000000300000000000300000000
00030000000000030303000000000000000000000000000000000000000000000000000000030000
00000003000000000000030000000000030000000000000300000000000300000000000003000000
00000300000000000000000000000000000000000000000000000000000303030000000000030000
00000003000000000003000000000003000000000003000000000003000000030303000000000000
00000000000000000000000000000000030000000003000300000300000003000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000303030303000000000000000003000000000000
03000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000003030300000000000003000003030303000300000003000300000003000003
03030300000000000000000000000000000000000000000000000000030000000000030000000000
03030303000003000000030003000000030003000000030003000000030003030303000000000000
00000000000000000000000000000000000000000000000000000000000000000003030300000300
00000300030000000000030000000000030000000300000303030000000000000000000000000000
00000000000000000000000000000000030000000000030000030303030003000000030003000000
03000300000003000300000003000003030303000000000000000000000000000000000000000000
00000000000000000000000000000000000303030000030000000300030303030300030000000000
03000000000000030303030000000000000000000000000000000000000000000000000000000003
03000000030000000003030300000000030000000000030000000000030000000000030000000000
03000000000000000000000000000000000000000000000000000000000000000000000000000000
00030303030003000000030003000000030003000000030003000000030000030303030000000000
03000003030300000000000000000000000000000300000000000300000000000303030300000300
00000300030000000300030000000300030000000300030000000300000000000000000000000000
00000000000000000300000000000300000000000000000000030300000000000300000000000300
00000000030000000000030000000003030300000000000000000000000000000000000000000000
00000300000000000300000000000000000000030300000000000300000000000300000000000300
00000000030000000000030000030000030000000303000000000000000000000000000000030000
00000003000000000003000003000003000300000003030000000003030000000003000300000003
00000300000000000000000000000000000000000000000000000000000303000000000003000000
00000300000000000300000000000300000000000300000000000300000000030303000000000000
00000000000000000000000000000000000000000000000000000000000000000303030300000300
03000300030003000300030003000300030003000300030003000300000000000000000000000000
00000000000000000000000000000000000000000000000003030303000003000000030003000000
03000300000003000300000003000300000003000000000000000000000000000000000000000000
00000000000000000000000000000000000303030000030000000300030000000300030000000300
03000000030000030303000000000000000000000000000000000000000000000000000000000000
00000000000000000303030300000300000003000300000003000300000003000300000003000303
03030000030000000000030000000000000000000000000000000000000000000000000000000000
00030303030003000000030003000000030003000000030003000000030000030303030000000000
03000000000003000000000000000000000000000000000000000000000000000300030303000303
00000000030000000000030000000000030000000000030000000000000000000000000000000000
00000000000000000000000000000000000000000000000000030303030003000000000000030303
00000000000003000000000003000303030300000000000000000000000000000000000000000000
00000000000003000000000003000000000303030000000003000000000003000000000003000000
00000300000000000003030000000000000000000000000000000000000000000000000000000000
00000000000000000300000003000300000003000300000003000300000003000300000003000003
03030300000000000000000000000000000000000000000000000000000000000000000000000000
03000000030003000000030000030003000000030003000000000300000000000300000000000000
00000000000000000000000000000000000000000000000000000000000000000300000003000300
00000300030003000300030003000300030003000300000303030000000000000000000000000000
00000000000000000000000000000000000000000000000003000000030000030003000000000300
00000000030000000003000300000300000003000000000000000000000000000000000000000000
00000000000000000000000000000000030000000300030000000300030000000300030000000300
03000000030000030303030000000000030000030303000000000000000000000000000000000000
00000000000000000303030303000000000300000000030000000003000000000300000000000303
03030300000000000000000000000000000000000000000000000000000000030300000003000000
00000300000000030000000000000300000000000300000000000300000000000003030000000000
00000000000000000000000000000000000000000000030000000000030000000000030000000000
03000000000003000000000003000000000003000000000003000000000000000000000000000000
00000000000000000000000000030300000000000003000000000003000000000000030000000003
00000000000300000000000300000003030000000000000000000000000000000000000000000003
00000300030003000300030000030000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
/terminess2:
data
C0000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000CC00
00CC0000C00000CC00000000030300333300000000000000000000000000000000333300F3F3C03F
3F0C3333000000000000000000000000000000000000000000000000003C0CCC30330000CC0C3330
3C000000000000000000000000000000000000000000000C0000CC00000000000000000000000000
000000003C0033000033000000C300000000000000300C0000330000330003C00000000000000000
0000303C00F0FCC030300000000000000000000000CC00F0FCC000C0000000000000000000000000
0000000000CC00300000000000000000000000F0F0C0000000000000000000000000000000000000
00CC000000000000000000CC00330000CC003300000000000000003CF00CCC3CCCFC00CCC30FC000
000000000003CC0000CC0000CC0003CF000000000000003CF00CC000CC003C003F0F0C0000000000
003CF00C000FC00000CCC30FC00000000000000003CC03C0CCCF0FCC0000CC000000000000FCF0C0
CF0F000000CCC30FC00000000000003CF000CF0F00CC00CCC30FC0000000000000F0F0CC0003C000
3C0000CC000000000000003CF00CC30FC0CC00CCC30FC00000000000003CF00CCC00CC30F0CC030F
C000000000000000000000CC0000000000CC0000000000000000000000CC0000000000CC00300000
00000000000C003C00300C0000300C000000000000000000F0F0C00F0F0C00000000000000000003
000000C3000003C003C0000000000000003CF00CC003C000C00000CC000000000000003CF00CCC3C
CCCCC3CCC30F0C0000000000003CF00CCC00CCFCF0CCCC00CC000000000000FCF00CCF0FC0CC00CC
CF0FC00000000000003CF00CCC0000CC0000C30FC0000000000000FCC300CC00CCCC00CCCF3C0000
0000000000FCF0C0CF0F00CC0000CF0F0C000000000000FCF0C0CF0F00CC0000CC00000000000000
003CF00CCC0000CCF0CCC30FC0000000000000CC00CCCF0FCCCC00CCCC00CC00000000000030FC00
00CC0000CC0003CF0000000000000000F3C00033000C3300C33C00000000000000CC03C0CFC000FC
0C00CC300C000000000000CC0000CC0000CC0000CF0F0C000000000000CF03CCCCCCCCCC00CCCC00
CC000000000000CC00CCFC0CCCCC30CCCC00CC0000000000003CF00CCC00CCCC00CCC30FC0000000
000000FCF00CCC00CCFCF000CC00000000000000003CF00CCC00CCCC00CCC3CFC00000C0000000FC
F00CCC00CCFCFC00CC300C0000000000003CF00CC30F000000CCC30FC0000000000000F0FCC000CC
0000CC0000CC00000000000000CC00CCCC00CCCC00CCC30FC0000000000000CC00CCC303C0333300
00CC00000000000000CC00CCCC00CCCCCCCCFC30CC000000000000CC00CC303C0003C300CC00CC00
0000000000CC00CC33330000CC0000CC00000000000000F0F0CC003C003C0000CF0F0C0000000000
0033F000330000330000330F0000000000000033000000CC000033000000CC00000000000030F300
003300003300033F00000000000C003C300C00000000000000000000000000000000000000000000
0000000000F0F0C0300C0000000000000000000000000000000000000000000030F00C3CF0CCC30F
CC000000000000CC0000FCF00CCC00CCCF0FC00000000000000000003CF00CCC0000C30FC0000000
0000000000CC3CF0CCCC00CCC30FCC0000000000000000003CF00CFCF0C0C30F0C00000000000000
3CC030FC0000CC0000CC000000000000000000003CF0CCCC00CCC30FCC030FC0000000CC0000FCF0
0CCC00CCCC00CC000000000C0000C00030CC0000CC0003CF0000000000000C0000C00030CC0000CC
0000CC300FC00000003300003303C033CC0033300C00000000000030CC0000CC0000CC0003CF0000
0000000000000000FCFC0CCCCCCCCCCCCC000000000000000000FCF00CCC00CCCC00CC0000000000
000000003CF00CCC00CCC30FC0000000000000000000FCF00CCC00CCCF0FC0CC0000000000000000
3CF0CCCC00CCC30FCC0000CC000000000000CFF0C0CC0000CC00000000000000000000003CF0C030
F00C0F0FC000000000000000CC0030FC0000CC0000C30C000000000000000000CC00CCCC00CCC30F
CC000000000000000000CC00CC33330000CC00000000000000000000CC00CCCCCCCCC3CFC0000000
000000000000C303C000CC003C300C000000000000000000CC00CCCC00CCC30FCC030FC000000000
0000F0F3C003C000CF0F0C000000000000003CC003C00000CC0000C30C00000000000000CC0000CC
0000CC0000CC0000000000000030C30000300C003300033C0000000003000CCCC3C0000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000