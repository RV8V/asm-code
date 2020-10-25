.global _start

.data
hi: .ascii "hello\n\0"
len = . - hi

.text
_start:
	mov $0, %r8
	call hi_loop
	call exit

hi_loop:
	mov $1,   %rax
	mov $1,   %rdi
	mov $hi,  %rsi
	mov $len, %rdx
	syscall

	add $1, %r8
	cmp $5, %r8
	jz exit
	
	jmp hi_loop

exit:
	mov $60, %rax
	mov $0,  %rdi
	syscall
