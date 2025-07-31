all: hello execve

hello: hello.c
	gcc -m32 -Wall -o hello hello.c

execve: execve.asm
	nasm -f elf32 -o execve.o execve.asm
	ld -m elf_i386 -o execve execve.o

run: all
	./execve

clean:
	rm -f hello execve execve.o
