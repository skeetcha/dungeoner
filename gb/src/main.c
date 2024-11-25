#include <gb/gb.h>
#include <stdbool.h>
#include "../res/room.h"
#include "dungeon.h"
#include <stdio.h>
#include <stdint.h>
#include <rand.h>
#include "fighter.h"
#include <gb/metasprites.h>
#include "rogue.h"
#include "cleric.h"
#include "wizard.h"
#include "utils.h"
#include "../res/dungeon.h"
#include <gbdk/emu_debug.h>
#include "encounter.h"
#include "goblin.h"
#include "monster.h"
#include <stdlib.h>
#include "../res/goblin_down.h"

void set_door(int direction) {
    switch (direction) {
        case BIT_DOOR_NORTH:
            set_bkg_tiles(door_tiles_x, door_tiles_y, door_tiles_w, door_tiles_h, door_tiles);
            break;
        case BIT_DOOR_SOUTH:
            set_bkg_tiles(door_tiles_x, 17, 2, 1, other_door);
            break;
        case BIT_DOOR_WEST:
            set_bkg_tiles(0, 10, 1, 2, other_door);
            break;
        case BIT_DOOR_EAST:
            set_bkg_tiles(19, 10, 1, 2, other_door);
            break;
        case BIT_STAIR_BELOW:
            set_bkg_tiles(stair_down_x, stair_down_y, stair_down_w, stair_down_h, stair_down_tiles);
            break;
        case BIT_STAIR_UP:
            set_bkg_tiles(stair_up_x, stair_up_y, stair_up_w, stair_up_h, stair_up_tiles);
            break;
    }
}

uint8_t joypad_current = 0;
uint8_t joypad_last = 0;
bool run = true;
uint8_t three_frame_counter = 0;
uint8_t three_frame_real_value = 0;
bool encounter_mode = true;
uint8_t monster_num = 0;

#define PLAYER_TILE_OFFSET 48

void update_frame_counter(void) {
    three_frame_counter += 2;
    three_frame_real_value = three_frame_counter >> 4;

    // Stop & reset if the value is over 4
    if (three_frame_real_value >= 4) {
        three_frame_real_value = 0;
        three_frame_counter = 0;
    }
}

void main(void) {
    SHOW_BKG;
    DISPLAY_ON;
    SHOW_SPRITES;

    UWORD seed;

    printf("Push any key (1)\n");
    waitpad(0xff);
    waitpadup();
    seed = DIV_REG;
    printf("Push any key (2)\n");
    waitpad(0xff);
    waitpadup();
    seed |= (UWORD)DIV_REG << 8;
    initarand(seed);

    set_bkg_data(0, 57, dungeon_tiles);
    set_bkg_tiles(0, 0, ROOM_TILE_WIDTH, ROOM_TILE_HEIGHT, room_tilemap);

    Dungeon dungeon;
    init_dungeon(&dungeon, 6, 6);
    generate_dungeon(&dungeon);
    uint8_t room = dungeon.grid[dungeon.entrance];
    EMU_printf("Room data: %d\n", room);

    if (HAS_NORTH_DOOR(room)) {
        set_door(BIT_DOOR_NORTH);
    }

    if (HAS_WEST_DOOR(room)) {
        set_door(BIT_DOOR_WEST);
    }

    if (HAS_EAST_DOOR(room)) {
        set_door(BIT_DOOR_EAST);
    }

    if (HAS_SOUTH_DOOR(room)) {
        set_door(BIT_DOOR_SOUTH);
    }
    
    if (HAS_STAIR_DOWN(room)) {
        set_door(BIT_STAIR_BELOW);
    }
    
    if (HAS_STAIR_UP(room)) {
        set_door(BIT_STAIR_UP);
    }

    setup_fighter();
    setup_rogue();
    setup_cleric();
    setup_wizard();
    Monster* current_monsters = generate_encounter(rand_range(DIFFICULTY_TRIVIAL, DIFFICULTY_NONE), &monster_num);
    monster_num = monster_num;
    set_sprite_data(PLAYER_TILE_OFFSET, goblin_down_TILE_COUNT, goblin_down_tiles);
    set_sprite_palette(PLAYER_TILE_OFFSET, goblin_down_PALETTE_COUNT, goblin_down_palettes);

    for (uint8_t i = 0; i < monster_num; i++) {
        setup_goblin(&current_monsters[i]);
        current_monsters[i].location[0] = (64 + (16 * i)) << 4;
        current_monsters[i].location[1] = 64 << 4;
        EMU_printf("Monster %d has location of %d, %d\n", i + 1, current_monsters[i].location[0] >> 4, current_monsters[i].location[1] >> 4);
    }

    while (run) {
        joypad_current = joypad();

        update_frame_counter();
        uint8_t last_sprite = 0;
        last_sprite += update_fighter();
        last_sprite += update_rogue(last_sprite);
        last_sprite += update_cleric(last_sprite);
        last_sprite += update_wizard(last_sprite);

        for (int i = 0; i < monster_num; i++) {
            last_sprite += update_goblin(last_sprite, &current_monsters[i]);
        }

        hide_sprites_range(last_sprite, MAX_HARDWARE_SPRITES);

        if (joypad_current & J_SELECT) {
            run = false;
        }

        vsync();
        joypad_last = joypad_current;
    }
    
    HIDE_BKG;
    DISPLAY_OFF;
    free_dungeon(&dungeon);
    free(current_monsters);
    printf("Game closed.");
}