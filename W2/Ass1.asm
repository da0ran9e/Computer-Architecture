.data

x: .byte 256

.text

# Assign X, Y

la $t1, x

lb $t2, 0($t1)