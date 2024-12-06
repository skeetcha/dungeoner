#include "metasprite.h"
#include <gb/metasprites.h>

const metasprite_t metasprite[] = {
    {.dy=-8, .dx=-8, .dtile=0, .props=0},
    {.dy=0, .dx=8, .dtile=2, .props=0},
    {.dy=8, .dx=-8, .dtile=1, .props=0},
    {.dy=0, .dx=8, .dtile=3, .props=0},
    METASPR_TERM
};