.section ".head.text","ax"
.global _start
.extern _end

_start:
    // code0/code1
    nop
    b entry

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

    // magic - yes 0x644d5241 is the same as ASCII string "ARM\x64"
    .ascii "ARM\x64"

    // Another reserved field at the end of the header
    .byte 0, 0, 0, 0

entry:
    bl main
