.data
	
	welcome_message: .asciiz "\n Welcome to an assembler sorting program!\n"
	type_message: .asciiz "Please, enter type of elements you would like to sort: 1 - if you prefer ints and 2 - strings\n"
	size_message: .asciiz "Please, enter a number of elements you would like to sort:\n"
	quantity_message: .asciiz "\n Enter elements (press 'Enter' button after entering each):\n"
	before_sorting: .asciiz "\n Elements before sorting:\n"
	after_sorting: .asciiz "\n Elements after sorting:\n"
	probel: .asciiz "\n" # It`s just a newline
	space: .asciiz " " # It`s a space
	var: .word 
	answer: .word
	
	# Size of string array
	size: .word 4
	
	
.text
	.globl main
main:
	# Print welcome message
	li $v0, 4
	la $a0, welcome_message
	syscall

	# Ask for type of sorting elements
	li $v0, 4
	la $a0, type_message
	syscall
	
	# Get type of elements(1 or 2)
	li $v0, 5
	syscall
		
	#Save value of type to $t0
	move $t0, $v0
		
		
	li $v0, 4
	la $a0, probel
	syscall
		
		beq $t0, 1, sortInteger
		
		#beq $s1, 2, sortStrings
		
sortInteger:
	# Ask for number of elements
	li $v0, 4
	la $a0, size_message
	syscall
	
	# Get number of elements
	li $v0, 5
	syscall
		
	#Save size to $s0
	add $s0, $zero, $v0
		
		#Multiply by left bitshift
		sll $a0, $v0, 2
		
		#Allocate memory for array
		li $v0,	9
		syscall
		
		#Copy allocated space to $s2
		move $s2, $v0
				
	li $v0, 4
	la $a0, probel
	syscall
		
		
	#Print message
	li $v0, 4
	la $a0, quantity_message
	syscall
		
	#$t0 for index
	addi $t0, $zero, 0
		
	#$t1 for temporary container for size of array
	add	$t1, $s0, $zero	
	sll	$t1, $t1, 2
		
	#Copy space of array temporary to $t3
	move	$t3	$s2
				
	#loop for reading elements
input_loop:

	beq $t0, $t1, exit_input_loop
		
	li $v0, 5
	syscall
						
	#Save value of element to $t3
	sw $v0, 0($t3)
						
	addi $t0, $t0, 4	
	addi $t3, $t3, 4
			
	j input_loop
	
exit_input_loop:
	
			
print_array:	
		li $v0, 4
		la $a0, before_sorting
		syscall
		
		#Set index to zero
		addi $t0, $zero, 0
		
		#Copy array to $s3
		move $s3, $s2
		
	#loop for printing array
	print_loop:
			beq $t0, $s0, exit_print_loop
			
			#Load address to $t1 from index
			sll	$t1	$t0	2			
			#Load complete element to $t1 from #s3
			addu	$t1	$t1	$s3			
			#Load value in index $t0 to $t2
			lw	$t2	0($t1)
			
			#Print value
			li	$v0, 1
			move	$a0, $t2
			syscall
			li $v0,	4
			la $a0,	space
			syscall
						
			
			addi $t0, $t0, 1
			j print_loop
	exit_print_loop:
			
	
selection_sort:

	#i = 0 (i - $t0)
	addi	$t0, $zero, 0	
	
	sort_loop:
			beq $t0, $s0, exit_sort_loop
			
			#j = i
			add $t1, $zero, $t0
			#m = i
			add $t2, $zero,	$t0
			
			loop1:
				bge $t1, $s0, exit_loop1
				
				# $t4 = a[j]
				sll $t6	$t1, 2
				addu $t6, $t6, $s2
				lw $t4,	($t6)
				
				# $t5 = a[m]
				sll $t6, $t2, 2
				addu $t6, $t6, $s2
				lw $t5,	($t6)
				
				#Check a[j] < a[m] and save result to $t7
				slt $t7, $t4, $t5
					
				
				bne $t7, $zero,	change_registers
				
				addi $t1, $t1, 1	
							
				j loop1
				
			change_registers:
				add $t2, $zero,	$t1				
				addi $t1, $t1, 1				
				j loop1
				
			exit_loop1:
				
			# $t3 = a[i]
			sll $t6, $t0, 2
			addu $t6, $t6, $s2
			lw $t3,	($t6)
			
			#$t5 = a[m]
			sll $t6, $t2, 2
			addu $t6, $t6, $s2
			lw $t5,	($t6)
			
			#Save $t5 to a[i]
			sll $t6, $t0, 2
			addu $t6, $t6, $s2
			sw $t5,	($t6)
			
			#Save $t3 to a[m]
			sll $t6, $t2, 2
			addu $t6, $t6, $s2
			sw $t3,	($t6)			
		
			addi $t0, $t0, 1
			
			j sort_loop
	exit_sort_loop:

		
print_sorted_array:	
		li $v0, 4
		la $a0, after_sorting
		syscall
		
		#Set index to zero
		addi $t0, $zero, 0
		
		#Copy array to $s3
		move $s3, $s2
		
	#loop for printing array
	print_loop1:
			beq $t0, $s0, exit_print_loop1
			
			#Load address to $t1 from index
			sll	$t1, $t0, 2			
			#Load complete element to $t1 from #s3
			addu	$t1, $t1, $s3			
			#Load value in index $t1 to $t2
			lw	$t2, 0($t1)
			
			#Print value
			li	$v0, 1
			move	$a0, $t2
			syscall
			li $v0,	4
			la $a0,	space
			syscall
						
			
			addi $t0, $t0, 1
			j print_loop1
	exit_print_loop1:
			li $v0, 4
			la $a0, probel
			syscall
		


# Exit program
	li $v0, 10
	syscall		
				
