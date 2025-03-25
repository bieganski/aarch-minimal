STACK_SIZE = 0x10000;

ENTRY(_start)

PHDRS
{
    headers PT_PHDR PHDRS;
    text PT_LOAD FILEHDR PHDRS;
    rodata PT_LOAD;
    data PT_LOAD;
    bss PT_LOAD;
    stack PT_LOAD;
}

SECTIONS
{
    . = SIZEOF_HEADERS;
    . = 0x1000;

    .text : {
        *(.head.text)
        *(.text)
    } :text

    .init_array : ALIGN(0x1000) {
        KEEP(*(SORT(.init_array.*)))
        KEEP(*(.init_array))
    } :rodata

    .rodata : {
        *(.rodata)
    } :rodata

    .data : {
        *(.data)
    } :data =0xcd

    # NOTE
    # we pad .bss on purpose with trailing byte, in order to force section type PROGBITS.
    # the reason for that is to avoid zeroing .bss in runtime by kernel code before jumping to main.

    .bss : {
        *(.bss)
        BYTE(0);
    } :bss

    # NOTE
    # stack is also PROGBITS, but is additionally poisoned by 0xAB repeating byte.

    .stack : ALIGN(0x1000) {
        BYTE(0);
        . = ALIGN(8);
        . = . + STACK_SIZE - 8;
    } :stack =0xAB

    _end = .;
}

