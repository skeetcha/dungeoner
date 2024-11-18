#ifndef MONSTER_H
#define MONSTER_H

#include <stdint.h>

// Size
#define SIZE_TINY       0
#define SIZE_SMALL      1
#define SIZE_MEDIUM     2
#define SIZE_LARGE      3
#define SIZE_HUGE       4
#define SIZE_GARGANTUAN 5
// Type
#define MTYPE_HUMANOID 0
// Subtype
#define MSTYPE_GOBLIN 0
// Modifiers
#define MOD_NEG_5 0
#define MOD_NEG_4 1
#define MOD_NEG_3 2
#define MOD_NEG_2 3
#define MOD_NEG_1 4
#define MOD_ZERO  5
#define MOD_POS_1 6
#define MOD_POS_2 7
#define MOD_POS_3 8
#define MOD_POS_4 9
#define MOD_POS_5 10
#define MOD_POS_6 11
#define MOD_POS_7 12
// Levels
#define LEVEL_NEG_1 0
#define LEVEL_ZERO  1
#define LEVEL_POS(val) (val + 1)

typedef struct _monster {
    // 0:  Size (unsigned)
    // 1:  Type (unsigned)
    // 2:  Subtype (unsigned)
    // 3:  Perception Mod (signed)
    // 4:  Strength Mod (signed)
    // 5:  Dexterity Mod (signed)
    // 6:  Constitution Mod (signed)
    // 7:  Intelligence Mod (signed)
    // 8:  Wisdom Mod (signed)
    // 9:  Charisma Mod (signed)
    // 10: AC (unsigned)
    // 11: Fortitude Save (signed)
    // 12: Reflex Save (signed)
    // 13: Will Save (signed)
    // 14: Max HP (unsigned)
    // 15: Walking Speed (unsigned)
    // 16: Level (unsigned)
    uint8_t stats[17];
    uint8_t current_hp;
    const char* name;
} Monster;

#endif