segment .data
	data db "testing code", 0xa, 0xd
	len equ $ - data
	message db 'display 9 start', 0xa
	len_m equ $ - message
	s2 times 9 db '*'
	name db 'test string ', 10
	len_s equ $ - name

	BYTE_VALUE db 150
	WORD_VALUE dw 300
	BYTE_TABLE db 14, 15, 22, 45
	WORD_TABLE dw 134, 456, 214, 83
	MY_TABLE times 10 dw 0

	choice        db 'y', 10
        number        dw 643
        neg_number    dw -425
        big_number    dq 9382982
        real_number   dd 3.1342
        real_number_t dq 244.523

	arr times   9 dw 0
	stars times 9 db '*'

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

        mov ebx,   [MY_TABLE]
	mov dword  [ebx], 110 ; MY_TABLE + 0 = 110
	add ebx,   2          ; ebx = ebx + 2
	mov dword  [ebx], 123 ; TABLE + 1 = 123
	int 80h

	mov edx, len_s
	mov ecx, name
	mov ebx, 1
	mov eax, 4
	int 80h

	mov [name], dword 'hell'

	mov edx, len_s
	mov ecx, name
	mov ebx, 1
	mov eax, 4
	int 80h

	mov edx, 2
        mov ecx, choice
        mov ebx, 1
        mov eax, 4
        int 0x80

	mov cl, BYTE_TABLE[2]
	mov cl, BYTE_TABLE + 2
	mov cx, WORD_TABLE[2]
	mov cx, WORD_TABLE + 3
	int 80h

	mov eax, 1
	mov ebx, 0
	int 0x80
