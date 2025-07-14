| Nº (`eax`) | Nome da Syscall  | Descrição                                          | `ebx`                 | `ecx`                | `edx`                |
| ---------- | ---------------- | -------------------------------------------------- | --------------------- | -------------------- | -------------------- |
| 1          | `exit`           | Finaliza um processo                               | código de saída       | —                    | —                    |
| 2          | `fork`           | Cria um novo processo                              | —                     | —                    | —                    |
| 3          | `read`           | Lê dados de um arquivo ou entrada                  | fd                    | ponteiro para buffer | tamanho              |
| 4          | `write`          | Escreve dados em um arquivo ou saída               | fd                    | ponteiro para buffer | tamanho              |
| 5          | `open`           | Abre um arquivo                                    | ponteiro para path    | flags                | modo                 |
| 6          | `close`          | Fecha um descritor de arquivo                      | fd                    | —                    | —                    |
| 7          | `waitpid`        | Aguarda um processo filho                          | pid                   | ponteiro para status | opções               |
| 8          | `creat`          | Cria um arquivo                                    | ponteiro para path    | modo                 | —                    |
| 9          | `link`           | Cria um link (hard link)                           | oldpath               | newpath              | —                    |
| 10         | `unlink`         | Remove (apaga) um arquivo                          | ponteiro para path    | —                    | —                    |
| 11         | `execve`         | Executa um programa                                | filename              | argv                 | envp                 |
| 12         | `chdir`          | Muda o diretório atual                             | ponteiro para path    | —                    | —                    |
| 13         | `time`           | Retorna a hora atual                               | ponteiro para time\_t | —                    | —                    |
| 14         | `mknod`          | Cria um nó de dispositivo                          | ponteiro para path    | modo                 | dev                  |
| 15         | `chmod`          | Altera permissões de arquivo                       | ponteiro para path    | modo                 | —                    |
| 20         | `getpid`         | Retorna o PID do processo atual                    | —                     | —                    | —                    |
| 37         | `kill`           | Envia sinal a um processo                          | pid                   | sinal                | —                    |
| 39         | `mkdir`          | Cria diretório                                     | ponteiro para path    | modo                 | —                    |
| 40         | `rmdir`          | Remove diretório                                   | ponteiro para path    | —                    | —                    |
| 45         | `brk`            | Define fim do segmento de dados (gerência de heap) | endereço desejado     | —                    | —                    |
| 54         | `ioctl`          | Controla dispositivos                              | fd                    | comando              | argumento            |
| 85         | `readlink`       | Lê um link simbólico                               | caminho               | buffer               | tamanho do buffer    |
| 90         | `mmap`           | Mapeia arquivos/dispositivos na memória            | ponteiro para addr    | tamanho              | prot                 |
| 91         | `munmap`         | Desfaz mapeamento                                  | addr                  | tamanho              | —                    |
| 122        | `uname`          | Retorna informações do sistema                     | ponteiro para utsname | —                    | —                    |
| 125        | `mprotect`       | Define permissões de páginas de memória            | addr                  | tamanho              | prot                 |
| 174        | `rt_sigaction`   | Manipula sinais (versão com tempo real)            | sinal                 | ponteiro para action | ponteiro para oldact |
| 175        | `rt_sigprocmask` | Máscara de sinais                                  | como                  | ponteiro para set    | ponteiro para oldset |
| 252        | `exit_group`     | Encerra todos os threads do processo               | código de saída       | —                    | —                    |

