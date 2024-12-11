INCLUDE "hardware.inc/hardware.inc"

SECTION "TitleScreenState", ROM0

titleScreenTileData: INCBIN "src/generated/backgrounds/title.2bpp"
titleScreenTileDataEnd:

titleScreenTileMap: INCBIN "src/generated/backgrounds/title.tilemap"
titleScreenTileMapEnd:

InitTitleScreenState::
    call DrawTitleScreen

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
    ld [rLCDC], a
    ret

DrawTitleScreen::
    ld de, titleScreenTileData
    ld hl, $9340
    ld bc, titleScreenTileDataEnd - titleScreenTileData
    call CopyDEIntoMemoryAtHL

    ld de, titleScreenTileMap
    ld hl, $9800
    ld bc, titleScreenTileMapEnd - titleScreenTileMap
    jp CopyDEintoMemoryAtHL_With520Offset

UpdateTitleScreenState::
    ld a, PADF_A
    ld [mWaitKey], a
    
    call WaitForKeyFunction
    ld a, 1
    ld [wGameState], a
    jp NextGameState