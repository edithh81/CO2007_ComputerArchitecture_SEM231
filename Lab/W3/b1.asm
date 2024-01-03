.data
promt: .asciiz "Please choose which shape to calculate volume or total surface area\n Press:\n 1. Rectangular box\n 2. Cube\n 3. Cyclinder \n 4. Sphere \n 5. Rectangular Pyramid\n"
yourChoice: .asciiz "Your choice: "
inpInstr: .asciiz "Please choose which to calculate:\n 1.Volume\n 2.Total surface area\n"
errType: .asciiz "You have not chosen a valid value. Please enter again!\n"
negerr: .asciiz "Input value was negative. Please enter again!\n"
inpRecBox: .asciiz "Please input the parameters of Rectangular box: \n"
inpCube: .asciiz "Please input the parameters of Cube: \n"
inpCyclinder: .asciiz "Please input the parameters of Cyclinder: \n"
inpSphere: .asciiz "Please input the parameters of Sphere: \n"
inpRecPyra: .asciiz "Please input the parameters of Rectangular Pyramid: \n"
RecBoxlength: .asciiz "Length: "
RecBoxwidth: .asciiz "Width: "
RecBoxheight: .asciiz "Height: "
Cyclinderradius: .asciiz "Radius: "
volmsg: .asciiz "Volume is: "
tsamsg: .asciiz "Total surface area is: "
lowerbound: .float 0.0
base: .float 1.0
pi: .float 3.14
four: .float 4.0
three: .float 3.0
six: .float 6.0
two: .float 2.0
.text
inpType:
lwc1 $f10, lowerbound
la $a0, promt
li $v0, 4
syscall
la $a0, yourChoice
li $v0, 4
syscall
li $v0, 5
syscall
blt $v0, 1, errorType
bgt $v0, 5, errorType
move $s0, $v0 # s0 contains the inp type
beq $s0, 1, RecBox
beq $s0, 2, Cube
beq $s0, 3, Cyclinder
beq $s0, 4, Sphere
beq $s0, 5, RecPyramid
errorType:
	la $a0, errType
	li $v0, 4
	syscall
	j inpType
RecBox:
	la $a0, inpRecBox
	li $v0, 4
	syscall
	la $a0, RecBoxlength
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	# f1 contains length
	mov.s $f1, $f0
	c.le.s $f1, $f10
	bc1t negparameter
	la $a0, RecBoxwidth
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	# f2 contains width
	mov.s $f2, $f0
	c.le.s $f2, $f10
	bc1t negparameter
	la $a0, RecBoxheight
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	# f2 contains height
	mov.s $f3, $f0
	c.le.s $f3, $f10
	bc1t negparameter
	recbox1:
	la $a0, inpInstr
	li $v0, 4
	syscall
	la $a0, yourChoice
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 1, errCal
	bgt $t1, 2, errCal
	beq $t1, 1, volRC
	beq $t1, 2, tcaRC
	volRC:
		lwc1 $f4, base
		mul.s $f4, $f1, $f2
		mul.s $f4, $f4, $f3
		la $a0, volmsg
		li $v0, 4
		syscall
		mov.s $f12, $f4
		li $v0, 2
		syscall
		j end
	tcaRC:
		lwc1 $f4, base
		mul.s $f4, $f1, $f2
		add.s $f4, $f4, $f4
		mul.s $f5, $f1, $f3
		add.s $f5, $f5, $f5
		mul.s $f6, $f2, $f3
		add.s $f6, $f6, $f6
		add.s $f4, $f4, $f5
		add.s $f4, $f4, $f6
		la $a0, tsamsg
		li $v0, 4
		syscall
		mov.s $f12, $f4
		li $v0, 2
		syscall
		j end
Cube:
	la $a0, inpCube
	li $v0, 4
	syscall
	la $a0, RecBoxlength
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	c.le.s $f0, $f10
	bc1t negparameter
	cube1:
	la $a0, inpInstr
	li $v0, 4
	syscall
	la $a0, yourChoice
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 1, errCal
	bgt $t1, 2, errCal
	beq $t1, 1, volCube
	beq $t1, 2, tcaCube
	volCube:
		mul.s $f1, $f0, $f0
		mul.s $f1, $f1, $f0
		la $a0, volmsg
		li $v0, 4
		syscall
		mov.s $f12, $f1
		li $v0, 2
		syscall
		j end
	tcaCube:
		mul.s $f1, $f0, $f0
		lwc1 $f2, six
		mul.s $f1, $f1, $f2
		la $a0, tsamsg
		li $v0, 4
		syscall
		mov.s $f12, $f1
		li $v0, 2
		syscall
		j end
Cyclinder:
	la $a0, inpCyclinder
	li $v0, 4
	syscall
	la $a0, RecBoxheight
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f1, $f0
	c.le.s $f1, $f10
	bc1t negparameter
	la $a0, Cyclinderradius
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f2, $f0
	c.le.s $f2, $f10
	bc1t negparameter
	cyclinder1:
	la $a0, inpInstr
	li $v0, 4
	syscall
	la $a0, yourChoice
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 1, errCal
	bgt $t1, 2, errCal
	beq $t1, 1, volCyclinder
	beq $t1, 2, tcaCyclinder
	volCyclinder:
		# get pi number
		lwc1 $f0, pi
		mul.s $f2, $f2, $f2
		mul.s $f0, $f0, $f1
		mul.s $f0, $f0, $f2
		la $a0, volmsg
		li $v0, 4
		syscall
		mov.s $f12, $f0
		li $v0, 2
		syscall
		j end
	tcaCyclinder:
		lwc1 $f0, pi
		mul.s $f0, $f0, $f2
		add.s $f0, $f0, $f0
		add.s $f3, $f1, $f2
		mul.s $f0, $f0, $f3
		la $a0, tsamsg
		li $v0, 4
		syscall
		mov.s $f12, $f0
		li $v0, 2
		syscall
		j end
Sphere:
	la $a0, inpSphere
	li $v0, 4
	syscall
	la $a0, Cyclinderradius
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f2, $f0
	c.le.s $f2, $f10
	bc1t negparameter
	sphere1:
	la $a0, inpInstr
	li $v0, 4
	syscall
	la $a0, yourChoice
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 1, errCal
	bgt $t1, 2, errCal
	beq $t1, 1, volSphere
	beq $t1, 2, tcaSphere
	volSphere:
		lwc1 $f0, pi
		mul.s $f1, $f2, $f2
		mul.s $f1, $f2, $f1
		mul.s $f0, $f0, $f1
		lwc1 $f3, four
		mul.s $f0, $f0, $f3
		lwc1 $f3, three
		div.s $f0, $f0, $f3
		la $a0, volmsg
		li $v0, 4
		syscall
		mov.s $f12, $f0
		li $v0, 2
		syscall
		j end
	tcaSphere:
		lwc1 $f0, pi
		mul.s $f1, $f2, $f2
		mul.s $f0, $f0, $f1
		lwc1 $f3, four
		mul.s $f0, $f0, $f3
		la $a0, tsamsg
		li $v0, 4
		syscall
		mov.s $f12, $f0
		li $v0, 2
		syscall
		j end
RecPyramid:
	la $a0, inpRecPyra
	li $v0, 4
	syscall
	la $a0, RecBoxlength
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	# f1 contains length
	mov.s $f1, $f0
	c.le.s $f1, $f10
	bc1t negparameter
	la $a0, RecBoxwidth
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	# f2 contains width
	mov.s $f2, $f0
	c.le.s $f2, $f10
	bc1t negparameter
	la $a0, RecBoxheight
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	# f3 contains height
	mov.s $f3, $f0
	c.le.s $f3, $f10
	bc1t negparameter
	recpyra1:
	la $a0, inpInstr
	li $v0, 4
	syscall
	la $a0, yourChoice
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 1, errCal
	bgt $t1, 2, errCal
	beq $t1, 1, volRecpyra
	beq $t1, 2, tcaRecpyra
	volRecpyra:
	mul.s $f1, $f1, $f2
	mul.s $f3, $f1, $f3
	lwc1 $f4, three
	div.s $f3, $f3, $f4
	la $a0, volmsg
		li $v0, 4
		syscall
		mov.s $f12, $f3
		li $v0, 2
		syscall
		j end
	tcaRecpyra:
	# formula S = l*w + sqrt(w^2/4 + h^2)*l + sqrt(l^2/4 + h^2)*w
	# s1 = l*w
	mul.s $f4, $f1, $f2
	# s2 = sqrt(w^2/4 + h^2)*l
	mul.s $f5, $f2, $f2
	lwc1 $f6, four
	div.s $f5, $f5, $f6
	mul.s $f7, $f3, $f3
	add.s $f5, $f5, $f7
	sqrt.s $f5, $f5
	mul.s $f5, $f5, $f1
	# s3 = sqrt(l^2/4 + h^2)*w
	mul.s $f6, $f1, $f1
	lwc1 $f7, four
	div.s $f6, $f6, $f7
	mul.s $f8, $f3, $f3
	add.s $f6, $f8, $f6
	sqrt.s $f6, $f6
	mul.s $f6, $f6, $f2
	# sum
	add.s $f4, $f4, $f5
	add.s $f4, $f4, $f6
	la $a0, tsamsg
		li $v0, 4
		syscall
		mov.s $f12, $f4
		li $v0, 2
		syscall
		j end
negparameter:
	la $a0, negerr
	li $v0, 4
	syscall
	beq $s0, 1, RecBox
	beq $s0, 2, Cube
	beq $s0, 3, Cyclinder
	beq $s0, 4, Sphere
	beq $s0, 5, RecPyramid
errCal:
	la $a0, errType
	li $v0, 4
	syscall
	beq $s0, 1, recbox1
	beq $s0, 2, cube1
	beq $s0, 3, cyclinder1
	beq $s0, 4, sphere1
	beq $s0, 5, recpyra1
end:
	li $v0, 10
	syscall
