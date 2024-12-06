#ifndef ROOM_H
#define ROOM_H

#define ROOM_TILE_WIDTH 20
#define ROOM_TILE_HEIGHT 18

extern const unsigned char room_tilemap[];
extern const unsigned int room_len;
extern const unsigned char door_tiles[];
extern const unsigned char other_door[];
extern const unsigned char stair_up_tiles[];
extern const unsigned char stair_down_tiles[];

#define door_tiles_x 8
#define door_tiles_y 0
#define door_tiles_w 4
#define door_tiles_h 5

#define stair_down_x 2
#define stair_down_y 0
#define stair_down_w 4
#define stair_down_h 5

#define stair_up_x 14
#define stair_up_y 0
#define stair_up_w 4
#define stair_up_h 5

#endif