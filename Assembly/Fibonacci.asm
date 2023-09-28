.data
prompt:  .asciiz "Enter the number of Fibonacci terms to generate: "
result:  .asciiz "Fibonacci Series: "

.text
main:
    # Prompt for and read the number of terms
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0    # Store the number of terms in $t0

    # Initialize the first two terms
    li $t1, 0        # First term (F(0))
    li $t2, 1        # Second term (F(1))

    # Display the result label
    li $v0, 4
    la $a0, result
    syscall

loop:
    # Display the current term
    li $v0, 1
    move $a0, $t1
    syscall

    # Calculate the next term
    add $t3, $t1, $t2  # $t3 = $t1 + $t2
    move $t1, $t2      # Shift values for the next iteration
    move $t2, $t3

    # Decrement the count and loop if needed
    addi $t0, $t0, -1
    bnez $t0, loop

    # Exit the program
    li $v0, 10
    syscall
