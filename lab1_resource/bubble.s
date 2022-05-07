.data
size: .word   5
arr:  .word    31,23,43,12,45
str1: .string "Array ¡G"
str2: .string "Sorted ¡G"
str3: .string " t1 "
str4: .string " t0 "
endl: .string "\n"
spac: .string " "
.text
main:
        la   s0, arr
        jal  ra, printarray        
        li   t0, 5           # n = 5
        li   t1, 0           # i = 0
        # Print the result to console
        jal loopi
        
        exit: jal  ra, printResult

        # Exit program
        li   a7, 10
        ecall

loopi:
        addi t1, t1, 1       # i++
        addi t2, t1, -1      # j = i - 1
        blt  t1, t0, loopj   # if i < n, loopj
        j exit
        
loopj:
        
        slli t3, t2, 2       # address of arr[j]
        add  s1, s0, t3
        lw   t5, 0(s1)       # t5 = arr[j]
        
        #slli t3, t2, 4       # address of arr[j+1]
        #add  s2, s0, t3
        lw   t6, 4(s1)       # t6 = arr[j+1]

        bltz t2, loopi       # j < 0, jump
        bge  t6, t5, loopi    # if arr[j] > arr[j+1]
        jal ra, swap
        addi t2, t2, -1      # j = j - 1
        j loopj
        
swap:
        add t4, t5, x0       # temp = arr[j]
        sw t6, 0(s1)       # arr[j] = arr[j+1]
        sw t4, 4(s1)       # arr[j+1] = temp
        ret
#print unsorted array
printarray:
        la   a0, str1
        li   a7, 4
        ecall
        la   a0, endl
        li   a7, 4
        ecall 
        lw   t0, 0(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 4(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 8(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 12(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 16(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, endl
        li   a7, 4
        ecall 
        ret
        
#printresult
printResult:
        la   a0, str2
        li   a7, 4
        ecall
        la   a0, endl
        li   a7, 4
        ecall 
        lw   t0, 0(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 4(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 8(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 12(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        la   a0, spac
        li   a7, 4
        ecall
        lw   t0, 16(s0)
        mv   a0, t0
        li   a7, 1
        ecall
        ret