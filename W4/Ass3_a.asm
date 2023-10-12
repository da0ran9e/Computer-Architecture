slt $t0, $s1, $zero   # $t0=1 if $s1 < 0, else =0
sub $s0, $zero, $s1   #reverse 

and $s0, $s0, $t0     # If $s1 < 0, $s0 = 0 
or $s0, $s0, $s1      # If $s1 >= 0, $s0 = $s1
