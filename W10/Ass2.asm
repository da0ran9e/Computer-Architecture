# Define constants for monitor screen and colors
.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv BLACK 0x00000000

.text
	li $k0, MONITOR_SCREEN
	sub $k0, $k0, 4 # starting address
	addi $k1, $k0, 256 # ending address
	
	# Initialize loop counters
	addi $t1, $0, 0 # bits in row
	addi $t2, $0, 32 
	addi $t3, $0, 0 # column num
loop:
	beq $k1, $k0, end	
row_loop:
	# Check if $t1 is equal to 32
	beq $t1, $t2, end_row_loop
	addi $t1, $t1, 4
	
	li $t0, BLACK
	addi $k0, $k0, 4
	sw  $t0, ($k0)
	
	beq $t3, 4, check_row_1
	beq $t3, 8, check_row_2
	beq $t3, 12, check_row_3
	beq $t3, 16, check_row_4
	beq $t3, 20, check_row_5
	beq $t3, 24, check_row_6

	# Repeat Loop1
	j row_loop

# End of Loop1
end_row_loop:
	# Reset loop counters
	addi $t1, $0, 0
	addi $t2, $0, 32
	addi $t3, $t3, 4
	
check_row_1:
	beq $t1, 16, place
	beq $t1, 20, place
	j loop
check_row_2:
	beq $t1, 12, place
	beq $t1, 24, place
	j loop
check_row_3:
	beq $t1, 8, place
	beq $t1, 28, place
	j loop
check_row_4:
	beq $t1, 8, place
	beq $t1, 12, place
	beq $t1, 16, place
	beq $t1, 20, place
	beq $t1, 24, place
	beq $t1, 28, place
	j loop
check_row_5:
	beq $t1, 8, place
	beq $t1, 28, place
	j loop
check_row_6:
	beq $t1, 8, place
	beq $t1, 28, place
	j loop

	
j end
place:
li $t0, WHITE
sw  $t0, ($k0)
j loop
end:
