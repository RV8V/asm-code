%macro print 1
	mov rax, %1
	mov rbx, COUNTER
%%print_loop:
	mov cl, [rax]
	cmp cl, LAST_SYMBOL
	je %%end_print_loop
	inc rbx
	inc rax
	jmp %%print_loop
%%end_print_loop:
	mov rax, SYS_WRITE
	mov rdi, STDOUT_FILE
	mov rsi, %1
	mov rdx, rbx
	syscall
%endmacro

%macro exit 0
	mov rax, SYS_EXIT
	mov rdi, EXIT_SUCCESS
	syscall
%endmacro

STDOUT_FILE  equ 1
EXIT_SUCCESS equ 0
SYS_EXIT     equ 60
SYS_WRITE    equ 1
COUNTER      equ 0
LAST_SYMBOL  equ 0
