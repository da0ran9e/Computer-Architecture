.data
array:  .word 10, 24, 7, 45, 32, 8, 17, 59, 12, 5
array_size:  .word 10
max_label:   .asciiz "The maximum element is: "

.text
main:
    # Load the address of the array into $a0
    la $a0, array
    
    # Load the size of the array into $t1
    lw $t1, array_size

    # Initialize $t2 with the first element of the array
    lw $t2, 0($a0)

    # Loop to find the maximum element
loop:
    beq $t1, $zero, done   # If size == 0, exit loop
    lw $t3, 0($a0)         # Load the current element into $t3
    bgt $t3, $t2, update_max  # If current element > max, update max
    addi $a0, $a0, 4       # Move to the next element in the array
    addi $t1, $t1, -1      # Decrement size
    j loop

update_max:
    move $t2, $t3           # Update max with the current element
    j loop

done:
    # Display the maximum element
    li $v0, 4
    la $a0, max_label
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    # Exit the program
    li $v0, 10
    syscall
