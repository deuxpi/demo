.segment "CODE"
main:
    lda $900e ; 4
    ora #$0f  ; 2
    sta $900e ; 4

loop:
    lda $900c ; 4
    adc #$01  ; 2
    ora #$80  ; 2
    sta $900c ; 4

    ldy #$3f  ; 2
wait1:
    ldx #$ff  ; 2
wait2:
    dex       ; 2
    bne wait2 ; 2/3
    dey       ; 2
    bne wait1 ; 2/3

    jmp loop  ; 3
