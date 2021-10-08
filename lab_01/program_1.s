.data
len: .byte 30
threshold: .byte 0x0
a: .byte 0, 1, -2, 3, -4, 5, 6, 7, 8, 9, 10, -11, 12, 13, -14, 15, 16, -17, 18, 19, 20, -21, 22, 23, 24, -25, 26, 27, 28, 29
b: .byte 0, 1, 2, 3, -4, 5, -6, 7, 8, 9, 10, -11, 12, 13, 14, 15, 16, 17, 18, -19, 20, -21, 22, 23, 24, 25, 26, -27, 28, 29
c: .space 30
thresholdhigh: .space 1
thresholdlow: .space 1
min: .space 1
max: .space 1

.text

;r1 -> counter for the loop
;r2 -> temp value for a
;r3 -> temp value for b
;r4 -> a + b
;r5 -> threshold_high register
;r6 -> threshold_low register
;r7 -> min register
;r8 -> max register
;r9 -> results of compare operations
;r29 -> threshold value
;r30 -> number of elements in the array

daddui r1, r0, 0
daddui r2, r0, 0
daddui r3, r0, 0
daddui r4, r0, 0
daddui r5, r0, 0
daddui r6, r0, 0
daddui r7, r0, 0xff
daddui r8, r0, 0
lb r29, threshold(r0)
lbu r30, len(r0)

checkloop:
beq	r1, r30, end 

loop:
lb r2, a(r1)        ;save the a value
lb r3, b(r1)        ;save the b value
dadd r4, r2, r3     ;summing the values
sb r4, c(r1)        ;storing the sum in c
daddui r1, r1, 1

;threshold over/below calc section
slt r9, r4, r29
bne r9, r0, belowt
daddui r5, r5, 1
j min

belowt:
daddui r6, r6, 1

;min/max calc section
min:
slt r9, r7, r4
bne r9, r0, max
dadd r7, r0, r4
j checkloop

max:
dadd r8, r0, r4
j checkloop

end: 
sb r5, thresholdhigh(r0)
sb r6, thresholdlow(r0)
sb r7, min(r0)
sb r8, max(r0)
halt