.data
	message: .asciiz "Hello Assembler World \n"
.text
	li $v0, 4
	la $a0, message
	syscall