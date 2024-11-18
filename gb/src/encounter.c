#include "encounter.h"
#include "monster.h"
#include <gb/gb.h>
#include "utils.h"
#include <stdlib.h>
#include "monsters.h"

Monster* generate_encounter(UBYTE difficulty) {
    unsigned int monster_num = 0;

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

    Monster* monsters = (Monster*)calloc(monster_num, sizeof(Monster));

    for (int i = 0; i < monster_num; i++) {
        monsters[i] = goblin;
    }

    return monsters;
}