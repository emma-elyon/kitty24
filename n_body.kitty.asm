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
main:
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


__while_0:
	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 64
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_1


	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 12
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, $4 ; 1200
	shl  r1, 8
	or   r1, $B0
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 40
	shl  r1, 8
	or   r1, $28
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shl  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 3


	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 12
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, $2 ; 600
	shl  r1, 8
	or   r1, $58
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 20
	shl  r1, 8
	or   r1, $14
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shl  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3
	if   __while_0
	__end_1:


__loop_2:
	if   __loop_2
	add  rC, $3
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


__while_3:
	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 64
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_4


	sub  rC, 3
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 12
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6


	sub  rC, 3
	ld   r1, rB, -6 ; index
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, -6 ; index
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, -12


	let  r1, 65280
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -9 ; x
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -12 ; y
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 243
	shl  r1, 8
	or   r1, $F3
	pop  r2, rC
	st   r2, r1, 0, 1


	ld   r1, rB, -3 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -3
	add  rC, $9
	if   __while_3
	__end_4:


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -6


__while_5:
	ld   r1, rB, -6 ; a
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 64
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_6


	sub  rC, 3
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -6 ; a
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 12
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -9


	sub  rC, 3
	ld   r1, rB, -9 ; ai
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, -12


	sub  rC, 3
	ld   r1, rB, -9 ; ai
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, -15


	sub  rC, 3
	ld   r1, rB, -6 ; a
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -18


__while_7:
	ld   r1, rB, -18 ; b
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 64
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_8


	sub  rC, 3
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -18 ; b
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 12
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -21


	sub  rC, 3
	ld   r1, rB, -21 ; bi
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, -24


	sub  rC, 3
	ld   r1, rB, -21 ; bi
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	st   rB, r1, -27


	sub  rC, 3
	ld   r1, rB, -24 ; bx
	push rC, r1
	ld   r1, rB, -12 ; ax
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -30


	sub  rC, 3
	ld   r1, rB, -27 ; by
	push rC, r1
	ld   r1, rB, -15 ; ay
	pop  r2, rC
	sub  r1, r2, r1
	st   rB, r1, -33


	sub  rC, 6
	push rC, rB
	push rC, rA
	let  r1, $100 ; 65536
	shl  r1, 8
	or   r1, $0
	push rC, r1
	ld   r1, rB, -30 ; delta_x
	push rC, r1
	ld   r1, rB, -30 ; delta_x
	pop  r2, rC
	mul  r1, r2, r1
	push rC, r1
	ld   r1, rB, -33 ; delta_y
	push rC, r1
	ld   r1, rB, -33 ; delta_y
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	pop  r2, rC
	pop  r1, rC
	push rC, r2
	push rC, r1
	add  rA, rF, 9
	let  rD, div_mod[0:1]
	shl  rD, 8
	or   rF, rD, div_mod[2]
	add  rC, 6
	pop  rA, rC
	pop  rB, rC
	st   rB, r1, -36
	st   rB, r2, -39


	ld   r1, rB, -36 ; div
	push rC, r1
	let  r1, $1 ; 256
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	less r1, r1, r2
	if   r1, 12
	let  rD, __else_9[0:1]
	shl  rD, 8
	or   rF, rD, __else_9[2]


	let  r1, $1 ; 256
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -36
	let  rD, __end_10[0:1]
	shl  rD, 8
	or   rF, rD, __end_10[2]
	__else_9:
	__end_10:
	push rC, r1
	pop  r1, rC


	sub  rC, 3
	ld   r1, rB, -24 ; bx
	push rC, r1
	ld   r1, rB, -12 ; ax
	pop  r2, rC
	less r1, r1, r2
	if   r1, 12
	let  rD, __else_11[0:1]
	shl  rD, 8
	or   rF, rD, __else_11[2]


	ld   r1, rB, -36 ; div
	push rC, r1
	pop  r1, rC
	let  rD, __end_12[0:1]
	shl  rD, 8
	or   rF, rD, __end_12[2]
	__else_11:


	ld   r1, rB, -24 ; bx
	push rC, r1
	ld   r1, rB, -12 ; ax
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_13[0:1]
	shl  rD, 8
	or   rF, rD, __else_13[2]


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	let  rD, __end_14[0:1]
	shl  rD, 8
	or   rF, rD, __end_14[2]
	__else_13:


	ld   r1, rB, -36 ; div
	sub  r1, r0, r1
	push rC, r1
	pop  r1, rC
	__end_14:
	push rC, r1
	pop  r1, rC
	__end_12:
	st   rB, r1, -42


	sub  rC, 3
	ld   r1, rB, -27 ; by
	push rC, r1
	ld   r1, rB, -15 ; ay
	pop  r2, rC
	less r1, r1, r2
	if   r1, 12
	let  rD, __else_15[0:1]
	shl  rD, 8
	or   rF, rD, __else_15[2]


	ld   r1, rB, -36 ; div
	push rC, r1
	pop  r1, rC
	let  rD, __end_16[0:1]
	shl  rD, 8
	or   rF, rD, __end_16[2]
	__else_15:


	ld   r1, rB, -27 ; by
	push rC, r1
	ld   r1, rB, -15 ; ay
	pop  r2, rC
	sub  r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_17[0:1]
	shl  rD, 8
	or   rF, rD, __else_17[2]


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	push rC, r1
	pop  r1, rC
	let  rD, __end_18[0:1]
	shl  rD, 8
	or   rF, rD, __end_18[2]
	__else_17:


	ld   r1, rB, -36 ; div
	sub  r1, r0, r1
	push rC, r1
	pop  r1, rC
	__end_18:
	push rC, r1
	pop  r1, rC
	__end_16:
	st   rB, r1, -45


	ld   r1, rB, -9 ; ai
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -9 ; ai
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	ld   r1, rB, -42 ; signed_x
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -9 ; ai
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -9 ; ai
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	ld   r1, rB, -45 ; signed_y
	pop  r2, rC
	add  r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -21 ; bi
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -21 ; bi
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	ld   r1, rB, -42 ; signed_x
	pop  r2, rC
	sub  r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -21 ; bi
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -21 ; bi
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	ld   r1, rB, -45 ; signed_y
	pop  r2, rC
	sub  r1, r2, r1
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -18 ; b
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -18
	add  rC, $1B
	if   __while_7
	__end_8:


	ld   r1, rB, -6 ; a
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -6
	add  rC, $C
	if   __while_5
	__end_6:


	sub  rC, 3
	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -9


__while_19:
	ld   r1, rB, -9 ; i
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 64
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, __end_20


	sub  rC, 3
	let  r1, 32768
	shl  r1, 8
	or   r1, 0
	push rC, r1
	ld   r1, rB, -9 ; i
	push rC, r1
	let  r1, 0
	shl  r1, 8
	or   r1, 12
	pop  r2, rC
	mul  r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -12


	sub  rC, 3
	ld   r1, rB, -12 ; index
	ld   r1, 0, 3
	push rC, r1
	ld   r1, rB, -12 ; index
	push rC, r1
	let  r1, $0 ; 6
	shl  r1, 8
	or   r1, $6
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	ashr r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -15


	sub  rC, 3
	ld   r1, rB, -12 ; index
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	ld   r1, rB, -12 ; index
	push rC, r1
	let  r1, $0 ; 9
	shl  r1, 8
	or   r1, $9
	pop  r2, rC
	add  r1, r2, r1
	ld   r1, 0, 3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	ashr r1, r2, r1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -18


	ld   r1, rB, -15 ; x
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $40 ; 16384
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_21[0:1]
	shl  rD, 8
	or   rF, rD, __else_21[2]


	let  r1, $1 ; 319
	shl  r1, 8
	or   r1, $3F
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -15
	let  rD, __end_22[0:1]
	shl  rD, 8
	or   rF, rD, __end_22[2]
	__else_21:
	__end_22:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -15 ; x
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $1 ; 320
	shl  r1, 8
	or   r1, $40
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_23[0:1]
	shl  rD, 8
	or   rF, rD, __else_23[2]


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -15
	let  rD, __end_24[0:1]
	shl  rD, 8
	or   rF, rD, __end_24[2]
	__else_23:
	__end_24:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -18 ; y
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $40 ; 16384
	shl  r1, 8
	or   r1, $0
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_25[0:1]
	shl  rD, 8
	or   rF, rD, __else_25[2]


	let  r1, $0 ; 179
	shl  r1, 8
	or   r1, $B3
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shl  r1, r2, r1
	st   rB, r1, -18
	let  rD, __end_26[0:1]
	shl  rD, 8
	or   rF, rD, __end_26[2]
	__else_25:
	__end_26:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -18 ; y
	push rC, r1
	let  r1, $0 ; 8
	shl  r1, 8
	or   r1, $8
	pop  r2, rC
	shr  r1, r2, r1
	push rC, r1
	let  r1, $0 ; 180
	shl  r1, 8
	or   r1, $B4
	pop  r2, rC
	less r1, r2, r1
	less r1, 1
	if   r1, 12
	let  rD, __else_27[0:1]
	shl  rD, 8
	or   rF, rD, __else_27[2]


	let  r1, $0 ; 0
	shl  r1, 8
	or   r1, $0
	st   rB, r1, -18
	let  rD, __end_28[0:1]
	shl  rD, 8
	or   rF, rD, __end_28[2]
	__else_27:
	__end_28:
	push rC, r1
	pop  r1, rC


	ld   r1, rB, -12 ; index
	push rC, r1
	ld   r1, rB, -15 ; x
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -12 ; index
	push rC, r1
	let  r1, $0 ; 3
	shl  r1, 8
	or   r1, $3
	pop  r2, rC
	add  r1, r2, r1
	push rC, r1
	ld   r1, rB, -18 ; y
	pop  r2, rC
	st   r2, r1, 0, 3


	ld   r1, rB, -9 ; i
	push rC, r1
	let  r1, $0 ; 1
	shl  r1, 8
	or   r1, $1
	pop  r2, rC
	add  r1, r2, r1
	st   rB, r1, -9
	add  rC, $9
	if   __while_19
	__end_20:
	add  rC, $9
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