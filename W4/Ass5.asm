.data 

    s1:.word 2   #s1 là số bị nhân
    s2:.word 16  #s2 là số lũy thừa của 2
    s3:.word 1   #s3 đếm số vòng lặp
.text

start:

       lw $s1,s1
       lw $s2,s2
       lw $s3,s3
LOOP:
       beq $s3, $s2, EXIT
       add $s3,$s3,$s3
       add $s1,$s1,$s1
       j LOOP
EXIT:
