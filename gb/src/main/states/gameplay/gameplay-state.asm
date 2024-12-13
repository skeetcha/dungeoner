INCLUDE "hardware.inc/hardware.inc"

SECTION "GameplayState", ROM0

InitGameplayState::
    call DrawRoom
    ld a, LCDCF_ON | LCDCF_BGON
    ld [rLCDC], a
    ret

DrawRoom::
    ld de, dungeon_tiles
    ld hl, $9340
    ld bc, dungeon_tiles_end - dungeon_tiles
    call CopyDEIntoMemoryAtHL
    ld de, room_Tilemap
    ld hl, $9800
    ld bc, room_Tilemap_end - room_Tilemap
    call CopyDEIntoMemoryAtHL
    call SetRoomDoors
    ret

SetRoomDoors::
    ld a, [wEntrance]
    ld e, a
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    and $04
    jp z, .FuncBody2
    ; set north door
    push hl
    ld hl, $9800+$08
    ld a, $37+$0f   ; Row 1
    ld [hli], a
    ld a, $38+$0f
    ld [hli], a
    ld a, $39+$0f
    ld [hli], a
    ld a, $32+$0f
    ld [hli], a
    ld de, $001c
    add hl, de      ; Row 2
    ld a, $43+$0f
    ld [hli], a
    ld a, $44+$0f
    ld [hli], a
    ld a, $45+$0f
    ld [hli], a
    ld a, $3e+$0f
    ld [hli], a
    add hl, de      ; Row 3
    ld a, $4f+$0f
    ld [hli], a
    ld a, $50+$0f
    ld [hli], a
    ld a, $51+$0f
    ld [hli], a
    ld a, $4a+$0f
    ld [hli], a
    add hl, de      ; Row 4
.FuncBody2
    ld a, [hl]
    and $08
    jp z, .FuncBody3
    ; set east door
.FuncBody3
    ld a, [hl]
    and $10
    jp z, .FuncBody4
    ; set south door
.FuncBody4
    ld a, [hl]
    and $20
    jp z, .FuncBody5
    ; set west door
.FuncBody5
    ld a, [hl]
    and $40
    jp z, .FuncBody6
    ; set stair down
.FuncBody6
    ld a, [hl]
    and $80
    jp z, .FuncBody7
.FuncBody7
    ret

UpdateGameplayState::
    call WaitForOneVBlank
    jp UpdateGameplayState