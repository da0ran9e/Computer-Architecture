.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59 ,5
Aend: .word

.text
main:
    la $a0, A           
    la $a1, Aend        
    addi $t0, $a0, 4    
    j insertion_sort    

after_sort:
    li $v0, 10           # Exit
    syscall

insertion_sort:
    add $v0, $t0, $zero  # Copy the address of the current element into $v0

loop:
    lw $s0, ($v0)       
    lw $s1, -4($v0)     
    slt $s2, $s0, $s1   

    beq $s2, $zero, skip_swap  

    sw $s0, -4($v0)      # Swap current and previous elements
    sw $s1, ($v0)

    subi $v0, $v0, 4     # Move to A[i-1]
    beq $v0, $a0, skip_swap  
    j loop

skip_swap:
    addi $t0, $t0, 4    # Move to the next element

    beq $t0, $a1, end_sort  #

    j insertion_sort     

end_sort:
    j after_sort          # Jump to end 
