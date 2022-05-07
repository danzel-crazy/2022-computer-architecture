.data
argument1: .word   4
argument2: .word   8
str1: .string "GCD value of "
str2: .string " and "
str3:  .string " is "

.text
main:
        lw   a2, argument2   # Load 8 from static data
        lw   a0, argument1    # Load 4 from static data
        lw   t0, 0
        addi sp, sp, -24
        sw   a0, 0(sp)
        sw   a2, 8(sp)
        jal  ra, gcd       # Jump-and-link to the 'gcd' label

        # Print the result to console
        mv   a1, t0
        lw   a0, argument1   # Load 8 from static data
        lw   a2, argument2    # Load 4 from static data
        jal  ra, printResult

        # Exit program
        li   a7, 10
        ecall

gcd: 
        sw   ra, 16(sp) 
        lw   a2, 8(sp)    
        lw   t0, 0(sp)
        rem  a0, a2, t0
        beqz a0 exit
        addi sp, sp, -24
        sw   t0, 8(sp)
        sw   a0, 0(sp)
        jal  gcd
        addi sp, sp, 24
        lw   ra, 16(sp)
        ret
        
exit:   jr ra

# --- printResult ---
# a1: GCD result
printResult:
        mv t0, a0
        mv t1, a1
        mv t2, a2
        
        la a0, str1    #print GCD value of 8
        li a7, 4
        ecall
        mv a0, t0
        li a7, 1
        ecall
        
        la a0, str2    #print and  4 
        li a7, 4
        ecall
        mv a0, t2
        li a7, 1
        ecall
        
        la a0, str3    #print is answer
        li a7, 4
        ecall
        mv a0, t1
        li a7, 1
        ecall
        
        ret