ASFLAGS = -f bin

AS = nasm

BINS = hello minimal macro-minimal

.PHONY: all clean inspect-hello inspect-minimal
all: $(BINS) .gitignore

hello: hello.asm elf.inc
	$(AS) $(ASFLAGS) $< -o $@
	chmod +x $@

minimal: minimal.asm elf.inc
	$(AS) $(ASFLAGS) $< -o $@
	chmod +x $@

macro-minimal: macro-minimal.asm elf.inc
	$(AS) $(ASFLAGS) $< -o $@
	chmod +x $@

clean:
	rm -f $(BINS)

inspect-hello: hello
	readelf -h hello
	readelf -l hello

inspect-minimal: minimal
	readelf -h minimal
	readelf -l minimal

inspect-macro-minimal: macro-minimal
	readelf -h macro-minimal
	readelf -l macro-minimal
