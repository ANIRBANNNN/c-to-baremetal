# RISC-V Bare Metal Setup Guide

This repository contains a minimal bare-metal RISC-V environment using:

- RISC-V GCC Cross Compiler
- QEMU Emulator
- GDB Multiarch Debugger
- Assembly + C Integration
- Custom Linker Script
- Makefile Automation

The setup allows you to:

- Write bare-metal RISC-V programs
- Compile Assembly and C code
- Generate ELF and raw binary files
- Run programs in QEMU
- Debug instruction-by-instruction using GDB
- Inspect generated machine code

---

# Install Required Packages

Update package list:

```bash
sudo apt update
```

Install required tools:

```bash
sudo apt install -y \
gcc-riscv64-unknown-elf \
binutils-riscv64-unknown-elf \
qemu-system-misc \
gdb-multiarch \
xxd \
make \
build-essential
```

---

# Verify Installation

Check compiler:

```bash
riscv64-unknown-elf-gcc --version
```

Check QEMU:

```bash
qemu-system-riscv32 --version
```

Check GDB:

```bash
gdb-multiarch --version
```

---

# Project Structure

```text
.
├── Makefile
├── m.s
├── m.ld
├── c-asm.c
├── main.elf
├── main.bin
└── README.md
```

---

# Makefile

```Makefile
Anirban: c-asm.c m.s
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld m.s c-asm.c -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin

assembly: c-asm.c
	riscv64-unknown-elf-gcc -O0 -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld c-asm.c -S

machinecode: m.s m.ld
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld m.s -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin

printbinary: main.bin
	xxd -e -c 4 -g 4 main.bin

startqemu: main.elf
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel main.elf -S -gdb tcp::1234

connectgdb:
	gdb-multiarch main.elf -ex "target remote :1234" -ex "break _start" -ex "continue" -q

clean:
	rm *.out *.bin *.elf c-asm.s
```

---

# Build the Project

Compile Assembly + C source:

```bash
make Anirban
```

This generates:

- `main.elf`
- `main.bin`

---

# Generate Assembly from C

```bash
make assembly
```

This creates:

```text
c-asm.s
```

Useful for understanding how GCC converts C into RISC-V assembly.

---

# Generate Machine Code

```bash
make machinecode
```

This creates:

- `main.elf`
- `main.bin`

---

# Print Binary Instructions

```bash
make printbinary
```

This displays machine instructions in hexadecimal format.

Example:

```text
00000000: 00000513
00000004: 00100593
```

---

# Start QEMU

Run the ELF binary inside QEMU:

```bash
make startqemu
```

QEMU waits for GDB connection on port `1234`.

---

# Connect GDB

Open another terminal and run:

```bash
make connectgdb
```

---

# Useful GDB Commands

Show assembly layout:

```gdb
layout asm
```

Step one instruction:

```gdb
si
```

Show registers:

```gdb
info registers
```

Show instructions near program counter:

```gdb
x/10i $pc
```

Continue execution:

```gdb
continue
```

Quit GDB:

```gdb
quit
```

---

# Clean Build Files

Remove generated files:

```bash
make clean
```

---

# Example Workflow

## Terminal 1

Build project:

```bash
make Anirban
```

Start QEMU:

```bash
make startqemu
```

---

## Terminal 2

Connect debugger:

```bash
make connectgdb
```

Inside GDB:

```gdb
layout asm
si
info registers
```

---

# Learning Goals

This project is useful for learning:

- RISC-V ISA
- Assembly Language
- C to Assembly Translation
- Bare-Metal Programming
- Linker Scripts
- Embedded Systems
- Low-Level Debugging
- Computer Architecture
- Machine Code Generation

---

# Useful Resources

## RISC-V Official Website

https://riscv.org/

## QEMU Documentation

https://www.qemu.org/docs/master/

## GDB Documentation

https://sourceware.org/gdb/documentation/

## GDB Dashboard

https://github.com/cyrus-and/gdb-dashboard

---

# Author

ANIRBAN JANA