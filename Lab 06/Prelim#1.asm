#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​6 ​Part 1.5
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl main #​ ​execution​ ​starts​ ​here
main:
  	  	
displayMenu:	
	la $a0, menu # system call to print menu
	li $v0, 0x4
	syscall	
	
	li $v0, 0x5
	syscall

	beq $v0, 0x1, callReadSize            # if (input == 1) {goto readSize}
  	beq $v0, 0x2, callAllocate            # if (input == 2) {goto allocate}
  	beq $v0, 0x3, callDisplayElement      # if (input == 3) {goto displayElement}
  	beq $v0, 0x4, callRowMajorSum         # if (input == 4) {goto rowMajorSum}
  	beq $v0, 0x5, callColumnMajorSum      # if (input == 5) {goto columnMajorSum}
  	beq $v0, 0x6, callDisplayLocation     # if (input == 6) {goto noOfUniqueElements}
  	beq $v0, 0x7, exit                    # if (input == 7) {goto exit}
  	j displayMenu
  	
callReadSize:
	jal readSize	
	j displayMenu
	
callAllocate:
	jal allocateArray 
	jal display
	j displayMenu
	
callDisplayElement:
	jal displayElement
	j displayMenu
	
callRowMajorSum:
	jal rowMajorSum
	j displayMenu
	
callColumnMajorSum:
	jal columnMajorSum
	j displayMenu
	
callDisplayLocation:
	jal displayLocation
	j displayMenu
    	
# readSize subprogram
#------------------------------------------------ 	
readSize:	
	la $a0, prompt          # system call to ask the user for the array size
	li $v0, 0x4
	syscall	
	
	li $v0, 0x5             # system call to read user input
	syscall
	
	blt  $v0, 0x1, readSize # compare user input if not valid ask again
	move $s0, $v0 
	
	jr $ra

    	
# readArray subprogram
#------------------------------------------------		
allocateArray:
	mul  $t0, $s0, $s0
	mul  $t0, $s0, 0x4   
	move $a0, $t0         # allocate the size of the array in the heap
	li   $v0, 0x9         # now, $v0 has the address of allocated memory
	syscall   

	move $s1, $v0      
	move $s2, $s1         # copy the initial pointer to save array
	mul  $s3, $s0, $s0	
	
	li $t0, 0x1		
init:			
	sw   $t0, 0($s2)      # put the generated number at the position pointed by $s2
	addi $s2, $s2, 0x4    # increment by one the array pointer
	subi $s3, $s3, 0x1
	addi $t0, $t0, 0x1

	bgt $s3, $zero, init  # while(size > 0) add an item to the array
	
	move $t0, $zero       # reset registers for future use
	move $s2, $zero
	move $s3, $zero
		
	jr $ra
													
# display subprogram 
#------------------------------------------------	
display:
	move $t0, $s1    
	mul  $t1, $s0, $s0
	li   $t2, 0x1	
	
prnlp:
	lw $a0, ($t0)
	li $v0, 0x1           # print list element
	syscall
	
	la $a0, space         # print space
	li $v0, 0x4
	syscall
		
	rem  $t3, $t2, $s0
	bnez $t3, iterate
	 
	la $a0, newln         # print space
	li $v0, 0x4
	syscall
	
iterate:	
	addi $t0, $t0, 0x4    # increment by one the array pointer
	subi $t1, $t1, 0x1
	addi $t2, $t2, 0x1
	bgt  $t1, $zero, prnlp
	
prntdn:
	jr $ra
	
# displayElement subprogram 
#------------------------------------------------
displayElement:
	la $a0, prompt3
	li $v0, 0x4
	syscall	
	
	li   $v0, 0x8          # take in input
        la   $a0, buffer       # load byte space into address
        li   $a1, 0x14         # allot the byte space for string
        move $t0, $a0          # save string to t0
        syscall	
         
        move $a1, $t0
	addu $a1, $a1, 0x1   
	lbu  $t1, ($a1)
	subi $t1, $t1, 0x30      
	
	move $a1, $t0
	addu $a1, $a1, 0x3   
	lbu  $t2, ($a1)  
	subi $t2, $t2, 0x30    
	
	# (i - 1) x N x 4 + (j - 1) x 4
	subi $t1, $t1, 0x1    
	mul  $t3, $s0, 0x4
	mul  $t3, $t3, $t1 
	subi $t2, $t2, 0x1
	mul  $t2, $t2, 0x4
	add  $t3, $t3, $t2
	
	la $a0, prompt4
	li $v0, 0x4
	syscall	
	
	move $t0, $s1
	add $t0, $t0, $t3    # increment by one the array pointer
	
	lw $a0, ($t0)
	li $v0, 0x1          # print list element
	syscall
	
	jr $ra	
	
# rowMajorSum subprogram 
#------------------------------------------------
rowMajorSum:
	move $t0, $s1    
	mul  $t1, $s0, $s0
	li   $t2, 0x0 	
	
sumlp:
	lw  $a0, ($t0)
	add $t2, $t2, $a0
		
	addi $t0, $t0, 0x4    # increment by one the array pointer
	subi $t1, $t1, 0x1
	bgt  $t1, $zero, sumlp
	
sumdn:
	la $a0, rowMajor
	li $v0, 0x4
	syscall	
	
	move $a0, $t2
	li   $v0, 0x1          
	syscall
	
	jr $ra
	
# columnMajorSum subprogram 
#------------------------------------------------
columnMajorSum:
	li $t0, 0x1 # i
	li $t1, 0x1 # j
	move $t2, $zero # sum
	move $t3, $s1   # array ptr

iter:
	sub  $t4, $t0, 0x1
	mul  $t5, $s0, 0x4
	mul  $t4, $t4, $t5
	
	sub  $t6, $t1, 0x1
	mul  $t6, $t6, 0x4
	add  $t4, $t4, $t6
	
	add  $t3, $t3, $t4    
	lw   $a0, ($t3)
	add  $t2, $t2, $a0

	addi $t0, $t0, 0x1
	move $t3, $s1 
	subi $t7, $t0, 0x1 
	bne  $t7, $s0, iter
	
	li   $t0, 0x1 
	addi $t1, $t1, 0x1
	subi $t8, $t1, 0x1 
	bne  $t8, $s0, iter
	
sumdn2:
	la $a0, columnMajor
	li $v0, 0x4
	syscall	
	
	move $a0, $t2
	li   $v0, 0x1          
	syscall
	
	jr $ra
	
# displayLocation subprogram 
#------------------------------------------------
displayLocation:
	la $a0, prompt5          # system call to ask the user for the element
	li $v0, 0x4
	syscall	
	
	li $v0, 0x5              # system call to read user input
	syscall
	
	move $t0, $v0
	move $t1, $s1    
	mul  $t2, $s0, $s0
	li   $t3, 0x1	 # i
	li   $t4, 0x1	 # j
	
searchlp:
	lw  $a0, ($t1)
	beq $a0, $t0, searchdn 
			
	addi $t1, $t1, 0x4    # increment by one the array pointer
	subi $t2, $t2, 0x1
	
	beq  $t4, $s0, restore
	addi $t4, $t4, 0x1 # j++
	bgt  $t2, $zero, searchlp
		
restore:
	addi $t3, $t3, 0x1 # i++
	li   $t4, 0x1	   # j
	bgt  $t2, $zero, searchlp
	
error:	la $a0, prompt7        
	li $v0, 0x4
	syscall	
	
	jr $ra
	
searchdn:
	la $a0, prompt6        
	li $v0, 0x4
	syscall	
	
	move $a0, $t3
	li   $v0, 0x1          
	syscall
	
	la $a0, comma        
	li $v0, 0x4
	syscall	
	
	move $a0, $t4
	li   $v0, 0x1          
	syscall
	
	jr $ra
	
# Exit Operation 
#------------------------------------------------
exit:
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
	
#------------​ ​DATA​ ​------------------
		.data
buffer:		.space 10
space:		.asciiz " "
comma:		.asciiz ", "
newln:		.asciiz "\n"
prompt:	 	.asciiz "Enter the matrix size in terms of dimensions (N): "
prompt2: 	.asciiz "Matrix allocated and initialized."
prompt3:	.asciiz "Enter the matrix element to be accessed (i,j): "
prompt4:	.asciiz "The element is: "
prompt5:	.asciiz "Enter the element to be located:  "
prompt6:	.asciiz "The element is at the location:  "
prompt7:	.asciiz "The element is not in the matrix."
rowMajor:	.asciiz "Row-major (row by row) summation of the matrix elements is: "
columnMajor:	.asciiz "Column-major (column by column) summation of the matrix elements is: "
menu:		.asciiz "\nChoose an operation from the menu:\n1. Ask the user the matrix size in terms of its dimensions (N),\n2. Allocate and initialize matrix,\n3. Access matrix element and display the content,\n4. Obtain summation of matrix elements row-major,\n5. Obtain summation of matrix elements column-major,\n6. Display desired elements of the matrix by specifying its row and column member,\n7. Exit.\n"
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
