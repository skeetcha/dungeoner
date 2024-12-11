SECTION "MemoryUtilsSection", ROM0

CopyDEIntoMemoryAtHL::
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jp nz, CopyDEIntoMemoryAtHL
    ret

CopyDEintoMemoryAtHL_With520Offset::
    ld a, [de]
    add a, 52
    ld [hli], a
    inc de
    dec bc
    or c
    jp nz, CopyDEintoMemoryAtHL_With520Offset
    ret