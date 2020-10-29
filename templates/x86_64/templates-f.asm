format ELF64 executable 3

segment readable writable
	msg db 'message', 10, 0

segment readable executable
entry main

main:
	lea rdi, [msg]
	call strlen
	; mov rax, 9
	mov rdx, rax
	mov rsi, rdi
	mov rdi, 1
	mov rax, 1
	syscall

	xor rdi, rdi
	mov rax, 60
	syscall

strlen:
	push rdi
	push rcx
	sub  rcx, rcx
	mov  rcx, -1
	sub  al,  al
	cld
	repne scasb
	neg  rcx
	mov  rcx, 1
	mov  rax, rcx
	pop  rcx
	pop  rdi
	ret
