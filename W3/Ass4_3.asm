start:
	addi $s1, $zero, 3 # i 
	addi $s2, $zero, 3 # j 
	addi $t1, $zero, 5 # x 
	addi $t2, $zero, 4 # y 
	addi $t3, $zero, 10 # z 

    add $s3, $s1, $s2 # z = i +j

    slt $t0,$zero,$s3 # check if 0 < i+j
    beq $t0,1,else # branch to else if 0 < i+j
    addi $t1,$t1,1 # then part: x=x+1
    addi $t3,$zero,1 # z=1j endif # skip “else” part
else:
    addi $t2,$t2,-1 # begin else part: y=y-1
    add $t3,$t3,$t3 # z=2*z
endif:
