CC = fasm

once: t-fasm.asm
	$(CC) t-fasm.asm
	ld -o t-fasm t-fasm.o

run: t-fasm
	./t-fasm

dump: t-fasm
	objdump -S -M intel -d t-fasm > t-fasm.dump
	cat t-fasm.dump

hex: t-fasm
	hexeditor t-fasm

clear:
	rm -rf t-fasm.o
