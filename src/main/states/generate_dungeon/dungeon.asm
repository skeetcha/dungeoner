SECTION "DungeonVariables", WRAM0

wDungeonGrid:: ds $ff
wEntrance:: db
wCurrentRoom:: db
wCurrentWidth:: db
wCurrentHeight:: db
wGeneratedCells:: ds $ff
wDungeonArea:: db
wTwoThirdsArea:: db
wPotentialDoors:: db

SECTION "DungeonCode", ROM0

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
    ld hl, wDungeonGrid
.Loop
    cp 0
    jp z, .End
    ld [hl], 0
    inc l
    sub 1
    jp .Loop
.End
    ld [hl], 0
    ret

GenerateDungeon::
    xor a
    ld b, a
    ld c, a
    push bc
    ; SP     = generated_cells_number
    ; SP + 1 = i
.Loop
    ld hl, sp+0 ; generated_cells_number
    ld a, [hl]
    ld hl, wDungeonArea
    cp [hl]
    jp nc, .LoopEnd
    ld hl, sp+1 ; i
    ld a, [hl]
    cp 0
    jp z, .LoopBody
    ld hl, sp+0
    cp [hl]
    jp c, .LoopBody
    jp .LoopEnd
.LoopBody
    ld hl, sp+1 ; i
    ld a, [hl]
    cp 0
    jp nz, .LoopBody2
    dec hl ; generated_cells_number
    ld a, [hl]
    cp 0
    jp nz, .LoopBody2
    call rand
    ld a, b
    ld hl, wDungeonArea
.SmallLoop
    cp [hl]
    jp c, .SmallLoopEnd
    sub [hl]
    jp .SmallLoop
.SmallLoopEnd
    ld [wEntrance], a
    ld [wGeneratedCells], a
    ld e, a
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld [hl], $03
    ld hl, sp+0
    ld a, 1
    ld [hl], a
.LoopBody2
    call GenerateRoom
    ; This program will assume that GenerateRoom will pop all values from the stack after use
    ; So that...
    ; SP     = generated_cells_number
    ; SP + 1 = i
    ld hl, sp+1
    ld a, [hl]
    ld e, a
    ld hl, wGeneratedCells
    ld a, l
    add e
    ld l, a
    ld e, [hl]
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    and $01
    jp nz, .LoopBody3
    ld a, [hl]
    or $01
    ld [hl], a
.LoopBody3
    ld hl, sp+1
    ld a, [hl]
    ld hl, sp+0
    ld e, [hl]
    dec e
    cp e
    jp nz, .LoopContinue
    inc e
    ld a, e
    ld hl, wTwoThirdsArea
    cp [hl]
    jp nc, .LoopContinue
    ld hl, sp+1
    xor a
    ld [hl], a
    jp .Loop
.LoopContinue
    ld hl, sp+1
    ld a, [hl]
    inc a
    ld [hl], a
    jp .Loop
.LoopEnd
    pop bc ; Get rid of manual value pushed on stack to get old PC back at SP
    ret

GenerateRoom::
    call rand
    rlc b
    rlc b
    rlc b
    rlc b
    ld a, b
    and $0f
    ld hl, wPotentialDoors
    ld [hl], a
    xor a
    ld b, a
    ld c, a
    push bc
    push bc
    ; SP     = door
    ; SP + 1 = opposite_door
    ; SP + 2 = neighbor_room
    ; SP + 3 = cell_index
    ; SP + 4 = OLD_PC_LOW
    ; SP + 5 = OLD_PC_HIGH
    ; SP + 6 = generated_cells_number
    ; SP + 7 = i
    ld hl, sp+0
    ld a, 1
    ld [hl], a
    ld hl, sp+7
    ld e, [hl]
    ld hl, wGeneratedCells
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    ld hl, sp+3
    ld [hl], a
.Loop
    ld hl, sp+0
    ld a, [hl]
    cp 16
    jp z, .LoopEnd
    ld hl, sp+3
    ld e, [hl]
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    ld hl, sp+0
    ld d, [hl]
    sla d
    sla d
    and d
    jp nz, .LoopContinue
    call GetNeighborRoomIndex
    ; This program will assume that GenerateRoom will pop all values from the stack after use
    ; So that...
    ; SP     = door
    ; SP + 1 = opposite_door
    ; SP + 2 = neighbor_room
    ; SP + 3 = cell_index
    ; SP + 4 = OLD_PC_LOW
    ; SP + 5 = OLD_PC_HIGH
    ; SP + 6 = generated_cells_number
    ; SP + 7 = i
    ld hl, sp+2
    ld a, [hl]
    cpl
    cp 0
    jp z, .LoopContinue
    ld e, [hl]
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    and $01
    jp nz, .LoopContinue
    call GetOppositeDirecitonBit ; This will simply be stored in REG_B
    ; This program will assume that GenerateRoom will pop all values from the stack after use
    ; So that...
    ; SP     = door
    ; SP + 1 = opposite_door
    ; SP + 2 = neighbor_room
    ; SP + 3 = cell_index
    ; SP + 4 = OLD_PC_LOW
    ; SP + 5 = OLD_PC_HIGH
    ; SP + 6 = generated_cells_number
    ; SP + 7 = i
    ld hl, sp+0
    ld a, [hl]
    ld hl, wPotentialDoors
    and [hl]
    ld hl, sp+0
    cp [hl]
    jp nz, .LoopBody2
    ld hl, sp+3
    ld e, [hl]
    ld hl, sp+0
    ld d, [hl]
    sla d
    sla d
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    or d
    ld [hl], a
    ld hl, sp+2
    ld e, [hl]
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    or b
    ld [hl], a
.LoopBody2
    ld hl, sp+2
    ld e, [hl]
    ld hl, wDungeonGrid
    ld a, l
    add e
    ld l, a
    ld a, [hl]
    cp b
    jp nz, .LoopContinue
    ld hl, sp+6
    ld e, [hl]
    ld hl, sp+2
    ld d, [hl]
    ld hl, wGeneratedCells
    ld a, l
    add e
    ld l, a
    ld [hl], d
    ld hl, sp+6
    ld a, [hl]
    inc a
    ld [hl], a
.LoopContinue
    ld hl, sp+0
    ld a, [hl]
    sla a
    ld [hl], a
    jp .Loop
.LoopEnd
    pop bc ; Get rid of manual value pushed on stack to get old PC back at SP
    pop bc ; Get rid of manual value pushed on stack to get old PC back at SP
    ret

GetNeighborRoomIndex::
    ; SP     = OLD_PC_LOW
    ; SP + 1 = OLD_PC_HIGH
    ; SP + 2 = door (needs to be shifted left twice)
    ; SP + 3 = opposite_door
    ; SP + 4 = neighbor_room
    ; SP + 5 = cell_index
    ; SP + 6 = OLD_PC_LOW
    ; SP + 7 = OLD_PC_HIGH
    ; SP + 8 = generated_cells_number
    ; SP + 9 = i
    ld hl, sp+2
    ld a, [hl]
    sla a
    sla a
    cp $04
    jp nz, .Case2
    ld hl, sp+5
    ld a, [hl]
    ld hl, wCurrentWidth
    sub [hl]
    ld hl, sp+4
    ld [hl], a
    cp 0
    ret z
    ret nc
    jp .Default
.Case2
    cp $08
    jp nz, .Case3
    ld hl, sp+5
    ld a, [hl]
    inc a
    ld hl, sp+4
    ld [hl], a
    ld hl, wDungeonArea
    cp [hl]
    ret c
    jp .Default
.Case3
    cp $10
    jp nz, .Case4
    ld hl, sp+5
    ld a, [hl]
    ld hl, wCurrentWidth
    add [hl]
    ld hl, sp+4
    ld [hl], a
    ld hl, wCurrentWidth
    ld e, [hl]
    ld d, a
    xor a
    ld hl, wDungeonArea
    ld c, [hl]
.Case3Loop
    cp d
    jp z, .Default
    cp c
    ret z
    add e
    jp .Case3Loop
.Case4
    cp $20
    jp nz, .Default
    ld hl, sp+5
    ld a, [hl]
    dec a
    ld hl, sp+4
    ld [hl], a
    ld hl, wCurrentWidth
    ld e, [hl]
    ld d, a
    xor a
    dec a
    ld hl, wDungeonArea
    ld c, [hl]
.Case4Loop
    cp c
    ret c
    cp d
    jp z, .Default
    add e
    jp .Case4Loop
.Default
    ld hl, sp+4
    ld a, -1
    ld [hl], a
    ret

GetOppositeDirecitonBit::
    ; SP     = OLD_PC_LOW
    ; SP + 1 = OLD_PC_HIGH
    ; SP + 2 = door (needs to be shifted left twice)
    ; SP + 3 = opposite_door
    ; SP + 4 = neighbor_room
    ; SP + 5 = cell_index
    ; SP + 6 = OLD_PC_LOW
    ; SP + 7 = OLD_PC_HIGH
    ; SP + 8 = generated_cells_number
    ; SP + 9 = i
    ld b, -1
    ld hl, sp+2
    ld a, [hl]
    sla a
    sla a
    cp $04
    jp nz, .Case2
    ld b, $10
    jp .Break
.Case2
    cp $08
    jp nz, .Case3
    ld b, $20
    jp .Break
.Case3
    cp $10
    jp nz, .Case4
    ld b, $04
    jp .Break
.Case4
    cp $20
    jp nz, .Break
    ld b, $08
.Break
    ret