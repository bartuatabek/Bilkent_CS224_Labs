#​ ​-----------​ ​HEADING​ ​--------------- 
#​ MIPS ​program with user interface to convert
# the given integer value into floating point number
# using IEEE 754 Standarts.
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __main #​ ​execution​ ​starts​ ​here
__main:

menu:
	la $a0, prompt # system call to print prompt
	li $v0, 4
	syscall	
	
	li $v0, 5 # system call to read user input
	syscall
	
	beq $v0, -1, exit # if(input == -1) {goto exit}

	sw $v0, number
	jal convert_int_to_float
	
  	j menu
	
# Exit Operation 
#------------------------------------------------
exit:
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	

# convert_int_to_float subprogram
#------------------------------------------------
convert_int_to_float:
	lw $t0, number
	
	# calculating the exponent
	clz $t1, $t0 # count leading zeros
	li  $t2, 0x0000001F # 31
	li  $t3, 0x0000007F 
	sub $t1, $t2, $t1 # sub from 31 to get exponent
	
	move $t2, $t1 # exponent copy
	move $t6, $t1 # exponent copy 2
	
	add $t1, $t1, $t3 # exponent + 7F
	sll $t1, $t1, 23  # exponent + sign bit
	
	# extract the mantissa
	li   $t3, 1
	move $t4, $t0
	
shamt:
	mul  $t3, $t3, 2
	subi $t2, $t2, 1
	bgt  $t2, $zero, shamt
	
	sub  $t4, $t4, $t3 # shift mantissa
	li   $t5, 0x00000017	
	sub  $t5, $t5, $t6 # calculate shamt for mantissa 23-exp
	sllv $t4, $t4, $t5
	
	# or everthing
	or $t0, $t1, $t4

	
	la $a0, prompt2 # system call to print prompt
	li $v0, 4
	syscall	
	
	lw $a0, number # system call to print prompt
	li $v0, 1
	syscall	
	
	la $a0, prompt3 # system call to print prompt
	li $v0, 4
	syscall	
	
	sw $t0, number
	l.s $f0, number
	li $v0, 2
  	mov.s $f12, $f0   # Move contents of register $f3 to register $f12
  	syscall
	
	la $a0, space # system call to print prompt
	li $v0, 4
	syscall	
	
	jr $ra

#------------​ ​DATA​ ​------------------
		.data
number:		.word 0
prompt:		.asciiz "To convert an integer number to float enter a number, to exit type '-1' \nInput: "
prompt2:	.asciiz "Integer number: "
prompt3:	.asciiz "\nFloating point equivalent: "
space:		.asciiz "\n\n"
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
