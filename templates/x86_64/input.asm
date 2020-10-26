section .data
	text_a db "what is your name?", 20
	text_b db "hello, ", 9

section .bss
	name resb 16

section .text
	global _start

_start:
	call _print_text_a
	call _get_name
	call _print_text_b
	call _print_name	

	mov rax, 60
	mov rdi, 0
	syscall

_get_name:
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	mov rdx, 16
	syscall
	ret

_print_text_a:
	mov rax, 1
	mov rdi, 1
	mov rsi, text_a
	mov rdx, 20
	syscall
	ret

_print_text_b:
	mov rax, 1
	mov rdi, 1
	mov rsi, text_b
	mov rdx, 9
	syscall
	ret

_print_name:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 16
	syscall
	ret
