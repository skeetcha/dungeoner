INCLUDE "hardware.inc/hardware.inc"
INCLUDE "src/main/utils/macros/text-macros.inc"

SECTION "TitleScreenState", ROM0

PressPlayText:: db "press a to play", 255

titleScreenTileData: INCBIN "src/generated/backgrounds/title.2bpp"
titleScreenTileDataEnd:

titleScreenTileMap: INCBIN "src/generated/backgrounds/title.tilemap"
titleScreenTileMapEnd:

InitTitleScreenState::
    call DrawTitleScreen
    ld de, $99C3
    ld hl, PressPlayText
    call DrawTextTilesLoop

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