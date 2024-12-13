INCLUDE "hardware.inc/hardware.inc"

SECTION "GameplayState", ROM0

roomTileData: INCBIN "src/generated/backgrounds/room.2bpp"
roomTileDataEnd:

roomTileMap: INCBIN "src/generated/backgrounds/room.tilemap"
roomTileMapEnd:

InitGameplayState::
    call DrawRoom
    ld a, LCDCF_ON | LCDCF_BGON
    ld [rLCDC], a
    ret

DrawRoom::
    ld de, roomTileData
    ld hl, $9340
    ld bc, roomTileDataEnd - roomTileData
    call CopyDEIntoMemoryAtHL
    ld de, roomTileMap
    ld hl, $9800
    ld bc, roomTileMapEnd - roomTileMap
    jp CopyDEintoMemoryAtHL_With520Offset

UpdateGameplayState::
    jp NextGameState