format ELF64
public _start

section '.bss' writable
	bss_char rb 1

section '.data' writable
	fmt db "%c + %d = %d", 0

; rax = 64 bit = 32|eax = 16|ax = ah|al
; al  - 8 bit

section '.text' executable
_start:
	; mov rax, 10
	; mov rbx, 20
	; mov rax, rbx
	; mov rax, 'a'
	; call print_char
	; mov rax, 'b'
	; call print_char
	; call print_line

	; mov  rax, 399
	; mov  rbx, 28
	; imul rax, rbx ; @params: 2
	; mul rbx ; @params: 1 - needs rax
	; call print_number

	mov  rax, 10
	call print_number
	mov  rax, "*"
	call print_char
	mov  rax, 725
	call print_number
	mov  rax, "="
	call print_char
	mov  rax, 10
	mov  rbx, 725
	mul  rbx
	call print_number
	call print_line
	call exit

; rax - integer | rdx - reminder
; 571 / 10 = 57 | 1 + '0' (symbol not integer)
; 57 / 10 = 5 | 7
; 5 / 10 = 0 | 5
; '0' + 1 = 48 + 1 = 49 = '1'

; | input
; rax = number
section '.print_number' executable
print_number:
	push rax
	push rbx
	push rcx
	push rdx
	xor rcx, rcx
	.next_iter:
		cmp  rax, 0
		je  .print_iter
		mov  rbx, 10
		xor  rdx, rdx
		div  rbx
		add  rdx, 48 ; '0' - 48 in ascii
		push rdx
		inc  rcx
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

; | input
; rax = char
section '.print_char' executable
print_char:
	; mov rax, 4 - write
	; mov rbx, 1 - 32 bit arch, registers sequence
	; mov rcx, 'a'
	; mov rdx, 1
	; int 0x80

	; push rax
	; mov rax, 1 ; write
	; mov rdi, 1 ; 64 bit arch, register sequence
	; mov rsi, rsp
	; mov rdx, 1
	; syscall
	; pop rax
	; ret

	push rax
	push rbx
	push rcx
	push rdx

	mov [bss_char], al ; rax - 64 bit, bss_char 8 bit
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
