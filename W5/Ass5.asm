#Laboratory Exercise 5, Assignment 2
.data
e1: 	.asciiz "Enter the string: "
e2: 	.asciiz "\nThe reverse string: "
x: 	.space 21
y: 	.space 21
.text	
	li 	$v0, 4 
        la 	$a0, e1  
        syscall 
	li 	$v0, 8
	la	$a0, y
	li 	$a1,21
	syscall

get_length: 	
	la 	$a0, y
	xor 	$v0, $zero, $zero 
	xor 	$t0, $zero, $zero
check_char: 	
	add 	$t1, $a0, $t0 
	lb 	$t2, 0($t1)
	beq 	$t2,$zero,end_of_str 
	addi 	$v0, $v0, 1 
	addi 	$t0, $t0, 1 
	j 	check_char
end_of_str:
end_of_get_length:
	sub 	$v0,$v0,1
	move	$s2,$v0
	la	$a1, y
	la 	$a0, x
strrv:
	add 	$s0,$zero,$0
L1:
	add 	$t1,$0,$a1
	add	$t1,$t1,$s2
	lb  	$t2,0($t1) 
	add 	$t3,$s0,$a0 
	sb 	$t2,0($t3) 
	beq 	$s2,$zero,end_of_strrv
	nop
	addi 	$s0,$s0,1 
	subi	$s2,$s2,1
	j 	L1 	
end_of_strrv:
	li 	$v0, 4 
        la 	$a0, e2
        syscall 
	li 	$v0, 4
    	la 	$a0, x
    	syscall                
    