.data
    text1:   .asciiz "Enter the first number: "
    text2:   .asciiz "Enter the second number: "
    result:    .asciiz "The sum is: "

.text
main:
    li $v0, 51 #print dialog 1
    la $a0, text1 #print text
    syscall 

    add $t0, $zero, $a0  

    li $v0, 51
    la $a0, text2
    syscall

    add $t1, $zero, $a0  

    add $t2, $t0, $t1

    li $v0, 56
    la $a0, result
    move $a0, $t2
    syscall

    li $v0, 10
    syscall
