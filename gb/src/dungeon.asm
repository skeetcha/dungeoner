SECTION "DungeonVariables", WRAM0

dungeon_grid:: ds 512
entrance_id:: db
current_room:: db
current_width:: db
current_height:: db
generated_cells:: ds 512

SECTION "DungeonCode", ROM0

BIT_USED_ROOM:: db $01
BIT_ENTRANCE:: db $02
BIT_DOOR_NORTH:: db $04
BIT_DOOR_EAST:: db $08
BIT_DOOR_SOUTH:: db $10
BIT_DOOR_WEST:: db $20
BIT_STAIR_BELOW:: db $40
BIT_STAIR_UP:: db $80
MAX_ROOMS:: dw 512
NEIGHBORS:: db %00111100

; Params:
;   Starting Width: B
;   Starting Height: C
InitDungeon::
    ld hl, current_width    ; current_width = B
    ld [hl], b
    ld hl, current_height   ; current_height = C
    ld [hl], c
    ret

GenerateDungeon::
    ; REG_B = i
    ; REG_C = generated_cells_number
    ; REG_D = dungeon_area
    ld hl, current_width
    ld e, [hl]
    ld d, 0
    ld hl, current_height
    ld a, [hl]
    call Mul8
    ld d, l
    ld c, 0
    ld b, 0
.LoopCheck
    ld a, c
    cp a, d
    jp nc, .LoopEnd
    jp z, .LoopEnd
    ld a, b
    cp a, 0
    jp nz, .LoopCheck2
    jp z, .LoopBody
.LoopCheck2
    cp a, c
    jp nc, .LoopEnd
    jp z, .LoopEnd
.LoopBody
    cp a, 0
    jp nz, .LoopBody2
    ld a, c
    cp a, 0
    jp nz, .LoopBody2
    push bc
    call rand
    ld l, b
    ld h, 0
    ld c, d
    inc c
    call Mod8
    ld hl, entrance_id
    ld [hl], a
    pop bc
    ld hl, generated_cells+$0
    ld [hl], a
    ld hl, BIT_ENTRANCE
    ld a, [hl]
    ld hl, BIT_USED_ROOM
    or a, [hl]
    ld hl, dungeon_grid
    push de
    push hl
    ld hl, entrance_id
    ld e, [hl]
    ld d, 0
    pop hl
    add hl, de
    pop de
    ld [hl], a
    ld c, 1
.LoopBody2
    call GenerateRoom
    ld hl, dungeon_grid
    push de
    push hl
    ld hl, generated_cells
    ld e, b
    ld d, 0
    add hl, de
    ld e, [hl]
    ld d, 0
    pop hl
    add hl, de
    pop de
    ld a, [hl]
    push hl
    ld hl, BIT_USED_ROOM
    and a, [hl]
    pop hl
    jp nz, .LoopBody3
    ld a, [hl]
    push hl
    ld hl, BIT_USED_ROOM
    or a, [hl]
    pop hl
    ld [hl], a
.LoopBody3
    ld a, c
    sub a, 1
    ld e, a
    ld a, b
    cp a, e
    jp nz, .LoopBody4
    push bc
    ld l, d
    ld h, 0
    ld c, 4
    call Mod8
    pop bc
    push de
    ld e, l
    ld d, h
    ld a, 3
    call Mul8
    pop de
    ld a, c
    cp a, l
    jp z, .LoopBody4
    jp nc, .LoopBody4
    jp .LoopEnd
.LoopBody4
    inc b
    jp .LoopCheck
.LoopEnd
    ret

GenerateRoom::
    ; REG_B = cell_index_queue
    ; REG_C = queue_size
    ; REG_D = potential_doors
    ; REG_E = door
    ; REG_H = neighbor_room
    ; REG_L = cell_index
    ; generated_cells = cells_queue
    push de
    push bc
    call rand
    ld hl, NEIGHBORS
    ld c, [hl]
    inc c
    ld b, l
    ld h, 0
    call Mod8
    pop bc
    ld d, a
    ld hl, generated_cells
    ld a, l
    add a, b
    ld l, a
    push de
    ld e, [hl]
    ld l, e
    pop de
    ld e, 1
.LoopCheck
    ld a, e
    push hl
    ld hl, NEIGHBORS
    cp a, [hl]
    pop hl
    jp nc, .LoopEnd
    jp nz, .LoopEnd
    ld a, e
    push de
    push hl
    ld hl, NEIGHBORS
    ld e, [hl]
    and a, e
    pop hl
    pop de
    cp a, e
    jp nz, .LoopContinue
    push de
    ld e, l
    ld hl, dungeon_grid
    ld a, l
    add a, e
    ld l, a
    ld a, [hl]
    pop de
    and a, e
    jp nz, .LoopContinue
    call GetNeighborRoomIndex
    ld a, h
    cpl
    cp a, 0
    jp nz, .LoopContinue
    push hl
    push de
    ld e, h
    ld hl, dungeon_grid
    ld a, l
    add a, e
    ld l, a
    pop de
    ld a, [hl]
    ld hl, BIT_USED_ROOM
    and a, [hl]
    pop hl
    jp nz, .LoopContinue
    push bc ; b = opposite_door, cache earlier values
    call GetOppositeDirectionBit
    ld a, e
    and a, d
    cp a, e
    jp nz, .LoopBody2
    push hl
    push de
    ld e, l
    ld hl, dungeon_grid
    ld a, l
    add a, e
    ld l, a
    pop de
    ld a, [hl]
    or a, e
    ld [hl], a
    push de
    ld e, h
    ld hl, dungeon_grid
    ld a, l
    add a, e
    ld l, a
    pop de
    ld a, [hl]
    or a, b
    ld [hl], a
    pop hl
.LoopBody2
    push hl
    push de
    ld e, h
    ld hl, dungeon_grid
    ld a, l
    add a, e
    ld l, a
    pop de
    ld a, [hl]
    pop hl
    cp a, b
    jp nz, .LoopContinue
    pop bc
    push hl
    push de
    ld e, h
    ld hl, generated_cells
    ld a, l
    add a, c
    ld l, a
    ld [hl], e
    pop de
    pop hl
    inc c
.LoopContinue
    rlc e
    jp .LoopCheck
.LoopEnd
    pop de
    ret

GetNeighborRoomIndex::
    ret

GetOppositeDirectionBit::
    ret