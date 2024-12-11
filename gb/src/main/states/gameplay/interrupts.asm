INCLUDE "hardware.inc/hardware.inc"

SECTION "Interrupts", ROM0

DisableInterrupts::
    xor a
    ldh [rSTAT], a
    di
    ret