.data
floatarr: .float 0.4, 34.2, 23.5, 2.4, 16.8, 2.06, -20.0, 3.6, 2.9, 1009.45
sp: .asciiz " "
k: .word 10
prompt: .asciiz "Minimum value of float array is: "
.text
la $s0, floatarr
lw $s1, k
jal findmin
la $a0, prompt
li $v0, 4
syscall
# f1 contains the result
li $v0, 2
mov.s $f12, $f1
syscall
li $v0, 10
syscall
findmin:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	beq $s1, 1, basecase
	addi $s0, $s0, 4
	subi $s1, $s1, 1
	jal findmin
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lwc1 $f0, 0($s0)
	c.lt.s $f1, $f0
	bc1t skip
swap:	
	mov.s $f1, $f0
	j backtrack
skip:
	j backtrack
basecase:
	lwc1 $f1, 0($s0)
backtrack:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
