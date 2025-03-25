#include "pl011.h"

#define UART_BASE 0x9000000 // matches QEMU '-machine virt'. determined using 'qemu-system-XXX -machine virt -machine dumpdtb=qemu.dtb'
#define CLOCK_FREQ 24000000  // must match device tree

void print_hex(struct pl011* dev, char* prefix, uint32_t value) {
    while (*prefix) {
        pl011_putc(dev, *prefix++);
    }
    pl011_putc(dev, ' ');
    for (int shift = 28; shift >= 0; shift -= 4) {
        uint8_t nibble = (value >> shift) & 0xF;
        pl011_putc(dev, nibble < 10 ? '0' + nibble : 'A' + nibble - 10);
    }
    pl011_send(dev, "\r\n", 2);
}

int main (int argc, char**argv){
    struct pl011 dev;
    pl011_setup(&dev, UART_BASE, CLOCK_FREQ);

    print_hex(&dev, "\nHello from your 'but-we-have-kernel-at-home' kernel!", (0x4200 | 0x42));
    return 0;
}