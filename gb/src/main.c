#include <gb/gb.h>
#include "bool.h"
#include "simple_sprite.h"
#include "dungeon.h"

uint8_t sprite_x, sprite_y;
int8_t velocity_x, velocity_y;
uint8_t joypad_current = 0, joypad_previous = 0;

void main(void) {
    DISPLAY_ON;
    SHOW_SPRITES;

    set_sprite_data(0, 1, simple_sprite);
    set_sprite_tile(0, 0);
    move_sprite(0, 84, 88);
    set_sprite_prop(0, 0);
    sprite_x = 80;
    sprite_y = 72;

    velocity_x = 0;
    velocity_y = 0;

    while (true) {
        sprite_x += velocity_x;
        sprite_y += velocity_y;

        joypad_previous = joypad_current;
        joypad_current = joypad();

        if (joypad_current & J_RIGHT) {
            velocity_x = 1;
        } else if (joypad_current & J_LEFT) {
            velocity_x = -1;
        } else {
            velocity_x = 0;
        }

        if ((joypad_current & J_A) && !(joypad_previous & J_A)) {
            sprite_y += 8;
        } else if ((joypad_current & J_B) && !(joypad_previous & J_B)) {
            sprite_y -= 8;
        }

        move_sprite(0, sprite_x + 4, sprite_y + 12);
        vsync();
    }
}