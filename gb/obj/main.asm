;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_door
	.globl _load_sprites
	.globl _initarand
	.globl _puts
	.globl _printf
	.globl _free_dungeon
	.globl _generate_dungeon
	.globl _init_dungeon
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _vsync
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
	.globl _run
	.globl _joypad_last
	.globl _joypad_current
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
_joypad_current::
	.ds 2
_joypad_last::
	.ds 2
_run::
	.ds 1
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
;src/main.c:12: void set_door(int direction) {
;	---------------------------------
; Function set_door
; ---------------------------------
_set_door::
;src/main.c:13: switch (direction) {
	ld	a, e
	sub	a, #0x04
	or	a, d
	jr	Z, 00101$
	ld	a, e
	sub	a, #0x08
	or	a, d
	jr	Z, 00104$
	ld	a, e
	sub	a, #0x10
	or	a, d
	jr	Z, 00102$
	ld	a, e
	sub	a, #0x20
	or	a, d
	jr	Z, 00103$
	ret
;src/main.c:14: case BIT_DOOR_NORTH:
00101$:
;src/main.c:15: set_bkg_tiles(dungeon_north_door_index_x, dungeon_north_door_index_y, 1, 1, door);
	ld	de, #_door
	push	de
	ld	hl, #0x101
	push	hl
	ld	hl, #0x109
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:16: break;
	ret
;src/main.c:17: case BIT_DOOR_SOUTH:
00102$:
;src/main.c:18: set_bkg_tiles(dungeon_south_door_index_x, dungeon_south_door_index_y, 1, 1, door);
	ld	de, #_door
	push	de
	ld	hl, #0x101
	push	hl
	ld	hl, #0xf09
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:19: break;
	ret
;src/main.c:20: case BIT_DOOR_WEST:
00103$:
;src/main.c:21: set_bkg_tiles(dungeon_west_door_index_x, dungeon_west_door_index_y, 1, 1, door);
	ld	de, #_door
	push	de
	ld	hl, #0x101
	push	hl
	ld	hl, #0x802
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:22: break;
	ret
;src/main.c:23: case BIT_DOOR_EAST:
00104$:
;src/main.c:24: set_bkg_tiles(dungeon_east_door_index_x, dungeon_east_door_index_y, 1, 1, door);
	ld	de, #_door
	push	de
	ld	hl, #0x101
	push	hl
	ld	hl, #0x810
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:26: }
;src/main.c:27: }
	ret
;src/main.c:33: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-8
;src/main.c:34: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:35: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:36: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:40: printf("Push any key (1)\n");
	ld	de, #___str_1
	call	_puts
;src/main.c:41: waitpad(0xff);
	ld	a, #0xff
	call	_waitpad
;src/main.c:42: waitpadup();
	call	_waitpadup
;src/main.c:43: seed = DIV_REG;
	ldh	a, (_DIV_REG + 0)
	ld	c, a
	ld	b, #0x00
;src/main.c:44: printf("Push any key (2)\n");
	push	bc
	ld	de, #___str_3
	call	_puts
	pop	bc
;src/main.c:45: waitpad(0xff);
	ld	a, #0xff
	call	_waitpad
;src/main.c:46: waitpadup();
	call	_waitpadup
;src/main.c:47: seed |= (UWORD)DIV_REG << 8;
	ldh	a, (_DIV_REG + 0)
	ld	b, a
;src/main.c:48: printf("%u", seed);
	push	bc
	push	bc
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
	call	_initarand
	pop	hl
;src/main.c:51: set_bkg_data(0, 14, dungeon_tiles);
	ld	de, #_dungeon_tiles
	push	de
	ld	hl, #0xe00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:52: set_bkg_tiles(0, 0, dungeon_room_width, dungeon_room_height, dungeon_room);
	ld	de, #_dungeon_room
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:55: init_dungeon(&dungeon, 6, 6);
	ld	de, #0x0006
	push	de
	ld	bc, #0x0006
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_init_dungeon
;src/main.c:56: generate_dungeon(&dungeon);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_generate_dungeon
;src/main.c:57: uint8_t room = dungeon.grid[dungeon.entrance];
	pop	bc
	push	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, (hl)
;src/main.c:59: if (HAS_NORTH_DOOR(room)) {
	ld	a, c
	and	a, #0x04
	sub	a, #0x04
	jr	NZ, 00102$
;src/main.c:60: set_door(BIT_DOOR_NORTH);
	push	bc
	ld	de, #0x0004
	call	_set_door
	pop	bc
00102$:
;src/main.c:63: if (HAS_WEST_DOOR(room)) {
	ld	a, c
	and	a, #0x20
	sub	a, #0x20
	jr	NZ, 00104$
;src/main.c:64: set_door(BIT_DOOR_WEST);
	push	bc
	ld	de, #0x0020
	call	_set_door
	pop	bc
00104$:
;src/main.c:67: if (HAS_EAST_DOOR(room)) {
	ld	a, c
	and	a, #0x08
	sub	a, #0x08
	jr	NZ, 00106$
;src/main.c:68: set_door(BIT_DOOR_EAST);
	push	bc
	ld	de, #0x0008
	call	_set_door
	pop	bc
00106$:
;src/main.c:71: if (HAS_SOUTH_DOOR(room)) {
	ld	a, c
	and	a, #0x10
	sub	a, #0x10
	jr	NZ, 00108$
;src/main.c:72: set_door(BIT_DOOR_SOUTH);
	ld	de, #0x0010
	call	_set_door
00108$:
;src/main.c:75: load_sprites();
	call	_load_sprites
;src/main.c:77: while (run) {
00111$:
	ld	hl, #_run
	bit	0, (hl)
	jr	Z, 00113$
;src/main.c:78: joypad_current = joypad();
	call	_joypad
	ld	hl, #_joypad_current
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:80: if (joypad_current & J_SELECT) {
	push	hl
	dec	hl
	bit	6, (hl)
	pop	hl
	jr	Z, 00110$
;src/main.c:81: run = false;
	ld	hl, #_run
	ld	(hl), #0x00
00110$:
;src/main.c:84: vsync();
	call	_vsync
;src/main.c:85: joypad_last = joypad_current;
	ld	a, (#_joypad_current)
	ld	(#_joypad_last),a
	ld	a, (#_joypad_current + 1)
	ld	(#_joypad_last + 1),a
	jr	00111$
00113$:
;src/main.c:88: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/main.c:89: DISPLAY_OFF;
	call	_display_off
;src/main.c:90: free_dungeon(&dungeon);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_free_dungeon
;src/main.c:91: printf("Game closed.");
	ld	de, #___str_5
	push	de
	call	_printf
	pop	hl
;src/main.c:92: }
	add	sp, #8
	ret
___str_1:
	.ascii "Push any key (1)"
	.db 0x00
___str_3:
	.ascii "Push any key (2)"
	.db 0x00
___str_4:
	.ascii "%u"
	.db 0x00
___str_5:
	.ascii "Game closed."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__joypad_current:
	.dw #0x0000
__xinit__joypad_last:
	.dw #0x0000
__xinit__run:
	.db #0x01	;  1
	.area _CABS (ABS)
