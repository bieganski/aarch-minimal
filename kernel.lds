OUTPUT_FORMAT(elf64-littleaarch64)
ENTRY(_start)

PHDRS
{
    headers PT_PHDR PHDRS;
    text PT_LOAD FILEHDR PHDRS;
    rodata PT_LOAD;
    data PT_LOAD;
}

SECTIONS
{
    . = SIZEOF_HEADERS;
    . = 0x1000;
    _IMAGE_START = .;

    .text : {
        _TEXT_BEGIN = .;
        *(.head.text)
        *(.text)
        _TEXT_END = .;
    } :text

    .init_array : ALIGN(0x1000) {
        _INIT_BEGIN = .;
        KEEP(*(SORT(.init_array.*)))
        KEEP(*(.init_array))
        _INIT_END = .;
    } :rodata

    .rodata : {
        _RODATA_BEGIN = .;
        *(.rodata)
        _RODATA_END = .;
    } :rodata

    .data : {
        _DATA_BEGIN = .;
        *(.data)
        _DATA_END = .;
    } :data

    .bss : {
        _BSS_BEGIN = .;
        *(.bss)
        _BSS_END = .;
    } :data

    _end = .;
}

