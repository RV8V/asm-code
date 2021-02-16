#!/bin/bash

fileasm=$(ls *.asm)
nasm -f elf $fileasm
file=${fileasm//asm./}
fileo=$(ls *.o)
ld -m elf_i386 -s -o $file $fileo
rm -rf $fileo
./$file
