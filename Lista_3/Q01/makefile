all:
	nasm -f elf32 funcao.asm -o funcao.o
	gcc -m32 main.c funcao.o -o main

run:
	./main