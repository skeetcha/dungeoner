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
    ret
;    ld de, roomTileData
;    ld hl, $9340
;    ld bc, roomTileDataEnd - roomTileData
;    call CopyDEIntoMemoryAtHL
;    ld de, roomTileMap
;    ld hl, $9800
;    ld bc, roomTileMapEnd - roomTileMap
;    jp CopyDEintoMemoryAtHL_With520Offset

UpdateGameplayState::
    call WaitForOneVBlank
    jp UpdateGameplayState