%include "linux64.inc"

section .data
	filename db "file.txt", 0
	data db "hello world", 0

section .text
	global _start

_start:
	mov rax, SYS_OPEN
	mov rdi, filename
	mov rsi, O_CREATE+O_WRONGLY
	mov rdi, 0644o
	syscall

	push rax
	mov rdi, rax
	mov rax, SYS_WRITE
	mov rsi, data
	mov rdx, 17
	syscall

	mov rax, SYS_CLOSE
	pop rdi
	syscall

	exit 
