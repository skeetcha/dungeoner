#include "character.h"
#include <stdbool.h>

bool Character_is_valid(Character ch) {
    if (ch.ancestry == DWARF) {
        return (ch.heritage <= DWARF_STRONG_BLOODED) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    } else if (ch.ancestry == ELF) {
        return ((ch.heritage >= ELF_ANCIENT) && (ch.heritage <= ELF_WOODLAND)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    } else if (ch.ancestry == GNOME) {
        return ((ch.heritage >= GNOME_CHAMELEON) && (ch.heritage <= GNOME_WELLSPRING)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    } else if (ch.ancestry == GOBLIN) {
        return ((ch.heritage >= GOBLIN_CHARHIDE) && (ch.heritage <= GOBLIN_UNBREAKABLE)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    } else if (ch.ancestry == HALFLING) {
        return ((ch.heritage >= HALFLING_GUTSY) && (ch.heritage <= HALFLING_WILDWOOD)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    } else if (ch.ancestry == HUMAN) {
        return (ch.heritage == HUMAN_SKILLED) || (ch.heritage == HUMAN_VERSATILE) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    } else if (ch.ancestry == LESHY) {
        return ((ch.heritage >= LESHY_CACTUS) && (ch.heritage <= LESHY_VINE)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    } else if (ch.ancestry == ORC) {
        return ((ch.heritage >= ORC_BADLANDS) && (ch.heritage <= ORC_WINTER)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
    }

    return false;
}

const Character char_fighter = {
    FIGHTER,
    HUMAN,
    HUMAN_VERSATILE,
    {
        MOD_POS_4,
        MOD_POS_2,
        MOD_POS_2,
        MOD_POS_1,
        MOD_ZERO,
        MOD_ZERO
    },
    {
        true,
        false,
        true,
        true,
        true,
        false,
        true,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        true,
        false
    },
    2,
    {
        2,
        2,
        1
    },
    25,
    SIZE_MEDIUM
};

const Character char_rogue = {
    ROGUE,
    ELF,
    ELF_WHISPER,
    {
        MOD_ZERO,
        MOD_POS_4,
        MOD_POS_2,
        MOD_POS_1,
        MOD_POS_1,
        MOD_POS_1
    },
    {
        true,
        false,
        true,
        true,
        true,
        true,
        true,
        false,
        false,
        false,
        true,
        true,
        true,
        true,
        false,
        true
    },
    2,
    {
        1,
        2,
        2
    },
    30,
    SIZE_MEDIUM
};

const Character char_cleric = {
    CLERIC,
    HUMAN,
    HUMAN_VERSATILE,
    {
        MOD_POS_2,
        MOD_POS_1,
        MOD_ZERO,
        MOD_ZERO,
        MOD_POS_4,
        MOD_POS_2
    },
    {
        false,
        false,
        true,
        false,
        false,
        true,
        false,
        true,
        false,
        false,
        false,
        true,
        false,
        false,
        true,
        false
    },
    1,
    {
        2,
        1,
        2
    },
    25,
    SIZE_MEDIUM
};

const Character char_wizard = {
    WIZARD,
    HUMAN,
    HUMAN_VERSATILE,
    {
        MOD_ZERO,
        MOD_POS_2,
        MOD_POS_2,
        MOD_POS_4,
        MOD_POS_1,
        MOD_ZERO
    },
    {
        false,
        true,
        false,
        true,
        true,
        true,
        false,
        false,
        true,
        true,
        false,
        false,
        true,
        true,
        false,
        false
    },
    2,
    {
        1,
        1,
        2
    },
    25,
    SIZE_MEDIUM
};