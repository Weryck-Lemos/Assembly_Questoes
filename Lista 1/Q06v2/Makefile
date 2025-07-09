NOME = main

all: $(NOME).o
	gcc -m32 $(NOME).o -o $(NOME)
	./$(NOME) 23 -5 12
	rm -rf *.o

%.o: %.asm
	nasm -f elf32 $(NOME).asm -o $(NOME).o