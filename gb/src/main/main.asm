INCLUDE "hardware.inc/hardware.inc"
    rev_Check_hardware_inc 4.0

SECTION "GameVariables", WRAM0

wLastKeys:: db
wCurKeys:: db
wNewKeys:: db
wGameState:: db

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
    ; Shut down audio circuitry
    xor a
    ld [rNR52], a
    ld [wGameState], a
    
    ; Wait for VBlank phase before initiating the library
    call WaitForOneVBlank

    ; Turn the LCD off
    xor a
    ld [rLCDC], a

    ; Load our common text font into VRAM
    call LoadTextFontIntoVRAM
    
    ; Turn the LCD on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
    ld [rLCDC], a
    
    ; During the first (blank) frame, intialize display registers
    ld a, %11100100
    ld [rBGP], a
    ld [rOBP0], a

NextGameState::
    ; Do not turn the LCD off outside of VBlank
    call WaitForOneVBlank
    call ClearBackground

    ; Turn the LCD off
    xor a
    ld [rLCDC], a
    
    ld [rSCX], a
    ld [rSCY], a
    ld [rWX], a
    ld [rWY], a
    ld [wCurKeys], a
    ; disable interrupts
    ; call DisableInterrupts

    ; Clear all sprites
    ; call ClearAllSprites

    ; Initiate the next state
    ld a, [wGameState]
    cp 2 ; 2 = Gameplay
    call z, InitGameplayState
    cp 1 ; 1 = Generate Dungeon
    call z, InitDungeonGeneration
    ld a, [wGameState]
    and a ; 0 = Menu
    call z, InitTitleScreenState

    ; Update the next state
    ld a, [wGameState]
    cp 2 ; 2 = Gameplay
    jp z, UpdateGameplayState
    cp 1 ; 1 = Generate Dungeon
    jp z, UpdateDungeonGeneration
    jp UpdateTitleScreenState