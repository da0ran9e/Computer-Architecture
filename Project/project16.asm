.data
    arraySize:         	.asciiz "Enter the number of elements in the array: "
    arrayPrompt:    	.asciiz "Enter element "
    colon:		        .asciiz ": "
    findPrompt:     	.asciiz "Enter the number to find: "
    maxMessage:     	.asciiz "\nThe maximum element is: "
    mInputMessage:	    .asciiz "\nEnter n: "
    MInputMessage:	    .asciiz "Enter m: "
    returnMessage1:   	.asciiz "The number of elements between "
    returnMessage2:   	.asciiz " and "
    returnMessage3:   	.asciiz " is: "
    notfoundMessage:  	.asciiz "\n Not found the value: "
    endl:		        .asciiz "\n"

.text
main:
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
        bge $v0, $t3, update_max 

    # move to the next index
        j next_read_iteration

    update_max:
        move $t3, $v0 #update the max value

    next_read_iteration:
        addi $t2, $t2, 1 # index++
        # check if all elements have been read
        bne $t2, $t0, read_loop

    ##########################################################
    return_to_begin:
        addi $sp,$sp,-4
    return_loop:
        addi $sp,$sp,4 # move the poiter 1 word
        addi $t2, $t2, -1 # index--
        bne $t2, $zero, stack_loop # the index return to 0

    check_loop:

