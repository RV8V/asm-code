section .data
	digit db 0, 9

section .text
	global _start

%macro exit 0
	mov rax, 60
	mov rdi, 0
	syscall
%endmacro

%macro print_digits 1
	mov rax, %1
	call _print_rax_digit
%endmacro

%macro print_some 2
	mov rax, %1
	add rax, %2
	call _print_rax_digit
%endmacro

_start:
	print_digits 3
	print_digits 4
	exit

	mov rax, 7
	call _print_rax_digit
	call _print_div
	call _print_add
	call _value
	call exit

_print_rax_digit:
	add rax, 48
	mov [digit], al
	mov rax, 1
	mov rdi, 1
	mov rsi, digit
	mov rdx, 2
	syscall
	ret

_value:
	push 4
	push 8
	push 3
	pop rax
	call _print_rax_digit
	pop rax
	call _print_rax_digit
	pop rax
	call _print_rax_digit

_print_div:
	mov rax, 6
	mov rbx, 2
	div rbx
	call _print_rax_digit

_print_add:
	mov rax, 1
	add rax, 4
	call _print_rax_digit

exit:
	mov rax, 60
	mov rdi, 0
	syscall
