# switch(test){
# 	case 0:
# 		a=a+1;
# 		break;
# 	case 1:
# 		a=a-1;
# 		break;
# 	case 2:
# 		b=2*b;
# 		break;
# 	default:
# }

.test
	#s1 = test
	#s2 = a
	
	beq $s1, 0, CASE0
	beq $s1, 1, CASE1
	beq $s2, 2, CASE2
	j CONTINUE
	
CASE0:
	addi $s2, $s2, 1
	j CONTINUE
CASE1:
	addi $s2, $s2, -1 
	j CONTINUE
CASE2:
	add $s3, $s3, $s3 #b = 2*b

CONTINUE: