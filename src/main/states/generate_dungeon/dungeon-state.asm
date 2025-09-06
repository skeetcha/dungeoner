INCLUDE "hardware.inc/hardware.inc"
INCLUDE "src/main/utils/macros/text-macros.inc"

SECTION "DungeonGenerationState", ROM0

PressGenerateText1:: db "press a to", 255
PressGenerateText2:: db "generate dungeon", 255

InitDungeonGeneration::
    call BlackBackground
    ld de, $98e3
    ld hl, PressGenerateText1
    call DrawTextTilesLoop
    ld de, $9903
    ld hl, PressGenerateText2
    call DrawTextTilesLoop

    ld a, LCDCF_ON | LCDCF_BGON
    ld [rLCDC], a
    ld a, 10
    ld [wVBlankCount], a
    call WaitForVBlankFunction
    ret

BlackBackground::
    ld hl, $9800
    ld bc, $400
.Loop
    ld a, $37
    ld [hli], a
    dec bc
    ld a, b
    or c
    jp nz, .Loop
    ret

UpdateDungeonGeneration::
    ld a, PADF_A
    ld [mWaitKey], a
    
    call WaitForKeyFunction
    ld a, 2
    ld [wGameState], a
    ld hl, rDIV
    ld b, [hl]
    call srand
    ld b, 6
    ld c, 6
    ld d, 36
    ld e, 27
    call InitDungeon
    call GenerateDungeon
    jp NextGameState