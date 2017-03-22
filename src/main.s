.segment "ZEROPAGE": zeropage

_thi: .res 1, $00
_tlo: .res 1, $00
_tmp1: .res 1, $00
_tmp2: .res 1, $00
_tmp3: .res 1, $00
_blink: .res 1, $00

.segment "CODE"
main:
    lda #$93
    jsr $ffd2

    lda #$35
    sta $01

    sei

    lda #0
    ldx #0

loop:
    tax

    dec z:_blink
    bne noblink
    sta $900f
    lda #$08
    sta z:_blink
noblink:

    txa

    ora #$80
    sta $900c

    eor #$7f
    sta $900d

    txa
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
    sta z:_tmp3
    lda z:_tlo
    asl
    bcc nope
    inc z:_tmp3
nope:
    lda z:_tmp3
    and z:_tmp2
    sta z:_tmp2

    lda z:_thi
    lsr
    lsr
    and z:_tmp1
    ora z:_tmp2

    ldy #$ff
wait:
    nop
    dey
    bne wait

    jmp loop  ; 3
