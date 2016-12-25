.text
main:
	# main() / program entry
	
	# storing the address of operand U into argument register $a0
	la $a0, strOpU			# a0 = strOpU
	# Printing operand U
	jal print			# print($a0)
	# Reading integer operand U
	jal read			# read U
	# Storing U into the temporary register $t0
	add $t0, $zero, $v0		# t0 = U
	
	# storing the address of operand V into argument register $a0
	la $a0, strOpV			# a0 = strOpV
	# Printing operand V
	jal print			# print($a0)
	# Reading integer operand V
	jal read			# read V
	# Storing V into the temporary register $t1
	add $t1, $zero, $v0		# t1 = V
	
	# compute 5 * U * U
	
	move $a0, $t0                   # storing the first arguemnt into argument register $a0
	move $a1, $t0                   # storing the second arguemnt into argument register $a1
	li $a2, 5                       # storing the third arguemnt into argument register $a2
	jal func            		# v0 = func(5, U, U) = 5 * U * U. Calling the function 'func' with input arguments in the registers $a0, $a1, $a2 
	move $s0, $v0                   # Save the result into s0 register
	
	# compute -12 * U * V
	
	move $a0, $t0                   # storing the first arguemnt into argument register $a0
	move  $a1, $t1                  # storing the second arguemnt into argument register $a1
	li $a2, -12                     # storing the third arguemnt into argument register $a2
	jal func            		# v0 = func(-12, U, V) = -12 * U * V. Calling the function 'func' with input arguments in the registers $a0, $a1, $a2
	add $s0, $s0, $v0               # Add the result to the contents of s0 register
	
	# compute 6 * V * V
	
	move $a0, $t1                   # storing the first arguemnt into argument register $a0
	move $a1, $t1                   # storing the second arguemnt into argument register $a1
	li $a2, 6                       # storing the third arguemnt into argument register $a2
	jal func            		# v0 = func(6, V, V) = 6 * V * V. Calling the function 'func' with input arguments in the registers $a0, $a1, $a2
	add $s0, $s0, $v0               # Add the result to the contents of s0 register.

	# print result
	la $a0, strResult		# a0 = strResult
	jal print			# print($a0)
	move $a0, $s0			# a0 = s0 = result
	li $v0, 1			# print($a0) as an integer
	syscall
	
exit:
	# exit()
	li $v0, 10
	syscall                         # System call to exit the execution of a particular subroutine
	jr $ra				# return to the address present in the $ra register
	
print:
	# print()
	li $v0, 4			# print the input string
	syscall                         # System call to print the 
	jr $ra				# return to the address present in the $ra register

read:
	# read() 
	li $v0, 5			# read an integer
	syscall                         # System call to read an integer
	jr $ra				# return to the address present in the $ra register

func:
	# v0 = func(W, X, Y) = W * X * Y
	# a0 = W, a1 = X, a2 = Y
	
	# push return address onto the stack
	
	addi $sp, $sp, -4               # Decrement the stack pointer by 4.
	sw $ra, 0($sp)                  # store the return address onto the stack.
		
	# compute X * U * V
	
	mul $t2, $a1, $a0               # Multiply two arguments and store the result into temporary register $t2              
	mul $t2, $t2, $a2               # Multiply the previous result with the third argument and store the result into the temporary register $t2
	move $v0, $t2                   # store the result into register $v0.
	
	# pop the return address from the stack
	
	lw $ra, 0($sp)                  # load the return address from the stack into the $ra register.
	addi $sp, $sp, 4                # Increment the stack pointer by 4
	jr $ra				# return to the address stored in the $ra register. 

.data
strOpU:		.asciiz "enter the operand U: "
strOpV:		.asciiz "enter the operand V: "
strResult:	.asciiz "result = "


# Declaration: I worked independently on this assignment