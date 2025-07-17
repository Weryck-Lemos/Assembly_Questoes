// mouse_move.cpp
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/uinput.h>
#include <iostream>

int main() {
    // 1) Abre o dispositivo uinput
    int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
    if (fd < 0) {
        perror("Erro abrindo /dev/uinput");
        return 1;
    }

    // 2) Habilita eventos de movimento relativo
    if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0 ||
        ioctl(fd, UI_SET_RELBIT, REL_X) < 0 ||
        ioctl(fd, UI_SET_RELBIT, REL_Y) < 0) {
        perror("Erro configurando EV_REL");
        close(fd);
        return 1;
    }

    // 3) Define os parâmetros do dispositivo virtual
    struct uinput_user_dev uidev;
    memset(&uidev, 0, sizeof(uidev));
    snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, "simple-mouse-mover");
    uidev.id.bustype = BUS_USB;
    uidev.id.vendor  = 0x1234;
    uidev.id.product = 0x5678;
    write(fd, &uidev, sizeof(uidev));

    // 4) Cria o dispositivo
    if (ioctl(fd, UI_DEV_CREATE) < 0) {
        perror("Erro criando dispositivo uinput");
        close(fd);
        return 1;
    }

    // Dá um tempinho para o kernel finalizar a criação
    sleep(1);

    // 5) Prepara e envia eventos de movimento
    auto send_rel = [&](int dx, int dy) {
        struct input_event ev;

        // Movimento em X
        gettimeofday(&ev.time, nullptr);
        ev.type  = EV_REL;
        ev.code  = REL_X;
        ev.value = dx;
        write(fd, &ev, sizeof(ev));

        // Movimento em Y
        gettimeofday(&ev.time, nullptr);
        ev.type  = EV_REL;
        ev.code  = REL_Y;
        ev.value = dy;
        write(fd, &ev, sizeof(ev));

        // Sincronização
        gettimeofday(&ev.time, nullptr);
        ev.type  = EV_SYN;
        ev.code  = SYN_REPORT;
        ev.value = 0;
        write(fd, &ev, sizeof(ev));
    };

    // Exemplo: move o mouse +100px na direita e +50px para baixo
    send_rel(100, 50);

    // 6) Destrói o dispositivo e fecha
    sleep(1);
    ioctl(fd, UI_DEV_DESTROY);
    close(fd);
    return 0;
}
