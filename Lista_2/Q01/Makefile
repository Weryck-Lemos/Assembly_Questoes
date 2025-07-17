all: main

main: main.o time_syscall.o
	gcc -m32 main.o time_syscall.o -o main

main.o: main.c
	gcc -m32 -c main.c -o main.o

time_syscall.o: time_syscall.asm
	nasm -f elf32 time_syscall.asm -o time_syscall.o

run: main
	./main

clean:
	rm -f main main.o time_syscall.o
