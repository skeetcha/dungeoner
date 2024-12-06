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
#include "../res/goblin_up.h"
#include "../res/goblin_left.h"
#include "character.h"
#include <gbdk/font.h>
#include "../res/window_tiles.h"
#include "../res/window.h"

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
uint8_t encounter_order[] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    // 0: null
    // 1: fighter
    // 2: rogue
    // 3: cleric
    // 4: wizard
    // 5+: goblins in same order as `current_monsters`
};
uint16_t initiative[] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
uint8_t map_offset = 32;

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

int comp_init(const void* a, const void* b) {
    uint8_t index_a = *(const uint8_t*)a;
    uint8_t index_b = *(const uint8_t*)b;

    if (initiative[index_a] < initiative[index_b]) return 1;
    if (initiative[index_a] > initiative[index_b]) return -1;
    return 0;
}

void roll_initiative(void) {
    uint8_t prof = char_fighter.perception;
    int bonus;

    if (prof == 0) {
        bonus = (int)char_fighter.stats[4] - 5;
    } else {
        bonus = (int)char_fighter.stats[4] - 4 + (prof << 1);
    }

    RollResult result;
    result = roll(1, 20, bonus);
    initiative[0] = (uint16_t)result.result;
    prof = char_rogue.perception;
    
    if (prof == 0) {
        bonus = (int)char_rogue.stats[4] - 5;
    } else {
        bonus = (int)char_rogue.stats[4] - 4 + (prof << 1);
    }

    result = roll(1, 20, bonus);
    initiative[1] = (uint16_t)result.result;
    prof = char_cleric.perception;

    if (prof == 0) {
        bonus = (int)char_cleric.stats[4] - 5;
    } else {
        bonus = (int)char_cleric.stats[4] - 4 + (prof << 1);
    }

    result = roll(1, 20, bonus);
    initiative[2] = (uint16_t)result.result;
    prof = char_wizard.perception;

    if (prof == 0) {
        bonus = (int)char_wizard.stats[4] - 5;
    } else {
        bonus = (int)char_wizard.stats[4] - 4 + (prof << 1);
    }

    result = roll(1, 20, bonus);
    initiative[3] = (uint16_t)result.result;

    for (uint8_t i = 0; i < monster_num; i++) {
        result = roll(1, 20, 2);
        initiative[4 + i] = (uint16_t)result.result;
    }

    for (uint8_t i = 0; i < monster_num + 4; i++) {
        encounter_order[i] = i + 1;
    }

    qsort(encounter_order, (size_t)(monster_num + 4), sizeof(uint8_t), comp_init);
}

void update_main(Monster* current_monsters) {
    joypad_current = joypad();

    update_frame_counter();
    uint8_t last_sprite = 0;
    last_sprite += update_fighter();
    last_sprite += update_rogue(last_sprite);
    last_sprite += update_cleric(last_sprite);
    last_sprite += update_wizard(last_sprite);

    for (uint8_t i = 0; i < monster_num; i++) {
        last_sprite += update_goblin(last_sprite, &current_monsters[i]);
    }

    for (uint8_t sprite = 0; sprite < last_sprite; sprite++) {
        scroll_sprite(sprite, 0, -map_offset);
    }

    hide_sprites_range(last_sprite, MAX_HARDWARE_SPRITES);

    if (joypad_current & J_SELECT) {
        run = false;
    }

    joypad_last = joypad_current;
}

void print_room_data(uint8_t room) {
    EMU_printf("Room data:\n");

    if (IS_USED(room)) {
        EMU_printf("used, ");
    }

    if (IS_ENTRANCE(room)) {
        EMU_printf("entrance, ");
    }

    if (HAS_NORTH_DOOR(room)) {
        EMU_printf("north, ");
    }

    if (HAS_EAST_DOOR(room)) {
        EMU_printf("east, ");
    }

    if (HAS_WEST_DOOR(room)) {
        EMU_printf("west, ");
    }

    if (HAS_SOUTH_DOOR(room)) {
        EMU_printf("south, ");
    }

    if (HAS_STAIR_DOWN(room)) {
        EMU_printf("stair down, ");
    }

    if (HAS_STAIR_UP(room)) {
        EMU_printf("stair up, ");
    }

    EMU_printf("\n");
}

void main(void) {
    font_t min_font;
    font_init();
    min_font = font_load(font_min); // 36 tiles
    font_set(min_font);

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

    set_bkg_data(37, 57, dungeon_tiles);
    set_bkg_tiles(0, 0, ROOM_TILE_WIDTH, ROOM_TILE_HEIGHT, room_tilemap);

    set_win_data(0x5e, 9, window_tiles);
    set_win_tiles(0, 0, 20, 4, window_tilemap);
    move_win(7, 112);

    SHOW_WIN;

    Dungeon dungeon;
    init_dungeon(&dungeon, 6, 6);
    generate_dungeon(&dungeon);
    uint8_t room = dungeon.grid[dungeon.entrance];
    print_room_data(room);

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
    set_sprite_data(PLAYER_TILE_OFFSET + 12, goblin_up_TILE_COUNT, goblin_up_tiles);
    set_sprite_palette(PLAYER_TILE_OFFSET + 12, goblin_up_PALETTE_COUNT, goblin_up_palettes);
    set_sprite_data(PLAYER_TILE_OFFSET + 24, goblin_left_TILE_COUNT, goblin_left_tiles);
    set_sprite_palette(PLAYER_TILE_OFFSET + 24, goblin_left_PALETTE_COUNT, goblin_left_palettes);

    for (uint8_t i = 0; i < monster_num; i++) {
        setup_goblin(&current_monsters[i]);
        current_monsters[i].location[0] = (64 + (16 * i)) << 4;
        current_monsters[i].location[1] = 64 << 4;
    }

    roll_initiative();
    scroll_bkg(0, map_offset);

    while (run) {
        update_main(current_monsters);
        vsync();
    }
    
    HIDE_BKG;
    HIDE_WIN;
    HIDE_SPRITES;
    DISPLAY_OFF;
    free_dungeon(&dungeon);
    free(current_monsters);
    EMU_printf("Game closed.\n");
}