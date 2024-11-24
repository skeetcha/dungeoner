#include "goblin.h"
#include <stdint.h>
#include <gb/gb.h>
#include "../res/goblin_down.h"
#include "../res/goblin_up.h"
#include "../res/goblin_left.h"
#include <stdbool.h>
#include "monster.h"

#define PLAYER_TILE_OFFSET 48

void setup_goblin(uint8_t offset, Monster* goblin) {
    set_sprite_data(PLAYER_TILE_OFFSET + offset, goblin_down_TILE_COUNT, goblin_down_tiles);
    set_sprite_palette(PLAYER_TILE_OFFSET + offset, goblin_down_PALETTE_COUNT, goblin_down_palettes);
    goblin->metasprite = goblin_down_metasprites[1];
}

uint8_t update_goblin(uint8_t offset, uint8_t last_sprite, Monster* goblin) {
    /*if (flip_fighter) {
        return move_metasprite_flipx(fighter_metasprite, 0, 0, 0, fighter_x >> 4, fighter_y >> 4);
    } else {
        return move_metasprite_ex(fighter_metasprite, 0, 0, 0, fighter_x >> 4, fighter_y >> 4);
    }*/

    if (goblin->flip_sprite) {
        return move_metasprite_flipx(goblin->metasprite, PLAYER_TILE_OFFSET + offset, 0, last_sprite, goblin->location[0] >> 4, goblin->location[1] >> 4);
    } else {
        return move_metasprite_ex(goblin->metasprite, PLAYER_TILE_OFFSET + offset, 0, last_sprite, goblin->location[0] >> 4, goblin->location[1] >> 4);
    }
}