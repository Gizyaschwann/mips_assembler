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
	mov.d $f0, $f12