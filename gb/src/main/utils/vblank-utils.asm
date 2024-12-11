INCLUDE "hardware.inc/hardware.inc"

SECTION "VBlankVariables", WRAM0

wVBlankCount:: db

SECTION "VBlankFunctions", ROM0

WaitForOneVBlank::
    ld a, 1
    ld [wVBlankCount], a

WaitForVBlankFunction::

WaitForVBlankFunction_Loop::
    ld a, [rLY]
    cp 144
    jp c, WaitForVBlankFunction_Loop
    ld a, [wVBlankCount]
    sub 1
    ld [wVBlankCount], a
    ret z

WaitForKeyFunction_Loop2::
    ld a, [rLY]
    cp 144
    jp nc, WaitForKeyFunction_Loop2
    jp WaitForVBlankFunction_Loop