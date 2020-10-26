.global _start

.data
hi: .ascii "hello world\n\0"
int: .int 1
len = . - hi

.text
_start:
	mov $hi, %r8
	add $1,  %r8

	mov $int, %r9	

	mov (%r9),   %rax
	mov (%r9),   %rdi
	mov %r8,  %rsi
	mov $len, %rdx
	syscall

	mov 4(%r9), %rax
	mov 4(%r9), %rdi
	syscall

	mov $60, %rax
	mov $0,  %rdi
	syscall
	
