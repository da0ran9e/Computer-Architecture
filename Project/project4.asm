.data
    arraySize:         	.asciiz "Enter the number of elements in the array: "
    arrayPrompt:    	.asciiz "Enter element "
    colon:		.asciiz ": "
    findPrompt:     	.asciiz "Enter the number to find: "
    maxMessage:     	.asciiz "\nThe maximum element is: "
    mInputMessage:	.asciiz "\nEnter n: "
    MInputMessage:	.asciiz "Enter m: "
    returnMessage1:   	.asciiz "The number of elements between "
    returnMessage2:   	.asciiz " and "
    returnMessage3:   	.asciiz " is: "
    notfoundMessage:  	.asciiz "\n Not found the value: "
    endl:		.asciiz "\n"

.text
main:
#---------------------------------------------------------------------
#@brief: 	Input a n-size-array and find the largest element
#@param[in] 	$t0 	integer	 	number of elements
# 		$t2			current index
# 		$t3			max element
#@return $t3 the largest value
#@note  - User input the size of the array (n) then enter n elements  
#       of the array one by one. 
#       - Use stack to store array elements.
#       - With each input element, the max value will be checked and 
#       updated.
#---------------------------------------------------------------------
    #enter the number of elements
        li $v0, 4
        la $a0, arraySize
        syscall

        li $v0, 5
        syscall
        move $t0, $v0 # $t0 (n) number of elements

        beq $t0, $zero, end_program # Check if the array is 0-size

    # Initialize
        li $t2, 0      # $t2 = current index
        li $t3, -99999 # $t3 = max element, initialize with a small value

    # read array elements
    read_loop:
        li $v0, 4
        la $a0, arrayPrompt 
        syscall
        
        move $a0, $t2
        li $v0, 1
        syscall
        
        li $v0, 4
        la $a0, colon
        syscall

        li $v0, 5 # read the input
        syscall
    
    # push value to the stack
        addi $sp, $sp, -4 # adjust the stack pointer to for 1 word (4 bytes)
        sw $v0, 0($sp) # Save the element on the stack

    # compare with the current max
        bgt $v0, $t3, update_max 

    # move to the next index
        j next_read_iteration

    update_max:
        move $t3, $v0 #update the max value

    next_read_iteration:
        addi $t2, $t2, 1 # index++
        # check if all elements have been read
        bne $t2, $t0, read_loop

    # Print the maximum element
        li $v0, 4
        la $a0, maxMessage
        syscall

        move $a0, $t3 # print max
        li $v0, 1
        syscall

#---------------------------------------------------------------------
#@brief Find the number of elements between 2 values
#	 	$t0 	integer	 	number of elements
#		$t1			current value
# 		$t2			current index
#@param[in] 	$t4 	integer	 	m
#@param[in] 	$t5	integer	 	M
#		$t6 			found m index
#		$t7			number of elements between m and M
#@return $t7 the number of elements between m and M
#@note  - After pushing values to the stack, the stack pointer is at  
#       the top of the stack, move the pointer back to the end of the 
#       stack to read from the begin of the array.
#       - User input 2 integer m and M
#       - The program read the array from beginning to the end to find m
#       if m is found, save the index of m then find M on the rest of
#       the array, if M found then the number of elements between
#       m and M will be calculated by: <index of M> - <index of m> - 1
#       - If any value of m or M is not found then exit the program
#---------------------------------------------------------------------

    #run the pointer to the bottom of the stack
        addi $sp,$sp,-8 

    stack_loop:
        addi $sp,$sp,4 # move the poiter 1 word
        addi $t2, $t2, -1 # index--
        bne $t2, $zero, stack_loop # the index return to 0
    
    #begin input
        li $v0, 4
        la $a0, mInputMessage
        syscall
        
        li $v0, 5
        syscall
        move $t4, $v0 # $t4 = m
        
        li $v0, 4
        la $a0, MInputMessage
        syscall
    
        li $v0, 5
        syscall
        move $t5, $v0 # $t5 = M
    #End of input
    
    #Find for values
    find_m_loop:
        lw $t1,4($sp) #get the stack value to t1
        beq $t1, $t4, found_m
    
        addi $sp,$sp,-4 #adjust the stack pointer

        addi $t2, $t2, 1 # index++
        bne $t2, $t0, find_m_loop # while (index != n): loop

    #if the find loop of m run to here that mean m is not found
    not_found_m: 
        li $v0, 4
        la $a0, notfoundMessage
        syscall
        
        move $a0, $t4
        li $v0, 1
        syscall
        
        li $v0, 4
        la $a0, endl
        syscall
        
        j end_program # exit the program
    
    found_m:
        move $t6, $t2 #save the found index to $t6
        j find_M_loop
    
    #find M
    find_M_loop:
        lw $t1,4($sp) #get the stack value to t1
        beq $t1, $t5, found_M
    
        addi $sp,$sp,-4 #adjust the stack pointer

        addi $t2, $t2, 1 # index++
        bne $t2, $t0, find_M_loop # while (index != n): loop
    
    # if M is not found in the rest of the array
    not_found_M:
        li $v0, 4
        la $a0, notfoundMessage
        syscall
        
        move $a0, $t5
        li $v0, 1
        syscall
        
        li $v0, 4
        la $a0, endl
        syscall
        
        j end_program # exit program
    
    # calculate the number of elements
    found_M:
        sub $t7, $t2, $t6
        sub $t7, $t7, 1
    
    return:
        li $v0, 4
        la $a0, returnMessage1
        syscall
        
        move $a0, $t4
        li $v0, 1
        syscall
        
        li $v0, 4
        la $a0, returnMessage2
        syscall
        S
        move $a0, $t5
        li $v0, 1
        syscall
        
        li $v0, 4
        la $a0, returnMessage3
        syscall
        
        move $a0, $t7
        li $v0, 1
        syscall
        
    end_program:
