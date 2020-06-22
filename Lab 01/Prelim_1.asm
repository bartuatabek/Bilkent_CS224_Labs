#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​1​ ​Part 1​ ​Section​ ​1
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
	
	sw $v0, size  # compare user input if not valid ask again
	lw $t1, size
	bgt $t1, 20, sizeCheck
	
		
	la $t1, array # point to the index of the first element in array
	lw $t4, size # load array size to $t4
	
	la $a0, str1 # system call to ask the user for the array elements
	li $v0, 4
	syscall	
	
addItem:	
	li $v0, 5
	syscall
	
	sw $v0, 0($t1)
	addi $t1, $t1, 4
	addi $t4, $t4, -1
	bgt $t4, $zero, addItem # while($t4 > 0) add an item to the array
	
	
	la $t1, array # point to the index of the first element in array
	lw $t4, size
		
	la  $a0, str2 # system call to print "Display array"
    	li  $v0, 4          
    	syscall
	jal display # call display
	
	la $t1, array  # load the address of array to $t1
	lw $t2, size  # load the address of last element to $t2
	subi $t2, $t2, 1
	mul $t2, $t2, 4
	add $t2, $t2, $t1
	jal reverse
		
  	la $t1, array # point to the index of the first element in array
	lw $t4, size	
	
	la  $a0, str3 # system call to print "Display reverse array"
    	li  $v0, 4          
    	syscall
    	jal display # call display
    	
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall
	
#------------------------------------------------	
display:	
	lw $a0, ($t1)
	li $v0, 1
	syscall
	
	la  $a0, space # print space
    	li  $v0, 4          
    	syscall
	
	addi $t1, $t1, 4
	addi $t4, $t4, -1
	bgt $t4, $zero, display # while($t4 > 0)
	
reverse:
	bge $t1, $t2, done
	
	lw $t3, 0($t1)
	lw $t4, 0($t2)
	
	sw $t4, 0($t1)
	sw $t3, 0($t2)
	
	addi $t1, $t1, 4
	subi $t2, $t2, 4
	
	b reverse
	
done:
	jr $ra
		
#------------​ ​DATA​ ​------------------
	.data
array: 	.space 80
size:	.word 0
str0: 	.asciiz "Enter the size of the array: "
str1: 	.asciiz "Enter the elements of the array: \n"
str2: 	.asciiz "\nDisplay array\n"
str3: 	.asciiz "\n\nDisplay reverse array\n"
space:  .asciiz " "
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
