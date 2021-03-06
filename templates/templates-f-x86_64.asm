format ELF64 executable 3

segment readable writable
	msg    db 'message', 10, 0
	_m     db 'this is another string', 10, 0
	prompt db 'please enter your name: ', 0
	buffer rb 64

segment readable executable
entry main

include 'unistd64.inc'
include 'io.inc'

main:
	lea  rdi, [prompt]
	call print
	lea  rsi, [buffer]
	mov  rdi, 64
	call read
	mov  rdi, rsi
	call print

	lea  rdi, [msg]
	call print
	lea  rdi, [_m]
	call print
	; call strlen
	; mov rax, 9
	; mov rdx, rax
	; mov rsi, rdi
	; mov rdi, 1
	; mov rax, 1
	; syscall

	xor rdi, rdi
	mov rax, sys_exit
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

print:
	call strlen
	mov rdx, rax
	mov rsi, rdi
	mov rdi, 1
	mov rax, sys_write
	syscall
	ret

read:
	mov rdx, rdi
	mov rdi, 0
	mo  rax, sys_read
	syscall
	ret
