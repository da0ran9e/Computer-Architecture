.data
A: 	.word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend: 	.word
.text
main: 	
	la	$a0,A
	la 	$t0,Aend
	addi	$a0,$a0,-4
	addi	$t1,$t0,-4
loop1:	
	addi	$a1,$a0,4
	addi 	$a0,$a0,4
	beq	$a0,$t0,end
	nop
loop2:
	lw	$s0,0($a0)
	lw	$s1,0($a1)
	bgt	$s0,$s1,sort
	j 	next
	nop
sort:
	sw	$s1,0($a0)
	sw	$s0,0($a1)
	j 	next
	nop
next:
	beq	$a1,$t1,loop1
	addi	$a1,$a1,4
	j 	loop2
	nop
end:
	
