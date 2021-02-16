format ELF64
public _start

section '.data' writable
	_buffer.size equ 20

section '.bss' writable
	_buffer  rb _buffer.size
	bss_char rb 1

section '.text' executable
_start:
	; mov  rax, 0
	; call print_number

	mov  rax, 571
	mov  rbx, _buffer ; _buffer contains string
	mov  rcx, _buffer.size
	call number_to_string
	call print_line

	mov  rax, _buffer
	call print_string
	call print_line

	xor  rax, rax
	mov  rbx, _buffer
	mov  al, [rbx+_buffer.size-1]
	call print_number
	call print_line
	call exit

; rsi, rdi, rbp, rsp
; mm0 .. mm7 ; 64 bit
; r8 .. r15 ; 64 bit

section '.number_to_string' executable
; | input
; rax = number
; rbx = buffer
; rcx = buffer.size
number_to_string:
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	mov  rsi, rcx
	dec  rsi
	xor  rcx, rcx
	.next_iter:
		push rbx
		mov  rbx, 10
		xor  rdx, rdx
		div  rbx
		pop  rbx
		add  rdx, '0'
		push rdx
		inc  rcx
		cmp  rax, 0
		je  .next_step	
		jmp .next_iter
	.next_step:
		mov rdx, rcx
		xor rcx, rcx
	.to_string:
		cmp rcx, rsi
		je  .pop_iter
		cmp rcx, rdx
		je  .null_char
		pop rax
		mov [rbx+rcx], rax
		inc rcx
		jmp .to_string
	.pop_iter:
		cmp rcx, rdx
		je  .close
		pop rax
		inc rcx
		jmp .pop_iter
	.null_char:
		mov rsi, rdx
	.close:
		mov [rbx+rsi], byte 0
		pop rsi
		pop rdx
		pop rcx
		pop rbx
		pop rax
		ret

section '.print_number' executable
print_number:
	push rax
	push rbx
	push rcx
	push rdx
	xor rcx, rcx
	.next_iter:
		mov  rbx, 10
		xor  rdx, rdx
		div  rbx
		add  rdx, '0'
		push rdx
		inc  rcx
		cmp  rax, 0
		je  .print_iter
		jmp .next_iter
	.print_iter:
		cmp  rcx, 0
		je  .close
		pop  rax
		call print_char
		dec  rcx
		jmp .print_iter
	.close:
		pop rdx
		pop rcx
		pop rbx
		pop rax
		ret

section '.print_char' executable
print_char:
	push rax
	push rbx
	push rcx
	push rdx

	mov [bss_char], al
	mov rax, 4
	mov rbx, 1
	mov rcx, bss_char
	mov rdx, 1
	int 0x80

	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret
	
section '.print_line' executable
print_line:
	push rax
	mov  rax, 0xa
	call print_char
	pop  rax
	ret

section '.text' executable
exit:
	mov rax, 1
	mov rbx, 0
	int 0x80
