.data
    prompt:         .asciiz "Enter the number of elements in the array: "
    arrayPrompt:    .asciiz "Enter element "
    maxMessage:     .asciiz "The maximum element is: "
    searchPrompt1:  .asciiz "Enter the first number to search: "
    searchPrompt2:  .asciiz "Enter the second number to search: "
    indexMessage1:  .asciiz "The first number is found at index: "
    indexMessage2:  .asciiz "The second number is found at index: "
    notFoundMessage: .asciiz "Number not found in the array."

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

    # Read elements into the array
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
    input1:
    li $v0, 4
    la $a0, searchPrompt1
    syscall
    li $v0, 5
    syscall
    move $t4, $v0 # $t4 = first number to search

    # Find the first index of the first number
    move $t6, $t1 # $t6 = address of the array
    li $t7, 0     # $t7 = current index

    search_loop1:
    lw $t8, 0($t6) # Load the current element from the array
    beq $t8, $t4, found_first
    addi $t6, $t6, 4 # Move to the next element in the array
    addi $t7, $t7, 1 # Increment the current index
    bne $t7, $t0, search_loop1
    j not_found1

    found_first:
    # Print the index of the first number
    li $v0, 4
    la $a0, indexMessage1
    syscall
    move $a0, $t7
    li $v0, 1
    syscall
    
    # Find the first index of the second number
    
    move $t6, $t1 # Reset the address of the array
    
    input2:
    li $v0, 4
    la $a0, searchPrompt2
    syscall
    li $v0, 5
    syscall
    move $t5, $v0 # $t5 = second number to search

    search_loop2:
    lw $t8, 0($t6) # Load the current element from the array
    beq $t8, $t5, found_second
    addi $t6, $t6, 4 # Move to the next element in the array
    addi $t9, $t9, 1 # Increment the current index
    bne $t9, $t0, search_loop2
    j not_found2

    found_second:
    # Print the index of the second number
    li $v0, 4
    la $a0, indexMessage2
    syscall
    move $a0, $t9
    li $v0, 1
    syscall
    
    end_program:
    # Exit the program
    li $v0, 10
    syscall

    not_found1:
    li $v0, 4
    la $a0, notFoundMessage
    syscall
    j input1
    
    not_found2:
    li $v0, 4
    la $a0, notFoundMessage
    syscall
    j input2