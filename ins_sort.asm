.data
	numbers:    .word 20, 30, 10, 40, 50, 60, 30, 25, 10, 5
	length:     .word 10            
.text            
	.globl main
main:
	# $v0 Use $2 to hold firstUnsortedIndex
	# $v1 Use $3 to hold testIndex
	# $a0 Use $4 to hold elementToInsert
	# $a1 Use $5 to hold value of numbers[ .. ]
	# $a2 Use $6 to calculate the address of numbers[ ... ] in
	# $a3 Use $7 to hold the value of (length-1)
	# $t0 Use $8 to hold the base/starting address of the numbers array
for_init:   li $v0, 1
	lw $a3, length
	sub $a3, $a3, 1
	la $t0, numbers
for_loop:   
	bgt $v0, $a3, end_for
	sub $v1, $v0, 1
	mul $a2, $v0, 4  # address of numbers[i]= base addr of numbers + i*(element size)
	add $a2, $t0, $a2
	lw $a0, 0($6)
while:            
	blt $v1, 0, end_while
	mul $a2, $v1, 4 # address of numbers[i]= base addr of numbers + i*(element size)
	add $a2, $t0, $a2
	lw $a1, 0($a2)
	ble $a1, $a0, end_while
	sw $a1, 4($a2)
	sub $v1, $v1, 1
	j while
end_while: 
	mul $a2, $v1, 4 # address of numbers[i]= base addr of numbers + i*(element size)
	add $a2, $t0, $a2
	sw $a0, 4($a2)
	addi $v0, $v0, 1
	j for_loop
	
end_for:

	li $v0, 10           # system call to exitsyscallName:_____________________________ Lecture 18  Page 1
	syscall