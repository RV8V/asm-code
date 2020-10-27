BYTE_VALUE db 150
WORD_VALUE dw 300
BYTE_TABLE db 14, 15, 22, 45
WORD_TABLE dw 134, 456, 214, 893
MY_TABLE times 10 dw 0

segment .data
	name db 'test string ', 10
	len equ $ - name

segment .text
	global _start

_start:
	;mov ebx,   [MY_TABLE]
	;mov dword  [ebx], 110 ; MY_TABLE + 0 = 110
	;add ebx,   2          ; ebx = ebx + 2
	;mov dword  [ebx], 123 ; TABLE + 1 = 123
	;int 80h

	mov edx, len
	mov ecx, name
	mov ebx, 1
	mov eax, 4
	int 80h

	mov [name], dword 'hell'

	mov edx, len
	mov ecx, name
	mov ebx, 1
	mov eax, 4
	int 80h

	;mov cl, BYTE_TABLE[2]
	;mov cl, BYTE_TABLE + 2
	;mov cx, WORD_TABLE[2]
	;mov cx, WORD_TABLE + 3
	;int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
