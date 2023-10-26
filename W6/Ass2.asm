#Laboratory Exercise 5, Assignment 1
.data
e1: 		.asciiz "Enter the first integer: "
e2: 		.asciiz "Enter the second integer: "
result1: 	.asciiz "The sum of "
result2:	.asciiz " and "
result3:	.asciiz	" is "
.text
main:
        li 	$v0, 4 
        la 	$a0, e1  
        syscall 
        
        li	$v0, 5 
        syscall
        move 	$s0, $v0 

    	li 	$v0, 4
    	la 	$a0, e2
    	syscall

    	li 	$v0, 5        
    	syscall
    	move 	$s1,$v0

    	li 	$v0, 4
    	la 	$a0, result1
    	syscall
    	
    	li 	$v0, 1
    	move	$a0,$s0
	syscall
    	
    	li 	$v0, 4
    	la 	$a0, result2
    	syscall
    	
    	li 	$v0, 1
	move	$a0,$s1
	syscall
    	
    	li 	$v0, 4
    	la 	$a0, result3
    	syscall

    	add 	$a0, $s0, $s1
    	li 	$v0, 1
    	syscall
