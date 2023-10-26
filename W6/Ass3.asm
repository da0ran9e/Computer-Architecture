.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59 ,5
Aend: .word 
.text
main:	
	la 	$a0, A       	
	addi	$a0,$a0,-4
	la 	$a1, Aend
	addi 	$a1, $a1, -4   	
	j	sort            
after_sort:
	li	$v0, 10
	syscall 
end_main:
sort:
	addi 	$a0, $a0, 4	#i++
	beq 	$a0, $a1, after_sort 
	addi 	$a2, $a0, 0	
	j	loop
loop:
	beq	$a2, $a1, sort
	lw	$v0, 0($a0)
	addi	$a2, $a2, 4 
	lw	$v1, 0($a2)
	slt	$t3, $v1, $v0
	bne	$t3, $zero, swap
	j	loop	
swap:   
	lw	$t0,0($a0)
	sw	$t0,0($a2)
	sw	$v1,0($a0)
	j	loop
