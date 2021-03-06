TOTAL_COUNT equ 50
LENGTH      equ 20
WIDTH       equ 10
AREA        equ LENGTH * WIDTH

%assign TOTAL 10
%assign TOTAL 20

%define PTR [EBX + 4]

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

	count dw 0
	value db 15

	msg1 db "enter a digit ", 0xa, 0xd
	len1 equ $ - msg1

	msg2 db "please enter second value ", 0xa, 0xd
	len2 equ $ - msg2

	msg3 db "the sum is: "
	len3 equ $ - msg3

	message db "the largest digit is ", 0xa, 0xd
        length equ $ - message
        num1 dd '47'
        num2 dd '22'
        num3 dd '31'
	achar db '0'

	file_name db "file.txt"
	_m db "hello world", 0xa
	_l equ $ - _m
	_m_done db "written to file", 0xa
	_len_done equ $ - _m_done

x:
	db 2
	db 4
	db 3

sum:
	db 0

segment .bss
	num1    resb 2
	num2    resb 2
	res     resb 1
	largest resb 2
	
	fd_out  resb 1
	fd_in   resb 1
	info    resb 26	

segment .text
	global _start

top:
        add ebx, [ecx]
        add ecx, 1
        dec eax
        jnz top

done:
        add ebx, '0'
        mov [sum], ebx

display:
        mov edx, 1
        mov ecx, sum
        mov ebx, 1
        mov eax, 4
        int 80h

        mov eax, 1
        int  80h

_start:
	mov eax, 8
	mov ebx, file_name
	mov ecx, 0777o
	int 80h

	mov [fd_out], eax

	mov edx, _l
	mov ecx, _m
	mov ebx, [fd_out]
	mov eax, 8
	int 80h

	mov eax, 6
	mov ebx, [fd_out]

	mov eax, 4
	mov ebx, 1
	mov ecx, _m_done
	mov edx, _l_done
	int 80h

	mov eax, 5
	mov ebx, file_name
	mov ecx, 0
	mov edx, 0777o
	int 80h

	mov [fd_in], eax

	mov eax, 3
	mov ebx, [fd_in]
	mov ecx, info
	mov edx, 26
	int 80h

	mov eax, 6
	mov ebx, [fd_in]
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, info
	mov edx, 26
	int 80h

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

	mov ecx, TOTAL_COUNT
	cmp eax, TOTAL_COUNT

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

 	mov ecx, [num1]
        cmp ecx, [num2] ;47 - 22 > 0 -> jg
        jg check_third_num
        mov ecx, [num2]

check_third_num:
        cmp ecx, [num3] ;47 - 31 > 0 -> jg
        jg _exit
        mov ecx, [num3]
	ret

l1:
        mov [num], eax
        mov eax, 4
        mov ebx, 1
        push ecx

        mov ecx, num
        mov edx, 1
        int 80h

        mov eax, [num]
        sub eax, '0'
        inc eax
        add eax, '0'
        pop ecx
        loop l1
	
	call display_ascii
        mov eax, 1
        mov ebx, 0
        int 80h

display_ascii:
        mov ecx, 256

next:
        push ecx
        mov eax, 4
        mov ebx, 1
        mov ecx, achar
        mov edx, 1
        int 80h

        pop ecx
        mov dx, [achar]
        cmp byte [achar], 0dh
        inc byte [achar]
        loop next
        ret

_exit:
        mov [largest], ecx
        mov ecx, message
        mov edx, length
        mov ebx, 1
        mov eax, 4
        int 80h

        mov ecx, [largest]
        mov edx, 2
        mov ebx, 1
        mov eax, 4
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 0x80
