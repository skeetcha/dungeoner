;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module dungeon_tiles
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _dungeon_tiles
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
_dungeon_tiles:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x85	; 133
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xa1	; 161
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x85	; 133
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xa3	; 163
	.db #0x5d	; 93
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0x89	; 137
	.db #0x77	; 119	'w'
	.db #0xab	; 171
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xa1	; 161
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x85	; 133
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xa1	; 161
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0x91	; 145
	.db #0xee	; 238
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xc5	; 197
	.db #0xba	; 186
	.db #0xd5	; 213
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.area _INITIALIZER
	.area _CABS (ABS)
