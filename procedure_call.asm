.data 
	
.text
main:
	# put values to registers
	li $t0, 10
	li $t1, 11
	
	#call function
	jal addtwo
	
	#output result
	li $v0, 1
	add $a0, $zero, $t2
	syscall
	
	# To exit
	li $v0, 10
	syscall
	
addtwo:
	add $t2, $t1, $t0
	
	jr $ra