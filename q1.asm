.text
main:
	# main() / program entry
	la $t0, string		# t0 = start address of the string
	la $t1, tail		# t1 = end address of the string
	
loop:
	# iterate through all string elements and conver the letters to lowercase
	
	lb $t2, ($t0)         # loading each character of the input string into a temporary register in every iteration till we exit the loop.   
	addi $t2, $t2, 32     # adding 32 to the temporary reister value  so as to obtain the ascii value of corresponding lowercase letter
	sb $t2, ($t0)         # storing contents of the temporary reister into another register
	addi $t0, $t0, 1      # incrementing the starting address of the string by 1 in each iteration and storing it into the temporary register                   
        blt $t0, $t1, loop    # It's the latest string element/quit the loop. Checking and iterating the loop till the end address of the string is reached.

print:
	# print out the result
	li $v0, 4		# print_string() system call
	la $a0, string          
	syscall	                # This syscall prints the string, whose null-termination address is stored in $a0 register   
	
finish:
	# finish execution
	li $v0, 10		# exit() system call
	syscall                 # This system call terminates the execution

.data
string:		.asciiz "ABCDEFG"      # Storing the input string
tail:		.asciiz "\n"           # Terminating the input string with a null character


# Declaration: I worked independently on this assignment



