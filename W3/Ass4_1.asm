
start:
	addi $s1, $zero, 3 # i 
	addi $s2, $zero, 3 # j 
	addi $t1, $zero, 5 # x 
	addi $t2, $zero, 4 # y 
	addi $t3, $zero, 10 # z 

	slt $t0,$s1,$s2 	# if s1 < s2 (i < j) then set t0 = 1 else t0 = 0
	beq $t0,$zero,else 	# if t0 == 0 (j < i) then jump to else  
				# if not, it mean j>=i then do:
	addi $t1,$t1,1 # then part: x=x+1
	addi $t3,$zero,1 # z=1
	
	j endif # jump to the end
else: 	
	# if (j < i) jump here
	addi $t2,$t2,-1 # y=y-1
	add $t3,$t3,$t3 # z=2*z
endif: