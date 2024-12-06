#ifndef CHARACTER_H
#define CHARACTER_H

#include <stdbool.h>
#include <stdint.h>

// : Character Creation Options
// ::: Classes
#define ALCHEMIST    0x00
#define BARBARIAN    0x01
#define BARD         0x02
#define CHAMPION     0x03
#define CLERIC       0x04
#define DRUID        0x05
#define FIGHTER      0x06
#define INVESTIGATOR 0x07
#define MONK         0x08
#define ORACLE       0x09
#define RANGER       0x0a
#define ROGUE        0x0b
#define SORCERER     0x0c
#define SWASHBUCKLER 0x0d
#define WITCH        0x0e
#define WIZARD       0x0f
// ::: Ancestries
#define DWARF    0x00
#define ELF      0x01
#define GNOME    0x02
#define GOBLIN   0x03
#define HALFLING 0x04
#define HUMAN    0x05
#define LESHY    0x06
#define ORC      0x07
// ::: Heritages
// ::::: Dwarf
#define DWARF_ANCIENT_BLOOD  0x00
#define DWARF_DEATH_WARDEN   0x01
#define DWARF_FORGE          0x02
#define DWARF_ROCK           0x03
#define DWARF_STRONG_BLOODED 0x04
// ::::: Elf
#define ELF_ANCIENT          0x05
#define ELF_ARCTIC           0x06
#define ELF_CAVERN           0x07
#define ELF_SEER             0x08
#define ELF_WHISPER          0x09
#define ELF_WOODLAND         0x0a
// ::::: Gnome
#define GNOME_CHAMELEON      0x0b
#define GNOME_FEY_TOUCHED    0x0c
#define GNOME_SENSATE        0x0d
#define GNOME_UMBRAL         0x0e
#define GNOME_WELLSPRING     0x0f
// ::::: Goblin
#define GOBLIN_CHARHIDE      0x10
#define GOBLIN_IRONGUT       0x11
#define GOBLIN_RAZORTOOTH    0x12
#define GOBLIN_SNOW          0x13
#define GOBLIN_UNBREAKABLE   0x14
// ::::: Halfling
#define HALFLING_GUTSY       0x15
#define HALFLING_HILLOCK     0x16
#define HALFLING_NOMADIC     0x17
#define HALFLING_TWILIGHT    0x18
#define HALFLING_WILDWOOD    0x19
// ::::: Human
#define HUMAN_SKILLED        0x1a
#define HUMAN_VERSATILE      0x1b
// ::::: Leshy
#define LESHY_CACTUS         0x1c
#define LESHY_FRUIT          0x1d
#define LESHY_FUNGUS         0x1e
#define LESHY_GOURD          0x1f
#define LESHY_LEAF           0x20
#define LESHY_LOTUS          0x21
#define LESHY_ROOT           0x22
#define LESHY_SEAWEED        0x23
#define LESHY_VINE           0x24
// ::::: Orc
#define ORC_BADLANDS         0x25
#define ORC_BATTLE_READY     0x26
#define ORC_DEEP             0x27
#define ORC_GRAVE            0x28
#define ORC_HOLD_SCARRED     0x29
#define ORC_RAINFALL         0x2a
#define ORC_WINTER           0x2b
// ::::: Versatile
#define VERS_AIUVARIN        0x2c
#define VERS_DROMAAR         0x2d
#define VERS_CHANGELING      0x2e
#define VERS_DRAGONBLOOD     0x2f
#define VERS_NEPHILIM        0x30
// Modifiers
#define MOD_NEG_5 0
#define MOD_NEG_4 1
#define MOD_NEG_3 2
#define MOD_NEG_2 3
#define MOD_NEG_1 4
#define MOD_ZERO  5
#define MOD_POS_1 6
#define MOD_POS_2 7
#define MOD_POS_3 8
#define MOD_POS_4 9
#define MOD_POS_5 10
#define MOD_POS_6 11
#define MOD_POS_7 12
// Size
#define SIZE_TINY       0
#define SIZE_SMALL      1
#define SIZE_MEDIUM     2
#define SIZE_LARGE      3
#define SIZE_HUGE       4
#define SIZE_GARGANTUAN 5

typedef struct _character {
    uint8_t class_val;
    uint8_t ancestry;
    uint8_t heritage;
    uint8_t stats[6];
    bool skills[16];
    uint8_t perception;
    uint8_t saves[3];
    uint8_t speed;
    uint8_t size;
} Character;

bool Character_is_valid(Character ch);
extern const Character char_fighter;
extern const Character char_rogue;
extern const Character char_cleric;
extern const Character char_wizard;

#endif