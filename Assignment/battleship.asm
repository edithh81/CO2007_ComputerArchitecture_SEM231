######################
# Battleship
######################
.data	
	# path to store setup and target of each player
	p1out: .asciiz "D:/K22_KHMT_HCMUT/HK231/Computer Architecture/Assignment/check/p1.txt"
	p2out: .asciiz "D:/K22_KHMT_HCMUT/HK231/Computer Architecture/Assignment/check/p2.txt"
	setupout: .asciiz "Set up\n"
	sizeout: .asciiz "Size: "
	coorPlace: .asciiz "Coordinate: "
	attack: .asciiz "Attack: "
	s2: .asciiz "2"
	s3: .asciiz "3"
	s4: .asciiz "4"
	el: .asciiz "\n"
	# welcome
	welcome: .asciiz "Welcome to BattleShip!\nIn this game, you will have:\n- 3 2x1 ships \n- 2 3x1 ships \n- 1 4x1 ship\nAll the ships must be placed in the grid before battle so the coordinate must be in range 0 to 6\nLET'S BEGIN!!!!!\n"
	inputMsg: .asciiz "Enter your ship coordinates in the following form (rowBow colBow rowStern colStern)\n"
	# Input message
	askShip: .asciiz "Enter the ship size to place (2, 3, 4) "
	askp1: .asciiz "Player 1 places all your ship\n" 
	askp2: .asciiz "Player 2 places all your ship\n" 
	donePlaced: .asciiz "Successfully place all the ships"
	gridMessage: .asciiz "Your Grid\n"
	debug: .asciiz "Debug"
	BattleMsg: .asciiz "Let's battle!!!!\n"
	Player1Win: .asciiz "Congrats!! Player 1 win!!!"
	Player2Win: .asciiz "Congrats!! Player 2 win!!!"
	# In game message
	user1Attack: .asciiz "Player1's Turn. Enter the target cell!"
	user2Attack: .asciiz "Player2's Turn. Enter the target cell!"
	Ship2Sunked: .asciiz "Ship size 2 sunked!"
	Ship3Sunked: .asciiz "Ship size 3 sunked!"
	Ship4Sunked: .asciiz "Ship size 4 sunked!"
	missMsg: .asciiz "MISS!\n"
	hitMsg: .asciiz "HIT!\n"
	# Error Message
	inpSizeError: .asciiz "Size of ship can be 2,3 or 4. Please enter again!"
	coorError: .asciiz "Your input is not valid. Please enter again!"
	lengthError: .asciiz "The length of your ship does not fit with the coordinate. Please enter again!"
	noMoreShip: .asciiz "You have owned full this size of ship. Please choose another size!\n"
	overlapError: .asciiz "The coordinate has been occupied by another ship. Please enter again!"
	targetError: .asciiz "The range of coordinate's target cell is from 0 to 6. Please enter again!"
	wrongPlaced: .asciiz "You can only place the ship in the same row or in the same column. Please enter again!"
	# Container	
	nOfShip1: .word 0, 0, 0   #s0 to store nShip of Player 1 
	nOfShip2: .word 0, 0, 0   #s1 to store nShip of Player 2
	# both player use first idx to store size2, second to store size3, last to store size4
	InCoor: .byte 0:8
	targetcell: .byte 0:4
	grid1: .byte 	0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0
	
	grid2: .byte 	0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0
	printGrid: .byte 0:500
	attackGrid1: .byte 	0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0
	attackGrid2: .byte 	0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0
.text
openfile:
# use s6 to store as p1
	li $v0, 13
	la $a0, p1out
	li $a1, 1
	li $a2, 0
	syscall
	move $s6, $v0
	li $v0, 15
	move $a0, $s6
	la $a1, setupout
	li $a2, 7
	syscall
#use s7 to store as p2
	li $v0, 13
	la $a0, p2out
	li $a1, 1
	li $a2, 0
	syscall
	move $s7, $v0
	li $v0, 15
	move $a0, $s7
	la $a1, setupout
	li $a2, 7
	syscall
main:	
	li $a1, 1
	# welcome message
	la $a0, welcome
	li $v0, 55
	syscall
#let player 1 set up their table
p1:
	la $a0, askp1
	li $v0, 55
	syscall
	addi $t0, $0, 1
	j initializeBoard
#let player 2 set up their table
p2:
	la $a0, askp2
	li $v0, 55
	syscall
	addi $t0, $0, 2
	j initializeBoard
initializeBoard:
	addi $s1, $0, 6 # each player has 6 ships
	beq $t0, 1, setup1 # use $t0 to identify which player
	beq $t0, 2, setup2
	# use $s0 to store each value of size
	# use $s3 to store grid of each player
	setup1:
		la $s0, nOfShip1
		la $s3, grid1
		j inpSizeofShip
	setup2:
		la $s0, nOfShip2
		la $s3, grid2
		j inpSizeofShip
	inpSizeofShip:
		beq $s1, 0, doneSetUp # all of ship have been placed
		la $a0, askShip
		li $v0, 51
		syscall
		beq $a1, -1, inpsizeError
		beq $a1, -2, end
		beq $a1, -3, inpsizeError
		blt $a0, 2, inpsizeError # out of range
		bgt $a0, 4, inpsizeError #out of range
		beq $a0, 2, shipSize2
		beq $a0, 3, shipSize3
		beq $a0, 4, shipSize4
	shipSize2:
		lw $t1, 0($s0)
		li $s2, 2
		beq $t1, 3, typeRunOut # this type has been placed all
		j inpCoor
	shipSize3:
		lw $t1, 4($s0)
		li $s2, 3
		beq $t1, 2, typeRunOut # this type has been placed all
		j inpCoor
	shipSize4:
		lw $t1, 8($s0)
		li $s2, 4
		beq $t1, 1, typeRunOut # this type has been placed all
		j inpCoor
	inpCoor:
		la $a0, inputMsg
		la $a1, InCoor
		li $a2, 8
		li $v0, 54
		syscall # $a1 contains the inp coor
		beq $a1, -2, end
		beq $a1, -3, wrongFormat
		beq $a1, -4, wrongFormat
		# use $t2 to store the string
		la $t2, InCoor
		# use t3 to check character at each index
		li $t5, 0
		loop_check: #loop check each character at each index
			lb $t3, 0($t2)
			lb $t4, 1($t2)
			sub $t3, $t3, 48
			blt $t3, 0,wrongFormat # coor is less than 0
			bgt $t3, 6,wrongFormat # coor is greater than 6
			beq $t5, 3, check_length
			bne $t4, ' ', wrongFormat # do not accept floating num or anything else
			addi $t2, $t2, 2 # increase string to get char
			addi $t5, $t5, 1
			blt $t5, 4, loop_check
		check_length:
			# get coor from inp and check length 
			la $t2, InCoor # get incoor in t2
			lb $t3, 0($t2) # r bow
			lb $t4, 2($t2) # c bow
			lb $t5, 4($t2) # r stern
			lb $t6, 6($t2) # c stern
			# $s2 contain length of input ship
			# $s3 store the grid
			beq $t3, $t5, placeSameRow # ship place in a row
			beq $t4, $t6, placeSameCol # ship place in a col
			j placeShipErr
			placeSameRow:
				sub $t7, $t4, $t6 #get length
				bgt $t7, 0, nonNeg
				sub $t7, $t6, $t4
				nonNeg: addi $t7, $t7, 1
				bne $t7, $s2, lengthofShipError
				addi $t9, $s2, 0
				# check overlap
				# get coor from ascii to integer
				subi $t3, $t3, 48
				subi $t4, $t4, 48
				subi $t5, $t5, 48
				subi $t6, $t6, 48
				blt $t4, $t6, skip
				# swap $t4 and $t6
				addi $t8, $t4, 0
				addi $t4, $t6, 0
				addi $t6, $t8, 0
				skip: 
				mul $t7, $t3, 7 # mul t7 = t3*7
				add $t7, $t7, $t4
				add $t7, $t7, $s3
				loopOverlap:
				lb $t8, 0($t7)
				#la $a0, debug
				#addi $a1, $t8, 0
				#li $v0, 56
				#syscall
				beq $t8, 1, overlapErr
				subi $t9, $t9, 1
				beq $t9, 0, markedRow
				addi $t7, $t7, 1
				#add $t7, $t7, $s3
				j loopOverlap
			placeSameCol:
				sub $t7, $t3, $t5 #get length
				bgt $t7, 0, nonNeg1
				sub $t7, $t5, $t3
				nonNeg1: addi $t7, $t7, 1
				bne $t7, $s2, lengthofShipError
				# check overlap
				addi $t9, $s2, 0
				subi $t3, $t3, 48
				subi $t4, $t4, 48
				subi $t5, $t5, 48
				subi $t6, $t6, 48
				blt $t3, $t5, skip1
				#swap $t3 and $t5
				addi $t8, $t3, 0
				addi $t3, $t5, 0
				addi $t5, $t8, 0
				skip1:
				mul $t7, $t3, 7
				add $t7, $t7, $t4
				add $t7, $t7, $s3
				loopOverlap1:
				lb $t8, 0($t7)
				beq $t8, 1, overlapErr
				subi $t9, $t9, 1
				beq $t9, 0, markedCol
				addi $t7, $t7, 7
				#add $t7, $t7, $s3
				j loopOverlap1
			markedRow:
				addi $t9, $s2, 0
				mul $t7, $t3, 7 # mul t7 = t3*7
				add $t7, $t7, $t4
				add $t7, $t7, $s3
				loopMark:
				li $t8, 1
				sb $t8, 0($t7)
				subi $t9, $t9, 1
				beq $t9, 0, print
				addi $t7, $t7, 1
				#add $t7, $t7, $s3
				j loopMark
			markedCol:
				addi $t9, $s2, 0
				mul $t7, $t3, 7 # mul t7 = t3*7
				add $t7, $t7, $t4
				add $t7, $t7, $s3
				loopMark1:
				li $t8, 1
				sb $t8, 0($t7)
				subi $t9, $t9, 1
				beq $t9, 0, print
				addi $t7, $t7, 7
				#add $t7, $t7, $s3
				j loopMark1
			print:	
				beq $t0, 2, filep2
				li $v0, 15
				move $a0, $s6
				la $a1, sizeout
				li $a2, 6
				syscall
				li $v0, 15
				move $a0, $s6
				beq $s2, 2, lasize2
				beq $s2, 3, lasize3
				beq $s2, 4, lasize4
				lasize2:
				la $a1, s2
				j write
				lasize3:
				la $a1, s3
				j write
				lasize4:
				la $a1, s4
				write:
				li $a2, 1
				syscall
				li $v0, 15
				move $a0, $s6
				la $a1, el
				li $a2, 1
				syscall
				li $v0, 15
				move $a0, $s6
				la $a1, coorPlace
				li $a2, 12
				syscall
				li $v0, 15
				move $a0, $s6
				la $a1, InCoor
				li $a2, 7
				syscall
				li $v0, 15
				move $a0, $s6
				la $a1, el
				li $a2, 1
				syscall
				j donewFile
				filep2:
				li $v0, 15
				move $a0, $s7
				la $a1, sizeout
				li $a2, 6
				syscall
				li $v0, 15
				move $a0, $s7
				beq $s2, 2, lasize2_1
				beq $s2, 3, lasize3_1
				beq $s2, 4, lasize4_1
				lasize2_1:
				la $a1, s2
				j write_1
				lasize3_1:
				la $a1, s3
				j write_1
				lasize4_1:
				la $a1, s4
				write_1:
				li $a2, 1
				syscall
				li $v0, 15
				move $a0, $s7
				la $a1, el
				li $a2, 1
				syscall
				li $v0, 15
				move $a0, $s7
				la $a1, coorPlace
				li $a2, 12
				syscall
				li $v0, 15
				move $a0, $s7
				la $a1, InCoor
				li $a2, 7
				syscall
				li $v0, 15
				move $a0, $s7
				la $a1, el
				li $a2, 1
				syscall
				donewFile:
				# use t2 to store grid
				la $t2, printGrid
				# use t3 as index
				li $t4, '='
				li $t3, 0
				line_head:
				sb $t4, 0($t2)
				addi $t3, $t3, 1
				addi $t2, $t2, 1
				blt $t3, 18, line_head
				li $t4, '\n'
				sb $t4, 0($t2)
				addi $t2, $t2, 1
				# $s3 contains the grid
				li $t3, 0 # outerloop
				li $t5, 0 # innerloop
				addi $t6, $s3, 0
				make_border:
					li $t4, '|'
					sb $t4, 0($t2)
					li $t4, ' '
					sb $t4, 1($t2)
					sb $t4, 2($t2)
					sb $t4, 3($t2)
					addi $t2, $t2, 4
					make_grid:
						lb $t4, 0($t6)
						addi $t4, $t4, 48
						sb $t4, 0($t2)
						li $t4, ' ' 
						sb $t4, 1($t2)
						sb $t4, 2($t2)
						sb $t4, 3($t2)
						addi $t2, $t2, 4
						addi $t5, $t5, 1
						addi $t6, $t6, 1
						blt $t5, 7, make_grid
					li $t5, 0
					addi $t3, $t3, 1
					li $t4, '|'
					sb $t4, 0($t2)
					li $t4, '\n'
					sb $t4, 1($t2)
					addi $t2, $t2, 2
					blt $t3, 7, make_border
				li $t4, '='
				li $t3, 0
				line_end:
				sb $t4, 0($t2)
				addi $t3, $t3, 1
				addi $t2, $t2, 1
				blt $t3, 18, line_end
			la $a0, gridMessage
			la $a1, printGrid
			li $v0, 59
			syscall
			beq $s2, 2, increaseSize2
			beq $s2, 3, increaseSize3
			beq $s2, 4, increaseSize4
	# $t1 contains number of ship
	# $s0 contains array of nShip
	increaseSize2:
		addi $t1, $t1, 1
		sw $t1, 0($s0)
		subi $s1, $s1, 1
		j inpSizeofShip
	increaseSize3:
		addi $t1, $t1, 1
		sw $t1, 4($s0)
		subi $s1, $s1, 1
		j inpSizeofShip
	increaseSize4:
		addi $t1, $t1, 1
		sw $t1, 8($s0)
		subi $s1, $s1, 1
		j inpSizeofShip
	placeShipErr:
		la $a0, wrongPlaced
		la $v0, 55
		syscall
		j inpSizeofShip
	overlapErr:
		la $a0, overlapError
		li $v0, 55
		syscall
		j inpSizeofShip
	lengthofShipError:
		la $a0, lengthError
		li $v0, 55
		syscall
		j inpSizeofShip
	wrongFormat: 
		la $a0, coorError
		li $v0, 55
		syscall
		j inpSizeofShip
	inpsizeError:
		la $a0, inpSizeError
		li $v0, 55
		syscall
		j inpSizeofShip
	typeRunOut:
		la $a0, noMoreShip
		li $v0, 55
		syscall
		j inpSizeofShip
doneSetUp:
	la $a0, donePlaced
	la $v0, 55
	syscall
	beq $t0, 1, p2
	beq $t0, 2, Battle
##############################################################
# In game
Battle:
	la $a0, BattleMsg
	li $a1, 1
	li $v0, 55
	syscall
	# use $s1 to decide which player
	li $s1, 1
	# use $s3 to store cells of p1
	# use $s4 to store cells of p2
	li $s3, 16
	li $s4, 16
	chooseTurn:
	beq $s1, 1, TurnP1
	beq $s1, 2, TurnP2	
	# use s0 to store the grid
	TurnP1:
	la $s0, grid2
	la $a0, user1Attack
	la $a1, targetcell
	li $a2, 4
	li $v0, 54
	syscall
	beq $a1, -4, TargetCellErr
	# use $t0 to store inp target cell
	la $t0, targetcell
	lb $t1, 0($t0)
	lb $t2, 1($t0)
	lb $t3, 2($t0)
	subi $t1, $t1, 48
	subi $t3, $t3, 48
	bne $t2, ' ', TargetCellErr
	blt $t1, 0, TargetCellErr
	bgt $t1, 6, TargetCellErr
	blt $t3, 0, TargetCellErr
	bgt $t3, 6, TargetCellErr
	j Attack
	TurnP2:
	la $s0, grid1
	la $a0, user2Attack
	la $a1, targetcell
	li $a2, 4
	li $v0, 54
	syscall
	beq $a1, -4, TargetCellErr
	# use $t0 to store inp target cell
	la $t0, targetcell
	lb $t1, 0($t0)
	lb $t2, 1($t0)
	lb $t3, 2($t0)
	subi $t1, $t1, 48
	subi $t3, $t3, 48
	bne $t2, ' ', TargetCellErr
	blt $t1, 0, TargetCellErr
	bgt $t1, 6, TargetCellErr
	blt $t3, 0, TargetCellErr
	bgt $t3, 6, TargetCellErr
	Attack:
	beq $s1, 1, loadGrid2
	la $s2, attackGrid1
	j Shooting
	loadGrid2:
	la $s2, attackGrid2
	Shooting:
	mul $t0, $t1, 7
	add $t0, $t0, $t3
	add $t0, $t0, $s0
	lb $t4, 0($t0) #get target cell
	beq $t4, 1, HIT
	j MISS
	HIT:
	li $t4, 0
	sb $t4, 0($t0) #store 0 into grid to mark that cell has been attacked
	# mark in the attack grid
	mul $t0, $t1, 7
	add $t0, $t0, $t3
	add $t0, $t0, $s2
	li $t4, 1
	sb $t4, 0($t0)
	beq $s1, 1, decreasep2
	subi $s3, $s3, 1
	j beforePrint
	decreasep2:
	subi $s4, $s4, 1
	beforePrint:
	la $a0, hitMsg
	j printAfterAttack
	MISS:
	la $a0, missMsg
	printAfterAttack:
		# use t2 to store grid
		la $t2, printGrid
		# use t3 as index
		li $t4, '='
		li $t3, 0
			line_head1:
				sb $t4, 0($t2)
				addi $t3, $t3, 1
				addi $t2, $t2, 1
				blt $t3, 18, line_head1
				li $t4, '\n'
				sb $t4, 0($t2)
				addi $t2, $t2, 1
				# $s2 contains the grid
				li $t3, 0 # outerloop
				li $t5, 0 # innerloop
				addi $t6, $s2, 0
				make_border1:
					li $t4, '|'
					sb $t4, 0($t2)
					li $t4, ' '
					sb $t4, 1($t2)
					sb $t4, 2($t2)
					sb $t4, 3($t2)
					addi $t2, $t2, 4
					make_grid1:
						lb $t4, 0($t6)
						addi $t4, $t4, 48
						sb $t4, 0($t2)
						li $t4, ' ' 
						sb $t4, 1($t2)
						sb $t4, 2($t2)
						sb $t4, 3($t2)
						addi $t2, $t2, 4
						addi $t5, $t5, 1
						addi $t6, $t6, 1
						blt $t5, 7, make_grid1
					li $t5, 0
					addi $t3, $t3, 1
					li $t4, '|'
					sb $t4, 0($t2)
					li $t4, '\n'
					sb $t4, 1($t2)
					addi $t2, $t2, 2
					blt $t3, 7, make_border1
				li $t4, '='
				li $t3, 0
				line_end1:
				sb $t4, 0($t2)
				addi $t3, $t3, 1
				addi $t2, $t2, 1
				blt $t3, 18, line_end1
		la $a1, printGrid
		li $v0, 59
		syscall
		j whoWin
	whoWin:
	beq $s1, 1, set2
	li $v0, 15
	move $a0, $s7
	la $a1, attack
	la $a2, 8
	syscall
	li $v0, 15
	move $a0, $s7
	la $a1, targetcell
	la $a2, 3
	syscall
	li $v0, 15
	move $a0, $s7
	la $a1, el
	li $a2, 1
	syscall
	beq $s3, 0, p2Win
	li $s1, 1
	j chooseTurn
		set2:	
			li $v0, 15
			move $a0, $s6
			la $a1, attack
			la $a2, 8
			syscall
			li $v0, 15
			move $a0, $s6
			la $a1, targetcell
			la $a2, 3
			syscall
			li $v0, 15
			move $a0, $s6
			la $a1, el
			li $a2, 1
			syscall
			beq $s4, 0, p1Win
			li $s1, 2
			j chooseTurn
	p1Win:
	la $a0, Player1Win
	li $a1, 1
	li $v0, 55
	syscall
	j end
	p2Win:
	la $a0, Player2Win
	li $a1, 1
	li $v0, 55
	syscall
	j end
	TargetCellErr:
	la $a0, targetError
	li $a1, 2
	li $v0, 55
	syscall
	beq $s1, 1, TurnP1
	beq $s2, 2, TurnP2
end:	
	li $v0, 16
	move $a0, $s6
	syscall
	li $v0, 16
	move $a0, $s7
	syscall
	li $v0, 10
	syscall
