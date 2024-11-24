#include "rogue.h"
#include <stdint.h>
#include <stdbool.h>
#include "../res/rogue_down.h"
#include "../res/rogue_up.h"
#include "../res/rogue_left.h"
#include <gb/gb.h>
#include <stdlib.h>
#include <gb/emu_debug.h>

#define ROGUE_SPEED 4
#define FIGHTER_PADDED_TILE_COUNT 12

uint16_t rogue_x, rogue_y;
extern uint16_t fighter_x, fighter_y;
extern uint8_t fighter_direction, fighter_last_direction;

uint8_t flip_rogue = false;

metasprite_t const *rogue_metasprite;

extern uint8_t three_frame_real_value;

void setup_rogue(void) {
    // set the down tiles in
    set_sprite_data(FIGHTER_PADDED_TILE_COUNT, rogue_down_TILE_COUNT, rogue_down_tiles);
    // Set our color palettes into vram
    set_sprite_palette(FIGHTER_PADDED_TILE_COUNT, rogue_down_PALETTE_COUNT, rogue_down_palettes);
    // Position near the top middle
    // Scale the position, since we are using scaled integers
    rogue_x = 80 << 4;
    rogue_y = 120 << 4;
    // Start with the down metasprite
    rogue_metasprite = rogue_down_metasprites[1];
}

uint8_t update_rogue(uint8_t last_sprite) {
    int16_t dx = (uint16_t)(fighter_x >> 4) - (uint16_t)(rogue_x >> 4);
    int16_t dy = (uint16_t)(fighter_y >> 4) - (uint16_t)(rogue_y >> 4);
    int16_t dx_abs = abs(dx);
    int16_t dy_abs = abs(dy);

    if ((dx_abs > 16) || (dy_abs > 16)) {
        uint8_t frame = three_frame_real_value;

        if (frame == 3) {
            frame = 1;
        }

        if (dx_abs > dy_abs) {
            rogue_metasprite = rogue_left_metasprites[frame];

            if (dx > 0) {
                rogue_x += ROGUE_SPEED;
                flip_rogue = true;
            } else {
                rogue_x -= ROGUE_SPEED;
                flip_rogue = false;
            }
        } else {
            flip_rogue = false;

            if (dy > 0) {
                rogue_y += ROGUE_SPEED;
                rogue_metasprite = rogue_down_metasprites[frame];
            } else {
                rogue_y -= ROGUE_SPEED;
                rogue_metasprite = rogue_up_metasprites[frame];
            }
        }

        if (fighter_direction != fighter_last_direction) {
            switch (fighter_direction) {
                case J_DOWN:
                    set_sprite_data(FIGHTER_PADDED_TILE_COUNT, rogue_down_TILE_COUNT, rogue_down_tiles);
                    break;
                case J_RIGHT:
                    flip_rogue = true;
                case J_LEFT:
                    set_sprite_data(FIGHTER_PADDED_TILE_COUNT, rogue_left_TILE_COUNT, rogue_left_tiles);
                    break;
                case J_UP:
                    set_sprite_data(FIGHTER_PADDED_TILE_COUNT, rogue_up_TILE_COUNT, rogue_up_tiles);
                    break;
            }
        }
    }
    // flip along the vertical access if necessary
    // Draw the character at the non-scaled position
    // Return how many sprites were used
    if (flip_rogue) {
        return move_metasprite_flipx(rogue_metasprite, FIGHTER_PADDED_TILE_COUNT, 0, last_sprite, rogue_x >> 4, rogue_y >> 4);
    } else {
        return move_metasprite_ex(rogue_metasprite, FIGHTER_PADDED_TILE_COUNT, 0, last_sprite, rogue_x >> 4, rogue_y >> 4);
    }
}