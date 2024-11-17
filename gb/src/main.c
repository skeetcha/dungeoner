#include <gb/gb.h>
#include <stdbool.h>
#include "dungeon_tiles.h"
#include "room.h"

void main(void) {
    set_bkg_data(0, 14, dungeon_tiles);
    set_bkg_tiles(0, 0, 21, 21, dungeon_room);

    SHOW_BKG;
    DISPLAY_ON;

    while (true) {
        vsync();
    }
}