#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

time_t convert_to_epoch(const char *datetime_str) {
    int dd, mm, yyyy, hh, min, ss;
    struct tm t = {0};

    if (sscanf(datetime_str, "%d/%d/%d %d:%d:%d", &dd, &mm, &yyyy, &hh, &min, &ss) != 6) {
        return -1;
    }

    t.tm_mday = dd;
    t.tm_mon = mm - 1;
    t.tm_year = yyyy - 1900;
    t.tm_hour = hh;
    t.tm_min = min;
    t.tm_sec = ss;

    return mktime(&t); 
}