#Laboratory Exercise 5, Assignment 2
.data
e1: 	.asciiz "Enter the sring: "
e2: 	.asciiz "Copy of the string: "
x: 	.space 1000
y: 	.space 1000
.text
	li 	$v0, 4 
        la 	$a0, e1  
        syscall 
	li 	$v0, 8
	la	$a0, y
	li 	$a1,1000
	syscall
	la	$a1, y
	la 	$a0, x
strcpy:
	add 	$s0,$zero,$zero
L1:
	add 	$t1,$s0,$a1

	lb  	$t2,0($t1) 
	add 	$t3,$s0,$a0 

	sb 	$t2,0($t3) 
	beq 	$t2,$zero,end_of_strcpy
	nop
	addi 	$s0,$s0,1 
	j 	L1 
	nop
end_of_strcpy:
	li 	$v0, 4 
        la 	$a0, e2 
        syscall 
	li 	$v0, 4
    	la 	$a0, x
    	syscall                
    
