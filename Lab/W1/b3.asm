.data
array:      .word   1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
sz: .word   20        
space:      .asciiz " "
newline:    .asciiz "\n"

.text
.globl main

main:
    la $t0, array            # Load array address into $t0
    lw $t1, sz      # Load array size into $t1

    # Bubble sort in descending order
    add $t2, $t0, $t1        
    sll $t2, $t2, 2         
    add $t2, $t2, $t0        

	# Outer loop counter (size - 1)
    sub $t3, $t1, 1          
outerloop:
    beqz $t3, print_array    
    move $t4, $t0            

	# Inner loop
    li $t5, 0                
innerloop:
    addi $t6, $t5, 1         # Calculate the next index
    bge $t6, $t1, update_outer # If reached the end of the array, go to update_outer

    lw $t7, 0($t4)           # Load current element
    lw $t8, 4($t4)           # Load next element

    blt $t7, $t8, swap       # If current element < next element, swap

continue_inner:
    addi $t4, $t4, 4         # Move to the next element in the array
    addi $t5, $t5, 1         # Increment inner loop index
    j innerloop             # Jump back to the start of the inner loop

swap:
    sw $t7, 4($t4)           # Swap elements (store cross)
    sw $t8, 0($t4)

    j continue_inner         # Continue with the inner loop

update_outer:
    subi $t3, $t3, 1         # Decrease outer loop counter
    j outerloop             # Jump back to the start of the outer loop

print_array:
    li $v0, 4                # Print newline
    la $a0, newline
    syscall

    move $t4, $t0            # Start at the beginning of the array

    li $t5, 0                # Reset index to 0
print_loop:
    lw $t7, 0($t4)           # Load the current element
    li $v0, 1                # System call to print integer
    move $a0, $t7
    syscall

    li $v0, 4                # Print space
    la $a0, space
    syscall

    addi $t4, $t4, 4         # Move to the next element
    addi $t5, $t5, 1         # Increment index
    blt $t5, $t1, print_loop # If index is less than size, loop

    # Exit the program
    li $v0, 10
    syscall
