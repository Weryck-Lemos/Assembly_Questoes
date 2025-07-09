#include <stdio.h>

const char *s;

int Fator();
int SumSub();
int MultDiv();


int Fator() {
    if (*s == '(') {
        s++;
        int v = SumSub();
        if (*s == ')')
            s++;
        return v;
    } else {
        int v = 0;
        while (*s >= '0' && *s <= '9') {
            v = v * 10 + (*s - '0');
            s++;
        }
        return v;
    }
}

int MultDiv() {
    int v = Fator();
    while (*s == '*' || *s == '/') {
        char op = *s;
        s++;
        int w = Fator();
        if (op == '*')
            v *= w;
        else
            v /= w;
    }
    return v;
}

int SumSub() {
    int v = MultDiv();
    while (*s == '+' || *s == '-') {
        char op = *s;
        s++;
        int w = MultDiv();
        if (op == '+')
            v += w;
        else
            v -= w;
    }
    return v;
}