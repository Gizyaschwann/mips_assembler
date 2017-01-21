.data
	list: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
.text
	la $t3, list
	
	#la $t3, list         # put address of list into $t3
    li $t2, 6            # put the index into $t2
    addi $t5, $zero, 4
    mul $t2, $t2, $t5
  #  add $t2, $t2, $t2    # double the index
  #  add $t2, $t2, $t2    # double the index again (now 4x)
    add $t1, $t2, $t3    # combine the two components of the address
    lw $t4, 0($t1)       # get the value from the array cell
    #addi $t4, $zero, 12
    #sw $t4, 0($t1)
    
    #lw $t6, 0($t1)
    
    move $a0, $t4
	li $v0, 1
	syscall