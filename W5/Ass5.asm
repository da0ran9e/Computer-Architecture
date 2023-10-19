.data
text1: .asciiz "Enter string: "
text2: .asciiz "Reversed string: "
newline: .asciiz "\n"
input: .space 20

.text
    main:
    print_text:
        li $v0, 4
        la $a0, text1
        syscall

    get_string:
        li $v0, 8
        la $a0, input
        li $a1, 20
        syscall

    get_length: 
        la $t0, input
        li $t1, 0

    loop:
        lb $t2, 0($t0)       # Load byte from the string
        beqz $t2, end_input  # end input

        li $t3, 10
        beq $t2, $t3, continue

        addi $t0, $t0, 1     # t0++ size of poiter
        addi $t1, $t1, 1     # t1++ counter
        bnez $t1, loop

    continue:
        addi $t0, $t0, 1     #pointer size +1 but string length does not
        j loop

    end_input:
        li $v0, 4
        la $a0, text2
        syscall

        la $t0, input
        add $t0, $t0, $t1  # Pointer point to the end of the string

    print_reverse:
        beqz $t1, END  # end if printed entire string
        subi $t0, $t0, 1  # Move 1 character
        lb $t2, 0($t0)   # Load byte from the string
        li $v0, 11
        move $a0, $t2     # Print
        syscall
        subi $t1, $t1, 1  # t1--
        j print_reverse

    END:
        li $v0, 10
        syscall
