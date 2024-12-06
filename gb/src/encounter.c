#include "encounter.h"
#include "monster.h"
#include <gb/gb.h>
#include "utils.h"
#include <stdlib.h>
#include "monsters.h"
#include <stdint.h>
#include <stdbool.h>
#include "../res/goblin_down.h"
#include <gb/emu_debug.h>

Monster* generate_encounter(UBYTE difficulty, uint8_t* monster_num_ref) {
    uint8_t monster_num = 0;

    switch (difficulty) {
        case DIFFICULTY_TRIVIAL:
            monster_num = 2;
            break;
        case DIFFICULTY_LOW:
            monster_num = 3;
            break;
        case DIFFICULTY_MODERATE:
            monster_num = rand_range(4, 5);
            break;
        case DIFFICULTY_SEVERE:
            monster_num = rand_range(6, 7);
            break;
        case DIFFICULTY_EXTREME:
            monster_num = rand_range(8, 9);
            break;
    }

    EMU_printf("Monster num: %d\n", monster_num);

    Monster* monsters = (Monster*)calloc(monster_num, sizeof(Monster));

    for (int i = 0; i < monster_num; i++) {
        monsters[i].data = &goblin;
        monsters[i].flip_sprite = false;
        monsters[i].location[0] = 0;
        monsters[i].location[1] = 0;
        monsters[i].metasprite = goblin_down_metasprites[1];
    }

    *monster_num_ref = monster_num;
    return monsters;
}