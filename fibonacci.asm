.data 
	message: .asciiz "Enter a number: \n"
	var: .word 
	answer: .word
.text
	.globl main
	main:
	# Prompt to enter a number
	li $v0, 4
	la $a0, message
	syscall
	
	# Get an integer
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	lw $a0, var
	jal fibonacci
	sw $v0, answer
	
	li $v0, 1
	lw $a0, answer
	syscall
	
	# Exit
	li $v0, 10
	syscall
	
	
.globl fibonacci
fibonacci:
	# if n==1 return 1
	li $t0, 1
	bne $a0, $t0, l2
	li $v0, 1
	jr $ra
	
	# else if n==2 return 1
l2:
	li $t0, 2
	bne $a0, $t0, l3
	li $v0, 1
	jr $ra
	
	# else
l3:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	
	addi $a0, $a0, -1
	jal fibonacci
	sw $v0, 0($sp)
	
	lw $a0, 4($sp)
	addi $a0, $a0, -2
	jal fibonacci
	lw $a0, 0($sp)
	add $v0, $v0, $a0
	
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra


	
	
	
