.data
  prompt: .asciiz "Please enter your name: "
  greeting: .asciiz "Hello, "
  symbol: .asciiz "!"
  name: .space 100
.text
  main:
    # print the prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # read the name
    li $v0, 8 # system call code for read string
    la $a0, name # load the address of the name string
    li $a1, 100 # maximum length of the name
    syscall 
    
    li $v0, 4 # system call code for print string
    la $a0, greeting # load the address of the greeting string
    syscall 
    
    li $v0, 4 # system call code for print string
    la $a0, name # load the address of the name string
    syscall 
    
    li $v0, 4 # system call code for print string
    la $a0, symbol # load the address of the newline string
    syscall 

    li $v0, 10 
    syscall 
