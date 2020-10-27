SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4
STDIN_FILE  equ 0
STDOUT_FILE equ 1

segment .data
	count dw 0
	value db 15

	msg1 db "enter a digit ", 0xa, 0xd
	len1 equ $ - msg1

	msg2 db "please enter second value ", 0xa, 0xd
	len2 equ $ - msg2

	msg3 db "the sum is: "
	len3 equ $ - msg3

segment .bss
	num1 resb 2
	num2 resb 2
	res  resb 1

segment .text
	global _start

_start:
	inc dword [count] ;icrement value in variable
	inc word  [value]

	mov ebx, count
	inc word [ebx]

	mov esi, value
	dec byte [esi]

	mov eax, SYS_WRITE
	mov ebx, STDOUT_FILE
	mov ecx, msg1
	mov edx, len1
	int 0x80

	mov eax, SYS_READ
	mov ebx, STDIN_FILE
	mov ecx, num1
	mov edx, 2
	int 0x80

	mov eax, SYS_WRITE
        mov ebx, STDOUT_FILE
        mov ecx, msg2
        mov edx, len2
        int 0x80

        mov eax, SYS_READ
        mov ebx, STDIN_FILE
        mov ecx, num2
        mov edx, 2
        int 0x80

	mov eax, SYS_WRITE
	mov ebx, STDOUT_FILE
	mov ecx, msg3
	mov edx, len3
	int 0x80

	mov eax, [num1]
	sub eax, '0' ;substruct ascii '0' to convert to decimal digit
	
	mov ebx, [num2]
	sub ebx, '0'

	add eax, ebx
	add eax, '0'

	mov [res], eax

	mov eax, SYS_WRITE
	mov ebx, STDOUT_FILE
	mov ecx, res
	mov edx, 1
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80


