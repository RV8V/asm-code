.global _start

.data
s: .ascii "testing string\n\0"
len = . - s

.text
_start:
	mov  $s,    %r8
	movb $'a', 4(%r8)

	mov $1,   %rax
	mov $1,   %rdi
	mov $s,   %rsi
	mov $len, %rdx
	syscall

	mov $60, %rax
	mov $0,  %rdi
	syscall

