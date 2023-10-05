# sum = 0;
# for (int i=0; i<n; i++){
#     sum += a[i];
# }
.data
    A .word 10, 2, 3, 5, 6, 8
.text
    #s5 = sum
    #s1 = i
    #s3 = n = 0

    addi $s5, $zero, 0

    li $s1, 0 #i = 0
    li $s3, 8
LOOP:
    slt $t2, $s1, $s3
    beq $t2, 0, STOP

    la $t9, A 
    add $t1, $s1, $s1
    add $t1, $t1, $t1 # t1 = 4*i

    lw $t0, 0($t1), 
    add $s5, $s5, $t0

    addi $s1, $s1, 1
    j LOOP

STOP: