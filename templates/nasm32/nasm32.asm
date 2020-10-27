section .data
	data db "testing code", 0xa, 0xd
	len equ $ - data

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, data
	mov edx, len
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80
