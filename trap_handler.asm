 .data
 	text1: .asciiz "Enter first argument \n"
	text2: .asciiz "Enter second argument \n"
 .text
main:
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
	
   teqi $t1, 0 # immediately trap because $t1 contains 0
   bne $t1, 0, divide # divide entered numbers if everything is ok
   # Display results
	li $v0, 1
	add $a0, $zero, $13
	syscall
	
   li   $v0, 10   # After return from exception handler, specify exit service
   syscall        # terminate normally
   
divide:
   div $t3, $t0, $t1 
   # Display results
	li $v0, 1
	add $a0, $zero, $t3
	syscall
	
# Trap handler in the standard MIPS32 kernel text segment

   .ktext 0x80000180
   move $k0,$v0   # Save $v0 value
   move $k1,$a0   # Save $a0 value
   la   $a0, msg  # address of string to print
   li   $v0, 4    # Print String service
   syscall
   move $v0,$k0   # Restore $v0
   move $a0,$k1   # Restore $a0
   mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
   addi $k0,$k0,4 # Add 4 to point to next instruction
   mtc0 $k0,$14   # Store new address back into $14
   mtc0 $t6, $13
     # Display results
	li $v0, 1
	add $a0, $zero, $t6
	syscall
   eret           # Error return; set PC to value in $14
   .kdata	
msg:   
   .asciiz "Dividing by zero is forbidden \n"