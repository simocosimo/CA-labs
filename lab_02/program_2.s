.data
zero:   .double 0.0
v1:     .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
v2:     .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
v3:     .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
v4:     .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3
        .double 1.2, 2.4, 9.8, 20.3, 5.5, 19.4, 25.6, 95.3

;doubles are on 64bit, so 8byte
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
daddui r2, r0, 0
l.d f0, zero(r0)
add.d f3, f0, f0
add.d f5, f0, f0
add.d f6, f0, f0
add.d f7, f0, f0
add.d f11, f0, f0
add.d f12, f0, f0
add.d f13, f0, f0
add.d f14, f0, f0

checkloop:
beq r2, r1, end

loop:
;loading values from memory
l.d f11, v1(r2)
l.d f12, v2(r2)
l.d f13, v3(r2)
l.d f14, v4(r2)

;computing v5 value
mul.d f5, f12, f13
add.d f5, f5, f11

;computing v6 value
mul.d f6, f5, f14

;computing v7 value
div.d f7, f6, f12

;storing values
s.d f5, v5(r2)
s.d f6, v6(r2)
s.d f7, v7(r2)

;looping
daddui r2, r2, 8
j checkloop

end:
halt