.data
prompt1: .asciiz"Enter Size:\n"
println: .asciiz"for j equal "
toeq: .asciiz", total equals "
endl: .asciiz"\n"
.text
main:
	#declare value
	li $s0,1 
	#prompts user to enter size
	la $a0,prompt1
	li $v0,4
	syscall
	#read integer size and store in $s1
	li $v0,5
	syscall
	move $s1,$v0	
forloop:
	#add j and size store in total
	add $s2,$s0,$s1
	#if j = size exit
	beq $s0,$s1,done 
	#print out 
	la $a0,println
	li $v0,4
	syscall
	#print out j
	move $a0,$s0
	li $v0,1
	syscall
	#print out total equal
	la $a0,toeq
	li $v0,4
	syscall
	#print out total
	move $a0,$s2
	li $v0,1
	syscall
	#endl
	la $a0,endl
	li $v0,4
	syscall
	#see if j is less than size
	slt $t0,$s0,$s1
	#if j is not equal to size jump to l1
	beq $t0,1,l1
l1:
	#increase j by 1 and goes back to forloop
	addi $s0,$s0,1
	j forloop
done:	
	#exits
	li $v0,10
	syscall	
	
	
		