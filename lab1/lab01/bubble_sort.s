.data
size: .word   5
arr:  .word   5, 3, 6, 7, 31
str1: .string "Array ："
str2: .string "Sorted ："
str3: .string " t1 "
str4: .string " t0 "
endl: .string "\n"
spac: .string " "
.text
main:
        la   s0, arr                                      # 1
        jal  ra, printarray                               # 2    
        li   t0, 5           # n = 5                      # 45
        li   t1, 0           # i = 0                      # 46

        jal loopi                                         # 47 
        
        exit: jal  ra, printResult                        # 100

        # Exit program
        li   a7, 10                                       # 143
        ecall                                             # 144

loopi:
        addi t1, t1, 1       # i++                        # 48  # 70  # 79  # 88  # 97
        blt  t1, t0, loopj   # if i < n, loopj            # 49  # 71  # 80  # 89  # 98
        j exit                                            # 99
        
loopj:
        addi t2, t1, -1      # j = i - 1                  # 50  # 64  # 72  # 81  # 90
        slli t3, t2, 2       # address of arr[j]          # 51  # 65  # 73  # 82  # 91
        add  s1, s0, t3                                   # 52  # 66  # 74  # 83  # 92
        lw   t5, 0(s1)       # t5 = arr[j]                # 53  # 67  # 75  # 84  # 93
        
        #slli t3, t2, 4       # address of arr[j+1]       
        #add  s2, s0, t3                                  
        lw   t6, 4(s1)       # t6 = arr[j+1]              # 54  # 68  # 76  # 85  # 94

        bltz t2, loopi       # j < 0, jump                # 55  # 69  # 77  # 86  # 95
        bge  t6, t5, loopi    # if arr[j] > arr[j+1]      # 56  # 78  # 87  # 96
        jal ra, swap                                      # 57  
        addi t2, t2, -1      # j = j - 1                  # 62  
        j loopj                                           # 63  
        
swap:
        add t4, t5, x0       # temp = arr[j]              # 58
        sw t6, 0(s1)       # arr[j] = arr[j+1]            # 59
        sw t4, 4(s1)       # arr[j+1] = temp              # 60
        ret                                               # 61
#print unsorted array
printarray:
        la   a0, str1                                    # 3
        li   a7, 4                                       # 4
        ecall                                            # 5
        la   a0, endl                                    # 6
        li   a7, 4                                       # 7
        ecall                                            # 8
        lw   t0, 0(s0)                                   # 9
        mv   a0, t0                                      # 10
        li   a7, 1                                       # 11
        ecall                                            # 12   
        la   a0, spac                                    # 13
        li   a7, 4                                       # 14
        ecall                                            # 15   
        lw   t0, 4(s0)                                   # 16
        mv   a0, t0                                      # 17
        li   a7, 1                                       # 18
        ecall                                            # 19
        la   a0, spac                                    # 20 
        li   a7, 4                                       # 21
        ecall                                            # 22
        lw   t0, 8(s0)                                   # 23
        mv   a0, t0                                      # 24
        li   a7, 1                                       # 25
        ecall                                            # 26
        la   a0, spac                                    # 27
        li   a7, 4                                       # 28
        ecall                                            # 29
        lw   t0, 12(s0)                                  # 30
        mv   a0, t0                                      # 31
        li   a7, 1                                       # 32
        ecall                                            # 33
        la   a0, spac                                    # 34
        li   a7, 4                                       # 35
        ecall                                            # 36
        lw   t0, 16(s0)                                  # 37
        mv   a0, t0                                      # 38
        li   a7, 1                                       # 39
        ecall                                            # 40
        la   a0, endl                                    # 41
        li   a7, 4                                       # 42
        ecall                                            # 43
        ret                                              # 44
        
#printresult
printResult:
        la   a0, str2                                    # 101
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
        ret                                              # 142                