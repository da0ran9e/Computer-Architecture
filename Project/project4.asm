.data
    prompt:      .asciiz "Enter the size of the array: "
    promptArray: .asciiz "Enter element "
    promptMin:   .asciiz "Enter the minimum value of the range: "
    promptMax:   .asciiz "Enter the maximum value of the range: "
    resultMax:   .asciiz "Maximum element in the array: "
    resultRange: .asciiz "Number of elements in the specified range: "
    
    array:       .space 100   # Adjust the size as needed

.text
main:
    # Prompt for the size of the array
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read the size of the array
    li $v0, 5
    syscall
    move $t0, $v0  # $t0 contains the size of the array
    
    # Prompt for array elements
    li $t1, 0  # Index of the array
    la $t2, array
    
read_loop:
    beq $t1, $t0, find_max  # If all elements are read, go to find_max
    
    # Prompt for the current array element
    li $v0, 4
    la $a0, promptArray
    syscall
    
    # Read the current array element
    li $v0, 5
    syscall
    sw $v0, 0($t2)  # Store the element in the array
    addi $t1, $t1, 1  # Increment the array index
    addi $t2, $t2, 4  # Move to the next array element
    j read_loop

find_max:
    # Find the maximum element in the array
    la $t2, array
    lw $t3, 0($t2)  # Load the first element as the initial max
    
    li $t1, 1  # Start from the second element
    find_max_loop:
        beq $t1, $t0, find_range  # If all elements are checked, go to find_range
        
        lw $t4, 0($t2)
        bge $t4, $t3, max_not_updated  # If the current element is not greater than max, skip updating max
        move $t3, $t4  # Update max
        max_not_updated:
        
        addi $t1, $t1, 1  # Increment the array index
        addi $t2, $t2, 4  # Move to the next array element
        j find_max_loop
    
    find_range:
    # Prompt for the minimum value of the range
    li $v0, 4
    la $a0, promptMin
    syscall
    
    # Read the minimum value of the range
    li $v0, 5
    syscall
    move $t5, $v0
    
    # Prompt for the maximum value of the range
    li $v0, 4
    la $a0, promptMax
    syscall
    
    # Read the maximum value of the range
    li $v0, 5
    syscall
    move $t6, $v0
    
    # Calculate the number of elements in the specified range
    la $t2, array
    li $t1, 0  # Counter for elements in range
    find_range_loop:
        beq $t1, $t0, print_results  # If all elements are checked, go to print_results
        
        lw $t4, 0($t2)
        blt $t4, $t5, range_not_included  # If the current element is less than the minimum, skip
        bgt $t4, $t6, range_not_included  # If the current element is greater than the maximum, skip
        
        addi $t1, $t1, 1  # Increment the counter
        range_not_included:
        
        addi $t2, $t2, 4  # Move to the next array element
        j find_range_loop
    
    print_results:
    # Print the maximum element in the array
    li $v0, 4
    la $a0, resultMax
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    # Print the number of elements in the specified range
    li $v0, 4
    la $a0, resultRange
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    # Exit the program
    li $v0, 10
    syscall
