SECTION "InputUtilsVariables", WRAM0

mWaitKey:: db

SECTION "InputUtils", ROM0

WaitForKeyFunction::
    push bc

WaitForKeyFunction_Loop:
    ld a, [wCurKeys]
    ld [wLastKeys], a
    
    call Input

    ld a, [mWaitKey]
    ld b, a
    ld a, [wCurKeys]
    and b
    jp z, WaitForKeyFunction_NotPressed

    ld a, [wLastKeys]
    and b
    jp nz, WaitForKeyFunction_NotPressed

    pop bc
    ret

WaitForKeyFunction_NotPressed:
    ld a, 1
    ld [wVBlankCount], a
    
    call WaitForVBlankFunction

    jp WaitForKeyFunction_Loop