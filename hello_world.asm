.data 
	hello_world:    .asciiz 
	new_line:  	.byte 
.text 
main:
	la $a0, hello_world
	li $v0, 4
	syscall
	
	la $a0, new_line
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall