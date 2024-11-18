;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module monsters
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _goblin
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_goblin:
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x10	; 16
	.db #0x0a	; 10
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0x06	; 6
	.dw __str_0
__str_0:
	.ascii "Goblin Warrior"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)