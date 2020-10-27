segment .data
	data db "testing code", 0xa, 0xd
	len equ $ - data
	message db 'display 9 start', 0xa
	len_m equ $ - message
	s2 times 9 db '*'

segment .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, data
	mov edx, len
	int 0x80
	
	mov edx, 9
	mov ecx, s2
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80
