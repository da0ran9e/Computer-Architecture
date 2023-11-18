.data
    prompt_array:   .asciiz "Enter the size of the array: "
    prompt_values:  .asciiz "Enter the array elements: "
    prompt_range:   .asciiz "Enter the range (m, M): "
    result_max:     .asciiz "Maximum element: "
    result_count:   .asciiz "Number of elements in the range: "
    newline:        .asciiz "\n"

.text
    # Function to read an integer from input
    read_int:
        li $v0, 5
        syscall
        move $a0, $v0
        jr $ra

    # Function to print an integer
    print_int:
        li $v0, 1
        syscall
        jr $ra

    # Function to print a character
    print_char:
        li $v0, 11
        syscall
        jr $ra

    # Function to print a string
    print_str:
        move $a0, $t0  # Load the address of the string
    print_str_loop:
        lb $a1, 0($a0)  # Load the current character
        beqz $a1, print_str_done  # Exit loop if null terminator
        jal print_char  # Print the current character
        addi $a0, $a0, 1  # Move to the next character
        j print_str_loop  # Repeat the loop
    print_str_done:
        jr $ra

    # Function to find the maximum element in an array
    find_max:
        li $t0, 0           # Index i
        lw $t1, array       # Load the first element as the initial maximum

    max_loop:
        lw $t2, array($t0)  # Load the current element
        bge $t2, $t1, not_max
        move $t1, $t2       # Update maximum
        not_max:
        addi $t0, $t0, 4    # Move to the next element
        bnez $t0, max_loop  # Loop until the end of the array
        jr $ra

    # Function to count elements in the range (m, M)
    count_in_range:
        li $t3, 0           # Initialize count to 0
        li $t4, 0           # Initialize index i

    count_loop:
        lw $t5, array($t4)  # Load the current element
        blt $t5, $a0, not_in_range
        bgt $t5, $a1, not_in_range
        addi $t3, $t3, 1    # Increment count
        not_in_range:
        addi $t4, $t4, 4    # Move to the next element
        bnez $t4, count_loop  # Loop until the end of the array
        jr $ra

    # Main program
    .globl main
main:
    # Prompt for the size of the array
    la $t0, prompt_array
    jal print_str
    jal read_int
    move $t6, $v0        # Store the size of the array

    # Prompt for array elements
    la $t0, prompt_values
    jal print_str
    la $t7, array
    la $t8, array_end
    li $t0, 0            # Index i

read_loop:
    bge $t0, $t6, read_done
    jal read_int         # Read an integer
    sw $v0, 0($t7)       # Store the integer in the array
    addi $t7, $t7, 4     # Move to the next element
    addi $t0, $t0, 1     # Increment index
    j read_loop

read_done:

    # Prompt for the range (m, M)
    la $t0, prompt_range
    jal print_str
    jal read_int
    move $a0, $v0        # Store m
    jal read_int
    move $a1, $v0        # Store M

    # Find the maximum element
    jal find_max
    move $t9, $t1        # Store the maximum element

    # Count elements in the range (m, M)
    la $a0, result_count
    jal print_str
    la $a0, newline
    jal print_str
    move $a0, $t9
    move $a1, $t6
    jal count_in_range
    move $t3, $v0        # Store the count

    # Print the maximum element
    la $a0, result_max
    jal print_str
    move $a0, $t9
    jal print_int

    # Print the count
    la $a0, result_count
    jal print_str
    move $a0, $t3
    jal print_int

    # Exit
    li $v0, 10
    syscall

    .data
    array:      .space 100    # Space for the array
    array_end:  .space 0      # End of the array
