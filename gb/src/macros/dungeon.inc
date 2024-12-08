MACRO IsUsed
    ld a, \1
    cp [BIT_USED_ROOM]
    jp z, \2
ENDM

MACRO IsEntrance
    ld a, \1
    cp [BIT_ENTRANCE]
    jp z, \2
ENDM

MACRO HasNorthDoor
    ld a, \1
    cp [BIT_DOOR_NORTH]
    jp z, \2
ENDM

MACRO HasWestDoor
    ld a, \1
    cp [BIT_DOOR_WEST]
    jp z, \2
ENDM

MACRO HasSouthDoor
    ld a, \1
    cp [BIT_DOOR_SOUTH]
    jp z, \2
ENDM

MACRO HasEastDoor
    ld a, \1
    cp [BIT_DOOR_EAST]
    jp z, \2
ENDM

MACRO HasStairDown
    ld a, \1
    cp [BIT_STAIR_BELOW]
    jp z, \2
ENDM

MACRO HasStairUp
    ld a, \1
    cp [BIT_STAIR_UP]
    jp z, \2
ENDM