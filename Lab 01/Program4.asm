#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​1​ ​Part 4
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __main #​ ​execution​ ​starts​ ​here
__main:

#  Input Operations
#------------------------------------------------
	la $a0, str0 # system call to ask for user input
	li $v0, 4
	syscall	
	
   	li $v0, 5 # system call to read user input
	syscall
	move $s0, $v0 # move a to $s0
	
	la $a0, str1 # system call to ask for user input
	li $v0, 4
	syscall	
	
   	li $v0, 5 # system call to read user input
	syscall
	move $s1, $v0 # move b to $s1
	
	la $a0, str2 # system call to ask for user input
	li $v0, 4
	syscall	
	
   	li $v0, 5 # system call to read user input
	syscall
	move $s2, $v0 # move c to $s2
	
	la $a0, str3 # system call to ask for user input
	li $v0, 4
	syscall	
	
   	li $v0, 5 # system call to read user input
	syscall
	move $s3, $v0 # move d to $s3
	
	la $a0, str4 # system call to ask for user input
	li $v0, 4
	syscall	
	
   	li $v0, 5 # system call to read user input
	syscall
	move $s4, $v0 # move e to $s4

#  Arithmetic Operations
#------------------------------------------------
operations:
	div $t5, $s0, $s1 # operation: '(A/B)'
	add $t6, $s2, $s3 # operation: '(C+D)'
	sub $t7, $t5, $t6 # operation: '(A/B) - (C+D)'
	rem $t8, $t7, $s4 # operation: '(A/B) - (C+D) % E'

	la $a0, str5 # system call to print results notifier
	li $v0, 4
	syscall	
	
   	li $v0, 1 # system call to print the result
    	move $a0, $t8 # move the results from $t8 to $a0
  	syscall

# Exit Operation 
#------------------------------------------------
exit:
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
	
#------------​ ​DATA​ ​------------------
	.data
str0:	.asciiz "Enter a: "
str1:	.asciiz "Enter b: "
str2:	.asciiz "Enter c: "
str3:	.asciiz "Enter d: "
str4:	.asciiz "Enter e: "
str5:	.asciiz "The result of the operation '((A/B)-(C+D))%E' is: "
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
