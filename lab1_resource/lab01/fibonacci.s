# This example shows an implementation of the mathematical
# fibonacci function (! function) to find the fibonacci value of 7 = 13.

.data
argument: .word   7
str1:     .string "Fibonacci value of "
str2:     .string " is "
str3:     .string " a0 = a0 + a2"
str4:     .string " a0 "
.text
main:
        lw  a0, argument      
        li  t1, 1                 
        jal ra, fib           

        # Print the result to console                          
        mv  a1, a0                                             
        lw  a0, argument                                       
        jal ra, printResult

        # Exit program
        li a7, 10
        ecall

fib:
        ble  a0, t1, exit                                        
        addi sp, sp, -24                                          
        sw   ra, 0(sp)                                           
        sw   a0, 8(sp)                                           
           
        addi a0, a0, -1                                          
        jal, ra, fib                                             
        sw   a0, 16(sp)                                         
        lw   a0, 8(sp)                                        
        
        addi a0, a0, -2                                        
        jal  ra, fib                                          
        lw   t0, 16(sp)                                      
        
        #la a0, str4
        #li a7, 4
        #ecall
        #mv a0, t1
        #li a7, 1
        #ecall 
        
        add  a0, a0, t0                                        
        
        #la a0, str3
        #li a7, 4
        #ecall
        #mv a0, t1
        #li a7, 1
        #ecall
        
        lw   ra, 0(sp)                                        
        addi sp, sp, 24                                       
        ret                                                    
    
exit: ret

# --- printResult ---
# a0: Value which fibonacci number was computed from
# a1: Fibonacci result
printResult:
        mv t0, a0
        mv t1, a1
        la a0, str1
        li a7, 4
        ecall
        mv a0, t0
        li a7, 1
        ecall
        la a0, str2
        li a7, 4
        ecall
        mv a0, t1
        li a7, 1
        ecall
        ret
