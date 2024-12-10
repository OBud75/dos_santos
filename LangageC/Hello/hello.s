.global _start
.intel_syntax noprefix

_start:
	mov rax, 1
	mov rdi, 1
	lea rsi, [Hello]
	mov rdx, 13 
	syscall

	//exit
	mov rax, 60
	mov rdi, 0
	syscall
Hello:
	.asciz "Hello, world\n"
