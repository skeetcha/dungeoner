SECTION "DungeonVariables", WRAM0

wDungeonGrid:: ds 512
wEntrance:: db
wCurrentRoom:: db
wCurrentWidth:: db
wCurrentHeight:: db
wGeneratedCells:: ds 512
wDungeonArea:: db
wTwoThirdsArea:: db
wPotentialDoors:: db

SECTION "DungeonCode", ROM0

INCLUDE "macros/dungeon.inc"

BIT_USED_ROOM::   db %00000001
BIT_ENTRANCE::    db %00000010
BIT_DOOR_NORTH::  db %00000100
BIT_DOOR_EAST::   db %00001000
BIT_DOOR_SOUTH::  db %00010000
BIT_DOOR_WEST::   db %00100000
BIT_STAIR_BELOW:: db %01000000
BIT_STAIR_UP::    db %10000000
MAX_ROOMS:: dw 512
NEIGHBORS::       db %00111100

; Params:
;   Starting Width: B
;   Starting Height: C
;   Dungeon Area: D
;   Three Fourths Dungeon Area: E
InitDungeon::
    ld a, b                 ; wCurrentWidth = REG_B
    ld [wCurrentWidth], a
    ld a, c                 ; wCurrentHeight = REG_C
    ld [wCurrentHeight], a
    ld a, d                 ; wDungeonArea = REG_D
    ld [wDungeonArea], a
    ld a, e                 ; wTwoThirdsArea = REG_E
    ld [wTwoThirdsArea], a
    ld a, $ff               ; initialize memory
    ld b, 2
    ld hl, wDungeonGrid
.Loop
    cp 0
    jp z, .Loop2
    ld [hl], 0
    inc l
    sub 1
    jp .Loop
.Loop2
    ld [hl], 0
    dec b
    ld a, b
    cp 0
    jp z, .End
    ld l, 0
    inc h
    ld a, $ff
    jp .Loop
.End
    ret

GenerateDungeon::
    ; REG_B = generated_cells_number
    ; REG_C = i
    ld b, 0                     ; REG_B = 0
    ld c, 0                     ; REG_C = 0
.LoopCheck
    ld a, [wDungeonArea]        ; IF REG_B >= wDungeonArea
    ld e, a
    ld a, b
    cp e
    jp nc, .LoopSkip            ;   break
    jp z, .LoopSkip
    ld a, c                     ; IF REG_C == 0
    cp 0
    jp z, .LoopBody             ;   proceed to loop
    cp b                        ; IF REG_C >= REG_B
    jp nc, .LoopSkip            ;   break
    jp z, .LoopSkip
.LoopBody
    ld a, c                     ; IF REG_C == 0
    cp 0
    jp nz, .LoopBody2
    ld a, b                     ; AND REG_B == 0
    cp 0
    jp nz, .LoopBody2
    ld d, b                     ; wEntrance = rand_range(0, wDungeonArea)
    ld e, c
    call rand
    ld a, b
    ld hl, wDungeonArea
.LoopBodyLoop
    cp [hl]
    jp c, .LoopBodyLoopSkip
    sub [hl]
    jp .LoopBodyLoop
.LoopBodyLoopSkip
    ld [wEntrance], a
    ld b, d
    ld c, e
    ld hl, wGeneratedCells      ; wGeneratedCells[0] = wEntrance
    ld a, l
    add b
    ld l, a
    ld a, [wEntrance]
    ld [hl], a
    ld hl, wDungeonGrid         ; wDungeonGrid[wEntrance] = BIT_ENTRANCE | BIT_USED_ROOM
    ld e, a
    ld a, l
    add e
    ld l, a
    ld [hl], $03
    ld b, 1                     ; REG_B = 1
.LoopBody2
    call GenerateRoom           ; generate_room(wDungeonGrid, REG_B, REG_C, wGeneratedCells)
    ld hl, wGeneratedCells      ; IF wDungeonGrid[wGeneratedCells[REG_C]] IS_NOT_USED
    ld a, l
    add c
    ld l, a
    ld e, [hl]
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    ld hl, BIT_USED_ROOM
    and [hl]
    jp nz, .LoopBody3
    ld hl, wGeneratedCells      ;   SET USED_BIT IN wDungeonGrid[wGeneratedCells[REG_C]]
    ld a, l
    add c
    ld l, a
    ld e, [hl]
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    set 7, a
    ld [hl], a
.LoopBody3
    ld a, c                     ; IF REG_C == REG_B - 1
    ld e, b
    dec e
    cp e
    jp nz, .LoopBody4
    ld a, b
    ld hl, wTwoThirdsArea       ; AND REG_B < wTwoThirdsArea
    cp [hl]
    jp nc, .LoopBody4
    jp z, .LoopBody4
    ld c, -1                    ;   REG_C = -1
.LoopBody4
    inc c                       ; REG_C += 1
    jp .LoopCheck               ; LOOP
.LoopSkip
    ; wCurrentRoom = wEntrance
    ld hl, wEntrance
    ld a, [hl]
    ld [wCurrentRoom], a
    ret

GenerateRoom::
    ; REG_B = queue_size         => cell_index
    ; REG_C = cell_index_queue   => neighbor_room
    ; REG_D = door
    ; REG_E = opposite_door
    ; cells_queue = wGeneratedCells
    ld d, b                         ; REG_D = rand_range(0, NEIGHBORS)
    ld e, c
    call rand
    ld a, b
    ld hl, NEIGHBORS
    ld l, [hl]
.Loop1
    cp l
    jp c, .Loop1Skip
    sub l
    jp .Loop1
.Loop1Skip
    ld [wPotentialDoors], a
    ld b, d
    ld c, e
    push bc
    ld hl, wGeneratedCells          ; REG_B = wGeneratedCells[REG_C]
    ld a, l
    add c
    ld l, a
    ld b, [hl]
    ld d, 1
.LoopCheck
    ld a, d                         ; IF REG_D > NEIGHBORS
    ld hl, NEIGHBORS
    cp [hl]
    jp nc, .LoopSkip                ;   BREAK
    jp z, .LoopSkip
    and [hl]                        ; IF (REG_D & NEIGHBORS) != REG_D
    cp d
    jp nz, .LoopContinue            ;   CONTINUE
    ld hl, wDungeonGrid             ; IF wDungeonGrid[REG_B] & REG_D
    ld a, l
    add b
    ld l, a
    ld a, [hl]
    and d
    cp 0
    jp nz, .LoopContinue            ;   CONTINUE
    call GetNeighborRoomIndex       ; REG_C = get_neighbor_room_index(wDungeonGrid, REG_B, REG_D)
    ld a, c                         ; IF ! ~REG_C
    cpl
    cp 0
    jp z, .LoopContinue             ;   CONTINUE
    ld hl, wDungeonGrid             ; IF wDungeonGrid[REG_C] & BIT_USED_ROOM
    ld a, l
    add c
    ld l, a
    ld a, [hl]
    and $01
    jp nz, .LoopContinue            ;   CONTINUE
    call GetOppositeDirectionBit    ; REG_E = get_opposite_direction_bit(REG_D)
    ld a, [wPotentialDoors]         ; IF (REG_D & wPotentialDoors) == REG_D
    and d
    cp d
    jp nz, .LoopBody2
    ld hl, wDungeonGrid             ;   wDungeonGrid[REG_B] |= REG_D
    ld a, l
    add b
    ld l, a
    ld a, [hl]
    or d
    ld [hl], a
    ld hl, wDungeonGrid             ;   wDungeonGrid[REG_C] |= REG_E
    ld a, l
    add c
    ld l, a
    ld a, [hl]
    or e
    ld [hl], a
.LoopBody2
    ld hl, wDungeonGrid             ; IF wDungeonGrid[REG_C] == REG_E
    ld a, l
    add c
    ld l, a
    ld a, [hl]
    cp e
    jp nz, .LoopContinue
    pop hl                          ;   wGeneratedCells[OLD_REG_B] = REG_C
    push de
    ld d, h
    ld e, l
    ld hl, wGeneratedCells
    ld a, l
    add d
    ld l, a
    ld [hl], c
    inc d                           ;   OLD_REG_B += 1
    ld h, d
    ld l, e
    pop de
    push hl
.LoopContinue
    rlc d                           ; REG_D <= 1
    jp .LoopCheck                   ; LOOP
.LoopSkip
    pop bc
    ret

GetNeighborRoomIndex::
    ; REG_B = current_room
    ; REG_C = return val
    ; REG_D = direction
    ld a, d                 ; BEGIN SWITCH
    cp %00000100            ; CASE BIT_DOOR_NORTH
    jp nz, .Check1
    ld a, b                 ;   REG_C = REG_B - wCurrentWidth
    ld hl, wCurrentWidth
    sub [hl]
    ld c, a
    jp .Body2               ;   BREAK
.Check1
    cp %00001000            ; CASE BIT_DOOR_EAST
    jp nz, .Check2
    ld a, b                 ;   REG_C = REG_B + 1
    inc a
    ld c, a
    jp .Body2               ;   BREAK
.Check2
    cp %00010000            ; CASE BIT_DOOR_SOUTH
    jp nz, .Check3
    ld a, b                 ;   REG_C = REG_B + wCurrentWidth
    ld hl, wCurrentWidth
    add [hl]
    ld c, a
    jp .Body2               ;   BREAK
.Check3
    cp %00100000            ; CASE BIT_DOOR_WEST
    jp nz, .Check4
    ld a, b                 ;   REG_C = REG_B - 1
    dec a
    ld c, a
    jp .Body2               ;   BREAK
.Check4                     ; DEFAULT_CASE  
    ld c, -1                ;   REG_C = -1
.Body2
    ld a, d                 ; IF REG_D == BIT_DOOR_NORTH
    cp %00000100
    jp nz, .Body3
    ld a, c                 ; AND REG_C >= 0
    cp -1
    jp z, .Body3
    cp 0
    jp c, .Body2a          ;   RETURN
    ret
.Body2a
    jp nz, .FuncEnd
    ret
.Body3
    ld a, d                 ; IF REG_D == BIT_DOOR_SOUTH
    cp %00010000
    jp nz, .Body4
    ld a, c                 ; AND REG_C < wDungeonArea
    ld hl, wDungeonArea
    cp [hl]
    jp nc, .FuncEnd         ;   RETURN
    jp z, .FuncEnd
    ret
.Body4
    ld a, d                 ; IF REG_D == BIT_DOOR_EAST
    cp %00001000
    jp nz, .Body5
    ; REG_A = REG_D % wCurrentWidth
    push bc                 ; AND (REG_D % wCurrentWidth) > 0
    ld a, d
    ld hl, wCurrentWidth
    ld c, [hl]
    call Modulo
    pop bc
    cp 0
    jp c, .FuncEnd         ;   RETURN
    jp z, .FuncEnd
    ret
.Body5
    ld a, d                 ; IF REG_D == BIT_DOOR_WEST
    cp %00100000
    jp nz, .FuncEnd
    push bc                 ; AND (REG_D % wCurrentWidth) < (wCurrentWidth - 1)
    ld a, d
    ld hl, wCurrentWidth
    ld c, [hl]
    call Modulo
    pop bc
    ld hl, wCurrentWidth
    ld l, [hl]
    dec l
    cp l
    jp nc, .FuncEnd         ;   RETURN
    jp z, .FuncEnd
    ret
.FuncEnd
    ld c, -1
    ret

GetOppositeDirectionBit::
    ; REG_D = door
    ; REG_E = return val
    ld a, d
;BIT_DOOR_NORTH::  db %00000100
;BIT_DOOR_EAST::   db %00001000
;BIT_DOOR_SOUTH::  db %00010000
;BIT_DOOR_WEST::   db %00100000
    cp %00000100
    jp nz, .Check1
    ld e, %00010000
    ret
.Check1
    cp %00001000
    jp nz, .Check2
    ld e, %00100000
    ret
.Check2
    cp %00010000
    jp nz, .Check3
    ld e, %00000100
    ret
.Check3
    cp %00100000
    jp nz, .Check4
    ld e, %00001000
    ret
.Check4
    ld e, -1
    ret