.data
str: .asciiz "abdeefggf"
err: .asciiz "Your string contains non_alphabetic char"
output: .asciiz "Output is : "
fre: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
la $s0, str
li $t3, 0
standardlize:
	lb $t0, 0($s0)
	beq $t0, '\0', br
	sgt $t1, $t0, 64
	slt $t2, $t0, 98
	and $t1, $t1, $t2
	beq $t1, 1, skip
	subi $t0, $t0, 32
	sb $t0, 0($s0)
	skip:
	addi $t3, $t3, 1
	addi $s0, $s0, 1
	j standardlize
br:
la $s0, str
li $t0, 0
	checknonAlphabetic:
		lb $t1, 0($s0)
		beq $t1, '\0', process
		blt $t1, 65, error
		bgt $t1, 97, error
		addi $s0, $s0, 1
		
process:
	la $s0, str
	li $t0, 0
	la $s1, fre # frequency arr
	loopmark:
		lb $t1, 0($s0)
		beq $t1, '\0', printRes
		subi $t1, $t1, 65
		sll $t1, $t1, 2
		add $t1, $t1, $s1
		lw $t2, 0($t1)
		addi $t2, $t2, 1
		sw $t2, 0($t1)
		addi $s0, $s0, 1
		j loopmark
printRes:	
	la $a0, output
	li $v0, 4
	syscall
	la $s1, fre
	li $t0, 26
	li $t1, 25
	sll $t1, $t1, 2
	add $s1, $s1, $t1
	loop_print:
		
error:
	la $a0, err
	li $v0, 4
	syscall
	j exit
exit:
 	li $v0, 10
 	syscall
