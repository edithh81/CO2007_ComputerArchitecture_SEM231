.data
  prompt: .asciiz "Please enter your name: "
  greeting: .asciiz "Hello, "
  symbol: .asciiz "!"
  name: .space 100
.text
  main:
    li $v0, 4
    la $a0, prompt
    syscall
    
  
    li $v0, 8 
    la $a0, name 
    li $a1, 100 
    syscall 
    
    li $v0, 4 
    la $a0, greeting 
    syscall 
    
    li $v0, 4 
    la $a0, name 
    syscall 
    
    li $v0, 4 
    la $a0, symbol 
    syscall 

    li $v0, 10 
    syscall 
