#include "utils.h"
#include <stdbool.h>
#include <rand.h>

RollResult roll(unsigned int die_amount, unsigned int die_type, int bonus) {
    unsigned int sum = 0;
    bool crit_success = false;
    bool crit_failure = false;

    for (int i = 0; i < die_amount; i++) {
        unsigned int val = rand_range(1, die_type);

        if (val == 20) {
            crit_success = true;
        } else if (val == 1) {
            crit_failure = true;
        }
    }

    if (bonus > ((int)sum * -1)) {
        sum = 0;
        crit_success = false;
        crit_failure = false;
    }

    RollResult r;
    r.result = sum + bonus;
    r.crit_success = crit_success;
    r.crit_failure = crit_failure;
    return r;
}

unsigned int rand_range(unsigned int min, unsigned int max) {
    return rand() % (max - min) + min;
}