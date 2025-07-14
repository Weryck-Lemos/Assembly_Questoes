#include <stdio.h>
#include <time.h>

extern long get_time(void);

int main(void) {
    time_t t = get_time();
    struct tm *lt = localtime(&t);
    if (!lt) {
        perror("localtime");
        return 1;
    }
    printf("%02d/%02d/%04d %02d:%02d:%02d\n",
        lt->tm_mday,
        lt->tm_mon + 1,
        lt->tm_year + 1900,
        lt->tm_hour,
        lt->tm_min,
        lt->tm_sec
    );
    return 0;
}
