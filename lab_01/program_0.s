.data
a:      .word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
        .word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
        .word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
        .word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
        .word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
len:    .byte 100    ;Number of array elements
res:    .space 1

.text

;r1 -> double the number of elements in the array (or number of bytes in the array)
;r2 -> counter for the loop
;r3 -> temp 8 bit from current value in the array
;r4 -> temp result, to be stored in memory at the end
;r5 -> flag to find in values

lbu r1, len(r0)
daddu r1, r1, r1
daddui r2, r0, 0
daddui r3, r0, 0
daddui r4, r0, 0
daddui r5, r0, 0x2f

checkloop:
beq r2, r1, end

loop:
lbu r3, a(r2)
daddui r2, r2, 1
beq r3, r5, increment
j checkloop

increment:
daddui r4, r4, 1
j checkloop

end:
sb r4, res(r0)
halt
