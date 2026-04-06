%ifndef ELF_INC
    %define ELF_INC

    ; ElfN_Ehdr macros

    ; ELF magic
    %define EI_NIDENT 16
    %define ELFMAG0 0x7f
    %define ELFMAG1 'E'
    %define ELFMAG2 'L'
    %define ELFMAG3 'F'
    %define ELFMAG `\177ELF`
    ; ELF class and endianness defines
    %define ELFCLASS32 1
    %define ELFCLASS64 2
    %define ELFDATA2LSB 1
    %define ELFDATA2MSB 2
    ; ELF file version
    %define EV_CURRENT 1
    ; ELF OS ABI defines
    %define ELFOSABI_SYSV 0
    %define ELFOSABI_HPUX 1
    %define ELFOSABI_NETBSD 2
    %define ELFOSABI_GNU 3
    %define ELFOSABI_LINUX ELFOSABI_GNU ; compatibility alias
    %define ELFOSABI_SOLARIS 6
    %define ELFOSABI_AIX 7
    %define ELFOSABI_IRIX 8
    %define ELFOSABI_FREEBSD 9
    %define ELFOSABI_TRU64 10
    %define ELFOSABI_MODESTO 11
    %define ELFOSABI_OPENBSD 12
    %define ELFOSABI_ARM_AEABI 64
    %define ELFOSABI_ARM 97
    %define ELFOSABI_STANDALONE 255
    ; executable types
    %define ET_REL 1
    %define ET_EXEC 2
    %define ET_DYN 3
    %define ET_CORE 4
    ; e_machine (architecture) values, not a complete set since we are only a poc/toy implementation
    %define EM_386           3
    %define EM_MIPS          8
    %define EM_S370          9
    %define EM_MIPS_RS3_LE  10
    %define EM_SPARC32PLUS  18
    %define EM_960          19
    %define EM_PPC          20
    %define EM_PPC64        21
    %define EM_S390         22
    %define EM_ARM          40
    %define EM_SPARCV9      43
    %define EM_IA_64        50
    %define EM_X86_64       62
    %define EM_PDP10        64
    %define EM_PDP11        65
    ; end of ElfN_Ehdr macros -----------------------------------------------------------------------------------


    ; ElfN_Phdr macros

    ; p_type macros
    %define PT_NULL       0
    %define PT_LOAD       1
    %define PT_DYNAMIC    2
    %define PT_INTERP     3
    %define PT_NOTE       4
    %define PT_SHLIB      5
    %define PT_PHDR       6
    %define PT_LOPROC     0x70000000
    %define PT_HIPROC     0x7fffffff
    %define PT_GNU_STACK  0x6474e551

    ; p_flags macros
    %define PF_X  1
    %define PF_W (1 << 1)
    %define PF_R (1 << 2)

    struc Elf64_Ehdr
        .e_ident:      resb EI_NIDENT
        .e_type:       resw 1
        .e_machine:    resw 1
        .e_version:    resd 1
        .e_entry:      resq 1
        .e_phoff:      resq 1
        .e_shoff:      resq 1
        .e_flags:      resd 1
        .e_ehsize:     resw 1
        .e_phentsize:  resw 1
        .e_phnum:      resw 1
        .e_shentsize:  resw 1
        .e_shnum:      resw 1
        .e_shstrndx:   resw 1
    endstruc


    struc Elf64_Phdr
        .p_type:     resd 1
        .p_flags:    resd 1
        .p_offset:   resq 1
        .p_vaddr:    resq 1
        .p_paddr:    resq 1
        .p_filesz:   resq 1
        .p_memsz:    resq 1
        .p_align:    resq 1
    endstruc

%endif
