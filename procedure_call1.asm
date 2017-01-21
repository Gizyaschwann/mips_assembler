.text
main:
	# write values to refisters
	li $a0, 10
	li $a1, 11
	
	# call add_two function, move result to $a0 register
	jal add_two
	move $a0, $v0
	
	# print result
	li $v0, 1
	syscall
	
	move $a0, $t0
	syscall
	
	#exit
	li $v0, 10
	syscall
add_two:
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	
	add $t0, $a0, $a1
	add $v0, $0, $t0
	
	lw $t0, 0($sp)
	addi $sp, $sp, 4
	jr $ra