.data
array: .word 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150
prompt1: .asciiz "Please choose a mode:\n1. Print the value of the element chosen by the user\n2. Print a sequence of values from the elements chosen by the user\nEnter 1 or 2: "
prompt2: .asciiz "Enter an index number from 0 to 14: "
prompt3: .asciiz "Enter two index numbers from 0 to 14, separated by a space: "
error_size: .asciiz "Invalid input. Please try again.\n"
newline: .asciiz "\n"
space: .asciiz " "
.text
li $v0, 4 #print message
la $a0, prompt1 
syscall

#let user choose mode
li $v0, 5
syscall
move $t0, $v0
bne $t0, 1, mode2
j mode1
#print the result
la $t0, array
mul $t2, $v0, 4
add $t1, $t0, $t2
lw $t1, 0($t1)
addi $a0, $t1, 0
li $v0, 1
syscall
j end

mode1:
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#read index
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 0, error1
	bgt $t1, 14, error1
	# not error
	la $t2, array
	sll $t1, $t1, 2
	add $t2, $t2, $t1
	lw $t3, 0($t2)
	 li $v0, 1
	 move $a0, $t3
	 syscall
	 li $v0, 10
	 syscall
mode2:
	li $v0, 4
	la $a0, prompt3
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 #first index
	li $v0, 5
	syscall
	move $t2, $v0 #second index
	blt $t1, 0, error2
	bgt $t1, 14, error2
	blt $t2, 0, error2
	bgt $t2, 14, error2
	la $t3, array
	sll $t1, $t1, 2
	add $t3, $t3, $t1
	la $t4, array
	sll $t2, $t2, 2
	add $t4, $t4, $t2
error1:
	la $a0, error_size
	li $v0, 4
	syscall
	j mode1
error2:
	la $a0, error_size
	li $v0, 4
	syscall
	j mode2
print_arr:
	lw $t5, 0($t3)
	li $v0, 1
	move $a0, $t5
	syscall
	 li $v0, 4
	 la $a0, space
	 syscall
	 beq $t3, $t4, end
	 addi $t3, $t3, 4
	 j print_arr
end:
	li $v0, 10
	 syscall
	