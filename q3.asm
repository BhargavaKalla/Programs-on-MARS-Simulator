.text
main:
	# main() / program entry
	
	# initialize pointers
	# loading start address of the array into temporary register $t0
	
	la $t0, a			# t0 = &a
	
	# loading size of the array into temporary register $t1
	
	lw $t1, size			# t1 = sizeof(a)
	
	# Storing '0' into the tmeporary register $t2
	
	move $t2, $zero			# t2 = 0
	addi $t1, $t1, -1               # Decrementing the contents of $t1 by '1'
	

loop_1:
	# initialize a[10]
	
	bge $t2, 10, end_1              # Checking the loop condition i < 10 and exit if i >= 10
	sb $t2, ($t0)                   # Storing a[i] = i
	addi $t0, $t0, 1                # Incrementing start address of the array 'a[]' by '1' in each iteration
	addi $t2, $t2, 1                # Incrementing the loop count i.
	j loop_1                        # Unconditional jump to the label loop_1 for starting the next iteration
end_1:	
	# initialize function call arguments
	
	la $a0, sum			# a0 = $sum = sump
	la $a1, a			# a1 = &a
	move $t0, $zero			# t0 = 0

loop_2:
	# calculate sum
	
	bge $t0, 10, end_2              # Checking the loop condition i < 10 and exit if i >= 10           
	jal PSums                       # Calling the function 'PSums' with the arguments in the registers $a0, $a1
	addi $t0, $t0, 1                # Inrementing the 'i' value i.e., the loop count
	addi $a1, $a1, 1                # Storing the address of location (a+i) into the arument register $a1
	j loop_2                        # Unondition jump to the label loop_2 for starting the next iteration
	
end_2:
	
	lw $t0, 0($a0)		        # t0 = *sump = sum
	
	# print the result
	la $a0, strResult		# a0 = strResult
	jal print			# print($a0)
	move $a0, $t0			# a0 = t0 = sum
	li $v0, 1			# print($a0) as an integer
	syscall                         # System call to print the result
	
exit:
	# exit()
	li $v0, 10
	syscall                         # Making the system call to exit the execution
	jr $ra				# return
	
print:
	# print()
	li $v0, 4			# print the input string
	syscall                         # System call to print the string
	jr $ra				# return to the location of the return address

PSums:
	# PSums(*s, *e): *s += *e
	# a0 = s, a1 = e
	
	# push the return address onto the stack
	addi $sp, $sp, -4               # Decrement the stack pointer by 4
	sw $ra, 0($sp)                  # Store the return address onto the stack
	
        lb $t3, ($a0)                   # Loading *s into the register $t3
	lb $t4, ($a1)                   # Loading *e into the register $t4
	add $t4, $t3, $t4               # add *s with *e and store it in *s i.e., in the location ($a0)       
	sb $t4,($a0)                    # store the result into temporary reister $t4
	                  
	lw $ra, 0($sp)                  # Store the return address from the stack into the register $ra
	addi $sp, $sp, 4                # Increment the stack pointer by '4'

	jr $ra				# return to the location present in the register $ra

.data
strResult:	.asciiz	"result = "
sum:		.word 	0		# sum = 0
a:		.word 	0 : 10		# a[10]
size:		.word 	10		# sizeof(a)


# Declaration: I worked independently on this assignment
