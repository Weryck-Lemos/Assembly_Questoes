NOME = main

all: $(NOME).o
	gcc -m32 $(NOME).o -o $(NOME)
	./$(NOME) <entrada.txt
	rm -rf *.o

%.o: %.asm
	nasm -f elf32 $(NOME).asm -o $(NOME).o