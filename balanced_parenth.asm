.data
	text1: .asciiz "Enter string yow:\n"
	string: .asciiz "((()))"
	length: .word 255 # Максимальная Длина стринга
.text
	# Prompt the user to enter string
	li $v0, 4
	la $a0, text1
	syscall
	
	# Get first argument and store it in $t0
	li $v0, 8
	syscall
	move $t0, $a0
	move $t1, $a1

	move $a0, $v0
	# Display results
	li $v0, 4
	syscall