
run:
	nasm -f elf32 main.asm -o main.o
	ld -m elf_i386 main.o -lc -dynamic-linker /lib/ld-linux.so.2 -o main
	./main
