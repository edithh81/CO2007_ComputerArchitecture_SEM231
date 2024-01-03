.data
floatarr: .float 0.4, 34.2, 23.5, -2.4, 16.8, -2.06, 20.0, 3.6, 2.9, 1009.45
sp: .asciiz " "
k: .word 10
prompt: .asciiz "Print: "
.text
la $s0, floatarr
lw $s1, k
la $a0, prompt
li $v0, 4
syscall
jal print
li $v0, 10
syscall
print:
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
beq $s1, 1, basecase
subi $s1, $s1, 1
addi $s0, $s0, 4
jal print
li $v0, 2
lw $s0, 4($sp)
lwc1 $f0, 0($s0)
mov.s $f12, $f0
syscall
li $v0, 4
la $a0, sp
syscall
j backtrack
basecase:
lwc1 $f0, 0($s0)
li $v0, 2
mov.s $f12, $f0
syscall
li $v0, 4
la $a0, sp
syscall
backtrack:
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
addi $sp, $sp, 12
jr $ra
