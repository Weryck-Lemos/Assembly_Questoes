NOME = main

all: $(NOME).o
	gcc -m32 $(NOME).o -o $(NOME)

%.o: %.asm
	nasm -f elf32 $(NOME).asm -o $(NOME).o