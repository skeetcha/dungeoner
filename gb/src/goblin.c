#include "goblin.h"
#include <stdint.h>
#include <gb/gb.h>
#include "../res/goblin_down.h"
#include "../res/goblin_up.h"
#include "../res/goblin_left.h"
#include <stdbool.h>
#include "monster.h"
#include <gb/emu_debug.h>

#define PLAYER_TILE_OFFSET 48

void setup_goblin(Monster* goblin) {
    goblin->metasprite = goblin_down_metasprites[1];
}

uint8_t update_goblin(uint8_t last_sprite, Monster* goblin) {
    EMU_printf("Last Sprite: %d\n", last_sprite);

    if (goblin->flip_sprite) {
        return move_metasprite_flipx(goblin->metasprite, PLAYER_TILE_OFFSET, 0, last_sprite, goblin->location[0] >> 4, goblin->location[1] >> 4);
    } else {
        return move_metasprite_ex(goblin->metasprite, PLAYER_TILE_OFFSET, 0, last_sprite, goblin->location[0] >> 4, goblin->location[1] >> 4);
    }
}