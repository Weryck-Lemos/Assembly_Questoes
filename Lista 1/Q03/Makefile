NOME   = programa
all: $(NOME)

$(NOME): print_array_int.o soma_vetores.o
	gcc -no-pie -s -o $@ $^

print_array_int.o: print_array_int.asm
	nasm -f elf64 $< -o $@

soma_vetores.o: soma_vetores.c
	gcc -c $< -o $@

run: $(NOME)
	./$(NOME)
	rm -f $(NOME) print_array_int.o soma_vetores.o
