.global _start

.data
file: .ascii "hello.txt\0"
write: .ascii "hello file\0"
space: .space 100

.text
_start:
	mov $2,    %rax
	mov $file, %rdi
	mov $2,    %rsi
	mov $0777, %rdx
	syscall

	mov %rax,    %r8
	mov %r8,    %rdi
	mov $write, %rsi
	mov $11,    %rdx
	syscall

	mov %rax,   %r9
	mov $0,     %rax
	mov %r9,    %rdi
	mov $space, %rsi
	mov $100,   %rdx
	syscall

	mov $1,     %rax
	mov $1,     %rdi
	mov $space, %rsi
	mov $100,   %rdx
	syscall

	mov $3,  %rax
	mov $r8, %rdi
	syscall

	mov $60, %rax
	mov $0,  %rdi
	syscall
	
