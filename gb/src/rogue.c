#include "rogue.h"
#include <stdint.h>
#include <stdbool.h>
#include "../res/rogue_down.h"
#include "../res/rogue_up.h"
#include "../res/rogue_left.h"
#include <gb/gb.h>

#define ROGUE_SPEED 5

uint8_t rogue_direction = 0;
uint16_t rogue_x, rogue_y;

uint8_t flip_rogue = false;

metasprite_t const *rogue_metasprite;

extern uint8_t joypad_current, joypad_last, three_frame_real_value;

void setup_rogue(void) {
    // set the down tiles in
    set_sprite_data(0, rogue_down_TILE_COUNT, rogue_down_tiles);
    // Set our color palettes into vram
    set_sprite_palette(0, rogue_down_PALETTE_COUNT, rogue_down_palettes);
    // Position near the top middle
    // Scale the position, since we are using scaled integers
    rogue_x = 80 << 4;
    rogue_y = 80 << 4;
    // Start by facing down
    rogue_direction = J_DOWN;
    // Start with the down metasprite
    rogue_metasprite = rogue_down_metasprites[1];
}

uint8_t update_rogue(void) {
    // Save our last direction
    // So we can keep track of directional changes
    uint8_t rogue_last_direction = rogue_direction;
    uint8_t rogue_moving = false;
    rogue_direction = rogue_direction;

    // check if the right joypad button is pressed
    if (joypad_current & J_RIGHT) {
        rogue_x += ROGUE_SPEED;
        rogue_direction = J_RIGHT;
        rogue_moving = true;
    }

    // check if the left joypad button is pressed
    if (joypad_current & J_LEFT) {
        rogue_x -= ROGUE_SPEED;
        rogue_direction = J_LEFT;
        rogue_moving = true;
    }

    // check if the down joypad button is pressed
    if (joypad_current & J_DOWN) {
        rogue_y += ROGUE_SPEED;
        rogue_direction = J_DOWN;
        rogue_moving = true;
    }

    // check if the up joypad button is pressed
    if (joypad_current & J_UP) {
        rogue_y -= ROGUE_SPEED;
        rogue_direction = J_UP;
        rogue_moving = true;
    }

    // If the character is moving
    if (rogue_moving) {
        // If we changed direction
        if (rogue_direction != rogue_last_direction) {
            switch (rogue_direction) {
                case J_DOWN:
                    set_sprite_data(0, rogue_down_TILE_COUNT, rogue_down_tiles);
                    break;
                case J_RIGHT:
                case J_LEFT:
                    set_sprite_data(0, rogue_left_TILE_COUNT, rogue_left_tiles);
                    break;
                case J_UP:
                    set_sprite_data(0, rogue_up_TILE_COUNT, rogue_up_tiles);
                    break;
            }
        }

        // Change the metasprite the character uses
        // We don't have "right" metasprites, so we'll use the left metasprites and flip
        switch (rogue_direction) {
            case J_DOWN:
                rogue_metasprite = rogue_down_metasprites[three_frame_real_value];
                flip_rogue = false;
                break;
            case J_RIGHT:
                rogue_metasprite = rogue_left_metasprites[three_frame_real_value];
                flip_rogue = true;
                break;
            case J_LEFT:
                rogue_metasprite = rogue_left_metasprites[three_frame_real_value];
                flip_rogue = false;
                break;
            case J_UP:
                rogue_metasprite = rogue_up_metasprites[three_frame_real_value];
                flip_rogue = false;
                break;
        }
    }

    // flip along the vertical access if necessary
    // Draw the character at the non-scaled position
    // Return how many sprites were used
    if (flip_rogue) {
        return move_metasprite_flipx(rogue_metasprite, 0, 0, 0, rogue_x >> 4, rogue_y >> 4);
    } else {
        return move_metasprite_ex(rogue_metasprite, 0, 0, 0, rogue_x >> 4, rogue_y >> 4);
    }
}