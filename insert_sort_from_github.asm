.globl main

.data
#int size = 16
size: 	.align 4
	.word 16
#char * [] data
data:   .align 2
	.space 64
.text

main:
	#char * [] data = { "names" }
	addr_init:
	la $t0, array
	la $t1, data
	li $t2, 0 #i = 0
	init_loop:
	beq $t2, 16, end_init #initialize addresses
	sw $t0, ($t1) #data[i] = &array[i]
	addi $t0, $t0, 16 #array = align 4 = 16
	addi $t1, $t1, 4 #data = words = 4
	addi $t2, $t2, 1 #i++
	j init_loop	
.data
init_string: .asciiz "Initial array is:\n["
.text
	end_init:
	#printf("Initial array is:\n");
	la $t0, init_string
	move $a0, $t0
	li $v0, 4
	syscall
	
	#print_array(data, size);
	la $a0, data
	lw $a1, size
	jal print_array
	
	#insertSort(data, size);
	la $a0, data
	lw $a1, size
	jal insert_sort
.data
sort_string: .asciiz "Insertion sort is finished!\n["
.text
	#printf("Insertion sort is finished!\n");
	la $t0, sort_string
	move $a0, $t0
	li $v0, 4
	syscall
	
	#print_array(data, size);
	la $a0, data
	lw $a1, size
	jal print_array
	
	#exit(0);
	li $v0, 10
	syscall
	
insert_sort:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)

	#char *a[], size_t length
	move $s0, $a0
	move $s1, $a1
	li $s2, 1 #i
	
	array_loop:
	#for(i = 1; i < length;i++)
	beq $s2, $s1, end_loop
	
	#char *value = a[i];
	la $t0 ($s0)
	li $t1, 4
	mul $t2, $s2, $t1 # 4 * i
	add  $t3, $t0, $t2 # get address from data[i]
	lw $s3, ($t3) #value = array[i]
	
	addi $s4, $s2, -1 #j = i-1
	
	comp_loop:
	#for (j = i-1; j >= 0 && str_lt(value, a[j]); j--)
	addi $t0, $s4, 1 # j + 1 > 0 == j >=0
	beq $t0, $zero, end_comp
	move $a0, $s3
	
	#str_lt(value, a[j]) == true
	la $t0, ($s0)
	li $t1, 4
	mul $t2, $s4, $t1 #4 * j
	add $t3, $t0, $t2 # get address from data[j]
	lw $a1, ($t3) #a[j] as argument
	
	jal str_lt
	move $t0, $v0
	beq $t0, $zero, end_comp #str_lt == true
	addi $t1, $s4, 1
	beq $t1, $zero, end_comp #j >= 0
	
	la $t0, ($s0)
	li $t1, 4
	mul $t2, $s4, $t1 #4 * j
	add $t3, $t0, $t2 # get address from data[j]
	lw $t4, ($t3) # $t4 = a[j] for later
	
	move $t0, $s0
	li $t1, 4
	addi $t2, $s4, 1 #j + 1
	mul $t3, $t2, $t1 # 4 * (j + 1)
	add $t1, $t3, $t0 #get address from data
	sw $t4, ($t1) #a[j+1] = a[j]; a[j] == $t4
		
	addi $s4, $s4, -1 #j--
	j comp_loop #end for(j)
	
	end_comp:
	move $t0, $s0
	li $t1, 4
	addi $t2, $s4, 1 #j + 1
	mul $t4, $t2, $t1 # 4 * (j + 1)
	add $t1, $t4, $t0
	sw $s3, ($t1) #a[j+1] = value;
	
	addi $s2, $s2, 1 #i++
	j array_loop #for(i)
	
	end_loop:
	lw $s4, 20($sp)
	lw $s3, 16($sp)
	lw $s2, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 24
	
	jr $ra

	
print_array:
	addi $sp, $sp -4
	sw $ra, 0($sp)
	
	move $t0, $a0
	move $t1, $a1 #int i=size
	
	print_loop:
	beq $t1, $zero, end_print #while i > 0

	lw $a0, ($t0) #printf( a[i] )
	li $v0, 4
	syscall
	
	addi $t0, $t0, 4
	addi $t1, $t1, -1
.data
chars:	.asciiz ", "
.text
	beq $t1, 0, end_print
	la $t3, chars
	move $a0, $t3
	li $v0, 4
	syscall
	j print_loop
.data
end_string: .asciiz "]\n"
.text
	end_print:
	la $t0, end_string
	move $a0, $t0
	li $v0, 4
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
str_lt:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $t0, $a0 #char * x
	move $t1, $a1 #char * y
	
	word_loop:
	lb $t2, ($t0) #load 
	lb $t3, ($t1)
	
	and $t4, $t2, $t3
	beq $t4, $zero, str_end #for (; *x!='\0' && *y!='\0'; x++, y++)
	blt $t2, $t3, lt #if (x < y)
	bgt $t2, $t3, gt #if (y < x)
	addi $t0, $t0, 1 #x++
	addi $t1, $t1, 1 #y++
	j word_loop
	
	str_end:
	beq $t2, $zero, lt# if x == 0
	j gt #else return false
	
	lt: #return true
	li $v0, 1
	j end_lt
	
	gt: #return false
	li $v0, 0
	j end_lt
	
	end_lt:
	lw $ra, 0($sp)
	addi $sp, $sp 4
	
	jr $ra
.data
#char * data [] = { "list", "of", "names" }
array:
	.align 4
	.asciiz "Joe"
	.align 4
	.asciiz "Jenny"
	.align 4
	.asciiz "Jill"
	.align 4
	.asciiz "John"
	.align 4
	.asciiz "Jeff"
	.align 4
	.asciiz "Joyce"
	.align 4
	.asciiz "Jerry"
	.align 4
	.asciiz "Janice"
	.align 4
	.asciiz "Jake"
	.align 4
	.asciiz "Jonna"
	.align 4
	.asciiz "Jack"
	.align 4
	.asciiz "Jocelyn"
	.align 4
	.asciiz "Jessie"
	.align 4
	.asciiz "Jess"
	.align 4
	.asciiz "Janet"
	.align 4
	.asciiz "Jane"
	.align 4