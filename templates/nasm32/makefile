all:
	nasm -f elf $(source) -o $(source).o
	ld -m elf_i386 -s -o $(source).res $(source).o
	rm $(source).o
