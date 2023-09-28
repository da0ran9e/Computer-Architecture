.data
prompt:   .asciiz "Enter a non-negative integer: "
result:   .asciiz "The factorial is: "

.text
main:
    # Prompt for and read the input
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0  # Store the input in $t0

    # Compute the factorial
    li $t1, 1      # Initialize $t1 to 1 (the result)
    li $t2, 1      # Initialize $t2 to 1 (counter)

loop:
    beq $t2, $t0, done  # If counter == input, exit loop
    mul $t1, $t1, $t2  # result *= counter
    addi $t2, $t2, 1   # counter++
    j loop

done:
    # Display the result
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    # Exit the program
    li $v0, 10
    syscall
