#include "monsters.h"
#include "monster.h"

const Monster goblin = {
    {                   // Begin Stats
        SIZE_SMALL,     //  Size
        MTYPE_HUMANOID, //  Type
        MSTYPE_GOBLIN,  //  Subtype
        MOD_POS_2,      //  Perception mod
        MOD_ZERO,       //  Strength mod
        MOD_POS_3,      //  Dexterity mod
        MOD_POS_1,      //  Constitution mod
        MOD_ZERO,       //  Intelligence mod
        MOD_NEG_1,      //  Wisdom mod
        MOD_POS_1,      //  Charisma mod
        16,             //  AC
        MOD_POS_5,      //  Fortitude save
        MOD_POS_7,      //  Reflex save
        MOD_POS_3,      //  Will save
        6,              //  Max HP
        25,             //  Walking speed
        LEVEL_NEG_1     //  Level
    },                  // End Stats
    6,                  // Current HP
    "Goblin Warrior"    // Name
};