all:
	nasm -f elf32 main.asm -o main.o
	gcc -m32 main.o -o main -lm

run:
	./main