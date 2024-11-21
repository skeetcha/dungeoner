#include "cleric.h"
#include <stdint.h>
#include <gb/metasprites.h>
#include "../res/cleric_down.h"
#include "../res/cleric_up.h"
#include "../res/cleric_left.h"
#include <stdbool.h>
#include <stdlib.h>
#include <gb/gb.h>

#define CLERIC_SPEED 4
#define FIGHTER_ROGUE_PADDED_TILE_COUNT 24

uint16_t cleric_x, cleric_y;
extern uint16_t rogue_x, rogue_y;
extern uint8_t fighter_direction, fighter_last_direction;

uint8_t flip_cleric = false;

metasprite_t const *cleric_metasprite;

extern uint8_t three_frame_real_value;

void setup_cleric(void) {
    set_sprite_data(FIGHTER_ROGUE_PADDED_TILE_COUNT, cleric_down_TILE_COUNT, cleric_down_tiles);
    set_sprite_palette(FIGHTER_ROGUE_PADDED_TILE_COUNT, cleric_down_PALETTE_COUNT, cleric_down_palettes);
    cleric_x = 80 << 4;
    cleric_y = (100 - 32) << 4;
    cleric_metasprite = cleric_down_metasprites[1];
}

uint8_t update_cleric(uint8_t last_sprite) {
    int16_t dx = (uint16_t)(rogue_x >> 4) - (uint16_t)(cleric_x >> 4);
    int16_t dy = (uint16_t)(rogue_y >> 4) - (uint16_t)(cleric_y >> 4);
    int16_t dx_abs = abs(dx);
    int16_t dy_abs = abs(dy);

    if ((dx_abs > 16) || (dy_abs > 16)) {
        uint8_t frame = three_frame_real_value;

        if (frame == 3) {
            frame = 1;
        }

        if (dx_abs > dy_abs) {
            cleric_metasprite = cleric_left_metasprites[frame];

            if (dx > 0) {
                cleric_x += CLERIC_SPEED;
                flip_cleric = true;
            } else {
                cleric_x -= CLERIC_SPEED;
                flip_cleric = false;
            }
        } else {
            flip_cleric = false;

            if (dy > 0) {
                cleric_y += CLERIC_SPEED;
                cleric_metasprite = cleric_down_metasprites[frame];
            } else {
                cleric_y -= CLERIC_SPEED;
                cleric_metasprite = cleric_up_metasprites[frame];
            }
        }

        if (fighter_direction != fighter_last_direction) {
            switch (fighter_direction) {
                case J_DOWN:
                    set_sprite_data(FIGHTER_ROGUE_PADDED_TILE_COUNT, cleric_down_TILE_COUNT, cleric_down_tiles);
                    break;
                case J_RIGHT:
                    flip_cleric = true;
                case J_LEFT:
                    set_sprite_data(FIGHTER_ROGUE_PADDED_TILE_COUNT, cleric_left_TILE_COUNT, cleric_left_tiles);
                    break;
                case J_UP:
                    set_sprite_data(FIGHTER_ROGUE_PADDED_TILE_COUNT, cleric_up_TILE_COUNT, cleric_up_tiles);
                    break;
            }
        }
    }

    if (flip_cleric) {
        return move_metasprite_flipx(cleric_metasprite, FIGHTER_ROGUE_PADDED_TILE_COUNT, 0, last_sprite, cleric_x >> 4, cleric_y >> 4);
    } else {
        return move_metasprite_ex(cleric_metasprite, FIGHTER_ROGUE_PADDED_TILE_COUNT, 0, last_sprite, cleric_x >> 4, cleric_y >> 4);
    }
}