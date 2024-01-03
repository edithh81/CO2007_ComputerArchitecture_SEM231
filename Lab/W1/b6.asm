.data
promptN: .asciiz "Enter N: "
promptM: .asciiz "Enter M: "
promptX: .asciiz "Enter X: "
output_msg: .asciiz "Sequence is: "
space: .asciiz " "
.text
    	li $v0, 4
    	la $a0, promptN
    	syscall

   	 li $v0, 5
    	syscall
    	move $s0, $v0  

    	li $v0, 4
   	la $a0, promptM
    	syscall

	li $v0, 5
    	syscall
    	move $s1, $v0  

   	li $v0, 4
    	la $a0, promptX
    	syscall

	li $v0, 5
    	syscall
    	move $t2, $v0 

    	li $v0, 4
    	la $a0, output_msg
    	syscall

generate:
    	blt $t2, 0, exit

    	li $v0, 1
    	move $a0, $s0 
    	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
    	mul $s0, $s0, $s1

    	subi $t2, $t2, 1
    	j generate

exit:
    li $v0, 10
    syscall
