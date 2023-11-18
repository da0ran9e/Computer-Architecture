.data
    prompt: .asciiz "Enter element: "
    array:  .space 40   # 10 integers, each taking 4 bytes

.text
main:
    la $a0, prompt
    
    # Loop to read 10 integers
    li $t0, 10
    la $t1, array
    
read_loop:
    # Print the prompt
    li $v0, 4
    syscall
    
    # Read an integer from the user
    li $v0, 8
    la $a0, ($t1)
    li $a1, 4
    syscall
    
    # Move to the next position in the array
    addi $t1, $t1, 4
    
    # Decrement the counter
    sub $t0, $t0, 1
    
    # Check if we have read all 10 integers
    bnez $t0, read_loop
    
    # Continue with your program logic here...
    
    # Exit the program
    li $v0, 10
    syscall
