INCLUDE "hardware.inc/hardware.inc"
    rev_Check_hardware_inc 4.0

SECTION "Header", ROM0[$100]

    ; This is your ROM's entry point
    ; You have 4 bytes of code to do... something
    di
    jp EntryPoint

    ; Make sure to allocate some space for the header, so no important
    ; code gets put there and later overwritten by RGBFIX.
    ; RGBFIX is designed to operate over a zero-filled header, so make
    ; sure to put zeros regarless of the padding value. (This feature
    ; was introduced in RGBDS 0.4.0, but the -MG etc flags were also
    ; introduced in that version.)
    ds $150 - @, 0

SECTION "Entry point", ROM0

EntryPoint:
    ; Seed random number generator
    ld b, 0
    ld c, 10
    call srand

    ; Initialize Dungeon
    ld b, 15  ; Starting Width
    ld c, 15  ; Starting Height
    ld d, 225 ; W * H
    ld e, 168 ; W * H * 0.75
    call InitDungeon
    call GenerateDungeon
    
    jp Done

Done:
    jp Done