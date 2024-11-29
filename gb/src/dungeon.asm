SECTION "DungeonVariables", WRAM0

dungeon_grid:: ds 512
entrance_id:: db
current_room:: db
current_width:: db
current_height:: db
generated_cells:: ds 512

SECTION "DungeonCode", ROM0

; Params:
;   Starting Width: B
;   Starting Height: C
InitDungeon::
    ld hl, current_width
    ld [hl], b
    ld hl, current_height
    ld [hl], c
    ret

GenerateDungeon::
    ; Dungeon Area = E
    push de
    push hl
    push af
    push bc

    ld hl, current_width
    ld e, [hl]
    ld d, 0
    ld hl, current_height
    ld a, [hl]
    call Mul8
    ld d, h
    ld e, l

    ; Generated Cells Number = A
    ld a, 0

    ; i = B
    ld b, 0
.LoopCheck:
    cp a, e
    jp nz, GenerateDungeon.Loop_Skip
    jp nc, GenerateDungeon.Loop_Skip
    jp GenerateDungeon.LoopCheck2
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
    push af
    ld a, b
    cp a, 0
    pop af
    jp nz, GenerateDungeon.Loop_Body2
    cp a, 0
    jp nz, GenerateDungeon.Loop_Body2
.Loop_Body2:
.Loop_Skip:
    pop bc
    pop af
    pop hl
    pop de

    ret