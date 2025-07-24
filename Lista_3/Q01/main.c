#include <stdio.h>

extern void print_real(void *number, int bits);

int main(void) {
    float  f =  3.141591;
    double d =  2.718281828459045;

    print_real(&f, 32);
    printf("\n");
    print_real(&d, 64);
}