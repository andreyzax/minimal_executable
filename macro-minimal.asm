[BITS 64]

%include "elf.inc"

; Because ORG is BASE_ADDR, labels evaluate to their eventual virtual addresses.
; Since p_offset = 0 and p_vaddr = BASE_ADDR, a byte at file offset X is mapped at:
;     BASE_ADDR + X
; Therefore:
;     e_entry = _start
; works directly, because _start already has its runtime virtual address.
%define BASE_ADDR 0x400000 ; "Traditional" program base on x86_64
                           ; on x86_64 linux we can't load programs to address 0 or any address thats too low. The kernel enforces an allowable
                           ; minimal address at '/proc/sys/vm/mmap_min_addr' and will segfault any program that tries to load below this!
%define PAGE_SIZE 0x1000

ORG BASE_ADDR ; must match p_vaddr of our segment

elf_header:
    istruc Elf64_Ehdr
        at .e_ident
            db ELFMAG, ELFCLASS64, ELFDATA2LSB, EV_CURRENT, ELFOSABI_SYSV, 0
            times EI_NIDENT - ($ - $$) db 0 ; padding
        at .e_type,      dw ET_EXEC
        at .e_machine,   dw EM_X86_64
        at .e_version,   dd EV_CURRENT
        at .e_entry,     dq _start
        at .e_phoff,     dq ph_table - $$ ; Start program headers immediately, this is not actually required by the elf standard
        at .e_shoff,     dq 0
        at .e_flags,     dd 0
        at .e_ehsize,    dw 64
        at .e_phentsize, dw 56
        at .e_phnum,     dw 1
        at .e_shentsize, dw 0
        at .e_shnum, dw 0
        at .e_shstrndx, dw 0
    iend

ph_table:
    istruc Elf64_Phdr
        at .p_type,   dd PT_LOAD
        at .p_flags,  dd PF_R | PF_X
        at .p_offset, dq 0
        at .p_vaddr,  dq BASE_ADDR
        at .p_paddr,  dq BASE_ADDR
        at .p_filesz, dq end - $$
        at .p_memsz,  dq end - $$
        at .p_align,  dq PAGE_SIZE
    iend

_start:
mov rax, 60
mov rdi, 0
syscall
end:
