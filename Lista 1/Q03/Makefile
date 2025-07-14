NOME = print_array_int
FUNC = soma_vetores

all:
	nasm -f elf32 $(NOME).asm -o $(NOME).o
	gcc -m32 -c $(FUNC).c -o $(FUNC).o
	gcc -m32 $(NOME).o $(FUNC).o -o $(NOME)

clean:
	rm -f $(NOME).o $(FUNC).o $(NOME)

run:
	./print_array_int