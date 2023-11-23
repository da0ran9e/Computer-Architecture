.LC0:
        .ascii  "HELLO!\000"
.LFB0 = .
helloWorld:
        daddiu  $sp,$sp,-32
        sd      $31,24($sp)
        sd      $fp,16($sp)
        sd      $28,8($sp)
        move    $fp,$sp
        lui     $28,%hi(%neg(%gp_rel(helloWorld)))
        daddu   $28,$28,$25
        daddiu  $28,$28,%lo(%neg(%gp_rel(helloWorld)))
        ld      $2,%got_page(.LC0)($28)
        daddiu  $4,$2,%got_ofst(.LC0)
        ld      $2,%call16(printf)($28)
        mtlo    $2
        mflo    $25
        jalr    $25
        nop

.LVL0 = .
        nop
        move    $sp,$fp
        ld      $31,24($sp)
        ld      $fp,16($sp)
        ld      $28,8($sp)
        daddiu  $sp,$sp,32
        jr      $31
        nop