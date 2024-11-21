#include "fighter.h"
#include <stdint.h>
#include <stdbool.h>
#include "../res/fighter_down.h"
#include "../res/fighter_up.h"
#include "../res/fighter_left.h"
#include <gb/gb.h>
#include <stdio.h>

#define FIGHTER_SPEED 4

uint8_t fighter_direction = 0, fighter_last_direction = 0;
uint16_t fighter_x, fighter_y;

uint8_t flip_fighter = false;

metasprite_t const *fighter_metasprite;

extern uint8_t joypad_current, joypad_last, three_frame_real_value;

void setup_fighter(void) {
    // set the down tiles in
    set_sprite_data(0, fighter_down_TILE_COUNT, fighter_down_tiles);
    // Set our color palettes into vram
    set_sprite_palette(0, fighter_down_PALETTE_COUNT, fighter_down_palettes);
    // Position near the top middle
    // Scale the position, since we are using scaled integers
    fighter_x = 80 << 4;
    fighter_y = 100 << 4;
    // Start by facing down
    fighter_direction = J_DOWN;
    // Start with the down metasprite
    fighter_metasprite = fighter_down_metasprites[1];
}

uint8_t update_fighter(void) {
    // Save our last direction
    // So we can keep track of directional changes
    fighter_last_direction = fighter_direction;
    uint8_t fighter_moving = false;
    fighter_direction = fighter_direction;

    // check if the right joypad button is pressed
    if (joypad_current & J_RIGHT) {
        fighter_x += FIGHTER_SPEED;
        fighter_direction = J_RIGHT;
        fighter_moving = true;
    }

    // check if the left joypad button is pressed
    if (joypad_current & J_LEFT) {
        fighter_x -= FIGHTER_SPEED;
        fighter_direction = J_LEFT;
        fighter_moving = true;
    }

    // check if the down joypad button is pressed
    if (joypad_current & J_DOWN) {
        fighter_y += FIGHTER_SPEED;
        fighter_direction = J_DOWN;
        fighter_moving = true;
    }

    // check if the up joypad button is pressed
    if (joypad_current & J_UP) {
        fighter_y -= FIGHTER_SPEED;
        fighter_direction = J_UP;
        fighter_moving = true;
    }

    // If the character is moving
    if (fighter_moving) {
        // If we changed direction
        if (fighter_direction != fighter_last_direction) {
            switch (fighter_direction) {
                case J_DOWN:
                    set_sprite_data(0, fighter_down_TILE_COUNT, fighter_down_tiles);
                    break;
                case J_RIGHT:
                case J_LEFT:
                    set_sprite_data(0, fighter_left_TILE_COUNT, fighter_left_tiles);
                    break;
                case J_UP:
                    set_sprite_data(0, fighter_up_TILE_COUNT, fighter_up_tiles);
                    break;
            }
        }

        uint8_t frame = three_frame_real_value;

        if (frame == 3) {
            frame = 1;
        }

        // Change the metasprite the character uses
        // We don't have "right" metasprites, so we'll use the left metasprites and flip
        switch (fighter_direction) {
            case J_DOWN:
                fighter_metasprite = fighter_down_metasprites[frame];
                flip_fighter = false;
                break;
            case J_RIGHT:
                fighter_metasprite = fighter_left_metasprites[frame];
                flip_fighter = true;
                break;
            case J_LEFT:
                fighter_metasprite = fighter_left_metasprites[frame];
                flip_fighter = false;
                break;
            case J_UP:
                fighter_metasprite = fighter_up_metasprites[frame];
                flip_fighter = false;
                break;
        }
    }

    // flip along the vertical access if necessary
    // Draw the character at the non-scaled position
    // Return how many sprites were used
    if (flip_fighter) {
        return move_metasprite_flipx(fighter_metasprite, 0, 0, 0, fighter_x >> 4, fighter_y >> 4);
    } else {
        return move_metasprite_ex(fighter_metasprite, 0, 0, 0, fighter_x >> 4, fighter_y >> 4);
    }
}