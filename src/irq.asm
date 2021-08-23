IRQ:
    PHA         
    TYA        
    PHA       
    TXA
    PHA

    LDA shadowPPUMASK
    ORA #1
    STA PPUMASK
    
    LDA #$27        ; Acknowledge and disable IRQ
    STA EPSM_ADDR0
    LDA #$10
    STA EPSM_DATA0

	PLA
    TAX
    PLA       
    TAY
    PLA    
	RTI 