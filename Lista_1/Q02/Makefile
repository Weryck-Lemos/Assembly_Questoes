NOME = main

all: $(NOME).o
	ld -s -o $(NOME) $(NOME).o
	./$(NOME)
	rm -rf *.o

%.o: %.asm
	nasm -f elf64 $<