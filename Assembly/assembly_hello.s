.global _start
.intel_syntax noprefix

_start:
  # Write console
  mov rax, 1
  mov rdi, 1
  lea rsi, [hello_ptr] # to access a pointer
  mov rdx, [hello_size]
  syscall

  # Read
  mov rax, 0
  syscall

  # Exit
  mov rax, 60
  mov rdi, 0
  syscall

hello_ptr:
  .asciz "Hello world\n"

hello_size:
  .int 13
