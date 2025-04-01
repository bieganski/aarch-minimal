#include <stdint.h>
// #include "pl011.h"
#include "uart.h"

#define UART_BASE 0x9000000 // matches QEMU '-machine virt'. determined using 'qemu-system-XXX -machine virt -machine dumpdtb=qemu.dtb'
#define CLOCK_FREQ 24000000  // must match device tree

#define pl011_putc(dev, char) uart_putc(char)

void uart_send(char* data) {
    while (*data) {
        uart_putc(*data++);
    }
}

void print_hex(char* prefix, uint32_t value) {
    uart_send(prefix);
    uart_putc(' ');
    for (int shift = 28; shift >= 0; shift -= 4) {
        uint8_t nibble = (value >> shift) & 0xF;
        uart_putc(nibble < 10 ? '0' + nibble : 'A' + nibble - 10);
    }
    uart_send("\r\n");
}

int main (int argc, char**argv){

    uart_init();

    print_hex("\nHello from your 'but-we-have-kernel-at-home' kernel!", (0x4200 | 0x42));
    return 0;
}