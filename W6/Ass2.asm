.data
A: .word 8, -22, 15, 11, -5, 6, 37, 13, -16, 8, 9, 25, 91
A_end: .word 0
.text
main:	
	la 	$a0, A       	
	la 	$a1, A_end
	addi 	$a1, $a1, -4   	
	j	sort            
after_sort:
	li	$v0, 10		
	syscall
end_main:
sort:
       	beq	$a0, $a1, done	#finish
       	j	max		
after_max:  
       	lw	$t0, 0($a1) 	
       	sw	$t0, 0($v0) 	
       	sw	$v1, 0($a1) 	
       	addi	$a1, $a1, -4 	
       	j	sort		
done:       
	j	after_sort

max:
	addi	$v0, $a0, 0     
	lw	$v1, 0($v0)     
	addi	$t0, $a0, 0     
loop:
	beq	$t0, $a1, ret   
	addi	$t0, $t0, 4    	
	lw	$t1, 0($t0)     
	slt	$t2, $t1, $v1   
	bne	$t2,$zero,loop	
	addi	$v0, $t0, 0	
	addi	$v1, $t1, 0	
	j	loop		
ret:
	j	after_max
