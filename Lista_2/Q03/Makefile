all: file_manager

file_manager: file_manager.o entradas.o
	gcc -m32 file_manager.o entradas.o -o file_manager

file_manager.o: file_manager.asm
	nasm -f elf32 file_manager.asm -o file_manager.o

entradas.o: entradas.c
	gcc -m32 -Wall -c entradas.c -o entradas.o

clean:
	rm -f file_manager.o entradas.o file_manager

run:
	./file_manager
