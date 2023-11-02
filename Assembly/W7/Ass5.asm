.data
    MesOfMax:    .asciiz "The largest value is "
    MesOfMin:    .asciiz "The smallest value is "
    MesMaxIndex: .asciiz "The largest element is stored in $s"
    MesMinIndex: .asciiz "The smallest element is stored in $s"
.text
main:
    # Initialize variables
    li $s0, -1
    li $s1, 3
    li $s2, 1
    li $s3, 8
    li $s4, 3
    li $s5, 4
    li $s6, -5
    li $s7, 6
    jal init
    nop
    # Print max
    li $v0, 56
    la $a0, MesMaxIndex
    add $a1, $t8, $zero
    syscall
    la $a0, MesOfMax
    add $a1, $t0, $zero
    syscall
    # Print min
    la $a0, MesMinIndex
    add $a1, $t9, $zero
    syscall
    la $a0, MesOfMin
    add $a1, $t1, $zero
    syscall
    li $v0, 10 # Exit
    syscall
swapMax:
    # Swap Max
    add $t0, $t3, $zero
    add $t8, $t2, $zero
    jr $ra
swapMin:
    # Swap Min 
    add $t1, $t3, $zero
    add $t9, $t2, $zero
    jr $ra
init:
    # Set up the stack 
    add $fp, $sp, $zero
    addi $sp, $sp, -32
    sw $s1, 0($sp)
    sw $s2, 4($sp)
    sw $s3, 8($sp)
    sw $s4, 12($sp)
    sw $s5, 16($sp)
    sw $s6, 20($sp)
    sw $s7, 24($sp)
    sw $ra, 28($sp)   
    # Initialize Max and Min 
    add $t0, $s0, $zero
    add $t1, $s0, $zero 
    # Initialize indexes of Max and Min
    li $t8, 0
    li $t9, 0   
    li $t2, 0 #current index
max_min: 
    addi $sp, $sp, 4 # move pointer 4 bits
    lw $t3, -4($sp)
    sub $t4, $sp, $fp # Check if we reached the end  or not
    beq $t4, $zero, done
    addi $t2, $t2, 1 # i++
    # Compare
    sub $t4, $t0, $t3
    bltzal $t4, swapMax
    sub $t4, $t3, $t1
    bltzal $t4, swapMin
    j max_min    # Continue
done:
    lw $ra, -4($sp)
    jr $ra
