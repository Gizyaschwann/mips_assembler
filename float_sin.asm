.data
	one_d: .double 1.0
	two_d: .double 2.0
	neg_one_d: .double -1.0
	pi: .double 3.14159
	four_d: .double 4.0
.text
main:
	l.d $f12, pi
	l.d $f0, four_d
	div.d $f12, $f12, $f0
	
	jal sin
	
	mov.d $f12, $f0
	li $v0, 3
	syscall
	
	li $v0, 10
	syscall
sin:
	#f12 - result, x
	l.d $f1, one_d #fact
	l.d $f2, neg_one_d #sign
	
	li $a0, 1
	li $a1, 10
	mul.d $f3, $f12, $f12 #x2
	
	bge $a0, $a1 exit #for(int i = 1; i < 10; i++)
	mul.d $f12, $f12, $f1 #x*=x2
	
	#(2*i) * (2*i+1)
  	
	move $t0, $a0 # $t0 = i
	li $t4, 2
	mult $t0, $t4 # $t0 = 2 * i
	mflo $t0 #move result of mult to $t0
	
	move $t1, $t0 # $t1 = $t0 = 2*i
	addi $t1, $t1, 1 # t1 = 2*i+1
	mult $t0, $t1 # $t0 = t0 * t1
	mflo $t0 #move result of mult to $t0
	
	mtc1.d $t0, $f13 #convert int to double
  	cvt.d.w $f13, $f13 #f13 = $t0 now
  	
	mul.d $f1, $f1, $f13 #fact*= $f13
	
	# sign = - sign
	li $f5, -1.0
	mul.d $f2, $f2, $f5
	
	mul.d $t2, $f2, $f12 #sign * x
	div.d $t2, $t2, $f1 #(sign * x) / fact
	add.d $f12, $f12, $t2 #result +=sign * x / fact
	j loop
exit:
	jr $ra
	
	
