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
#	 	$t0 	integer	 	number of elements
# 		$t2			current index
#param[in] 	$t4 	integer	 	n
#param[in] 	$t5	integer	 	m
#		$t6 			current value
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
    
    print_loop:
    lw $a0,4($sp) #pop the stack value to t6
    addi $sp,$sp,-4 #adjust the stack pointer
    li $v0, 1
    syscall
    
    print_iteration:
    addi $t2, $t2, 1
    bne $t2, $t0, print_loop
    
    #begin input
    li $v0, 4
    la $a0, nInputMessage
    syscall
    
    # Read n
    li $v0, 5
    syscall
    move $t4, $v0 # $t4 = n
    
    li $v0, 4
    la $a0, nInputMessage
    syscall
    
    # Read m
    li $v0, 5
    syscall
    move $t5, $v0 # $t5 = m
    
    #End of input
    
    addi $sp,$sp,-4
    pop_loop:
    lw $t6,4($sp) #pop the stack value to t6
    addi $sp,$sp,4 #adjust the stack pointer
    
    beq $t6, $t4, check	
    
    addi $t7, $t7, 1
    #if the value = m reset counter to 0
    beq $t6, $t5, reset
    
    next_pop_iteration:
    # Move to the next index
    addi $t2, $t2, -1
    # Check if all elements have been pop
    bne $t2, $zero, pop_loop
    
    beq $t7, $t0, not_found_m
    
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
    
    check:
    j return
    
    reset:
    li $t7, 0
    j pop_loop
    
    return:
    li $v0, 4
    la $a0, returnMessage1
    syscall
    
    li $v0, 4
    move $a1, $t7
    syscall
    
    end_program:
