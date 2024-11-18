;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module encounter
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _calloc
	.globl _rand_range
	.globl _generate_encounter
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
;src/encounter.c:8: Monster* generate_encounter(UBYTE difficulty) {
;	---------------------------------
; Function generate_encounter
; ---------------------------------
_generate_encounter::
	add	sp, #-6
	ld	c, a
;src/encounter.c:9: unsigned int monster_num = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;src/encounter.c:11: switch (difficulty) {
	ld	a, #0x04
	sub	a, c
	jr	C, 00106$
	ld	b, #0x00
	ld	hl, #00135$
	add	hl, bc
	add	hl, bc
	add	hl, bc
	jp	(hl)
00135$:
	jp	00101$
	jp	00102$
	jp	00103$
	jp	00104$
	jp	00105$
;src/encounter.c:12: case DIFFICULTY_TRIVIAL:
00101$:
;src/encounter.c:13: monster_num = 2;
	ldhl	sp,	#0
	ld	a, #0x02
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/encounter.c:14: break;
	jr	00106$
;src/encounter.c:15: case DIFFICULTY_LOW:
00102$:
;src/encounter.c:16: monster_num = 3;
	ldhl	sp,	#0
	ld	a, #0x03
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/encounter.c:17: break;
	jr	00106$
;src/encounter.c:18: case DIFFICULTY_MODERATE:
00103$:
;src/encounter.c:19: monster_num = rand_range(4, 5);
	ld	bc, #0x0005
	ld	de, #0x0004
	call	_rand_range
	pop	hl
	push	bc
;src/encounter.c:20: break;
	jr	00106$
;src/encounter.c:21: case DIFFICULTY_SEVERE:
00104$:
;src/encounter.c:22: monster_num = rand_range(6, 7);
	ld	bc, #0x0007
	ld	de, #0x0006
	call	_rand_range
	pop	hl
	push	bc
;src/encounter.c:23: break;
	jr	00106$
;src/encounter.c:24: case DIFFICULTY_EXTREME:
00105$:
;src/encounter.c:25: monster_num = rand_range(8, 9);
	ld	bc, #0x0009
	ld	de, #0x0008
	call	_rand_range
	pop	hl
	push	bc
;src/encounter.c:27: }
00106$:
;src/encounter.c:29: Monster* monsters = (Monster*)calloc(monster_num, sizeof(Monster));
	ld	bc, #0x0014
	pop	de
	push	de
	call	_calloc
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
;src/encounter.c:31: for (int i = 0; i < monster_num; i++) {
	ld	a, b
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00109$:
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00107$
;src/encounter.c:32: monsters[i] = goblin;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	bc, #0x0014
	push	bc
	ld	bc, #_goblin
	call	___memcpy
;src/encounter.c:31: for (int i = 0; i < monster_num; i++) {
	ldhl	sp,	#4
	inc	(hl)
	jr	NZ, 00109$
	inc	hl
	inc	(hl)
	jr	00109$
00107$:
;src/encounter.c:35: return monsters;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/encounter.c:36: }
	add	sp, #6
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
