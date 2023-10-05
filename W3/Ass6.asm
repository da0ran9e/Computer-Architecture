.data
	array: .word 5, 3, 4, 7, 9, 2, 12, 5, 31, 10
.text
	addi $s1, $zero, 0 #i = 0
	
	la $s2, array #load the address of the array to s2
	
	addi $s3, $zero, 10 #size of the array
	addi $s5, $zero, 0 # max = 0
	
loop:
	add $t1, $s1, $s1
	add $t1, $t1, $t1
	add $t1, $t1, $s2
	
	lw $t0, 0($t1)
	
	bgt $s5, $t0, else # if max > A[i] jump to else
	
	add $s5, $zero, $t0
	
else: 
	add $s1, $s1, 1
	blt $s1, $s3, loop # if i have not reach the end of the array
				#then continue the loop