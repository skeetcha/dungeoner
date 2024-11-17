#include "character.h"
#include <stdbool.h>

bool Character_is_valid(Character ch) {
    if (ch.ancestry == DWARF) {
        return ((ch.heritage >= DWARF_ANCIENT_BLOOD) && (ch.heritage <= DWARF_STRONG_BLOODED)) || (ch.heritage == VERS_AIUVARIN) || (ch.heritage == VERS_DROMAAR) || (ch.heritage == VERS_CHANGELING) || (ch.heritage == VERS_DRAGONBLOOD) || (ch.heritage == VERS_NEPHILIM);
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