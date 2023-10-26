#Laboratory Exercise 5, Assignment 3
.data
string: 	.space 50
Message1: 	.asciiz "Nhap xau: ”
Message2: 	.asciiz "Do dai la "
.text
main:
get_string: 
	li 	$v0, 54
    	la 	$a0, Message1
	la	$a1, string
	li 	$a2, 50
	syscall
get_length: 	
	la 	$a0, string
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
print_length:
	sub	$v0,$v0,1
	move	$s2,$v0
	li 	$v0, 56
    	la 	$a0, Message2
    	add 	$a1,$s2,$0
	syscall
