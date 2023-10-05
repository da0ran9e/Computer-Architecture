# if (i <= j)
#   x=x+1;
#   z=1;
#else 
#   y=y-1;
#   z=2*z

.text
    #s0 = i
    #s1 = j
    #t1 = x
    #t2 = y
    #t3 = z

    slt $t0, $s2, $s1 #select less than
    je $t0, 0, ELSE

    addi $t1, $t1, 1 #x = x+1
    addi $t3, $zero, 1 #z=1
    j CONTINUE

ELSE:
    addi $t2, $t0, -1
    add $t3, $t3, $t3 #z = 2*z

CONTINUE: