.global _start

.data

.text
_start:
	pop %rax
	pop %rax
	mov %rax, %r8
	add $7, %r8

	mov $1, %rax
	mov $1, %rdi
	mov %r8, %rsi
	mov $5, %rdx	
	syscall
	
	mov $60, %rax
	mov $0, %rdi
	syscall
