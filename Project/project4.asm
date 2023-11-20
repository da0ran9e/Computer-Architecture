.data
    prompt:         .asciiz "Enter the number of elements in the array: "
    arrayPrompt:    .asciiz "Enter element "
    rangePrompt:    .asciiz "Enter the lower and upper bounds: "
    countMessage:   .asciiz "The number of elements between the given range is: "
    invalidRange:   .asciiz "Invalid range! Please enter valid lower and upper bounds."

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

    # Prompt for lower and upper bounds
    li $v0, 4
    la $a0, rangePrompt
    syscall

    # Read lower bound
    li $v0, 5
    syscall
    move $t4, $v0

    # Read upper bound
    li $v0, 5
    syscall
    move $t5, $v0

    # Check if the range is valid
    bge $t5, $t4, valid_range
    li $v0, 4
    la $a0, invalidRange
    syscall
    j end_program

    valid_range:
    # Initialize the count of elements in the given range
    li $t6, 0

    # Iterate through the array to count elements within the range
    li $t2, 0 # Reset index to 0
    count_loop:
    lw $t7, 0($t1) # Load element from the array
    bge $t7, $t4, check_upper_bound
    j next_count_iteration

    check_upper_bound:
    ble $t7, $t5, increment_count
    j next_count_iteration

    increment_count:
    addi $t6, $t6, 1

    next_count_iteration:
    addi $t2, $t2, 1
    blt $t2, $t0, count_loop

    # Print the count of elements in the given range
    li $v0, 4
    la $a0, countMessage
    syscall
    move $a0, $t6
    li $v0, 1
    syscall

    end_program:
    # Exit the program
    li $v0, 10
    syscall
