.data
    prompt_size: .asciiz "Enter the size of the array (n): "
    prompt_arr:  .asciiz "Enter element #"
    array:       .space 1000  # Adjust the size as needed

.text
    main:
        # Prompt for array size
        li $v0, 4
        la $a0, prompt_size
        syscall

        # Read array size from user
        li $v0, 5
        syscall
        move $t1, $v0   # $t1 now contains the size of the array

        # Prompt for array elements
        la $t0, array     # Load the base address of the array
        li $t2, 0         # Initialize loop counter

    input_loop:
        beq $t2, $t1, done_input
        li $v0, 4
        la $a0, prompt_arr
        syscall

        # Read array element from user
        li $v0, 5
        syscall
        sw $v0, 0($t0)   # Store the element in the array
        addi $t0, $t0, 4 # Move to the next array element
        addi $t2, $t2, 1 # Increment loop counter
        j input_loop

    done_input:
        # Your further processing logic goes here

        # Exit the program
        li $v0, 10
        syscall
