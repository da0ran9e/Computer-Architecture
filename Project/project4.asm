.data
    prompt:     .asciiz "Enter the number of elements in the array: "
    arrayPrompt: .asciiz "Enter element "
    maxMessage:  .asciiz "The maximum element is: "
    prompt1:        .asciiz "Enter the first number: "
    prompt2:        .asciiz "Enter the second number: "
    distanceMessage: .asciiz "The distance between the two numbers is: "

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
    
    # Prompt for the number of elements in the array
    li $v0, 4
    la $a0, prompt1
    syscall

    # Read the first number
    li $v0, 5
    syscall
    move $t4, $v0 # $t4 = first number

    # Prompt for the second number
    li $v0, 4
    la $a0, prompt2
    syscall

    # Read the second number
    li $v0, 5
    syscall
    move $t5, $v0 # $t5 = second number

    # Calculate the distance between the two numbers
    sub $t6, $t5, $t4 # $t6 = distance

    # Print the distance
    li $v0, 4
    la $a0, distanceMessage
    syscall
    move $a0, $t6
    li $v0, 1
    syscall

    # Exit the program
    li $v0, 10
    syscall

    end_program:
    # Exit the program
    li $v0, 10
    syscall
