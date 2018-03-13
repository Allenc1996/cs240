#Allen Chen cs240
#December 14,2016
#this program does the recursive function (n+1)*Func(n-2)
#n is enter from the user

.data
Prompt1: .asciiz "Please enter a natural number n greater than or equal to 0\n"
result: .asciiz "the answer to this function is : "
.text
main:
	#initialzing variables
	li $s1,0
	li $s2,99
While: 
	#prompt user for integer
	la $a0, Prompt1
	li $v0,4
	syscall
	
	#read int
	li $v0,5
	syscall
	
	# $s3 gets n
	move $s3,$v0 
	
	#if 99 is entered exit
	beq $s2,$s3,exit
	
	#check to see if n is a less than 0 if it is ask for another input
	slt $t1,$s3,$s1
	beq $t1,1,While
	
	#return $s3 back to $v0 
	move $v0,$s3
	#duplicate ($v0 -> $v1) = n
	move $v1,$v0
	# (a0 <- n) the parameter n for function
	move $a0,$v1

	#calls function
	jal Func
	
	#move answer stored in $v0 into $s5
	move $s5,$v0
	
	#display message result
	la $a0,result
	li $v0,4
	syscall
	
	#displays answer
	move $a0,$s5
	li $v0,1
	syscall

exit:
	#exits program
	li $v0,10
	syscall		
	
Func:	
	#allocate space and saved in stack (2 word)
	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $s4,4 ($sp)
	
	#base case if n equal 0,or n = 1 return func(n) = 4
	li $v0,4
	beq $a0,$zero,Done
	beq $a0,1,Done
	
	#make n = (n+1)
	addi $a0,$a0,1
	
	#move (n+1) to the stack
	move $s4,$a0	
	
	#Func(n-2) 
	addi $a0,$a0,-3
	
	#recursive step until base case is reach
	jal Func
	
	#return (n+1)*func(n-2) stored in $v0
	mul $v0,$s4,$v0
Done:
	#deallocate stack and return value
	lw $ra,0($sp)
	lw $s4,4($sp)
	addi $sp,$sp,8
	jr $ra
	
