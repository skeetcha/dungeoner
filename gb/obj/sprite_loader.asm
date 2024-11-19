;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module sprite_loader
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
;res/sprite_loader.c:5: void load_rogue_sprites(void) {
;	---------------------------------
; Function load_rogue_sprites
; ---------------------------------
_load_rogue_sprites::
;res/sprite_loader.c:7: set_sprite_data(offset, offset + 4, rogueTLE0);
	ld	de, #_rogueTLE0
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:9: set_sprite_data(offset, offset + 4, rogueTLE1);
	ld	de, #_rogueTLE1
	push	de
	ld	hl, #0x804
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:11: set_sprite_data(offset, offset + 4, rogueTLE2);
	ld	de, #_rogueTLE2
	push	de
	ld	hl, #0xc08
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:13: set_sprite_data(offset, offset + 4, rogueTLE3);
	ld	de, #_rogueTLE3
	push	de
	ld	hl, #0x100c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:15: set_sprite_data(offset, offset + 4, rogueTLE4);
	ld	de, #_rogueTLE4
	push	de
	ld	hl, #0x1410
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:17: set_sprite_data(offset, offset + 4, rogueTLE5);
	ld	de, #_rogueTLE5
	push	de
	ld	hl, #0x1814
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:19: set_sprite_data(offset, offset + 4, rogueTLE6);
	ld	de, #_rogueTLE6
	push	de
	ld	hl, #0x1c18
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:21: set_sprite_data(offset, offset + 4, rogueTLE7);
	ld	de, #_rogueTLE7
	push	de
	ld	hl, #0x201c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:23: set_sprite_data(offset, offset + 4, rogueTLE8);
	ld	de, #_rogueTLE8
	push	de
	ld	hl, #0x2420
	push	hl
	call	_set_sprite_data
	add	sp, #4
;res/sprite_loader.c:24: }
	ret
;res/sprite_loader.c:26: void load_sprites(void) {
;	---------------------------------
; Function load_sprites
; ---------------------------------
_load_sprites::
;res/sprite_loader.c:27: load_rogue_sprites();
;res/sprite_loader.c:28: }
	jp	_load_rogue_sprites
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
