;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module dungeon
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rand_range
	.globl _free
	.globl _calloc
	.globl _neighbors
	.globl _init_dungeon
	.globl _generate_dungeon
	.globl _generate_room
	.globl _room_has_door
	.globl _get_opposite_direction_bit
	.globl _get_neighbor_room_index
	.globl _free_dungeon
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
_neighbors::
	.ds 2
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
;src/dungeon.c:14: void init_dungeon(Dungeon* d, const int width, const int height) {
;	---------------------------------
; Function init_dungeon
; ---------------------------------
_init_dungeon::
	push	bc
;src/dungeon.c:15: d->width = width;
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/dungeon.c:16: d->height = height;
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
;src/dungeon.c:17: d->grid = (uint8_t*)calloc(width * height, sizeof(uint8_t));
	ld	a, (hl-)
	ld	(bc), a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	ld	bc, #0x0001
	ld	e, l
	ld	d, h
	call	_calloc
	pop	de
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;src/dungeon.c:18: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/dungeon.c:20: void generate_dungeon(Dungeon* d) {
;	---------------------------------
; Function generate_dungeon
; ---------------------------------
_generate_dungeon::
	add	sp, #-15
	ldhl	sp,	#11
	ld	a, e
	ld	(hl+), a
;src/dungeon.c:23: int dungeon_area = d->width * d->height;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/dungeon.c:24: int* generated_cells = (int*)calloc(dungeon_area, sizeof(int));
	call	__mulint
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	bc, #0x0002
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_calloc
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/dungeon.c:25: generated_cells_number = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
;src/dungeon.c:27: for (i = 0; (generated_cells_number < dungeon_area) && ((i == 0) || (i < generated_cells_number)); i++) {
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#8
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), a
00113$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	NC, 00109$
	ldhl	sp,	#14
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00112$
	ldhl	sp,	#13
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00109$
00112$:
;src/dungeon.c:28: if ((i == 0) && (generated_cells_number == 0)) {
	ldhl	sp,	#14
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
	ldhl	sp,	#1
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;src/dungeon.c:29: entrance = rand_range(0, dungeon_area);
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x0000
	call	_rand_range
;src/dungeon.c:30: generated_cells[0] = entrance;
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/dungeon.c:31: d->grid[entrance] = BIT_ENTRANCE | BIT_USED_ROOM;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	(hl), #0x03
;src/dungeon.c:32: d->entrance = entrance;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/dungeon.c:33: generated_cells_number = 1;
	ldhl	sp,	#0
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00102$:
;src/dungeon.c:36: generate_room(d, i, generated_cells, &generated_cells_number);
	ldhl	sp,	#0
	push	hl
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_generate_room
;src/dungeon.c:31: d->grid[entrance] = BIT_ENTRANCE | BIT_USED_ROOM;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/dungeon.c:38: if (!(d->grid[generated_cells[i]] & BIT_USED_ROOM)) {
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	d, (hl)
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	bit	0, a
	jr	NZ, 00105$
;src/dungeon.c:39: d->grid[generated_cells[i]] |= BIT_USED_ROOM;
	set	0, a
	ld	(bc), a
00105$:
;src/dungeon.c:42: if ((i == (generated_cells_number - 1)) && (generated_cells_number < (dungeon_area / 4 * 3))) {
	pop	bc
	push	bc
	dec	bc
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00114$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00114$
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00117$:
	sra	b
	rr	c
	sra	b
	rr	c
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00109$
;src/dungeon.c:43: break;
00114$:
;src/dungeon.c:27: for (i = 0; (generated_cells_number < dungeon_area) && ((i == 0) || (i < generated_cells_number)); i++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	NZ,00113$
	inc	hl
	inc	(hl)
	jp	00113$
00109$:
;src/dungeon.c:47: free(generated_cells);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_free
;src/dungeon.c:48: }
	add	sp, #15
	ret
;src/dungeon.c:50: void generate_room(Dungeon* d, unsigned int cell_index_queue, int* cells_queue, unsigned int* queue_size) {
;	---------------------------------
; Function generate_room
; ---------------------------------
_generate_room::
	add	sp, #-12
	ldhl	sp,	#8
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/dungeon.c:52: potential_doors = rand_range(0, neighbors);
	push	bc
	ld	hl, #_neighbors
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x0000
	call	_rand_range
	ld	e, c
	ld	d, b
	pop	bc
	inc	sp
	inc	sp
	push	de
;src/dungeon.c:53: unsigned int cell_index = cells_queue[cell_index_queue];
	sla	c
	rl	b
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/dungeon.c:57: for (door = 1; door <= neighbors; door <<= 1) {
	ldhl	sp,	#10
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00114$:
	ld	de, #_neighbors
	ldhl	sp,	#10
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00174$
	bit	7, d
	jr	NZ, 00175$
	cp	a, a
	jr	00175$
00174$:
	bit	7, d
	jr	Z, 00175$
	scf
00175$:
	jp	C, 00115$
;src/dungeon.c:58: if (((door & neighbors) != door) || (d->grid[cell_index] & door)) {
	ldhl	sp,	#10
	ld	a, (hl)
	ld	hl, #_neighbors
	and	a, (hl)
	ld	c, a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	hl, #_neighbors + 1
	and	a, (hl)
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, c
	jp	NZ,00111$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jp	NZ,00111$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	b, #0x00
	ldhl	sp,	#10
	and	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	and	a, (hl)
	or	a, c
	jp	NZ, 00111$
;src/dungeon.c:62: int neighbor_room = get_neighbor_room_index(d, cell_index, door);
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_get_neighbor_room_index
;src/dungeon.c:64: if ((!~neighbor_room) || (d->grid[neighbor_room] & BIT_USED_ROOM)) {
	ld	a, c
	cpl
	ld	e, a
	ld	a, b
	cpl
	or	a, e
	jp	Z, 00111$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	a, (hl)
	rrca
	jp	C,00111$
;src/dungeon.c:68: opposite_door = get_opposite_direction_bit(door);
	push	bc
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_get_opposite_direction_bit
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	bc
;src/dungeon.c:70: if ((door & potential_doors) == door) {
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#0
	and	a, (hl)
	ld	e, a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#1
	and	a, (hl)
	ld	d, a
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00108$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00108$
;src/dungeon.c:71: d->grid[cell_index] |= door;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#10
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	or	a, l
	ld	(de), a
;src/dungeon.c:72: d->grid[neighbor_room] |= opposite_door;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#4
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	or	a, l
	ld	(de), a
00108$:
;src/dungeon.c:75: if (d->grid[neighbor_room] == opposite_door) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00111$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00111$
;src/dungeon.c:76: cells_queue[*queue_size] = neighbor_room;
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;src/dungeon.c:77: (*queue_size) += 1;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	inc	bc
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00111$:
;src/dungeon.c:57: for (door = 1; door <= neighbors; door <<= 1) {
	ldhl	sp,	#10
	sla	(hl)
	inc	hl
	rl	(hl)
	jp	00114$
00115$:
;src/dungeon.c:80: }
	add	sp, #12
	pop	hl
	add	sp, #4
	jp	(hl)
;src/dungeon.c:82: bool room_has_door(Dungeon* dungeon, int room, int direction) {
;	---------------------------------
; Function room_has_door
; ---------------------------------
_room_has_door::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/dungeon.c:83: int needed_bit = direction;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/dungeon.c:84: return (dungeon->grid[room] & needed_bit) == needed_bit;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	pop	de
	push	de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, #0x00
	and	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, e
	and	a, b
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	sub	a, c
	jr	NZ, 00103$
	ld	a, h
	sub	a, b
	ld	a, #0x01
	jr	Z, 00104$
00103$:
	xor	a, a
00104$:
;src/dungeon.c:85: }
	add	sp, #6
	pop	hl
	pop	bc
	jp	(hl)
;src/dungeon.c:87: int get_opposite_direction_bit(int direction) {
;	---------------------------------
; Function get_opposite_direction_bit
; ---------------------------------
_get_opposite_direction_bit::
;src/dungeon.c:88: int opposite_direction = -1;
	ld	bc, #0xffff
;src/dungeon.c:90: switch (direction) {
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
	jr	Z, 00103$
	ld	a, e
	sub	a, #0x20
	or	a, d
	jr	Z, 00102$
	ret
;src/dungeon.c:91: case BIT_DOOR_NORTH:
00101$:
;src/dungeon.c:92: opposite_direction = BIT_DOOR_SOUTH;
	ld	bc, #0x0010
;src/dungeon.c:93: break;
	ret
;src/dungeon.c:94: case BIT_DOOR_WEST:
00102$:
;src/dungeon.c:95: opposite_direction = BIT_DOOR_EAST;
	ld	bc, #0x0008
;src/dungeon.c:96: break;
	ret
;src/dungeon.c:97: case BIT_DOOR_SOUTH:
00103$:
;src/dungeon.c:98: opposite_direction = BIT_DOOR_NORTH;
	ld	bc, #0x0004
;src/dungeon.c:99: break;
	ret
;src/dungeon.c:100: case BIT_DOOR_EAST:
00104$:
;src/dungeon.c:101: opposite_direction = BIT_DOOR_WEST;
	ld	bc, #0x0020
;src/dungeon.c:103: }
;src/dungeon.c:105: return opposite_direction;
;src/dungeon.c:106: }
	ret
;src/dungeon.c:108: int get_neighbor_room_index(Dungeon* dungeon, int current_room, int direction) {
;	---------------------------------
; Function get_neighbor_room_index
; ---------------------------------
_get_neighbor_room_index::
	add	sp, #-14
	ldhl	sp,	#12
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
;src/dungeon.c:110: width = dungeon->width;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/dungeon.c:111: height = dungeon->height;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/dungeon.c:113: switch (direction) {
	ldhl	sp,	#16
	ld	a, (hl+)
	sub	a, #0x04
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00175$
	xor	a, a
00175$:
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl+)
	sub	a, #0x08
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00177$
	xor	a, a
00177$:
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl+)
	sub	a, #0x10
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00179$
	xor	a, a
00179$:
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl+)
	sub	a, #0x20
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00181$
	xor	a, a
00181$:
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	NZ, 00101$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00103$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00104$
	jr	00105$
;src/dungeon.c:114: case BIT_DOOR_NORTH:
00101$:
;src/dungeon.c:115: neighbor_room = current_room - width;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
;src/dungeon.c:116: break;
	jr	00106$
;src/dungeon.c:117: case BIT_DOOR_EAST:
00102$:
;src/dungeon.c:118: neighbor_room = current_room + 1;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/dungeon.c:119: break;
	jr	00106$
;src/dungeon.c:120: case BIT_DOOR_SOUTH:
00103$:
;src/dungeon.c:121: neighbor_room = current_room + width;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/dungeon.c:122: break;
	jr	00106$
;src/dungeon.c:123: case BIT_DOOR_WEST:
00104$:
;src/dungeon.c:124: neighbor_room = current_room - 1;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
;src/dungeon.c:125: break;
	jr	00106$
;src/dungeon.c:126: default:
00105$:
;src/dungeon.c:127: neighbor_room = -1;
	ldhl	sp,	#8
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
;src/dungeon.c:128: }
00106$:
;src/dungeon.c:131: ((direction == BIT_DOOR_NORTH) && (neighbor_room >= 0))
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
	ldhl	sp,	#9
	bit	7, (hl)
	jp	Z, 00107$
00111$:
;src/dungeon.c:132: || ((direction == BIT_DOOR_SOUTH) && (neighbor_room < (width * height)))
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	__mulint
	ldhl	sp,	#8
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00182$
	bit	7, d
	jr	NZ, 00183$
	cp	a, a
	jr	00183$
00182$:
	bit	7, d
	jr	Z, 00183$
	scf
00183$:
	jr	C, 00107$
00113$:
;src/dungeon.c:133: || ((direction == BIT_DOOR_EAST) && ((neighbor_room % width) > 0))
	pop	bc
	push	bc
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__modsint
	ldhl	sp,	#3
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, a
	jr	Z, 00115$
	dec	hl
	dec	hl
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00184$
	bit	7, d
	jr	NZ, 00185$
	cp	a, a
	jr	00185$
00184$:
	bit	7, d
	jr	Z, 00185$
	scf
00185$:
	jr	C, 00107$
00115$:
;src/dungeon.c:134: || ((direction == BIT_DOOR_WEST) && ((neighbor_room % width) < (width - 1)))
	ldhl	sp,	#7
	ld	a, (hl)
	or	a, a
	jr	Z, 00108$
	pop	de
	push	de
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#3
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00186$
	bit	7, d
	jr	NZ, 00187$
	cp	a, a
	jr	00187$
00186$:
	bit	7, d
	jr	Z, 00187$
	scf
00187$:
	jr	NC, 00108$
00107$:
;src/dungeon.c:136: return neighbor_room;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jr	00116$
00108$:
;src/dungeon.c:139: return -1;
	ld	bc, #0xffff
00116$:
;src/dungeon.c:140: }
	add	sp, #14
	pop	hl
	pop	af
	jp	(hl)
;src/dungeon.c:142: void free_dungeon(Dungeon* d) {
;	---------------------------------
; Function free_dungeon
; ---------------------------------
_free_dungeon::
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
;src/dungeon.c:143: free(d->grid);
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	e, c
	ld	d, b
;src/dungeon.c:144: }
	jp	_free
	.area _CODE
	.area _INITIALIZER
__xinit__neighbors:
	.dw #0x003c
	.area _CABS (ABS)
