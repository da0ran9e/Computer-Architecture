.data
n_prompt:       .asciiz "Enter the length of binary strings (n): "
string_label:   .asciiz "Binary String: "
binary_strings: .space 21  # Space to store binary strings

.text
main:
    # Prompt for and read the length of binary strings (n)
    li $v0, 4
    la $a0, n_prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0  # Store n in $t0

    # Initialize arrays a and s
    li $t1, 1      # Initialize k to 1
    sb $zero, binary_strings($t1)  # Initialize a[1] to 0

loop_outer:
    bge $t1, $t0, done  # If k >= n, exit the outer loop

    # Inner loop for generating binary strings
loop_inner:
    bge $t2, 2, print_string  # If s[k] >= 2, print the string

    # Generate the next binary string
    lb $t3, binary_strings($t1)   # Load a[k] into $t3
    sb $t3, binary_strings($t1)   # Store a[k] in a
    addi $t2, $t2, 1  # Increment s[k]

    # Check if k == n
    beq $t1, $t0, print_string

    # Increase k and reset s[k]
    addi $t1, $t1, 1
    sb $zero, binary_strings($t1)  # s[k] = 0
    j loop_outer

print_string:
    # Display the binary string
    li $v0, 4
    la $a0, string_label
    syscall

    li $t4, 1       # Initialize counter i to 1

print_loop:
    # Print the binary string
    lb $t5, binary_strings($t4)  # Load a[i] into $t5
    li $v0, 11
    li $a0, 48  # ASCII code for '0'
    add $a0, $a0, $t5  # Convert binary digit to ASCII
    syscall

    # Increment counter i
    addi $t4, $t4, 1

    # Check if i == n
    beq $t4, $t0, next_string

    # Print a space between binary digits
    li $v0, 11
    li $a0, 32  # ASCII code for space
    syscall

    j print_loop

next_string:
    # Print a newline
    li $v0, 11
    li $a0, 10  # ASCII code for newline
    syscall

    # Increment s[k]
    addi $t2, $t2, 1
    j loop_inner

done:
    # Exit the program
    li $v0, 10
    syscall
