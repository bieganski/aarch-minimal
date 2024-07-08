#include "pl011.h"

#define UART_BASE 0xfe201000
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

int main (void* a1, void* a2, void* a3, void* a4){
    struct pl011 dev;
    pl011_setup(&dev, UART_BASE, CLOCK_FREQ);

    // while(1) {
    print_hex(&dev, "a1: ", (uint32_t) a1);
    print_hex(&dev, "(uint32_t) *a1: ", *((uint32_t*) a1));
    print_hex(&dev, "a2: ", (uint32_t) a2);
    print_hex(&dev, "a3: ", (uint32_t) a3);
    print_hex(&dev, "a4: ", (uint32_t) a4);
    // }
    return 0;
}