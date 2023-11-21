.data
    prompt:     .asciiz "Enter the size of the array: "
    arrayPrompt: .asciiz "Enter element "
    rangePrompt: .asciiz "Enter the lower and upper bounds of the range (m M): "
    resultMsg:  .asciiz "Maximum element: "
    countMsg:   .asciiz "Number of elements in the specified range: "

.text
    # Main program
    main:
        li      $v0, 4                   # Print prompt for array size
        la      $a0, prompt
        syscall

        li      $v0, 5                   # Read array size from the user
        syscall
        move    $t0, $v0                 # $t0 = array size

        # Dynamically allocate space for the array on the stack
        sub     $sp, $sp, 4*$t0

        # Read array elements from the user
        la      $t1, 0($sp)               # $t1 points to the base of the array
        la      $a0, arrayPrompt
        move    $a1, $t0                 # Number of elements to read
        jal     readArray

        # Read range (m, M) from the user
        li      $v0, 4
        la      $a0, rangePrompt
        syscall

        li      $v0, 5
        syscall
        move    $t2, $v0                 # $t2 = lower bound (m)
        
        li      $v0, 5
        syscall
        move    $t3, $v0                 # $t3 = upper bound (M)

        # Find the maximum element in the array
        la      $a0, 0($sp)               # $a0 points to the base of the array
        move    $a1, $t0                 # Number of elements in the array
        jal     findMax

        # Print the maximum element
        li      $v0, 4
        la      $a0, resultMsg
        syscall

        li      $v0, 1
        move    $a0, $t4                 # Maximum element
        syscall

        # Calculate the number of elements in the range (m, M)
        la      $a0, 0($sp)               # $a0 points to the base of the array
        move    $a1, $t0                 # Number of elements in the array
        move    $a2, $t2                 # Lower bound (m)
        move    $a3, $t3                 # Upper bound (M)
        jal     countInRange

        # Print the count of elements in the range
        li      $v0, 4
        la      $a0, countMsg
        syscall

        li      $v0, 1
        move    $a0, $t5                 # Count of elements in the range
        syscall

        # Exit program
        li      $v0, 10
        syscall

    # Procedure to read an array from the user
    readArray:
        move    $t4, $a0                 # $t4 points to the base of the array
    readLoop:
        li      $v0, 4                   # Print prompt for array element
        la      $a0, arrayPrompt
        syscall

        li      $v0, 5                   # Read an element from the user
        syscall
        sw      $v0, 0($t4)               # Store the element in the array
        addi    $t4, $t4, 4              # Move to the next element

        addi    $a1, $a1, -1             # Decrement the number of elements
        bnez    $a1, readLoop            # Continue loop if more elements to read
        jr      $ra

    # Procedure to find the maximum element in the array
    findMax:
        move    $t4, $a0                 # $t4 points to the base of the array
        move    $t5, $t4                 # $t5 points to the current maximum

        li      $t6, 0                   # Initialize max index to 0
        li      $t7, 0                   # Initialize max value to 0

    maxLoop:
        lw      $t8, 0($t4)               # Load the current element
        ble     $t8, $t7, notGreater     # Skip if not greater than current max

        # Update the maximum element and index
        move    $t5, $t4                 # Update the pointer to current max
        move    $t7, $t8                 # Update the max value
        move    $t6, $t4                 # Update the max index

    notGreater:
        addi    $t4, $t4, 4              # Move to the next element
        addi    $a1, $a1, -1             # Decrement the number of elements
        bnez    $a1, maxLoop             # Continue loop if more elements to check

        # Store the maximum element, value, and index in $t4, $t5, $t6 respectively
        sw      $t5, 0($t0)               # Store the pointer to the max element
        sw      $t7, 4($t0)               # Store the max value
        sw      $t6, 8($t0)               # Store the max index
        jr      $ra

    # Procedure to count the number of elements in the range (m, M)
    countInRange:
        move    $t4, $a0                 # $t4 points to the base of the array
        move    $t5, $a2                 # $t5 = lower bound (m)
        move    $t6, $a3                 # $t6 = upper bound (M)
        li      $t7, 0                   # Initialize count to 0

    countLoop:
        lw      $t8, 0($t4)               # Load the current element
        blt     $t8, $t5, notInRange     # Skip if less than lower bound
        bgt     $t8, $t6, notInRange     # Skip if greater than upper bound

        # Increment the count if the element is in the range
        addi    $t7, $t7, 1

    notInRange:
        addi    $t4, $t4, 4              # Move to the next element
        addi    $a1, $a1, -1             # Decrement the number of elements
        bnez    $a1, countLoop           # Continue loop if more elements to check

        # Store the count in $t5
        move    $t5, $t7
        jr      $ra
