STDIN_FILE  equ 0
STDOUT_FILE equ 1
STDERR_FILE equ 2

SYS_WRITE equ 0
SYS_READ  equ 1
SYS_EXIT  equ 60

EXIT_SUCCESS equ 0

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

	mov rax, SYS_EXIT
	mov rdi, EXIT_SUCCESS
	syscall

_get_name:
	mov rax, SYS_READ
	mov rdi, STDIN_FILE
	mov rsi, name
	mov rdx, 16
	syscall
	ret

_print_text_a:
	mov rax, SYS_WRITE
	mov rdi, STDOUT_FILE
	mov rsi, text_a
	mov rdx, 20
	syscall
	ret

_print_text_b:
	mov rax, SYS_WRITE
	mov rdi, STDOUT_FILE
	mov rsi, text_b
	mov rdx, 9
	syscall
	ret

_print_name:
	mov rax, SYS_WRITE
	mov rdi, STDOUT_FILE
	mov rsi, name
	mov rdx, 16
	syscall
	ret
