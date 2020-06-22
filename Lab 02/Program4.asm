#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​2 ​Part 4
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __main #​ ​execution​ ​starts​ ​here
__main:
	la $a0, array # $a0 address
	lw $a1, size # $a1 size
  	jal noOfUniqueElements
  	
  	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
	
# noOfUniqueElements subprogram 
#------------------------------------------------
noOfUniqueElements:
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
	
	jal bubbleSort
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $zero

	beq  $s1, $zero, return
	
	addi $s2, $s2, 0x00000001

iterator:
	beq  $s1, $zero, return 	# we have sorted everything
	lw   $t0 ,0($s0)		# first element
	lw   $t1, 4($s0)		# second element
	beq  $t0, $t1, next2
	addi $s2, $s2, 0x00000001
	
next2:
	addi $s0, $s0, 0x00000004 # increment by one the array pointer
	addi $s1, $s1, -0x00000001
	bgt  $s1, 0x00000001, iterator	
	
	
return:
	move $v0, $s2
		
	lw $ra, 0($sp)
  	addi $sp, $sp, 4
  	
  	jr $ra


# bubbleSort subprogram 
#------------------------------------------------	
bubbleSort:
	move $s0, $a0
	move $s1, $a1
	move $s2, $a1
	
comparator:
	beq $s1, $zero, ending 	# we have sorted everything
	lw  $t0 ,0($s0)		# first element
	lw  $t1, 4($s0)		# second element
	slt $t2, $t1, $t0	
	beq $t2, $zero, next	 
	sw  $t1, 0($s0)		 
	sw  $t0, 4($s0)		
			
next:
	addi $s0, $s0, 0x00000004 # increment by one the array pointer
	addi $s2, $s2, -0x00000001
	bgt  $s2, 0x00000001, comparator
	
	move $s0, $a0
	move $s2, $a1
	addi $s1, $s1, -0x00000001
	j comparator		
	
ending:
	jr $ra

#------------​ ​DATA​ ​------------------
		.data
array:		.word 4,2,3,3,5,2,5,6
size:		.word 8
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
