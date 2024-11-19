//AUTOGENERATED FILE FROM png2asset

#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

BANKREF(fighter_left)

const palette_color_t fighter_left_palettes[4] = {
	RGB8(255,255,255), RGB8(227, 92,  6), RGB8(  0,169,  0), RGB8(  0,  0,  0)
	
};

const uint8_t fighter_left_tiles[160] = {
	0x00,0x00,0x03,0x03,
	0x0f,0x0c,0x0d,0x0b,
	0x1f,0x1f,0x1f,0x10,
	0x0f,0x0f,0x0f,0x0a,
	
0x00,0x00,0xc0,0xc0,
	0xf0,0xf0,0xf0,0xb0,
	0xf8,0x78,0xf8,0x88,
	0xf8,0xf8,0xe8,0x38,
	
0x0f,0x0a,0x0f,0x08,
	0x07,0x07,0x0f,0x0d,
	0x1e,0x17,0x0d,0x0f,
	0x07,0x07,0x0f,0x09,
	
0xf0,0x50,0xe0,0x20,
	0xe0,0xe0,0x70,0xd0,
	0x38,0xe8,0xf8,0xe8,
	0xb0,0xf0,0xf0,0x90,
	
0x03,0x03,0x0f,0x0c,
	0x0d,0x0b,0x1f,0x1f,
	0x1f,0x10,0x0f,0x0f,
	0x0f,0x0a,0x0f,0x0a,
	
0xc0,0xc0,0xf0,0xf0,
	0xf0,0xb0,0xf8,0x78,
	0xf8,0x88,0xf8,0xf8,
	0xe8,0x38,0xf0,0x50,
	
0x0f,0x08,0x07,0x07,
	0x03,0x02,0x02,0x03,
	0x03,0x03,0x02,0x03,
	0x03,0x03,0x07,0x04,
	
0xe0,0x20,0xe0,0xe0,
	0xe0,0xa0,0xf0,0xd0,
	0xf0,0x90,0xe0,0xe0,
	0xc0,0xc0,0xc0,0x40,
	
0x0f,0x0a,0x0f,0x08,
	0x07,0x07,0x07,0x05,
	0x07,0x07,0x05,0x07,
	0x07,0x07,0x0f,0x09,
	
0xf0,0x50,0xe0,0x20,
	0xe0,0xe0,0x50,0xf0,
	0xf0,0xd0,0xe0,0x20,
	0xf0,0xf0,0xf0,0x90
	
};

const metasprite_t fighter_left_metasprite0[] = {
	METASPR_ITEM(-8, -8, 0, S_PAL(0)),
	METASPR_ITEM(0, 8, 1, S_PAL(0)),
	METASPR_ITEM(8, -8, 2, S_PAL(0)),
	METASPR_ITEM(0, 8, 3, S_PAL(0)),
	METASPR_TERM
};

const metasprite_t fighter_left_metasprite1[] = {
	METASPR_ITEM(-8, -8, 4, S_PAL(0)),
	METASPR_ITEM(0, 8, 5, S_PAL(0)),
	METASPR_ITEM(8, -8, 6, S_PAL(0)),
	METASPR_ITEM(0, 8, 7, S_PAL(0)),
	METASPR_TERM
};

const metasprite_t fighter_left_metasprite2[] = {
	METASPR_ITEM(-8, -8, 0, S_PAL(0)),
	METASPR_ITEM(0, 8, 1, S_PAL(0)),
	METASPR_ITEM(8, -8, 8, S_PAL(0)),
	METASPR_ITEM(0, 8, 9, S_PAL(0)),
	METASPR_TERM
};

const metasprite_t* const fighter_left_metasprites[3] = {
	fighter_left_metasprite0, fighter_left_metasprite1, fighter_left_metasprite2
};