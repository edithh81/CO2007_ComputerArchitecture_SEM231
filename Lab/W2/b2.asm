.data
prompt_a: .asciiz "Enter a : "
prompt_b: .asciiz "Enter b : "
el: .asciiz "\n"
neg_err: .asciiz " The number is negative. Please enter again!\n"
GCDmsg: .asciiz "GCD of a and b is : "
LCMmsg: .asciiz "LCM of a and b is : "
.text
# enter a
main:
enter_a:
la $a0, prompt_a
li $v0, 4
syscall

li $v0, 5
syscall
move $t0, $v0
addi $t5, $t0, 0
blt $t0, 0, err_a
beq $t0, 0, err_a
enter_b:
la $a0, prompt_b
li $v0, 4
syscall

li $v0, 5
syscall
move $t1, $v0
addi $t6, $t1, 0
blt $t1, 0, err_b
beq $t1, 0, err_b
j GCD
err_a:
la $a0, neg_err
li $v0, 4
syscall
j enter_a
err_b:
la $a0, neg_err
li $v0, 4
syscall
j enter_b
# t0 contains a and t1 contains b
GCD:
beq $t1, 0, print_GCD
addi $t3, $t1, 0
div $t0, $t1
mfhi $t4
addi $t0, $t3, 0
addi $t1, $t4, 0
j GCD
print_GCD:
la $a0, GCDmsg
li $v0, 4
syscall

move $a0, $t0
la $v0, 1
syscall
j LCD
LCD:
la $a0, el
li $v0, 4
syscall
mul $t5, $t5, $t6
div $t5, $t0
j print_LCM
print_LCM:
la $a0, LCMmsg
li $v0, 4
syscall

mflo $a0
li $v0, 1
syscall
j exit
exit:
li $v0, 10
syscall
