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
    ; Cache current register values to restore later
    ; In the event this is called with values in the
    ; registers to be used in an outer function
    push de
    push hl
    push af
    push bc

    ld hl, current_width                ; dungeon_area = current_width * current_height
    ld e, [hl]
    ld d, 0
    ld hl, current_height
    ld a, [hl]
    call Mul8
    ld d, h
    ld e, l

    ; generated_cells_number is stored in A
    ld a, 0                             ; generated_cells_number = 0

    ; i is stored in B
    ld b, 0                             ; i = 0
.LoopCheck:                             ; for loop begin
    cp a, e                                 ; if (generated_cells_number < dungeon_area) && ((i == 0) || (i < generated_cells_number))
    jp nz, GenerateDungeon.Loop_Skip    ; Break Loop
    jp nc, GenerateDungeon.Loop_Skip
.LoopCheck2:
    push af
    ld a, b
    cp a, 0
    pop af
    jp z, GenerateDungeon.Loop_Body
    push af
    push bc
    ld c, a
    ld a, b
    ld b, c
    cp a, b
    pop bc
    pop af
    jp nz, GenerateDungeon.Loop_Skip
    jp nc, GenerateDungeon.Loop_Skip
.Loop_Body:
    push af                             ; if ((i == 0) && (generated_cells_number == 0))
    ld a, b
    cp a, 0
    pop af
    jp nz, GenerateDungeon.Loop_Body2
    cp a, 0
    jp nz, GenerateDungeon.Loop_Body2
    push bc
    ld b, 0
    ld c, e
    call rand_range
    push hl
    ld hl, entrance_id
    ld [hl], b
    ld hl, generated_cells
    ld [hl], b
    ld hl, dungeon_grid
    push af
    ld a, l
    add a, b
    ld l, a
    ld a, BIT_ENTRANCE
    or a, BIT_USED_ROOM
    ld [hl], a
    pop af
    ld a, 1
    pop hl
    pop bc
.Loop_Body2:
    call GenerateRoom
.Loop_Skip:
    pop bc
    pop af
    pop hl
    pop de

    ret

GenerateRoom::
    ret