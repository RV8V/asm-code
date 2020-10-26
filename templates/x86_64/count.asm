section .data
	text db "hello, world", 10, 0
	text_next db "testing", 10, 0

section .text
	global _start

_start:
	mov rax, text
	call _print

	mov rax, text_next
	call _print

	mov rax, 60
	mov rdi, 0
	syscall

;input: rax as pointer to string
;output: print string at rax
_print:
	push rax
	mov rbx, 0

_print_loop:
	inc rax
	inc rbx
	mov cl, [rax]
	cmp cl, 0
	jne _print_loop

	mov rax, 1
	mov rdi, 1
	pop rsi
	mov rdx, rbx
	syscall
	ret
	
