.data
arr: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
enterArr: .asciiz "Please enter 15 numbers in your arr \n"
enternumth: .asciiz "Enter number "
el: .asciiz "\n"
sp: .asciiz " "
error: "Does not exist the second smallest value in your array"
secondSmallest: .asciiz "Second smallest value is "
indexfound: .asciiz ", found in index "
comma: .asciiz ","
.text
la $a0, enterArr
li $v0, 4
syscall
# use t0 so store index
li $t0, 0
# use s0 to store arr
la $s0, arr
li $t2, 0
add $t2, $t2, $s0
loop_enter:
la $a0, enternumth
li $v0, 4
syscall
addi $a0, $t0, 1
li $v0, 1
syscall
la $v0, 5	
syscall
move $t1, $v0
sw $t1, 0($t2)
addi $t2, $t2, 4
addi $t0, $t0, 1
blt $t0, 15, loop_enter
checkNoExist:
li $t0, 1
li $t2, 0
la $s0, arr
add $t2, $t2, $s0
lw $t1, 0($t2)
addi $t2, $t2, 4
	loop_check:
		lw $t3, 0($t2)
		bne $t2, $t3, arrisnotDup
		addi $t0, $t0, 1
		add $t2, $t2, 4
		beq $t0, 15, err
		j loop_check
arrisnotDup:
la $s0, arr
# smallest value
lw $t1, 0($s0)
# second smallest value
lw $t2, 4($s0)
# index
li $t0, 2
li $t3, 0
add $t3, $t3, $s0
addi $t3, $t3, 8
findsecondsmallest:
	lw $t4, 0($t3)
	slt $t5, $t4, $t1
	beq $t5, 0, skip
	addi $t6, $t1, 0
	addi $t1, $t4, 0
	addi $t2, $t6, 0
	j increaseidx
	skip:
	slt $t6, $t4, $t2
	bne $t6, 1, increaseidx
	addi $t2, $t4, 0
	increaseidx:
	addi $t0, $t0, 1
	addi $t3, $t3, 4
	beq $t0, 15, printResult
	j findsecondsmallest
printResult:
	la $a0, secondSmallest
	li $v0, 4 
	syscall
	addi $a0, $t2, 0
	li $v0, 1
	syscall
	la $a0, indexfound
	li $v0, 4
	syscall
	li $t0, 0
	la $s0, arr
	li $t1, 0
	add $t1, $t1, $s0
	li $t5, 0
	loopprintidx:
		lw $t3, 0($t1)
		beq $t3, $t2, printIdx
		j increaseIdx
		printIdx:
		beq $t5, 0, skipcomma
		la $a0, comma
		li $v0, 4
		syscall
		la $a0, sp
		li $v0, 4
		syscall
		skipcomma:
		addi $t5, $t5, 1
		addi $a0, $t0, 0
		li $v0, 1
		syscall
		increaseIdx:
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		blt $t0, 15, loopprintidx
		j exit
err:
	la $a0, error
	li $v0, 4
	syscall
exit:
	li $v0, 10
	syscall
# manh qua a oi, em quat a