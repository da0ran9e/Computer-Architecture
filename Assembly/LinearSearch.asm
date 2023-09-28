.data
array:  .word 10, 24, 7, 45, 32, 8, 17, 59, 12, 5
array_size:  .word 10
search_value:  .word 32
found_msg:   .asciiz "Value found in the array."
not_found_msg:   .asciiz "Value not found in the array."

.text
main:
    # Load the address of the array into $a0
    la $a0, array

    # Load the size of the array into $t1
    lw $t1, array_size

    # Load the value to search for into $t2
    lw $t2, search_value

    # Initialize the loop counter
    li $t3, 0

    # Loop to search for the value
loop:
    beq $t3, $t1, not_found   # If counter == size, value not found
    lw $t4, 0($a0)            # Load the current element into $t4
    beq $t4, $t2, found      # If current element == search value, value found
    addi $a0, $a0, 4          # Move to the next element in the array
    addi $t3, $t3, 1          # Increment counter
    j loop

found:
    # Display a message indicating that the value was found
    li $v0, 4
    la $a0, found_msg
    syscall
    j done

not_found:
    # Display a message indicating that the value was not found
    li $v0, 4
    la $a0, not_found_msg
    syscall

done:
    # Exit the program
    li $v0, 10
    syscall
