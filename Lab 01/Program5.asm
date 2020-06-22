#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​1​ ​Part 5
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __start #​ ​execution​ ​starts​ ​here
__start:
	
sizeCheck:	
	la $a0, str0 # system call to ask the user for the array size
	li $v0, 4
	syscall	
	
	li $v0, 5 # system call to read user input
	syscall
	
	sw $v0, size # compare user input if not valid ask again
	lw $t0, size # load array size to $t1
	bgt $t0, 100, sizeCheck
	blt $t0, 1, sizeCheck
			
	la $t1, array # point to the index of the first element in array
	
	la $a0, str1 # system call to ask the user for the array elements
	li $v0, 4
	syscall	
	
addItem:	
	li $v0, 5 # system call to read user input
	syscall
	
	sw $v0, 0($t1) # storing array element
	addi $t1, $t1, 4
	addi $t0, $t0, -1
	bgt $t0, $zero, addItem # while(size > 0) add an item to the array
	
displayMenu:	
	la $a0, menu # system call to print menu
	li $v0, 4
	syscall	
	
	li $v0, 5
	syscall

	beq $v0, 1, operation1 # if (input == 1) {goto sum}
    	beq $v0, 2, operation2 # if (input == 2) {goto sum_2}
  	beq $v0, 3, operation3 # if (input == 3) {goto occurence}
  	beq $v0, 4, exit # if(input == 4) {goto exit}
  	b displayMenu
  	jr $ra

# Operation 1
#------------------------------------------------
operation1:
   	la $a0, str2 # system call to ask for user input
	li $v0, 4
	syscall	
	
   	li $v0, 5 # system call to read user input
	syscall
		
	lw $t0, size # load array size to $t1
	la $t1, array # point to the index of the first element in array
	move $t2, $zero	# sum of numbers initialized as 0
	move $t3, $v0 # move user input to $t3
		
whileOp1:
	beq $t0, $zero, endOperation1
	lw $t4, 0($t1)
	bgt $t4, $t3, addToSum
	addi $t0, $t0, -1
	addi $t1, $t1, 4
	j whileOp1
	
addToSum:
	add $t2, $t2, $t4
	addi $t0, $t0, -1
	addi $t1, $t1, 4
	j whileOp1
	
endOperation1:
	la $a0, str3 # system call to print results
	li $v0, 4
	syscall	
	
	li $v0, 1
    	move $a0, $t2
  	syscall
  	
  	jal displayMenu
  	
# Operation 2
#------------------------------------------------	
operation2:
	lw $t0, size
	la $t1, array
	move $t2, $zero	# sum of even numbers initialized as 0
	move $t3, $zero	# sum of odd numbers initialized as 0
	
whileOp2:
	beq $t0, $zero, endOperation2
	lw $t4, 0($t1)
	rem $t5, $t4, 2
	beq $t5, $zero, even
	add $t3, $t3, $t4
	addi $t0, $t0, -1
	addi $t1, $t1, 4
	j whileOp2
	
even:
	add $t2, $t2, $t4
	addi $t0, $t0, -1
	addi $t1, $t1, 4
	j whileOp2
	
endOperation2:
	la $a0, str4 # system call to print results
	li $v0, 4
	syscall	
	
	li $v0, 1
    	move $a0, $t2
  	syscall
  	
  	la $a0, str5 # system call to print results
	li $v0, 4
	syscall	
	
	li $v0, 1
    	move $a0, $t3
  	syscall
  	
  	jal displayMenu
  
# Operation 3
#------------------------------------------------	
operation3:
    	la $a0, str2 # system call to ask for user input
	li $v0, 4
	syscall	
	
   	li $v0, 5 # system call to get user input
	syscall
	
	lw $t0, size
	la $t1, array
	move $t2, $zero	# sum of even numbers initialized as 0
	move $t3, $v0	# input number
	
whileOp3:
	beq $t0, $zero, endOperation3
	lw $t4, 0($t1) # load current element to $t4
	rem $t5, $t4, $t3 # find the remainder 
	beq $t5, $zero, divisible # if current element is divisible by the input number go to divisible
	addi $t0, $t0, -1
	addi $t1, $t1, 4
	j whileOp3
	
divisible:
	addi $t2, $t2, 1 # add 1 to number of occurrences
	addi $t0, $t0, -1
	addi $t1, $t1, 4
	j whileOp3
	
endOperation3:
	la $a0, str6 # system call to print results
	li $v0, 4
	syscall	
	
	li $v0, 1
    	move $a0, $t2
  	syscall
  	
  	jal displayMenu
  
# Exit Operation 
#------------------------------------------------
exit:
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
	
#------------​ ​DATA​ ​------------------
	.data
array: 	.space 400
size:	.word 0
str0: 	.asciiz "Enter the size of the array: "
str1: 	.asciiz "Enter the elements: \n"
str2:	.asciiz "Enter a number: "
str3: 	.asciiz "Summation of numbers greater than input numbers is: "
str4: 	.asciiz "\nSummation of even numbers is: "
str5: 	.asciiz "\nSummation of odd numbers is: "
str6:	.asciiz "\nNumber of occurences of the array elements divisible by a certain input number is: "
menu:	.asciiz "\n\nChoose an operation from the menu:\n1. Find summation of numbers stored in the array which is greater than an input number.\n2. Find summation of even and odd numbers and display them.\n3. Display the number of occurrences of the array elements divisible by a certain input number.\n4. Quit\n"
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
