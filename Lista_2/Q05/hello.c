#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("Programa externo executado!\n");
    for (int i = 0; argv[i]; i++) {
        printf(" argv[%d] = %s\n", i, argv[i]);
    }
}
