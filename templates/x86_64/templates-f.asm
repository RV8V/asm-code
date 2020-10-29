format ELF64 executable 3

segment readable writable
	msg db 'message', 10, 0

segment readable executable
entry main

main:
	lea rdi, [msg]
	mov rax, 9
	mov rdx, rax
	mov rsi, rdi
	mov rdi, 1
	mov rax, 1
	syscall

	xor rdi, rdi
	mov rax, 60
	syscall
