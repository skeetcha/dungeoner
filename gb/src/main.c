#include <gb/gb.h>
#include <stdbool.h>
#include "dungeon_tiles.h"
#include "room.h"
#include "dungeon.h"
#include <stdio.h>
#include <stdint.h>
#include <rand.h>
#include "fighter.h"
#include <gb/metasprites.h>

void set_door(int direction) {
    switch (direction) {
        case BIT_DOOR_NORTH:
            set_bkg_tiles(dungeon_north_door_index_x, dungeon_north_door_index_y, 1, 1, door);
            break;
        case BIT_DOOR_SOUTH:
            set_bkg_tiles(dungeon_south_door_index_x, dungeon_south_door_index_y, 1, 1, door);
            break;
        case BIT_DOOR_WEST:
            set_bkg_tiles(dungeon_west_door_index_x, dungeon_west_door_index_y, 1, 1, door);
            break;
        case BIT_DOOR_EAST:
            set_bkg_tiles(dungeon_east_door_index_x, dungeon_east_door_index_y, 1, 1, door);
            break;
    }
}

uint8_t joypad_current = 0;
uint8_t joypad_last = 0;
bool run = true;
uint8_t three_frame_counter = 0;
uint8_t three_frame_real_value = 0;

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
    printf("%u", seed);
    initarand(seed);

    set_bkg_data(0, 14, dungeon_tiles);
    set_bkg_tiles(0, 0, dungeon_room_width, dungeon_room_height, dungeon_room);

    Dungeon dungeon;
    init_dungeon(&dungeon, 6, 6);
    generate_dungeon(&dungeon);
    uint8_t room = dungeon.grid[dungeon.entrance];

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

    setup_fighter();

    while (run) {
        joypad_current = joypad();

        update_frame_counter();
        uint8_t last_sprite = 0;
        last_sprite += update_fighter();

        if (joypad_current & J_SELECT) {
            run = false;
        }

        vsync();
        joypad_last = joypad_current;
    }
    
    HIDE_BKG;
    DISPLAY_OFF;
    free_dungeon(&dungeon);
    printf("Game closed.");
}