.text
main:
	# main() / program entry
	
	# Storing 'i' into the temporary register $t0
	la $a0, strArgI			# a0 = strArgI
	jal print			# print($a0)
	jal read			# read I
	add $t0, $zero, $v0		# t0 = I
	
	# Storing 'x' into the temporary reister $t1
	la $a0, strArgX			# a0 = strArgX
	jal print			# print($a0)
	jal read			# read X
	add $t1, $zero, $v0		# t1 = X
	

	# v0 = fix(I, X)

	move $a0, $t0                   # Loading register $a0 with the 'i'
	move $a1, $t1                   # Loading register $a1 with the 'x'
	jal fix                         # Calling function 'fix' with arguments in the registers $a0 and $a1
	
	move $t0, $v0			# t0 = v0 = result
	
	# print result
	la $a0, strResult		# a0 = strResult
	jal print			# print($a0)
	move $a0, $t0			# a0 = t0 = result
	li $v0, 1			# print($a0) as an integer
	syscall                         # Making system call for printing the integer
	
exit:
	# exit()
	li $v0, 10 
	syscall                         # Making system call to exi from the current subroutine
	jr $ra				# return to the location whose address is in $ra
	
print:
	# print()
	li $v0, 4			# print the input string
	syscall                         # System call for printing the string
	jr $ra				# return to the location whose address is in $ra

read:
	# read()
	li $v0, 5			# read an integer      
	syscall                         # System call for reading an integer and storing it in $v0
	jr $ra				# return to the location whose address is in $ra
	
fix:
	# v0 = fix(i, x)
	# a0 = i, a1 = x

	# push the return address onto the stack
	
	addi $sp, $sp, -4               # Decrement the stack pointer by '4'
	sw $ra, 0($sp)                  # Store the return address onto the stack
	
	bgt $a1, 0, condition_1         # if x > 0 then jump to label condition_1
	bgt $a0, 0, condition_2         # else-if i > 0 then jump to label condition_2
	b condition_3                   # else jump to label condition_3

condition_1:
        
        # After checking the condition x > 0
        # Recursively call the function with arguments i and (x-1) i.e., fix(i,x-1) 
        
	addi $t0, $a0, 0                # t0 = i
	addi $t1, $a1, -1               # t1 = (x-1) i.e., x = (x-1)
	move $a0, $t0                   # a0 = i
	move $a1, $t1                   # a1 = (x-1)
	jal fix                         # Recursively call the function 'fix' with arguments i and (x-1)
	b condition_end                 # End the recursion loop if the condition is not satisfied

condition_2:
        
        # Check the condition 
        # Recursively call the function with arguments (i-1) and (i-1) and add '1' to the result i.e., fix(i-1,i-1) + 1
        
	move $t0, $a0                   # t0 = i
	addi $a0, $a0, -1               # a0 = (i-1) i.e., i = (i-1)
	addi $a1, $a0, -1               # a1 = (i-1)
	jal fix                         # Recursively call the function 'fix' with arguments (i-1) and (i-1)
	addi $v0, $v0, 1                # Adding '1' to fix(i-1,i-1) 
	b condition_end                 # End the recursion loop if the condition is not satisfied

condition_3:

	li $v0, 0                       # else return '0'

	
condition_end:

	# pop the return address from the stack

	lw $ra, 0($sp)                  # Store the return address from the stack into the register $ra         
	addi $sp, $sp, 4                # Increment the stack pointer by '4'

	jr $ra				# return to the address present in register $ra

.data
strArgI:	.asciiz "enter the function argument i:"
strArgX:	.asciiz "enter the function argument x:"
strResult:	.asciiz "result = "


# Declaration: I worked independently on this assignment
