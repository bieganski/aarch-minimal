
SRCS := header.S main.c pl011.c
OBJS := header.o main.o pl011.o

# TOOLCHAIN := aarch64-linux-gnu
# ARCH_FLAGS := -mcpu=cortex-a57+nofp

TOOLCHAIN := riscv64-linux-gnu
ARCH_FLAGS := 



all:
	$(TOOLCHAIN)-gcc $(ARCH_FLAGS) -O3 -fno-stack-protector  $(SRCS) -fPIE -fPIC -static-pie -static -nostdlib -nostartfiles -nodefaultlibs -T kernel.lds -o kernel.elf -Wl,--build-id=none
	llvm-objcopy --input-target elf64-littleaarch64 --output-target binary kernel.elf kernel.bin

run:
	qemu-system-aarch64 -cpu cortex-a57 -machine virt -serial mon:stdio -nographic -kernel kernel.bin