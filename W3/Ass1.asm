#Laboratory Exercise 3, Home Assignment 1
start:
	addi $s1, $zero, 4 # i = 4
	addi $s2, $zero, 5 # j = 5
	addi $t1, $zero, 1 # x = 1
	addi $t2, $zero, 2 # y = 2
	addi $t3, $zero, 3 # z = 3

	slt $t0,$s2,$s1 	# if s2 < s1 (j < i) then set t0 = 1 else t0 = 0
	bne $t0,$zero,else 	# if t0 != 0 (j < i) then jump to else  
				# if not, it mean j>=i then do:
	addi $t1,$t1,1 	# x=x+1	
	addi $t3,$zero,1 # z=1
	
	j endif # jump to the end
else: 	
	# if (j < i) jump here
	addi $t2,$t2,-1 # y=y-1
	add $t3,$t3,$t3 # z=2*z
endif: