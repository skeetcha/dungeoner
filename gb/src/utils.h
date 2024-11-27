#ifndef UTILS_H
#define UTILS_H

#include <stdbool.h>
#include <stdint.h>

typedef struct _result {
    unsigned int result;
    bool crit_success;
    bool crit_failure;
} RollResult;

RollResult roll(unsigned int die_amount, unsigned int die_type, int bonus);
unsigned int rand_range(unsigned int min, unsigned int max);

#endif