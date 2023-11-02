.data
    MesOfMax:    .asciiz "The largest value is "
    MesOfMin:    .asciiz "The smallest value is "
    MesMaxIndex: .asciiz "The largest element is stored in $s"
    MesMinIndex: .asciiz "The smallest element is stored in $s"

.text
main:
    # Initialize variables for values and indices
    li $s0, -1
    li $s1, 3
    li $s2, 1
    li $s3, 8
    li $s4, 3
    li $s5, 4
    li $s6, -5
    li $s7, 6

    # Call the initialization function
    jal init
    nop

    # Print the result for the maximum value and its index
    li $v0, 56
    la $a0, MesMaxIndex
    add $a1, $t8, $zero
    syscall
    la $a0, MesOfMax
    add $a1, $t0, $zero
    syscall

    # Print the result for the minimum value and its index
    la $a0, MesMinIndex
    add $a1, $t9, $zero
    syscall
    la $a0, MesOfMin
    add $a1, $t1, $zero
    syscall

    # Exit the program
    li $v0, 10
    syscall

swapMax:
    # Swap Max and its index
    add $t0, $t3, $zero
    add $t8, $t2, $zero
    jr $ra

swapMin:
    # Swap Min and its index
    add $t1, $t3, $zero
    add $t9, $t2, $zero
    jr $ra

init:
    # Set up the stack frame and initialize variables
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
    
    # Initialize Max and Min to the lowest possible value
    add $t0, $s0, $zero
    add $t1, $s0, $zero
    
    # Initialize indices for Max and Min
    li $t8, 0
    li $t9, 0
    
    # Initialize the current index
    li $t2, 0

max_min:
    # Increase the stack pointer
    addi $sp, $sp, 4
    
    # Load the current array element
    lw $t3, -4($sp)
    
    # Check if we've reached the end (based on the stack frame)
    sub $t4, $sp, $fp
    beq $t4, $zero, done
    
    # Increment the current index
    addi $t2, $t2, 1
    
    # Compare the current element with Max and Min
    sub $t4, $t0, $t3
    bltzal $t4, swapMax
    sub $t4, $t3, $t1
    bltzal $t4, swapMin
    
    # Continue with the next element
    j max_min

done:
    # Restore the return address
    lw $ra, -4($sp)
    
    # Return to the calling program
    jr $ra
