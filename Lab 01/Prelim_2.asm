#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​1​ ​Part 1​ ​Section​ ​2 (c-d) % 2
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __start #​ ​execution​ ​starts​ ​here
__start:

	la $a0, str0 # system call code for read_int c
	li $v0, 4          
  	syscall 
  	
  	li $v0, 5
  	syscall
  	sw $v0, c
  	lw $t0, c
  	
  	
  	la $a0, str1 # system call code for read_int d
	li $v0, 4         
  	syscall
  	
  	li $v0, 5
  	syscall
  	sw $v0, d 
  	lw $t1,d                
	
	# expression operations
  	sub $t2, $t0, $t1 # operation (c-d)
  	rem $t3, $t2, 2 # operation % 2
  	sw $t3, x
  	
  	# system call to print the result
  	la $a0, str2
	li $v0, 4          
  	syscall 
  	
	li $v0, 1  
	move $a0, $t3        
  	syscall

	li $v0,10  # system call to exit
	syscall

#------------​ ​DATA​ ​------------------
	.data
x:  	.word 0
c:  	.word 0
d:  	.word 0
str0: 	.asciiz "Enter c: "
str1: 	.asciiz "Enter d: "
str2: 	.asciiz "x = "
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
