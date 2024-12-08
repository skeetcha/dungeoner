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
    ld a, b
    ld [current_width], a
    ld a, c
    ld [current_height], a
    ret