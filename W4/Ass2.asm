.text 
    addi $s0, $zero, 305419896 #0x12345678
    andi $t0, $s0, 0xff #LSB
    srl $t1, $s0, 24   # Shift right by 24 
    andi $t1, $t1, 0xff # MSB
    addi $s0, $s0, 0xffffff00 #clear LSM
    ori $t3, $s0, 0x000000ff #set LSM
    xor $s0, $s0, $s0 #clear
