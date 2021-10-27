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
daddui r1, r0, 312

loop:
;r2 block, first iteration
l.d f13, v3(r2)
l.d f12, v2(r2)
mul.d f5, f12, f13

;r20 block, second iteration (i+1) (+8)
daddui r20, r2, 8
l.d f15, v3(r20)
l.d f18, v2(r20)
mul.d f20, f18, f15

;r21 block, second iteration (i+2) (+16)
daddui r21, r2, 16
l.d f13, v3(r21)
l.d f29, v2(r21)
mul.d f21, f29, f13

;r22 bloc, third iteration (i+3) (+24)
daddui r22, r2, 24
l.d f15, v3(r22)
l.d f30, v2(r22)
mul.d f23, f30, f15

;adds
l.d f11, v1(r2)
l.d f17, v1(r20)
l.d f22, v1(r21)
l.d f24, v1(r22)
add.d f5, f5, f11
add.d f20, f20, f17
add.d f21, f21, f22
add.d f23, f23, f24

;load/calc v6 values
l.d f14, v4(r2)
l.d f16, v4(r20)
l.d f19, v4(r21)
l.d f25, v4(r22)
mul.d f6, f5, f14
mul.d f8, f20, f16
mul.d f9, f21, f19
mul.d f10, f23, f25

s.d f7, v7(r25)
div.d f7, f6, f12

;v6 store
s.d f6, v6(r2)
s.d f8, v6(r20)
s.d f9, v6(r21)
s.d f10, v6(r22)

daddui r25, r25, 8
s.d f26, v7(r25)
div.d f26, f8, f18

;v5 stores
s.d f5, v5(r2)
s.d f20, v5(r20)
s.d f21, v5(r21)
s.d f23, v5(r22)

daddui r25, r25, 8
s.d f27, v7(r25)
div.d f27, f9, f29

daddui r25, r25, 8
s.d f28, v7(r25)

daddu r25, r0, r2
daddui r2, r2, 32
bne r22, r1, loop

end:
div.d f28, f10, f30
s.d f7, v7(r25)
daddui r25, r25, 8
s.d f26, v7(r25)
daddui r25, r25, 8
s.d f27, v7(r25)
daddui r25, r25, 8
s.d f28, v7(r25)
halt