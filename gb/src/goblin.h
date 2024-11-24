#ifndef GOBLIN_H
#define GOBLIN_H

#include <stdint.h>
#include "monster.h"

void setup_goblin(uint8_t offset, Monster* goblin);
uint8_t update_goblin(uint8_t offset, uint8_t last_sprite, Monster* goblin);

#endif