#include <stdio.h>

#define TAMANHO 10

extern void soma_array(int *v1, int *v2, int *res);

int main(void) {
    int v1[TAMANHO] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int v2[TAMANHO] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
    int res[TAMANHO];

    soma_array(v1, v2, res);

    for (int i=0; i<TAMANHO; i++) {
        printf("%d\n", res[i]);
    }

    return 0;
}