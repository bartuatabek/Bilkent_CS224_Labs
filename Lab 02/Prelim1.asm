#​ ​-----------​ ​HEADING​ ​--------------- 
#​ ​Bartu​ ​Atabek
#​ ​21602229
#​ ​CS224-6
#​ ​Lab​ ​2 ​Part 1
#​ ​-----------​ ​PROGRAM​ ​START​ ​--------------
.text 
	.globl __main #​ ​execution​ ​starts​ ​here
__main:
	la $a0, hexNo
	jal  convertHexToDec
  	
  	move $a0, $v0 # print out the result
	li $v0, 1
  	syscall
  	
    	li $v0, 10 # ​system​ ​call​ ​to​ ​exit
	syscall	
		
  
# Hex to Decimal Conversion Subprogram 
#------------------------------------------------
convertHexToDec:
	li $s0, 0 # initialize the result to zero
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)	
	sw $s3, 12($sp)	
	
iterator:
        lb $s1, 0($a0) # load char from argument	
	beqz $s1, exit # check for the null character

        li $s2, 0x00000030 # load 48
        li $s3, 0x00000039 # load 57	

        blt $s1, $s2, invalid # error if lower than 48
        bgt $s1, $s3, case1 # if greater than57, test for A-F

        addi $s1, $s1, -0x00000030 # char is between 48 and 55 subtract 48
        j return

case1:  
	li $s2, 0x00000041 # load 65
        li $s3, 0x00000046 # load 70

        blt $s1, $s2, invalid # error if lower than 65
        bgt $s1, $s3, case2 # if greater than70, test for a-f
       
       	addi $s1, $s1, -0x00000037 # subtract 55 from hex char ('A'-'F')
        j return
             
case2:  
	li $s2, 0x00000061 # load 97
        li $s3, 0x00000066 # load 102

        blt $s1, $s2, invalid # error if lower than 0x61
        bgt $s1, $s3, invalid # error if greater than 0x66
       
        addi $s1, $s1, -0x00000057 # subtract 87 from hex char ('a'-'f')
        j return
    
return: 
	addi $a0, $a0, 1 # increment the string pointer
	mul $s0, $s0, 0x00000010
	add $s0, $s0, $s1
	j iterator # return to the top of the loop

invalid:  
	addi $s0, $zero, -1 # return -1
	
exit:	
	move $v0, $s0 # move return value to register $v0
	addi $sp, $sp 16
        jr $ra
		
#------------​ ​DATA​ ​------------------
		.data
hexNo: 		.asciiz "3ED"
#------------​ ​END​ ​OF​ ​PROGRAM​ ​-------------
