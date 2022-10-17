

.pos 0x100

#LIST ITERATOR FOR AVERAGE GRADE CALCULATOR
Average_loop:               ld    $s, r0                   #r0 = value of student pointer
                            ld    (r0), r0                 #r0 = base address of student/array of students = &s[0]
                            ld    $n, r3                   #r3 = address of n
                            ld    (r3), r3                 #r3 = value of n
                            dec   r3                       #r3 = n-1
                            not   r3                       #r3 = not n-1
                            inc   r3                       #r3 =-(n-1)
                            ld    $0, r4                   #r4 = index value = 0
loop1:                      mov   r3, r5                   #r5 = -(n-1)
                            add   r4, r5                   #r5 = index value -(n-1)
                            bgt   r5, end_loop1            #r5 = if index value > (n-1), end_loop1
                            br    Average                  # branch to calculating the average for the student
average_returns_here:       inc   r4                       # i++
                            ld    $24, r6                  # r6 = size of struct = 24
                            add   r6, r0                   # r0 = &s[+1]
                            br    loop1                    # jump back to interating through student list
end_loop1:                  br    bubble_sort_outer_loops



#AVERAGE GRADE CALCULATOR
Average:                    ld  $0x0, r1                 #r1 = sum of grades
                            ld  4(r0), r2                #r2 = grade 1 (r0 is the provided base of student struct)
                            add r2, r1                   #r1 = grade 1
                            ld  8(r0), r2                #r2 = grade 2
                            add r2, r1                   #r1 = grades 1 + 2
                            ld  12(r0), r2               #r2 = grade 3
                            add r2, r1                   #r1 = grades 1+2+3
                            ld  16(r0), r2               #r2 = grade 4
                            add r2, r1                   #r1 = grades 1+2+3+4
                            shr $2, r1
                            st  r1, 20(r0)
                            br  average_returns_here


#Bubble sort outer loops start here
bubble_sort_outer_loops:    ld    $n, r0                #r0 = &n
                            ld    (r0), r0              #r0 = value of n
                            dec   r0                    #R0 = i = n-1
outer_loop:                 mov   r0, r2                #r2 = i
                            not   r2                    #r2 = not i
                            inc   r2                    #R2 = -i
                            bgt   r0, initiatize_inner_loop        #r0 = i, i>0
                            br    end_outer_loop        # end outer loop
return_from_inner_loop:     dec   r0                    #i--
                            br    outer_loop
initiatize_inner_loop:      ld    $1, r1                          #r1 = j
inner_loop:                 mov   r2, r3
                            add   r1, r3                          #r2 = j-i
                            bgt   r3, return_from_inner_loop      # j>i, end inner loop
                            br    swap                            # jump to swap program

#####################################################################################


#store the registers
swap:             ld  $registers, r3
                  st  r0, (r3)
                  st  r1, 4(r3)
                  st  r2, 8(r3)                   #registers saved, r1, r2 and r3 in memory (r1 still being used and carried over)

#calculating values of a[j] and a[j-1]
                  mov   r1, r2                       #r1 = j; r2 = j  (r1=j)
                  dec   r2                           #r2 = j-1

                  ld    $s, r0                      #
                  ld    (r0), r0                    #r0 = base address of student array
                  mov   r1, r3                       #r3 = copy of j
                  shl   $4, r3                       #r3 = j*16
                  mov   r1, r4                      #r4 = copy of j
                  shl   $3, r4                       #r4 = j*8
                  add   r3, r4                      #r4 = offset of j from base
                  add   r0, r4                      #r4 = base address of a[j]
                  ld    $20, r5
                  add   r4, r5                      #r5 = base address of average element of a[j]
                  mov   r5, r6
                  ld    $-24, r7
                  add   r7, r6                      #r6 = base address of average element of a[j-1]

                  ld    (r5), r3                     #r3 = Value of a[j]
                  ld    (r6), r4                     #r4 = Value of a[j-1]
                  not   r3
                  inc   r3                           #r3 = -a[j]
                  add   r3, r4                       #r4 = a[j-1] - a[j]
                  bgt   r4, if_then


if_else:          ld    $registers, r3              #restoring registers
                  ld    (r3), r0
                  ld    4(r3), r1
                  ld    8(r3), r2      #restored the 3 registers being used for loop control
                  br    return_from_swap






if_then:          ld    $s, r0                      # all registers free to be used again
                  ld    (r0), r0                    #r0 = base address of student array
                  mov   r1,r2                       #r2 = copy of j
                  shl   $4, r2                       #r2 = j*16
                  mov   r1, r3                      #r3 = copy of j
                  shl   $3, r3                       #r3 = j*8
                  add   r3, r2                      #r2 = offset of j from base
                  mov   r2,r3                       #r3 = copy of r2
                  add   r0, r3                      #r3 = base address of a[j]
                  ld    $student_store, r5           #r5 = address of student score
                  ld    (r3), r4                     #r4 = first element of student
                  st    r4, (r5)                     # storing first element of student into (student_store)
                  ld    4(r3), r4
                  st    r4, 4(r5)
                  ld    8(r3), r4
                  st    r4, 8(r5)
                  ld    12(r3), r4
                  st    r4, 12(r5)
                  ld    16(r3), r4
                  st    r4, 16(r5)
                  ld    20(r3), r4
                  st    r4, 20(r5)    #all of student at a[j] stored at (student_store)
                  ld    $-24, r5
                  add   r3, r5                    #r5 = base address of a[j-1]
                  ld    (r5), r6                  #r6 = first element of a[j-1]
                  st    r6, (r3)                  #stored first element of a[j-1] into first element of a[j]
                  ld    4(r5), r6
                  st    r6, 4(r3)
                  ld    8(r5), r6
                  st    r6, 8(r3)
                  ld    12(r5), r6
                  st    r6, 12(r3)
                  ld    16(r5), r6
                  st    r6, 16(r3)
                  ld    20(r5), r6
                  st    r6, 20(r3)              #stored a[j-1] into a[j]

                  ld    $student_store, r6
                  ld    (r6), r7                 #r7 = value of first element of original a[j]
                  st    r7, (r5)                 # stored r6 into base address of first element of a[j-1]
                  ld    4(r6), r7
                  st    r7, 4(r5)
                  ld    8(r6), r7
                  st    r7, 8(r5)
                  ld    12(r6), r7
                  st    r7, 12(r5)
                  ld    16(r6), r7
                  st    r7, 16(r5)
                  ld    20(r6), r7
                  st    r7, 20(r5)            # original a[j] taken from memory and placed in the position of original a[j-1]

#restoring the registers
                  ld    $registers, r3
                  ld    (r3), r0
                  ld    4(r3), r1
                  ld    8(r3), r2      #restored the 3 registers being used for loop control

                  br    return_from_swap








####################################################################################
return_from_swap:           inc r1                      #j++
                            br  inner_loop              #go back to inner loop

end_outer_loop:             ld    $n, r0
                            ld    (r0), r0              #r0 = number of n
                            shr   $1, r0                #r0 = n/2

                            mov   r0, r1                       #r1 = n/2
                            shl   $4, r1                       #r1 = n/2*16
                            mov   r0, r2                      #r2 = n/2
                            shl   $3, r2                       #r2 = n/2 * 8
                            add   r2, r1                      #r1 = offset of median from base
                            ld    $20, r2
                            add   r2, r1                      #r1 = offset of average element of the median student

                            ld    $s, r2
                            ld    (r2), r2                    #r2 = address of base of student array
                            add   r1, r2                      #r2 = address of answer
                            ld    (r2), r3                    #r3 = answer
                            ld    $m, r4                      #r4 = address of answer
                            st    r3, (r4)                    # store answer into memory address of answer
                            halt










.pos 0x1000
n:               .long 5          # just one student
m:               .long 0          # put the answer here
s:               .long base       # address of the array
base:            .long 1234       # student ID
                 .long 1000         # grade 0
                 .long 10         # grade 1
                 .long 20         # grade 2
                 .long 20         # grade 3
                 .long 0          # computed average
                 .long 1234       # SECOND student ID
                 .long 20         # grade 0
                 .long 20         # grade 1
                 .long 30         # grade 2
                 .long 30         # grade 3
                 .long 0          # computed average
                 .long 1234       # student ID
                 .long 30         # grade 0
                 .long 30         # grade 1
                 .long 40         # grade 2
                 .long 40         # grade 3
                 .long 0          # computed average
                 .long 1234       # SECOND student ID
                 .long 50         # grade 0
                 .long 50         # grade 1
                 .long 60         # grade 2
                 .long 60         # grade 3
                 .long 0          # computed average
                 .long 1234       # SECOND student ID
                 .long 2000         # grade 0
                 .long 50         # grade 1
                 .long 60         # grade 2
                 .long 60         # grade 3
                 .long 0          # computed average



.pos 0x3000
registers:        .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0

.pos 0x4000
student_store:    .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
                  .long 0
