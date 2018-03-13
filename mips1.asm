.data 
Prompt1: .asciiz"\nPlease enter first integer between 0 and 20:\n" 
Prompt2: .asciiz"\nPlease enter second integer between -10 and 15:\n"
Prompt3: .asciiz"Your numbers in increasing order are:\n"
comma: .asciiz","
resultP: .asciiz"\nthe result is a positive number equal to:\n"
resultN: .asciiz"\nthe result is a negative number equal to:\n"

.text
While:
	#declare int value
	li $s0, 1
	li $s1, 20
	li $s3, -10
	li $s4, 15
	li $s7,999
Label1:
	#prompt user for first integer between 0 and 20
	la $a0,Prompt1
	li $v0,4
	syscall 
	#read first integer and store it in register $s2
	li $v0,5
	syscall
	move $s2,$v0 
	beq $s7,$s2,exit
	#check if integer is less than 1 or greather than 20
	slt $t1,$s2,$s0
	beq $t1,1,Label1
	sgt $t1,$s2,$s1 
	beq $t1,1,Label1
Label2:
	#promt user for second integer bettween -10 and 20
	la $a0,Prompt2
	li $v0,4
	syscall
	#read second integer and store it in $s5
	li $v0,5
	syscall
	move $s5,$v0
	beq $s7,$s5,exit
	#check if seocnd integer is less than -10 or greater than 15
	slt $t1,$s5,$s3
	beq $t1,1,Label2
	sgt $t1,$s5,$s4
	beq $t1,1,Label2
	#check which two of the integer if greater
	slt $t1,$s5,$s2
	beq $t1,1,Label3
	beq $t1,$zero,Label4
Label3:
	#print out prompt 3
	la $a0,Prompt3
	li $v0,4
	syscall
	#print out integer from smallest to largest
	move $a0,$s5
	li $v0,1
	syscall
	#comma
	la $a0,comma
	li $v0,4
	syscall
	#larger number
	move $a0,$s2
	li $v0,1
	syscall
	j Label5
Label4:
	#print out prompt 3
	la $a0,Prompt3
	li $v0,4
	syscall
	#print out integer from smallest to largest
	move $a0,$s2
	li $v0,1
	syscall
	#comma
	la $a0,comma
	li $v0,4
	syscall
	#larger number
	move $a0,$s5
	li $v0,1
	syscall
Label5:
	#int1 - 16*int2
	sll $s5,$s5,4
	sub $s6,$s2,$s5
	#check if positive or negative
	li $t0,0
	slt $t1,$s6,$t0
	beq $t1,1,resultNeg
	j resultPos
resultNeg:
	#print our result negative
	la $a0,resultN
	li $v0,4
	syscall
	#print out number
	move $a0,$s6
	li $v0,1
	syscall
	j While
resultPos:
	#print our result positive
	la $a0,resultP
	li $v0,4
	syscall
	#print out number
	move $a0,$s6
	li $v0,1
	syscall
	j While
exit:
	#exit
	li $v0,10
	syscall