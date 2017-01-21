.data 
	welcome_message: .asciiz "\n Welcome to an assembler sorting program!\n"
	size_message: .asciiz "Please, enter a number of elements you would like to sort:\n"
	quantity_message: .asciiz "\n Enter elements (press 'Enter' button after entering each):\n"
	probel: .asciiz "\n"
	var: .word 
	answer: .word
.text
	.globl main
main:
	# Print welcome message
	li $v0, 4
	la $a0, welcome_message
	syscall

	# Ask for number of elements
	li $v0, 4
	la $a0, size_message
	syscall
	# Get number of elements
	li $v0, 5
	syscall
	
	#addi $t0, $zero, 4 # задаем t0 размер одного инта
	#mult $t0, $v0 # находим размер будущего массива по количеству введённых элементов
	#mflo $s0 # сохраняем значение размера
	
	#Save initial size of array
	add	$t0	$zero	$v0
	
	sll	$a0	$v0	2	#Multiply $v0 by 2^2
	li	$v0	9
	syscall	
	move	$s0	$v0
	
	# вывод размера массива в байтах
	move $a0, $s0
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, probel
	syscall
	
	# Ask for elements
	li $v0, 4
	la $a0, quantity_message
	syscall

	#Index - t1
	addi $t1, $zero, 0
		
	move	$s1	$s0
	
	
	#loop for reading elements
	input_loop:
	beq $t1, $t0, exit
	li $v0, 5
	syscall
	
	move $t2, $v0 # save input value of element in $t2
	
	#move $a0, $v0
	#li $v0, 1
	#syscall
	
	#li $v0, 4
	#la $a0, probel
	#syscall
	
	sw $t2, ($s1)
	addi $s1, $s1, 4
	addi $t1, $t1, 1
	j input_loop
	exit:
		move	$s3	$s0
		addi	$t1	$zero	0
		li	$v0	4
		la	$a0	probel
		syscall
		j	printArray	

jal selectionSort
# $t0 - size, $t1 - i, $s1 - adress
selectionSort:
		#i - $t0, j - $t1, m - $t2
		add $s0, $zero, $t0
		addi	$t1	$zero	0
		
		while3:
			beq	$t0	$s0	exit3
			
			#j = i
			add	$t1	$zero	$t0
			#m = i
			add	$t2	$zero	$t0
			
			while4:
				bge	$t1	$s0	exit4
				
				#Load a[j] to $t4
				sll	$s1	$t1	2
				addu	$s1	$s1	$s2
				lw	$t4	($s1)
				
				#Load a[m] to $t5
				sll	$s1	$t2	2
				addu	$s1	$s1	$s2
				lw	$t5	($s1)
				
				#Check a[j] < a[m] and save result to $t6
				slt	$t7	$t4	$t5
					
				#If $s0 is true
				bne	$t7	$zero	changeRegisters
				
				addi	$t1	$t1	1	
							
				j	while4
				
			changeRegisters:
				add	$t2	$zero	$t1				
				addi	$t1	$t1	1				
				j	while4
				
			exit4:
				li	$v0	4
				la	$a0	probel
				syscall
				
			#Load a[i] to $t3
			sll	$s1	$t0	2
			addu	$s1	$s1	$s2
			lw	$t3	($s1)
			
			#Load a[m] to $t5
			sll	$s1	$t2	2
			addu	$s1	$s1	$s2
			lw	$t5	($s1)
			
			#Save $t5 to a[i]
			sll	$s1	$t0	2
			addu	$s1	$s1	$s2
			sw	$s1	($s1)
			
			#Save $t3 to a[m]
			sll	$s1	$t2	2
			addu	$s1	$s1	$s2
			sw	$t3	($s1)			
		
			addi	$t0	$t0	1
			
			j	while3
		exit3:
			move	$s3	$s1
		addi	$t1	$zero	0
		li	$v0	4
		la	$a0	probel
		syscall
		jal	printArray		
		
	jr	$ra
	
	move	$s3	$s1
		addi	$t1	$zero	0
		li	$v0	4
		la	$a0	probel
		syscall
		jal	printArray	

								
	printArray:
		beq $t1, $t0, exitPrint
		
		#Load address to $t1 from index
		sll	$t2	$t1	2			
		#Load complete element to $t1 from #s3
		addu	$t2	$t2	$s3			
		#Load value in index $t0 to $t2
		lw	$t3	0($t2)
		
		li	$v0	1
		move	$a0	$t3
		syscall
		
		li	$v0	4
		la	$a0	probel
		syscall
		
		addi	$t1	$t1	1
		
		j	printArray
		
	exitPrint:
	

	
		li	$v0	10
		syscall
		
	
