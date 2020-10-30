format elf64 executable
entry _start
; public _start

new_line equ 10
end_sym  equ 0
message db "testing string", new_line, end_sym
length = $ - message

section '.data' writable
	_m db "message", 10, 0
	_l = $ - _m

; rax -  64
; eax -  32
; ax  -  16
; al/ah - 8

; byte -  8 bit
; word -  16 bit
; dword - 32 bit
; qword - 64 bit

section '.text' executable
_start:
	mov rax, 4
	; mov rbx, 1
	xor rbx, rbx
	inc rbx
	mov rcx, message
	mov rdx, length
	int 0x80
	; mov rax, 1
	xor rax, rax
	inc rax
	xor rbx, rbx
	; mov rbx, 0
	int 0x80
	; mov rax, 4
	; mov rbx, 1
	; mov rcx, message
	; mov rdx, length
	; int 0x80
	; mov rax, message
	; call print_message
	; call _exit

section '.print_message' executable
; | input
; rax = string
; print_message:
 	; push rax
	; push rbx
	; push rcx
	; push rdx
	; mov rcx, rax
	; call length_string
	; mov rdx, rax
	; mov rax, 4
	; mov rbx, 1
	; int 0x80
	; pop rdx
	; pop rcx
	; pop rbx
	; pop rax
	; ret	

section '.length_string' executable
; | input
; rax = string
; | output
; rax = lenght
; length_string:
	; push rdx
	; xor rdx, rdx ; mov rdx, 0
	; .next_iter:
		; cmp [rax+rdx], byte 0
		; je  .close
		; inc rdx
		; jmp .next_iter
	; .close:
		; mov rax, rdx
		; pop rdx
		; ret

section '.exit' executable
; _exit:
	; mov rax, 1
	; mov rbx, 0
	; int 0x80
