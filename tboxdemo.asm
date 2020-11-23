;********************************
; Text Box Demo
;
; Puts a box on the screen!
;********************************

; Define a few things.
SCRstr  equ     $400            ; Screen start position.
SCRstp  equ     $600            ; Screen stop.
BLKspc  equ     $20             ; Black space character 20.
BLKstr  equ     $2A             ; Black space w/green star 2A.
MSKloc  equ     $1F             ; Mask for first five bits, zero rest.
BITchk  equ     %00000000       ; Bit check.

        org     $4000

Start   lda     #BLKstr     ; Load green star to A register.
        ldx     #SCRstr     ; Point X to start of video space.
        sta     ,x+         ; Put value of A reg on screen and increment.

Loop    cmpx    #$420       ; Check top line.
        blt     SetSt       ; GOTO SetSt.
        cmpx    #$5DF       ; Check bottom line.
        bgt     SetSt       ; GOTO SetSt.
        tfr     x,d         ; Set up side check by copying X to D.
        andb    #MSKloc     ; Mask for check.
        cmpb    #BITchk     ; All bits 0?
        beq     SetSt       ; GOTO SetSt.
        addb    #%00000001  ; Right side?
        andb    #MSKloc     ; Mask for check.
        cmpb    #BITchk     ; All bits 0?
        beq     SetSt       ; GOTO SetSt.

SetSp   lda     #BLKspc     ; Set space
        bra     Plac        ; GOTO Plac

SetSt   lda     #BLKstr     ; Set star

Plac    sta     ,x+         ; Put value of A reg on screen and increment
        cmpx    #SCRstp     ; Compare one past last space $5FF
        bne     Loop        ; Branch if not equal

Done    bra     Done

        rts

        End     Start
