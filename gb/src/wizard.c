#include "wizard.h"
#include <stdint.h>
#include <gb/metasprites.h>
#include "../res/wizard_down.h"
#include "../res/wizard_left.h"
#include "../res/wizard_up.h"
#include <stdbool.h>
#include <stdlib.h>
#include <gb/gb.h>

#define WIZARD_SPEED 4
#define FRC_PADDED_TILE_COUNT 36

uint16_t wizard_x, wizard_y;
extern uint16_t cleric_x, cleric_y;
extern uint8_t fighter_direction, fighter_last_direction;

uint8_t flip_wizard = false;

metasprite_t const *wizard_metasprite;

extern uint8_t three_frame_real_value;

void setup_wizard(void) {
    set_sprite_data(FRC_PADDED_TILE_COUNT, wizard_down_TILE_COUNT, wizard_down_tiles);
    set_sprite_palette(FRC_PADDED_TILE_COUNT, wizard_down_PALETTE_COUNT, wizard_down_palettes);
    wizard_x = 80 << 4;
    wizard_y = (80 - 48) << 4;
    wizard_metasprite = wizard_down_metasprites[1];
}

uint8_t update_wizard(uint8_t last_sprite) {
    int16_t dx = (uint16_t)(cleric_x >> 4) - (uint16_t)(wizard_x >> 4);
    int16_t dy = (uint16_t)(cleric_y >> 4) - (uint16_t)(wizard_y >> 4);
    int16_t dx_abs = abs(dx);
    int16_t dy_abs = abs(dy);

    if ((dx_abs > 16) || (dy_abs > 16)) {
        uint8_t frame = three_frame_real_value;

        if (frame == 3) {
            frame = 1;
        }

        if (dx_abs > dy_abs) {
            wizard_metasprite = wizard_left_metasprites[frame];

            if (dx > 0) {
                wizard_x += WIZARD_SPEED;
                flip_wizard = true;
            } else {
                wizard_x -= WIZARD_SPEED;
                flip_wizard = false;
            }
        } else {
            flip_wizard = false;

            if (dy > 0) {
                wizard_y += WIZARD_SPEED;
                wizard_metasprite = wizard_down_metasprites[frame];
            } else {
                wizard_y -= WIZARD_SPEED;
                wizard_metasprite = wizard_up_metasprites[frame];
            }
        }

        if (fighter_direction != fighter_last_direction) {
            switch (fighter_direction) {
                case J_DOWN:
                    set_sprite_data(FRC_PADDED_TILE_COUNT, wizard_down_TILE_COUNT, wizard_down_tiles);
                    break;
                case J_RIGHT:
                    flip_wizard = true;
                case J_LEFT:
                    set_sprite_data(FRC_PADDED_TILE_COUNT, wizard_left_TILE_COUNT, wizard_left_tiles);
                    break;
                case J_UP:
                    set_sprite_data(FRC_PADDED_TILE_COUNT, wizard_up_TILE_COUNT, wizard_up_tiles);
                    break;
            }
        }
    }

    if (flip_wizard) {
        return move_metasprite_flipx(wizard_metasprite, FRC_PADDED_TILE_COUNT, 0, last_sprite, wizard_x >> 4, wizard_y >> 4);
    } else {
        return move_metasprite_ex(wizard_metasprite, FRC_PADDED_TILE_COUNT, 0, last_sprite, wizard_x >> 4, wizard_y >> 4);
    }
}