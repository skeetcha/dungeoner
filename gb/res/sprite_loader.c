#include "sprite_loader.h"
#include "rogue.h"
#include <gb/gb.h>

void load_rogue_sprites(void) {
    unsigned int offset = 0;
    set_sprite_data(offset, offset + 4, rogueTLE0);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE1);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE2);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE3);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE4);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE5);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE6);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE7);
    offset += 4;
    set_sprite_data(offset, offset + 4, rogueTLE8);
}

void load_sprites(void) {
    load_rogue_sprites();
}