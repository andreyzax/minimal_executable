# minimal_executable

A small educational project that demonstrates how to handcraft a minimal Linux ELF64 executable with **NASM in flat binary mode**, without using a linker.

The goal is twofold:

1. show the minimum structure the Linux kernel needs in order to load an ELF executable
2. show that NASM can be used as a tool for authoring arbitrary binary formats, not just ordinary object files

## Files

- `elf.inc` — ELF-related constants used by the examples
- `minimal.s` — the smallest example in the repo; it simply exits with status 0
- `hello.s` — a slightly larger example that writes a string to stdout and then exits
- `Makefile` — builds both examples as raw flat binaries using NASM

## What this project demonstrates

These examples build an executable by writing the ELF file layout directly:

- the ELF header (`Elf64_Ehdr`)
- a single program header (`Elf64_Phdr`)
- machine code placed directly after the headers

No linker is involved. NASM emits the final executable file directly.

## Build

```sh
make
