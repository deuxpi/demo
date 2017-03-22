.segment "ZEROPAGE": zeropage

_thi: .res 1, $00
_tlo: .res 1, $00
_tmp1: .res 1, $00
_tmp2: .res 1, $00

.segment "CODE"
main:
    lda $900e ; 4
    ora #$0f  ; 2
    sta $900e ; 4

    lda #$d0
    sta $900c ; 4

    lda #0
    ldx #0
    ldy #0

loop:
    ora #$80
    sta $900c

    and #$0f  ; 2
    sta $900e ; 4

    ldx z:_tlo
    ldy z:_thi
    inx
    bne _nocarry
    iny
_nocarry:
    stx z:_tlo
    sty z:_thi

    clc
    lda z:_tlo
    adc z:_tlo
    adc z:_tlo
    sta z:_tmp1
    adc z:_tlo
    adc z:_tlo
    sta z:_tmp2

    lda z:_thi
    asl
    and z:_tmp2
    sta z:_tmp2

    lda z:_thi
    lsr
    lsr
    and z:_tmp1
    ora z:_tmp2

    ldy #$ff
wait:
    dey
    bne wait

    jmp loop  ; 3
