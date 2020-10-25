.text

_start:
.global  _start

	mov $1,   %rax
	mov $1,   %rdi
	mov $msg, %rsi
	mov $len, %rdx
	syscall

	call exit

msg: .ascii "hello, world\n"

len = . - msg

exit:
	mov $60, %rax
  	mov $0, %rdi
  	syscall
