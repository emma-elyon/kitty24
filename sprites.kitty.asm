; jump to event handler
if   rE, __interrupt
if   rE, __interrupt

; set up main return address
let  rA, $FFFF
shl  rA, 8
or   rA, $FF

; set up stack on first run
let  rC, $FD
shl  rC, 16

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
main:
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	add  rA, rF, 9
	let  rD, init_sin8[0:1]
	shl  rD, 8
	or   rF, rD, init_sin8[2]
	add  rC, 0
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


__loop_1:
	if   __loop_1
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
sprite:
	or   rB, rC ; reset stack base pointer


	sub  rC, 3
	ld   r1, rB, 6 ; y
	st   rB, r1, -3


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -6


__while_2:
	ld   r1, rB, -3 ; dy
	push rC, r1
	ld   r1, rB, 6 ; y
	push rC, r1
	ld   r1, rB, 12 ; height
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_3


	sub  rC, 3
	ld   r1, rB, 3 ; x
	st   rB, r1, -9


__while_4:
	ld   r1, rB, -9 ; dx
	push rC, r1
	ld   r1, rB, 3 ; x
	push rC, r1
	ld   r1, rB, 9 ; width
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_5


	sub  rC, 3
	ld   r1, rB, -3 ; dy
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	ld   r1, rB, -9 ; dx
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -12


	sub  rC, 3
	ld   r1, rB, 0 ; address
	push rC, r1
	ld   r1, rB, -6 ; sprite_index
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 1
	st   rB, r1, -15


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	ld   r1, rB, -15 ; pixel
	pop  r2, rC
	less r1, r2, r1
	if   r1, 12
	let  rD, __else_6[0:1]
	shl  rD, 8
	or   rF, rD, __else_6[2]


	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -12 ; framebuffer_index
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -15 ; pixel
	push rC, r1
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 1
	let  rD, __end_7[0:1]
	shl  rD, 8
	or   rF, rD, __end_7[2]
	__else_6:
	__end_7:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -6 ; sprite_index
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	ld   r1, rB, -9 ; dx
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -9
	add  rC, $6
	if   __while_4
	__end_5:


	ld   r1, rB, -3 ; dy
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3
	add  rC, $3
	if   __while_2
	__end_3:
	add  rC, $6
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
sin8:
	or   rB, rC ; reset stack base pointer


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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


	let  r1, 32768
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
clear:
	or   rB, rC ; reset stack base pointer
ld   r1, rB, 0  ; color
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
div_mod:
	or   rB, rC ; reset stack base pointer
ld   r4, rb, 3 ; denominator
	ld   r3, rb, 0 ; numerator
	let  r1, 0     ; quotient
	let  r2, 0     ; remainder
	let  r5, 24     ; i = bits to go through (up to 24)
	.while_i: ; i != 0
		shl  r2, 1
		shr  rD, r3, r5
		and  rD, 1
		or   r2, r2, rD
		less rD, r2, r4
		if   rD, .next
			sub  r2, r2, r4
			let  rD, 1
			shl  rD, rD, r5
			or   r1, r1, rD
		.next:
			sub  r5, 1
			if   r5, .while_i
	or   rC, rB ; reset stack pointer
	or   rF, rA ; return to rA
__interrupt_1:
	shr  rD, rE, 8
	push rC, rD
	or   rB, rC ; reset stack base pointer


	push rC, rB
	push rC, rA
	let  r1, $0 ; 240
	shl  r1, 8
	or   r1, $F0
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, clear[0:1]
	shl  rD, 8
	or   rF, rD, clear[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -3


__while_8:
	ld   r1, rB, -3 ; angle_delta
	push rC, r1
	let  r1, $1 ; 256
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_9


	sub  rC, 3
	push rC, rB
	push rC, rA
	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	ld   r1, rB, -3 ; angle_delta
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 64
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, sin8[0:1]
	shl  rD, 8
	or   rF, rD, sin8[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 96
	shl  r1, 8
	or   r1, $60
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	sub  rC, 3
	push rC, rB
	push rC, rA
	let  r1, __var_0[0:1]
	shl  r1, 8
	or   r1, __var_0[2]
	ld   r1
	push rC, r1
	ld   r1, rB, -3 ; angle_delta
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r1, rC
	push rC, r1
	add  rA, rF, 9
	let  rD, sin8[0:1]
	shl  rD, 8
	or   rF, rD, sin8[2]
	add  rC, 3
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 12
	shl  r1, 8
	or   r1, $C
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -9


	push rC, rB
	push rC, rA
	let  r1, /sonic[0:1]
	shl  r1, 8
	or   r1, /sonic[2]
	push rC, r1
	ld   r1, rB, -6 ; x
	push rC, r1
	ld   r1, rB, -9 ; y
	push rC, r1
	let  r1, $0 ; 24
	shl  r1, 8
	or   r1, $18
	push rC, r1
	let  r1, $0 ; 32
	shl  r1, 8
	or   r1, $20
	push rC, r1
	pop  r5, rC
	pop  r4, rC
	pop  r3, rC
	pop  r2, rC
	pop  r1, rC
	push rC, r5
	push rC, r4
	push rC, r3
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, sprite[0:1]
	shl  rD, 8
	or   rF, rD, sprite[2]
	add  rC, 15
	pop  rA, rC
	pop  rB, rC
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -3 ; angle_delta
	push rC, r1
	let  r1, $0 ; 16
	shl  r1, 8
	or   r1, $10
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3
	add  rC, $6
	if   __while_8
	__end_9:


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
	let  rD, __var_0[0:1]
	shl  rD, 8
	or   rD, __var_0[2]
	st   rD, r1
	add  rC, $3
	or   rC, rB ; reset stack pointer
	add  rC, 3 ; remove interrupt argument from stack
	let  rE, 0 ; return from interrupt
__handle_interrupt:
and  rD, rE, $FF
sub  rD, 1
mul  rD, 9
add  rF, rF, rD
let rD, __interrupt_1[0:1]
shl rD, 8
or rF, rD, __interrupt_1[2]
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
let  rE, 0
/sonic:
data
0B000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007070707070707070700000000000000000000
00000000000007070707000007070700000000000000000000000000000000000007000407070707
07000000000000000000000000000000000005040407010107070000000000000000000000000007
07000505070101010107070000000000000000000000070700070707010707070107070000000000
00000000070707000001030107070303010703000000000000000007000007000007010107030303
00070000000000000000000000000000000707070703030300030000000000000000000000000000
00000707070103030003000000000000000000000000070700000007030303030300020000000000
00000000000700000000000504040404040500000000000000000000070000000000000004040404
0E000000000000000000000700000000000000000505050E00000000000000000000000000000000
00000404040704040500000000000000000000000000000000040505070504040400000000000000
00000000000000000400000007050404050000000000000000000000000000000503020307070505
0E0100000000000000000000000000000E0203030007070700020200000000000000000000000000
00020202070700000001000000000000000000000000000000000202070000000000000000000000
00000000000000000000000007000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000203030300020202000000000000000000000000000000
000202020300010102000000000000000000000000000000000E0E0E030206000002020000000000
0000000000000000000E0E02060606060600000E0000000000000000000000000000000000000000
000000000000000B