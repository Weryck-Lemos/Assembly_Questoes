#include <stdio.h>

extern int create_file(const char *path, int mode);
extern int remove_file(const char *path);
extern int copy_file(const char *src, const char *dst);
extern int move_file(const char *oldp, const char *newp);
extern int create_dir(const char *path, int mode);
extern int remove_dir(const char *path);
extern int copy_dir(const char *src, const char *dst);
extern int move_dir(const char *oldp, const char *newp);
extern int chmod_file(const char *path, int mode);

int main() {
    int opt, mode, res;
    char path1[256], path2[256];

    while (1) {
        printf("\n=== MENU ===\n");
        printf("1) Criar arquivo\n");
        printf("2) Remover arquivo\n");
        printf("3) Copiar arquivo\n");
        printf("4) Mover arquivo\n");
        printf("5) Criar diretório\n");
        printf("6) Remover diretório\n");
        printf("7) Copiar diretório\n");
        printf("8) Mover diretório\n");
        printf("9) Alterar permissões\n");
        printf("0) Sair\n");
        printf("Escolha: ");
        if (scanf("%d", &opt)!=1) break;

        switch (opt) {
            case 1:
                printf("Nome do arquivo a criar: ");
                scanf("%255s", path1);
                res = create_file(path1, 0644);
                printf("Retorno: %d\n", res);
                break;
            case 2:
                printf("Nome do arquivo a remover: ");
                scanf("%255s", path1);
                res = remove_file(path1);
                printf("Retorno: %d\n", res);
                break;
            case 3:
                printf("Arquivo fonte: ");
                scanf("%255s", path1);
                printf("Arquivo destino: ");
                scanf("%255s", path2);
                res = copy_file(path1, path2);
                printf("Retorno: %d\n", res);
                break;
            case 4:
                printf("Arquivo original: ");
                scanf("%255s", path1);
                printf("Novo nome: ");
                scanf("%255s", path2);
                res = move_file(path1, path2);
                printf("Retorno: %d\n", res);
                break;
            case 5:
                printf("Nome do diretório a criar: ");
                scanf("%255s", path1);
                res = create_dir(path1, 0755);
                printf("Retorno: %d\n", res);
                break;
            case 6:
                printf("Nome do diretório a remover: ");
                scanf("%255s", path1);
                res = remove_dir(path1);
                printf("Retorno: %d\n", res);
                break;
            case 7:
                printf("Diretório fonte: ");
                scanf("%255s", path1);
                printf("Diretório destino: ");
                scanf("%255s", path2);
                res = copy_dir(path1, path2);
                printf("Retorno: %d\n", res);
                break;
            case 8:
                printf("Diretório original: ");
                scanf("%255s", path1);
                printf("Novo nome do diretório: ");
                scanf("%255s", path2);
                res = move_dir(path1, path2);
                printf("Retorno: %d\n", res);
                break;
            case 9:
                printf("Arquivo para chmod: ");
                scanf("%255s", path1);
                printf("Modo octal (ex: 644): ");
                scanf("%o", &mode);
                res = chmod_file(path1, mode);
                printf("Retorno: %d\n", res);
                break;
            case 0:
                return 0;
            default:
                printf("Opção inválida\n");
        }
    }
    return 0;
}
