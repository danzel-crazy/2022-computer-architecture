# This example shows an implementation of the mathematical
# factorial function (! function).

.data
argument: .word 7 # Number to find the factorial value of
str1: .string "Factorial value of "
str2: .string " is "

.text
main:
        lw       a0, argument   # Load argument from static data
        jal      ra, fact       # Jump-and-link to the 'fact' label

        # Print the result to console
        mv       a1, a0
        lw       a0, argument
        jal      ra, printResult

        # Exit program
        li       a0, 10
        ecall

fact:
        addi     sp, sp, -16  #save return address and n on stack
        sw       ra, 8(sp)    #store sp to return address
        sw       a0, 0(sp)    
        addi     t0, a0, -1     #t0 = n - 1
        bge      t0, zero, nfact  #if n >= 0, go to nfact

        addi     a0, zero, 1    #else return value to 1
        addi     sp, sp, 16     #pop stack 
        jalr     x0, x1, 0      #return 

nfact:
        addi     a0, a0, -1     #n = n - 1
        jal      ra, fact       #call fact(n-1) 

        addi     t1, a0, 0      #move result of fact(n-1) to t1
        lw       a0, 0(sp)      #restore caller's n
        lw       ra, 8(sp)      #restore caller's return value
        addi     sp, sp, 16     #pop

        mul      a0, a0, t1     #return n*fact(n-1)
        ret                     #return


# expects:
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
        mv       t0, a0
        mv       t1, a1

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, t0
        li       a0, 1
        ecall

        la       a1, str2
        li       a0, 4
        ecall

        mv       a1, t1
        li       a0, 1
        ecall

        ret
