.data
arr: .word 1, 2, 3, 4, 5, 6, 7, 8
enterArr: .asciiz "Please enter 8 numbers in your arr \n"
enternumth: .asciiz "Enter number "
el: .asciiz "\n"
sp: .asciiz " "
Arrmsg: .asciiz "Your array is: "
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
blt $t0, 8, loop_enter
# index
li $t0, 0
la $s0, arr
li $t2, 0
add $t2, $t2, $s0
loop_process:
	lw $t1, 0($t2)
	li $t3, 3
	div $t1, $t3
	mfhi $t4
	beq $t0, 8, printArr
	beq $t4, 0, dividedby3
	beq $t4, 1, mod3eq1
	beq $t4, 2, mod3eq2
	beq $t4, -1, mod3eq2
	beq $t4, -2, mod3eq1
dividedby3:
	li $t3, 3
	div $t1, $t3
	mflo $t1
	addi $t1, $t1, 1
	sw $t1, 0($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 4
	j loop_process
mod3eq1:
	subi $t1, $t1, 1
	sw $t1, 0($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 4
	j loop_process
mod3eq2:
	addi $t1, $t1, 1
	sw $t1, 0($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 4
	j loop_process
printArr:
la $a0, Arrmsg
li $v0, 4
syscall
li $t0, 0
li $t2, 0
la $s0, arr
add $t2, $t2, $s0
	print_loop:
		lw $a0, 0($t2)
		li $v0, 1
		syscall
		la $a0, sp
		li $v0, 4
		syscall
		addi $t0, $t0, 1
		addi $t2, $t2, 4
		blt $t0, 8, print_loop
