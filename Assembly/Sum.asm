.data
prompt1:   .asciiz "Enter the first number: "
prompt2:   .asciiz "Enter the second number: "
result:    .asciiz "The sum is: "

.text
main:
    # Prompt for and read the first number
    li $v0, 4
    la $a0, prompt1
    syscall
    li $v0, 5
    syscall
    move $t0, $v0  # Store the first number in $t0

    # Prompt for and read the second number
    li $v0, 4
    la $a0, prompt2
    syscall
    li $v0, 5
    syscall
    move $t1, $v0  # Store the second number in $t1

    # Compute the sum
    add $t2, $t0, $t1

    # Display the result
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    # Exit the program
    li $v0, 10
    syscall
