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

; e_ident byte array
db ELFMAG
db ELFCLASS64
db ELFDATA2LSB
db EV_CURRENT
db ELFOSABI_SYSV
db 0 ; The ABI version, should always be zero
times EI_NIDENT - ($ - $$) db 0 ; padding
; end of e_ident, the rest of elf header fields start here.
dw ET_EXEC    ; e_type
dw EM_X86_64  ; e_machine
dd EV_CURRENT ; e_version
dq _start     ; e_entry
dq ph_table - $$  ; e_phoff
dq 0          ; e_shoff - we don't have a section header table so we zero this out
dd 0          ; e_flags - currently there are no flags defined by the standard
dw 64         ; e_ehsize - should be 64 on an ELFCLASS64 file (the 64 is just a coincidence it's not becuse of the 64 bits arch!)
dw 56         ; e_phentsize - 56 on an ELFCLASS64 file
dw 1          ; e_phnum - in this minimal file there will be only one segment
dw 0          ; e_shentsize - We have no section table so we zero out the rest of the fields that describe it
dw 0          ; e_shnum
dw 0          ; e_shstrndx
; end of Elf64_Ehdr ------------------------------------------------------------------------------------------------
;
; start of program header, in this minimal elf file we define just one Elf64_Phdr member
ph_table:
dd PT_LOAD     ; p_type
dd PF_R | PF_X ; p_flags
dq 0           ; p_offset - To simplify alignment considerations we load from file offset 0, including the ELF & program headers.
dq BASE_ADDR   ; p_vaddr - we load our code into BASE_ADDR to match assembler expectations
dq BASE_ADDR   ; p_paddr - this is not used in linux and from what I have seen it's just copied from p_vaddr
dq end - $$    ; p_filesz
dq end - $$    ; p_memsz
dq PAGE_SIZE   ; p_align

_start:
mov rax, 60
mov rdi, 0
syscall

end:
