#ifndef DUNGEON_H
#define DUNGEON_H

#include <stdint.h>

#define BIT_USED_ROOM   0x01
#define BIT_ENTRANCE    0x02
#define BIT_DOOR_NORTH  0x04
#define BIT_DOOR_EAST   0x08
#define BIT_DOOR_SOUTH  0x10
#define BIT_DOOR_WEST   0x20
#define BIT_STAIR_BELOW 0x40
#define BIT_STAIR_UP    0x80

#define IS_USED(room) ((room & BIT_USED_ROOM) == BIT_USED_ROOM)
#define IS_ENTRANCE(room) ((room & BIT_ENTRANCE) == BIT_ENTRANCE)
#define HAS_NORTH_DOOR(room) ((room & BIT_DOOR_NORTH) == BIT_DOOR_NORTH)
#define HAS_EAST_DOOR(room) ((room & BIT_DOOR_EAST) == BIT_DOOR_EAST)
#define HAS_WEST_DOOR(room) ((room & BIT_DOOR_WEST) == BIT_DOOR_WEST)
#define HAS_SOUTH_DOOR(room) ((room & BIT_DOOR_SOUTH) == BIT_DOOR_SOUTH)
#define HAS_STAIR_DOWN(room) ((room & BIT_STAIR_BELOW) == BIT_STAIR_BELOW)
#define HAS_STAIR_UP(room) ((room & BIT_STAIR_UP) == BIT_STAIR_UP)

typedef struct _dungeon {
    uint8_t* grid;
    int entrance;
    int width;
    int height;
} Dungeon;

void init_dungeon(Dungeon* d, const int width, const int height);
void generate_dungeon(Dungeon* d);
void free_dungeon(Dungeon* d);

#endif