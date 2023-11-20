.data
    prompt:         .asciiz "Enter the number of elements in the array: "
    arrayPrompt:    .asciiz "Enter element "
    maxMessage:     .asciiz "The maximum element is: "
    nearestPrompt:  .asciiz "Enter two numbers to find the nearest indices: "

.text
main:
    # Prompt for the number of elements in the array
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the number of elements
    li $v0, 5
    syscall
    move $t0, $v0 # $t0 = number of elements

    # Check if the array is empty
    beq $t0, $zero, end_program

    # Allocate space for the array on the stack
    addi $sp, $sp, -4
    sw $t0, 0($sp) # Save the number of elements on the stack

    # Dynamically allocate space for the array
    li $v0, 9
    move $a0, $t0
    syscall
    move $t1, $v0 # $t1 = address of the array

    # Initialize variables
    li $t2, 0      # $t2 = current index
    li $t3, -99999 # $t3 = max element, initialize with a small value

    read_loop:
    # Prompt for array element
    li $v0, 4
    la $a0, arrayPrompt
    syscall
    move $a0, $t2
    li $v0, 1
    syscall

    # Read array element
    li $v0, 5
    syscall
    sw $v0, 0($t1) # Store the element in the array

    # Compare with the current max
    bge $v0, $t3, update_max

    # Move to the next index
    j next_iteration

    update_max:
    move $t3, $v0

    next_iteration:
    # Move to the next index
    addi $t2, $t2, 1

    # Check if all elements have been read
    bne $t2, $t0, read_loop

    # Print the maximum element
    li $v0, 4
    la $a0, maxMessage
    syscall
    move $a0, $t3
    li $v0, 1
    syscall

    # Prompt user to enter two additional numbers
    li $v0, 4
    la $a0, nearestPrompt
    syscall

    # Read the first additional number
    li $v0, 5
    syscall
    move $t4, $v0 # $t4 = first additional number

    # Read the second additional number
    li $v0, 5
    syscall
    move $t5, $v0 # $t5 = second additional number

    # Initialize variables for nearest indices
    li $t6, 0      # $t6 = index of the first nearest element
    li $t7, 1      # $t7 = index of the second nearest element
    li $t8, 2147483647  # $t8 = minimum absolute difference for the first nearest element
    li $t9, 2147483647  # $t9 = minimum absolute difference for the second nearest element

    find_nearest_indices:
    # Calculate the absolute difference between the current element and the first additional number
    lw $s0, 0($t1)
    sub $s0, $s0, $t4
    abs $s0, $s0

    # Update the first nearest index if a smaller absolute difference is found
    blt $s0, $t8, update_first_nearest

    # Calculate the absolute difference between the current element and the second additional number
    lw $s1, 0($t1)
    sub $s1, $s1, $t5
    abs $s1, $s1

    # Update the second nearest index if a smaller absolute difference is found
    blt $s1, $t9, update_second_nearest

    next_iteration_nearest:
    # Move to the next index
    addi $t2, $t2, 1

    # Check if all elements have been processed
    bne $t2, $t0, find_nearest_indices

    # Print the indices of the nearest elements
    li $v0, 4
    move $a0, $t6
    syscall

    li $v0, 4
    move $a0, $t7
    syscall

    end_program:
    # Exit the program
    li $v0, 10
    syscall

# Custom subroutine to calculate absolute value
abs:
    bltz $a0, absolute_value_neg
    jr $ra

absolute_value_neg:
    negu $a0, $a0
    jr $ra

update_first_nearest:
    move $t8, $s0
    move $t6, $t2
    j next_iteration_nearest

update_second_nearest:
    move $t9, $s1
    move $t7, $t2
    j next_iteration_nearest
