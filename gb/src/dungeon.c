#include "dungeon.h"
#include "bool.h"
#include <stdlib.h>
#include <rand.h>
#include <math.h>

const int MAP_WIDTH = 79;
const int MAP_HEIGHT = 43;

Tile Tile_empty(void) {
    Tile t;
    t.blocked = false;
    t.block_sight = false;
    t.explored = false;
    return t;
}

Tile Tile_wall(void) {
    Tile t;
    t.blocked = true;
    t.block_sight = true;
    t.explored = false;
    return t;
}

int pcg_choose(void* v, size_t el_size) {
    if (!v) {
        return -1;
    } else {
        double size = (double)sizeof(v) / (double)el_size;
        unsigned int num_digits = (unsigned int)round(log10(size));
        unsigned int modulo = (unsigned int)pow(10.0, (double)num_digits);
        unsigned int index_option = (unsigned int)(rand() % modulo);

        while ((size - 1.0) < (double)index_option) {
            index_option = (unsigned int)(rand() % modulo);
        }

        return (int)index_option;
    }
}

Map make_map(void) {
    int num_room_tries = 100;
    int extra_connector_chance = 25;
    int winding_percent = 10;
    int current_region = -1;
    int map_width = MAP_WIDTH;
    int map_height = MAP_HEIGHT;
    UWORD seed = 0xef68;
    initarand(seed);

    if ((map_width % 2) == 0) {
        map_width -= 1;
    }

    if ((map_height % 2) == 0) {
        map_height -= 1;
    }

    Map map = (Map)calloc(MAP_WIDTH, sizeof(Tile*));

    for (int i = 0; i < MAP_WIDTH; i++) {
        map[i] = (Tile*)calloc(map_height, sizeof(Tile));

        for (int j = 0; j < map_height; j++) {
            map[i][j] = Tile_wall();
        }
    }

    int** regions = (int**)calloc(MAP_WIDTH, sizeof(int*));

    for (int i = 0; i < MAP_WIDTH; i++) {
        regions[i] = (int*)calloc(map_height, sizeof(int));

        for (int j = 0; j < map_height; j++) {
            regions[i][j] = 0;
        }
    }
}

void Map_free(Map map) {
    int map_width = MAP_WIDTH;
    int map_height = MAP_HEIGHT;

    if ((map_width % 2) == 0) {
        map_width -= 1;
    }

    if ((map_height % 2) == 0) {
        map_height -= 1;
    }

    for (int i = 0; i < MAP_WIDTH; i++) {
        free(map[i]);
        map[i] = NULL;
    }

    free(map);
}