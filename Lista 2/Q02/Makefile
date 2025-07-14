NOME = main
FUNC = funcoes

all:
	nasm -f elf32 $(NOME).asm -o $(NOME).o
	gcc -m32 -c $(FUNC).c -o $(FUNC).o
	gcc -m32 $(NOME).o $(FUNC).o -o $(NOME)
	./$(NOME)

clean:
	rm -f $(NOME).o $(FUNC).o $(NOME)