#ifndef ENCOUNTER_H
#define ENCOUNTER_H

#include "monster.h"
#include <gb/gb.h>

// Difficulty
#define DIFFICULTY_TRIVIAL  0
#define DIFFICULTY_LOW      1
#define DIFFICULTY_MODERATE 2
#define DIFFICULTY_SEVERE   3
#define DIFFICULTY_EXTREME  4
#define DIFFICULTY_NONE     5

Monster* generate_encounter(UBYTE difficulty);

#endif