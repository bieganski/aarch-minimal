
SRCS := header.S main.c pl011.c
OBJS := header.o main.o pl011.o

TOOLCHAIN := aarch64-linux-gnu

all:
	$(TOOLCHAIN)-gcc -fno-stack-protector  $(SRCS) -fPIE -static -nostdlib -nostartfiles -nodefaultlibs -T kernel.lds -o kernel.elf -Wl,--build-id=none
	llvm-objcopy --input-target elf64-littleaarch64 --output-target binary kernel.elf kernel.bin