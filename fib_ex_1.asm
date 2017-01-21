.data 
	message: .asciiz "Enter a number: \n"
	var: .word 
	answer: .word

.text
	#load values of numbers to registers
	li $t0, 0
	li $t1, 1
	li $t2, 0
	li $t3, 2 #iterator
	
	# Prompt to enter a number
	li $v0, 4
	la $a0, message
	syscall
	
	# Get an integer
	li $v0, 5
	syscall
	move $t4, $v0
	
	
	loop:
	bge $t3, $t4, exit
	
	add $t2, $t1, $t0
	move $t0, $t1
	move $t1, $t2
	add $t3, $t3, 1
	
	j loop
	exit:
	
	# Output result
	li $v0, 1
	move $a0, $t2
	syscall
	