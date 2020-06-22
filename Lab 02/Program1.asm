#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​2 ​Part 1
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __main #​ ​execution​ ​starts​ ​here
__main:
  	jal readArray
  	jal display
  	
  	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
    	
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
	blt $s0, 1, sizeCheck
	
allocate:
	mul $t0, $v0, 0x00000004     # because array contains integer, I change them into bytes
	move $a0, $t0     # allocate the size of the array in the heap
	li $v0, 9       # now, $v0 has the address of allocated memory
	syscall

	move $s1, $v0       # Because systemcall uses $vo register, I move it to $v1 keep it safe.

	move $s2, $s1      # copy the initial pointer to save array
	move $s3, $s0	
		
addRnd:		
	
	li $v0, 42            # system call to generate random int
	la $a1, 101       # where you set the upper bound
	syscall              # your generated number will be in $a0
	
	sb $a0, 0($s2)     # put the generated number at the position pointed by $s2
	addi $s2, $s2, 0x00000004 # increment by one the array pointer
	addi $s3, $s3, -0x00000001

	bgt $s3, $zero, addRnd # while(size > 0) add an item to the array
	
	move $a0, $s1      # copy the initial pointer to save array
	move $a1, $s0
	
	jr $ra
		
# display subprogram 
#------------------------------------------------	
display:
	la      $a0, displayPrompt # print display prompt
	li      $v0, 4
	syscall
	
	move $s2, $s1    
	move $s3, $s0	
	
prnlp:
	lw      $a0, ($s2)
	li      $v0, 1 # print list element
	syscall
	
	la      $a0, space # print a newline
	li      $v0, 4
	syscall
	
	addi $s2, $s2, 0x00000004       # increment by one the array pointer
	addi $s3, $s3, -0x00000001
	bgt $s3, $zero, prnlp
	
prntdn:
	jr $ra
	
#------------​ ​DATA​ ​------------------
		.data
space:		.asciiz " "
prompt:	 	.asciiz "Enter the size for the array: "
displayPrompt: 	.asciiz "Displaying the array:\n"
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
