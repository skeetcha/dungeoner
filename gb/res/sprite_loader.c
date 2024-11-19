#include "sprite_loader.h"
#include "rogue.h"
#include "fighter.h"
#include <gb/gb.h>

void load_rogue_sprites(void) {
    unsigned int offset = 0;
    set_sprite_data(offset, offset + 4, rogueTLE0); // [0,4)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE1); // [4,8)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE2); // [8,12)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE3); // [12,16)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE4); // [16,20)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE5); // [20,24)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE6); // [24,28)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE7); // [28,32)
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE8); // [32,36)
}

void load_fighter_sprites(void) {
    unsigned int offset = 36;
    set_sprite_data(offset, offset + 4, fighterTLE0); // [36,40)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE1); // [40,44)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE2); // [44,48)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE3); // [48,52)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE4); // [52,56)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE5); // [56,60)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE6); // [60,64)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE7); // [64,68)
    offset += 4;
    set_sprite_data(offset, offset + 4, fighterTLE8); // [68,72)
}

void load_sprites(void) {
    load_rogue_sprites();
    load_fighter_sprites();
}