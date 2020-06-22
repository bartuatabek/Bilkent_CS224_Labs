#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​2 ​Part 5
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __main #​ ​execution​ ​starts​ ​here
__main:
  	  	
displayMenu:	
	la $a0, menu # system call to print menu
	li $v0, 4
	syscall	
	
	li $v0, 5
	syscall

	beq $v0, 1, callReadArray # if (input == 1) {goto readArray}
  	beq $v0, 2, callBubbleSort # if (input == 2) {goto bubbleSort}
  	beq $v0, 3, callMinMax # if(input == 3) {goto minMax}
  	beq $v0, 4, callNoOfUniqueElements # if(input == 4) {goto noOfUniqueElements}
  	beq $v0, 5, exit # if(input == 5) {goto exit}
  	j displayMenu
  	
callReadArray:
	jal readArray
	jal display 
	
	j displayMenu
	
callBubbleSort:
	move $a0, $s0
	move $a1, $s1
	
	jal bubbleSort
	jal display 
	j displayMenu

callMinMax:
	move $a0, $s0
	move $a1, $s1
	
	jal minMax
	
	move $t0, $v0
	move $t1, $v1
	
	la $a0, min # print min prompt
	li $v0, 4
	syscall
	
	li $v0, 1 # print min element
	move $a0, $t0
	syscall
	
	la $a0, max # print max prompt
	li $v0, 4
	syscall
	
	li $v0, 1 # print max element
	move $a0, $t1
	syscall
	
	j displayMenu

callNoOfUniqueElements:
	move $a0, $s0
	move $a1, $s1
	
	jal noOfUniqueElements
	
	move $t0, $v0
	
	la $a0, uniquePrompt # print min prompt
	li $v0, 4
	syscall
	
	li $v0, 1 # print min element
	move $a0, $t0
	syscall
	
    	j displayMenu
    	
# readArray subprogram
#------------------------------------------------		
 readArray:
 
 sizeCheck:	
	la $a0, prompt # system call to ask the user for the array size
	li $v0, 4
	syscall	
	
	li $v0, 5 # system call to read user input
	syscall
	
	move $s0, $v0 # compare user input if not valid ask again
	blt  $s0, 1, sizeCheck
	
allocate:
	mul  $t0, $v0, 0x00000004     # because array contains integer, I change them into bytes
	move $a0, $t0     # allocate the size of the array in the heap
	li   $v0, 9       # now, $v0 has the address of allocated memory
	syscall

	move $s1, $v0       # Because systemcall uses $vo register, I move it to $s1 keep it safe.

	move $s2, $s1      # copy the initial pointer to save array
	move $s3, $s0	
		
addRnd:		
	
	li $v0, 42            # system call to generate random int
	la $a1, 101       # where you set the upper bound
	syscall              # your generated number will be in $a0
	
	sb   $a0, 0($s2)     # put the generated number at the position pointed by $s2
	addi $s2, $s2, 0x00000004 # increment by one the array pointer
	addi $s3, $s3, -0x00000001

	bgt $s3, $zero, addRnd # while(size > 0) add an item to the array
	
	move $a0, $s1      # copy the initial pointer to save array
	move $a1, $s0
	
	move $s0, $a0 
	move $s1, $a1
	move $t0, $zero # reset registers for future use
	move $s2, $zero
	move $s3, $zero
		
	jr $ra
		
# display subprogram 
#------------------------------------------------	
display:
	move $t0, $a0    
	move $t1, $a1	
	
	la $a0, displayPrompt # print display prompt
	li $v0, 4
	syscall
	
prnlp:
	lw $a0, ($t0)
	li $v0, 1 # print list element
	syscall
	
	la $a0, space # print a newline
	li $v0, 4
	syscall
	
	addi $t0, $t0, 0x00000004 # increment by one the array pointer
	addi $t1, $t1, -0x00000001
	bgt  $t1, $zero, prnlp
	
prntdn:
	jr $ra
	
# bubbleSort subprogram 
#------------------------------------------------	
bubbleSort:
	move $t0, $a0
	move $t1, $a1
	move $t2, $a1
	
comparator:
	beq $t1, $zero, ending 	# we have sorted everything
	lw  $t3 ,0($t0)		# first element
	lw  $t4, 4($t0)		# second element
	slt $t5, $t4, $t3	
	beq $t5, $zero, next	 
	sw  $t4, 0($t0)		 
	sw  $t3, 4($t0)		
			
next:
	addi $t0, $t0, 0x00000004 # increment by one the array pointer
	addi $t2, $t2, -0x00000001
	bgt  $t2, 0x00000001, comparator
	
	move $t0, $a0
	move $t2, $a1
	addi $t1, $t1, -0x00000001
	j comparator		
	
ending:
	jr $ra
	
# minMax subprogram 
#------------------------------------------------
minMax:
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
	
	jal bubbleSort
	
	move $t0, $a0
	move $t1, $a1
	
	lw  $v0, 0($t0) # min value
	sub $t1, $t1, 0x00000001
	mul $t2, $t1, 0x00000004
	add $t0, $t0, $t2 # increment by one the array pointer
	lw  $v1, 0($t0) # max value
	
	lw   $ra, 0($sp)
  	addi $sp, $sp, 4
  	
  	jr $ra
  
# noOfUniqueElements subprogram 
#------------------------------------------------
noOfUniqueElements:
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
	
	jal bubbleSort
	
	move $t0, $a0
	move $t1, $a1
	move $t2, $zero

	beq  $t1, $zero, return
	
	addi $t2, $t2, 0x00000001

iterator:
	beq  $t1, $zero, return 	# we have sorted everything
	lw   $t3 ,0($t0)		# first element
	lw   $t4, 4($t0)		# second element
	beq  $t3, $t4, next2
	addi $t2, $t2, 0x00000001
	
next2:
	addi $t0, $t0, 0x00000004 # increment by one the array pointer
	addi $t1, $t1, -0x00000001
	bgt  $t1, 0x00000001, iterator	
	
	
return:
	move $v0, $t2
		
	lw   $ra, 0($sp)
  	addi $sp, $sp, 4
  	
  	jr $ra
	
# Exit Operation 
#------------------------------------------------
exit:
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
	
#------------​ ​DATA​ ​------------------
		.data
space:		.asciiz " "
prompt:	 	.asciiz "\nEnter the size for the array: "
displayPrompt: 	.asciiz "Displaying the array:\n"
uniquePrompt:	.asciiz "\nThe number of unique elements is: "
min:		.asciiz "\nThe min is: "
max:		.asciiz "\nThe max is: "
menu:		.asciiz "\n\nChoose an operation from the menu:\n1. Create array.\n2. Sort the array using bubble sort.\n3. Find the minimum and the maximum from the array.\n4. Find the number of unique elements in the array.\n5. Exit\n"

#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------

