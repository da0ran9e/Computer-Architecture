.data
input_str:  .asciiz "Hello, MIPS!"
output_str: .space 20

.text
main:
    # Load the address of the input string into $a0
    la $a0, input_str

    # Load the address of the output string into $a1
    la $a1, output_str

    # Calculate the length of the input string
    li $t0, 0   # Initialize a counter to 0
calc_length:
    lb $t1, 0($a0)   # Load a character from the input string
    beqz $t1, reverse   # If the character is null (end of string), go to reverse
    addi $a0, $a0, 1   # Move to the next character
    addi $t0, $t0, 1   # Increment the counter
    j calc_length

reverse:
    # Reverse the input string and store it in the output string
    li $t2, 0   # Initialize a counter to 0
    addi $t0, $t0, -1   # Decrement the length by 1 to get the last index
reverse_loop:
    beqz $t0, done   # If we've reversed the entire string, exit
    lb $t1, 0($a0)   # Load a character from the input string
    sb $t1, 0($a1)   # Store the character in the output string
    addi $a0, $a0, 1   # Move to the next character in the input string
    addi $a1, $a1, 1   # Move to the next position in the output string
    addi $t0, $t0, -1   # Decrement the counter
    j reverse_loop

done:
    # Null-terminate the output string
    li $t1, 0   # Null character
    sb $t1, 0($a1)

    # Display the reversed string
    li $v0, 4
    la $a0, output_str
    syscall

    # Exit the program
    li $v0, 10
    syscall
