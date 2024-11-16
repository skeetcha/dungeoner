#include "dungeon.h"
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

bool room_has_door(Dungeon* dungeon, int room, int direction);
int get_neighbor_room_index(Dungeon* dungeon, int current_room, int direction);
int get_opposite_direction_bit(int direction);
unsigned int get_random_int(unsigned int min, unsigned int max);
void generate_room(Dungeon* d, unsigned int cell_index_queue, int* cells_queue, unsigned int* queue_size);
int neighbors = BIT_DOOR_NORTH | BIT_DOOR_EAST | BIT_DOOR_SOUTH | BIT_DOOR_WEST;

void init_dungeon(Dungeon* d, const int width, const int height) {
    d->width = width;
    d->height = height;
    d->grid = (uint8_t*)calloc(width * height, sizeof(uint8_t));
}

void generate_dungeon(Dungeon* d) {
    unsigned int i, entrance, generated_cells_number;

    int dungeon_area = d->width * d->height;
    int* generated_cells = (int*)calloc(dungeon_area, sizeof(int));
    generated_cells_number = 0;

    for (i = 0; (generated_cells_number < dungeon_area) && ((i == 0) || (i < generated_cells_number)); i++) {
        if ((i == 0) && (generated_cells_number == 0)) {
            entrance = get_random_int(0, dungeon_area);
            generated_cells[0] = entrance;
            d->grid[entrance] = BIT_ENTRANCE | BIT_USED_ROOM;
            d->entrance = entrance;
            generated_cells_number = 1;
        }

        generate_room(d, i, generated_cells, &generated_cells_number);

        if (!(d->grid[generated_cells[i]] & BIT_USED_ROOM)) {
            d->grid[generated_cells[i]] |= BIT_USED_ROOM;
        }

        if ((i == (generated_cells_number - 1)) && (generated_cells_number < (dungeon_area / 4 * 3))) {
            i = -1;
        }
    }
    
    free(generated_cells);
}

void generate_room(Dungeon* d, unsigned int cell_index_queue, int* cells_queue, unsigned int* queue_size) {
    int potential_doors = 0;
    potential_doors = get_random_int(0, neighbors);
    unsigned int cell_index = cells_queue[cell_index_queue];

    int door, opposite_door;

    for (door = 1; door <= neighbors; dor <<= 1) {
        if (((door & neighbors) != door) || (d->grid[cell_index] & door)) {
            continue;
        }

        int neighbor_room = get_neighbor_room_index(d, cell_index, door);

        if ((!~neighbor_room) || (d->grid[neighbor_room] & BIT_USED_ROOM)) {
            continue;
        }

        opposite_door = get_opposite_direction_bit(door);

        if ((door & potential_doors) == door) {
            d->grid[cell_index] |= door;
            d->grid[neighbor_room] |= opposite_door;
        }

        if (d->grid[neighbor_room] == opposite_door) {
            cells_queue[*queue_size] = neighbor_room;
            (*queue_size) += 1;
        }
    }
}