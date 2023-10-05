.data
	array: .word 5, 3, 4, 7, 9, 2, 12, 5, 31, 10
.text
	addi $s5, $zero, 0 #initialize sum = 0
	addi $s3, $zero, 10 #size of array n = 10
	addi $s1, $zero, 0 # i = 0
	addi $s2, $zero, 4 # size of each element (word = 4 bytes) 
	la $t1, array #set t1 to the address of array

loop: 
	lw $t0,0($t1) #load value of A[i] into t0
	add $s5,$s5,$t0 #sum=sum+A[i]
	
	addi $s1,$s1,1 #i++	
	add $t1,$t1,$s2 #move the iterator by the size of a element 
	
	bne $s1,$s3,loop 	#while have not reach the end of array
				# i != n, continue the loop
				