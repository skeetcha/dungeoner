;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module sprite_loader
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _load_fighter_sprites
	.globl _load_rogue_sprites
	.globl _set_sprite_data
	.globl _load_sprites
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
;res/sprite_loader.c:6: void load_rogue_sprites(void) {
;	---------------------------------
; Function load_rogue_sprites
; ---------------------------------
_load_rogue_sprites::
;res/sprite_loader.c:8: set_sprite_data(offset, offset + 4, rogueTLE0); // [0,4)
	ld	de, #_rogueTLE0
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:10: set_sprite_data(offset, offset + 4, rogueTLE1); // [4,8)
	ld	de, #_rogueTLE1
	push	de
	ld	hl, #0x804
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:12: set_sprite_data(offset, offset + 4, rogueTLE2); // [8,12)
	ld	de, #_rogueTLE2
	push	de
	ld	hl, #0xc08
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:14: set_sprite_data(offset, offset + 4, rogueTLE3); // [12,16)
	ld	de, #_rogueTLE3
	push	de
	ld	hl, #0x100c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:16: set_sprite_data(offset, offset + 4, rogueTLE4); // [16,20)
	ld	de, #_rogueTLE4
	push	de
	ld	hl, #0x1410
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:18: set_sprite_data(offset, offset + 4, rogueTLE5); // [20,24)
	ld	de, #_rogueTLE5
	push	de
	ld	hl, #0x1814
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:20: set_sprite_data(offset, offset + 4, rogueTLE6); // [24,28)
	ld	de, #_rogueTLE6
	push	de
	ld	hl, #0x1c18
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:22: set_sprite_data(offset, offset + 4, rogueTLE7); // [28,32)
	ld	de, #_rogueTLE7
	push	de
	ld	hl, #0x201c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:24: set_sprite_data(offset, offset + 4, rogueTLE8); // [32,36)
	ld	de, #_rogueTLE8
	push	de
	ld	hl, #0x2420
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:25: }
	ret
;res/sprite_loader.c:27: void load_fighter_sprites(void) {
;	---------------------------------
; Function load_fighter_sprites
; ---------------------------------
_load_fighter_sprites::
;res/sprite_loader.c:29: set_sprite_data(offset, offset + 4, fighterTLE0); // [36,40)
	ld	de, #_fighterTLE0
	push	de
	ld	hl, #0x2824
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:31: set_sprite_data(offset, offset + 4, fighterTLE1); // [40,44)
	ld	de, #_fighterTLE1
	push	de
	ld	hl, #0x2c28
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:33: set_sprite_data(offset, offset + 4, fighterTLE2); // [44,48)
	ld	de, #_fighterTLE2
	push	de
	ld	hl, #0x302c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:35: set_sprite_data(offset, offset + 4, fighterTLE3); // [48,52)
	ld	de, #_fighterTLE3
	push	de
	ld	hl, #0x3430
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:37: set_sprite_data(offset, offset + 4, fighterTLE4); // [52,56)
	ld	de, #_fighterTLE4
	push	de
	ld	hl, #0x3834
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:39: set_sprite_data(offset, offset + 4, fighterTLE5); // [56,60)
	ld	de, #_fighterTLE5
	push	de
	ld	hl, #0x3c38
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:41: set_sprite_data(offset, offset + 4, fighterTLE6); // [60,64)
	ld	de, #_fighterTLE6
	push	de
	ld	hl, #0x403c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:43: set_sprite_data(offset, offset + 4, fighterTLE7); // [64,68)
	ld	de, #_fighterTLE7
	push	de
	ld	hl, #0x4440
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:45: set_sprite_data(offset, offset + 4, fighterTLE8); // [68,72)
	ld	de, #_fighterTLE8
	push	de
	ld	hl, #0x4844
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:46: }
	ret
;res/sprite_loader.c:48: void load_sprites(void) {
;	---------------------------------
; Function load_sprites
; ---------------------------------
_load_sprites::
;res/sprite_loader.c:49: load_rogue_sprites();
	call	_load_rogue_sprites
;res/sprite_loader.c:50: load_fighter_sprites();
;res/sprite_loader.c:51: }
	jp	_load_fighter_sprites
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
