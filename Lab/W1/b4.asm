.data
promt: .asciiz "Please enter the value of a, b, c and d: "
newline: .asciiz "\n"
F_msg: "F = "
G_msg: "G = "
quotient_msg: .asciiz "(quotient = "
remainder_msg: .asciiz ", remainder = "
close_bracket: .asciiz ")"
.text
li $v0, 4
la $a0, promt
syscall

#read value of a, b, c and d
li $v0, 5
syscall
move $s0, $v0 #store a in $s0

li $v0, 5
syscall
move $s1, $v0 #store b in $s0

li $v0, 5
syscall
move $s2, $v0 #store c in $s0

li $v0, 5
syscall
move $s3, $v0 #store d in $s0

# calculate F
mul $t0, $s0, $s0 # a^2
add $t1, $t0, $s1 # a^2 + b
sub $t2, $s2, $s3 # c-d
mul $t3, $t1, $t2 #(a^2 + b) * (c-d)
div $t3, $t0 # calculate F
#print F
li $v0, 4
la $a0, F_msg
syscall

#print Quotient
li $v0, 4
la $a0, quotient_msg
syscall
#print
li $v0, 1
mflo $a0
syscall

#print Remainder
li $v0, 4
la $a0, remainder_msg
syscall

li $v0, 1
mfhi $a0
syscall

#print close_backet
li $v0, 4
la $a0, close_bracket
syscall
#print newline
li $v0, 4
la $a0, newline
syscall
#calculate G
addi $t4, $s0, 1 # a + 1
addi $t5, $s1, 2 # b + 2
subi $t6, $s2, 3 # c - 3
sub $t7, $s2, $s0
mul $t4, $t4, $t5
mul $t4, $t4, $t6
div $t4, $t7

#print G
li $v0, 4
la $a0, G_msg
syscall

#print Quotient
li $v0, 4
la $a0, quotient_msg
syscall
#print
li $v0, 1
mflo $a0
syscall

#print Remainder
li $v0, 4
la $a0, remainder_msg
syscall

li $v0, 1
mfhi $a0
syscall

#print close_backet
li $v0, 4
la $a0, close_bracket
syscall