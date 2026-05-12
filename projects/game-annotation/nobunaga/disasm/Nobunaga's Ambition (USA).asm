;  HEADER - MAPPER 1 - SxROM, MMC1
        .db "NES", $1a
        .db 16  ; PRG ROM banks
        .db 0  ; CHR ROM banks
        .db $12 ; Mapper, mirroring, battery, trainer
        .db $08 ; Mapper, VS/Playchoice, NES 2.0 Header
        .db 0  ; PRG-RAM size (rarely used)
        .db 0  ; TV system (rarely used)
        .db 119  ; TV system, PRG-RAM presense (unofficial, rarely used)
        .db $07, $00, $00, $00, $01 ; Unused padding

;  MMIO
        PPUCTRL    EQU $2000
        PPUMASK    EQU $2001
        PPUSTATUS  EQU $2002
        OAMADDR    EQU $2003
        OAMDATA    EQU $2004
        PPUSCROLL  EQU $2005
        PPUADDR    EQU $2006
        PPUDATA    EQU $2007
        SQ1_VOL    EQU $4000
        SQ1_SWEEP  EQU $4001
        SQ1_LO     EQU $4002
        SQ1_HI     EQU $4003
        SQ2_VOL    EQU $4004
        SQ2_SWEEP  EQU $4005
        SQ2_LO     EQU $4006
        SQ2_HI     EQU $4007
        TRI_LINEAR EQU $4008
        TRI_LO     EQU $400a
        TRI_HI     EQU $400b
        NOISE_VOL  EQU $400c
        NOISE_PER  EQU $400e
        NOISE_LEN  EQU $400f
        DMC_FREQ   EQU $4010
        DMC_RAW    EQU $4011
        DMC_START  EQU $4012
        DMC_LEN    EQU $4013
        OAMDMA     EQU $4014
        SND_CHN    EQU $4015
        JOY1       EQU $4016
        JOY2       EQU $4017

        .include bank_00.asm
        .include bank_01.asm
        .include bank_02.asm
        .include bank_03.asm
        .include bank_04.asm
        .include bank_05.asm
        .include bank_06.asm
        .include bank_07.asm
        .include bank_08.asm
        .include bank_09.asm
        .include bank_10.asm
        .include bank_11.asm
        .include bank_12.asm
        .include bank_13.asm
        .include bank_14.asm
        .include bank_15.asm
        .incbin chr_rom.bin
