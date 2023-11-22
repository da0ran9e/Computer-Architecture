.data
    prompt:         	.asciiz "Enter the number of elements in the array: "
    arrayPrompt:    	.asciiz "Enter element "
    findPrompt:     	.asciiz "Enter the number to find: "
    maxMessage:     	.asciiz "\nThe maximum element is: "
    nInputMessage:	.asciiz "\nEnter n: "
    mInputMessage:	.asciiz "\nEnter m: "
    returnMessage1:   	.asciiz "\nThe number of elements between "
    returnMessage2:   	.asciiz " and "
    returnMessage3:   	.asciiz " is: "
    notfoundMessage:  	.asciiz "\n Not found the value: "
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
#	 	$t0 	integer	 	number of elements
#		$t1			current value
# 		$t2			current index
#param[in] 	$t4 	integer	 	n
#param[in] 	$t5	integer	 	m
#		$t6 			found n index
#		$t7			number of elements between n and m
#param[in] 
#return $t7 the number of elements between n and m
#---------------------------------------------------------------------

    #run to the bottom of the stack
    addi $sp,$sp,-8
    stack_loop:
    addi $sp,$sp,4 #adjust the stack 
    stack_pointer_iteration:
    addi $t2, $t2, -1
    bne $t2, $zero, stack_loop
    
    #print 
    li $v0, 4
    la $a0, endl
    syscall
    
    #begin input
    li $v0, 4
    la $a0, nInputMessage
    syscall
    
    li $v0, 5
    syscall
    move $t4, $v0 # $t4 = n
    
    li $v0, 4
    la $a0, mInputMessage
    syscall
    
    li $v0, 5
    syscall
    move $t5, $v0 # $t5 = m
    
    #End of input
    
    #Find for values
    
    #find_n
    find_n_loop:
    lw $t1,4($sp) #pop the stack value to t1
    beq $t1, $t4, found_n
    
    addi $sp,$sp,-4 #adjust the stack pointer
    li $v0, 1
    syscall

    addi $t2, $t2, 1
    bne $t2, $t0, find_n_loop
    
    not_found_n:
    li $v0, 4
    la $a0, notfoundMessage
    syscall
    
    li $v0, 1
    move $a1, $t4
    syscall
    
    li $v0, 4
    la $a0, endl
    syscall
    
    j end_program
    
    found_n:
    move $t6, $t2 #save the found index to $t6
    j find_m_loop
    
    #find m
    find_m_loop:
    lw $t1,4($sp) #pop the stack value to t1
    beq $t1, $t5, found_m
    
    addi $sp,$sp,-4 #adjust the stack pointer
    li $v0, 1
    syscall

    addi $t2, $t2, 1
    bne $t2, $t0, find_m_loop
    
    not_found_m:
    li $v0, 4
    la $a0, notfoundMessage
    syscall
    
    li $v0, 1
    move $a1, $t5
    syscall
    
    li $v0, 4
    la $a0, endl
    syscall
    
    j end_program
    
    found_m:
    sub $t7, $t2, $t6
    
    return:
    li $v0, 4
    la $a0, returnMessage1
    syscall
    
    li $v0, 1
    move $a1, $t7
    syscall
    
    end_program:
