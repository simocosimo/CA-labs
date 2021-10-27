.data
v1:     .double -5, 32.3, 42.3, -17, 42.65, -1, 56.45, 6.54, -3, 045.45, -5, 4.34
        .double 0.34, 1.7, -34.3, -1, 0.54, -34, 3, -65, -5, 454.3, 43.5, -1.7
        .double 5.4, 1, 9.6, 56.56, 3, 7.56, -5, 75.6, 34.3, 17.3, 23.2, 1
        .double -45, 56.5, -3, 65.5
v2:     .double -5, 32.3, 42.3, -17, 42.65, -1, 56.45, 6.54, -3, 045.45, -5, 4.34
        .double 0.34, 1.7, -34.3, -1, 0.54, -34, 3, -65, -5, 454.3, 43.5, -1.7
        .double 5.4, 1, 9.6, 56.56, 3, 7.56, -5, 75.6, 34.3, 17.3, 23.2, 1
        .double -45, 56.5, -3, 65.5
v3:     .double -5, 32.3, 42.3, -17, 42.65, -1, 56.45, 6.54, -3, 045.45, -5, 4.34
        .double 0.34, 1.7, -34.3, -1, 0.54, -34, 3, -65, -5, 454.3, 43.5, -1.7
        .double 5.4, 1, 9.6, 56.56, 3, 7.56, -5, 75.6, 34.3, 17.3, 23.2, 1
        .double -45, 56.5, -3, 65.5
v4:     .double -5, 32.3, 42.3, -17, 42.65, -1, 56.45, 6.54, -3, 045.45, -5, 4.34
        .double 0.34, 1.7, -34.3, -1, 0.54, -34, 3, -65, -5, 454.3, 43.5, -1.7
        .double 5.4, 1, 9.6, 56.56, 3, 7.56, -5, 75.6, 34.3, 17.3, 23.2, 1
        .double -45, 56.5, -3, 65.5
v5:     .space 320
v6:     .space 320
v7:     .space 320


.text

;r1 -> upper floor for the loop
;r2 -> counter for the loop
;f0 -> always 0 (I need to set it, not by default)
;f3 -> temp 8 byte from current value in array
;f5 -> computed v5 value
;f6 -> computed v6 value
;f7 -> computed v7 value
;f11, f12, f13, f14 -> support registers

daddui r1, r0, 320

loop:
l.d f13, v3(r2)
l.d f12, v2(r2)
l.d f11, v1(r2)
mul.d f5, f12, f13
add.d f5, f5, f11
l.d f14, v4(r2)
s.d f6, v6(r4)
mul.d f6, f5, f14
daddu r3, r0, r2
daddu r4, r0, r2
s.d f7, v7(r5)
daddu r5, r0, r2
daddui r2, r2, 8
s.d f5, v5(r3)
bne r2, r1, loop

end:
;nop
div.d f7, f6, f12
s.d f6, v6(r4)
s.d f7, v7(r5)
halt