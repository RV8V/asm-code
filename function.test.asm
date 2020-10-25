.global _start

.data
hello: .string "hello\n"

.text
_start:
	call output
	call exit
	
output:
	mov $1, %rax
	mov $1, %rdi
	mov $hello, %rsi
	mov $7, %rdx
	syscall
	ret

exit:
	mov $60, %rax
	mov $0, %rdi
	syscall
