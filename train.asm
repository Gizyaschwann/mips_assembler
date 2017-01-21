.data
	size_message: .asciiz "Please, enter a number of elements you would like to sort:\n"
.text
	# Ask for number of elements
	li $v0, 4
	la $a0, size_message
	syscall
	
	# Get number of elements
	li $v0, 5
	syscall
		
	sll $a0, $v0, 2
	
	li $v0, 1
	
	syscall