.global _start

.data
a: .space 10

.text
_start:
	mov $0,  %rax
    	mov $0,  %rdi
    	mov $a,  %rsi
    	mov $10, %rdx
    	syscall

    	mov $1,  %rax
    	mov $1,  %rdi
   	mov $a,  %rsi
    	mov $10, %rdx
    	syscall

    	mov $60, %rax
    	mov $0,  %rsi
    	syscall
