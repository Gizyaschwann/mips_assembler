.data 
	text1: .asciiz "Enter first argument \n"
	text2: .asciiz "Enter second argument \n"
	var1: .word 
	var2: .word
.text
	# Prompt the user to enter first argument
	li $v0, 4
	la $a0, text1
	syscall
	
	# Get first argument and store it in $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	# Prompt the user to enter second argument
	li $v0, 4
	la $a0, text2
	syscall
	
	# Get second argument and store it in $t0
	li $v0, 5
	syscall
	move $t1, $v0
	
	# Addition of 2 integers
	add $t2, $t0, $t1
	
	# Display results
	li $v0, 1
	add $a0, $zero, $t2
	syscall