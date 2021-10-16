.data
z:  .double 0.0
ba: .double 0xab
e:  .word16 0x7ff
i:  .double -5, 32.3, 42.3, -17, 42.65, -1, 56.45, 6.54, -3, 045.45, -5, 4.34
    .double 0.34, 1.7, -34.3, -1, 0.54, -34, 3, -65, -5, 454.3, 43.5, -1.7
    .double 5.4, 1, 9.6, 56.56, 3, 7.56
w:  .double -5, 32.3, 42.3, -17, 42.65, -1, 56.45, 6.54, -3, 045.45, -5, 4.34
    .double 0.34, 1.7, -34.3, -1, 0.54, -34, 3, -65, -5, 454.3, 43.5, -1.7
    .double 5.4, 1, 9.6, 56.56, 3, 7.56
y:  .space 8

.text

;r1 -> upper floor for the loop
;r2 -> counter for the loop
;f0 -> always 0 (I need to set it, not by default)
;f1 -> temp value from i
;f2 -> temp value from w
;f3 -> temp i * w
;f4 -> x
;r4 -> int of f4, support
;f5 -> ba
;f6 -> temp y value
;r7 -> exponent check

daddui r1, r0, 240
daddui r2, r0, 0
daddui r4, r0, 0
l.d f0, z(r0)
l.d f5, ba(r0)
lh r7, e(r0)
dsll r7, r7, 31
dsll r7, r7, 21
add.d f1, f0, f0
add.d f2, f0, f0
add.d f3, f0, f0
add.d f4, f0, f0
add.d f6, f0, f0

checkloop:
beq r2, r1, fx

loop:
;loading values from memory
l.d f1, i(r2)
l.d f2, w(r2)
;calculating summation
mul.d f3, f1, f2
add.d f4, f4, f3
daddui r2, r2, 8
j checkloop

fx:
;adding b to the whole summation
;TODO: check if b is a fp or an int with prof
add.d f4, f4, f5
mfc1 r4, f4
and r4, r4, r7
;check if exponent is equal to flag
bne r4, r7, end
add.d f4, f0, f0

end:
s.d f4, y(r0)
halt