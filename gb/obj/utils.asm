;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module utils
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rand
	.globl _roll
	.globl _rand_range
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/utils.c:5: RollResult roll(unsigned int die_amount, unsigned int die_type, int bonus) {
;	---------------------------------
; Function roll
; ---------------------------------
_roll::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils.c:7: bool crit_success = false;
	ldhl	sp,	#4
;src/utils.c:8: bool crit_failure = false;
	xor	a, a
	ld	(hl+), a
;src/utils.c:10: for (int i = 0; i < die_amount; i++) {
	ld	bc, #0x0000
	ld	(hl), c
00110$:
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jr	NC, 00106$
;src/utils.c:11: unsigned int val = rand_range(1, die_type);
	push	bc
	push	de
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x0001
	call	_rand_range
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
;src/utils.c:13: if (val == 20) {
	ld	a, l
	sub	a, #0x14
	or	a, h
	jr	NZ, 00104$
;src/utils.c:14: crit_success = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
	jr	00111$
00104$:
;src/utils.c:15: } else if (val == 1) {
	ld	a, l
	dec	a
	or	a, h
	jr	NZ, 00111$
;src/utils.c:16: crit_failure = true;
	ldhl	sp,	#5
	ld	(hl), #0x01
00111$:
;src/utils.c:10: for (int i = 0; i < die_amount; i++) {
	inc	bc
	jr	00110$
00106$:
;src/utils.c:20: if (bonus > ((int)sum * -1)) {
	ldhl	sp,	#12
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00154$
	bit	7, d
	jr	NZ, 00155$
	cp	a, a
	jr	00155$
00154$:
	bit	7, d
	jr	Z, 00155$
	scf
00155$:
	jr	NC, 00108$
;src/utils.c:22: crit_success = false;
	ldhl	sp,	#4
;src/utils.c:23: crit_failure = false;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00108$:
;src/utils.c:27: r.result = sum + bonus;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	sp
	inc	sp
	push	bc
;src/utils.c:28: r.crit_success = crit_success;
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/utils.c:29: r.crit_failure = crit_failure;
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/utils.c:30: return r;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/utils.c:31: }
	add	sp, #8
	pop	hl
	add	sp, #4
	jp	(hl)
;src/utils.c:33: unsigned int rand_range(unsigned int min, unsigned int max) {
;	---------------------------------
; Function rand_range
; ---------------------------------
_rand_range::
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;src/utils.c:34: return rand() % (max - min) + min;
	push	de
	push	bc
	call	_rand
	pop	bc
	pop	hl
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	d, #0x00
	push	hl
	call	__moduint
	pop	hl
	add	hl, bc
	ld	c, l
	ld	b, h
;src/utils.c:35: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
