#ifndef DUNGEON_H
#define DUNGEON_H

#include "bool.h"

typedef struct _tile {
    bool blocked;
    bool block_sight;
    bool explored;
} Tile;

Tile Tile_empty(void);
Tile Tile_wall(void);

typedef Tile** Map;

Map make_map(void);
void map_free(Map map);

#endif