.data
hello_str:  .asciiz "Hello, World!\n"

.text
main:
    # Print the string
    li $v0, 4       # System call code for print string
    la $a0, hello_str  # Load address of hello_str into $a0
    syscall

    # Exit the program
    li $v0, 10      # System call code for exit
    syscall
