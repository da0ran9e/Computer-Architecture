#
.text
    #s0 = a
    #s1 = b
    #s2 = maximum

    slt $t0, $s0, $s1
    je $t0, 0, ELSE

    addi $s2, $s1, 0
    j CONTINUE

ELSE:
    addi $s2, $s0, 0

CONTINUE: