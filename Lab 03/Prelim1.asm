#​ ​-----------​ ​HEADING​ ​--------------- 
#​ MIPS ​program with user interface to calculate the product
# of two positive integers and the summation of numbers from 1
# to n.
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __main #​ ​execution​ ​starts​ ​here
__main:
  	  	
displayMenu:	
	la $a0, menu # system call to print menu
	li $v0, 4
	syscall	
	
	li $v0, 5 # system call to read user input
	syscall

	beq $v0, 1, callRecursiveMultiplication # if (input == 1) {goto recursiveMultiplication}
  	beq $v0, 2, callRecursiveSummation      # if (input == 2) {goto recursiveSummation}
  	beq $v0, 3, exit 			# if(input == 3) {goto exit}
  	j displayMenu
  	
callRecursiveMultiplication:
	la $a0, prompt1 # system call to print prompt
	li $v0, 4
	syscall	
	
	li $v0, 5 # system call to read user input
	syscall
	move $t0, $v0
	
	la $a0, prompt2 # system call to print prompt
	li $v0, 4
	syscall	
	
	li $v0, 5 # system call to read user input
	syscall
	move $t1, $v0
	
	move $a0, $t0 		     # move the first number and the second number to
	move $a1, $t1		     # $a0, $a1 as parameters
	jal  recursiveMultiplication # call the subprogram
	sw   $v0, result             # save the output to result
	
	la $a0, prompt4 # system call to print prompt
	li $v0, 4
	syscall	
	
	lw $a0, result # system call to print result
	li $v0, 1 
	syscall
	
	j displayMenu
  		
callRecursiveSummation:
	la $a0, prompt3 # system call to print prompt
	li $v0, 4
	syscall	
	
	li $v0, 5 # system call to read user input
	syscall

	move $a0, $v0           # move the number to $a0 as parameter
	jal  recursiveSummation # call the subprogram
	sw   $v0, result        # save the output to result
	
	la $a0, prompt4 # system call to print prompt
	li $v0, 4
	syscall	
	
	lw $a0, result # system call to print result
	li $v0, 1 
	syscall
	
	j displayMenu 	
  	
# Exit Operation 
#------------------------------------------------
exit:
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	

# recursiveMultiplication subprogram
#------------------------------------------------	
recursiveMultiplication:
	addi $sp, $sp, -8 # make room on stack for 2 new items
	sw   $a0, 4($sp)  # push $a0 value onto stack
	sw   $ra, 0($sp)  # push $ra value onto stack
	 
	beq $a0, $zero, zero # if either of the inputs are zero
	beq $a1, $zero, zero # return zero as result 
	
	subi $a1, $a1, 1              # decrement the value in $a1 by 1
	jal  recursiveMultiplication  # recursive call to subprogram
	
	lw   $ra, 0($sp)   # restore $ra value from stack
	lw   $a0, 4($sp)   # restore $a0 value from stack
	addi $sp, $sp, 8   # restore $sp to original value (i.e. pop 2 items)
	add  $v0, $a0, $v0 # add result to $v0
	jr   $ra
	
zero:	
	move $v0, $zero  # load zero to $v0 
	addi $sp, $sp, 8 # restore $sp to original value (i.e. pop 2 items)
	jr   $ra	

# recursiveSummation subprogram
#------------------------------------------------
recursiveSummation:
	addi $sp, $sp, -8 # make room on stack for 2 new items
	sw   $a0, 4($sp)  # push $a0 value onto stack
	sw   $ra, 0($sp)  # push $ra value onto stack
	
	bgt  $a0, 1, else # if input is greater than 1 go to else
	
	addi $v0, $zero, 1 # add result to $v0
	addi $sp, $sp, 8   # restore $sp to original value (i.e. pop 2 items)
	jr   $ra
	
else:
	addi $a0, $a0, -1       # decrement the input
	jal  recursiveSummation # recursive call to subprogram
	lw   $ra, 0($sp)        # restore $ra value from stack
	lw   $a0, 4($sp)        # restore $a0 value from stack
	addi $sp, $sp, 8        # restore $sp to original value (i.e. pop 2 items)
	add  $v0, $a0, $v0      # add result to $v0
	jr   $ra
		
#------------​ ​DATA​ ​------------------
		.data
result:		.word 0
prompt1:	.asciiz "Enter the first number: "
prompt2:	.asciiz "Enter the second number: "
prompt3:	.asciiz "Enter a number: "
prompt4:	.asciiz "The result is: "
menu:		.asciiz "\nChoose an operation from the menu:\n1. Recursive multiplication\n2. Recursive summation\n3. Exit\n"
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
