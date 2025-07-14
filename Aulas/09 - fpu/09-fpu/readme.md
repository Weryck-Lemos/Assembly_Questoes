FPU - Unidade de Ponto Flutuante

Funciona com base em uma pilha de 8 registradores de 80 bits: ST(0) a ST(7)
 - ST(0): Topo da pilha
 - Operações são feitas com ST(0)
 
Pode trabalhar com tipos float, double, extended a integer
 
| Tipo                     | Tamanho         | Descrição            |
| ------------------------ | --------------- | -------------------- |
| `float`                  | 32 bits         | Precisão simples     |
| `double`                 | 64 bits         | Precisão dupla       |
| `long double`            | 80 bits         | Precisão estendida   |
| Inteiros (via conversão) | 16, 32, 64 bits | Para I/O de inteiros |

Lista de instruções da FPU:
(ver também: https://linasm.sourceforge.net/docs/instructions/fpu.php)

Carregamento e Armazenamento

| Instrução | Descrição                          | Exemplo            |
| --------- | ---------------------------------- | ------------------ |
| `fld`     | Carrega valor para o topo da pilha | `fld dword [a]`    |
| `fst`     | Copia ST(0) para memória           | `fst dword [res]`  |
| `fstp`    | Copia ST(0) para memória e **pop** | `fstp qword [res]` |
| `fxch`    | Troca ST(0) com ST(i)              | `fxch ST(3)`       |

Aritmética Básica

| Instrução | Operação                   | Exemplo                          |
| --------- | -------------------------- | -------------------------------- |
| `fadd`    | ST(0) = ST(0) + src        | `fadd dword [b]` ou `fadd ST(1)` |
| `faddp`   | ST(i) = ST(i) + ST(0), pop | `faddp ST(1), ST(0)`             |
| `fsub`    | ST(0) = ST(0) - src        | `fsub dword [b]`                 |
| `fsubp`   | ST(i) = ST(i) - ST(0), pop | `fsubp ST(1), ST(0)`             |
| `fmul`    | ST(0) = ST(0) × src        | `fmul dword [b]`                 |
| `fmulp`   | ST(i) = ST(i) × ST(0), pop | `fmulp ST(1), ST(0)`             |
| `fdiv`    | ST(0) = ST(0) ÷ src        | `fdiv dword [b]`                 |
| `fdivp`   | ST(i) = ST(i) ÷ ST(0), pop | `fdivp ST(1), ST(0)`             |

 Comparação
 
| Instrução  | Descrição                                | Exemplo          |
| ---------- | ---------------------------------------- | ---------------- |
| `fcom`     | Compara ST(0) com src (ST(i) ou memória) | `fcom dword [b]` |
| `fcomp`    | Idem, mas faz pop                        | `fcomp ST(1)`    |
| `fcompp`   | Compara ST(0) com ST(1) e pop ambos      | `fcompp`         |
| `fstsw ax` | Move status word da FPU para AX          | `fstsw ax`       |
| `sahf`     | Move AH (flags) para EFLAGS              | `sahf`           |

Conversão

| Instrução | Descrição                               | Exemplo           |
| --------- | --------------------------------------- | ----------------- |
| `fild`    | Carrega inteiro para ST(0)              | `fild dword [x]`  |
| `fistp`   | Converte ST(0) para inteiro, salva, pop | `fistp dword [x]` |
| `fist`    | Converte ST(0) para inteiro, salva      | `fist dword [x]`  |


Constantes

| Instrução | Valor carregado em ST(0) |
| --------- | ------------------------ |
| `fld1`    | 1.0                      |
| `fldz`    | 0.0                      |
| `fldpi`   | π                        |
| `fldl2e`  | log2(e)                  |

Controle da Pilha

| Instrução     | Ação                                                     |
| ------------- | -------------------------------------------------------- |
| `fstp ST(i)`  | Copia ST(0) para ST(i) e pop                             |
| `ffree ST(i)` | Libera registrador ST(i) (usado em contexto multitarefa) |
| `fninit`      | Reseta o estado da FPU                                   |

