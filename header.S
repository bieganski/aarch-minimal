.section ".head.text"
.global _start
.extern _end

// for boot protocol see https://www.kernel.org/doc/Documentation/arm64/booting.txt

_start:
    // code0/code1
    nop
    j entry

    // text_offset
    .quad 0

    // image_size
    .quad  _end - _start

    // flags
    .quad 0b1010

    // Reserved fields
    .quad 0
    .quad 0
    .quad 0

    // magic
    .ascii "ARM\x64"

    // Another reserved field at the end of the header
    .byte 0, 0, 0, 0

entry:

    // NOTE: in x0 there is a device tree address, that was set by bootloader/QEMU. for now we discard it.

    la x0 , _end   // the '_end' symbol points *after* the stack; see linker script.

    mv sp, x0

    li x0, 0       // de-clobber x0 before jumping to 'main'.
    
    // NOTE:
    // this is a good place to clear the BSS and stack, before jumping to 'main'.
    // for simplicity we don't do this, since we forced it in linker script - the bootloader will do this for us.
    j main

    wfi
