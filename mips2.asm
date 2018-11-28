.data
1 2 3 4 5

.text
lw $t1, 0($zero)
addi $t2, $t2, 16
lw $t3, 0($t2)

and $t4,$t1,$t3
or $t5,$t1,$t3

addi $t2, $t2, 16
sw $t4, 0($t2)
addi $t2, $t2, 16
sw $t5, 0($t2)
