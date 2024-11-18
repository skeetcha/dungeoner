;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module character
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _Character_is_valid
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
;src/character.c:4: bool Character_is_valid(Character ch) {
;	---------------------------------
; Function Character_is_valid
; ---------------------------------
_Character_is_valid::
;src/character.c:5: if (ch.ancestry == DWARF) {
	ldhl	sp,	#3
	ld	c, (hl)
;src/character.c:6: return ((ch.heritage >= DWARF_ANCIENT_BLOOD) && (ch.heritage <= DWARF_STRONG_BLOODED)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	hl,#0x4
	add	hl,sp
;src/character.c:5: if (ch.ancestry == DWARF) {
	ld	a, c
	or	a, a
	jr	NZ, 00122$
;src/character.c:6: return ((ch.heritage >= DWARF_ANCIENT_BLOOD) && (ch.heritage <= DWARF_STRONG_BLOODED)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	c, (hl)
	ld	a, #0x04
	sub	a, c
	jr	NC, 00127$
	ld	a,c
	cp	a,#0x2c
	jr	Z, 00127$
	cp	a,#0x2d
	jr	Z, 00127$
	cp	a,#0x2e
	jr	Z, 00127$
	cp	a,#0x2f
	jr	Z, 00127$
	sub	a, #0x30
	jr	Z, 00127$
	xor	a, a
	jp	00124$
00127$:
	ld	a, #0x01
	jp	00124$
00122$:
;src/character.c:7: } else if (ch.ancestry == ELF) {
	ld	a, c
	dec	a
	jr	NZ, 00119$
;src/character.c:8: return ((ch.heritage >= ELF_ANCIENT) && (ch.heritage <= ELF_WOODLAND)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	c, (hl)
	ld	a, c
	sub	a, #0x05
	jr	C, 00161$
	ld	a, #0x0a
	sub	a, c
	jr	NC, 00145$
00161$:
	ld	a,c
	cp	a,#0x2c
	jr	Z, 00145$
	cp	a,#0x2d
	jr	Z, 00145$
	cp	a,#0x2e
	jr	Z, 00145$
	cp	a,#0x2f
	jr	Z, 00145$
	sub	a, #0x30
	jr	Z, 00145$
	xor	a, a
	jp	00124$
00145$:
	ld	a, #0x01
	jp	00124$
00119$:
;src/character.c:9: } else if (ch.ancestry == GNOME) {
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00116$
;src/character.c:10: return ((ch.heritage >= GNOME_CHAMELEON) && (ch.heritage <= GNOME_WELLSPRING)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	c, (hl)
	ld	a, c
	sub	a, #0x0b
	jr	C, 00179$
	ld	a, #0x0f
	sub	a, c
	jr	NC, 00163$
00179$:
	ld	a,c
	cp	a,#0x2c
	jr	Z, 00163$
	cp	a,#0x2d
	jr	Z, 00163$
	cp	a,#0x2e
	jr	Z, 00163$
	cp	a,#0x2f
	jr	Z, 00163$
	sub	a, #0x30
	jr	Z, 00163$
	xor	a, a
	jp	00124$
00163$:
	ld	a, #0x01
	jp	00124$
00116$:
;src/character.c:11: } else if (ch.ancestry == GOBLIN) {
	ld	a, c
	sub	a, #0x03
	jr	NZ, 00113$
;src/character.c:12: return ((ch.heritage >= GOBLIN_CHARHIDE) && (ch.heritage <= GOBLIN_UNBREAKABLE)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	c, (hl)
	ld	a, c
	sub	a, #0x10
	jr	C, 00197$
	ld	a, #0x14
	sub	a, c
	jr	NC, 00181$
00197$:
	ld	a,c
	cp	a,#0x2c
	jr	Z, 00181$
	cp	a,#0x2d
	jr	Z, 00181$
	cp	a,#0x2e
	jr	Z, 00181$
	cp	a,#0x2f
	jr	Z, 00181$
	sub	a, #0x30
	jr	Z, 00181$
	xor	a, a
	jp	00124$
00181$:
	ld	a, #0x01
	jp	00124$
00113$:
;src/character.c:13: } else if (ch.ancestry == HALFLING) {
	ld	a, c
	sub	a, #0x04
	jr	NZ, 00110$
;src/character.c:14: return ((ch.heritage >= HALFLING_GUTSY) && (ch.heritage <= HALFLING_WILDWOOD)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	c, (hl)
	ld	a, c
	sub	a, #0x15
	jr	C, 00215$
	ld	a, #0x19
	sub	a, c
	jr	NC, 00199$
00215$:
	ld	a,c
	cp	a,#0x2c
	jr	Z, 00199$
	cp	a,#0x2d
	jr	Z, 00199$
	cp	a,#0x2e
	jr	Z, 00199$
	cp	a,#0x2f
	jr	Z, 00199$
	sub	a, #0x30
	jr	Z, 00199$
	xor	a, a
	jp	00124$
00199$:
	ld	a, #0x01
	jp	00124$
00110$:
;src/character.c:15: } else if (ch.ancestry == HUMAN) {
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00107$
;src/character.c:16: return (ch.heritage == HUMAN_SKILLED) || (ch.heritage == HUMAN_VERSATILE) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	a, (hl)
	cp	a, #0x1a
	jr	Z, 00217$
	cp	a, #0x1b
	jr	Z, 00217$
	cp	a, #0x2c
	jr	Z, 00217$
	cp	a, #0x2d
	jr	Z, 00217$
	cp	a, #0x2e
	jr	Z, 00217$
	cp	a, #0x2f
	jr	Z, 00217$
	sub	a, #0x30
	jr	Z, 00217$
	xor	a, a
	jr	00124$
00217$:
	ld	a, #0x01
	jr	00124$
00107$:
;src/character.c:17: } else if (ch.ancestry == LESHY) {
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00104$
;src/character.c:18: return ((ch.heritage >= LESHY_CACTUS) && (ch.heritage <= LESHY_VINE)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	c, (hl)
	ld	a, c
	sub	a, #0x1c
	jr	C, 00251$
	ld	a, #0x24
	sub	a, c
	jr	NC, 00235$
00251$:
	ld	a,c
	cp	a,#0x2c
	jr	Z, 00235$
	cp	a,#0x2d
	jr	Z, 00235$
	cp	a,#0x2e
	jr	Z, 00235$
	cp	a,#0x2f
	jr	Z, 00235$
	sub	a, #0x30
	jr	Z, 00235$
	xor	a, a
	jr	00124$
00235$:
	ld	a, #0x01
	jr	00124$
00104$:
;src/character.c:19: } else if (ch.ancestry == ORC) {
	ld	a, c
	sub	a, #0x07
	jr	NZ, 00108$
;src/character.c:20: return ((ch.heritage >= ORC_BADLANDS) && (ch.heritage <= ORC_WINTER)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
	ld	c, (hl)
	ld	a, c
	sub	a, #0x25
	jr	C, 00269$
	ld	a, #0x2b
	sub	a, c
	jr	NC, 00253$
00269$:
	ld	a,c
	cp	a,#0x2c
	jr	Z, 00253$
	cp	a,#0x2d
	jr	Z, 00253$
	cp	a,#0x2e
	jr	Z, 00253$
	cp	a,#0x2f
	jr	Z, 00253$
	sub	a, #0x30
	jr	Z, 00253$
	xor	a, a
	jr	00124$
00253$:
	ld	a, #0x01
	jr	00124$
00108$:
;src/character.c:23: return false;
	xor	a, a
00124$:
;src/character.c:24: }
	pop	hl
	add	sp, #3
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
