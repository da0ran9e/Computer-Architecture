.data
    prompt:         	.asciiz "Enter the number of elements in the array: "
    arrayPrompt:    	.asciiz "Enter element "
    findPrompt:     	.asciiz "Enter the number to find: "
    maxMessage:     	.asciiz "The maximum element is: "
    indexMessage:   	.asciiz "The first index of the number is: "
    endl:		.asciiz "\n"

.text
main:
    # the number of elements
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the number of elements
    li $v0, 5
    syscall
    move $t0, $v0 # $t0 = number of elements

    # Check if the array is 0-size
    beq $t0, $zero, end_program

    # Dynamically allocate space for the array
    li $v0, 9
    move $a0, $t0
    syscall
    move $t1, $v0 # $t1 = address of the array

    # Initialize variables
    li $t2, 0      # $t2 = current index
    li $t3, -99999 # $t3 = max element, initialize with a small value

    # Read array elements
    read_loop:
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
    
    # Allocate space for the array on the stack
    push:
    addi $sp, $sp, -4
    sw $v0, 0($sp) # Save the element on the stack

    # Compare with the current max
    bge $v0, $t3, update_max

    # Move to the next index
    j next_read_iteration
#---------------------------------------------------------------------
#Procedure max: find the largest integer
#param[in] 	$t0 	integer	 	number of elements
#		$t1 			address of the array
# 		$t2			current index
# 		$t3			max element
#param[in] 
#return $t3 the largest value
#---------------------------------------------------------------------

    update_max:
    move $t3, $v0

    next_read_iteration:
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

#---------------------------------------------------------------------
#Procedure distance: find the number of elements between 2 values
#param[in] 	$t0 	integer	 	number of elements
#		$t1 			address of the array
# 		$t2			current index
# 		$t3			max element
#param[in] 
#return $t3 the largest value
#---------------------------------------------------------------------


	addi $sp,$sp,-4
    pop_loop:
    li $v0, 4
    la $a0, endl
    syscall

    lw $a0,4($sp) #pop from stack to $s1
    addi $sp,$sp,4 #adjust the stack pointer	
    li $v0, 1
    syscall
    
    next_pop_iteration:
    # Move to the next index
    addi $t2, $t2, -1

    # Check if all elements have been read
    bne $t2, $zero, pop_loop
    
    
    li $v0, 4
    la $a0, findPrompt
    syscall

    # Read the number to find
    li $v0, 5
    syscall
    move $t4, $v0 # $t4 = number to find

    # Search for the first index of the number in the array
    li $t2, 0       # Reset the index
    li $t5, -1      # Initialize the index of the number to find
    find_loop:
    lw $t6, 0($t1)  # Load the current element from the array

    # Compare with the number to find
    bne $t6, $t4, not_found

    # Store the index if it's the first occurrence
    beq $t5, -1, store_index

    not_found:
    # Move to the next index
    addi $t2, $t2, 1

    # Check if all elements have been searched
    bne $t2, $t0, find_loop

    # Print the index of the number to find
    li $v0, 4
    la $a0, indexMessage
    syscall
    move $a0, $t5
    li $v0, 1
    syscall

    end_program:
    # Exit the program
    li $v0, 10
    syscall

    store_index:
    # Store the current index as the first occurrence
    move $t5, $t2
    j not_found
