#include <stdio.h>

#define TAMANHO 10

extern void print_array(int *res);

int main(void) {
    int v1[TAMANHO] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int v2[TAMANHO] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
    int res[TAMANHO];

    for(size_t i=0; i<TAMANHO; i++){
        res[i]= v1[i]+v2[i];
    }

    print_array(res);

    return 0;
}