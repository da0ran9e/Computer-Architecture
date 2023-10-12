.text 
    addi $s0, $zero, 305419896 #0x12345678
    andi $t0, $s0, 0xff #LSB
    andi $t1, $s0, 0xff000000 #MSB
    addi $t1, $s0, 0x0400 #10
    addi $t0, $s0, 0xffffff00 #clear LSM
    ori $t0, $s0, 0x000000ff #set LSM
    xor $s0, $s0, $s0 #clear
