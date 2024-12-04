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
    jp c, .LoopEnd
    jp z, .LoopEnd
    ld a, b
    cp a, 0
    jp nz, .LoopCheck2
    jp z, .LoopBody
.LoopCheck2
    cp a, c
    jp c, .LoopEnd
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
    ld a, BIT_ENTRANCE
    or a, BIT_USED_ROOM
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
    and a, BIT_USED_ROOM
    jp nz, .LoopBody3
    ld a, [hl]
    or a, BIT_USED_ROOM
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
    jp c, .LoopBody4
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
    push de
    
    pop de