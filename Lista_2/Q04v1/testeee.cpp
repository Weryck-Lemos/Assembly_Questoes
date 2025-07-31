#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/uinput.h>
#include <iostream>

int main() {

    int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
    if (fd < 0) {
        perror("Erro abrindo /dev/uinput");
        return 1;
    }


    if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0 ||
        ioctl(fd, UI_SET_RELBIT, REL_X) < 0 ||
        ioctl(fd, UI_SET_RELBIT, REL_Y) < 0) {
        perror("Erro configurando EV_REL");
        close(fd);
        return 1;
    }

    struct uinput_user_dev uidev;
    memset(&uidev, 0, sizeof(uidev));
    snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, "simple-mouse-mover");
    uidev.id.bustype = BUS_USB;
    uidev.id.vendor  = 0x1234;
    uidev.id.product = 0x5678;
    write(fd, &uidev, sizeof(uidev));
    if (ioctl(fd, UI_DEV_CREATE) < 0) {
        perror("Erro criando dispositivo uinput");
        close(fd);
        return 1;
    }
    sleep(1);

    auto send_rel = [&](int dx, int dy) {
        struct input_event ev;
        gettimeofday(&ev.time, nullptr);
        ev.type  = EV_REL;
        ev.code  = REL_X;
        ev.value = dx;
        write(fd, &ev, sizeof(ev));


        gettimeofday(&ev.time, nullptr);
        ev.type  = EV_REL;
        ev.code  = REL_Y;
        ev.value = dy;
        write(fd, &ev, sizeof(ev));

    
        gettimeofday(&ev.time, nullptr);
        ev.type  = EV_SYN;
        ev.code  = SYN_REPORT;
        ev.value = 0;
        write(fd, &ev, sizeof(ev));
    };


    send_rel(100, 50);
    sleep(1);
    ioctl(fd, UI_DEV_DESTROY);
    close(fd);
    return 0;
}
