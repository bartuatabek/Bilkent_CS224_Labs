##
## Object_Code.asm - Implements the code to obtain hex object code  x = (c-d) % 2
##
##

#################################
#	text segment		#
#################################

	.text
	.globl __start

__start:	# execution starts here
	la	$t1, a
	la	$t2, b

	li $v0,10  # system call to exit
	syscall	#    bye bye


#################################
#     	 data segment		#
#################################

	.data
str:	.asciiz	"\nHello\n"
a:	.word	1, 2, 3, 4
b:	.word   	1

## end of file Program1.asm
