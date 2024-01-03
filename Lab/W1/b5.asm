.data
input_msg:   .asciiz "Enter a 10-bit binary number: "
output_msg:     .asciiz "Decimal value: "
binary_string:  .space 11
newline: .asciiz "\n"
.text
    # Print the input message
    li $v0, 4
    la $a0, input_msg
    syscall

    # Read the binary number into a buffer
    li $v0, 8
    la $a0, binary_string
    li $a1, 11  # Maximum input length (10 bits + '\0')
    syscall
	
    li $v0, 4
    la $a0, newline
    syscall	
    # Convert the binary string to decimal
    li $t0, 0           
    la $t1, binary_string   
    li $t2, 2          

convert_loop:
    lb $t4, 0($t1)     
    beqz $t4, done  
    mul $t0, $t0, $t2  
    subi $t4, $t4, '0'  
    add $t0, $t0, $t4 
    addi $t1, $t1, 1   
    j convert_loop

done:
    li $v0, 4
    la $a0, output_msg
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 10
    syscall
