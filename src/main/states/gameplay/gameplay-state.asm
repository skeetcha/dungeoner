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
    ld a, $5b+$0f
    ld [hli], a
    ld a, $5c+$0f
    ld [hli], a
    ld a, $5d+$0f
    ld [hli], a
    ld a, $56+$0f
    ld [hli], a
    add hl, de      ; Row 5
    ld a, $27+$0f
    ld [hli], a
    ld a, $25+$0f
    ld [hli], a
    ld a, $25+$0f
    ld [hli], a
    ld a, $27+$0f
    ld [hli], a
    pop hl
.FuncBody2
    ld a, [hl]
    and $08
    jp z, .FuncBody3
    ; set east door
    push hl
    ld hl, $9800+$153
    ld a, $25+$0f
    ld [hl], a
    ld de, $0020
    add hl, de
    ld [hl], a
    pop hl
.FuncBody3
    ld a, [hl]
    and $10
    jp z, .FuncBody4
    ; set south door
    push hl
    ld hl, $9800+$228
    ld a, $25+$0f
    ld [hli], a
    ld [hli], a
    pop hl
.FuncBody4
    ld a, [hl]
    and $20
    jp z, .FuncBody5
    ; set west door
    push hl
    ld hl, $9800+$140
    ld a, $25+$0f
    ld [hl], a
    ld de, $0020
    add hl, de
    ld [hl], a
    pop hl
.FuncBody5
    ld a, [hl]
    and $40
    jp z, .FuncBody6
    ; set stair down
    push hl
    ld hl, $9800+$02    ; Row 1
    ld a, $37+$0f
    ld [hli], a
    ld a, $2e+$0f
    ld [hli], a
    ld a, $2f+$0f
    ld [hli], a
    ld a, $32+$0f
    ld [hli], a
    ld de, $001c
    add hl, de          ; Row 2
    ld a, $43+$0f
    ld [hli], a
    ld a, $3a+$0f
    ld [hli], a
    ld a, $3b+$0f
    ld [hli], a
    ld a, $3e+$0f
    ld [hli], a
    add hl, de          ; Row 3
    ld a, $4f+$0f
    ld [hli], a
    ld a, $46+$0f
    ld [hli], a
    ld a, $47+$0f
    ld [hli], a
    ld a, $4a+$0f
    ld [hli], a
    add hl, de          ; Row 4
    ld a, $5b+$0f
    ld [hli], a
    ld a, $52+$0f
    ld [hli], a
    ld a, $53+$0f
    ld [hli], a
    ld a, $56+$0f
    ld [hli], a
    add hl, de          ; Row 5
    ld a, $27+$0f
    ld [hli], a
    ld a, $25+$0f
    ld [hli], a
    ld a, $27+$0f
    ld [hl], a
    pop hl
.FuncBody6
    ld a, [hl]
    and $80
    jp z, .FuncBody7
    ; set stair up
    push hl
    ld hl, $9800+$0e    ; Row 1
    ld a, $34+$0f
    ld [hli], a
    ld a, $30+$0f
    ld [hli], a
    ld a, $31+$0f
    ld [hli], a
    ld a, $32+$0f
    ld [hli], a
    ld de, $001c
    add hl, de          ; Row 2
    ld a, $43+$0f
    ld [hli], a
    ld a, $3c+$0f
    ld [hli], a
    ld a, $3d+$0f
    ld [hli], a
    ld a, $3e+$0f
    ld [hli], a
    add hl, de          ; Row 3
    ld a, $4f+$0f
    ld [hli], a
    ld a, $48+$0f
    ld [hli], a
    ld a, $49+$0f
    ld [hli], a
    ld a, $4a+$0f
    ld [hli], a
    add hl, de          ; Row 4
    ld a, $5b+$0f
    ld [hli], a
    ld a, $54+$0f
    ld [hli], a
    ld a, $55+$0f
    ld [hli], a
    ld a, $56+$0f
    ld [hli], a
    add hl, de          ; Row 5
    ld a, $27+$0f
    ld [hli], a
    ld a, $25+$0f
    ld [hli], a
    ld a, $25+$0f
    ld [hli], a
    ld a, $27+$0f
    ld [hl], a
    pop hl
.FuncBody7
    ret

UpdateGameplayState::
    call WaitForOneVBlank
    jp UpdateGameplayState