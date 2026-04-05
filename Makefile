ASFLAGS = -f bin

AS = nasm

BINS = hello minimal

.PHONY: all debug clean
all: $(BINS) .gitignore

hello: hello.s elf.inc
	$(AS) $(ASFLAGS) $< -o $@
	chmod +x $@

minimal: minimal.s elf.inc
	$(AS) $(ASFLAGS) $< -o $@
	chmod +x $@

clean:
	rm -f $(BINS)
