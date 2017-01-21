.data 
	message: .asciiz "Hi! My name is Ilyuza \n"
.text
	jal displayMessage
	
	addi $s0, $zero, 5
	#Print 5 to screen
	
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	
	# To exit
	li $v0, 10
	syscall
	
	displayMessage:
	li $v0, 4
	la $a0, message
	syscall
	
	jr $ra