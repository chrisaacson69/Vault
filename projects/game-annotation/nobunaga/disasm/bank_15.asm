.base $c000

b15_c000:   sei                         ; 3C000:  78
            cld                         ; 3C001:  d8
            ldx #$fd                    ; 3C002:  a2 fd
            txs                         ; 3C004:  9a
            lda #$ff                    ; 3C005:  a9 ff
            sta $9fff                   ; 3C007:  8d ff 9f
            lda #$0e                    ; 3C00A:  a9 0e
            sta $9fff                   ; 3C00C:  8d ff 9f
            lsr a                       ; 3C00F:  4a
            sta $9fff                   ; 3C010:  8d ff 9f
            lsr a                       ; 3C013:  4a
            sta $9fff                   ; 3C014:  8d ff 9f
            lsr a                       ; 3C017:  4a
            sta $9fff                   ; 3C018:  8d ff 9f
            lsr a                       ; 3C01B:  4a
            sta $9fff                   ; 3C01C:  8d ff 9f
            lda #$00                    ; 3C01F:  a9 00
            sta $bfff                   ; 3C021:  8d ff bf
            sta $bfff                   ; 3C024:  8d ff bf
            sta $bfff                   ; 3C027:  8d ff bf
            sta $bfff                   ; 3C02A:  8d ff bf
            sta $bfff                   ; 3C02D:  8d ff bf
            sta $fff0                   ; 3C030:  8d f0 ff
            sta $fff0                   ; 3C033:  8d f0 ff
            sta $fff0                   ; 3C036:  8d f0 ff
            sta $fff0                   ; 3C039:  8d f0 ff
            sta $fff0                   ; 3C03C:  8d f0 ff
            hex 8d 73 00 ; sta $0073    ; 3C03F:  8d 73 00
            lda #$00                    ; 3C042:  a9 00
            hex 8d 80 00 ; sta $0080    ; 3C044:  8d 80 00
            hex 8d b0 00 ; sta $00b0    ; 3C047:  8d b0 00
            lda #$10                    ; 3C04A:  a9 10
            jsr b15_c6a6                ; 3C04C:  20 a6 c6
            jsr b15_c537                ; 3C04F:  20 37 c5
            jsr b15_c537                ; 3C052:  20 37 c5
            lda #$1e                    ; 3C055:  a9 1e
            jsr b15_c570                ; 3C057:  20 70 c5
            ldx #$00                    ; 3C05A:  a2 00
            lda #$3e                    ; 3C05C:  a9 3e
b15_c05e:   hex 9d 90 00 ; sta $0090,x  ; 3C05E:  9d 90 00
            sta $0700,x                 ; 3C061:  9d 00 07
            inx                         ; 3C064:  e8
            cpx #$20                    ; 3C065:  e0 20
            bne b15_c05e                ; 3C067:  d0 f5
            lda #$ff                    ; 3C069:  a9 ff
            hex 8d 74 00 ; sta $0074    ; 3C06B:  8d 74 00
            ldx #$00                    ; 3C06E:  a2 00
            lda #$f8                    ; 3C070:  a9 f8
b15_c072:   sta $0600,x                 ; 3C072:  9d 00 06
            sta $0603,x                 ; 3C075:  9d 03 06
            inx                         ; 3C078:  e8
            inx                         ; 3C079:  e8
            inx                         ; 3C07A:  e8
            inx                         ; 3C07B:  e8
            bne b15_c072                ; 3C07C:  d0 f4
            lda #$ff                    ; 3C07E:  a9 ff
            sta $02                     ; 3C080:  85 02
            lda #$05                    ; 3C082:  a9 05
            sta $03                     ; 3C084:  85 03
            lda #$20                    ; 3C086:  a9 20
            sta $1c                     ; 3C088:  85 1c
            lda #$00                    ; 3C08A:  a9 00
            sta $1d                     ; 3C08C:  85 1d
            lda #$30                    ; 3C08E:  a9 30
            sta $1e                     ; 3C090:  85 1e
            lda #$00                    ; 3C092:  a9 00
            sta $1f                     ; 3C094:  85 1f
            lda #$1f                    ; 3C096:  a9 1f
            sta SND_CHN                 ; 3C098:  8d 15 40
            lda #$c0                    ; 3C09B:  a9 c0
            sta JOY2                    ; 3C09D:  8d 17 40
            ldx #$00                    ; 3C0A0:  a2 00
            lda #$00                    ; 3C0A2:  a9 00
b15_c0a4:   sta $0720,x                 ; 3C0A4:  9d 20 07
            inx                         ; 3C0A7:  e8
            cpx #$05                    ; 3C0A8:  e0 05
            bne b15_c0a4                ; 3C0AA:  d0 f8
            ldx #$00                    ; 3C0AC:  a2 00
b15_c0ae:   lda #$00                    ; 3C0AE:  a9 00
            sta $0734,x                 ; 3C0B0:  9d 34 07
            txa                         ; 3C0B3:  8a
            clc                         ; 3C0B4:  18
            adc #$09                    ; 3C0B5:  69 09
            tax                         ; 3C0B7:  aa
            cpx #$2d                    ; 3C0B8:  e0 2d
            bne b15_c0ae                ; 3C0BA:  d0 f2
            lda #$04                    ; 3C0BC:  a9 04
            hex 8d 83 00 ; sta $0083    ; 3C0BE:  8d 83 00
            hex 8d 85 00 ; sta $0085    ; 3C0C1:  8d 85 00
            lda #$d2                    ; 3C0C4:  a9 d2
            hex 8d 84 00 ; sta $0084    ; 3C0C6:  8d 84 00
            hex 8d 86 00 ; sta $0086    ; 3C0C9:  8d 86 00
            lda #$00                    ; 3C0CC:  a9 00
            hex 8d 89 00 ; sta $0089    ; 3C0CE:  8d 89 00
            jsr b15_c68a                ; 3C0D1:  20 8a c6
            jsr b15_c757                ; 3C0D4:  20 57 c7
            jmp $8000                   ; 3C0D7:  4c 00 80

b15_c0da:   pha                         ; 3C0DA:  48
            txa                         ; 3C0DB:  8a
            pha                         ; 3C0DC:  48
            tya                         ; 3C0DD:  98
            pha                         ; 3C0DE:  48
            lda PPUSTATUS               ; 3C0DF:  ad 02 20
            jsr b15_c54f                ; 3C0E2:  20 4f c5
            lda #$00                    ; 3C0E5:  a9 00
            sta OAMADDR                 ; 3C0E7:  8d 03 20
            lda #$06                    ; 3C0EA:  a9 06
            sta OAMDMA                  ; 3C0EC:  8d 14 40
            hex ad b0 00 ; lda $00b0    ; 3C0EF:  ad b0 00
            bne b15_c12b                ; 3C0F2:  d0 37
            lda #$00                    ; 3C0F4:  a9 00
            jsr b15_c628                ; 3C0F6:  20 28 c6
            lda #$01                    ; 3C0F9:  a9 01
            jsr b15_c628                ; 3C0FB:  20 28 c6
            jsr b15_c6d4                ; 3C0FE:  20 d4 c6
            jsr tab_b15_c794+17         ; 3C101:  20 a5 c7
            hex ad 89 00 ; lda $0089    ; 3C104:  ad 89 00
            bne b15_c12b                ; 3C107:  d0 22
            clc                         ; 3C109:  18
            hex ad 86 00 ; lda $0086    ; 3C10A:  ad 86 00
            adc #$02                    ; 3C10D:  69 02
            hex 8d 86 00 ; sta $0086    ; 3C10F:  8d 86 00
            hex ad 85 00 ; lda $0085    ; 3C112:  ad 85 00
            adc #$00                    ; 3C115:  69 00
            hex 8d 85 00 ; sta $0085    ; 3C117:  8d 85 00
            clc                         ; 3C11A:  18
            hex ad 84 00 ; lda $0084    ; 3C11B:  ad 84 00
            adc #$02                    ; 3C11E:  69 02
            hex 8d 84 00 ; sta $0084    ; 3C120:  8d 84 00
            hex ad 83 00 ; lda $0083    ; 3C123:  ad 83 00
            adc #$00                    ; 3C126:  69 00
            hex 8d 83 00 ; sta $0083    ; 3C128:  8d 83 00
b15_c12b:   lda #$00                    ; 3C12B:  a9 00
            hex 8d 81 00 ; sta $0081    ; 3C12D:  8d 81 00
            jsr b15_c68a                ; 3C130:  20 8a c6
            pla                         ; 3C133:  68
            tay                         ; 3C134:  a8
            pla                         ; 3C135:  68
            tax                         ; 3C136:  aa
            pla                         ; 3C137:  68
            rti                         ; 3C138:  40

b15_c139:   pha                         ; 3C139:  48
            txa                         ; 3C13A:  8a
            pha                         ; 3C13B:  48
            tya                         ; 3C13C:  98
            pha                         ; 3C13D:  48
            tsx                         ; 3C13E:  ba
            lda $0104,x                 ; 3C13F:  bd 04 01
            and #$10                    ; 3C142:  29 10
            beq b15_c16c                ; 3C144:  f0 26
            lda #$00                    ; 3C146:  a9 00
            hex 8d 66 00 ; sta $0066    ; 3C148:  8d 66 00
            hex 8d 67 00 ; sta $0067    ; 3C14B:  8d 67 00
            lda #$c1                    ; 3C14E:  a9 c1
            pha                         ; 3C150:  48
            lda #$6c                    ; 3C151:  a9 6c
            pha                         ; 3C153:  48
            hex ae 50 00 ; ldx $0050    ; 3C154:  ae 50 00
            ldy #$03                    ; 3C157:  a0 03
            jsr b15_c6ad                ; 3C159:  20 ad c6
            clc                         ; 3C15C:  18
            tya                         ; 3C15D:  98
            adc #$73                    ; 3C15E:  69 73
            hex 8d 68 00 ; sta $0068    ; 3C160:  8d 68 00
            txa                         ; 3C163:  8a
            adc #$c1                    ; 3C164:  69 c1
            hex 8d 69 00 ; sta $0069    ; 3C166:  8d 69 00
            jmp ($0068)                 ; 3C169:  6c 68 00

b15_c16c:   nop                         ; 3C16C:  ea
            pla                         ; 3C16D:  68
            tay                         ; 3C16E:  a8
            pla                         ; 3C16F:  68
            tax                         ; 3C170:  aa
            pla                         ; 3C171:  68
            rti                         ; 3C172:  40

            hex 4c 00 c0 4c 64 c2 4c 4b ; 3C173:  4c 00 c0 4c 64 c2 4c 4b
            hex c3 4c cb c2 4c 4c c3 4c ; 3C17B:  c3 4c cb c2 4c 4c c3 4c
            hex 12 c3 4c 9e c3 4c 39 c3 ; 3C183:  12 c3 4c 9e c3 4c 39 c3
            hex 4c f0 c2 4c ad c3 4c cf ; 3C18B:  4c f0 c2 4c ad c3 4c cf
            hex c3 4c 27 c4 4c 37 c4 4c ; 3C193:  c3 4c 27 c4 4c 37 c4 4c
            hex e0 c4 4c 35 c5 4c 36 c5 ; 3C19B:  e0 c4 4c 35 c5 4c 36 c5
            hex 4c 2c c2 4c c3 c1 4c 6c ; 3C1A3:  4c 2c c2 4c c3 c1 4c 6c
            hex c3 4c b8 c1 4c 28 c4 4c ; 3C1AB:  c3 4c b8 c1 4c 28 c4 4c
            hex 0c c6 4c aa c5          ; 3C1B3:  0c c6 4c aa c5

            lda #$01                    ; 3C1B8:  a9 01
            hex 8d 81 00 ; sta $0081    ; 3C1BA:  8d 81 00
b15_c1bd:   hex ad 81 00 ; lda $0081    ; 3C1BD:  ad 81 00
            bne b15_c1bd                ; 3C1C0:  d0 fb
            rts                         ; 3C1C2:  60

            hex ad 88 00 ; lda $0088    ; 3C1C3:  ad 88 00
            ora #$01                    ; 3C1C6:  09 01
            hex 8d 88 00 ; sta $0088    ; 3C1C8:  8d 88 00
            ldy #$05                    ; 3C1CB:  a0 05
            lda #$00                    ; 3C1CD:  a9 00
b15_c1cf:   hex 99 8a 00 ; sta $008a,y  ; 3C1CF:  99 8a 00
            dey                         ; 3C1D2:  88
            bpl b15_c1cf                ; 3C1D3:  10 fa
            ldy #$05                    ; 3C1D5:  a0 05
b15_c1d7:   lda b15_c226,y              ; 3C1D7:  b9 26 c2
            hex 8d 75 00 ; sta $0075    ; 3C1DA:  8d 75 00
            lda #$08                    ; 3C1DD:  a9 08
            hex 8d 6c 00 ; sta $006c    ; 3C1DF:  8d 6c 00
b15_c1e2:   ldx #$05                    ; 3C1E2:  a2 05
            clc                         ; 3C1E4:  18
b15_c1e5:   hex 3e 8a 00 ; rol $008a,x  ; 3C1E5:  3e 8a 00
            dex                         ; 3C1E8:  ca
            bpl b15_c1e5                ; 3C1E9:  10 fa
            hex 0e 75 00 ; asl $0075    ; 3C1EB:  0e 75 00
            bcc b15_c1ff                ; 3C1EE:  90 0f
            ldx #$05                    ; 3C1F0:  a2 05
            clc                         ; 3C1F2:  18
b15_c1f3:   hex bd 83 00 ; lda $0083,x  ; 3C1F3:  bd 83 00
            hex 7d 8a 00 ; adc $008a,x  ; 3C1F6:  7d 8a 00
            hex 9d 8a 00 ; sta $008a,x  ; 3C1F9:  9d 8a 00
            dex                         ; 3C1FC:  ca
            bpl b15_c1f3                ; 3C1FD:  10 f4
b15_c1ff:   hex ce 6c 00 ; dec $006c    ; 3C1FF:  ce 6c 00
            bne b15_c1e2                ; 3C202:  d0 de
            dey                         ; 3C204:  88
            bpl b15_c1d7                ; 3C205:  10 d0
            sec                         ; 3C207:  38
            ldx #$05                    ; 3C208:  a2 05
b15_c20a:   hex bd 8a 00 ; lda $008a,x  ; 3C20A:  bd 8a 00
            eor #$ff                    ; 3C20D:  49 ff
            adc #$00                    ; 3C20F:  69 00
            hex 9d 83 00 ; sta $0083,x  ; 3C211:  9d 83 00
            dex                         ; 3C214:  ca
            bpl b15_c20a                ; 3C215:  10 f3
            hex ad 83 00 ; lda $0083    ; 3C217:  ad 83 00
            and #$7f                    ; 3C21A:  29 7f
            hex 8d 67 00 ; sta $0067    ; 3C21C:  8d 67 00
            hex ad 84 00 ; lda $0084    ; 3C21F:  ad 84 00
            hex 8d 66 00 ; sta $0066    ; 3C222:  8d 66 00
            rts                         ; 3C225:  60

b15_c226:   cmp $87                     ; 3C226:  c5 87
            ora ($0e,x)                 ; 3C228:  01 0e
            bcc b15_c20a+2              ; 3C22A:  90 e0
            hex ad 73 00 ; lda $0073    ; 3C22C:  ad 73 00
            pha                         ; 3C22F:  48
            hex ad 52 00 ; lda $0052    ; 3C230:  ad 52 00
            jsr b15_c577                ; 3C233:  20 77 c5
            ldx #$00                    ; 3C236:  a2 00
b15_c238:   hex ad 58 00 ; lda $0058    ; 3C238:  ad 58 00
            bne b15_c245                ; 3C23B:  d0 08
            hex ad 59 00 ; lda $0059    ; 3C23D:  ad 59 00
            beq b15_c25f                ; 3C240:  f0 1d
            hex ce 59 00 ; dec $0059    ; 3C242:  ce 59 00
b15_c245:   lda ($54,x)                 ; 3C245:  a1 54
            sta ($56,x)                 ; 3C247:  81 56
            hex ee 54 00 ; inc $0054    ; 3C249:  ee 54 00
            bne b15_c251                ; 3C24C:  d0 03
            hex ee 55 00 ; inc $0055    ; 3C24E:  ee 55 00
b15_c251:   hex ee 56 00 ; inc $0056    ; 3C251:  ee 56 00
            bne b15_c259                ; 3C254:  d0 03
            hex ee 57 00 ; inc $0057    ; 3C256:  ee 57 00
b15_c259:   hex ce 58 00 ; dec $0058    ; 3C259:  ce 58 00
            jmp b15_c238                ; 3C25C:  4c 38 c2

b15_c25f:   pla                         ; 3C25F:  68
            jsr b15_c577                ; 3C260:  20 77 c5
            rts                         ; 3C263:  60

            hex ad 73 00 ; lda $0073    ; 3C264:  ad 73 00
            pha                         ; 3C267:  48
            hex ad 52 00 ; lda $0052    ; 3C268:  ad 52 00
            jsr b15_c577                ; 3C26B:  20 77 c5
            hex ad 57 00 ; lda $0057    ; 3C26E:  ad 57 00
            hex 8d 6b 00 ; sta $006b    ; 3C271:  8d 6b 00
            hex ad 56 00 ; lda $0056    ; 3C274:  ad 56 00
            hex 8d 6a 00 ; sta $006a    ; 3C277:  8d 6a 00
            hex ad 55 00 ; lda $0055    ; 3C27A:  ad 55 00
            hex 8d 69 00 ; sta $0069    ; 3C27D:  8d 69 00
            hex ad 54 00 ; lda $0054    ; 3C280:  ad 54 00
            hex 8d 68 00 ; sta $0068    ; 3C283:  8d 68 00
            ldy #$00                    ; 3C286:  a0 00
            hex ad 58 00 ; lda $0058    ; 3C288:  ad 58 00
            hex 8d 6c 00 ; sta $006c    ; 3C28B:  8d 6c 00
b15_c28e:   ldx #$10                    ; 3C28E:  a2 10
            jsr b15_c693                ; 3C290:  20 93 c6
            hex ad 6b 00 ; lda $006b    ; 3C293:  ad 6b 00
            sta PPUADDR                 ; 3C296:  8d 06 20
            hex ad 6a 00 ; lda $006a    ; 3C299:  ad 6a 00
            sta PPUADDR                 ; 3C29C:  8d 06 20
b15_c29f:   lda ($68),y                 ; 3C29F:  b1 68
            sta PPUDATA                 ; 3C2A1:  8d 07 20
            iny                         ; 3C2A4:  c8
            bne b15_c2aa                ; 3C2A5:  d0 03
            hex ee 69 00 ; inc $0069    ; 3C2A7:  ee 69 00
b15_c2aa:   dex                         ; 3C2AA:  ca
            bne b15_c29f                ; 3C2AB:  d0 f2
            clc                         ; 3C2AD:  18
            hex ad 6a 00 ; lda $006a    ; 3C2AE:  ad 6a 00
            adc #$10                    ; 3C2B1:  69 10
            hex 8d 6a 00 ; sta $006a    ; 3C2B3:  8d 6a 00
            hex ad 6b 00 ; lda $006b    ; 3C2B6:  ad 6b 00
            adc #$00                    ; 3C2B9:  69 00
            hex 8d 6b 00 ; sta $006b    ; 3C2BB:  8d 6b 00
            jsr b15_c558                ; 3C2BE:  20 58 c5
            hex ce 6c 00 ; dec $006c    ; 3C2C1:  ce 6c 00
            bne b15_c28e                ; 3C2C4:  d0 c8
            pla                         ; 3C2C6:  68
            jsr b15_c577                ; 3C2C7:  20 77 c5
            rts                         ; 3C2CA:  60

            jsr b15_c54f                ; 3C2CB:  20 4f c5
            hex ad 52 00 ; lda $0052    ; 3C2CE:  ad 52 00
            asl a                       ; 3C2D1:  0a
            asl a                       ; 3C2D2:  0a
            tax                         ; 3C2D3:  aa
            hex ad 56 00 ; lda $0056    ; 3C2D4:  ad 56 00
            sta $0600,x                 ; 3C2D7:  9d 00 06
            hex ad 5a 00 ; lda $005a    ; 3C2DA:  ad 5a 00
            sta $0601,x                 ; 3C2DD:  9d 01 06
            hex ad 58 00 ; lda $0058    ; 3C2E0:  ad 58 00
            sta $0602,x                 ; 3C2E3:  9d 02 06
            hex ad 54 00 ; lda $0054    ; 3C2E6:  ad 54 00
            sta $0603,x                 ; 3C2E9:  9d 03 06
            jsr b15_c68a                ; 3C2EC:  20 8a c6
            rts                         ; 3C2EF:  60

            jsr b15_c693                ; 3C2F0:  20 93 c6
            hex ad 52 00 ; lda $0052    ; 3C2F3:  ad 52 00
            asl a                       ; 3C2F6:  0a
            asl a                       ; 3C2F7:  0a
            clc                         ; 3C2F8:  18
            adc #$23                    ; 3C2F9:  69 23
            sta PPUADDR                 ; 3C2FB:  8d 06 20
            lda #$c0                    ; 3C2FE:  a9 c0
            sta PPUADDR                 ; 3C300:  8d 06 20
            hex ad 54 00 ; lda $0054    ; 3C303:  ad 54 00
            ldx #$40                    ; 3C306:  a2 40
b15_c308:   sta PPUDATA                 ; 3C308:  8d 07 20
            dex                         ; 3C30B:  ca
            bne b15_c308                ; 3C30C:  d0 fa
            jsr b15_c558                ; 3C30E:  20 58 c5
            rts                         ; 3C311:  60

            jsr b15_c693                ; 3C312:  20 93 c6
            hex ad 52 00 ; lda $0052    ; 3C315:  ad 52 00
            asl a                       ; 3C318:  0a
            asl a                       ; 3C319:  0a
            clc                         ; 3C31A:  18
            adc #$20                    ; 3C31B:  69 20
            sta PPUADDR                 ; 3C31D:  8d 06 20
            lda #$00                    ; 3C320:  a9 00
            sta PPUADDR                 ; 3C322:  8d 06 20
            ldy #$1e                    ; 3C325:  a0 1e
            hex ad 54 00 ; lda $0054    ; 3C327:  ad 54 00
b15_c32a:   ldx #$20                    ; 3C32A:  a2 20
b15_c32c:   sta PPUDATA                 ; 3C32C:  8d 07 20
            dex                         ; 3C32F:  ca
            bne b15_c32c                ; 3C330:  d0 fa
            dey                         ; 3C332:  88
            bne b15_c32a                ; 3C333:  d0 f5
            jsr b15_c558                ; 3C335:  20 58 c5
            rts                         ; 3C338:  60

            hex ad 73 00 ; lda $0073    ; 3C339:  ad 73 00
            pha                         ; 3C33C:  48
            hex ad 52 00 ; lda $0052    ; 3C33D:  ad 52 00
            jsr b15_c577                ; 3C340:  20 77 c5
            jsr $8000                   ; 3C343:  20 00 80
            pla                         ; 3C346:  68
            jsr b15_c577                ; 3C347:  20 77 c5
            rts                         ; 3C34A:  60

            hex 60                      ; 3C34B:  60

            hex ad 80 00 ; lda $0080    ; 3C34C:  ad 80 00
            beq b15_c35d                ; 3C34F:  f0 0c
            hex ae 52 00 ; ldx $0052    ; 3C351:  ae 52 00
            hex ad 54 00 ; lda $0054    ; 3C354:  ad 54 00
            hex 9d 90 00 ; sta $0090,x  ; 3C357:  9d 90 00
            jmp b15_c36b                ; 3C35A:  4c 6b c3

b15_c35d:   hex ae 52 00 ; ldx $0052    ; 3C35D:  ae 52 00
            hex ad 54 00 ; lda $0054    ; 3C360:  ad 54 00
            sta $0700,x                 ; 3C363:  9d 00 07
            lda #$ff                    ; 3C366:  a9 ff
            hex 8d 74 00 ; sta $0074    ; 3C368:  8d 74 00
b15_c36b:   rts                         ; 3C36B:  60

b15_c36c:   hex ad 74 00 ; lda $0074    ; 3C36C:  ad 74 00
            bne b15_c36c                ; 3C36F:  d0 fb
            hex ad 52 00 ; lda $0052    ; 3C371:  ad 52 00
            hex 4d 80 00 ; eor $0080    ; 3C374:  4d 80 00
            beq b15_c39d                ; 3C377:  f0 24
            ldx #$00                    ; 3C379:  a2 00
b15_c37b:   lda $0700,x                 ; 3C37B:  bd 00 07
            hex bc 90 00 ; ldy $0090,x  ; 3C37E:  bc 90 00
            hex 9d 90 00 ; sta $0090,x  ; 3C381:  9d 90 00
            tya                         ; 3C384:  98
            sta $0700,x                 ; 3C385:  9d 00 07
            inx                         ; 3C388:  e8
            cpx #$20                    ; 3C389:  e0 20
            bne b15_c37b                ; 3C38B:  d0 ee
            lda #$ff                    ; 3C38D:  a9 ff
            hex 8d 74 00 ; sta $0074    ; 3C38F:  8d 74 00
b15_c392:   hex ad 74 00 ; lda $0074    ; 3C392:  ad 74 00
            bne b15_c392                ; 3C395:  d0 fb
            hex ad 52 00 ; lda $0052    ; 3C397:  ad 52 00
            hex 8d 80 00 ; sta $0080    ; 3C39A:  8d 80 00
b15_c39d:   rts                         ; 3C39D:  60

            hex ae 52 00 ; ldx $0052    ; 3C39E:  ae 52 00
            hex bd 6e 00 ; lda $006e,x  ; 3C3A1:  bd 6e 00
            hex 8d 66 00 ; sta $0066    ; 3C3A4:  8d 66 00
            beq b15_c3ac                ; 3C3A7:  f0 03
            hex 8d 89 00 ; sta $0089    ; 3C3A9:  8d 89 00
b15_c3ac:   rts                         ; 3C3AC:  60

            jsr b15_c54f                ; 3C3AD:  20 4f c5
            hex ad 52 00 ; lda $0052    ; 3C3B0:  ad 52 00
            asl a                       ; 3C3B3:  0a
            clc                         ; 3C3B4:  18
            hex 6d 52 00 ; adc $0052    ; 3C3B5:  6d 52 00
            tax                         ; 3C3B8:  aa
            hex ad 56 00 ; lda $0056    ; 3C3B9:  ad 56 00
            sta $0726,x                 ; 3C3BC:  9d 26 07
            hex ad 57 00 ; lda $0057    ; 3C3BF:  ad 57 00
            sta $0727,x                 ; 3C3C2:  9d 27 07
            hex ad 54 00 ; lda $0054    ; 3C3C5:  ad 54 00
            sta $0725,x                 ; 3C3C8:  9d 25 07
            jsr b15_c68a                ; 3C3CB:  20 8a c6
            rts                         ; 3C3CE:  60

            hex ae 52 00 ; ldx $0052    ; 3C3CF:  ae 52 00
            hex ad 54 00 ; lda $0054    ; 3C3D2:  ad 54 00
            beq b15_c3f9                ; 3C3D5:  f0 22
            cmp #$02                    ; 3C3D7:  c9 02
            beq b15_c3f0                ; 3C3D9:  f0 15
            jsr b15_c54f                ; 3C3DB:  20 4f c5
            lda #$01                    ; 3C3DE:  a9 01
            sta $0720,x                 ; 3C3E0:  9d 20 07
            ldy #$09                    ; 3C3E3:  a0 09
            jsr b15_c6ad                ; 3C3E5:  20 ad c6
            lda #$00                    ; 3C3E8:  a9 00
            sta $0734,y                 ; 3C3EA:  99 34 07
            jmp b15_c423                ; 3C3ED:  4c 23 c4

b15_c3f0:   lda $0720,x                 ; 3C3F0:  bd 20 07
            hex 8d 66 00 ; sta $0066    ; 3C3F3:  8d 66 00
            jmp b15_c426                ; 3C3F6:  4c 26 c4

b15_c3f9:   jsr b15_c54f                ; 3C3F9:  20 4f c5
            ldx #$00                    ; 3C3FC:  a2 00
            lda #$00                    ; 3C3FE:  a9 00
b15_c400:   sta $0720,x                 ; 3C400:  9d 20 07
            inx                         ; 3C403:  e8
            cpx #$05                    ; 3C404:  e0 05
            bne b15_c400                ; 3C406:  d0 f8
            ldx #$00                    ; 3C408:  a2 00
b15_c40a:   lda #$00                    ; 3C40A:  a9 00
            sta $0734,x                 ; 3C40C:  9d 34 07
            txa                         ; 3C40F:  8a
            clc                         ; 3C410:  18
            adc #$09                    ; 3C411:  69 09
            tax                         ; 3C413:  aa
            cpx #$2d                    ; 3C414:  e0 2d
            bne b15_c40a                ; 3C416:  d0 f2
            lda #$00                    ; 3C418:  a9 00
            sta SQ1_VOL                 ; 3C41A:  8d 00 40
            sta SQ2_VOL                 ; 3C41D:  8d 04 40
            sta TRI_LINEAR              ; 3C420:  8d 08 40
b15_c423:   jsr b15_c68a                ; 3C423:  20 8a c6
b15_c426:   rts                         ; 3C426:  60

            hex 60                      ; 3C427:  60

            hex ad 73 00 ; lda $0073    ; 3C428:  ad 73 00
            pha                         ; 3C42B:  48
            hex ad 5e 00 ; lda $005e    ; 3C42C:  ad 5e 00
            jsr b15_c577                ; 3C42F:  20 77 c5
            lda #$01                    ; 3C432:  a9 01
            jmp b15_c439                ; 3C434:  4c 39 c4

            lda #$00                    ; 3C437:  a9 00
b15_c439:   hex 8d 82 00 ; sta $0082    ; 3C439:  8d 82 00
            hex ac 56 00 ; ldy $0056    ; 3C43C:  ac 56 00
            ldx #$20                    ; 3C43F:  a2 20
            jsr b15_c6ad                ; 3C441:  20 ad c6
            tya                         ; 3C444:  98
            clc                         ; 3C445:  18
            hex 6d 54 00 ; adc $0054    ; 3C446:  6d 54 00
            tay                         ; 3C449:  a8
            txa                         ; 3C44A:  8a
            adc #$00                    ; 3C44B:  69 00
            hex 8d 68 00 ; sta $0068    ; 3C44D:  8d 68 00
            hex ad 52 00 ; lda $0052    ; 3C450:  ad 52 00
            asl a                       ; 3C453:  0a
            asl a                       ; 3C454:  0a
            clc                         ; 3C455:  18
            adc #$20                    ; 3C456:  69 20
            hex 6d 68 00 ; adc $0068    ; 3C458:  6d 68 00
            hex 8d 68 00 ; sta $0068    ; 3C45B:  8d 68 00
            hex 8c 69 00 ; sty $0069    ; 3C45E:  8c 69 00
            hex ee 5a 00 ; inc $005a    ; 3C461:  ee 5a 00
            hex ad 5a 00 ; lda $005a    ; 3C464:  ad 5a 00
            sec                         ; 3C467:  38
            hex ed 56 00 ; sbc $0056    ; 3C468:  ed 56 00
            hex 8d 6c 00 ; sta $006c    ; 3C46B:  8d 6c 00
            hex ee 58 00 ; inc $0058    ; 3C46E:  ee 58 00
            hex ad 58 00 ; lda $0058    ; 3C471:  ad 58 00
            sec                         ; 3C474:  38
            hex ed 54 00 ; sbc $0054    ; 3C475:  ed 54 00
            hex 8d 75 00 ; sta $0075    ; 3C478:  8d 75 00
            ldx #$00                    ; 3C47B:  a2 00
b15_c47d:   jsr b15_c693                ; 3C47D:  20 93 c6
            hex ad 68 00 ; lda $0068    ; 3C480:  ad 68 00
            sta PPUADDR                 ; 3C483:  8d 06 20
            hex ad 69 00 ; lda $0069    ; 3C486:  ad 69 00
            sta PPUADDR                 ; 3C489:  8d 06 20
            hex ad 75 00 ; lda $0075    ; 3C48C:  ad 75 00
            hex 8d 6d 00 ; sta $006d    ; 3C48F:  8d 6d 00
            hex ad 5c 00 ; lda $005c    ; 3C492:  ad 5c 00
b15_c495:   hex ad 82 00 ; lda $0082    ; 3C495:  ad 82 00
            beq b15_c4b2                ; 3C498:  f0 18
            lda ($5c,x)                 ; 3C49A:  a1 5c
            pha                         ; 3C49C:  48
            clc                         ; 3C49D:  18
            hex ad 5c 00 ; lda $005c    ; 3C49E:  ad 5c 00
            adc #$01                    ; 3C4A1:  69 01
            hex 8d 5c 00 ; sta $005c    ; 3C4A3:  8d 5c 00
            hex ad 5d 00 ; lda $005d    ; 3C4A6:  ad 5d 00
            adc #$00                    ; 3C4A9:  69 00
            hex 8d 5d 00 ; sta $005d    ; 3C4AB:  8d 5d 00
            pla                         ; 3C4AE:  68
            jmp b15_c4b5                ; 3C4AF:  4c b5 c4

b15_c4b2:   hex ad 5c 00 ; lda $005c    ; 3C4B2:  ad 5c 00
b15_c4b5:   sta PPUDATA                 ; 3C4B5:  8d 07 20
            hex ce 6d 00 ; dec $006d    ; 3C4B8:  ce 6d 00
            bne b15_c495                ; 3C4BB:  d0 d8
            hex ad 69 00 ; lda $0069    ; 3C4BD:  ad 69 00
            clc                         ; 3C4C0:  18
            adc #$20                    ; 3C4C1:  69 20
            hex 8d 69 00 ; sta $0069    ; 3C4C3:  8d 69 00
            hex ad 68 00 ; lda $0068    ; 3C4C6:  ad 68 00
            adc #$00                    ; 3C4C9:  69 00
            hex 8d 68 00 ; sta $0068    ; 3C4CB:  8d 68 00
            jsr b15_c558                ; 3C4CE:  20 58 c5
            hex ce 6c 00 ; dec $006c    ; 3C4D1:  ce 6c 00
            bne b15_c47d                ; 3C4D4:  d0 a7
            hex ad 82 00 ; lda $0082    ; 3C4D6:  ad 82 00
            beq b15_c4df                ; 3C4D9:  f0 04
            pla                         ; 3C4DB:  68
            jsr b15_c577                ; 3C4DC:  20 77 c5
b15_c4df:   rts                         ; 3C4DF:  60

            hex ee 58 00 ; inc $0058    ; 3C4E0:  ee 58 00
            hex ad 58 00 ; lda $0058    ; 3C4E3:  ad 58 00
            sec                         ; 3C4E6:  38
            hex ed 54 00 ; sbc $0054    ; 3C4E7:  ed 54 00
            hex 8d 77 00 ; sta $0077    ; 3C4EA:  8d 77 00
            hex 8d 6c 00 ; sta $006c    ; 3C4ED:  8d 6c 00
            hex ee 5a 00 ; inc $005a    ; 3C4F0:  ee 5a 00
            hex ad 5a 00 ; lda $005a    ; 3C4F3:  ad 5a 00
            sec                         ; 3C4F6:  38
            hex ed 56 00 ; sbc $0056    ; 3C4F7:  ed 56 00
            hex 8d 6d 00 ; sta $006d    ; 3C4FA:  8d 6d 00
            hex ad 54 00 ; lda $0054    ; 3C4FD:  ad 54 00
            hex 8d 78 00 ; sta $0078    ; 3C500:  8d 78 00
b15_c503:   hex ad 77 00 ; lda $0077    ; 3C503:  ad 77 00
            hex 8d 6c 00 ; sta $006c    ; 3C506:  8d 6c 00
            hex ad 78 00 ; lda $0078    ; 3C509:  ad 78 00
            hex 8d 54 00 ; sta $0054    ; 3C50C:  8d 54 00
b15_c50f:   hex ad 5c 00 ; lda $005c    ; 3C50F:  ad 5c 00
            hex 8d 58 00 ; sta $0058    ; 3C512:  8d 58 00
            jsr b15_c693                ; 3C515:  20 93 c6
            jsr b15_c640                ; 3C518:  20 40 c6
            jsr b15_c673                ; 3C51B:  20 73 c6
            jsr b15_c711                ; 3C51E:  20 11 c7
            jsr b15_c558                ; 3C521:  20 58 c5
            hex ee 54 00 ; inc $0054    ; 3C524:  ee 54 00
            hex ce 6c 00 ; dec $006c    ; 3C527:  ce 6c 00
            bne b15_c50f                ; 3C52A:  d0 e3
            hex ee 56 00 ; inc $0056    ; 3C52C:  ee 56 00
            hex ce 6d 00 ; dec $006d    ; 3C52F:  ce 6d 00
            bne b15_c503                ; 3C532:  d0 cf
            rts                         ; 3C534:  60

            hex 60 60                   ; 3C535:  60 60

b15_c537:   hex ad 80 00 ; lda $0080    ; 3C537:  ad 80 00
            bne b15_c54e                ; 3C53A:  d0 12
            pha                         ; 3C53C:  48
            txa                         ; 3C53D:  8a
            pha                         ; 3C53E:  48
            tya                         ; 3C53F:  98
            pha                         ; 3C540:  48
            jsr tab_b15_c794+17         ; 3C541:  20 a5 c7
            pla                         ; 3C544:  68
            tay                         ; 3C545:  a8
            pla                         ; 3C546:  68
            tax                         ; 3C547:  aa
            pla                         ; 3C548:  68
b15_c549:   lda PPUSTATUS               ; 3C549:  ad 02 20
            bpl b15_c549                ; 3C54C:  10 fb
b15_c54e:   rts                         ; 3C54E:  60

b15_c54f:   hex ad 71 00 ; lda $0071    ; 3C54F:  ad 71 00
            and #$7f                    ; 3C552:  29 7f
            jsr b15_c6a6                ; 3C554:  20 a6 c6
            rts                         ; 3C557:  60

b15_c558:   lda #$00                    ; 3C558:  a9 00
            sta PPUSCROLL               ; 3C55A:  8d 05 20
            sta PPUSCROLL               ; 3C55D:  8d 05 20
            jsr b15_c567                ; 3C560:  20 67 c5
            jsr b15_c68a                ; 3C563:  20 8a c6
            rts                         ; 3C566:  60

b15_c567:   hex ad 72 00 ; lda $0072    ; 3C567:  ad 72 00
            ora #$18                    ; 3C56A:  09 18
            jsr b15_c570                ; 3C56C:  20 70 c5
            rts                         ; 3C56F:  60

b15_c570:   sta PPUMASK                 ; 3C570:  8d 01 20
            hex 8d 72 00 ; sta $0072    ; 3C573:  8d 72 00
            rts                         ; 3C576:  60

b15_c577:   hex cd 73 00 ; cmp $0073    ; 3C577:  cd 73 00
            beq b15_c5a9                ; 3C57A:  f0 2d
            pha                         ; 3C57C:  48
            hex ad 71 00 ; lda $0071    ; 3C57D:  ad 71 00
            pha                         ; 3C580:  48
            bpl b15_c586                ; 3C581:  10 03
            jsr b15_c54f                ; 3C583:  20 4f c5
b15_c586:   pla                         ; 3C586:  68
            hex 8d 71 00 ; sta $0071    ; 3C587:  8d 71 00
            pla                         ; 3C58A:  68
            hex 8d 73 00 ; sta $0073    ; 3C58B:  8d 73 00
            sta $fff0                   ; 3C58E:  8d f0 ff
            lsr a                       ; 3C591:  4a
            sta $fff0                   ; 3C592:  8d f0 ff
            lsr a                       ; 3C595:  4a
            sta $fff0                   ; 3C596:  8d f0 ff
            lsr a                       ; 3C599:  4a
            sta $fff0                   ; 3C59A:  8d f0 ff
            lsr a                       ; 3C59D:  4a
            sta $fff0                   ; 3C59E:  8d f0 ff
            hex ad 71 00 ; lda $0071    ; 3C5A1:  ad 71 00
            bpl b15_c5a9                ; 3C5A4:  10 03
            jsr b15_c68a                ; 3C5A6:  20 8a c6
b15_c5a9:   rts                         ; 3C5A9:  60

b15_c5aa:   lda $03                     ; 3C5AA:  a5 03
            cmp #$02                    ; 3C5AC:  c9 02
            beq b15_c5aa                ; 3C5AE:  f0 fa
            jsr b15_c54f                ; 3C5B0:  20 4f c5
            lda #$00                    ; 3C5B3:  a9 00
            sta $bfff                   ; 3C5B5:  8d ff bf
            sta $bfff                   ; 3C5B8:  8d ff bf
            sta $bfff                   ; 3C5BB:  8d ff bf
            hex ad 52 00 ; lda $0052    ; 3C5BE:  ad 52 00
            sta $bfff                   ; 3C5C1:  8d ff bf
            lsr a                       ; 3C5C4:  4a
            sta $bfff                   ; 3C5C5:  8d ff bf
            ldy #$00                    ; 3C5C8:  a0 00
b15_c5ca:   lda ($56),y                 ; 3C5CA:  b1 56
            sta $0200,y                 ; 3C5CC:  99 00 02
            iny                         ; 3C5CF:  c8
            tya                         ; 3C5D0:  98
            hex cd 58 00 ; cmp $0058    ; 3C5D1:  cd 58 00
            bne b15_c5ca                ; 3C5D4:  d0 f4
            lda #$00                    ; 3C5D6:  a9 00
            sta $bfff                   ; 3C5D8:  8d ff bf
            sta $bfff                   ; 3C5DB:  8d ff bf
            sta $bfff                   ; 3C5DE:  8d ff bf
            hex ad 54 00 ; lda $0054    ; 3C5E1:  ad 54 00
            sta $bfff                   ; 3C5E4:  8d ff bf
            lsr a                       ; 3C5E7:  4a
            sta $bfff                   ; 3C5E8:  8d ff bf
            ldy #$00                    ; 3C5EB:  a0 00
b15_c5ed:   lda $0200,y                 ; 3C5ED:  b9 00 02
            sta ($56),y                 ; 3C5F0:  91 56
            clc                         ; 3C5F2:  18
            hex 6d 66 00 ; adc $0066    ; 3C5F3:  6d 66 00
            hex 8d 66 00 ; sta $0066    ; 3C5F6:  8d 66 00
            hex ad 67 00 ; lda $0067    ; 3C5F9:  ad 67 00
            adc #$00                    ; 3C5FC:  69 00
            hex 8d 67 00 ; sta $0067    ; 3C5FE:  8d 67 00
            iny                         ; 3C601:  c8
            tya                         ; 3C602:  98
            hex cd 58 00 ; cmp $0058    ; 3C603:  cd 58 00
            bne b15_c5ed                ; 3C606:  d0 e5
            jsr b15_c68a                ; 3C608:  20 8a c6
            rts                         ; 3C60B:  60

            jsr b15_c54f                ; 3C60C:  20 4f c5
            lda #$00                    ; 3C60F:  a9 00
            sta $bfff                   ; 3C611:  8d ff bf
            sta $bfff                   ; 3C614:  8d ff bf
            sta $bfff                   ; 3C617:  8d ff bf
            hex ad 52 00 ; lda $0052    ; 3C61A:  ad 52 00
            sta $bfff                   ; 3C61D:  8d ff bf
            lsr a                       ; 3C620:  4a
            sta $bfff                   ; 3C621:  8d ff bf
            jsr b15_c68a                ; 3C624:  20 8a c6
            rts                         ; 3C627:  60

b15_c628:   tax                         ; 3C628:  aa
            lda #$01                    ; 3C629:  a9 01
            sta JOY1                    ; 3C62B:  8d 16 40
            lda #$00                    ; 3C62E:  a9 00
            sta JOY1                    ; 3C630:  8d 16 40
            ldy #$08                    ; 3C633:  a0 08
b15_c635:   lda JOY1,x                  ; 3C635:  bd 16 40
            lsr a                       ; 3C638:  4a
            hex 7e 6e 00 ; ror $006e,x  ; 3C639:  7e 6e 00
            dey                         ; 3C63C:  88
            bne b15_c635                ; 3C63D:  d0 f6
            rts                         ; 3C63F:  60

b15_c640:   hex ad 56 00 ; lda $0056    ; 3C640:  ad 56 00
            lsr a                       ; 3C643:  4a
            lsr a                       ; 3C644:  4a
            asl a                       ; 3C645:  0a
            asl a                       ; 3C646:  0a
            asl a                       ; 3C647:  0a
            hex 8d 68 00 ; sta $0068    ; 3C648:  8d 68 00
            hex ad 54 00 ; lda $0054    ; 3C64B:  ad 54 00
            lsr a                       ; 3C64E:  4a
            lsr a                       ; 3C64F:  4a
            clc                         ; 3C650:  18
            hex 6d 68 00 ; adc $0068    ; 3C651:  6d 68 00
            hex 8d 68 00 ; sta $0068    ; 3C654:  8d 68 00
            hex ad 52 00 ; lda $0052    ; 3C657:  ad 52 00
            asl a                       ; 3C65A:  0a
            asl a                       ; 3C65B:  0a
            adc #$20                    ; 3C65C:  69 20
            hex 8d 69 00 ; sta $0069    ; 3C65E:  8d 69 00
            clc                         ; 3C661:  18
            lda #$c0                    ; 3C662:  a9 c0
            hex 6d 68 00 ; adc $0068    ; 3C664:  6d 68 00
            hex 8d 68 00 ; sta $0068    ; 3C667:  8d 68 00
            lda #$03                    ; 3C66A:  a9 03
            hex 6d 69 00 ; adc $0069    ; 3C66C:  6d 69 00
            hex 8d 69 00 ; sta $0069    ; 3C66F:  8d 69 00
            rts                         ; 3C672:  60

b15_c673:   hex ad 54 00 ; lda $0054    ; 3C673:  ad 54 00
            and #$03                    ; 3C676:  29 03
            lsr a                       ; 3C678:  4a
            hex 8d 75 00 ; sta $0075    ; 3C679:  8d 75 00
            hex ad 56 00 ; lda $0056    ; 3C67C:  ad 56 00
            and #$03                    ; 3C67F:  29 03
            lsr a                       ; 3C681:  4a
            asl a                       ; 3C682:  0a
            hex 6d 75 00 ; adc $0075    ; 3C683:  6d 75 00
            hex 8d 75 00 ; sta $0075    ; 3C686:  8d 75 00
            rts                         ; 3C689:  60

b15_c68a:   hex ad 71 00 ; lda $0071    ; 3C68A:  ad 71 00
            ora #$80                    ; 3C68D:  09 80
            jsr b15_c6a6                ; 3C68F:  20 a6 c6
            rts                         ; 3C692:  60

b15_c693:   jsr b15_c54f                ; 3C693:  20 4f c5
            jsr b15_c537                ; 3C696:  20 37 c5
            jsr b15_c69d                ; 3C699:  20 9d c6
            rts                         ; 3C69C:  60

b15_c69d:   hex ad 72 00 ; lda $0072    ; 3C69D:  ad 72 00
            and #$e7                    ; 3C6A0:  29 e7
            jsr b15_c570                ; 3C6A2:  20 70 c5
            rts                         ; 3C6A5:  60

b15_c6a6:   sta PPUCTRL                 ; 3C6A6:  8d 00 20
            hex 8d 71 00 ; sta $0071    ; 3C6A9:  8d 71 00
            rts                         ; 3C6AC:  60

b15_c6ad:   lda #$00                    ; 3C6AD:  a9 00
            hex 8d 75 00 ; sta $0075    ; 3C6AF:  8d 75 00
            hex 8d 76 00 ; sta $0076    ; 3C6B2:  8d 76 00
            cpx #$00                    ; 3C6B5:  e0 00
b15_c6b7:   beq b15_c6cd                ; 3C6B7:  f0 14
            clc                         ; 3C6B9:  18
            tya                         ; 3C6BA:  98
            hex 6d 75 00 ; adc $0075    ; 3C6BB:  6d 75 00
            hex 8d 75 00 ; sta $0075    ; 3C6BE:  8d 75 00
            hex ad 76 00 ; lda $0076    ; 3C6C1:  ad 76 00
            adc #$00                    ; 3C6C4:  69 00
            hex 8d 76 00 ; sta $0076    ; 3C6C6:  8d 76 00
            dex                         ; 3C6C9:  ca
            jmp b15_c6b7                ; 3C6CA:  4c b7 c6

b15_c6cd:   hex ac 75 00 ; ldy $0075    ; 3C6CD:  ac 75 00
            hex ae 76 00 ; ldx $0076    ; 3C6D0:  ae 76 00
            rts                         ; 3C6D3:  60

b15_c6d4:   hex ad 74 00 ; lda $0074    ; 3C6D4:  ad 74 00
            beq b15_c710                ; 3C6D7:  f0 37
            jsr b15_c69d                ; 3C6D9:  20 9d c6
            lda #$3f                    ; 3C6DC:  a9 3f
            sta PPUADDR                 ; 3C6DE:  8d 06 20
            lda #$00                    ; 3C6E1:  a9 00
            sta PPUADDR                 ; 3C6E3:  8d 06 20
            tax                         ; 3C6E6:  aa
b15_c6e7:   lda $0700,x                 ; 3C6E7:  bd 00 07
            sta PPUDATA                 ; 3C6EA:  8d 07 20
            inx                         ; 3C6ED:  e8
            cpx #$20                    ; 3C6EE:  e0 20
            bne b15_c6e7                ; 3C6F0:  d0 f5
            lda #$3f                    ; 3C6F2:  a9 3f
            sta PPUADDR                 ; 3C6F4:  8d 06 20
            lda #$00                    ; 3C6F7:  a9 00
            sta PPUADDR                 ; 3C6F9:  8d 06 20
            sta PPUADDR                 ; 3C6FC:  8d 06 20
            sta PPUADDR                 ; 3C6FF:  8d 06 20
            sta PPUSCROLL               ; 3C702:  8d 05 20
            sta PPUSCROLL               ; 3C705:  8d 05 20
            jsr b15_c567                ; 3C708:  20 67 c5
            lda #$00                    ; 3C70B:  a9 00
            hex 8d 74 00 ; sta $0074    ; 3C70D:  8d 74 00
b15_c710:   rts                         ; 3C710:  60

b15_c711:   hex ad 69 00 ; lda $0069    ; 3C711:  ad 69 00
            sta PPUADDR                 ; 3C714:  8d 06 20
            hex ad 68 00 ; lda $0068    ; 3C717:  ad 68 00
            sta PPUADDR                 ; 3C71A:  8d 06 20
            lda PPUDATA                 ; 3C71D:  ad 07 20
            lda PPUDATA                 ; 3C720:  ad 07 20
            hex 8d 76 00 ; sta $0076    ; 3C723:  8d 76 00
            lda #$fc                    ; 3C726:  a9 fc
            hex ae 75 00 ; ldx $0075    ; 3C728:  ae 75 00
b15_c72b:   beq b15_c73b                ; 3C72B:  f0 0e
            sec                         ; 3C72D:  38
            rol a                       ; 3C72E:  2a
            rol a                       ; 3C72F:  2a
            clc                         ; 3C730:  18
            hex 2e 58 00 ; rol $0058    ; 3C731:  2e 58 00
            hex 2e 58 00 ; rol $0058    ; 3C734:  2e 58 00
            dex                         ; 3C737:  ca
            jmp b15_c72b                ; 3C738:  4c 2b c7

b15_c73b:   hex 2d 76 00 ; and $0076    ; 3C73B:  2d 76 00
            hex 0d 58 00 ; ora $0058    ; 3C73E:  0d 58 00
            hex 8d 76 00 ; sta $0076    ; 3C741:  8d 76 00
            hex ad 69 00 ; lda $0069    ; 3C744:  ad 69 00
            sta PPUADDR                 ; 3C747:  8d 06 20
            hex ad 68 00 ; lda $0068    ; 3C74A:  ad 68 00
            sta PPUADDR                 ; 3C74D:  8d 06 20
            hex ad 76 00 ; lda $0076    ; 3C750:  ad 76 00
            sta PPUDATA                 ; 3C753:  8d 07 20
            rts                         ; 3C756:  60

b15_c757:   jsr b15_c693                ; 3C757:  20 93 c6
            lda #$00                    ; 3C75A:  a9 00
            sta PPUADDR                 ; 3C75C:  8d 06 20
            sta PPUADDR                 ; 3C75F:  8d 06 20
            ldx #$00                    ; 3C762:  a2 00
            lda #$ff                    ; 3C764:  a9 ff
b15_c766:   lda tab_b15_c775,x          ; 3C766:  bd 75 c7
            sta PPUDATA                 ; 3C769:  8d 07 20
            inx                         ; 3C76C:  e8
            cpx #$30                    ; 3C76D:  e0 30
            bne b15_c766                ; 3C76F:  d0 f5
            jsr b15_c558                ; 3C771:  20 58 c5
            rts                         ; 3C774:  60

tab_b15_c775: ; 17 bytes
            hex ff ff ff ff ff ff ff ff ; 3C775:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C77D:  ff ff ff ff ff ff ff ff
            hex 60                      ; 3C785:  60

            sei                         ; 3C786:  78
            ror $7e7f,x                 ; 3C787:  7e 7f 7e
            sei                         ; 3C78A:  78
            rts                         ; 3C78B:  60

            brk                         ; 3C78C:  00
            hex 60                      ; 3C78D:  60
            sei                         ; 3C78E:  78
            ror $7e7f,x                 ; 3C78F:  7e 7f 7e
            sei                         ; 3C792:  78
            rts                         ; 3C793:  60

tab_b15_c794: ; 22 bytes
            hex 00 00 00 00 00 00 00 00 ; 3C794:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 3C79C:  00 00 00 00 00 00 00 00
            hex 00 20 ac c7 20 17       ; 3C7A4:  00 20 ac c7 20 17

            iny                         ; 3C7AA:  c8
            rts                         ; 3C7AB:  60

            lda #$00                    ; 3C7AC:  a9 00
            hex 8d 79 00 ; sta $0079    ; 3C7AE:  8d 79 00
            lda #$34                    ; 3C7B1:  a9 34
            hex 8d 7a 00 ; sta $007a    ; 3C7B3:  8d 7a 00
            lda #$07                    ; 3C7B6:  a9 07
            hex 8d 7b 00 ; sta $007b    ; 3C7B8:  8d 7b 00
b15_c7bb:   jsr b15_c7de                ; 3C7BB:  20 de c7
            jsr b15_c7c9                ; 3C7BE:  20 c9 c7
            hex ad 79 00 ; lda $0079    ; 3C7C1:  ad 79 00
            cmp #$05                    ; 3C7C4:  c9 05
            bne b15_c7bb                ; 3C7C6:  d0 f3
            rts                         ; 3C7C8:  60

b15_c7c9:   hex ee 79 00 ; inc $0079    ; 3C7C9:  ee 79 00
            hex ad 7a 00 ; lda $007a    ; 3C7CC:  ad 7a 00
            clc                         ; 3C7CF:  18
            adc #$09                    ; 3C7D0:  69 09
            hex 8d 7a 00 ; sta $007a    ; 3C7D2:  8d 7a 00
            hex ad 7b 00 ; lda $007b    ; 3C7D5:  ad 7b 00
            adc #$00                    ; 3C7D8:  69 00
            hex 8d 7b 00 ; sta $007b    ; 3C7DA:  8d 7b 00
            rts                         ; 3C7DD:  60

b15_c7de:   ldy #$00                    ; 3C7DE:  a0 00
            lda ($7a),y                 ; 3C7E0:  b1 7a
            beq b15_c7ee                ; 3C7E2:  f0 0a
            cmp #$05                    ; 3C7E4:  c9 05
            bcc b15_c7eb                ; 3C7E6:  90 03
            jmp b15_c7ee                ; 3C7E8:  4c ee c7

b15_c7eb:   jsr b15_c7ef                ; 3C7EB:  20 ef c7
b15_c7ee:   rts                         ; 3C7EE:  60

b15_c7ef:   tax                         ; 3C7EF:  aa
            dex                         ; 3C7F0:  ca
            txa                         ; 3C7F1:  8a
            clc                         ; 3C7F2:  18
            adc #$05                    ; 3C7F3:  69 05
            ldy #$00                    ; 3C7F5:  a0 00
            sta ($7a),y                 ; 3C7F7:  91 7a
            txa                         ; 3C7F9:  8a
            asl a                       ; 3C7FA:  0a
            asl a                       ; 3C7FB:  0a
            tax                         ; 3C7FC:  aa
            lda $0720                   ; 3C7FD:  ad 20 07
            beq b15_c809                ; 3C800:  f0 07
            hex ad 79 00 ; lda $0079    ; 3C802:  ad 79 00
            cmp #$02                    ; 3C805:  c9 02
            beq b15_c816                ; 3C807:  f0 0d
b15_c809:   ldy #$01                    ; 3C809:  a0 01
b15_c80b:   lda ($7a),y                 ; 3C80B:  b1 7a
            sta SQ1_VOL,x               ; 3C80D:  9d 00 40
            inx                         ; 3C810:  e8
            iny                         ; 3C811:  c8
            cpy #$05                    ; 3C812:  c0 05
            bne b15_c80b                ; 3C814:  d0 f5
b15_c816:   rts                         ; 3C816:  60

            lda #$00                    ; 3C817:  a9 00
            hex 8d 79 00 ; sta $0079    ; 3C819:  8d 79 00
            lda #$34                    ; 3C81C:  a9 34
            hex 8d 7a 00 ; sta $007a    ; 3C81E:  8d 7a 00
            lda #$07                    ; 3C821:  a9 07
            hex 8d 7b 00 ; sta $007b    ; 3C823:  8d 7b 00
b15_c826:   hex ad 79 00 ; lda $0079    ; 3C826:  ad 79 00
            tax                         ; 3C829:  aa
            lda $0720,x                 ; 3C82A:  bd 20 07
            beq b15_c832                ; 3C82D:  f0 03
            jsr b15_c83d                ; 3C82F:  20 3d c8
b15_c832:   jsr b15_c7c9                ; 3C832:  20 c9 c7
            hex ad 79 00 ; lda $0079    ; 3C835:  ad 79 00
            cmp #$05                    ; 3C838:  c9 05
            bne b15_c826                ; 3C83A:  d0 ea
            rts                         ; 3C83C:  60

b15_c83d:   ldy #$00                    ; 3C83D:  a0 00
            lda ($7a),y                 ; 3C83F:  b1 7a
            cmp #$05                    ; 3C841:  c9 05
            bcc b15_c850                ; 3C843:  90 0b
            jsr b15_c8c4                ; 3C845:  20 c4 c8
            bne tab_b15_c856            ; 3C848:  d0 0c
b15_c84a:   jsr b15_c8ce                ; 3C84A:  20 ce c8
            jmp tab_b15_c856            ; 3C84D:  4c 56 c8

b15_c850:   jsr b15_c857                ; 3C850:  20 57 c8
            jmp b15_c84a                ; 3C853:  4c 4a c8

tab_b15_c856: ; 1 bytes
            hex 60                      ; 3C856:  60

b15_c857:   jsr b15_c877                ; 3C857:  20 77 c8
            jsr b15_c894                ; 3C85A:  20 94 c8
            ldy #$00                    ; 3C85D:  a0 00
            sta ($7a),y                 ; 3C85F:  91 7a
            jsr b15_c894                ; 3C861:  20 94 c8
            ldy #$01                    ; 3C864:  a0 01
            sta ($7a),y                 ; 3C866:  91 7a
            jsr b15_c894                ; 3C868:  20 94 c8
            ldy #$02                    ; 3C86B:  a0 02
            sta ($7a),y                 ; 3C86D:  91 7a
            jsr b15_c894                ; 3C86F:  20 94 c8
            ldy #$04                    ; 3C872:  a0 04
            sta ($7a),y                 ; 3C874:  91 7a
            rts                         ; 3C876:  60

b15_c877:   hex ad 79 00 ; lda $0079    ; 3C877:  ad 79 00
            asl a                       ; 3C87A:  0a
            clc                         ; 3C87B:  18
            hex 6d 79 00 ; adc $0079    ; 3C87C:  6d 79 00
            tax                         ; 3C87F:  aa
            lda $0725,x                 ; 3C880:  bd 25 07
            ldy #$05                    ; 3C883:  a0 05
            sta ($7a),y                 ; 3C885:  91 7a
            lda $0726,x                 ; 3C887:  bd 26 07
            iny                         ; 3C88A:  c8
            sta ($7a),y                 ; 3C88B:  91 7a
            iny                         ; 3C88D:  c8
            lda $0727,x                 ; 3C88E:  bd 27 07
            sta ($7a),y                 ; 3C891:  91 7a
            rts                         ; 3C893:  60

b15_c894:   hex ad 73 00 ; lda $0073    ; 3C894:  ad 73 00
            pha                         ; 3C897:  48
            ldy #$05                    ; 3C898:  a0 05
            lda ($7a),y                 ; 3C89A:  b1 7a
            jsr b15_c577                ; 3C89C:  20 77 c5
            ldy #$06                    ; 3C89F:  a0 06
            lda ($7a),y                 ; 3C8A1:  b1 7a
            hex 8d 7c 00 ; sta $007c    ; 3C8A3:  8d 7c 00
            clc                         ; 3C8A6:  18
            adc #$01                    ; 3C8A7:  69 01
            sta ($7a),y                 ; 3C8A9:  91 7a
            iny                         ; 3C8AB:  c8
            lda ($7a),y                 ; 3C8AC:  b1 7a
            hex 8d 7d 00 ; sta $007d    ; 3C8AE:  8d 7d 00
            adc #$00                    ; 3C8B1:  69 00
            sta ($7a),y                 ; 3C8B3:  91 7a
            ldx #$00                    ; 3C8B5:  a2 00
            lda ($7c,x)                 ; 3C8B7:  a1 7c
            hex 8d 7e 00 ; sta $007e    ; 3C8B9:  8d 7e 00
            pla                         ; 3C8BC:  68
            jsr b15_c577                ; 3C8BD:  20 77 c5
            hex ad 7e 00 ; lda $007e    ; 3C8C0:  ad 7e 00
            rts                         ; 3C8C3:  60

b15_c8c4:   ldy #$08                    ; 3C8C4:  a0 08
            lda ($7a),y                 ; 3C8C6:  b1 7a
            tax                         ; 3C8C8:  aa
            dex                         ; 3C8C9:  ca
            txa                         ; 3C8CA:  8a
            sta ($7a),y                 ; 3C8CB:  91 7a
            rts                         ; 3C8CD:  60

b15_c8ce:   jsr b15_c894                ; 3C8CE:  20 94 c8
            cmp #$f0                    ; 3C8D1:  c9 f0
            bcs b15_c8de                ; 3C8D3:  b0 09
            jsr b15_c929                ; 3C8D5:  20 29 c9
            jsr b15_c990                ; 3C8D8:  20 90 c9
            jmp b15_c8e3                ; 3C8DB:  4c e3 c8

b15_c8de:   jsr b15_c8e4                ; 3C8DE:  20 e4 c8
            bcc b15_c8ce                ; 3C8E1:  90 eb
b15_c8e3:   rts                         ; 3C8E3:  60

b15_c8e4:   cmp #$f0                    ; 3C8E4:  c9 f0
            beq b15_c8eb                ; 3C8E6:  f0 03
            jmp b15_c906                ; 3C8E8:  4c 06 c9

b15_c8eb:   ldy #$00                    ; 3C8EB:  a0 00
            lda ($7a),y                 ; 3C8ED:  b1 7a
            sec                         ; 3C8EF:  38
            sbc #$05                    ; 3C8F0:  e9 05
            asl a                       ; 3C8F2:  0a
            asl a                       ; 3C8F3:  0a
            tax                         ; 3C8F4:  aa
            lda #$00                    ; 3C8F5:  a9 00
            sta SQ1_VOL,x               ; 3C8F7:  9d 00 40
            hex ae 79 00 ; ldx $0079    ; 3C8FA:  ae 79 00
            lda #$00                    ; 3C8FD:  a9 00
            sta $0720,x                 ; 3C8FF:  9d 20 07
            sta ($7a),y                 ; 3C902:  91 7a
            sec                         ; 3C904:  38
            rts                         ; 3C905:  60

b15_c906:   hex ad 79 00 ; lda $0079    ; 3C906:  ad 79 00
            asl a                       ; 3C909:  0a
            clc                         ; 3C90A:  18
            hex 6d 79 00 ; adc $0079    ; 3C90B:  6d 79 00
            tax                         ; 3C90E:  aa
            ldy #$05                    ; 3C90F:  a0 05
            lda $0725,x                 ; 3C911:  bd 25 07
            sta ($7a),y                 ; 3C914:  91 7a
            iny                         ; 3C916:  c8
            lda $0726,x                 ; 3C917:  bd 26 07
            sta ($7a),y                 ; 3C91A:  91 7a
            iny                         ; 3C91C:  c8
            lda $0727,x                 ; 3C91D:  bd 27 07
            sta ($7a),y                 ; 3C920:  91 7a
            ldy #$00                    ; 3C922:  a0 00
            lda #$00                    ; 3C924:  a9 00
            sta ($7a),y                 ; 3C926:  91 7a
            rts                         ; 3C928:  60

b15_c929:   jsr b15_c94b                ; 3C929:  20 4b c9
            ldy #$04                    ; 3C92C:  a0 04
            lda ($7a),y                 ; 3C92E:  b1 7a
            and #$f8                    ; 3C930:  29 f8
            hex 0d 7f 00 ; ora $007f    ; 3C932:  0d 7f 00
            sta ($7a),y                 ; 3C935:  91 7a
            dey                         ; 3C937:  88
            hex ad 7e 00 ; lda $007e    ; 3C938:  ad 7e 00
            sta ($7a),y                 ; 3C93B:  91 7a
            ldy #$00                    ; 3C93D:  a0 00
            lda ($7a),y                 ; 3C93F:  b1 7a
            cmp #$05                    ; 3C941:  c9 05
            bcc b15_c94a                ; 3C943:  90 05
            sec                         ; 3C945:  38
            sbc #$04                    ; 3C946:  e9 04
            sta ($7a),y                 ; 3C948:  91 7a
b15_c94a:   rts                         ; 3C94A:  60

b15_c94b:   pha                         ; 3C94B:  48
            and #$0f                    ; 3C94C:  29 0f
            asl a                       ; 3C94E:  0a
            tax                         ; 3C94F:  aa
            lda tab_b15_c96f+1,x        ; 3C950:  bd 70 c9
            hex 8d 7e 00 ; sta $007e    ; 3C953:  8d 7e 00
            inx                         ; 3C956:  e8
            lda tab_b15_c96f+1,x        ; 3C957:  bd 70 c9
            hex 8d 7f 00 ; sta $007f    ; 3C95A:  8d 7f 00
            pla                         ; 3C95D:  68
            lsr a                       ; 3C95E:  4a
            lsr a                       ; 3C95F:  4a
            lsr a                       ; 3C960:  4a
            lsr a                       ; 3C961:  4a
            tax                         ; 3C962:  aa
b15_c963:   beq tab_b15_c96f            ; 3C963:  f0 0a
            hex 4e 7f 00 ; lsr $007f    ; 3C965:  4e 7f 00
            hex 6e 7e 00 ; ror $007e    ; 3C968:  6e 7e 00
            dex                         ; 3C96B:  ca
            jmp b15_c963                ; 3C96C:  4c 63 c9

tab_b15_c96f: ; 25 bytes
            hex 60 f9 03 c0 03 8a 03 57 ; 3C96F:  60 f9 03 c0 03 8a 03 57
            hex 03 27 03 fa 02 cf 02 a7 ; 3C977:  03 27 03 fa 02 cf 02 a7
            hex 02 81 02 5d 02 3b 02 1b ; 3C97F:  02 81 02 5d 02 3b 02 1b
            hex 02                      ; 3C987:  02

            brk                         ; 3C988:  00
            hex 00                      ; 3C989:  00
            brk                         ; 3C98A:  00
            hex 00                      ; 3C98B:  00
            brk                         ; 3C98C:  00
            hex 00                      ; 3C98D:  00
            brk                         ; 3C98E:  00
            hex 00                      ; 3C98F:  00
b15_c990:   jsr b15_c894                ; 3C990:  20 94 c8
            asl a                       ; 3C993:  0a
            asl a                       ; 3C994:  0a
            asl a                       ; 3C995:  0a
            ldy #$08                    ; 3C996:  a0 08
            sta ($7a),y                 ; 3C998:  91 7a
            rts                         ; 3C99A:  60

            hex ff ff ff ff ff ff ff ff ; 3C99B:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9A3:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9AB:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9B3:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9BB:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9C3:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9CB:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9D3:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9DB:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9E3:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9EB:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3C9F3:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff 4c 00 00 ; 3C9FB:  ff ff ff ff ff 4c 00 00
            hex 20 23 e8 00 00 0c a8 e5 ; 3CA03:  20 23 e8 00 00 0c a8 e5
            hex 7f 6a e9 b1 cb 02 cf 20 ; 3CA0B:  7f 6a e9 b1 cb 02 cf 20
            hex 23 e8 00 00 3c a0 0d 00 ; 3CA13:  23 e8 00 00 3c a0 0d 00
            hex b3 0c d3 b4 c2 d8 27    ; 3CA1B:  b3 0c d3 b4 c2 d8 27

            dex                         ; 3CA22:  ca
            rti                         ; 3CA23:  40

            hex d6 2f ca a0 0d 00 b3 0c ; 3CA24:  d6 2f ca a0 0d 00 b3 0c
            hex d3 b4 bc d4 cf 20 23 e8 ; 3CA2C:  d3 b4 bc d4 cf 20 23 e8
            hex fe ff 0c b0 1d bc 2b 50 ; 3CA34:  fe ff 0c b0 1d bc 2b 50
            hex c2 d8 42                ; 3CA3C:  c2 d8 42

            dex                         ; 3CA3F:  ca
            rti                         ; 3CA40:  40

            hex 2b 3c 0b b1 cf 20 23 e8 ; 3CA41:  2b 3c 0b b1 cf 20 23 e8
            hex 00 00 8d 11 e9 26 f2 02 ; 3CA49:  00 00 8d 11 e9 26 f2 02
            hex cf 20 23 e8 00 00 0c 51 ; 3CA51:  cf 20 23 e8 00 00 0c 51
            hex c2 d8 5f                ; 3CA59:  c2 d8 5f

            dex                         ; 3CA5C:  ca
            rti                         ; 3CA5D:  40

            hex cf ac 46 ca 1c b9 cf 20 ; 3CA5E:  cf ac 46 ca 1c b9 cf 20
            hex 23 e8 00 00 89 30 1c c7 ; 3CA66:  23 e8 00 00 89 30 1c c7
            hex d8 78 ca 0c 8b 39 c7 d7 ; 3CA6E:  d8 78 ca 0c 8b 39 c7 d7
            hex 7c                      ; 3CA76:  7c

            dex                         ; 3CA77:  ca
            rti                         ; 3CA78:  40

            hex d6 7d ca 41 cf 20 23 e8 ; 3CA79:  d6 7d ca 41 cf 20 23 e8
            hex fe ff 40 2b d6 90 ca 0c ; 3CA81:  fe ff 40 2b d6 90 ca 0c
            hex d0 2c d1 0b d0 2b d1 0c ; 3CA89:  d0 2c d1 0b d0 2b d1 0c
            hex d3 d7 88 ca 0b cf 20 23 ; 3CA91:  d3 d7 88 ca 0b cf 20 23
            hex e8 00 00 d6 ab ca 0c d0 ; 3CA99:  e8 00 00 d6 ab ca 0c d0
            hex 2c d1 b3 a0 0f 00 d4 0d ; 3CAA1:  2c d1 b3 a0 0f 00 d4 0d
            hex d1 2d 0d d7 9f ca cf 20 ; 3CAA9:  d1 2d 0d d7 9f ca cf 20
            hex 23 e8 00 00 d6 c7 ca 0c ; 3CAB1:  23 e8 00 00 d6 c7 ca 0c
            hex d3 d7 bf                ; 3CAB9:  d3 d7 bf

            dex                         ; 3CABC:  ca
            rti                         ; 3CABD:  40

            hex cf 0c d0 2c d1 0d d0 2d ; 3CABE:  cf 0c d0 2c d1 0d d0 2d
            hex d1 0d d3 b3 0c d3 b4 c0 ; 3CAC6:  d1 0d d3 b3 0c d3 b4 c0
            hex d7 b8 ca 0d d3 b3 0c d3 ; 3CACE:  d7 b8 ca 0d d3 b3 0c d3
            hex b4 bc cf 20 23 e8 fe ff ; 3CAD6:  b4 bc cf 20 23 e8 fe ff
            hex 0c 2b 0c d0 2c d1 b3 0d ; 3CADE:  0c 2b 0c d0 2c d1 b3 0d
            hex d0 2d d1 d3 d4 d7 e0 ca ; 3CAE6:  d0 2d d1 d3 d4 d7 e0 ca
            hex 0b cf 20 23 e8 00 00 d6 ; 3CAEE:  0b cf 20 23 e8 00 00 d6
            hex 0b cb a0 0d 00 b3 0c d3 ; 3CAF6:  0b cb a0 0d 00 b3 0c d3
            hex b4 c0 d8 05 cb 0c cf 0c ; 3CAFE:  b4 c0 d8 05 cb 0c cf 0c

            bne tab_b15_cb10+36         ; 3CB06:  d0 2c
            asl $2ed1                   ; 3CB08:  0e d1 2e
            asl b15_f8d7                ; 3CB0B:  0e d7 f8
            dex                         ; 3CB0E:  ca
            rti                         ; 3CB0F:  40

tab_b15_cb10: ; 189 bytes
            hex cf 20 23 e8 00 00 a0 0b ; 3CB10:  cf 20 23 e8 00 00 a0 0b
            hex 00 b3 89 61 b4 c3 d8 2a ; 3CB18:  00 b3 89 61 b4 c3 d8 2a
            hex cb a0 0b 00 8b 7a c3 d7 ; 3CB20:  cb a0 0b 00 8b 7a c3 d7
            hex 2e cb 40 d6 2f cb 41 cf ; 3CB28:  2e cb 40 d6 2f cb 41 cf
            hex 20 23 e8 00 00 a0 0b 00 ; 3CB30:  20 23 e8 00 00 a0 0b 00
            hex b3 e9 11 cb 02 d8 48 cb ; 3CB38:  b3 e9 11 cb 02 d8 48 cb
            hex a0 0b 00 8f e0 d6 4b cb ; 3CB40:  a0 0b 00 8f e0 d6 4b cb
            hex a0 0b 00 cf 20 23 e8 00 ; 3CB48:  a0 0b 00 cf 20 23 e8 00
            hex 00 0c 50 c2 d8 5c cb 0c ; 3CB50:  00 0c 50 c2 d8 5c cb 0c
            hex cb d6 5d cb 0c cf 20 23 ; 3CB58:  cb d6 5d cb 0c cf 20 23
            hex e8 00 00 0c 1d c2 d8 6d ; 3CB60:  e8 00 00 0c 1d c2 d8 6d
            hex cb 0c d6 6e cb 0d cf 20 ; 3CB68:  cb 0c d6 6e cb 0d cf 20
            hex 23 e8 00 00 0c 1d c4 d8 ; 3CB70:  23 e8 00 00 0c 1d c4 d8
            hex 7e cb 0c d6 7f cb 0d cf ; 3CB78:  7e cb 0c d6 7f cb 0d cf
            hex 20 23 e8 ff ff 0c d3 a2 ; 3CB80:  20 23 e8 ff ff 0c d3 a2
            hex ff ff 3c 0d d3 d4 3d a0 ; 3CB88:  ff ff 3c 0d d3 d4 3d a0
            hex ff ff d4 cf 20 23 e8 fe ; 3CB90:  ff ff d4 cf 20 23 e8 fe
            hex ff 0c b0 2b 3c 0d b0 b1 ; 3CB98:  ff 0c b0 2b 3c 0d b0 b1
            hex 3d 0b b1 cf 20 23 e8 00 ; 3CBA0:  3d 0b b1 cf 20 23 e8 00
            hex 00 3c 8d 15 e9 26 f2 04 ; 3CBA8:  00 3c 8d 15 e9 26 f2 04
            hex cf 20 23 e8 00 00 3c 67 ; 3CBB0:  cf 20 23 e8 00 00 3c 67
            hex e9 26 f2 04 cf 20 23 e8 ; 3CBB8:  e9 26 f2 04 cf 20 23 e8
            hex 00 00 3f 3e 3d 3c 8d 10 ; 3CBC0:  00 00 3f 3e 3d 3c 8d 10
            hex e9 26 f2 0a cf          ; 3CBC8:  e9 26 f2 0a cf

            lda #$ff                    ; 3CBCD:  a9 ff
            sta $08                     ; 3CBCF:  85 08
            sta $09                     ; 3CBD1:  85 09
            ldy #$03                    ; 3CBD3:  a0 03
            lda ($02),y                 ; 3CBD5:  b1 02
            bmi b15_cc34                ; 3CBD7:  30 5b
            sta $44                     ; 3CBD9:  85 44
            dey                         ; 3CBDB:  88
            lda ($02),y                 ; 3CBDC:  b1 02
            sta $45                     ; 3CBDE:  85 45
            lda #$00                    ; 3CBE0:  a9 00
            sta $40                     ; 3CBE2:  85 40
            sta $41                     ; 3CBE4:  85 41
            sta $42                     ; 3CBE6:  85 42
            sta $43                     ; 3CBE8:  85 43
            ldx #$08                    ; 3CBEA:  a2 08
b15_cbec:   asl $45                     ; 3CBEC:  06 45
            rol $44                     ; 3CBEE:  26 44
            rol $43                     ; 3CBF0:  26 43
            rol $42                     ; 3CBF2:  26 42
            asl $45                     ; 3CBF4:  06 45
            rol $44                     ; 3CBF6:  26 44
            rol $43                     ; 3CBF8:  26 43
            rol $42                     ; 3CBFA:  26 42
            sec                         ; 3CBFC:  38
            rol $41                     ; 3CBFD:  26 41
            rol $40                     ; 3CBFF:  26 40
            ldy #$02                    ; 3CC01:  a0 02
            sec                         ; 3CC03:  38
            lda $43                     ; 3CC04:  a5 43
            sbc $41                     ; 3CC06:  e5 41
            sta $43                     ; 3CC08:  85 43
            lda $42                     ; 3CC0A:  a5 42
            sbc $40                     ; 3CC0C:  e5 40
            sta $42                     ; 3CC0E:  85 42
            bcs b15_cc20                ; 3CC10:  b0 0e
            ldy #$00                    ; 3CC12:  a0 00
            lda $43                     ; 3CC14:  a5 43
            adc $41                     ; 3CC16:  65 41
            sta $43                     ; 3CC18:  85 43
            lda $42                     ; 3CC1A:  a5 42
            adc $40                     ; 3CC1C:  65 40
            sta $42                     ; 3CC1E:  85 42
b15_cc20:   tya                         ; 3CC20:  98
            ora $41                     ; 3CC21:  05 41
            and #$fe                    ; 3CC23:  29 fe
            sta $41                     ; 3CC25:  85 41
            dex                         ; 3CC27:  ca
            bne b15_cbec                ; 3CC28:  d0 c2
            lda $40                     ; 3CC2A:  a5 40
            lsr a                       ; 3CC2C:  4a
            sta $09                     ; 3CC2D:  85 09
            lda $41                     ; 3CC2F:  a5 41
            ror a                       ; 3CC31:  6a
            sta $08                     ; 3CC32:  85 08
b15_cc34:   rts                         ; 3CC34:  60

            hex 20 23 e8 00 00 3c 8d 12 ; 3CC35:  20 23 e8 00 00 3c 8d 12
            hex e9 26 f2 04 cf 20 23 e8 ; 3CC3D:  e9 26 f2 04 cf 20 23 e8
            hex 00 00 87 13 3f          ; 3CC45:  00 00 87 13 3f

            rol $3c3d,x                 ; 3CC4A:  3e 3d 3c
            rts                         ; 3CC4D:  60

            hex 6c e9 26 f2 0e cf 20 23 ; 3CC4E:  6c e9 26 f2 0e cf 20 23
            hex e8 00 00 87 15 87 13 3f ; 3CC56:  e8 00 00 87 15 87 13 3f

            rol $3c3d,x                 ; 3CC5E:  3e 3d 3c
            rts                         ; 3CC61:  60

            hex 8d 14 e9 26 f2 10 cf 20 ; 3CC62:  8d 14 e9 26 f2 10 cf 20
            hex 23 e8 00 00 61 8d 12 8d ; 3CC6A:  23 e8 00 00 61 8d 12 8d
            hex 1d 67 8d 16 e9 42 cc 0a ; 3CC72:  1d 67 8d 16 e9 42 cc 0a
            hex cf 20 23 e8 00 00 0c a8 ; 3CC7A:  cf 20 23 e8 00 00 0c a8
            hex cd 7f 0d a8 cf 7f cf 20 ; 3CC82:  cd 7f 0d a8 cf 7f cf 20
            hex 23 e8 00 00 61 8d 19 8d ; 3CC8A:  23 e8 00 00 61 8d 19 8d
            hex 13 a4 d1 7f d8 9e cc 89 ; 3CC92:  13 a4 d1 7f d8 9e cc 89
            hex 14 d6 a0 cc 89 16 b3 62 ; 3CC9A:  14 d6 a0 cc 89 16 b3 62
            hex e9 42 cc 0a a4 d1 7f d8 ; 3CCA2:  e9 42 cc 0a a4 d1 7f d8
            hex b1 cc 89 14 d6 b3 cc 89 ; 3CCAA:  b1 cc 89 14 d6 b3 cc 89
            hex 16 b3 62 e9 7b cc 04 cf ; 3CCB2:  16 b3 62 e9 7b cc 04 cf
            hex 20 23 e8 00 00 61 8d 19 ; 3CCBA:  20 23 e8 00 00 61 8d 19
            hex 8d 1d 8d 14 8d 14 e9 42 ; 3CCC2:  8d 1d 8d 14 8d 14 e9 42
            hex cc 0a 40 a8 f9 7b cf 20 ; 3CCCA:  cc 0a 40 a8 f9 7b cf 20
            hex 23 e8 00 00 61 63 8d 1d ; 3CCD2:  23 e8 00 00 61 63 8d 1d
            hex 63 62 e9 42 cc 0a cf 20 ; 3CCDA:  63 62 e9 42 cc 0a cf 20
            hex 23 e8 00 00 61 8d 1a 8d ; 3CCE2:  23 e8 00 00 61 8d 1a 8d
            hex 1d 8d 1a 62 e9 42 cc 0a ; 3CCEA:  1d 8d 1a 62 e9 42 cc 0a
            hex 8a ff 00 a8 df 7f cf 20 ; 3CCF2:  8a ff 00 a8 df 7f cf 20
            hex 23 e8 00 00 61 8d 13    ; 3CCFA:  23 e8 00 00 61 8d 13

            sta $641f                   ; 3CD01:  8d 1f 64
            rts                         ; 3CD04:  60

            hex e9 42 cc 0a a4 5d 6f 8c ; 3CD05:  e9 42 cc 0a a4 5d 6f 8c
            hex ff 00 c1 d8 1f cd a4 5d ; 3CD0D:  ff 00 c1 d8 1f cd a4 5d
            hex 6f a8 e6 7b 8a ff 00 a8 ; 3CD15:  6f a8 e6 7b 8a ff 00 a8
            hex 5d 6f cf 20 23 e8 fe ff ; 3CD1D:  5d 6f cf 20 23 e8 fe ff
            hex 61 e9 35 cc 02 ac 50 cf ; 3CD25:  61 e9 35 cc 02 ac 50 cf
            hex ac 5d cf a4 c9 7f d8 4f ; 3CD2D:  ac 5d cf a4 c9 7f d8 4f
            hex cd 8d 21 67 e9 8b cf 04 ; 3CD35:  cd 8d 21 67 e9 8b cf 04
            hex 8d 30 6b e9 8b cf 04 8d ; 3CD3D:  8d 30 6b e9 8b cf 04 8d
            hex 30 6f e9 8b cf 04 40 a8 ; 3CD45:  30 6f e9 8b cf 04 40 a8
            hex c9 7f a4 c7 7f d8 7e cd ; 3CD4D:  c9 7f a4 c7 7f d8 7e cd
            hex 40 2b 0b d2 8c 7a f6 bb ; 3CD55:  40 2b 0b d2 8c 7a f6 bb
            hex b0 b3 3b e9 8b cf 04 0b ; 3CD5D:  b0 b3 3b e9 8b cf 04 0b
            hex d0 2b 0b 54 c6 d7 57 cd ; 3CD65:  d0 2b 0b 54 c6 d7 57 cd
            hex 8d 24 8e b0 15 8e 5c 84 ; 3CD6D:  8d 24 8e b0 15 8e 5c 84
            hex 64 e9 7c cf             ; 3CD75:  64 e9 7c cf

            php                         ; 3CD79:  08
            rti                         ; 3CD7A:  40

            hex a8 c7 7f 60 e9 35 cc 02 ; 3CD7B:  a8 c7 7f 60 e9 35 cc 02
            hex a4 5d 6f 8c ff 00 c1 d8 ; 3CD83:  a4 5d 6f 8c ff 00 c1 d8
            hex 99 cd a4 5d 6f a8 e6 7b ; 3CD8B:  99 cd a4 5d 6f a8 e6 7b
            hex 8a ff 00 a8 5d 6f 8a ff ; 3CD93:  8a ff 00 a8 5d 6f 8a ff
            hex 00 a8 df 7f 8d 14 62 e9 ; 3CD9B:  00 a8 df 7f 8d 14 62 e9
            hex 7b cc 04 40 a8 f9 7b 40 ; 3CDA3:  7b cc 04 40 a8 f9 7b 40
            hex a8 fb 7b cf 20 23 e8 00 ; 3CDAB:  a8 fb 7b cf 20 23 e8 00
            hex 00 42 a8 cd 7f a4 cf 7f ; 3CDB3:  00 42 a8 cd 7f a4 cf 7f
            hex d0 a8 cf 7f 8b 1b c8 d8 ; 3CDBB:  d0 a8 cf 7f 8b 1b c8 d8
            hex c9 cd 43 a8 cf 7f cf 20 ; 3CDC3:  c9 cd 43 a8 cf 7f cf 20
            hex 23 e8 00 00 a0 0b 00 8b ; 3CDCB:  23 e8 00 00 a0 0b 00 8b
            hex 5f c5 d8 f4 cd a0 0b 00 ; 3CDD3:  5f c5 d8 f4 cd a0 0b 00
            hex 8b 7a c3 d8 f4 cd 89 2f ; 3CDDB:  8b 7a c3 d8 f4 cd 89 2f
            hex d6 11 ce a0 0b 00 8b 5a ; 3CDE3:  d6 11 ce a0 0b 00 8b 5a
            hex c3 d8 fd cd 89 2b d6 11 ; 3CDEB:  c3 d8 fd cd 89 2b d6 11
            hex ce a0 0b 00 8b 41 c5 d7 ; 3CDF3:  ce a0 0b 00 8b 41 c5 d7
            hex e6 cd a0 0b 00 8b 2d c5 ; 3CDFB:  e6 cd a0 0b 00 8b 2d c5
            hex d8 1d ce a0 0b 00 8b 3a ; 3CE03:  d8 1d ce a0 0b 00 8b 3a
            hex c3 d8 1d ce 89 28 cd a0 ; 3CE0B:  c3 d8 1d ce 89 28 cd a0
            hex 0b 00 bc a2 0b 00 a0 0b ; 3CE13:  0b 00 bc a2 0b 00 a0 0b
            hex 00 cf a0 0b 00 d9 0c 00 ; 3CE1B:  00 cf a0 0b 00 d9 0c 00
            hex 20 00 55 ce 21 00 55 ce ; 3CE23:  20 00 55 ce 21 00 55 ce
            hex 23 00 5a ce 25 00 5f ce ; 3CE2B:  23 00 5a ce 25 00 5f ce
            hex 28 00 64 ce 29 00 64 ce ; 3CE33:  28 00 64 ce 29 00 64 ce
            hex 2a 00 69 ce 2b 00 69 ce ; 3CE3B:  2a 00 69 ce 2b 00 69 ce
            hex 2c 00 69 ce 3c 00 73 ce ; 3CE43:  2c 00 69 ce 3c 00 73 ce
            hex 3e 00 78 ce 3f 00 78 ce ; 3CE4B:  3e 00 78 ce 3f 00 78 ce
            hex 7d ce 89 1f d6 11 ce 89 ; 3CE53:  7d ce 89 1f d6 11 ce 89
            hex 4c d6 16 ce 89 4d d6 16 ; 3CE5B:  4c d6 16 ce 89 4d d6 16
            hex ce 89 25 d6 11 ce 89 24 ; 3CE63:  ce 89 25 d6 11 ce 89 24
            hex cd a0 0b 00 bb d6 16 ce ; 3CE6B:  cd a0 0b 00 bb d6 16 ce
            hex 89 13 d6 16 ce 89 2a d6 ; 3CE73:  89 13 d6 16 ce 89 2a d6
            hex 11 ce 40 d6 16 ce 20 23 ; 3CE7B:  11 ce 40 d6 16 ce 20 23
            hex e8 00 00 a0 0b 00 5a c0 ; 3CE83:  e8 00 00 a0 0b 00 5a c0
            hex d8 92 ce ac af cd cf a0 ; 3CE8B:  d8 92 ce ac af cd cf a0
            hex 0b 00 b3 e9 ca cd 02 a2 ; 3CE93:  0b 00 b3 e9 ca cd 02 a2
            hex 0b 00 a0 0b 00 b3 aa cf ; 3CE9B:  0b 00 a0 0b 00 b3 aa cf
            hex 7f aa cd 7f aa cf 7f    ; 3CEA3:  7f aa cd 7f aa cf 7f

            tax                         ; 3CEAA:  aa
            cmp $607f                   ; 3CEAB:  cd 7f 60
            jmp ($26e9)                 ; 3CEAE:  6c e9 26

tab_b15_ceb1: ; 154 bytes
            hex f2 0e a4 cd 7f d0 a8 cd ; 3CEB1:  f2 0e a4 cd 7f d0 a8 cd
            hex 7f 8b 1f c8 d8 c3 ce ac ; 3CEB9:  7f 8b 1f c8 d8 c3 ce ac
            hex af cd cf 20 23 e8 db ff ; 3CEC1:  af cd cf 20 23 e8 db ff
            hex d6 1e cf a0 fd ff 5a c0 ; 3CEC9:  d6 1e cf a0 fd ff 5a c0
            hex d8 ec ce 0b a6 cd 7f c1 ; 3CED1:  d8 ec ce 0b a6 cd 7f c1
            hex d8 1b cf 64 de db ff b3 ; 3CED9:  d8 1b cf 64 de db ff b3
            hex aa cf 7f a4 cd 7f d1 b3 ; 3CEE1:  aa cf 7f a4 cd 7f d1 b3
            hex d6 13 cf 81 fb d0 85 fb ; 3CEE9:  d6 13 cf 81 fb d0 85 fb
            hex d1 b3 a0 fd ff b3 e9 ca ; 3CEF1:  d1 b3 a0 fd ff b3 e9 ca
            hex cd 02 d4 a4 cd 7f d0 a8 ; 3CEF9:  cd 02 d4 a4 cd 7f d0 a8
            hex cd 7f 8b 20 c0 d8 27 cf ; 3CF01:  cd 7f 8b 20 c0 d8 27 cf
            hex 64 de db ff b3 aa cf 7f ; 3CF09:  64 de db ff b3 aa cf 7f
            hex 8d 1f aa cf 7f 3b e9 54 ; 3CF11:  8d 1f aa cf 7f 3b e9 54
            hex cc 0c ac af cd a4 cd 7f ; 3CF19:  cc 0c ac af cd a4 cd 7f
            hex 2b de db ff 85 fb 0c d0 ; 3CF21:  2b de db ff 85 fb 0c d0
            hex 2c d1 d3 a2 fd ff d7 cc ; 3CF29:  2c d1 d3 a2 fd ff d7 cc
            hex ce 0b a6 cd 7f c1 d8 4f ; 3CF31:  ce 0b a6 cd 7f c1 d8 4f
            hex cf 64 de db ff b3 aa cf ; 3CF39:  cf 64 de db ff b3 aa cf
            hex 7f a4 cd 7f d1 b3 aa cf ; 3CF41:  7f a4 cd 7f d1 b3 aa cf
            hex 7f 3b                   ; 3CF49:  7f 3b

            sbc #$54                    ; 3CF4B:  e9 54
            cpy tab_b15_ceb1+91         ; 3CF4D:  cc 0c cf
            jsr b15_e823                ; 3CF50:  20 23 e8
            brk                         ; 3CF53:  00
            hex 00                      ; 3CF54:  00
            adc ($60,x)                 ; 3CF55:  61 60
            adc $e9                     ; 3CF57:  65 e9
            rol $f2                     ; 3CF59:  26 f2
            asl $cf                     ; 3CF5B:  06 cf
            jsr b15_e823                ; 3CF5D:  20 23 e8
            brk                         ; 3CF60:  00
            hex 00                      ; 3CF61:  00
            rts                         ; 3CF62:  60

            hex 60 68 e9 26 f2 06 cf 20 ; 3CF63:  60 68 e9 26 f2 06 cf 20
            hex 23 e8 00 00 87 13 3f    ; 3CF6B:  23 e8 00 00 87 13 3f

            rol $3c3d,x                 ; 3CF72:  3e 3d 3c
            rts                         ; 3CF75:  60

            hex 6d e9 26 f2 0e cf 20 23 ; 3CF76:  6d e9 26 f2 0e cf 20 23
            hex e8 00 00 3f 3e 3d 3c 61 ; 3CF7E:  e8 00 00 3f 3e 3d 3c 61
            hex e9 26 f2 0a cf 20 23 e8 ; 3CF86:  e9 26 f2 0a cf 20 23 e8
            hex 00 00 3d 3c 64 e9 26 f2 ; 3CF8E:  00 00 3d 3c 64 e9 26 f2
            hex 06 cf 20 23 e8 fe ff 0d ; 3CF96:  06 cf 20 23 e8 fe ff 0d
            hex 1e c6 d8 bc cf 0c b3 b0 ; 3CF9E:  1e c6 d8 bc cf 0c b3 b0
            hex d0 b1 d1 b3 0d 5a c6 d8 ; 3CFA6:  d0 b1 d1 b3 0d 5a c6 d8
            hex b6 cf 0d 8f 30 d6 b9 cf ; 3CFAE:  b6 cf 0d 8f 30 d6 b9 cf
            hex 0d 8f 37 d4 41 cf 3e 0d ; 3CFB6:  0d 8f 37 d4 41 cf 3e 0d
            hex 1e b8 b3 3c e9 98 cf 06 ; 3CFBE:  1e b8 b3 3c e9 98 cf 06
            hex 2b 3e 0d 1e ba b3 3c e9 ; 3CFC6:  2b 3e 0d 1e ba b3 3c e9
            hex 98 cf 06 0b d0 cf 20 23 ; 3CFCE:  98 cf 06 0b d0 cf 20 23
            hex e8 fd ff 40 2b d6 ed cf ; 3CFD6:  e8 fd ff 40 2b d6 ed cf
            hex 0b 5a b5 b3 a0 fd ff b4 ; 3CFDE:  0b 5a b5 b3 a0 fd ff b4
            hex bb 2b 0c b3 b0 d0 b1 0c ; 3CFE6:  bb 2b 0c b3 b0 d0 b1 0c
            hex b0 d3 8f d0 a2 fd ff 5a ; 3CFEE:  b0 d3 8f d0 a2 fd ff 5a
            hex c2 d7 de cf 0b cf 20 23 ; 3CFF6:  c2 d7 de cf 0b cf 20 23
            hex e8 e9 ff 0c 72 2c 8f fe ; 3CFFE:  e8 e9 ff 0c 72 2c 8f fe
            hex b0 85 fd 0c 85 e9 d6 18 ; 3D006:  b0 85 fd 0c 85 e9 d6 18
            hex d0 0d d0 2d d1 b3 a0 ff ; 3D00E:  d0 0d d0 2d d1 b3 a0 ff
            hex ff d4 81 fd d0 85 fd d1 ; 3D016:  ff d4 81 fd d0 85 fd d1
            hex d3 a2 ff ff d8 30 d1 a0 ; 3D01E:  d3 a2 ff ff d8 30 d1 a0
            hex ff ff 8b 25 c0 d8 0f d0 ; 3D026:  ff ff 8b 25 c0 d8 0f d0
            hex de f3 ff 85 f1 46 85 eb ; 3D02E:  de f3 ff 85 f1 46 85 eb
            hex 40 85 ef 81 fd d3 a2 ff ; 3D036:  40 85 ef 81 fd d3 a2 ff
            hex ff a0 ff ff b3 e9 65 ca ; 3D03E:  ff a0 ff ff b3 e9 65 ca
            hex 02 d8 55 d0 de fd ff b3 ; 3D046:  02 d8 55 d0 de fd ff b3
            hex e9 d4 cf 02 d6 56 d0 40 ; 3D04E:  e9 d4 cf 02 d6 56 d0 40
            hex 85 ed 81 fd d0 85 fd d1 ; 3D056:  85 ed 81 fd d0 85 fd d1
            hex d3 a2 ff ff 8b 2e c0 d8 ; 3D05E:  d3 a2 ff ff 8b 2e c0 d8
            hex 7f d0 de fd ff b3 e9 d4 ; 3D066:  7f d0 de fd ff b3 e9 d4
            hex cf 02 85 eb 41 85 ef 81 ; 3D06E:  cf 02 85 eb 41 85 ef 81
            hex fd d0 85 fd d1 d3 a2 ff ; 3D076:  fd d0 85 fd d1 d3 a2 ff
            hex ff a0 ff ff b3 e9 30 cb ; 3D07E:  ff a0 ff ff b3 e9 30 cb
            hex 02 d9 04 00 00 00 2f d1 ; 3D086:  02 d9 04 00 00 00 2f d1
            hex 43 00 d0 d0 44 00 9c d0 ; 3D08E:  43 00 d0 d0 44 00 9c d0
            hex 53 00 b7 d0 0f d0 6a 81 ; 3D096:  53 00 b7 d0 0f d0 6a 81
            hex e9 72 85 e9 8f fe b0 b3 ; 3D09E:  e9 72 85 e9 8f fe b0 b3
            hex de f1 ff b3 e9 98 cf 06 ; 3D0A6:  de f1 ff b3 e9 98 cf 06
            hex cd 81 ed bc 85 ed d6 e5 ; 3D0AE:  cd 81 ed bc 85 ed d6 e5
            hex d0 81 e9 72 85 e9 8f fe ; 3D0B6:  d0 81 e9 72 85 e9 8f fe
            hex b0 85 f1 87 f1 e9 7e ca ; 3D0BE:  b0 85 f1 87 f1 e9 7e ca
            hex 02 cd 81 ed bc 85 ed d6 ; 3D0C6:  02 cd 81 ed bc 85 ed d6
            hex fc d0 81 ed d1 85 ed 81 ; 3D0CE:  fc d0 81 ed d1 85 ed 81
            hex f1 d0 85 f1 d1 b3 81 e9 ; 3D0D6:  f1 d0 85 f1 d1 b3 81 e9
            hex 72 85 e9 8f fe b0 d4 87 ; 3D0DE:  72 85 e9 8f fe b0 d4 87
            hex f1 40 d4                ; 3D0E6:  f1 40 d4

            dec $fff3,x                 ; 3D0E9:  de f3 ff
            sta $f1                     ; 3D0EC:  85 f1
            rti                         ; 3D0EE:  40

tab_b15_d0ef: ; 212 bytes
            hex 85 ef d6 fc d0 0d d0 2d ; 3D0EF:  85 ef d6 fc d0 0d d0 2d
            hex d1 b3 89 20 d4 81 ed d1 ; 3D0F7:  d1 b3 89 20 d4 81 ed d1
            hex 85 ed d0 50 c4 d7 f4 d0 ; 3D0FF:  85 ed d0 50 c4 d7 f4 d0
            hex 81 f1 d3 d8 18 d0 81 ef ; 3D107:  81 f1 d3 d8 18 d0 81 ef
            hex d8 19 d1 81 eb 50 c4 d8 ; 3D10F:  d8 19 d1 81 eb 50 c4 d8
            hex 27 d1 0d d0 2d d1 b3 81 ; 3D117:  27 d1 0d d0 2d d1 b3 81
            hex f1 d3 d4 81 eb d1 85 eb ; 3D11F:  f1 d3 d4 81 eb d1 85 eb
            hex 81 f1 d0 85 f1 d6 07 d1 ; 3D127:  81 f1 d0 85 f1 d6 07 d1
            hex cf 3d 40 d4 cf 20 23 e8 ; 3D12F:  cf 3d 40 d4 cf 20 23 e8
            hex 6a ff de 6a ff b3 de 0b ; 3D137:  6a ff de 6a ff b3 de 0b
            hex 00 b3 e9 fc cf 04 de 6a ; 3D13F:  00 b3 e9 fc cf 04 de 6a
            hex ff b3 e9 c4 ce 02 cf 20 ; 3D147:  ff b3 e9 c4 ce 02 cf 20
            hex 23 e8 f8 ff 42 2b a4 d3 ; 3D14F:  23 e8 f8 ff 42 2b a4 d3
            hex 7f d5 00 00 05 00 6b d1 ; 3D157:  7f d5 00 00 05 00 6b d1
            hex 69 d1 e1 d1 e8 d1 ee d1 ; 3D15F:  69 d1 e1 d1 e8 d1 ee d1
            hex 4e d2 40 2b 0b 51 c8 d7 ; 3D167:  4e d2 40 2b 0b 51 c8 d7
            hex c9 d1 0b 51 da 2b a6 df ; 3D16F:  c9 d1 0b 51 da 2b a6 df
            hex 7f c1 d8 ad d1 a4 cd 7f ; 3D177:  7f c1 d8 ad d1 a4 cd 7f
            hex 29 a4 cf 7f 28 61 8d 1a ; 3D17F:  29 a4 cf 7f 28 61 8d 1a
            hex 8d 1d 8d 1a 8d 14 e9 6a ; 3D187:  8d 1d 8d 1a 8d 14 e9 6a
            hex cf 0a 8d 1a 8d 15 e9 7b ; 3D18F:  cf 0a 8d 1a 8d 15 e9 7b
            hex cc 04 0b d0 b3 8e 8a f6 ; 3D197:  cc 04 0b d0 b3 8e 8a f6
            hex e9 34 d1 04 38 39 e9 7b ; 3D19F:  e9 34 d1 04 38 39 e9 7b
            hex cc 04 0b a8 df 7f a4 e7 ; 3D1A7:  cc 04 0b a8 df 7f a4 e7
            hex 7f 52 c1 d8 69 d2 a4 e9 ; 3D1AF:  7f 52 c1 d8 69 d2 a4 e9
            hex 7f d1 a8 e9 7f d9 02 00 ; 3D1B7:  7f d1 a8 e9 7f d9 02 00
            hex 64 00 52 d2             ; 3D1BF:  64 00 52 d2

            brk                         ; 3D1C3:  00
            hex 00                      ; 3D1C4:  00
            bvs tab_b15_d0ef+170        ; 3D1C5:  70 d2
            adc #$d2                    ; 3D1C7:  69 d2
            rti                         ; 3D1C9:  40

            hex 2b 3a e9 72 d7 02 b3 0b ; 3D1CA:  2b 3a e9 72 d7 02 b3 0b
            hex 8c d5 7f bb d3 b4 c1 d8 ; 3D1D2:  8c d5 7f bb d3 b4 c1 d8
            hex 71 d1 0b d0 d6 ca d1 a4 ; 3D1DA:  71 d1 0b d0 d6 ca d1 a4
            hex 5f 6f 2a d6 6b d1 a4 63 ; 3D1E2:  5f 6f 2a d6 6b d1 a4 63
            hex 6f d6 e4 d1 a4 e1 7f 8c ; 3D1EA:  6f d6 e4 d1 a4 e1 7f 8c
            hex ff 00 c0 d8 3d d2 40 d6 ; 3D1F2:  ff 00 c0 d8 3d d2 40 d6
            hex fe d1 0b d0 2b ac 7e d7 ; 3D1FA:  fe d1 0b d0 2b ac 7e d7
            hex b3 0b 8c d5 7f bb d3 b4 ; 3D202:  b3 0b 8c d5 7f bb d3 b4
            hex c1 d8 14 d2 0b 58 c6 d7 ; 3D20A:  c1 d8 14 d2 0b 58 c6 d7
            hex fc d1 0b 58 c9 d8 37 d2 ; 3D212:  fc d1 0b 58 c9 d8 37 d2
            hex 40 d6 20 d2 0b d0 2b aa ; 3D21A:  40 d6 20 d2 0b d0 2b aa
            hex 63 6f e9 72 d7 02 b3 0b ; 3D222:  63 6f e9 72 d7 02 b3 0b
            hex 8c d5 7f bb d3 b4 c1 d7 ; 3D22A:  8c d5 7f bb d3 b4 c1 d7
            hex 1e d2 0b d0 2b 0b 51 da ; 3D232:  1e d2 0b d0 2b 0b 51 da
            hex a8 e1 7f a4 e1 7f 2b a4 ; 3D23A:  a8 e1 7f a4 e1 7f 2b a4
            hex e8 7b d8 6b d1 41 cd 0b ; 3D242:  e8 7b d8 6b d1 41 cd 0b
            hex dc d6 6a d1 41 d6 6a d1 ; 3D24A:  dc d6 6a d1 41 d6 6a d1
            hex aa e7 7f 60 a4 cf 7f 53 ; 3D252:  aa e7 7f 60 a4 cf 7f 53
            hex bd d1 b3 a4 cd 7f 53 bd ; 3D25A:  bd d1 b3 a4 cd 7f 53 bd
            hex b3 60 63 e9 26 f2 0c 3b ; 3D262:  b3 60 63 e9 26 f2 0c 3b
            hex 66 e9 26 f2 04 cf 62 60 ; 3D26A:  66 e9 26 f2 04 cf 62 60

            hex 8e f8 00 ; stx $00f8    ; 3D272:  8e f8 00
            hex 8e f8 00 ; stx $00f8    ; 3D275:  8e f8 00
            rts                         ; 3D278:  60

tab_b15_d279: ; 60 bytes
            hex 63 e9 26 f2 0c 8a c8 00 ; 3D279:  63 e9 26 f2 0c 8a c8 00
            hex a8 e9 7f d6 69 d2 20 23 ; 3D281:  a8 e9 7f d6 69 d2 20 23
            hex e8 fe ff ac 4e d1 d7 8c ; 3D289:  e8 fe ff ac 4e d1 d7 8c
            hex d2 40 2b ac 4e d1 2b d8 ; 3D291:  d2 40 2b ac 4e d1 2b d8
            hex 94 d2 0b cf 20 23 e8 00 ; 3D299:  94 d2 0b cf 20 23 e8 00
            hex 00 0c d8 ab d2 0c d1 d6 ; 3D2A1:  00 0c d8 ab d2 0c d1 d6
            hex ac d2 42 a8 e7 7f 0c d7 ; 3D2A9:  ac d2 42 a8 e7 7f 0c d7
            hex ca d2 62 60             ; 3D2B1:  ca d2 62 60

            hex 8e f8 00 ; stx $00f8    ; 3D2B5:  8e f8 00
            hex 8e f8 00 ; stx $00f8    ; 3D2B8:  8e f8 00
            rts                         ; 3D2BB:  60

tab_b15_d2bc: ; 117 bytes
            hex 63 e9 26 f2 0c 8d 13 e9 ; 3D2BC:  63 e9 26 f2 0c 8d 13 e9
            hex 26 f2 02 d6 f8 d2 0c 51 ; 3D2C4:  26 f2 02 d6 f8 d2 0c 51
            hex c0 d8 db d2 62 60 8e f8 ; 3D2CC:  c0 d8 db d2 62 60 8e f8
            hex 00 8e f8 00 d6 ec d2 aa ; 3D2D4:  00 8e f8 00 d6 ec d2 aa
            hex e7 7f 60 a4 cf 7f 53 bd ; 3D2DC:  e7 7f 60 a4 cf 7f 53 bd
            hex d1 b3 a4 cd 7f 53 bd b3 ; 3D2E4:  d1 b3 a4 cd 7f 53 bd b3
            hex 60 63 e9 26 f2 0c 8a c8 ; 3D2EC:  60 63 e9 26 f2 0c 8a c8
            hex 00 a8 e9 7f cf 20 23 e8 ; 3D2F4:  00 a8 e9 7f cf 20 23 e8
            hex 00 00 61 8d 13 69 68 62 ; 3D2FC:  00 00 61 8d 13 69 68 62
            hex e9 42 cc 0a cf 20 23 e8 ; 3D304:  e9 42 cc 0a cf 20 23 e8
            hex 00 00 61 8d 1a 69 8d 14 ; 3D30C:  00 00 61 8d 1a 69 8d 14
            hex 62 e9 42 cc 0a cf 20 23 ; 3D314:  62 e9 42 cc 0a cf 20 23
            hex e8 00 00 ac 59 d7 ac 09 ; 3D31C:  e8 00 00 ac 59 d7 ac 09
            hex d3 cf 20 23 e8 00 00 a4 ; 3D324:  d3 cf 20 23 e8 00 00 a4
            hex c5 7f d8 38 d3          ; 3D32C:  c5 7f d8 38 d3

            ldy tab_b15_d2bc+77         ; 3D331:  ac 09 d3
            rti                         ; 3D334:  40

            hex a8 c5 7f a4 d1 7f d8 43 ; 3D335:  a8 c5 7f a4 d1 7f d8 43
            hex d3 89 14 d6 45 d3 89 16 ; 3D33D:  d3 89 14 d6 45 d3 89 16
            hex b3 62 e9 7b cc 04 3c e9 ; 3D345:  b3 62 e9 7b cc 04 3c e9
            hex c4 ce 02 cf 20 23 e8 fe ; 3D34D:  c4 ce 02 cf 20 23 e8 fe
            hex ff 3c e9 c4 ce 02 61 e9 ; 3D355:  ff 3c e9 c4 ce 02 61 e9
            hex 9d d2 02 ac 87 d2 2b 8b ; 3D35D:  9d d2 02 ac 87 d2 2b 8b
            hex 40 c1 d8 78 d3 0b 8c 80 ; 3D365:  40 c1 d8 78 d3 0b 8c 80
            hex 00 c1 d8 78 d3 0b 52    ; 3D36D:  00 c1 d8 78 d3 0b 52

            cmp ($d7,x)                 ; 3D374:  c1 d7
            rts                         ; 3D376:  60

            hex d3 60 e9 9d d2 02 0b 8b ; 3D377:  d3 60 e9 9d d2 02 0b 8b
            hex 40 c0 d8 8e d3 8d 3c e9 ; 3D37F:  40 c0 d8 8e d3 8d 3c e9
            hex 81 ce 02 41 d6 a1 d3 0b ; 3D387:  81 ce 02 41 d6 a1 d3 0b
            hex 8c 80 00 c0 d8 a0 d3 8d ; 3D38F:  8c 80 00 c0 d8 a0 d3 8d
            hex 3e e9 81 ce 02 40 d6 a1 ; 3D397:  3e e9 81 ce 02 40 d6 a1
            hex d3 42 2b ac 89 cc 0b cf ; 3D39F:  d3 42 2b ac 89 cc 0b cf
            hex 20 23 e8 fe ff 8e 95 f6 ; 3D3A7:  20 23 e8 fe ff 8e 95 f6
            hex e9 c4 ce 02 61 e9 9d d2 ; 3D3AF:  e9 c4 ce 02 61 e9 9d d2
            hex 02 ac 87 d2 2b 8b 40 c1 ; 3D3B7:  02 ac 87 d2 2b 8b 40 c1
            hex d8 ca d3 0b 8c 80 00 c1 ; 3D3BF:  d8 ca d3 0b 8c 80 00 c1
            hex d7 b8 d3 60 e9 9d d2 02 ; 3D3C7:  d7 b8 d3 60 e9 9d d2 02
            hex 0b 8b 40 c0 d8 e0 d3 8d ; 3D3CF:  0b 8b 40 c0 d8 e0 d3 8d
            hex 59 e9 81 ce 02 41 d6 e7 ; 3D3D7:  59 e9 81 ce 02 41 d6 e7
            hex d3 8d 4e e9 81 ce 02 40 ; 3D3DF:  d3 8d 4e e9 81 ce 02 40
            hex 2b ac 89 cc 0b cf 20 23 ; 3D3E7:  2b ac 89 cc 0b cf 20 23
            hex e8 ec ff 40 24 40 26 41 ; 3D3EF:  e8 ec ff 40 24 40 26 41
            hex 25 de f4 ff b3 05 d2 b4 ; 3D3F7:  25 de f4 ff b3 05 d2 b4
            hex bb b3 8a ff 00 b1 05 d0 ; 3D3FF:  bb b3 8a ff 00 b1 05 d0
            hex 25 05 55 c3 d7 f8 d3 36 ; 3D407:  25 05 55 c3 d7 f8 d3 36
            hex 8e 9e f6 e9 34 d1 04 a4 ; 3D40F:  8e 9e f6 e9 34 d1 04 a4
            hex cd 7f d1 a8 cd 7f 61 e9 ; 3D417:  cd 7f d1 a8 cd 7f 61 e9
            hex 9d d2 02                ; 3D41F:  9d d2 02

            ldy tab_b15_d279+14         ; 3D422:  ac 87 d2
            rti                         ; 3D425:  40

            hex 22 ac 4e d1 d9 06 00 01 ; 3D426:  22 ac 4e d1 d9 06 00 01
            hex 00 59 d4 02 00 47 d4 10 ; 3D42E:  00 59 d4 02 00 47 d4 10
            hex 00 69 d4 20 00 af d4 40 ; 3D436:  00 69 d4 20 00 af d4 40
            hex 00 db d4 80 00 11 d5 60 ; 3D43E:  00 db d4 80 00 11 d5 60
            hex d4 60 e9 9d d2 02 a4 e0 ; 3D446:  d4 60 e9 9d d2 02 a4 e0
            hex 7b 51 c0 d8 57 d4 89 ff ; 3D44E:  7b 51 c0 d8 57 d4 89 ff
            hex cf 40 cf 60 e9 9d d2 02 ; 3D456:  cf 40 cf 60 e9 9d d2 02
            hex 41 22 02 d8 27 d4 40 23 ; 3D45E:  41 22 02 d8 27 d4 40 23
            hex d6 73 d5 de f4 ff b3 04 ; 3D466:  d6 73 d5 de f4 ff b3 04
            hex d2 b4 bb b3 b0 d0 b1 5a ; 3D46E:  d2 b4 bb b3 b0 d0 b1 5a
            hex c9 d8 85 d4 de f4 ff b3 ; 3D476:  c9 d8 85 d4 de f4 ff b3
            hex 04 d2 b4 bb b3 40 b1 de ; 3D47E:  04 d2 b4 bb b3 40 b1 de
            hex f4 ff b3 04 d2 b4 bb b0 ; 3D486:  f4 ff b3 04 d2 b4 bb b0
            hex b3 8e a1 f6 e9 34 d1 04 ; 3D48E:  b3 8e a1 f6 e9 34 d1 04
            hex a4 cd 7f d1 a8 cd 7f 60 ; 3D496:  a4 cd 7f d1 a8 cd 7f 60
            hex e9 9d d2 02 62 e9 3e d7 ; 3D49E:  e9 9d d2 02 62 e9 3e d7
            hex 02 61 e9 9d d2 02 d6 60 ; 3D4A6:  02 61 e9 9d d2 02 d6 60
            hex d4 de f4 ff b3 04 d2 b4 ; 3D4AE:  d4 de f4 ff b3 04 d2 b4
            hex bb b3 b0 d1 b1 5a c9 d8 ; 3D4B6:  bb b3 b0 d1 b1 5a c9 d8
            hex cb d4 de f4 ff b3 04 d2 ; 3D4BE:  cb d4 de f4 ff b3 04 d2
            hex b4 bb b3 49 b1 de f4 ff ; 3D4C6:  b4 bb b3 49 b1 de f4 ff
            hex b3 04 d2 b4 bb b0 b3 8e ; 3D4CE:  b3 04 d2 b4 bb b0 b3 8e
            hex a4 f6 d6 92 d4 04       ; 3D4D6:  a4 f6 d6 92 d4 04

            cld                         ; 3D4DC:  d8
            rts                         ; 3D4DD:  60

tab_b15_d4de: ; 52 bytes
            hex d4 60 e9 9d d2 02 8e a7 ; 3D4DE:  d4 60 e9 9d d2 02 8e a7
            hex f6 e9 c4 ce 02 42 cd a4 ; 3D4E6:  f6 e9 c4 ce 02 42 cd a4
            hex cd 7f bc a8 cd 7f 61 e9 ; 3D4EE:  cd 7f bc a8 cd 7f 61 e9
            hex 9d d2 02 de f4 ff b3 04 ; 3D4F6:  9d d2 02 de f4 ff b3 04
            hex d1 24 d0 d2 b4 bb b3 8a ; 3D4FE:  d1 24 d0 d2 b4 bb b3 8a
            hex ff 00 b1 62 e9 3e d7 02 ; 3D506:  ff 00 b1 62 e9 3e d7 02
            hex d6 60 d4 0c             ; 3D50E:  d6 60 d4 0c

            cmp ($14),y                 ; 3D512:  d1 14
            cmp ($d8,x)                 ; 3D514:  c1 d8
            rts                         ; 3D516:  60

            hex d4 04 d7 28 d5 de f4 ff ; 3D517:  d4 04 d7 28 d5 de f4 ff
            hex b3 04 d2                ; 3D51F:  b3 04 d2

            ldy $bb,x                   ; 3D522:  b4 bb
            bcs tab_b15_d4de+32         ; 3D524:  b0 d8
            rts                         ; 3D526:  60

            hex d4 60 e9 9d d2 02 a4 cd ; 3D527:  d4 60 e9 9d d2 02 a4 cd
            hex 7f d0 a8 cd 7f de f4 ff ; 3D52F:  7f d0 a8 cd 7f de f4 ff
            hex b3 04 d0 24 d2 b4 bb b3 ; 3D537:  b3 04 d0 24 d2 b4 bb b3
            hex 40 b1 de f4 ff b3 04 d2 ; 3D53F:  40 b1 de f4 ff b3 04 d2
            hex b4 bb b0 b3 8e a9 f6 e9 ; 3D547:  b4 bb b0 b3 8e a9 f6 e9
            hex 34 d1 04 a4 cd 7f d1 a8 ; 3D54F:  34 d1 04 a4 cd 7f d1 a8
            hex cd 7f 61 e9 9d d2 02 d6 ; 3D557:  cd 7f 61 e9 9d d2 02 d6
            hex 09 d5 de f4 ff b3 05 d2 ; 3D55F:  09 d5 de f4 ff b3 05 d2
            hex b4 bb b0 b3 03 5a b5 b4 ; 3D567:  b4 bb b0 b3 03 5a b5 b4
            hex bb 23 05 d0 25 de f4 ff ; 3D56F:  bb 23 05 d0 25 de f4 ff
            hex b3 05 d2 b4 bb b0 8c ff ; 3D577:  b3 05 d2 b4 bb b0 8c ff
            hex 00 c1 d7 61 d5 03 cf 20 ; 3D57F:  00 c1 d7 61 d5 03 cf 20
            hex 23 e8 fe ff 40 d6 96 d5 ; 3D587:  23 e8 fe ff 40 d6 96 d5
            hex 4a cd 0c b6 2c 0b d0 2b ; 3D58F:  4a cd 0c b6 2c 0b d0 2b
            hex 0c d7 8f d5 0b cf 20 23 ; 3D597:  0c d7 8f d5 0b cf 20 23
            hex e8 f6 ff 3d e9 86 d5 02 ; 3D59F:  e8 f6 ff 3d e9 86 d5 02
            hex 2b a4 cd 7f 29 a4 cf 7f ; 3D5A7:  2b a4 cd 7f 29 a4 cf 7f
            hex 28 38 39 e9 7b cc 04 40 ; 3D5AF:  28 38 39 e9 7b cc 04 40
            hex d6 c2 d5 8d 20 e9 81 ce ; 3D5B7:  d6 c2 d5 8d 20 e9 81 ce
            hex 02 0a d0 2a 0a 1b c2 d7 ; 3D5BF:  02 0a d0 2a 0a 1b c2 d7
            hex ba d5 38 39 e9 7b cc 04 ; 3D5C7:  ba d5 38 39 e9 7b cc 04
            hex 3b e9 ed d3 02 27 07 50 ; 3D5CF:  3b e9 ed d3 02 27 07 50
            hex c3 d7 e7 d5 07 1c c5 d8 ; 3D5D7:  c3 d7 e7 d5 07 1c c5 d8
            hex b0 d5 07 1d c3 d8 b0 d5 ; 3D5DF:  b0 d5 07 1d c3 d8 b0 d5
            hex 07 cf 20 23 e8 fe ff 3d ; 3D5E7:  07 cf 20 23 e8 fe ff 3d
            hex 3c 8e ac f6 e9 34 d1 06 ; 3D5EF:  3c 8e ac f6 e9 34 d1 06
            hex 3d 3c e9 9d d5 04 2b 0b ; 3D5F7:  3d 3c e9 9d d5 04 2b 0b
            hex 50 c4 d8 07 d6 ac 89 cc ; 3D5FF:  50 c4 d8 07 d6 ac 89 cc
            hex 0b cf 20 23 e8 fe ff 8d ; 3D607:  0b cf 20 23 e8 fe ff 8d
            hex 1a 62 e9 7b cc 04 8e b7 ; 3D60F:  1a 62 e9 7b cc 04 8e b7
            hex f6 e9 c4 ce 02 ac 87 d2 ; 3D617:  f6 e9 c4 ce 02 ac 87 d2
            hex 2b ac 89 cc ac e1 cc 0b ; 3D61F:  2b ac 89 cc ac e1 cc 0b
            hex cf 20 23 e8 fc ff 40 2a ; 3D627:  cf 20 23 e8 fc ff 40 2a
            hex 2b d6 4e d6 0a 8c a2 6d ; 3D62F:  2b d6 4e d6 0a 8c a2 6d
            hex bb d3 d7 48 d6 3a e9 8d ; 3D637:  bb d3 d7 48 d6 3a e9 8d
            hex d9 02 8c ff 00 c0 d8 4b ; 3D63F:  d9 02 8c ff 00 c0 d8 4b
            hex d6 0b d0 2b 0a d0 2a 0a ; 3D647:  d6 0b d0 2b 0a d0 2a 0a
            hex a6 9d 6d c6 d7 33 d6 0b ; 3D64F:  a6 9d 6d c6 d7 33 d6 0b
            hex 51 c0 d8 6b d6 ac 82 d9 ; 3D657:  51 c0 d8 6b d6 ac 82 d9
            hex d8 66 d6 40 d6 67 d6 41 ; 3D65F:  d8 66 d6 40 d6 67 d6 41
            hex cd 0b da 2b 0b          ; 3D667:  cd 0b da 2b 0b

            eor ($c1),y                 ; 3D66C:  51 c1
            cld                         ; 3D66E:  d8
            adc $d6,x                   ; 3D66F:  75 d6
            rti                         ; 3D671:  40

            hex d6 76 d6 41 cf 20 23 e8 ; 3D672:  d6 76 d6 41 cf 20 23 e8
            hex 00 00 aa 9f 6d 8e c4 f6 ; 3D67A:  00 00 aa 9f 6d 8e c4 f6
            hex e9 34 d1 04 cf 20 23 e8 ; 3D682:  e9 34 d1 04 cf 20 23 e8
            hex 00 00 a4 5f 6d d5 00 00 ; 3D68A:  00 00 a4 5f 6d d5 00 00
            hex 04 00 a5 d6 9e d6 a6 d6 ; 3D692:  04 00 a5 d6 9e d6 a6 d6
            hex ac d6 b2 d6 8e c7 f6 e9 ; 3D69A:  ac d6 b2 d6 8e c7 f6 e9
            hex c4 ce 02 cf 8e ce f6 d6 ; 3D6A2:  c4 ce 02 cf 8e ce f6 d6
            hex a1 d6 8e d5 f6 d6 a1 d6 ; 3D6AA:  a1 d6 8e d5 f6 d6 a1 d6
            hex 8e da f6 d6 a1 d6 20 23 ; 3D6B2:  8e da f6 d6 a1 d6 20 23
            hex e8 00 00 0e d8 db d6 0e ; 3D6BA:  e8 00 00 0e d8 db d6 0e
            hex b7 25 b7 14 0d b7 25 b7 ; 3D6C2:  b7 25 b7 14 0d b7 25 b7
            hex 14 0c b7 25 b7 15 b7 01 ; 3D6CA:  14 0c b7 25 b7 15 b7 01
            hex b7 15 b7 02 b7 27 d6 dd ; 3D6D2:  b7 15 b7 02 b7 27 d6 dd
            hex d6 89 ff cf 20 23 e8 00 ; 3D6DA:  d6 89 ff cf 20 23 e8 00
            hex 00 0c d7 ed d6 0d d7 ed ; 3D6E2:  00 0c d7 ed d6 0d d7 ed
            hex d6 40 cf 0d b7 26 b7 14 ; 3D6EA:  d6 40 cf 0d b7 26 b7 14
            hex 0c b7 26 b7 15 b7 03 b7 ; 3D6F2:  0c b7 26 b7 15 b7 03 b7
            hex 14 0c b7 26 b7 19 64 00 ; 3D6FA:  14 0c b7 26 b7 19 64 00
            hex 00 00 b7 01 b7 15 b7 02 ; 3D702:  00 00 b7 01 b7 15 b7 02
            hex b7 27 cf 20 23 e8 00 00 ; 3D70A:  b7 27 cf 20 23 e8 00 00
            hex 0d 8b 64 c0 d8 1b d7 0c ; 3D712:  0d 8b 64 c0 d8 1b d7 0c
            hex cf 0c 5a b6 b3 0d 5a b6 ; 3D71A:  cf 0c 5a b6 b3 0d 5a b6
            hex b4 b5 b3 0c 5a b9 1d b5 ; 3D722:  b4 b5 b3 0c 5a b9 1d b5
            hex 8b 64 b6 b3 0c 5a b6 b3 ; 3D72A:  8b 64 b6 b3 0c 5a b6 b3
            hex 0d 5a b9 b4 b5 5a b6 b4 ; 3D732:  0d 5a b9 b4 b5 5a b6 b4
            hex bb b4 bb cf 20 23 e8 fe ; 3D73A:  bb b4 bb cf 20 23 e8 fe
            hex ff d6 51 d7 8a f0 00 2b ; 3D742:  ff d6 51 d7 8a f0 00 2b
            hex 0b d1 2b 0b d7 4a d7 0c ; 3D74A:  0b d1 2b 0b d7 4a d7 0c
            hex d1 2c d0 d7 46 d7 cf 20 ; 3D752:  d1 2c d0 d7 46 d7 cf 20
            hex 23 e8 00 00 aa 65 6d e9 ; 3D75A:  23 e8 00 00 aa 65 6d e9
            hex 3e d7 02 cf 20 23 e8 00 ; 3D762:  3e d7 02 cf 20 23 e8 00
            hex 00 ac 59 d7 ac 89 cc cf ; 3D76A:  00 ac 59 d7 ac 89 cc cf
            hex 20 23 e8 00 00 0c 8c 15 ; 3D772:  20 23 e8 00 00 0c 8c 15
            hex 6e bb d3 cf 20 23 e8 00 ; 3D77A:  6e bb d3 cf 20 23 e8 00
            hex 00 aa 5f 6f e9 72 d7 02 ; 3D782:  00 aa 5f 6f e9 72 d7 02
            hex cf 20 23 e8 fe ff 8e e1 ; 3D78A:  cf 20 23 e8 fe ff 8e e1
            hex f6 e9 c4 ce 02 3c e9 72 ; 3D792:  f6 e9 c4 ce 02 3c e9 72
            hex d7 02 59 b5 8c a8 77 bb ; 3D79A:  d7 02 59 b5 8c a8 77 bb
            hex 2b b3 e9 c4 ce 02 8d 2c ; 3D7A2:  2b b3 e9 c4 ce 02 8d 2c
            hex e9 81 ce 02 cf 20 23 e8 ; 3D7AA:  e9 81 ce 02 cf 20 23 e8
            hex fe ff 8e e7 f6 e9 c4 ce ; 3D7B2:  fe ff 8e e7 f6 e9 c4 ce
            hex 02 3c e9 72 d7 02 59 b5 ; 3D7BA:  02 3c e9 72 d7 02 59 b5
            hex 8c a8 77 bb 2b b3 e9 c4 ; 3D7C2:  8c a8 77 bb 2b b3 e9 c4
            hex ce 02 cf 20 23 e8 00 00 ; 3D7CA:  ce 02 cf 20 23 e8 00 00
            hex 0c 57 b5 8c 2f 75 bb cf ; 3D7D2:  0c 57 b5 8c 2f 75 bb cf
            hex 20 23 e8 00 00 3c e9 72 ; 3D7DA:  20 23 e8 00 00 3c e9 72
            hex d7 02 b3 e9 cd d7 02 cf ; 3D7E2:  d7 02 b3 e9 cd d7 02 cf
            hex 20 23 e8 00 00 aa 5f 6f ; 3D7EA:  20 23 e8 00 00 aa 5f 6f
            hex e9 da d7 02 cf 20 23 e8 ; 3D7F2:  e9 da d7 02 cf 20 23 e8
            hex fe ff 0c 8b 1a b5 8c 01 ; 3D7FA:  fe ff 0c 8b 1a b5 8c 01
            hex 70 bb 2b 0b 78 b0 d7 14 ; 3D802:  70 bb 2b 0b 78 b0 d7 14
            hex d8 0b 7c b3 0b 7e b3 40 ; 3D80A:  d8 0b 7c b3 0b 7e b3 40
            hex b1 b1 cf 20 23 e8 fc ff ; 3D812:  b1 b1 cf 20 23 e8 fc ff
            hex 0c 8b 1a b5 8c 11 70 bb ; 3D81A:  0c 8b 1a b5 8c 11 70 bb
            hex 2b 0b b0 d7 35 d8 0b 72 ; 3D822:  2b 0b b0 d7 35 d8 0b 72
            hex b3 0b 74 b3 0b          ; 3D82A:  b3 0b 74 b3 0b

            ror $b3,x                   ; 3D82F:  76 b3
            rti                         ; 3D831:  40

            hex b1 b1 b1 cf 20 23 e8 f4 ; 3D832:  b1 b1 b1 cf 20 23 e8 f4
            hex ff 0c 8b 1a b5 8c 01 70 ; 3D83A:  ff 0c 8b 1a b5 8c 01 70
            hex bb 27 07 2a d6 63 d8 3b ; 3D842:  bb 27 07 2a d6 63 d8 3b
            hex 07 8f 18 b0 b3 0b b0 b3 ; 3D84A:  07 8f 18 b0 b3 0b b0 b3
            hex e9 5e cb 04 b1 0b b0 50 ; 3D852:  e9 5e cb 04 b1 0b b0 50
            hex c2 d8 61 d8 3b 40 b1 0b ; 3D85A:  c2 d8 61 d8 3b 40 b1 0b
            hex 72 2b 0a 8f 18 b3 0b b4 ; 3D862:  72 2b 0a 8f 18 b3 0b b4
            hex c6 d7 49 d8 07 7a b3 8d ; 3D86A:  c6 d7 49 d8 07 7a b3 8d
            hex 64 07 7a b0 b3 e9 5e cb ; 3D872:  64 07 7a b0 b3 e9 5e cb
            hex 04 b1 40 29 3c e9 da d7 ; 3D87A:  04 b1 40 29 3c e9 da d7
            hex 02 26 28 d6 a9 d8 08 d3 ; 3D882:  02 26 28 d6 a9 d8 08 d3

            hex 8c eb 00 ; sty $00eb    ; 3D88A:  8c eb 00
            cpy $d8                     ; 3D88D:  c4 d8
            sty $d8,x                   ; 3D88F:  94 d8
            sec                         ; 3D891:  38
            rti                         ; 3D892:  40

            hex d4 08 d3 8c d2 00 c4 d8 ; 3D893:  d4 08 d3 8c d2 00 c4 d8
            hex a1 d8 38 89 d2 d4 08 d0 ; 3D89B:  a1 d8 38 89 d2 d4 08 d0
            hex 28 d1 09 d0 29 d1 09 56 ; 3D8A3:  28 d1 09 d0 29 d1 09 56
            hex c6 d7 88 d8 3c e9 15 d8 ; 3D8AB:  c6 d7 88 d8 3c e9 15 d8
            hex 02 3c e9 f7 d7 02 cf 20 ; 3D8B3:  02 3c e9 f7 d7 02 cf 20
            hex 23 e8 fc ff 0c 51 c2 d8 ; 3D8BB:  23 e8 fc ff 0c 51 c2 d8
            hex c7                      ; 3D8C3:  c7

            cld                         ; 3D8C4:  d8
            rti                         ; 3D8C5:  40

            hex cf 3c e9 cd cb 02 b3 0e ; 3D8C6:  cf 3c e9 cd cb 02 b3 0e
            hex b0 b3 0d b0 b4 bb 52 b6 ; 3D8CE:  b0 b3 0d b0 b4 bb 52 b6
            hex b3 e9 cd cb 02 b4 bb b3 ; 3D8D6:  b3 e9 cd cb 02 b4 bb b3
            hex 46 a6 63 6d bc b3 3c e9 ; 3D8DE:  46 a6 63 6d bc b3 3c e9
            hex b8 d6 06 2b 0b d7 f0 d8 ; 3D8E6:  b8 d6 06 2b 0b d7 f0 d8
            hex 41 cf 0b cf 20 23 e8 fc ; 3D8EE:  41 cf 0b cf 20 23 e8 fc
            hex ff 0c 78 b3 0c 7c b3 3d ; 3D8F6:  ff 0c 78 b3 0c 7c b3 3d
            hex e9 ba d8 06 2b 0c 7c b0 ; 3D8FE:  e9 ba d8 06 2b 0c 7c b0
            hex b3 0c 8f 18 b0 b4 bc 2a ; 3D906:  b3 0c 8f 18 b0 b4 bc 2a
            hex b3 0b b4 c4 d8 17 d9 0a ; 3D90E:  b3 0b b4 c4 d8 17 d9 0a
            hex cf 0b cf 20 23 e8 fc ff ; 3D916:  cf 0b cf 20 23 e8 fc ff
            hex 0c 74 b3 0c 7e b3 3d e9 ; 3D91E:  0c 74 b3 0c 7e b3 3d e9
            hex ba d8 06 2b 0c 7e b0 b3 ; 3D926:  ba d8 06 2b 0c 7e b0 b3
            hex 0c 8f 18 b0 b4 bc 2a b3 ; 3D92E:  0c 8f 18 b0 b4 bc 2a b3
            hex 0b b4 c4 d8 3e d9 0a cf ; 3D936:  0b b4 c4 d8 3e d9 0a cf
            hex 0b cf 20 23 e8 00 00 3d ; 3D93E:  0b cf 20 23 e8 00 00 3d
            hex 3c e9 f2 d8 04 b3 0c 7c ; 3D946:  3c e9 f2 d8 04 b3 0c 7c
            hex b4 b3 b0 bb b1 3d 3c e9 ; 3D94E:  b4 b3 b0 bb b1 3d 3c e9
            hex 19 d9 04 b3 0c 7e b4 b3 ; 3D956:  19 d9 04 b3 0c 7e b4 b3
            hex b0 bb b1 cf 20 23 e8 00 ; 3D95E:  b0 bb b1 cf 20 23 e8 00
            hex 00 89 80 cd a5 a1 6d db ; 3D966:  00 89 80 cd a5 a1 6d db
            hex a9 a1 6d cf 20 23 e8 00 ; 3D96E:  a9 a1 6d cf 20 23 e8 00
            hex 00 3c e9 72 d7 02 8c d4 ; 3D976:  00 3c e9 72 d7 02 8c d4
            hex 6d bb d3 cf 20 23 e8 00 ; 3D97E:  6d bb d3 cf 20 23 e8 00
            hex 00 a4 09 6e 58 c9 cf 20 ; 3D986:  00 a4 09 6e 58 c9 cf 20
            hex 23 e8 00 00 0c 8c f7 6c ; 3D98E:  23 e8 00 00 0c 8c f7 6c
            hex bb d3 cf 20 23 e8 00 00 ; 3D996:  bb d3 cf 20 23 e8 00 00
            hex 0c 8c f7 6c bb d3 8c ff ; 3D99E:  0c 8c f7 6c bb d3 8c ff
            hex 00 c0 cf 20 23 e8 00 00 ; 3D9A6:  00 c0 cf 20 23 e8 00 00
            hex a4 5f 6f 8c a2 6d bb d3 ; 3D9AE:  a4 5f 6f 8c a2 6d bb d3
            hex cf 20 23 e8 00 00 ac 7e ; 3D9B6:  cf 20 23 e8 00 00 ac 7e
            hex d7 b3 3c e9 72 d7 02 b4 ; 3D9BE:  d7 b3 3c e9 72 d7 02 b4
            hex c0 cf 20 23 e8 00 00 0c ; 3D9C6:  c0 cf 20 23 e8 00 00 0c
            hex 8c f7 6c bb cf 20 23 e8 ; 3D9CE:  8c f7 6c bb cf 20 23 e8
            hex 00 00 0c 5a b5 8c 85 79 ; 3D9D6:  00 00 0c 5a b5 8c 85 79
            hex bb b3 e9 c4 ce 02 cf 20 ; 3D9DE:  bb b3 e9 c4 ce 02 cf 20
            hex 23 e8 00 00 0c 8c 65 6f ; 3D9E6:  23 e8 00 00 0c 8c 65 6f
            hex bb d3 8c 80 00 da 50 c1 ; 3D9EE:  bb d3 8c 80 00 da 50 c1
            hex cf 20 23 e8 fe ff 0c 8c ; 3D9F6:  cf 20 23 e8 fe ff 0c 8c
            hex 79 7b bb d3 56 c0 d8 0d ; 3D9FE:  79 7b bb d3 56 c0 d8 0d
            hex da 8a ed f6 d6 21 da 0c ; 3DA06:  da 8a ed f6 d6 21 da 0c
            hex 8c 79 7b bb d3 57 c0 d8 ; 3DA0E:  8c 79 7b bb d3 57 c0 d8
            hex 1e da 8a f5 f6 d6 21 da ; 3DA16:  1e da 8a f5 f6 d6 21 da
            hex 8a fe f6 2b 0b cf 20 23 ; 3DA1E:  8a fe f6 2b 0b cf 20 23
            hex e8 00 00 87 13 3f 3e e9 ; 3DA26:  e8 00 00 87 13 3f 3e e9
            hex de d6 04 b3 0d 51 db b3 ; 3DA2E:  de d6 04 b3 0d 51 db b3
            hex e9 0d d7 04 b3 3e 3f e9 ; 3DA36:  e9 0d d7 04 b3 3e 3f e9
            hex de d6 04 b3 3c e9 0d d7 ; 3DA3E:  de d6 04 b3 3c e9 0d d7
            hex 04 b4 bb b3 e9 5e cb 04 ; 3DA46:  04 b4 bb b3 e9 5e cb 04
            hex cf 20 23 e8 00 00 a4 5f ; 3DA4E:  cf 20 23 e8 00 00 a4 5f
            hex 6f a6 63 6f c6 d8 6a da ; 3DA56:  6f a6 63 6f c6 d8 6a da
            hex a4 5f 6f 8b 36 b5 a6 63 ; 3DA5E:  a4 5f 6f 8b 36 b5 a6 63
            hex 6f d6 73 da a4 63 6f 8b ; 3DA66:  6f d6 73 da a4 63 6f 8b
            hex 36 b5 a6 5f 6f bb 8c 93 ; 3DA6E:  36 b5 a6 5f 6f bb 8c 93
            hex 61 bb b3 89 46 d4 cf 20 ; 3DA76:  61 bb b3 89 46 d4 cf 20
            hex 23 e8 fc ff ac 7e d7 2b ; 3DA7E:  23 e8 fc ff ac 7e d7 2b
            hex aa 63 6f e9 72 d7 02 2a ; 3DA86:  aa 63 6f e9 72 d7 02 2a
            hex 0b 1a c6 d8 9c da 0a 8b ; 3DA8E:  0b 1a c6 d8 9c da 0a 8b
            hex 36 b5 1b d6 a1 da 0b 8b ; 3DA96:  36 b5 1b d6 a1 da 0b 8b
            hex 36 b5 1a bb 8c 93 61 bb ; 3DA9E:  36 b5 1a bb 8c 93 61 bb
            hex b3 89 5a d4 cf 20 23 e8 ; 3DAA6:  b3 89 5a d4 cf 20 23 e8
            hex 00 00 68 8e 4f 6f a4 9d ; 3DAAE:  00 00 68 8e 4f 6f a4 9d
            hex 6d 8b 11 c0 d8 c6 da 0c ; 3DAB6:  6d 8b 11 c0 d8 c6 da 0c
            hex 53 bd 8c 00 83 d6 cc da ; 3DABE:  53 bd 8c 00 83 d6 cc da
            hex 0c 53 bd 8c 04 80 bb b3 ; 3DAC6:  0c 53 bd 8c 04 80 bb b3
            hex 64 e9 bd cb 08 8a 4f 6f ; 3DACE:  64 e9 bd cb 08 8a 4f 6f
            hex cf 20 23 e8 fc ff aa 5f ; 3DAD6:  cf 20 23 e8 fc ff aa 5f
            hex 6f e9 ab da 02 8a 4f 6f ; 3DADE:  6f e9 ab da 02 8a 4f 6f
            hex 2a 2b d6 04 db 0a d3 b3 ; 3DAE6:  2a 2b d6 04 db 0a d3 b3
            hex e9 8d d9 02 8c ff 00 c1 ; 3DAEE:  e9 8d d9 02 8c ff 00 c1
            hex d8 01 db 0b d0 2b d1 b3 ; 3DAF6:  d8 01 db 0b d0 2b d1 b3
            hex 0a d3 d4 0a d0 2a 0a d3 ; 3DAFE:  0a d3 d4 0a d0 2a 0a d3
            hex 8c ff 00 c1 d7 eb da 3b ; 3DB06:  8c ff 00 c1 d7 eb da 3b
            hex 89 ff d4 cf 20 23 e8 00 ; 3DB0E:  89 ff d4 cf 20 23 e8 00
            hex 00 a4 9d 6d 8b 11 c0 d8 ; 3DB16:  00 a4 9d 6d 8b 11 c0 d8
            hex 2a db aa 63 6f e9 72 d7 ; 3DB1E:  2a db aa 63 6f e9 72 d7
            hex 02 53 c0 cf aa 63 6f e9 ; 3DB26:  02 53 c0 cf aa 63 6f e9
            hex 72 d7 02 8b 14 c0 cf 20 ; 3DB2E:  72 d7 02 8b 14 c0 cf 20
            hex 23 e8 00 00 a4 09 6e d0 ; 3DB36:  23 e8 00 00 a4 09 6e d0
            hex a8 09 6e ac 82 d9 d8 4a ; 3DB3E:  a8 09 6e ac 82 d9 d8 4a
            hex db ac 62 d9 cf 20 23 e8 ; 3DB46:  db ac 62 d9 cf 20 23 e8
            hex 00 00 0c 8c f7 6c bb d3 ; 3DB4E:  00 00 0c 8c f7 6c bb d3
            hex 8c ff 00 c1 d8 6d db 3c ; 3DB56:  8c ff 00 c1 d8 6d db 3c
            hex e9 72 d7 02 59 b5 8c a8 ; 3DB5E:  e9 72 d7 02 59 b5 8c a8
            hex 77 bb b3 e9 c4 ce 02 cf ; 3DB66:  77 bb b3 e9 c4 ce 02 cf
            hex 20 23 e8 00 00 0c 8c f7 ; 3DB6E:  20 23 e8 00 00 0c 8c f7
            hex 6c bb d3 8c ff 00 c1 d8 ; 3DB76:  6c bb d3 8c ff 00 c1 d8
            hex 8f db 3c e9 72 d7 02 59 ; 3DB7E:  8f db 3c e9 72 d7 02 59
            hex b5 8c a8 77 bb b3 d6 92 ; 3DB86:  b5 8c a8 77 bb b3 d6 92
            hex db 8e 06 f7 e9 c4 ce 02 ; 3DB8E:  db 8e 06 f7 e9 c4 ce 02
            hex cf 20 23 e8 f8 ff 3c e9 ; 3DB96:  cf 20 23 e8 f8 ff 3c e9
            hex da d7 02                ; 3DB9E:  da d7 02

            ror $b3,x                   ; 3DBA1:  76 b3
            eor ($d4,x)                 ; 3DBA3:  41 d4
            rti                         ; 3DBA5:  40

            hex 28 65 e9 52 ca 02 b3 65 ; 3DBA6:  28 65 e9 52 ca 02 b3 65
            hex e9 52 ca 02 55 b5 b3 65 ; 3DBAE:  e9 52 ca 02 55 b5 b3 65
            hex e9 52 ca 02 8b 19 b5 b3 ; 3DBB6:  e9 52 ca 02 8b 19 b5 b3
            hex 65 e9 52 ca 02 8b 7d b5 ; 3DBBE:  65 e9 52 ca 02 8b 7d b5
            hex b4 bb b4 bb b4 bb 2a a4 ; 3DBC6:  b4 bb b4 bb b4 bb 2a a4
            hex 9d 6d 8b 32 c0 d8 db db ; 3DBCE:  9d 6d 8b 32 c0 d8 db db
            hex 89                      ; 3DBD6:  89

            and $d6,x                   ; 3DBD7:  35 d6
            cmp $89db,x                 ; 3DBD9:  dd db 89
            ora ($29),y                 ; 3DBDC:  11 29
            rti                         ; 3DBDE:  40

            hex 2b 41 28 d6 f6 db 0b d2 ; 3DBDF:  2b 41 28 d6 f6 db 0b d2
            hex 8c b1 6e bb b0 1a c0 d8 ; 3DBE7:  8c b1 6e bb b0 1a c0 d8
            hex f3 db 40 28 0b d0 2b 0b ; 3DBEF:  f3 db 40 28 0b d0 2b 0b
            hex 19 c6 d7 e5 db 08 d8 a7 ; 3DBF7:  19 c6 d7 e5 db 08 d8 a7
            hex db 3c e9 72 d7 02 d2 8c ; 3DBFF:  db 3c e9 72 d7 02 d2 8c
            hex b1 6e bb b3 0a b1 cf 20 ; 3DC07:  b1 6e bb b3 0a b1 cf 20
            hex 23 e8 00 00 0c 8b 31 c8 ; 3DC0F:  23 e8 00 00 0c 8b 31 c8
            hex d8 2a dc a5 4a 6e d1 a9 ; 3DC17:  d8 2a dc a5 4a 6e d1 a9
            hex 4a 6e a5 4a 6e 8c 4b 6e ; 3DC1F:  4a 6e a5 4a 6e 8c 4b 6e
            hex bb d3 cf a5 4a 6e d0 a9 ; 3DC27:  bb d3 cf a5 4a 6e d0 a9
            hex 4a 6e a5 4a 6e 8c 4a 6e ; 3DC2F:  4a 6e a5 4a 6e 8c 4a 6e
            hex bb b3 0c d4 cf 20 23 e8 ; 3DC37:  bb b3 0c d4 cf 20 23 e8
            hex fc ff 8a 7f 6e 2a 40 2b ; 3DC3F:  fc ff 8a 7f 6e 2a 40 2b
            hex d6 5d dc 0a d3 1c c0 d8 ; 3DC47:  d6 5d dc 0a d3 1c c0 d8
            hex 55 dc 3a 89 ff d4 0a d0 ; 3DC4F:  55 dc 3a 89 ff d4 0a d0
            hex 2a d1 0b d0 2b d1 0b a6 ; 3DC57:  2a d1 0b d0 2b d1 0b a6
            hex 9d 6d c6 d7 4a dc cf 20 ; 3DC5F:  9d 6d c6 d7 4a dc cf 20
            hex 23 e8 00 00 0c 8b 32 c8 ; 3DC67:  23 e8 00 00 0c 8b 32 c8
            hex d8 74 dc 0c cf a4 9d 6d ; 3DC6F:  d8 74 dc 0c cf a4 9d 6d
            hex 8b 32 c0 d8 81 dc 0c d6 ; 3DC77:  8b 32 c0 d8 81 dc 0c d6
            hex 87 dc 0c 8c 0e f7 bb d3 ; 3DC7F:  87 dc 0c 8c 0e f7 bb d3
            hex cf 20 23 e8 ff ff 61 de ; 3DC87:  cf 20 23 e8 ff ff 61 de
            hex ff ff b3 0d 5b b5 b3 aa ; 3DC8F:  ff ff b3 0d 5b b5 b3 aa
            hex 63 6f e9 66 dc 02 8b 37 ; 3DC97:  63 6f e9 66 dc 02 8b 37
            hex b5 b4 bb 1c bb 8c 7e a5 ; 3DC9F:  b5 b4 bb 1c bb 8c 7e a5
            hex bb b3 64 e9 bd cb 08 a0 ; 3DCA7:  bb b3 64 e9 bd cb 08 a0
            hex ff ff cf 20 23 e8 f3 ff ; 3DCAF:  ff ff cf 20 23 e8 f3 ff
            hex de f3 ff 29 6b e9 52 ca ; 3DCB7:  de f3 ff 29 6b e9 52 ca
            hex 02 d2 2b 6b e9 52 ca 02 ; 3DCBF:  02 d2 2b 6b e9 52 ca 02
            hex d2 2a 39 0b 8c 30 f9 bb ; 3DCC7:  d2 2a 39 0b 8c 30 f9 bb
            hex d3 d4 09 d0 29 b3 0b d0 ; 3DCCF:  d3 d4 09 d0 29 b3 0b d0
            hex 2b 8c 30 f9 bb d3 d4 09 ; 3DCD7:  2b 8c 30 f9 bb d3 d4 09
            hex d0 29 b3 0a 8c 5d f9 bb ; 3DCDF:  d0 29 b3 0a 8c 5d f9 bb
            hex d3 d4 09 d0 29 b3 0a d0 ; 3DCE7:  d3 d4 09 d0 29 b3 0a d0
            hex 2a 8c 5d f9 bb d3 d4    ; 3DCEF:  2a 8c 5d f9 bb d3 d4

            ora #$d0                    ; 3DCF6:  09 d0
            and #$b3                    ; 3DCF8:  29 b3
            rti                         ; 3DCFA:  40

            hex d4 40                   ; 3DCFB:  d4 40

            plp                         ; 3DCFD:  28
            rti                         ; 3DCFE:  40

tab_b15_dcff: ; 1695 bytes
            hex d6 1c dd 0b 59 b5 8c a8 ; 3DCFF:  d6 1c dd 0b 59 b5 8c a8
            hex 77 bb b3 de f3 ff b3 e9 ; 3DD07:  77 bb b3 de f3 ff b3 e9
            hex b0 ca 04 d7 1a dd 41 28 ; 3DD0F:  b0 ca 04 d7 1a dd 41 28
            hex d6 25 dd 0b d0 2b 0b a6 ; 3DD17:  d6 25 dd 0b d0 2b 0b a6
            hex 9d 6d c6 d7 02 dd 08 d7 ; 3DD1F:  9d 6d c6 d7 02 dd 08 d7
            hex b7 dc de f3 ff b3 0c 59 ; 3DD27:  b7 dc de f3 ff b3 0c 59
            hex b5 8c a8 77 bb b3 e9 d9 ; 3DD2F:  b5 8c a8 77 bb b3 e9 d9
            hex ca 04 cf 20 23 e8 f4 ff ; 3DD37:  ca 04 cf 20 23 e8 f4 ff
            hex de f8 ff 26 0d d6 67 dd ; 3DD3F:  de f8 ff 26 0d d6 67 dd
            hex 07 d3 b3 e9 b7 d9 02 1c ; 3DD47:  07 d3 b3 e9 b7 d9 02 1c
            hex dc d7 65 dd 07 d3 b3 e9 ; 3DD4F:  dc d7 65 dd 07 d3 b3 e9
            hex 99 d9 02 d7 65 dd 06 d0 ; 3DD57:  99 d9 02 d7 65 dd 06 d0
            hex 26 d1 b3 07 d3 d4 07 d0 ; 3DD5F:  26 d1 b3 07 d3 d4 07 d0
            hex 27 07 d3 8c ff 00 c1 d7 ; 3DD67:  27 07 d3 8c ff 00 c1 d7
            hex 47 dd 36 89 ff d4 68 3d ; 3DD6F:  47 dd 36 89 ff d4 68 3d
            hex de f8 ff b3 60 e9 bd cb ; 3DD77:  de f8 ff b3 60 e9 bd cb
            hex 08 cf 20 23 e8 f8 ff 3c ; 3DD7F:  08 cf 20 23 e8 f8 ff 3c
            hex e9 da d7 02 b3 8d 14 e9 ; 3DD87:  e9 da d7 02 b3 8d 14 e9
            hex 52 ca 02 8f 14 d4 3c e9 ; 3DD8F:  52 ca 02 8f 14 d4 3c e9
            hex da d7 02 d0 2a d6 c8 dd ; 3DD97:  da d7 02 d0 2a d6 c8 dd
            hex 3b 8d 14 e9 52 ca 02 8f ; 3DD9F:  3b 8d 14 e9 52 ca 02 8f
            hex 32 b3 0b d3 b3 e9 0d d7 ; 3DDA7:  32 b3 0b d3 b3 e9 0d d7
            hex 04 d4 0b d3 8b 1e c2 d8 ; 3DDAF:  04 d4 0b d3 8b 1e c2 d8
            hex be dd 89 1e d6 bf dd 40 ; 3DDB7:  be dd 89 1e d6 bf dd 40
            hex b3 0b b4 b3 d3 bb d4 0b ; 3DDBF:  b3 0b b4 b3 d3 bb d4 0b
            hex d0 2b 0a 74 b3 0b b4 c7 ; 3DDC7:  d0 2b 0a 74 b3 0b b4 c7
            hex d7 9f dd 0c 8b 1a b5 8c ; 3DDCF:  d7 9f dd 0c 8b 1a b5 8c
            hex 01 70 bb 28 d6 45 de 0c ; 3DDD7:  01 70 bb 28 d6 45 de 0c
            hex 8b 1a b5 8c 17 70 bb 19 ; 3DDDF:  8b 1a b5 8c 17 70 bb 19
            hex c0 d8 0a de 39 8d 1f e9 ; 3DDE7:  c0 d8 0a de 39 8d 1f e9
            hex 52 ca 02 8f 32 b3 09 b0 ; 3DDEF:  52 ca 02 8f 32 b3 09 b0
            hex b3 e9 0d d7 04 b1 09 b0 ; 3DDF7:  b3 e9 0d d7 04 b1 09 b0
            hex 8b 32 c2 d8 3b de 89 32 ; 3DDFF:  8b 32 c2 d8 3b de 89 32
            hex d6 3c de 39 0c 8c a2 6d ; 3DE07:  d6 3c de 39 0c 8c a2 6d
            hex bb d3 d8 1f de 8d 14 e9 ; 3DE0F:  bb d3 d8 1f de 8d 14 e9
            hex 52 ca 02 8f 32 d6 27 de ; 3DE17:  52 ca 02 8f 32 d6 27 de
            hex 8d 1e e9 52 ca 02 8f 1e ; 3DE1F:  8d 1e e9 52 ca 02 8f 1e
            hex b3 09 b0 b3 e9 0d d7 04 ; 3DE27:  b3 09 b0 b3 e9 0d d7 04
            hex b1 09 b0 5a c2 d8 3b de ; 3DE2F:  b1 09 b0 5a c2 d8 3b de
            hex 4a d6 3c de 40 b3 09 b4 ; 3DE37:  4a d6 3c de 40 b3 09 b4
            hex b3 b0 bb b1 09 72 29 08 ; 3DE3F:  b3 b0 bb b1 09 72 29 08
            hex 8f 18 b3 09 b4 c6 d7 de ; 3DE47:  8f 18 b3 09 b4 c6 d7 de
            hex dd 8d 32 0c 8b 1a b5 8c ; 3DE4F:  dd 8d 32 0c 8b 1a b5 8c
            hex 0d 70 bb b4 b3 b0 bb b1 ; 3DE57:  0d 70 bb b4 b3 b0 bb b1
            hex 8d 32 0c 8b 1a b5 8c 13 ; 3DE5F:  8d 32 0c 8b 1a b5 8c 13
            hex 70 bb b4 b3 b0 bb b1 0c ; 3DE67:  70 bb b4 b3 b0 bb b1 0c
            hex 8c 2d 6d bb b3 89 14 d4 ; 3DE6F:  8c 2d 6d bb b3 89 14 d4
            hex cf 20 23 e8 fe ff a5 a1 ; 3DE77:  cf 20 23 e8 fe ff a5 a1
            hex 6d 8b 20 da d8 8a de 8a ; 3DE7F:  6d 8b 20 da d8 8a de 8a
            hex 2e f7 cf a5 a1 6d 8b 10 ; 3DE87:  2e f7 cf a5 a1 6d 8b 10
            hex da d8 97 de 8a 6a 79 cf ; 3DE8F:  da d8 97 de 8a 6a 79 cf
            hex 0c d9 04 00 07 00 ad de ; 3DE97:  0c d9 04 00 07 00 ad de
            hex 0d 00 b3 de 17 00 ad de ; 3DE9F:  0d 00 b3 de 17 00 ad de
            hex 1e 00 b3 de b9 de 8a 20 ; 3DEA7:  1e 00 b3 de b9 de 8a 20
            hex f7 2b 0b cf 8a 28 f7 d6 ; 3DEAF:  f7 2b 0b cf 8a 28 f7 d6
            hex b0 de 3c e9 f7 d9 02 d6 ; 3DEB7:  b0 de 3c e9 f7 d9 02 d6
            hex b0 de 20 23 e8 f8 ff a4 ; 3DEBF:  b0 de 20 23 e8 f8 ff a4
            hex 57 6f a6 63 6f c0 d8 d6 ; 3DEC7:  57 6f a6 63 6f c0 d8 d6
            hex de a4 5f 6f d6 d9 de a4 ; 3DECF:  de a4 5f 6f d6 d9 de a4
            hex 63 6f 28 b3 e9 72 d7 02 ; 3DED7:  63 6f 28 b3 e9 72 d7 02
            hex 2a aa 57 6f e9 72 d7 02 ; 3DEDF:  2a aa 57 6f e9 72 d7 02
            hex 29 b3 e9 0e dc 02 39 e9 ; 3DEE7:  29 b3 e9 0e dc 02 39 e9
            hex 3c dc 02 40 d6 33 df 3b ; 3DEEF:  3c dc 02 40 d6 33 df 3b
            hex e9 72 d7 02 19 c0 d8 31 ; 3DEF7:  e9 72 d7 02 19 c0 d8 31
            hex df 3b e9 99 d9 02 d7 31 ; 3DEFF:  df 3b e9 99 d9 02 d7 31
            hex df 0b 8c 15 6e bb b3 0a ; 3DF07:  df 0b 8c 15 6e bb b3 0a
            hex d4 0b 8c a2 6d bb b3 40 ; 3DF0F:  d4 0b 8c a2 6d bb b3 40
            hex d4 0b 8c f7 6c bb b3 38 ; 3DF17:  d4 0b 8c f7 6c bb b3 38
            hex e9 8d d9 02 d8 2a df 45 ; 3DF1F:  e9 8d d9 02 d8 2a df 45
            hex d6 2b df 40 d4 3b e9 54 ; 3DF27:  d6 2b df 40 d4 3b e9 54
            hex e5 02 0b d0 2b 0b a6 9d ; 3DF2F:  e5 02 0b d0 2b 0b a6 9d
            hex 6d c6 d7 f6 de cf 20 23 ; 3DF37:  6d c6 d7 f6 de cf 20 23
            hex e8 fe ff 3c e9 da d7 02 ; 3DF3F:  e8 fe ff 3c e9 da d7 02
            hex 2b 0b 72 b3 d3 d0 d4 0b ; 3DF47:  2b 0b 72 b3 d3 d0 d4 0b
            hex 74 b3 d3 d0 d4 0b 75 b3 ; 3DF4F:  74 b3 d3 d0 d4 0b 75 b3
            hex d3 d0 d4 3d e9 da d7 02 ; 3DF57:  d3 d0 d4 3d e9 da d7 02
            hex 2b 0b 72 b3 d3 d1 d4 0b ; 3DF5F:  2b 0b 72 b3 d3 d1 d4 0b
            hex 74 b3 d3 d1 d4 0b 75 b3 ; 3DF67:  74 b3 d3 d1 d4 0b 75 b3
            hex d3 d1 d4 cf 20 23 e8 f8 ; 3DF6F:  d3 d1 d4 cf 20 23 e8 f8
            hex ff a4 5f 6f 8b 1a b5 8c ; 3DF77:  ff a4 5f 6f 8b 1a b5 8c
            hex 13 70 bb 29 a4 63 6f 8b ; 3DF7F:  13 70 bb 29 a4 63 6f 8b
            hex 1a b5 8c 13 70 bb 2a 0a ; 3DF87:  1a b5 8c 13 70 bb 2a 0a
            hex 76 b0 2b 40 28 3a 3b aa ; 3DF8F:  76 b0 2b 40 28 3a 3b aa
            hex 87 6f aa 81 6f 09 b0 b3 ; 3DF97:  87 6f aa 81 6f 09 b0 b3
            hex 0a b0 b3 e9 24 da 0a b1 ; 3DF9F:  0a b0 b3 e9 24 da 0a b1
            hex 08 d0 28 d1 0a 72 2a 8f ; 3DFA7:  08 d0 28 d1 0a 72 2a 8f
            hex fe 09 72 29 8f fe 08 53 ; 3DFAF:  fe 09 72 29 8f fe 08 53
            hex c6 d7 94 df cf 20 23 e8 ; 3DFB7:  c6 d7 94 df cf 20 23 e8
            hex fe ff a4 63 6f 2b 40 d6 ; 3DFBF:  fe ff a4 63 6f 2b 40 d6
            hex ec df ac 12 db d8 e8 df ; 3DFC7:  ec df ac 12 db d8 e8 df
            hex a4 63 6f 8c 2d 6d bb d3 ; 3DFCF:  a4 63 6f 8c 2d 6d bb d3
            hex 8b 1e c4 d8 e8 df a4 63 ; 3DFD7:  8b 1e c4 d8 e8 df a4 63
            hex 6f 8c 2d 6d bb b3 89 1e ; 3DFDF:  6f 8c 2d 6d bb b3 89 1e
            hex d4 a4 63 6f d0 a8 63 6f ; 3DFE7:  d4 a4 63 6f d0 a8 63 6f
            hex a4 63 6f a6 9d 6d c6 d7 ; 3DFEF:  a4 63 6f a6 9d 6d c6 d7
            hex c9 df 0b a8 63 6f cf 20 ; 3DFF7:  c9 df 0b a8 63 6f cf 20
            hex 23 e8 fe ff 0d 8f 16 b0 ; 3DFFF:  23 e8 fe ff 0d 8f 16 b0
            hex 8b 32 b6 8f 14 2b 0c 55 ; 3E007:  8b 32 b6 8f 14 2b 0c 55
            hex b5 8c ab 76 bb d3 1b c8 ; 3E00F:  b5 8c ab 76 bb d3 1b c8
            hex d8 3b e0 0c 55 b5 8c ab ; 3E017:  d8 3b e0 0c 55 b5 8c ab
            hex 76 bb d3 1b bc b3 0c 55 ; 3E01F:  76 bb d3 1b bc b3 0c 55
            hex b5 8c a9 76 bb b4 b3 d3 ; 3E027:  b5 8c a9 76 bb b4 b3 d3
            hex bb d4 0c 55 b5 8c ab 76 ; 3E02F:  bb d4 0c 55 b5 8c ab 76
            hex bb b3 0b d4 cf 20 23 e8 ; 3E037:  bb b3 0b d4 cf 20 23 e8
            hex f4 ff aa 63 6f e9 36 d8 ; 3E03F:  f4 ff aa 63 6f e9 36 d8
            hex 02 a4 63 6f 8b 1a b5 8c ; 3E047:  02 a4 63 6f 8b 1a b5 8c
            hex 01 70 bb 26 a4 5f 6f 8b ; 3E04F:  01 70 bb 26 a4 5f 6f 8b
            hex 32 c0 28 a4 57 6f a6 63 ; 3E057:  32 c0 28 a4 57 6f a6 63
            hex 6f c0 29 09 d8 80 e0 65 ; 3E05F:  6f c0 29 09 d8 80 e0 65
            hex a4 63 6f 55 b5 8c a9 76 ; 3E067:  a4 63 6f 55 b5 8c a9 76
            hex bb b3 a4 5f 6f 55 b5 8c ; 3E06F:  bb b3 a4 5f 6f 55 b5 8c
            hex a9 76 bb b3 64 e9 bd cb ; 3E077:  a9 76 bb b3 64 e9 bd cb
            hex 08 08 d7 a6 e0 ac 73 df ; 3E07F:  08 08 d7 a6 e0 ac 73 df
            hex 36 aa 63 6f e9 fe df 04 ; 3E087:  36 aa 63 6f e9 fe df 04
            hex 09 d8 9c e0 aa 63 6f aa ; 3E08F:  09 d8 9c e0 aa 63 6f aa
            hex 5f 6f d6 a2 e0 aa 5f 6f ; 3E097:  5f 6f d6 a2 e0 aa 5f 6f
            hex aa 63 6f e9 3d df 04 a5 ; 3E09F:  aa 63 6f e9 3d df 04 a5
            hex a1 6d 8b 20 da d7 b3 e0 ; 3E0A7:  a1 6d 8b 20 da d7 b3 e0
            hex 08 d7 b7 e0 40 d6 b8 e0 ; 3E0AF:  08 d7 b7 e0 40 d6 b8 e0
            hex 41 27 07 d8 cb e0 09 d7 ; 3E0B7:  41 27 07 d8 cb e0 09 d7
            hex cb e0 40 a8 81 6f a8 7f ; 3E0BF:  cb e0 40 a8 81 6f a8 7f
            hex 6f a8 7d 6f 36 a4 7d 6f ; 3E0C7:  6f a8 7d 6f 36 a4 7d 6f
            hex a6 83 6f bb b1 06 76 b3 ; 3E0CF:  a6 83 6f bb b1 06 76 b3
            hex a4 7f 6f a6 85 6f bb b1 ; 3E0D7:  a4 7f 6f a6 85 6f bb b1
            hex 06 8f 10 b3 a4 81 6f a6 ; 3E0DF:  06 8f 10 b3 a4 81 6f a6
            hex 87 6f bb b1 07 d8 06 e1 ; 3E0E7:  87 6f bb b1 07 d8 06 e1
            hex 6a e9 52 ca 02 7a b3 06 ; 3E0EF:  6a e9 52 ca 02 7a b3 06
            hex 78 b0 b3 e9 0d d7 04 b3 ; 3E0F7:  78 b0 b3 e9 0d d7 04 b3
            hex 06 78 b4 b3 b0 bc b1 a4 ; 3E0FF:  06 78 b4 b3 b0 bc b1 a4
            hex 63 6f 8c 15 6e bb 2a 08 ; 3E107:  63 6f 8c 15 6e bb 2a 08
            hex d7 20 e1 39 e9 e5 d9 02 ; 3E10F:  d7 20 e1 39 e9 e5 d9 02
            hex d8 20 e1 ac c1 de d6 9c ; 3E117:  d8 20 e1 ac c1 de d6 9c
            hex e1 09 d8 9c e1 08 d8 78 ; 3E11F:  e1 09 d8 9c e1 08 d8 78
            hex e1 a4 63 6f 8c a2 6d bb ; 3E127:  e1 a4 63 6f 8c a2 6d bb
            hex d3 d8 6e e1 0a d3 b3 e9 ; 3E12F:  d3 d8 6e e1 0a d3 b3 e9
            hex 0e dc 02 0a d3 b3 e9 3c ; 3E137:  0e dc 02 0a d3 b3 e9 3c
            hex dc 02 40 d6 65 e1 0a d3 ; 3E13F:  dc 02 40 d6 65 e1 0a d3
            hex b3 3b e9 72 d7 02 b4 c0 ; 3E147:  b3 3b e9 72 d7 02 b4 c0
            hex d8 63 e1 0b a6 63 6f c1 ; 3E14F:  d8 63 e1 0b a6 63 6f c1
            hex d8 63 e1 3b e9 c8 d9 02 ; 3E157:  d8 63 e1 3b e9 c8 d9 02
            hex b3 89 ff d4 0b d0 2b 0b ; 3E15F:  b3 89 ff d4 0b d0 2b 0b
            hex a6 9d 6d c6 d7 45 e1 aa ; 3E167:  a6 9d 6d c6 d7 45 e1 aa
            hex 63 6f e9 1b e2 02 d6 9c ; 3E16F:  63 6f e9 1b e2 02 d6 9c
            hex e1 3a ac 7e d7 d4 aa 63 ; 3E177:  e1 3a ac 7e d7 d4 aa 63
            hex 6f e9 c8 d9 02 b3 aa 5f ; 3E17F:  6f e9 c8 d9 02 b3 aa 5f
            hex 6f e9 8d d9 02 d8 93 e1 ; 3E187:  6f e9 8d d9 02 d8 93 e1
            hex 45 d6 94 e1 40 d4 aa 63 ; 3E18F:  45 d6 94 e1 40 d4 aa 63
            hex 6f e9 54 e5 02 08 d7 c7 ; 3E197:  6f e9 54 e5 02 08 d7 c7
            hex e1 09 d8 c7 e1 a4 63 6f ; 3E19F:  e1 09 d8 c7 e1 a4 63 6f
            hex 8c a2 6d bb b3 a5 65 6f ; 3E1A7:  8c a2 6d bb b3 a5 65 6f
            hex 57 bf d4 a4 63 6f 8c a2 ; 3E1AF:  57 bf d4 a4 63 6f 8c a2
            hex 6d bb d3 b3 a4 5f 6f 8c ; 3E1B7:  6d bb d3 b3 a4 5f 6f 8c
            hex a2 6d bb b4 b3 d3 dc d4 ; 3E1BF:  a2 6d bb b4 b3 d3 dc d4
            hex 89 8f cd a5 a1 6d da a9 ; 3E1C7:  89 8f cd a5 a1 6d da a9
            hex a1 6d ac bc df aa 63 6f ; 3E1CF:  a1 6d ac bc df aa 63 6f
            hex e9 36 d8 02 08 d7 e6 e1 ; 3E1D7:  e9 36 d8 02 08 d7 e6 e1
            hex aa 5f 6f e9 36 d8 02 cf ; 3E1DF:  aa 5f 6f e9 36 d8 02 cf
            hex 20 23 e8 fe ff 8d 1d e9 ; 3E1E7:  20 23 e8 fe ff 8d 1d e9
            hex 03 ca 02 40 d6 11 e2 0c ; 3E1EF:  03 ca 02 40 d6 11 e2 0c
            hex 8b 36 b5 1b bb 8c 93 61 ; 3E1F7:  8b 36 b5 1b bb 8c 93 61
            hex bb b3 0b 8b 36 b5 1c bb ; 3E1FF:  bb b3 0b 8b 36 b5 1c bb
            hex 8c 93 61 bb b3 40 d4 d4 ; 3E207:  8c 93 61 bb b3 40 d4 d4
            hex 0b d0 2b 0b a6 9d 6d c6 ; 3E20F:  0b d0 2b 0b a6 9d 6d c6
            hex d7 f6 e1 cf 20 23 e8 00 ; 3E217:  d7 f6 e1 cf 20 23 e8 00
            hex 00 0c 8c 15 6e bb b3 8e ; 3E21F:  00 0c 8c 15 6e bb b3 8e
            hex ff 00 e9 0e dc 02 d4 3c ; 3E227:  ff 00 e9 0e dc 02 d4 3c
            hex e9 72 d7 02 b3 e9 b2 dc ; 3E22F:  e9 72 d7 02 b3 e9 b2 dc
            hex 02 3c e9 72 d7 02 59 b5 ; 3E237:  02 3c e9 72 d7 02 59 b5
            hex 8c a8 77 bb b3 e9 26 d3 ; 3E23F:  8c a8 77 bb b3 e9 26 d3
            hex 02 0c d0 b3 8e 35 f7 e9 ; 3E247:  02 0c d0 b3 8e 35 f7 e9
            hex 34 d1 04 0c 8c f7 6c bb ; 3E24F:  34 d1 04 0c 8c f7 6c bb
            hex b3 40 d4 0c 8c a2 6d bb ; 3E257:  b3 40 d4 0c 8c a2 6d bb
            hex b3 41 d4 3c e9 81 dd 02 ; 3E25F:  b3 41 d4 3c e9 81 dd 02
            hex 3c e9 97 db 02 3c e9 54 ; 3E267:  3c e9 97 db 02 3c e9 54
            hex e5 02 ac 66 d7 cf 20 23 ; 3E26F:  e5 02 ac 66 d7 cf 20 23
            hex e8 00 00 3c e9 e7 e1 02 ; 3E277:  e8 00 00 3c e9 e7 e1 02
            hex 3c e9 72 d7 02 59 b5 8c ; 3E27F:  3c e9 72 d7 02 59 b5 8c
            hex a8 77 bb b3 e9 26 d3 02 ; 3E287:  a8 77 bb b3 e9 26 d3 02
            hex 8e 4f f7 e9 c4 ce 02 3c ; 3E28F:  8e 4f f7 e9 c4 ce 02 3c
            hex e9 8d d9 02 d8 ab e2 aa ; 3E297:  e9 8d d9 02 d8 ab e2 aa
            hex 9f 6d 0c d0 b3 8e 5b f7 ; 3E29F:  9f 6d 0c d0 b3 8e 5b f7
            hex e9 34 d1 06 ac 66 d7 cf ; 3E2A7:  e9 34 d1 06 ac 66 d7 cf
            hex 20 23 e8 fc ff 40 2a 0c ; 3E2AF:  20 23 e8 fc ff 40 2a 0c
            hex 55 b5 8c a9 76 bb 2b d6 ; 3E2B7:  55 b5 8c a9 76 bb 2b d6
            hex cf e2 0b d0 2b d1 b3 0d ; 3E2BF:  cf e2 0b d0 2b d1 b3 0d
            hex d0 2d d1 d3 d4 0a d0 2a ; 3E2C7:  d0 2d d1 d3 d4 0a d0 2a
            hex 0a 55 c6 d7 c1 e2 cf 20 ; 3E2CF:  0a 55 c6 d7 c1 e2 cf 20
            hex 23 e8 00 00 ac 89 cc 8e ; 3E2D7:  23 e8 00 00 ac 89 cc 8e
            hex 77 f7 e9 26 d3 02 aa 63 ; 3E2DF:  77 f7 e9 26 d3 02 aa 63
            hex 6f e9 72 d7 02 59 b5 8c ; 3E2E7:  6f e9 72 d7 02 59 b5 8c
            hex a8 77 bb b3 e9 c4 ce 02 ; 3E2EF:  a8 77 bb b3 e9 c4 ce 02
            hex 8e 7d f7 e9 c4 ce 02 ac ; 3E2F7:  8e 7d f7 e9 c4 ce 02 ac
            hex 7e d7 59 b5 8c a8 77 bb ; 3E2FF:  7e d7 59 b5 8c a8 77 bb
            hex b3 e9 c4 ce 02 3c 8e 7f ; 3E307:  b3 e9 c4 ce 02 3c 8e 7f
            hex f7 e9 34 d1 04 cf 20 23 ; 3E30F:  f7 e9 34 d1 04 cf 20 23
            hex e8 fa ff aa 63 6f e9 8d ; 3E317:  e8 fa ff aa 63 6f e9 8d
            hex d9 02 d8 61 e3 a4 d3 7f ; 3E31F:  d9 02 d8 61 e3 a4 d3 7f
            hex 29 42 a8 d3 7f 8e 98 f7 ; 3E327:  29 42 a8 d3 7f 8e 98 f7
            hex e9 d6 e2 02 8e a6 f7 e9 ; 3E32F:  e9 d6 e2 02 8e a6 f7 e9
            hex c4 ce 02 ac a7 d3 d8 59 ; 3E337:  c4 ce 02 ac a7 d3 d8 59
            hex e3 8e 8c f7 e9 26 d3 02 ; 3E33F:  e3 8e 8c f7 e9 26 d3 02
            hex 8e 0f 27 61 e9 e9 d5 04 ; 3E347:  8e 0f 27 61 e9 e9 d5 04
            hex 2b d7 5b e3 ac 89 cc d6 ; 3E34F:  2b d7 5b e3 ac 89 cc d6
            hex 5b e3 40 2b 09 a8 d3 7f ; 3E357:  5b e3 40 2b 09 a8 d3 7f
            hex 0b cf aa 63 6d e9 52 ca ; 3E35F:  0b cf aa 63 6d e9 52 ca
            hex 02 d7 a2 e3 aa 5f 6f e9 ; 3E367:  02 d7 a2 e3 aa 5f 6f e9
            hex 72 d9 02 d8 7d e3 63 e9 ; 3E36F:  72 d9 02 d8 7d e3 63 e9
            hex 52 ca 02 d7 a2 e3 a4 5f ; 3E377:  52 ca 02 d7 a2 e3 a4 5f
            hex 6f 8b 1a b5 8c 01 70 bb ; 3E37F:  6f 8b 1a b5 8c 01 70 bb
            hex b0 2a 8c c8 00 c4 d8 a2 ; 3E387:  b0 2a 8c c8 00 c4 d8 a2
            hex e3 8d 1e e9 52 ca 02 8f ; 3E38F:  e3 8d 1e e9 52 ca 02 8f
            hex 32 b3 3a e9 0d d7 04    ; 3E397:  32 b3 3a e9 0d d7 04

            bcc tab_b15_dcff+1641       ; 3E39E:  90 c8
            brk                         ; 3E3A0:  00
            hex cf                      ; 3E3A1:  cf
            rti                         ; 3E3A2:  40

            hex cf 20 23 e8 fa ff aa 63 ; 3E3A3:  cf 20 23 e8 fa ff aa 63
            hex 6f e9 8d d9 02 d8 de e3 ; 3E3AB:  6f e9 8d d9 02 d8 de e3
            hex a4 d3 7f 29 42 a8 d3 7f ; 3E3B3:  a4 d3 7f 29 42 a8 d3 7f
            hex 8e ad f7 e9 d6 e2 02 8e ; 3E3BB:  8e ad f7 e9 d6 e2 02 8e
            hex 8c f7 e9 c4 ce 02 8e 0f ; 3E3C3:  8c f7 e9 c4 ce 02 8e 0f
            hex 27 61 e9 e9 d5 04 2b d7 ; 3E3CB:  27 61 e9 e9 d5 04 2b d7
            hex d8 e3 ac 89 cc 09 a8 d3 ; 3E3D3:  d8 e3 ac 89 cc 09 a8 d3
            hex 7f 0b cf aa 5f 6f e9 72 ; 3E3DB:  7f 0b cf aa 5f 6f e9 72
            hex d9 02 d8 f0 e3 63 e9 52 ; 3E3E3:  d9 02 d8 f0 e3 63 e9 52
            hex ca 02 d7 23 e4 a4 5f 6f ; 3E3EB:  ca 02 d7 23 e4 a4 5f 6f
            hex 8b 1a b5 8c 01 70 bb b0 ; 3E3F3:  8b 1a b5 8c 01 70 bb b0
            hex 2a aa 63 6d e9 52 ca 02 ; 3E3FB:  2a aa 63 6d e9 52 ca 02
            hex d7 21 e4 8d 32 e9 52 ca ; 3E403:  d7 21 e4 8d 32 e9 52 ca
            hex 02 b3 3a e9 0d d7 04 b3 ; 3E40B:  02 b3 3a e9 0d d7 04 b3
            hex 8d 32 3a e9 0d d7 04 b4 ; 3E413:  8d 32 3a e9 0d d7 04 b4
            hex bb 8f 14 d6 22 e4 40 cf ; 3E41B:  bb 8f 14 d6 22 e4 40 cf
            hex 40 cf 20 23 e8 fe ff 3c ; 3E423:  40 cf 20 23 e8 fe ff 3c
            hex e9 72 d7 02 2c 3c e9 3c ; 3E42B:  e9 72 d7 02 2c 3c e9 3c
            hex dc 02 40 d6 4a e4 3b e9 ; 3E433:  dc 02 40 d6 4a e4 3b e9
            hex 72 d7 02 1c c0 d8 48 e4 ; 3E43B:  72 d7 02 1c c0 d8 48 e4
            hex 3b e9 54 e4 02 0b d0 2b ; 3E443:  3b e9 54 e4 02 0b d0 2b
            hex 0b a6 9d 6d c6 d7 39 e4 ; 3E44B:  0b a6 9d 6d c6 d7 39 e4
            hex cf 20 23 e8 00 00 0c 8c ; 3E453:  cf 20 23 e8 00 00 0c 8c
            hex f7 6c bb d3 8c ff 00 c1 ; 3E45B:  f7 6c bb d3 8c ff 00 c1
            hex d8 a1 e4 8e b2 f7 e9 26 ; 3E463:  d8 a1 e4 8e b2 f7 e9 26
            hex d3 02 0c d0 b3 8e b8 f7 ; 3E46B:  d3 02 0c d0 b3 8e b8 f7
            hex e9 34 d1 04 ac 66 d7 0c ; 3E473:  e9 34 d1 04 ac 66 d7 0c
            hex 8c f7 6c bb b3 89 ff d4 ; 3E47B:  8c f7 6c bb b3 89 ff d4
            hex 0c 8c a2 6d bb b3 40 d4 ; 3E483:  0c 8c a2 6d bb b3 40 d4
            hex 0c 8c 2d 6d bb b3 89 14 ; 3E48B:  0c 8c 2d 6d bb b3 89 14
            hex d4 8e a3 77 3c e9 af e2 ; 3E493:  d4 8e a3 77 3c e9 af e2
            hex 04 3c e9 54 e5 02 cf 20 ; 3E49B:  04 3c e9 54 e5 02 cf 20
            hex 23 e8 fc ff a4 5f 6f 2a ; 3E4A3:  23 e8 fc ff a4 5f 6f 2a
            hex 8a 89 6f 2b 40 d6 c6 e4 ; 3E4AB:  8a 89 6f 2b 40 d6 c6 e4
            hex ac a9 d9 d8 c2 e4 0b d0 ; 3E4B3:  ac a9 d9 d8 c2 e4 0b d0
            hex 2b d1 b3 a4 5f 6f d4 a4 ; 3E4BB:  2b d1 b3 a4 5f 6f d4 a4
            hex 5f 6f d0 a8 5f 6f a4 5f ; 3E4C3:  5f 6f d0 a8 5f 6f a4 5f
            hex 6f a6 9d 6d c6 d7 b3 e4 ; 3E4CB:  6f a6 9d 6d c6 d7 b3 e4
            hex 3b 89 ff d4 0a a8 5f 6f ; 3E4D3:  3b 89 ff d4 0a a8 5f 6f
            hex cf 20 23 e8 fc ff ac a2 ; 3E4DB:  cf 20 23 e8 fc ff ac a2
            hex e4 8a 89 6f 2a d6 01 e5 ; 3E4E3:  e4 8a 89 6f 2a d6 01 e5
            hex 0b d3 b3 e9 72 d7 02 1c ; 3E4EB:  0b d3 b3 e9 72 d7 02 1c
            hex c1 d8 ff e4 0a d0 2a d1 ; 3E4F3:  c1 d8 ff e4 0a d0 2a d1
            hex b3 0b d3 d4 0b d0 2b 0b ; 3E4FB:  b3 0b d3 d4 0b d0 2b 0b
            hex d3 8c ff 00 c1 d7 eb e4 ; 3E503:  d3 8c ff 00 c1 d7 eb e4
            hex 3a 89 ff d4 cf 20 23 e8 ; 3E50B:  3a 89 ff d4 cf 20 23 e8
            hex fa ff 8a 89 6f          ; 3E513:  fa ff 8a 89 6f

            and #$40                    ; 3E518:  29 40
            rol a                       ; 3E51A:  2a
            rti                         ; 3E51B:  40

            hex d6 45 e5 3b e9 99 d9 02 ; 3E51C:  d6 45 e5 3b e9 99 d9 02
            hex d7 43 e5 3b e9 b7 d9 02 ; 3E524:  d7 43 e5 3b e9 b7 d9 02
            hex 1c dc d7 43 e5 a4 5f 6f ; 3E52C:  1c dc d7 43 e5 a4 5f 6f
            hex 1b c1 d8 43 e5 09 d0 29 ; 3E534:  1b c1 d8 43 e5 09 d0 29
            hex d1 b3 0b d4 0a d0 2a 0b ; 3E53C:  d1 b3 0b d4 0a d0 2a 0b
            hex d0 2b 0b a6 9d 6d c6 d7 ; 3E544:  d0 2b 0b a6 9d 6d c6 d7
            hex 1f e5 39 89 ff d4 0a cf ; 3E54C:  1f e5 39 89 ff d4 0a cf
            hex 20 23 e8 d8 ff a4 5d 6f ; 3E554:  20 23 e8 d8 ff a4 5d 6f
            hex 58 c7 d8 94 e5 a4 cd 7f ; 3E55C:  58 c7 d8 94 e5 a4 cd 7f
            hex 2b a4 cf 7f 2a 8d 22 de ; 3E564:  2b a4 cf 7f 2a 8d 22 de
            hex da ff b3 a4 5d 6f 8b 22 ; 3E56C:  da ff b3 a4 5d 6f 8b 22
            hex b5 8c 3c 9e bb b3 64 e9 ; 3E574:  b5 8c 3c 9e bb b3 64 e9
            hex bd cb 08 de da ff 85 d8 ; 3E57C:  bd cb 08 de da ff 85 d8
            hex 81 d8 d3 8c ff 00 c1 d7 ; 3E584:  81 d8 d3 8c ff 00 c1 d7
            hex 95 e5 3a 3b e9 7b cc 04 ; 3E58C:  95 e5 3a 3b e9 7b cc 04
            hex cf 81 d8 d0 85 d8 d1 d3 ; 3E594:  cf 81 d8 d0 85 d8 d1 d3
            hex a8 cd 7f 81 d8 d0 85 d8 ; 3E59C:  a8 cd 7f 81 d8 d0 85 d8
            hex d1 d3 a8 cf 7f 81 d8 d0 ; 3E5A4:  d1 d3 a8 cf 7f 81 d8 d0
            hex 85 d8 d1 d3 1c c0 d8 84 ; 3E5AC:  85 d8 d1 d3 1c c0 d8 84
            hex e5 64 a4 cf 7f 8f fc 8b ; 3E5B4:  e5 64 a4 cf 7f 8f fc 8b
            hex 1c b5 b3 a4 5d 6f 8c c0 ; 3E5BC:  1c b5 b3 a4 5d 6f 8c c0
            hex 01 b5 b4 bb a6 cd 7f bb ; 3E5C4:  01 b5 b4 bb a6 cd 7f bb
            hex 8c 5a 8d bb b3 aa cf 7f ; 3E5CC:  8c 5a 8d bb b3 aa cf 7f
            hex 8d 1d a4 cd 7f 78 b3 e9 ; 3E5D4:  8d 1d a4 cd 7f 78 b3 e9
            hex 5e cb 04 b3 aa cf 7f aa ; 3E5DC:  5e cb 04 b3 aa cf 7f aa
            hex cd 7f e9 54 cc 0c 3c e9 ; 3E5E4:  cd 7f e9 54 cc 0c 3c e9
            hex 6e db 02 d6 8e e5 20 23 ; 3E5EC:  6e db 02 d6 8e e5 20 23
            hex e8 d8 ff 0c a6 5d 6f c1 ; 3E5F4:  e8 d8 ff 0c a6 5d 6f c1
            hex d8 93 e6 61 e9 35 cc 02 ; 3E5FC:  d8 93 e6 61 e9 35 cc 02
            hex 61 8d 13 8d 1f 64 8d 1e ; 3E604:  61 8d 13 8d 1f 64 8d 1e
            hex e9 42 cc 0a 64 0c 8c c0 ; 3E60C:  e9 42 cc 0a 64 0c 8c c0
            hex 01 b5 8c 5c 8d bb b3 8d ; 3E614:  01 b5 8c 5c 8d bb b3 8d
            hex 13 8d 1d 64 62 e9 54 cc ; 3E61C:  13 8d 1d 64 62 e9 54 cc
            hex 0c 62 8e c8 23 0c 55 bd ; 3E624:  0c 62 8e c8 23 0c 55 bd
            hex 8c 1c 9d bb b3 64 e9 7c ; 3E62C:  8c 1c 9d bb b3 64 e9 7c
            hex cf 08 0c a8 5d 6f a4 cd ; 3E634:  cf 08 0c a8 5d 6f a4 cd
            hex 7f 2b a4 cf 7f 2a 8d 22 ; 3E63C:  7f 2b a4 cf 7f 2a 8d 22
            hex de da ff b3 0c 8b 22 b5 ; 3E644:  de da ff b3 0c 8b 22 b5
            hex 8c 3c 9e bb b3 64 e9 bd ; 3E64C:  8c 3c 9e bb b3 64 e9 bd
            hex cb 08 de da ff 85 d8 d6 ; 3E654:  cb 08 de da ff 85 d8 d6
            hex 7e e6 81 d8 d0 85 d8 d1 ; 3E65C:  7e e6 81 d8 d0 85 d8 d1
            hex d3 a8 cd 7f 81 d8 d0 85 ; 3E664:  d3 a8 cd 7f 81 d8 d0 85
            hex d8 d1 d3 a8 cf 7f 81 d8 ; 3E66C:  d8 d1 d3 a8 cf 7f 81 d8
            hex d0 85 d8 d1 d3 b3 e9 6e ; 3E674:  d0 85 d8 d1 d3 b3 e9 6e
            hex db 02 81 d8 d3 8c ff 00 ; 3E67C:  db 02 81 d8 d3 8c ff 00
            hex c1 d7 5e e6 3a 3b e9 7b ; 3E684:  c1 d7 5e e6 3a 3b e9 7b
            hex cc 04 60 e9 35 cc 02 cf ; 3E68C:  cc 04 60 e9 35 cc 02 cf
            hex 20 23 e8 00 00 a4 9d 6d ; 3E694:  20 23 e8 00 00 a4 9d 6d
            hex 8b 32 c0 d8 ab e6 a4 dd ; 3E69C:  8b 32 c0 d8 ab e6 a4 dd
            hex 7f 8c a6 fe d6 b1 e6 a4 ; 3E6A4:  7f 8c a6 fe d6 b1 e6 a4
            hex dd 7f 8c d8 fe bb d3 b3 ; 3E6AC:  dd 7f 8c d8 fe bb d3 b3
            hex e9 f2 e5 02 cf 20 23 e8 ; 3E6B4:  e9 f2 e5 02 cf 20 23 e8
            hex f6 ff a4 5b 6f d2 8c b1 ; 3E6BC:  f6 ff a4 5b 6f d2 8c b1
            hex 6e bb b0 2b 0b 55 b8 29 ; 3E6C4:  6e bb b0 2b 0b 55 b8 29
            hex 0b 55 ba 2a 09 55 b8 28 ; 3E6CC:  0b 55 ba 2a 09 55 b8 28
            hex 09 55 ba 29 08 55 b8 27 ; 3E6D4:  09 55 ba 29 08 55 b8 27

            php                         ; 3E6DC:  08
            eor $ba,x                   ; 3E6DD:  55 ba
            plp                         ; 3E6DF:  28
            jmp ($b08e)                 ; 3E6E0:  6c 8e b0

            hex 15 0a 8c c0 00 b5 8c 04 ; 3E6E3:  15 0a 8c c0 00 b5 8c 04
            hex a6 bb b3 68 e9 7c cf    ; 3E6EB:  a6 bb b3 68 e9 7c cf

            php                         ; 3E6F2:  08
            ror $8e                     ; 3E6F3:  66 8e
            bvs tab_b15_e6fa+19         ; 3E6F5:  70 16
            ora #$8b                    ; 3E6F7:  09 8b
            rts                         ; 3E6F9:  60

tab_b15_e6fa: ; 28 bytes
            hex b5 8c c4 a9 bb b3 68 e9 ; 3E6FA:  b5 8c c4 a9 bb b3 68 e9
            hex 7c cf 08 66 8e d0 16 08 ; 3E702:  7c cf 08 66 8e d0 16 08
            hex 8b 60 b5 8c a4 ab bb b3 ; 3E70A:  8b 60 b5 8c a4 ab bb b3
            hex 68 e9 7c cf             ; 3E712:  68 e9 7c cf

            php                         ; 3E716:  08
            jmp ($308e)                 ; 3E717:  6c 8e 30

            hex 17 07 8c c0 00 b5 8c 84 ; 3E71A:  17 07 8c c0 00 b5 8c 84
            hex ad bb b3 68 e9 7c cf    ; 3E722:  ad bb b3 68 e9 7c cf

            php                         ; 3E729:  08
            jmp ($0a3c)                 ; 3E72A:  6c 3c 0a

            hex 5c b5 8c 34 ae bb b3 69 ; 3E72D:  5c b5 8c 34 ae bb b3 69
            hex e9 bd cb 08 66 0c 7c b3 ; 3E735:  e9 bd cb 08 66 0c 7c b3
            hex 09 56 b5 8c 70 ae bb b3 ; 3E73D:  09 56 b5 8c 70 ae bb b3
            hex 69 e9 bd cb 08 66 0c 8f ; 3E745:  69 e9 bd cb 08 66 0c 8f
            hex 12 b3 08 56 b5 8c 8e ae ; 3E74D:  12 b3 08 56 b5 8c 8e ae
            hex bb b3                   ; 3E755:  bb b3

            adc #$e9                    ; 3E757:  69 e9
            lda $08cb,x                 ; 3E759:  bd cb 08
            jmp ($8f0c)                 ; 3E75C:  6c 0c 8f

            hex 18 b3 07 5c b5 8c ac ae ; 3E75F:  18 b3 07 5c b5 8c ac ae
            hex bb b3 69 e9 bd cb 08 cf ; 3E767:  bb b3 69 e9 bd cb 08 cf
            hex 20 23 e8 d4 ff 40 85 da ; 3E76F:  20 23 e8 d4 ff 40 85 da
            hex 81 da d2 8c cc f7 bb b0 ; 3E777:  81 da d2 8c cc f7 bb b0
            hex b3 87 da e9 8b cf 04 81 ; 3E77F:  b3 87 da e9 8b cf 04 81
            hex da d0 85 da 81 da 54 c6 ; 3E787:  da d0 85 da 81 da 54 c6
            hex d7 77 e7 a4 5b 6f 8b 35 ; 3E78F:  d7 77 e7 a4 5b 6f 8b 35
            hex c9 d7 a7 e7 aa 5b 6f e9 ; 3E797:  c9 d7 a7 e7 aa 5b 6f e9
            hex cd d7 02 76 d3 d7 ee e7 ; 3E79F:  cd d7 02 76 d3 d7 ee e7
            hex aa 5b 6f e9 66 dc 02 d2 ; 3E7A7:  aa 5b 6f e9 66 dc 02 d2
            hex d2 8c d0 bb bb 85 d8 64 ; 3E7AF:  d2 8c d0 bb bb 85 d8 64
            hex de d4 ff b3 87 d8 68 e9 ; 3E7B7:  de d4 ff b3 87 d8 68 e9
            hex bd cb 08 de d4 ff 85 d8 ; 3E7BF:  bd cb 08 de d4 ff 85 d8
            hex 81 d8 d0 d3 b3 8e b0 15 ; 3E7C7:  81 d8 d0 d3 b3 8e b0 15
            hex 81 d8 72 b0 b3 81 d8 d3 ; 3E7CF:  81 d8 72 b0 b3 81 d8 d3
            hex b3 e9 7c cf 08 68 aa 5b ; 3E7D7:  b3 e9 7c cf 08 68 aa 5b
            hex 6f e9 66 dc 02 8b 24 b5 ; 3E7DF:  6f e9 66 dc 02 8b 24 b5
            hex 8c 44 b1 bb d6 fa e7 de ; 3E7E7:  8c 44 b1 bb d6 fa e7 de
            hex dc ff b3 e9 b9 e6 02 68 ; 3E7EF:  dc ff b3 e9 b9 e6 02 68
            hex de dc ff b3 0d 75 b3 0c ; 3E7F7:  de dc ff b3 0d 75 b3 0c
            hex 75 b3 3d 3c e9 54 cc 0c ; 3E7FF:  75 b3 3d 3c e9 54 cc 0c
            hex 41 a8 c7 7f cf 20 23 e8 ; 3E807:  41 a8 c7 7f cf 20 23 e8
            hex 00 00 a5 a1 6d 54 da d8 ; 3E80F:  00 00 a5 a1 6d 54 da d8
            hex 22 e8 0c a8 cb 7f 6e e9 ; 3E817:  22 e8 0c a8 cb 7f 6e e9
            hex b1 cb 02 cf             ; 3E81F:  b1 cb 02 cf

b15_e823:   pla                         ; 3E823:  68
            sta $08                     ; 3E824:  85 08
            pla                         ; 3E826:  68
            sta $09                     ; 3E827:  85 09
            pla                         ; 3E829:  68
            sta $00                     ; 3E82A:  85 00
            pla                         ; 3E82C:  68
            sta $01                     ; 3E82D:  85 01
            ldy #$07                    ; 3E82F:  a0 07
            sec                         ; 3E831:  38
            lda $02                     ; 3E832:  a5 02
            sbc #$09                    ; 3E834:  e9 09
            sta $0c                     ; 3E836:  85 0c
            lda $03                     ; 3E838:  a5 03
            sbc #$00                    ; 3E83A:  e9 00
            sta $0d                     ; 3E83C:  85 0d
b15_e83e:   hex b9 00 00 ; lda $0000,y  ; 3E83E:  b9 00 00
            sta ($0c),y                 ; 3E841:  91 0c
            dey                         ; 3E843:  88
            bpl b15_e83e                ; 3E844:  10 f8
            ldy #$01                    ; 3E846:  a0 01
            clc                         ; 3E848:  18
            lda $0c                     ; 3E849:  a5 0c
            sta $04                     ; 3E84B:  85 04
            adc ($08),y                 ; 3E84D:  71 08
            sta $02                     ; 3E84F:  85 02
            iny                         ; 3E851:  c8
            lda $0d                     ; 3E852:  a5 0d
            sta $05                     ; 3E854:  85 05
            adc ($08),y                 ; 3E856:  71 08
            sta $03                     ; 3E858:  85 03
            clc                         ; 3E85A:  18
            lda $08                     ; 3E85B:  a5 08
            adc #$03                    ; 3E85D:  69 03
            sta $06                     ; 3E85F:  85 06
            lda $09                     ; 3E861:  a5 09
            adc #$00                    ; 3E863:  69 00
            sta $07                     ; 3E865:  85 07
b15_e867:   ldy #$00                    ; 3E867:  a0 00
            lda ($06),y                 ; 3E869:  b1 06
            inc $06                     ; 3E86B:  e6 06
            bne b15_e871                ; 3E86D:  d0 02
            inc $07                     ; 3E86F:  e6 07
b15_e871:   tax                         ; 3E871:  aa
            lda tab_b15_f026,x          ; 3E872:  bd 26 f0
            sta $00                     ; 3E875:  85 00
            lda tab_b15_f026+256,x      ; 3E877:  bd 26 f1
            sta $01                     ; 3E87A:  85 01
            jmp ($0000)                 ; 3E87C:  6c 00 00

            lda #$e8                    ; 3E87F:  a9 e8
            bne b15_e8ad                ; 3E881:  d0 2a
            lda #$ea                    ; 3E883:  a9 ea
            bne b15_e8ad                ; 3E885:  d0 26
            lda #$ec                    ; 3E887:  a9 ec
            bne b15_e8ad                ; 3E889:  d0 22
            lda #$ee                    ; 3E88B:  a9 ee
            bne b15_e8ad                ; 3E88D:  d0 1e
            lda #$f0                    ; 3E88F:  a9 f0
            bne b15_e8ad                ; 3E891:  d0 1a
            lda #$f2                    ; 3E893:  a9 f2
            bne b15_e8ad                ; 3E895:  d0 16
            lda #$f4                    ; 3E897:  a9 f4
            bne b15_e8ad                ; 3E899:  d0 12
            lda #$f6                    ; 3E89B:  a9 f6
            bne b15_e8ad                ; 3E89D:  d0 0e
            lda #$f8                    ; 3E89F:  a9 f8
            bne b15_e8ad                ; 3E8A1:  d0 0a
            lda #$fa                    ; 3E8A3:  a9 fa
            bne b15_e8ad                ; 3E8A5:  d0 06
            lda #$fc                    ; 3E8A7:  a9 fc
            bne b15_e8ad                ; 3E8A9:  d0 02
            lda #$fe                    ; 3E8AB:  a9 fe
b15_e8ad:   clc                         ; 3E8AD:  18
            adc $04                     ; 3E8AE:  65 04
            sta $00                     ; 3E8B0:  85 00
            lda #$ff                    ; 3E8B2:  a9 ff
            adc $05                     ; 3E8B4:  65 05
            sta $01                     ; 3E8B6:  85 01
            lda ($00),y                 ; 3E8B8:  b1 00
            sta $08                     ; 3E8BA:  85 08
            iny                         ; 3E8BC:  c8
            lda ($00),y                 ; 3E8BD:  b1 00
            sta $09                     ; 3E8BF:  85 09
            jmp b15_e867                ; 3E8C1:  4c 67 e8

            ldy #$11                    ; 3E8C4:  a0 11
            bne b15_e8d2                ; 3E8C6:  d0 0a
            ldy #$0f                    ; 3E8C8:  a0 0f
            bne b15_e8d2                ; 3E8CA:  d0 06
            ldy #$0d                    ; 3E8CC:  a0 0d
            bne b15_e8d2                ; 3E8CE:  d0 02
            ldy #$0b                    ; 3E8D0:  a0 0b
b15_e8d2:   lda ($04),y                 ; 3E8D2:  b1 04
            sta $08                     ; 3E8D4:  85 08
            iny                         ; 3E8D6:  c8
            lda ($04),y                 ; 3E8D7:  b1 04
            sta $09                     ; 3E8D9:  85 09
            jmp b15_e867                ; 3E8DB:  4c 67 e8

            lda #$e8                    ; 3E8DE:  a9 e8
            bne b15_e90c                ; 3E8E0:  d0 2a
            lda #$ea                    ; 3E8E2:  a9 ea
            bne b15_e90c                ; 3E8E4:  d0 26
            lda #$ec                    ; 3E8E6:  a9 ec
            bne b15_e90c                ; 3E8E8:  d0 22
            lda #$ee                    ; 3E8EA:  a9 ee
            bne b15_e90c                ; 3E8EC:  d0 1e
            lda #$f0                    ; 3E8EE:  a9 f0
            bne b15_e90c                ; 3E8F0:  d0 1a
            lda #$f2                    ; 3E8F2:  a9 f2
            bne b15_e90c                ; 3E8F4:  d0 16
            lda #$f4                    ; 3E8F6:  a9 f4
            bne b15_e90c                ; 3E8F8:  d0 12
            lda #$f6                    ; 3E8FA:  a9 f6
            bne b15_e90c                ; 3E8FC:  d0 0e
            lda #$f8                    ; 3E8FE:  a9 f8
            bne b15_e90c                ; 3E900:  d0 0a
            lda #$fa                    ; 3E902:  a9 fa
            bne b15_e90c                ; 3E904:  d0 06
            lda #$fc                    ; 3E906:  a9 fc
            bne b15_e90c                ; 3E908:  d0 02
            lda #$fe                    ; 3E90A:  a9 fe
b15_e90c:   clc                         ; 3E90C:  18
            adc $04                     ; 3E90D:  65 04
            sta $00                     ; 3E90F:  85 00
            lda #$ff                    ; 3E911:  a9 ff
            adc $05                     ; 3E913:  65 05
            sta $01                     ; 3E915:  85 01
            lda ($00),y                 ; 3E917:  b1 00
            sta $0c                     ; 3E919:  85 0c
            iny                         ; 3E91B:  c8
            lda ($00),y                 ; 3E91C:  b1 00
            sta $0d                     ; 3E91E:  85 0d
            jmp b15_e867                ; 3E920:  4c 67 e8

            ldy #$11                    ; 3E923:  a0 11
            bne b15_e931                ; 3E925:  d0 0a
            ldy #$0f                    ; 3E927:  a0 0f
            bne b15_e931                ; 3E929:  d0 06
            ldy #$0d                    ; 3E92B:  a0 0d
            bne b15_e931                ; 3E92D:  d0 02
            ldy #$0b                    ; 3E92F:  a0 0b
b15_e931:   lda ($04),y                 ; 3E931:  b1 04
            sta $0c                     ; 3E933:  85 0c
            iny                         ; 3E935:  c8
            lda ($04),y                 ; 3E936:  b1 04
            sta $0d                     ; 3E938:  85 0d
            jmp b15_e867                ; 3E93A:  4c 67 e8

            lda #$e8                    ; 3E93D:  a9 e8
            bne b15_e96b                ; 3E93F:  d0 2a
            lda #$ea                    ; 3E941:  a9 ea
            bne b15_e96b                ; 3E943:  d0 26
            lda #$ec                    ; 3E945:  a9 ec
            bne b15_e96b                ; 3E947:  d0 22
            lda #$ee                    ; 3E949:  a9 ee
            bne b15_e96b                ; 3E94B:  d0 1e
            lda #$f0                    ; 3E94D:  a9 f0
            bne b15_e96b                ; 3E94F:  d0 1a
            lda #$f2                    ; 3E951:  a9 f2
            bne b15_e96b                ; 3E953:  d0 16
            lda #$f4                    ; 3E955:  a9 f4
            bne b15_e96b                ; 3E957:  d0 12
            lda #$f6                    ; 3E959:  a9 f6
            bne b15_e96b                ; 3E95B:  d0 0e
            lda #$f8                    ; 3E95D:  a9 f8
            bne b15_e96b                ; 3E95F:  d0 0a
            lda #$fa                    ; 3E961:  a9 fa
            bne b15_e96b                ; 3E963:  d0 06
            lda #$fc                    ; 3E965:  a9 fc
            bne b15_e96b                ; 3E967:  d0 02
            lda #$fe                    ; 3E969:  a9 fe
b15_e96b:   clc                         ; 3E96B:  18
            adc $04                     ; 3E96C:  65 04
            sta $00                     ; 3E96E:  85 00
            lda #$ff                    ; 3E970:  a9 ff
            adc $05                     ; 3E972:  65 05
            sta $01                     ; 3E974:  85 01
            lda $08                     ; 3E976:  a5 08
            sta ($00),y                 ; 3E978:  91 00
            iny                         ; 3E97A:  c8
            lda $09                     ; 3E97B:  a5 09
            sta ($00),y                 ; 3E97D:  91 00
            jmp b15_e867                ; 3E97F:  4c 67 e8

            ldy #$11                    ; 3E982:  a0 11
            bne b15_e990                ; 3E984:  d0 0a
            ldy #$0f                    ; 3E986:  a0 0f
            bne b15_e990                ; 3E988:  d0 06
            ldy #$0d                    ; 3E98A:  a0 0d
            bne b15_e990                ; 3E98C:  d0 02
            ldy #$0b                    ; 3E98E:  a0 0b
b15_e990:   lda $08                     ; 3E990:  a5 08
            sta ($04),y                 ; 3E992:  91 04
            iny                         ; 3E994:  c8
            lda $09                     ; 3E995:  a5 09
            sta ($04),y                 ; 3E997:  91 04
            jmp b15_e867                ; 3E999:  4c 67 e8

            lda #$e8                    ; 3E99C:  a9 e8
            bne b15_e9ca                ; 3E99E:  d0 2a
            lda #$ea                    ; 3E9A0:  a9 ea
            bne b15_e9ca                ; 3E9A2:  d0 26
            lda #$ec                    ; 3E9A4:  a9 ec
            bne b15_e9ca                ; 3E9A6:  d0 22
            lda #$ee                    ; 3E9A8:  a9 ee
            bne b15_e9ca                ; 3E9AA:  d0 1e
            lda #$f0                    ; 3E9AC:  a9 f0
            bne b15_e9ca                ; 3E9AE:  d0 1a
            lda #$f2                    ; 3E9B0:  a9 f2
            bne b15_e9ca                ; 3E9B2:  d0 16
            lda #$f4                    ; 3E9B4:  a9 f4
            bne b15_e9ca                ; 3E9B6:  d0 12
            lda #$f6                    ; 3E9B8:  a9 f6
            bne b15_e9ca                ; 3E9BA:  d0 0e
            lda #$f8                    ; 3E9BC:  a9 f8
            bne b15_e9ca                ; 3E9BE:  d0 0a
            lda #$fa                    ; 3E9C0:  a9 fa
            bne b15_e9ca                ; 3E9C2:  d0 06
            lda #$fc                    ; 3E9C4:  a9 fc
            bne b15_e9ca                ; 3E9C6:  d0 02
            lda #$fe                    ; 3E9C8:  a9 fe
b15_e9ca:   clc                         ; 3E9CA:  18
            adc $04                     ; 3E9CB:  65 04
            sta $00                     ; 3E9CD:  85 00
            lda #$ff                    ; 3E9CF:  a9 ff
            adc $05                     ; 3E9D1:  65 05
            sta $01                     ; 3E9D3:  85 01
            iny                         ; 3E9D5:  c8
            lda ($00),y                 ; 3E9D6:  b1 00
            tax                         ; 3E9D8:  aa
            dey                         ; 3E9D9:  88
            lda ($00),y                 ; 3E9DA:  b1 00
            jmp b15_f008                ; 3E9DC:  4c 08 f0

            ldy #$12                    ; 3E9DF:  a0 12
            bne b15_e9ed                ; 3E9E1:  d0 0a
            ldy #$10                    ; 3E9E3:  a0 10
            bne b15_e9ed                ; 3E9E5:  d0 06
            ldy #$0e                    ; 3E9E7:  a0 0e
            bne b15_e9ed                ; 3E9E9:  d0 02
            ldy #$0c                    ; 3E9EB:  a0 0c
b15_e9ed:   lda ($04),y                 ; 3E9ED:  b1 04
            tax                         ; 3E9EF:  aa
            dey                         ; 3E9F0:  88
            lda ($04),y                 ; 3E9F1:  b1 04
            jmp b15_f008                ; 3E9F3:  4c 08 f0

            txa                         ; 3E9F6:  8a
            and #$0f                    ; 3E9F7:  29 0f
            sta $08                     ; 3E9F9:  85 08
            sty $09                     ; 3E9FB:  84 09
            jmp b15_e867                ; 3E9FD:  4c 67 e8

            sty $08                     ; 3EA00:  84 08
            sty $09                     ; 3EA02:  84 09
            jmp b15_e867                ; 3EA04:  4c 67 e8

            txa                         ; 3EA07:  8a
            and #$0f                    ; 3EA08:  29 0f
            sta $0c                     ; 3EA0A:  85 0c
            sty $0d                     ; 3EA0C:  84 0d
            jmp b15_e867                ; 3EA0E:  4c 67 e8

            sty $0c                     ; 3EA11:  84 0c
            sty $0d                     ; 3EA13:  84 0d
            jmp b15_e867                ; 3EA15:  4c 67 e8

            txa                         ; 3EA18:  8a
            and #$0f                    ; 3EA19:  29 0f
            ldx #$00                    ; 3EA1B:  a2 00
            jmp b15_f008                ; 3EA1D:  4c 08 f0

            txa                         ; 3EA20:  8a
            and #$0f                    ; 3EA21:  29 0f
            clc                         ; 3EA23:  18
            adc $08                     ; 3EA24:  65 08
            sta $08                     ; 3EA26:  85 08
            bcc b15_ea2c                ; 3EA28:  90 02
            inc $09                     ; 3EA2A:  e6 09
b15_ea2c:   jmp b15_e867                ; 3EA2C:  4c 67 e8

            jsr b15_efec                ; 3EA2F:  20 ec ef
            bcc b15_ea37                ; 3EA32:  90 03
            jsr b15_efa6                ; 3EA34:  20 a6 ef
b15_ea37:   lda ($00),y                 ; 3EA37:  b1 00
            sta $08                     ; 3EA39:  85 08
            iny                         ; 3EA3B:  c8
            lda ($00),y                 ; 3EA3C:  b1 00
            sta $09                     ; 3EA3E:  85 09
            jmp b15_e867                ; 3EA40:  4c 67 e8

            jsr b15_efd5                ; 3EA43:  20 d5 ef
            bcc b15_ea37                ; 3EA46:  90 ef
            jsr b15_efa6                ; 3EA48:  20 a6 ef
b15_ea4b:   lda ($00),y                 ; 3EA4B:  b1 00
            sta $0c                     ; 3EA4D:  85 0c
            iny                         ; 3EA4F:  c8
            lda ($00),y                 ; 3EA50:  b1 00
            sta $0d                     ; 3EA52:  85 0d
            jmp b15_e867                ; 3EA54:  4c 67 e8

            jsr b15_efec                ; 3EA57:  20 ec ef
            bcc b15_ea4b                ; 3EA5A:  90 ef
            jsr b15_efd5                ; 3EA5C:  20 d5 ef
            bcc b15_ea4b                ; 3EA5F:  90 ea
            jsr b15_efa6                ; 3EA61:  20 a6 ef
b15_ea64:   lda $08                     ; 3EA64:  a5 08
            sta ($00),y                 ; 3EA66:  91 00
            iny                         ; 3EA68:  c8
            lda $09                     ; 3EA69:  a5 09
            sta ($00),y                 ; 3EA6B:  91 00
            jmp b15_e867                ; 3EA6D:  4c 67 e8

            jsr b15_efec                ; 3EA70:  20 ec ef
            bcc b15_ea64                ; 3EA73:  90 ef
            jsr b15_efd5                ; 3EA75:  20 d5 ef
            bcc b15_ea64                ; 3EA78:  90 ea
            jsr b15_efa6                ; 3EA7A:  20 a6 ef
b15_ea7d:   iny                         ; 3EA7D:  c8
            lda ($00),y                 ; 3EA7E:  b1 00
            tax                         ; 3EA80:  aa
            dey                         ; 3EA81:  88
            lda ($00),y                 ; 3EA82:  b1 00
            jmp b15_f008                ; 3EA84:  4c 08 f0

            jsr b15_efec                ; 3EA87:  20 ec ef
            bcc b15_ea7d                ; 3EA8A:  90 f1
            jsr b15_efd5                ; 3EA8C:  20 d5 ef
            bcc b15_ea7d                ; 3EA8F:  90 ec
            jsr b15_efbf                ; 3EA91:  20 bf ef
            adc $04                     ; 3EA94:  65 04
            sta $08                     ; 3EA96:  85 08
            txa                         ; 3EA98:  8a
            adc $05                     ; 3EA99:  65 05
            sta $09                     ; 3EA9B:  85 09
            jmp b15_e867                ; 3EA9D:  4c 67 e8

            jsr b15_efbf                ; 3EAA0:  20 bf ef
            adc $04                     ; 3EAA3:  65 04
            sta $0c                     ; 3EAA5:  85 0c
            txa                         ; 3EAA7:  8a
            adc $05                     ; 3EAA8:  65 05
            sta $0d                     ; 3EAAA:  85 0d
            jmp b15_e867                ; 3EAAC:  4c 67 e8

            jsr b15_ef97                ; 3EAAF:  20 97 ef
b15_eab2:   sta $08                     ; 3EAB2:  85 08
            stx $09                     ; 3EAB4:  86 09
            jmp b15_e867                ; 3EAB6:  4c 67 e8

            jsr b15_efbf                ; 3EAB9:  20 bf ef
            bcc b15_eab2                ; 3EABC:  90 f4
            jsr b15_ef97                ; 3EABE:  20 97 ef
b15_eac1:   sta $0c                     ; 3EAC1:  85 0c
            stx $0d                     ; 3EAC3:  86 0d
            jmp b15_e867                ; 3EAC5:  4c 67 e8

            jsr b15_efbf                ; 3EAC8:  20 bf ef
            bcc b15_eac1                ; 3EACB:  90 f4
            jsr b15_ef97                ; 3EACD:  20 97 ef
            jmp b15_f008                ; 3EAD0:  4c 08 f0

            jsr b15_efbf                ; 3EAD3:  20 bf ef
            jmp b15_f008                ; 3EAD6:  4c 08 f0

            jsr b15_ef97                ; 3EAD9:  20 97 ef
b15_eadc:   adc $08                     ; 3EADC:  65 08
            sta $08                     ; 3EADE:  85 08
            txa                         ; 3EAE0:  8a
            adc $09                     ; 3EAE1:  65 09
            sta $09                     ; 3EAE3:  85 09
            jmp b15_e867                ; 3EAE5:  4c 67 e8

            jsr b15_efbf                ; 3EAE8:  20 bf ef
            bcc b15_eadc                ; 3EAEB:  90 ef
            jsr b15_efec                ; 3EAED:  20 ec ef
b15_eaf0:   lda ($00),y                 ; 3EAF0:  b1 00
            sta $08                     ; 3EAF2:  85 08
            sty $09                     ; 3EAF4:  84 09
            jmp b15_e867                ; 3EAF6:  4c 67 e8

            jsr b15_efd5                ; 3EAF9:  20 d5 ef
            bcc b15_eaf0                ; 3EAFC:  90 f2
            jsr b15_efec                ; 3EAFE:  20 ec ef
b15_eb01:   lda ($00),y                 ; 3EB01:  b1 00
            sta $0c                     ; 3EB03:  85 0c
            sty $0d                     ; 3EB05:  84 0d
            jmp b15_e867                ; 3EB07:  4c 67 e8

            jsr b15_efd5                ; 3EB0A:  20 d5 ef
            bcc b15_eb01                ; 3EB0D:  90 f2
            jsr b15_efec                ; 3EB0F:  20 ec ef
b15_eb12:   lda $08                     ; 3EB12:  a5 08
            sta ($00),y                 ; 3EB14:  91 00
            jmp b15_e867                ; 3EB16:  4c 67 e8

            jsr b15_efd5                ; 3EB19:  20 d5 ef
            bcc b15_eb12                ; 3EB1C:  90 f4
            jsr b15_efec                ; 3EB1E:  20 ec ef
b15_eb21:   lda ($00),y                 ; 3EB21:  b1 00
            ldx #$00                    ; 3EB23:  a2 00
            jmp b15_f008                ; 3EB25:  4c 08 f0

            jsr b15_efd5                ; 3EB28:  20 d5 ef
            bcc b15_eb21                ; 3EB2B:  90 f4
            lda $08                     ; 3EB2D:  a5 08
            sta $00                     ; 3EB2F:  85 00
            lda $09                     ; 3EB31:  a5 09
            sta $01                     ; 3EB33:  85 01
            jmp b15_eb3b                ; 3EB35:  4c 3b eb

            jsr b15_efd5                ; 3EB38:  20 d5 ef
b15_eb3b:   jsr b15_eb57                ; 3EB3B:  20 57 eb
            ldy #$00                    ; 3EB3E:  a0 00
            jmp b15_eb9e                ; 3EB40:  4c 9e eb

            lda $08                     ; 3EB43:  a5 08
            sta $00                     ; 3EB45:  85 00
            lda $09                     ; 3EB47:  a5 09
            sta $01                     ; 3EB49:  85 01
            jmp b15_eb51                ; 3EB4B:  4c 51 eb

            jsr b15_efd5                ; 3EB4E:  20 d5 ef
b15_eb51:   jsr b15_eb57                ; 3EB51:  20 57 eb
            jmp b15_e867                ; 3EB54:  4c 67 e8

b15_eb57:   sec                         ; 3EB57:  38
            lda $02                     ; 3EB58:  a5 02
            sbc #$02                    ; 3EB5A:  e9 02
            sta $02                     ; 3EB5C:  85 02
            bcs b15_eb62                ; 3EB5E:  b0 02
            dec $03                     ; 3EB60:  c6 03
b15_eb62:   lda $06                     ; 3EB62:  a5 06
            sta ($02),y                 ; 3EB64:  91 02
            iny                         ; 3EB66:  c8
            lda $07                     ; 3EB67:  a5 07
            sta ($02),y                 ; 3EB69:  91 02
            jsr tab_b15_eb7a            ; 3EB6B:  20 7a eb
            clc                         ; 3EB6E:  18
            lda $02                     ; 3EB6F:  a5 02
            adc #$02                    ; 3EB71:  69 02
            sta $02                     ; 3EB73:  85 02
            bcc b15_eb79                ; 3EB75:  90 02
            inc $03                     ; 3EB77:  e6 03
b15_eb79:   rts                         ; 3EB79:  60

tab_b15_eb7a: ; 3 bytes
            hex 6c 00 00                ; 3EB7A:  6c 00 00

            jsr b15_efbf                ; 3EB7D:  20 bf ef
            ldy #$00                    ; 3EB80:  a0 00
            stx $00                     ; 3EB82:  86 00
            tax                         ; 3EB84:  aa
            bne b15_eb8e                ; 3EB85:  d0 07
b15_eb87:   dec $00                     ; 3EB87:  c6 00
            bpl b15_eb8e                ; 3EB89:  10 03
            jmp b15_e867                ; 3EB8B:  4c 67 e8

b15_eb8e:   lda ($08),y                 ; 3EB8E:  b1 08
            sta ($0c),y                 ; 3EB90:  91 0c
            iny                         ; 3EB92:  c8
            bne b15_eb99                ; 3EB93:  d0 04
            inc $09                     ; 3EB95:  e6 09
            inc $0d                     ; 3EB97:  e6 0d
b15_eb99:   dex                         ; 3EB99:  ca
            beq b15_eb87                ; 3EB9A:  f0 eb
            bne b15_eb8e                ; 3EB9C:  d0 f0
b15_eb9e:   jsr b15_ef97                ; 3EB9E:  20 97 ef
            adc $02                     ; 3EBA1:  65 02
            sta $02                     ; 3EBA3:  85 02
            bcc b15_eba9                ; 3EBA5:  90 02
            inc $03                     ; 3EBA7:  e6 03
b15_eba9:   jmp b15_e867                ; 3EBA9:  4c 67 e8

            jsr b15_efbf                ; 3EBAC:  20 bf ef
            adc $02                     ; 3EBAF:  65 02
            sta $02                     ; 3EBB1:  85 02
            txa                         ; 3EBB3:  8a
            adc $03                     ; 3EBB4:  65 03
            sta $03                     ; 3EBB6:  85 03
            jmp b15_e867                ; 3EBB8:  4c 67 e8

b15_ebbb:   jsr b15_efbf                ; 3EBBB:  20 bf ef
            sta $06                     ; 3EBBE:  85 06
            stx $07                     ; 3EBC0:  86 07
            jmp b15_e867                ; 3EBC2:  4c 67 e8

            lda $08                     ; 3EBC5:  a5 08
            ora $09                     ; 3EBC7:  05 09
            bne b15_ebbb                ; 3EBC9:  d0 f0
b15_ebcb:   jsr b15_efbf                ; 3EBCB:  20 bf ef
            jmp b15_e867                ; 3EBCE:  4c 67 e8

            lda $08                     ; 3EBD1:  a5 08
            ora $09                     ; 3EBD3:  05 09
            beq b15_ebbb                ; 3EBD5:  f0 e4
            bne b15_ebcb                ; 3EBD7:  d0 f2
b15_ebd9:   jsr b15_ef97                ; 3EBD9:  20 97 ef
            adc $06                     ; 3EBDC:  65 06
            sta $06                     ; 3EBDE:  85 06
            bcs b15_ebe4                ; 3EBE0:  b0 02
            dec $07                     ; 3EBE2:  c6 07
b15_ebe4:   jmp b15_e867                ; 3EBE4:  4c 67 e8

            lda $08                     ; 3EBE7:  a5 08
            ora $09                     ; 3EBE9:  05 09
            bne b15_ebd9                ; 3EBEB:  d0 ec
b15_ebed:   jsr b15_ef97                ; 3EBED:  20 97 ef
            jmp b15_e867                ; 3EBF0:  4c 67 e8

            lda $08                     ; 3EBF3:  a5 08
            ora $09                     ; 3EBF5:  05 09
            beq b15_ebd9                ; 3EBF7:  f0 e0
            bne b15_ebed                ; 3EBF9:  d0 f2
b15_ebfb:   jsr b15_ef97                ; 3EBFB:  20 97 ef
            adc $06                     ; 3EBFE:  65 06
            sta $06                     ; 3EC00:  85 06
            bcc b15_ec06                ; 3EC02:  90 02
            inc $07                     ; 3EC04:  e6 07
b15_ec06:   jmp b15_e867                ; 3EC06:  4c 67 e8

            lda $08                     ; 3EC09:  a5 08
            ora $09                     ; 3EC0B:  05 09
            bne b15_ebfb                ; 3EC0D:  d0 ec
b15_ec0f:   jsr b15_ef97                ; 3EC0F:  20 97 ef
            jmp b15_e867                ; 3EC12:  4c 67 e8

            lda $08                     ; 3EC15:  a5 08
            ora $09                     ; 3EC17:  05 09
            beq b15_ebfb                ; 3EC19:  f0 e0
            bne b15_ec0f                ; 3EC1B:  d0 f2
            lda ($06),y                 ; 3EC1D:  b1 06
            tax                         ; 3EC1F:  aa
            iny                         ; 3EC20:  c8
            lda ($06),y                 ; 3EC21:  b1 06
            sta $0c                     ; 3EC23:  85 0c
            clc                         ; 3EC25:  18
            lda $06                     ; 3EC26:  a5 06
            adc #$02                    ; 3EC28:  69 02
            sta $06                     ; 3EC2A:  85 06
            bcc b15_ec30                ; 3EC2C:  90 02
            inc $07                     ; 3EC2E:  e6 07
b15_ec30:   ldy #$00                    ; 3EC30:  a0 00
            txa                         ; 3EC32:  8a
            bne b15_ec3c                ; 3EC33:  d0 07
            dec $0c                     ; 3EC35:  c6 0c
            bpl b15_ec3c                ; 3EC37:  10 03
            dey                         ; 3EC39:  88
            bne b15_ec57                ; 3EC3A:  d0 1b
b15_ec3c:   dex                         ; 3EC3C:  ca
            lda ($06),y                 ; 3EC3D:  b1 06
            cmp $08                     ; 3EC3F:  c5 08
            bne b15_ec4a                ; 3EC41:  d0 07
            iny                         ; 3EC43:  c8
            lda ($06),y                 ; 3EC44:  b1 06
            cmp $09                     ; 3EC46:  c5 09
            beq b15_ec57                ; 3EC48:  f0 0d
b15_ec4a:   clc                         ; 3EC4A:  18
            lda $06                     ; 3EC4B:  a5 06
            adc #$04                    ; 3EC4D:  69 04
            sta $06                     ; 3EC4F:  85 06
            bcc b15_ec30                ; 3EC51:  90 dd
            inc $07                     ; 3EC53:  e6 07
            bcs b15_ec30                ; 3EC55:  b0 d9
b15_ec57:   iny                         ; 3EC57:  c8
            lda ($06),y                 ; 3EC58:  b1 06
            tax                         ; 3EC5A:  aa
            iny                         ; 3EC5B:  c8
            lda ($06),y                 ; 3EC5C:  b1 06
            sta $07                     ; 3EC5E:  85 07
            stx $06                     ; 3EC60:  86 06
            jmp b15_e867                ; 3EC62:  4c 67 e8

            clc                         ; 3EC65:  18
            lda ($06),y                 ; 3EC66:  b1 06
            adc $08                     ; 3EC68:  65 08
            sta $08                     ; 3EC6A:  85 08
            iny                         ; 3EC6C:  c8
            lda ($06),y                 ; 3EC6D:  b1 06
            adc $09                     ; 3EC6F:  65 09
            sta $09                     ; 3EC71:  85 09
            iny                         ; 3EC73:  c8
            lda $08                     ; 3EC74:  a5 08
            cmp ($06),y                 ; 3EC76:  d1 06
            iny                         ; 3EC78:  c8
            lda $09                     ; 3EC79:  a5 09
            sbc ($06),y                 ; 3EC7B:  f1 06
            iny                         ; 3EC7D:  c8
            bcs b15_ec91                ; 3EC7E:  b0 11
            lda $08                     ; 3EC80:  a5 08
            asl a                       ; 3EC82:  0a
            rol $09                     ; 3EC83:  26 09
            adc $06                     ; 3EC85:  65 06
            sta $06                     ; 3EC87:  85 06
            lda $09                     ; 3EC89:  a5 09
            adc $07                     ; 3EC8B:  65 07
            sta $07                     ; 3EC8D:  85 07
            ldy #$06                    ; 3EC8F:  a0 06
b15_ec91:   lda ($06),y                 ; 3EC91:  b1 06
            tax                         ; 3EC93:  aa
            iny                         ; 3EC94:  c8
            lda ($06),y                 ; 3EC95:  b1 06
            sta $07                     ; 3EC97:  85 07
            stx $06                     ; 3EC99:  86 06
            jmp b15_e867                ; 3EC9B:  4c 67 e8

            lda ($08),y                 ; 3EC9E:  b1 08
            tax                         ; 3ECA0:  aa
            iny                         ; 3ECA1:  c8
            lda ($08),y                 ; 3ECA2:  b1 08
            stx $08                     ; 3ECA4:  86 08
            sta $09                     ; 3ECA6:  85 09
            jmp b15_e867                ; 3ECA8:  4c 67 e8

            lda ($08),y                 ; 3ECAB:  b1 08
            sta $08                     ; 3ECAD:  85 08
            sty $09                     ; 3ECAF:  84 09
            jmp b15_e867                ; 3ECB1:  4c 67 e8

            jsr b15_ecdb                ; 3ECB4:  20 db ec
            lda $09                     ; 3ECB7:  a5 09
            sta ($0c),y                 ; 3ECB9:  91 0c
            dey                         ; 3ECBB:  88
            lda $08                     ; 3ECBC:  a5 08
            sta ($0c),y                 ; 3ECBE:  91 0c
            jmp b15_e867                ; 3ECC0:  4c 67 e8

            jsr b15_ecdb                ; 3ECC3:  20 db ec
            dey                         ; 3ECC6:  88
            lda $08                     ; 3ECC7:  a5 08
            sta ($0c),y                 ; 3ECC9:  91 0c
            jmp b15_e867                ; 3ECCB:  4c 67 e8

            lda $08                     ; 3ECCE:  a5 08
            ldx $09                     ; 3ECD0:  a6 09
            jmp b15_f008                ; 3ECD2:  4c 08 f0

            jsr b15_ecdb                ; 3ECD5:  20 db ec
            jmp b15_e867                ; 3ECD8:  4c 67 e8

b15_ecdb:   lda ($02),y                 ; 3ECDB:  b1 02
            sta $0c                     ; 3ECDD:  85 0c
            iny                         ; 3ECDF:  c8
            lda ($02),y                 ; 3ECE0:  b1 02
            sta $0d                     ; 3ECE2:  85 0d
            clc                         ; 3ECE4:  18
            lda $02                     ; 3ECE5:  a5 02
            adc #$02                    ; 3ECE7:  69 02
            sta $02                     ; 3ECE9:  85 02
            bcc b15_ecef                ; 3ECEB:  90 02
            inc $03                     ; 3ECED:  e6 03
b15_ecef:   rts                         ; 3ECEF:  60

            ldy #$00                    ; 3ECF0:  a0 00
            sty $00                     ; 3ECF2:  84 00
            sty $01                     ; 3ECF4:  84 01
            ldy #$10                    ; 3ECF6:  a0 10
b15_ecf8:   lda $08                     ; 3ECF8:  a5 08
            lsr a                       ; 3ECFA:  4a
            bcc b15_ed0a                ; 3ECFB:  90 0d
            clc                         ; 3ECFD:  18
            lda $00                     ; 3ECFE:  a5 00
            adc $0c                     ; 3ED00:  65 0c
            sta $00                     ; 3ED02:  85 00
            lda $01                     ; 3ED04:  a5 01
            adc $0d                     ; 3ED06:  65 0d
            sta $01                     ; 3ED08:  85 01
b15_ed0a:   ror $01                     ; 3ED0A:  66 01
            ror $00                     ; 3ED0C:  66 00
            ror $09                     ; 3ED0E:  66 09
            ror $08                     ; 3ED10:  66 08
            dey                         ; 3ED12:  88
            bne b15_ecf8                ; 3ED13:  d0 e3
            jmp b15_e867                ; 3ED15:  4c 67 e8

            jsr b15_ed2e                ; 3ED18:  20 2e ed
            jmp b15_e867                ; 3ED1B:  4c 67 e8

            jsr b15_ed7a                ; 3ED1E:  20 7a ed
            jsr b15_ed2e                ; 3ED21:  20 2e ed
            lda $0a                     ; 3ED24:  a5 0a
            bpl tab_b15_ed2b            ; 3ED26:  10 03
            jmp b15_ef09                ; 3ED28:  4c 09 ef

tab_b15_ed2b: ; 3 bytes
            hex 4c 67 e8                ; 3ED2B:  4c 67 e8

b15_ed2e:   ldy #$00                    ; 3ED2E:  a0 00
            sty $00                     ; 3ED30:  84 00
            sty $01                     ; 3ED32:  84 01
            ldy #$10                    ; 3ED34:  a0 10
b15_ed36:   asl $08                     ; 3ED36:  06 08
            rol $09                     ; 3ED38:  26 09
            rol $00                     ; 3ED3A:  26 00
            rol $01                     ; 3ED3C:  26 01
            sec                         ; 3ED3E:  38
            lda $00                     ; 3ED3F:  a5 00
            sbc $0c                     ; 3ED41:  e5 0c
            tax                         ; 3ED43:  aa
            lda $01                     ; 3ED44:  a5 01
            sbc $0d                     ; 3ED46:  e5 0d
            bcc b15_ed50                ; 3ED48:  90 06
            stx $00                     ; 3ED4A:  86 00
            sta $01                     ; 3ED4C:  85 01
            inc $08                     ; 3ED4E:  e6 08
b15_ed50:   dey                         ; 3ED50:  88
            bne b15_ed36                ; 3ED51:  d0 e3
            rts                         ; 3ED53:  60

            jsr b15_ed7a                ; 3ED54:  20 7a ed
            jsr b15_ed2e                ; 3ED57:  20 2e ed
            lda $00                     ; 3ED5A:  a5 00
            sta $08                     ; 3ED5C:  85 08
            lda $01                     ; 3ED5E:  a5 01
            sta $09                     ; 3ED60:  85 09
            lda $0b                     ; 3ED62:  a5 0b
            bpl tab_b15_ed69            ; 3ED64:  10 03
            jmp b15_ef09                ; 3ED66:  4c 09 ef

tab_b15_ed69: ; 3 bytes
            hex 4c 67 e8                ; 3ED69:  4c 67 e8

            jsr b15_ed2e                ; 3ED6C:  20 2e ed
            lda $00                     ; 3ED6F:  a5 00
            sta $08                     ; 3ED71:  85 08
            lda $01                     ; 3ED73:  a5 01
            sta $09                     ; 3ED75:  85 09
            jmp b15_e867                ; 3ED77:  4c 67 e8

b15_ed7a:   lda $09                     ; 3ED7A:  a5 09
            sta $0b                     ; 3ED7C:  85 0b
            eor $0d                     ; 3ED7E:  45 0d
            sta $0a                     ; 3ED80:  85 0a
            lda $09                     ; 3ED82:  a5 09
            bpl b15_ed91                ; 3ED84:  10 0b
            sec                         ; 3ED86:  38
            tya                         ; 3ED87:  98
            sbc $08                     ; 3ED88:  e5 08
            sta $08                     ; 3ED8A:  85 08
            tya                         ; 3ED8C:  98
            sbc $09                     ; 3ED8D:  e5 09
            sta $09                     ; 3ED8F:  85 09
b15_ed91:   lda $0d                     ; 3ED91:  a5 0d
            bpl b15_eda0                ; 3ED93:  10 0b
            sec                         ; 3ED95:  38
            tya                         ; 3ED96:  98
            sbc $0c                     ; 3ED97:  e5 0c
            sta $0c                     ; 3ED99:  85 0c
            tya                         ; 3ED9B:  98
            sbc $0d                     ; 3ED9C:  e5 0d
            sta $0d                     ; 3ED9E:  85 0d
b15_eda0:   rts                         ; 3EDA0:  60

            clc                         ; 3EDA1:  18
            lda $08                     ; 3EDA2:  a5 08
            adc $0c                     ; 3EDA4:  65 0c
            sta $08                     ; 3EDA6:  85 08
            lda $09                     ; 3EDA8:  a5 09
            adc $0d                     ; 3EDAA:  65 0d
            sta $09                     ; 3EDAC:  85 09
            jmp b15_e867                ; 3EDAE:  4c 67 e8

            sec                         ; 3EDB1:  38
            lda $08                     ; 3EDB2:  a5 08
            sbc $0c                     ; 3EDB4:  e5 0c
            sta $08                     ; 3EDB6:  85 08
            lda $09                     ; 3EDB8:  a5 09
            sbc $0d                     ; 3EDBA:  e5 0d
            sta $09                     ; 3EDBC:  85 09
            jmp b15_e867                ; 3EDBE:  4c 67 e8

            ldx $0c                     ; 3EDC1:  a6 0c
            bne b15_edcc                ; 3EDC3:  d0 07
b15_edc5:   dec $0d                     ; 3EDC5:  c6 0d
            bpl b15_edcc                ; 3EDC7:  10 03
            jmp b15_e867                ; 3EDC9:  4c 67 e8

b15_edcc:   asl $08                     ; 3EDCC:  06 08
            rol $09                     ; 3EDCE:  26 09
            dex                         ; 3EDD0:  ca
            beq b15_edc5                ; 3EDD1:  f0 f2
            bne b15_edcc                ; 3EDD3:  d0 f7
            lda $09                     ; 3EDD5:  a5 09
            bpl b15_edee                ; 3EDD7:  10 15
            ldx $0c                     ; 3EDD9:  a6 0c
            bne b15_ede4                ; 3EDDB:  d0 07
b15_eddd:   dec $0d                     ; 3EDDD:  c6 0d
            bpl b15_ede4                ; 3EDDF:  10 03
            jmp b15_e867                ; 3EDE1:  4c 67 e8

b15_ede4:   sec                         ; 3EDE4:  38
            ror $09                     ; 3EDE5:  66 09
            ror $08                     ; 3EDE7:  66 08
            dex                         ; 3EDE9:  ca
            beq b15_eddd                ; 3EDEA:  f0 f1
            bne b15_ede4                ; 3EDEC:  d0 f6
b15_edee:   ldx $0c                     ; 3EDEE:  a6 0c
            bne b15_edf9                ; 3EDF0:  d0 07
b15_edf2:   dec $0d                     ; 3EDF2:  c6 0d
            bpl b15_edf9                ; 3EDF4:  10 03
            jmp b15_e867                ; 3EDF6:  4c 67 e8

b15_edf9:   lsr $09                     ; 3EDF9:  46 09
            ror $08                     ; 3EDFB:  66 08
            dex                         ; 3EDFD:  ca
            beq b15_edf2                ; 3EDFE:  f0 f2
            bne b15_edf9                ; 3EE00:  d0 f7
            lda $08                     ; 3EE02:  a5 08
            and $0c                     ; 3EE04:  25 0c
            sta $08                     ; 3EE06:  85 08
            lda $09                     ; 3EE08:  a5 09
            and $0d                     ; 3EE0A:  25 0d
            sta $09                     ; 3EE0C:  85 09
            jmp b15_e867                ; 3EE0E:  4c 67 e8

            lda $08                     ; 3EE11:  a5 08
            ora $0c                     ; 3EE13:  05 0c
            sta $08                     ; 3EE15:  85 08
            lda $09                     ; 3EE17:  a5 09
            ora $0d                     ; 3EE19:  05 0d
            sta $09                     ; 3EE1B:  85 09
            jmp b15_e867                ; 3EE1D:  4c 67 e8

            lda $08                     ; 3EE20:  a5 08
            eor $0c                     ; 3EE22:  45 0c
            sta $08                     ; 3EE24:  85 08
            lda $09                     ; 3EE26:  a5 09
            eor $0d                     ; 3EE28:  45 0d
            sta $09                     ; 3EE2A:  85 09
            jmp b15_e867                ; 3EE2C:  4c 67 e8

            lda $09                     ; 3EE2F:  a5 09
            cmp $0d                     ; 3EE31:  c5 0d
            sty $09                     ; 3EE33:  84 09
            bne b15_ee3e                ; 3EE35:  d0 07
            lda $08                     ; 3EE37:  a5 08
            cmp $0c                     ; 3EE39:  c5 0c
            bne b15_ee3e                ; 3EE3B:  d0 01
            iny                         ; 3EE3D:  c8
b15_ee3e:   sty $08                     ; 3EE3E:  84 08
            jmp b15_e867                ; 3EE40:  4c 67 e8

            lda $09                     ; 3EE43:  a5 09
            cmp $0d                     ; 3EE45:  c5 0d
            sty $09                     ; 3EE47:  84 09
            bne b15_ee51                ; 3EE49:  d0 06
            lda $08                     ; 3EE4B:  a5 08
            cmp $0c                     ; 3EE4D:  c5 0c
            beq b15_ee52                ; 3EE4F:  f0 01
b15_ee51:   iny                         ; 3EE51:  c8
b15_ee52:   sty $08                     ; 3EE52:  84 08
            jmp b15_e867                ; 3EE54:  4c 67 e8

            lda $08                     ; 3EE57:  a5 08
            cmp $0c                     ; 3EE59:  c5 0c
            lda $09                     ; 3EE5B:  a5 09
            sbc $0d                     ; 3EE5D:  e5 0d
            sty $09                     ; 3EE5F:  84 09
            bpl b15_ee64                ; 3EE61:  10 01
            iny                         ; 3EE63:  c8
b15_ee64:   tya                         ; 3EE64:  98
            bvc b15_ee69                ; 3EE65:  50 02
            eor #$01                    ; 3EE67:  49 01
b15_ee69:   sta $08                     ; 3EE69:  85 08
            jmp b15_e867                ; 3EE6B:  4c 67 e8

            lda $0c                     ; 3EE6E:  a5 0c
            cmp $08                     ; 3EE70:  c5 08
            lda $0d                     ; 3EE72:  a5 0d
            sbc $09                     ; 3EE74:  e5 09
            sty $09                     ; 3EE76:  84 09
            bpl b15_ee7b                ; 3EE78:  10 01
            iny                         ; 3EE7A:  c8
b15_ee7b:   tya                         ; 3EE7B:  98
            bvc b15_ee80                ; 3EE7C:  50 02
            eor #$01                    ; 3EE7E:  49 01
b15_ee80:   sta $08                     ; 3EE80:  85 08
            jmp b15_e867                ; 3EE82:  4c 67 e8

            lda $0c                     ; 3EE85:  a5 0c
            cmp $08                     ; 3EE87:  c5 08
            lda $0d                     ; 3EE89:  a5 0d
            sbc $09                     ; 3EE8B:  e5 09
            sty $09                     ; 3EE8D:  84 09
            bmi b15_ee92                ; 3EE8F:  30 01
            iny                         ; 3EE91:  c8
b15_ee92:   tya                         ; 3EE92:  98
            bvc b15_ee97                ; 3EE93:  50 02
            eor #$01                    ; 3EE95:  49 01
b15_ee97:   sta $08                     ; 3EE97:  85 08
            jmp b15_e867                ; 3EE99:  4c 67 e8

            lda $08                     ; 3EE9C:  a5 08
            cmp $0c                     ; 3EE9E:  c5 0c
            lda $09                     ; 3EEA0:  a5 09
            sbc $0d                     ; 3EEA2:  e5 0d
            sty $09                     ; 3EEA4:  84 09
            bmi b15_eea9                ; 3EEA6:  30 01
            iny                         ; 3EEA8:  c8
b15_eea9:   tya                         ; 3EEA9:  98
            bvc b15_eeae                ; 3EEAA:  50 02
            eor #$01                    ; 3EEAC:  49 01
b15_eeae:   sta $08                     ; 3EEAE:  85 08
            jmp b15_e867                ; 3EEB0:  4c 67 e8

            lda $08                     ; 3EEB3:  a5 08
            cmp $0c                     ; 3EEB5:  c5 0c
            lda $09                     ; 3EEB7:  a5 09
            sbc $0d                     ; 3EEB9:  e5 0d
            sty $09                     ; 3EEBB:  84 09
            bcs b15_eec0                ; 3EEBD:  b0 01
            iny                         ; 3EEBF:  c8
b15_eec0:   sty $08                     ; 3EEC0:  84 08
            jmp b15_e867                ; 3EEC2:  4c 67 e8

            lda $0c                     ; 3EEC5:  a5 0c
            cmp $08                     ; 3EEC7:  c5 08
            lda $0d                     ; 3EEC9:  a5 0d
            sbc $09                     ; 3EECB:  e5 09
            sty $09                     ; 3EECD:  84 09
            bcs b15_eed2                ; 3EECF:  b0 01
            iny                         ; 3EED1:  c8
b15_eed2:   sty $08                     ; 3EED2:  84 08
            jmp b15_e867                ; 3EED4:  4c 67 e8

            lda $0c                     ; 3EED7:  a5 0c
            cmp $08                     ; 3EED9:  c5 08
            lda $0d                     ; 3EEDB:  a5 0d
            sbc $09                     ; 3EEDD:  e5 09
            sty $09                     ; 3EEDF:  84 09
            bcc b15_eee4                ; 3EEE1:  90 01
            iny                         ; 3EEE3:  c8
b15_eee4:   sty $08                     ; 3EEE4:  84 08
            jmp b15_e867                ; 3EEE6:  4c 67 e8

            lda $08                     ; 3EEE9:  a5 08
            cmp $0c                     ; 3EEEB:  c5 0c
            lda $09                     ; 3EEED:  a5 09
            sbc $0d                     ; 3EEEF:  e5 0d
            sty $09                     ; 3EEF1:  84 09
            bcc b15_eef6                ; 3EEF3:  90 01
            iny                         ; 3EEF5:  c8
b15_eef6:   sty $08                     ; 3EEF6:  84 08
            jmp b15_e867                ; 3EEF8:  4c 67 e8

            lda $09                     ; 3EEFB:  a5 09
            sty $09                     ; 3EEFD:  84 09
            ora $08                     ; 3EEFF:  05 08
            bne b15_ef04                ; 3EF01:  d0 01
            iny                         ; 3EF03:  c8
b15_ef04:   sty $08                     ; 3EF04:  84 08
            jmp b15_e867                ; 3EF06:  4c 67 e8

b15_ef09:   sec                         ; 3EF09:  38
            tya                         ; 3EF0A:  98
            sbc $08                     ; 3EF0B:  e5 08
            sta $08                     ; 3EF0D:  85 08
            tya                         ; 3EF0F:  98
            sbc $09                     ; 3EF10:  e5 09
            sta $09                     ; 3EF12:  85 09
            jmp b15_e867                ; 3EF14:  4c 67 e8

            lda $08                     ; 3EF17:  a5 08
            eor #$ff                    ; 3EF19:  49 ff
            sta $08                     ; 3EF1B:  85 08
            lda $09                     ; 3EF1D:  a5 09
            eor #$ff                    ; 3EF1F:  49 ff
            sta $09                     ; 3EF21:  85 09
            jmp b15_e867                ; 3EF23:  4c 67 e8

            lda $08                     ; 3EF26:  a5 08
            ldx $0c                     ; 3EF28:  a6 0c
            stx $08                     ; 3EF2A:  86 08
            sta $0c                     ; 3EF2C:  85 0c
            lda $09                     ; 3EF2E:  a5 09
            ldx $0d                     ; 3EF30:  a6 0d
            stx $09                     ; 3EF32:  86 09
            sta $0d                     ; 3EF34:  85 0d
            jmp b15_e867                ; 3EF36:  4c 67 e8

            inc $08                     ; 3EF39:  e6 08
            bne b15_ef3f                ; 3EF3B:  d0 02
            inc $09                     ; 3EF3D:  e6 09
b15_ef3f:   jmp b15_e867                ; 3EF3F:  4c 67 e8

            lda $08                     ; 3EF42:  a5 08
            bne b15_ef48                ; 3EF44:  d0 02
            dec $09                     ; 3EF46:  c6 09
b15_ef48:   dec $08                     ; 3EF48:  c6 08
            jmp b15_e867                ; 3EF4A:  4c 67 e8

            asl $08                     ; 3EF4D:  06 08
            rol $09                     ; 3EF4F:  26 09
            jmp b15_e867                ; 3EF51:  4c 67 e8

            jsr b15_efbf                ; 3EF54:  20 bf ef
            ldy #$08                    ; 3EF57:  a0 08
            jsr b15_f603                ; 3EF59:  20 03 f6
            jmp b15_e867                ; 3EF5C:  4c 67 e8

            jsr b15_efbf                ; 3EF5F:  20 bf ef
            ldy #$08                    ; 3EF62:  a0 08
            jsr b15_f5cd                ; 3EF64:  20 cd f5
            jmp b15_e867                ; 3EF67:  4c 67 e8

            jsr b15_efbf                ; 3EF6A:  20 bf ef
            ldy #$0c                    ; 3EF6D:  a0 0c
            jsr b15_f62c                ; 3EF6F:  20 2c f6
            jmp b15_e867                ; 3EF72:  4c 67 e8

            ldy #$07                    ; 3EF75:  a0 07
            lda $04                     ; 3EF77:  a5 04
            sta $0c                     ; 3EF79:  85 0c
            lda $05                     ; 3EF7B:  a5 05
            sta $0d                     ; 3EF7D:  85 0d
b15_ef7f:   lda ($0c),y                 ; 3EF7F:  b1 0c
            hex 99 00 00 ; sta $0000,y  ; 3EF81:  99 00 00
            dey                         ; 3EF84:  88
            bpl b15_ef7f                ; 3EF85:  10 f8
            inc $00                     ; 3EF87:  e6 00
            bne b15_ef8f                ; 3EF89:  d0 04
            inc $01                     ; 3EF8B:  e6 01
            ldx #$00                    ; 3EF8D:  a2 00
b15_ef8f:   jmp ($0000)                 ; 3EF8F:  6c 00 00

            brk                         ; 3EF92:  00
            hex 00                      ; 3EF93:  00
            jmp b15_e867                ; 3EF94:  4c 67 e8

b15_ef97:   ldx #$00                    ; 3EF97:  a2 00
            lda ($06),y                 ; 3EF99:  b1 06
            bpl b15_ef9e                ; 3EF9B:  10 01
            dex                         ; 3EF9D:  ca
b15_ef9e:   inc $06                     ; 3EF9E:  e6 06
            bne b15_efa4                ; 3EFA0:  d0 02
            inc $07                     ; 3EFA2:  e6 07
b15_efa4:   clc                         ; 3EFA4:  18
            rts                         ; 3EFA5:  60

b15_efa6:   clc                         ; 3EFA6:  18
            ldx #$00                    ; 3EFA7:  a2 00
            lda ($06),y                 ; 3EFA9:  b1 06
            bpl b15_efae                ; 3EFAB:  10 01
            dex                         ; 3EFAD:  ca
b15_efae:   adc $04                     ; 3EFAE:  65 04
            sta $00                     ; 3EFB0:  85 00
            txa                         ; 3EFB2:  8a
            adc $05                     ; 3EFB3:  65 05
            sta $01                     ; 3EFB5:  85 01
            inc $06                     ; 3EFB7:  e6 06
            bne b15_efbd                ; 3EFB9:  d0 02
            inc $07                     ; 3EFBB:  e6 07
b15_efbd:   clc                         ; 3EFBD:  18
            rts                         ; 3EFBE:  60

b15_efbf:   iny                         ; 3EFBF:  c8
            lda ($06),y                 ; 3EFC0:  b1 06
            tax                         ; 3EFC2:  aa
            dey                         ; 3EFC3:  88
            lda ($06),y                 ; 3EFC4:  b1 06
            pha                         ; 3EFC6:  48
            clc                         ; 3EFC7:  18
            lda $06                     ; 3EFC8:  a5 06
            adc #$02                    ; 3EFCA:  69 02
            sta $06                     ; 3EFCC:  85 06
            bcc b15_efd3                ; 3EFCE:  90 03
            inc $07                     ; 3EFD0:  e6 07
            clc                         ; 3EFD2:  18
b15_efd3:   pla                         ; 3EFD3:  68
            rts                         ; 3EFD4:  60

b15_efd5:   lda ($06),y                 ; 3EFD5:  b1 06
            sta $00                     ; 3EFD7:  85 00
            iny                         ; 3EFD9:  c8
            lda ($06),y                 ; 3EFDA:  b1 06
            sta $01                     ; 3EFDC:  85 01
            dey                         ; 3EFDE:  88
            clc                         ; 3EFDF:  18
            lda $06                     ; 3EFE0:  a5 06
            adc #$02                    ; 3EFE2:  69 02
            sta $06                     ; 3EFE4:  85 06
            bcc b15_efeb                ; 3EFE6:  90 03
            inc $07                     ; 3EFE8:  e6 07
            clc                         ; 3EFEA:  18
b15_efeb:   rts                         ; 3EFEB:  60

b15_efec:   clc                         ; 3EFEC:  18
            lda ($06),y                 ; 3EFED:  b1 06
            adc $04                     ; 3EFEF:  65 04
            sta $00                     ; 3EFF1:  85 00
            iny                         ; 3EFF3:  c8
            lda ($06),y                 ; 3EFF4:  b1 06
            adc $05                     ; 3EFF6:  65 05
            sta $01                     ; 3EFF8:  85 01
            dey                         ; 3EFFA:  88
            clc                         ; 3EFFB:  18
            lda $06                     ; 3EFFC:  a5 06
            adc #$02                    ; 3EFFE:  69 02
            sta $06                     ; 3F000:  85 06
            bcc b15_f007                ; 3F002:  90 03
            inc $07                     ; 3F004:  e6 07
            clc                         ; 3F006:  18
b15_f007:   rts                         ; 3F007:  60

b15_f008:   tay                         ; 3F008:  a8
            sec                         ; 3F009:  38
            lda $02                     ; 3F00A:  a5 02
            sbc #$02                    ; 3F00C:  e9 02
            sta $02                     ; 3F00E:  85 02
            bcs b15_f014                ; 3F010:  b0 02
            dec $03                     ; 3F012:  c6 03
b15_f014:   tya                         ; 3F014:  98
            ldy #$00                    ; 3F015:  a0 00
            sta ($02),y                 ; 3F017:  91 02
            iny                         ; 3F019:  c8
            txa                         ; 3F01A:  8a
            sta ($02),y                 ; 3F01B:  91 02
            jmp b15_e867                ; 3F01D:  4c 67 e8

            jsr tab_b15_f679            ; 3F020:  20 79 f6
            jmp b15_e867                ; 3F023:  4c 67 e8

tab_b15_f026: ; 512 bytes
            hex 7f 83 87 8b 8f 93 97 9b ; 3F026:  7f 83 87 8b 8f 93 97 9b
            hex 9f a3 a7 ab d0 cc c8 c4 ; 3F02E:  9f a3 a7 ab d0 cc c8 c4
            hex de e2 e6 ea ee f2 f6 fa ; 3F036:  de e2 e6 ea ee f2 f6 fa
            hex fe 02 06 0a 2f 2b 27 23 ; 3F03E:  fe 02 06 0a 2f 2b 27 23
            hex 3d 41 45 49 4d 51 55 59 ; 3F046:  3d 41 45 49 4d 51 55 59
            hex 5d 61 65 69 8e 8a 86 82 ; 3F04E:  5d 61 65 69 8e 8a 86 82
            hex 9c a0 a4 a8 ac b0 b4 b8 ; 3F056:  9c a0 a4 a8 ac b0 b4 b8
            hex bc c0 c4 c8 eb e7 e3 df ; 3F05E:  bc c0 c4 c8 eb e7 e3 df
            hex 00 f6 f6 f6 f6 f6 f6 f6 ; 3F066:  00 f6 f6 f6 f6 f6 f6 f6
            hex f6 f6 f6 f6 f6 f6 f6 f6 ; 3F06E:  f6 f6 f6 f6 f6 f6 f6 f6
            hex 11 07 07 07 07 07 07 07 ; 3F076:  11 07 07 07 07 07 07 07
            hex 07 07 07 07 07 07 07 07 ; 3F07E:  07 07 07 07 07 07 07 07
            hex 18 18 18 18 18 18 18 18 ; 3F086:  18 18 18 18 18 18 18 18
            hex 18 18 18 18 18 18 18 18 ; 3F08E:  18 18 18 18 18 18 18 18
            hex 2c 20 20 20 20 20 20 20 ; 3F096:  2c 20 20 20 20 20 20 20
            hex 20 20 20 20 20 20 20 20 ; 3F09E:  20 20 20 20 20 20 20 20
            hex 92 34 2f 48 57 61 70 7a ; 3F0A6:  92 34 2f 48 57 61 70 7a
            hex 87 af b9 be c8 cd d3 d9 ; 3F0AE:  87 af b9 be c8 cd d3 d9
            hex e8 92 92 92 92 92 92 92 ; 3F0B6:  e8 92 92 92 92 92 92 92
            hex 92 92 92 92 92 92 92 92 ; 3F0BE:  92 92 92 92 92 92 92 92
            hex ed fe 0f 1e 43 f9 5c 0a ; 3F0C6:  ed fe 0f 1e 43 f9 5c 0a
            hex 75 19 8c 28 4e 7d 9e ac ; 3F0CE:  75 19 8c 28 4e 7d 9e ac
            hex 9e b4 20 ce d5 f0 1e 46 ; 3F0D6:  9e b4 20 ce d5 f0 1e 46
            hex 18 54 6c a1 b1 c1 ee d5 ; 3F0DE:  18 54 6c a1 b1 c1 ee d5
            hex 2f 43 57 85 6e 9c b3 d7 ; 3F0E6:  2f 43 57 85 6e 9c b3 d7
            hex c5 e9 fb 09 17 26 92 75 ; 3F0EE:  c5 e9 fb 09 17 26 92 75
            hex 39 42 4d ab c3 65 bb c5 ; 3F0F6:  39 42 4d ab c3 65 bb c5
            hex d1 1d 02 11 20 43 91 a0 ; 3F0FE:  d1 1d 02 11 20 43 91 a0
            hex 54 5f 6a d9 e7 f3 fb 09 ; 3F106:  54 5f 6a d9 e7 f3 fb 09
            hex 15 38 2d 92 92 92 92 92 ; 3F10E:  15 38 2d 92 92 92 92 92
            hex 92 92 92 92 92 92 92 92 ; 3F116:  92 92 92 92 92 92 92 92
            hex 92 92 92 92 92 92 92 93 ; 3F11E:  92 92 92 92 92 92 92 93
            hex e8 e8 e8 e8 e8 e8 e8 e8 ; 3F126:  e8 e8 e8 e8 e8 e8 e8 e8
            hex e8 e8 e8 e8 e8 e8 e8 e8 ; 3F12E:  e8 e8 e8 e8 e8 e8 e8 e8
            hex e8 e8 e8 e8 e8 e8 e8 e8 ; 3F136:  e8 e8 e8 e8 e8 e8 e8 e8
            hex e8 e9 e9 e9 e9 e9 e9 e9 ; 3F13E:  e8 e9 e9 e9 e9 e9 e9 e9
            hex e9 e9 e9 e9 e9 e9 e9 e9 ; 3F146:  e9 e9 e9 e9 e9 e9 e9 e9
            hex e9 e9 e9 e9 e9 e9 e9 e9 ; 3F14E:  e9 e9 e9 e9 e9 e9 e9 e9
            hex e9 e9 e9 e9 e9 e9 e9 e9 ; 3F156:  e9 e9 e9 e9 e9 e9 e9 e9
            hex e9 e9 e9 e9 e9 e9 e9 e9 ; 3F15E:  e9 e9 e9 e9 e9 e9 e9 e9
            hex ea e9 e9 e9 e9 e9 e9 e9 ; 3F166:  ea e9 e9 e9 e9 e9 e9 e9
            hex e9 e9 e9 e9 e9 e9 e9 e9 ; 3F16E:  e9 e9 e9 e9 e9 e9 e9 e9
            hex ea ea ea ea ea ea ea ea ; 3F176:  ea ea ea ea ea ea ea ea
            hex ea ea ea ea ea ea ea ea ; 3F17E:  ea ea ea ea ea ea ea ea
            hex ea ea ea ea ea ea ea ea ; 3F186:  ea ea ea ea ea ea ea ea
            hex ea ea ea ea ea ea ea ea ; 3F18E:  ea ea ea ea ea ea ea ea
            hex ea ea ea ea ea ea ea ea ; 3F196:  ea ea ea ea ea ea ea ea
            hex ea ea ea ea ea ea ea ea ; 3F19E:  ea ea ea ea ea ea ea ea
            hex ef ea ea ea ea ea ea ea ; 3F1A6:  ef ea ea ea ea ea ea ea
            hex ea ea ea ea ea ea ea ea ; 3F1AE:  ea ea ea ea ea ea ea ea
            hex ea ef ef ef ef ef ef ef ; 3F1B6:  ea ef ef ef ef ef ef ef
            hex ef ef ef ef ef ef ef ef ; 3F1BE:  ef ef ef ef ef ef ef ef
            hex ea ea eb eb ea ea ea eb ; 3F1C6:  ea ea eb eb ea ea ea eb
            hex ea eb ea eb eb eb eb eb ; 3F1CE:  ea eb ea eb eb eb eb eb
            hex ec ec f0 ec ec ec ed f2 ; 3F1D6:  ec ec f0 ec ec ec ed f2
            hex ed ed ed ed ed ed ed ed ; 3F1DE:  ed ed ed ed ed ed ed ed
            hex ee ee ee ee ee ee ee ee ; 3F1E6:  ee ee ee ee ee ee ee ee
            hex ee ee ee ef ef ef ef ef ; 3F1EE:  ee ee ee ef ef ef ef ef
            hex ef ef ef ec ec ec eb eb ; 3F1F6:  ef ef ef ec ec ec eb eb
            hex eb ec ee ee ee eb ea ea ; 3F1FE:  eb ec ee ee ee eb ea ea
            hex ef ef ef eb eb eb eb ec ; 3F206:  ef ef ef eb eb eb eb ec
            hex ec eb eb ef ef ef ef ef ; 3F20E:  ec eb eb ef ef ef ef ef
            hex ef ef ef ef ef ef ef ef ; 3F216:  ef ef ef ef ef ef ef ef
            hex ef ef ef ef ef ef ef ef ; 3F21E:  ef ef ef ef ef ef ef ef

            ldy #$17                    ; 3F226:  a0 17
b15_f228:   lda ($02),y                 ; 3F228:  b1 02
            hex 99 4e 00 ; sta $004e,y  ; 3F22A:  99 4e 00
            dey                         ; 3F22D:  88
            cpy #$01                    ; 3F22E:  c0 01
            bne b15_f228                ; 3F230:  d0 f6
            lda #$f2                    ; 3F232:  a9 f2
            pha                         ; 3F234:  48
            lda #$3c                    ; 3F235:  a9 3c
            pha                         ; 3F237:  48
            php                         ; 3F238:  08
            jmp ($fffe)                 ; 3F239:  6c fe ff

            nop                         ; 3F23C:  ea
            lda $66                     ; 3F23D:  a5 66
            sta $08                     ; 3F23F:  85 08
            lda $67                     ; 3F241:  a5 67
            sta $09                     ; 3F243:  85 09
            rts                         ; 3F245:  60

            lda ($06),y                 ; 3F246:  b1 06
            inc $06                     ; 3F248:  e6 06
            bne b15_f24e                ; 3F24A:  d0 02
            inc $07                     ; 3F24C:  e6 07
b15_f24e:   asl a                       ; 3F24E:  0a
            tax                         ; 3F24F:  aa
            lda b15_f260+1,x            ; 3F250:  bd 61 f2
            sta $00                     ; 3F253:  85 00
            lda b15_f260+2,x            ; 3F255:  bd 62 f2
            sta $01                     ; 3F258:  85 01
            lda #$e8                    ; 3F25A:  a9 e8
            pha                         ; 3F25C:  48
            lda #$66                    ; 3F25D:  a9 66
            pha                         ; 3F25F:  48
b15_f260:   jmp ($0000)                 ; 3F260:  6c 00 00

            hex c1 f2 f0 f2 7f f3 8c f3 ; 3F263:  c1 f2 f0 f2 7f f3 8c f3
            hex 27 f4 46 f4 57 f4 67 f4 ; 3F26B:  27 f4 46 f4 57 f4 67 f4
            hex 95 f4 7e f4 ac f4 4d f5 ; 3F273:  95 f4 7e f4 ac f4 4d f5
            hex 5b f5 69 f5 77 f5 7c f5 ; 3F27B:  5b f5 69 f5 77 f5 7c f5
            hex 81 f5 86 f5 8b f5 a3 f5 ; 3F283:  81 f5 86 f5 8b f5 a3 f5
            hex ac f5 c2 f5 31 f5 f4 f4 ; 3F28B:  ac f5 c2 f5 31 f5 f4 f4
            hex 00 f5 3f f5 1a f5 15 f5 ; 3F293:  00 f5 3f f5 1a f5 15 f5
            hex 3b f4 6b f3 99 f3 b5 f3 ; 3F29B:  3b f4 6b f3 99 f3 b5 f3
            hex f7 f3 03 f4 0f f4 1b f4 ; 3F2A3:  f7 f3 03 f4 0f f4 1b f4
            hex e9 f4 ef f4 f3 f4 33 f4 ; 3F2AB:  e9 f4 ef f4 f3 f4 33 f4
            hex 75 f4 a3 f4 8c f4 ba f4 ; 3F2B3:  75 f4 a3 f4 8c f4 ba f4
            hex db f3 fb f2 62 f3       ; 3F2BB:  db f3 fb f2 62 f3

            sty $10                     ; 3F2C1:  84 10
            sty $11                     ; 3F2C3:  84 11
            sty $12                     ; 3F2C5:  84 12
            sty $13                     ; 3F2C7:  84 13
            ldy #$20                    ; 3F2C9:  a0 20
b15_f2cb:   lda $08                     ; 3F2CB:  a5 08
            lsr a                       ; 3F2CD:  4a
            bcc b15_f2dc                ; 3F2CE:  90 0c
            clc                         ; 3F2D0:  18
            ldx #$fc                    ; 3F2D1:  a2 fc
b15_f2d3:   lda $14,x                   ; 3F2D3:  b5 14
            adc $10,x                   ; 3F2D5:  75 10
            sta $14,x                   ; 3F2D7:  95 14
            inx                         ; 3F2D9:  e8
            bne b15_f2d3                ; 3F2DA:  d0 f7
b15_f2dc:   lsr $13                     ; 3F2DC:  46 13
            ror $12                     ; 3F2DE:  66 12
            ror $11                     ; 3F2E0:  66 11
            ror $10                     ; 3F2E2:  66 10
            ror $0b                     ; 3F2E4:  66 0b
            ror $0a                     ; 3F2E6:  66 0a
            ror $09                     ; 3F2E8:  66 09
            ror $08                     ; 3F2EA:  66 08
            dey                         ; 3F2EC:  88
            bne b15_f2cb                ; 3F2ED:  d0 dc
            rts                         ; 3F2EF:  60

            jsr b15_f2fe                ; 3F2F0:  20 fe f2
            lda $40                     ; 3F2F3:  a5 40
            bpl tab_b15_f2fa            ; 3F2F5:  10 03
            jmp b15_f427                ; 3F2F7:  4c 27 f4

tab_b15_f2fa: ; 4 bytes
            hex 60 4c 1c f3             ; 3F2FA:  60 4c 1c f3

b15_f2fe:   lda $0b                     ; 3F2FE:  a5 0b
            sta $41                     ; 3F300:  85 41
            eor $0f                     ; 3F302:  45 0f
            sta $40                     ; 3F304:  85 40
            lda $0b                     ; 3F306:  a5 0b
            bpl b15_f30d                ; 3F308:  10 03
            jsr b15_f427                ; 3F30A:  20 27 f4
b15_f30d:   lda $0f                     ; 3F30D:  a5 0f
            bpl b15_f31c                ; 3F30F:  10 0b
            ldx #$fc                    ; 3F311:  a2 fc
b15_f313:   lda #$00                    ; 3F313:  a9 00
            sbc $10,x                   ; 3F315:  f5 10
            sta $10,x                   ; 3F317:  95 10
            inx                         ; 3F319:  e8
            bne b15_f313                ; 3F31A:  d0 f7
b15_f31c:   lda #$00                    ; 3F31C:  a9 00
            sta $10                     ; 3F31E:  85 10
            sta $11                     ; 3F320:  85 11
            sta $12                     ; 3F322:  85 12
            sta $13                     ; 3F324:  85 13
            ldy #$20                    ; 3F326:  a0 20
b15_f328:   asl $08                     ; 3F328:  06 08
            rol $09                     ; 3F32A:  26 09
            rol $0a                     ; 3F32C:  26 0a
            rol $0b                     ; 3F32E:  26 0b
            rol $10                     ; 3F330:  26 10
            rol $11                     ; 3F332:  26 11
            rol $12                     ; 3F334:  26 12
            rol $13                     ; 3F336:  26 13
            sec                         ; 3F338:  38
            lda $10                     ; 3F339:  a5 10
            sbc $0c                     ; 3F33B:  e5 0c
            sta $00                     ; 3F33D:  85 00
            lda $11                     ; 3F33F:  a5 11
            sbc $0d                     ; 3F341:  e5 0d
            sta $01                     ; 3F343:  85 01
            lda $12                     ; 3F345:  a5 12
            sbc $0e                     ; 3F347:  e5 0e
            tax                         ; 3F349:  aa
            lda $13                     ; 3F34A:  a5 13
            sbc $0f                     ; 3F34C:  e5 0f
            bcc b15_f35e                ; 3F34E:  90 0e
            stx $12                     ; 3F350:  86 12
            sta $13                     ; 3F352:  85 13
            lda $00                     ; 3F354:  a5 00
            sta $10                     ; 3F356:  85 10
            lda $01                     ; 3F358:  a5 01
            sta $11                     ; 3F35A:  85 11
            inc $08                     ; 3F35C:  e6 08
b15_f35e:   dey                         ; 3F35E:  88
            bne b15_f328                ; 3F35F:  d0 c7
            rts                         ; 3F361:  60

            jsr b15_f31c                ; 3F362:  20 1c f3
            sty $41                     ; 3F365:  84 41
            ldx #$03                    ; 3F367:  a2 03
            bne b15_f370                ; 3F369:  d0 05
            jsr b15_f2fe                ; 3F36B:  20 fe f2
            ldx #$03                    ; 3F36E:  a2 03
b15_f370:   lda $10,x                   ; 3F370:  b5 10
            sta $08,x                   ; 3F372:  95 08
            dex                         ; 3F374:  ca
            bpl b15_f370                ; 3F375:  10 f9
            lda $41                     ; 3F377:  a5 41
            bmi tab_b15_f37c            ; 3F379:  30 01
            rts                         ; 3F37B:  60

tab_b15_f37c: ; 3 bytes
            hex 4c 27 f4                ; 3F37C:  4c 27 f4

            clc                         ; 3F37F:  18
            ldx #$fc                    ; 3F380:  a2 fc
b15_f382:   lda $0c,x                   ; 3F382:  b5 0c
            adc $10,x                   ; 3F384:  75 10
            sta $0c,x                   ; 3F386:  95 0c
            inx                         ; 3F388:  e8
            bne b15_f382                ; 3F389:  d0 f7
            rts                         ; 3F38B:  60

            sec                         ; 3F38C:  38
            ldx #$fc                    ; 3F38D:  a2 fc
b15_f38f:   lda $0c,x                   ; 3F38F:  b5 0c
            sbc $10,x                   ; 3F391:  f5 10
            sta $0c,x                   ; 3F393:  95 0c
            inx                         ; 3F395:  e8
            bne b15_f38f                ; 3F396:  d0 f7
            rts                         ; 3F398:  60

b15_f399:   clc                         ; 3F399:  18
            ldy #$ff                    ; 3F39A:  a0 ff
            ldx #$fc                    ; 3F39C:  a2 fc
b15_f39e:   tya                         ; 3F39E:  98
            adc $10,x                   ; 3F39F:  75 10
            sta $10,x                   ; 3F3A1:  95 10
            inx                         ; 3F3A3:  e8
            bne b15_f39e                ; 3F3A4:  d0 f8
            tax                         ; 3F3A6:  aa
            bpl b15_f3aa                ; 3F3A7:  10 01
            rts                         ; 3F3A9:  60

b15_f3aa:   asl $08                     ; 3F3AA:  06 08
            rol $09                     ; 3F3AC:  26 09
            rol $0a                     ; 3F3AE:  26 0a
            rol $0b                     ; 3F3B0:  26 0b
            jmp b15_f399                ; 3F3B2:  4c 99 f3

            clc                         ; 3F3B5:  18
            lda $0b                     ; 3F3B6:  a5 0b
            bpl b15_f3bb                ; 3F3B8:  10 01
            sec                         ; 3F3BA:  38
b15_f3bb:   php                         ; 3F3BB:  08
b15_f3bc:   clc                         ; 3F3BC:  18
            ldy #$ff                    ; 3F3BD:  a0 ff
            ldx #$fc                    ; 3F3BF:  a2 fc
b15_f3c1:   tya                         ; 3F3C1:  98
            adc $10,x                   ; 3F3C2:  75 10
            sta $10,x                   ; 3F3C4:  95 10
            inx                         ; 3F3C6:  e8
            bne b15_f3c1                ; 3F3C7:  d0 f8
            tax                         ; 3F3C9:  aa
            bpl b15_f3ce                ; 3F3CA:  10 02
            plp                         ; 3F3CC:  28
            rts                         ; 3F3CD:  60

b15_f3ce:   plp                         ; 3F3CE:  28
            php                         ; 3F3CF:  08
            ror $0b                     ; 3F3D0:  66 0b
            ror $0a                     ; 3F3D2:  66 0a
            ror $09                     ; 3F3D4:  66 09
            ror $08                     ; 3F3D6:  66 08
            jmp b15_f3bc                ; 3F3D8:  4c bc f3

b15_f3db:   clc                         ; 3F3DB:  18
            ldy #$ff                    ; 3F3DC:  a0 ff
            ldx #$fc                    ; 3F3DE:  a2 fc
b15_f3e0:   tya                         ; 3F3E0:  98
            adc $10,x                   ; 3F3E1:  75 10
            sta $10,x                   ; 3F3E3:  95 10
            inx                         ; 3F3E5:  e8
            bne b15_f3e0                ; 3F3E6:  d0 f8
            tax                         ; 3F3E8:  aa
            bpl b15_f3ec                ; 3F3E9:  10 01
            rts                         ; 3F3EB:  60

b15_f3ec:   lsr $0b                     ; 3F3EC:  46 0b
            ror $0a                     ; 3F3EE:  66 0a
            ror $09                     ; 3F3F0:  66 09
            ror $08                     ; 3F3F2:  66 08
            jmp b15_f3db                ; 3F3F4:  4c db f3

            ldx #$03                    ; 3F3F7:  a2 03
b15_f3f9:   lda $08,x                   ; 3F3F9:  b5 08
            eor #$ff                    ; 3F3FB:  49 ff
            sta $08,x                   ; 3F3FD:  95 08
            dex                         ; 3F3FF:  ca
            bpl b15_f3f9                ; 3F400:  10 f7
            rts                         ; 3F402:  60

            ldx #$03                    ; 3F403:  a2 03
b15_f405:   lda $08,x                   ; 3F405:  b5 08
            and $0c,x                   ; 3F407:  35 0c
            sta $08,x                   ; 3F409:  95 08
            dex                         ; 3F40B:  ca
            bpl b15_f405                ; 3F40C:  10 f7
            rts                         ; 3F40E:  60

            ldx #$03                    ; 3F40F:  a2 03
b15_f411:   lda $08,x                   ; 3F411:  b5 08
            ora $0c,x                   ; 3F413:  15 0c
            sta $08,x                   ; 3F415:  95 08
            dex                         ; 3F417:  ca
            bpl b15_f411                ; 3F418:  10 f7
            rts                         ; 3F41A:  60

            ldx #$03                    ; 3F41B:  a2 03
b15_f41d:   lda $08,x                   ; 3F41D:  b5 08
            eor $0c,x                   ; 3F41F:  55 0c
            sta $08,x                   ; 3F421:  95 08
            dex                         ; 3F423:  ca
            bpl b15_f41d                ; 3F424:  10 f7
            rts                         ; 3F426:  60

b15_f427:   sec                         ; 3F427:  38
            ldx #$fc                    ; 3F428:  a2 fc
b15_f42a:   tya                         ; 3F42A:  98
            sbc $0c,x                   ; 3F42B:  f5 0c
            sta $0c,x                   ; 3F42D:  95 0c
            inx                         ; 3F42F:  e8
            bne b15_f42a                ; 3F430:  d0 f8
            rts                         ; 3F432:  60

            jsr b15_f43b                ; 3F433:  20 3b f4
            lda $08                     ; 3F436:  a5 08
            eor #$01                    ; 3F438:  49 01
            rts                         ; 3F43A:  60

b15_f43b:   ldx #$03                    ; 3F43B:  a2 03
b15_f43d:   lda $08,x                   ; 3F43D:  b5 08
            bne b15_f451                ; 3F43F:  d0 10
            dex                         ; 3F441:  ca
            bpl b15_f43d                ; 3F442:  10 f9
            bmi b15_f462                ; 3F444:  30 1c
            ldx #$03                    ; 3F446:  a2 03
b15_f448:   lda $08,x                   ; 3F448:  b5 08
            cmp $0c,x                   ; 3F44A:  d5 0c
            bne b15_f462                ; 3F44C:  d0 14
            dex                         ; 3F44E:  ca
            bpl b15_f448                ; 3F44F:  10 f7
b15_f451:   sty $09                     ; 3F451:  84 09
            iny                         ; 3F453:  c8
            sty $08                     ; 3F454:  84 08
            rts                         ; 3F456:  60

            ldx #$03                    ; 3F457:  a2 03
b15_f459:   lda $08,x                   ; 3F459:  b5 08
            cmp $0c,x                   ; 3F45B:  d5 0c
            bne b15_f451                ; 3F45D:  d0 f2
            dex                         ; 3F45F:  ca
            bpl b15_f459                ; 3F460:  10 f7
b15_f462:   sty $09                     ; 3F462:  84 09
            sty $08                     ; 3F464:  84 08
            rts                         ; 3F466:  60

            jsr b15_f4c3                ; 3F467:  20 c3 f4
            bpl b15_f46d                ; 3F46A:  10 01
            iny                         ; 3F46C:  c8
b15_f46d:   tya                         ; 3F46D:  98
            bvc b15_f472                ; 3F46E:  50 02
            eor #$01                    ; 3F470:  49 01
b15_f472:   sta $08                     ; 3F472:  85 08
            rts                         ; 3F474:  60

            jsr b15_f4c3                ; 3F475:  20 c3 f4
            bcs b15_f47b                ; 3F478:  b0 01
            iny                         ; 3F47A:  c8
b15_f47b:   sty $08                     ; 3F47B:  84 08
            rts                         ; 3F47D:  60

            jsr b15_f4d6                ; 3F47E:  20 d6 f4
            bpl b15_f484                ; 3F481:  10 01
            iny                         ; 3F483:  c8
b15_f484:   tya                         ; 3F484:  98
            bvc b15_f489                ; 3F485:  50 02
            eor #$01                    ; 3F487:  49 01
b15_f489:   sta $08                     ; 3F489:  85 08
            rts                         ; 3F48B:  60

            jsr b15_f4d6                ; 3F48C:  20 d6 f4
            bcs b15_f492                ; 3F48F:  b0 01
            iny                         ; 3F491:  c8
b15_f492:   sty $08                     ; 3F492:  84 08
            rts                         ; 3F494:  60

            jsr b15_f4d6                ; 3F495:  20 d6 f4
            bmi b15_f49b                ; 3F498:  30 01
            iny                         ; 3F49A:  c8
b15_f49b:   tya                         ; 3F49B:  98
            bvc b15_f4a0                ; 3F49C:  50 02
            eor #$01                    ; 3F49E:  49 01
b15_f4a0:   sta $08                     ; 3F4A0:  85 08
            rts                         ; 3F4A2:  60

            jsr b15_f4d6                ; 3F4A3:  20 d6 f4
            bcc b15_f4a9                ; 3F4A6:  90 01
            iny                         ; 3F4A8:  c8
b15_f4a9:   sty $08                     ; 3F4A9:  84 08
            rts                         ; 3F4AB:  60

            jsr b15_f4c3                ; 3F4AC:  20 c3 f4
            bmi b15_f4b2                ; 3F4AF:  30 01
            iny                         ; 3F4B1:  c8
b15_f4b2:   tya                         ; 3F4B2:  98
            bvc b15_f4b7                ; 3F4B3:  50 02
            eor #$01                    ; 3F4B5:  49 01
b15_f4b7:   sta $08                     ; 3F4B7:  85 08
            rts                         ; 3F4B9:  60

            jsr b15_f4c3                ; 3F4BA:  20 c3 f4
            bcc b15_f4c0                ; 3F4BD:  90 01
            iny                         ; 3F4BF:  c8
b15_f4c0:   sty $08                     ; 3F4C0:  84 08
            rts                         ; 3F4C2:  60

b15_f4c3:   lda $08                     ; 3F4C3:  a5 08
            cmp $0c                     ; 3F4C5:  c5 0c
            lda $09                     ; 3F4C7:  a5 09
            sbc $0d                     ; 3F4C9:  e5 0d
            sty $09                     ; 3F4CB:  84 09
            lda $0a                     ; 3F4CD:  a5 0a
            sbc $0e                     ; 3F4CF:  e5 0e
            lda $0b                     ; 3F4D1:  a5 0b
            sbc $0f                     ; 3F4D3:  e5 0f
            rts                         ; 3F4D5:  60

b15_f4d6:   lda $0c                     ; 3F4D6:  a5 0c
            cmp $08                     ; 3F4D8:  c5 08
            lda $0d                     ; 3F4DA:  a5 0d
            sbc $09                     ; 3F4DC:  e5 09
            sty $09                     ; 3F4DE:  84 09
            lda $0e                     ; 3F4E0:  a5 0e
            sbc $0a                     ; 3F4E2:  e5 0a
            lda $0f                     ; 3F4E4:  a5 0f
            sbc $0b                     ; 3F4E6:  e5 0b
            rts                         ; 3F4E8:  60

            lda $09                     ; 3F4E9:  a5 09
            bpl b15_f4ef                ; 3F4EB:  10 02
            ldy #$ff                    ; 3F4ED:  a0 ff
b15_f4ef:   sty $0a                     ; 3F4EF:  84 0a
            sty $0b                     ; 3F4F1:  84 0b
            rts                         ; 3F4F3:  60

b15_f4f4:   lda ($06),y                 ; 3F4F4:  b1 06
            hex 99 08 00 ; sta $0008,y  ; 3F4F6:  99 08 00
            iny                         ; 3F4F9:  c8
            cpy #$04                    ; 3F4FA:  c0 04
            bne b15_f4f4                ; 3F4FC:  d0 f6
            beq b15_f50a                ; 3F4FE:  f0 0a
b15_f500:   lda ($06),y                 ; 3F500:  b1 06
            hex 99 0c 00 ; sta $000c,y  ; 3F502:  99 0c 00
            iny                         ; 3F505:  c8
            cpy #$04                    ; 3F506:  c0 04
            bne b15_f500                ; 3F508:  d0 f6
b15_f50a:   lda $06                     ; 3F50A:  a5 06
            adc #$03                    ; 3F50C:  69 03
            sta $06                     ; 3F50E:  85 06
            bcc b15_f514                ; 3F510:  90 02
            inc $07                     ; 3F512:  e6 07
b15_f514:   rts                         ; 3F514:  60

            ldy #$ff                    ; 3F515:  a0 ff
            tya                         ; 3F517:  98
            bne b15_f51c                ; 3F518:  d0 02
            lda #$01                    ; 3F51A:  a9 01
b15_f51c:   clc                         ; 3F51C:  18
            ldx #$01                    ; 3F51D:  a2 01
            adc $08                     ; 3F51F:  65 08
            sta $08                     ; 3F521:  85 08
            ror a                       ; 3F523:  6a
b15_f524:   rol a                       ; 3F524:  2a
            tya                         ; 3F525:  98
            adc $08,x                   ; 3F526:  75 08
            sta $08,x                   ; 3F528:  95 08
            ror a                       ; 3F52A:  6a
            inx                         ; 3F52B:  e8
            cpx #$04                    ; 3F52C:  e0 04
            bne b15_f524                ; 3F52E:  d0 f4
            rts                         ; 3F530:  60

            jsr b15_ecdb                ; 3F531:  20 db ec
            ldy #$03                    ; 3F534:  a0 03
b15_f536:   hex b9 08 00 ; lda $0008,y  ; 3F536:  b9 08 00
            sta ($0c),y                 ; 3F539:  91 0c
            dey                         ; 3F53B:  88
            bpl b15_f536                ; 3F53C:  10 f8
            rts                         ; 3F53E:  60

            ldx #$03                    ; 3F53F:  a2 03
b15_f541:   lda $08,x                   ; 3F541:  b5 08
            ldy $0c,x                   ; 3F543:  b4 0c
            sta $0c,x                   ; 3F545:  95 0c
            sty $08,x                   ; 3F547:  94 08
            dex                         ; 3F549:  ca
            bpl b15_f541                ; 3F54A:  10 f5
            rts                         ; 3F54C:  60

            jsr b15_efec                ; 3F54D:  20 ec ef
b15_f550:   ldy #$03                    ; 3F550:  a0 03
b15_f552:   lda ($00),y                 ; 3F552:  b1 00
            hex 99 08 00 ; sta $0008,y  ; 3F554:  99 08 00
            dey                         ; 3F557:  88
            bpl b15_f552                ; 3F558:  10 f8
            rts                         ; 3F55A:  60

            jsr b15_efec                ; 3F55B:  20 ec ef
b15_f55e:   ldy #$03                    ; 3F55E:  a0 03
b15_f560:   lda ($00),y                 ; 3F560:  b1 00
            hex 99 0c 00 ; sta $000c,y  ; 3F562:  99 0c 00
            dey                         ; 3F565:  88
            bpl b15_f560                ; 3F566:  10 f8
            rts                         ; 3F568:  60

            jsr b15_efec                ; 3F569:  20 ec ef
b15_f56c:   ldy #$03                    ; 3F56C:  a0 03
b15_f56e:   hex b9 08 00 ; lda $0008,y  ; 3F56E:  b9 08 00
            sta ($00),y                 ; 3F571:  91 00
            dey                         ; 3F573:  88
            bpl b15_f56e                ; 3F574:  10 f8
            rts                         ; 3F576:  60

            jsr b15_efec                ; 3F577:  20 ec ef
            bcc b15_f58e                ; 3F57A:  90 12
            jsr b15_efd5                ; 3F57C:  20 d5 ef
            bcc b15_f550                ; 3F57F:  90 cf
            jsr b15_efd5                ; 3F581:  20 d5 ef
            bcc b15_f55e                ; 3F584:  90 d8
            jsr b15_efd5                ; 3F586:  20 d5 ef
            bcc b15_f56c                ; 3F589:  90 e1
            jsr b15_efd5                ; 3F58B:  20 d5 ef
b15_f58e:   sec                         ; 3F58E:  38
            lda $02                     ; 3F58F:  a5 02
            sbc #$04                    ; 3F591:  e9 04
            sta $02                     ; 3F593:  85 02
            bcs b15_f599                ; 3F595:  b0 02
            dec $03                     ; 3F597:  c6 03
b15_f599:   ldy #$03                    ; 3F599:  a0 03
b15_f59b:   lda ($00),y                 ; 3F59B:  b1 00
            sta ($02),y                 ; 3F59D:  91 02
            dey                         ; 3F59F:  88
            bpl b15_f59b                ; 3F5A0:  10 f9
            rts                         ; 3F5A2:  60

            lda #$08                    ; 3F5A3:  a9 08
            sta $00                     ; 3F5A5:  85 00
            sty $01                     ; 3F5A7:  84 01
            jmp b15_f58e                ; 3F5A9:  4c 8e f5

            ldy #$03                    ; 3F5AC:  a0 03
b15_f5ae:   lda ($02),y                 ; 3F5AE:  b1 02
            hex 99 0c 00 ; sta $000c,y  ; 3F5B0:  99 0c 00
            dey                         ; 3F5B3:  88
            bpl b15_f5ae                ; 3F5B4:  10 f8
            clc                         ; 3F5B6:  18
            lda $02                     ; 3F5B7:  a5 02
            adc #$04                    ; 3F5B9:  69 04
            sta $02                     ; 3F5BB:  85 02
            bcc b15_f5c1                ; 3F5BD:  90 02
            inc $03                     ; 3F5BF:  e6 03
b15_f5c1:   rts                         ; 3F5C1:  60

            lda $08                     ; 3F5C2:  a5 08
            sta $00                     ; 3F5C4:  85 00
            lda $09                     ; 3F5C6:  a5 09
            sta $01                     ; 3F5C8:  85 01
            jmp b15_f550                ; 3F5CA:  4c 50 f5

b15_f5cd:   pha                         ; 3F5CD:  48
            hex b9 00 00 ; lda $0000,y  ; 3F5CE:  b9 00 00
            sta $00                     ; 3F5D1:  85 00
            hex b9 01 00 ; lda $0001,y  ; 3F5D3:  b9 01 00
            sta $01                     ; 3F5D6:  85 01
            ldy #$00                    ; 3F5D8:  a0 00
            lda ($00),y                 ; 3F5DA:  b1 00
            sta $08                     ; 3F5DC:  85 08
            iny                         ; 3F5DE:  c8
            lda ($00),y                 ; 3F5DF:  b1 00
            sta $09                     ; 3F5E1:  85 09
            txa                         ; 3F5E3:  8a
            beq b15_f5ed                ; 3F5E4:  f0 07
b15_f5e6:   lsr $09                     ; 3F5E6:  46 09
            ror $08                     ; 3F5E8:  66 08
            dex                         ; 3F5EA:  ca
            bne b15_f5e6                ; 3F5EB:  d0 f9
b15_f5ed:   pla                         ; 3F5ED:  68
            jsr b15_f669                ; 3F5EE:  20 69 f6
            lda $08                     ; 3F5F1:  a5 08
            and $0a                     ; 3F5F3:  25 0a
            sta $08                     ; 3F5F5:  85 08
            lda $09                     ; 3F5F7:  a5 09
            and $0b                     ; 3F5F9:  25 0b
            sta $09                     ; 3F5FB:  85 09
            lda #$00                    ; 3F5FD:  a9 00
            tax                         ; 3F5FF:  aa
            ldy #$01                    ; 3F600:  a0 01
            rts                         ; 3F602:  60

b15_f603:   jsr b15_f5cd                ; 3F603:  20 cd f5
            lda $0b                     ; 3F606:  a5 0b
            eor #$ff                    ; 3F608:  49 ff
            sta $0b                     ; 3F60A:  85 0b
            lsr a                       ; 3F60C:  4a
            and $09                     ; 3F60D:  25 09
            sta $00                     ; 3F60F:  85 00
            lda $0a                     ; 3F611:  a5 0a
            eor #$ff                    ; 3F613:  49 ff
            sta $0a                     ; 3F615:  85 0a
            ror a                       ; 3F617:  6a
            and $08                     ; 3F618:  25 08
            ora $00                     ; 3F61A:  05 00
            beq b15_f62a                ; 3F61C:  f0 0c
            lda $08                     ; 3F61E:  a5 08
            ora $0a                     ; 3F620:  05 0a
            sta $08                     ; 3F622:  85 08
            lda $09                     ; 3F624:  a5 09
            ora $0b                     ; 3F626:  05 0b
            sta $09                     ; 3F628:  85 09
b15_f62a:   txa                         ; 3F62A:  8a
            rts                         ; 3F62B:  60

b15_f62c:   pha                         ; 3F62C:  48
            hex b9 00 00 ; lda $0000,y  ; 3F62D:  b9 00 00
            sta $00                     ; 3F630:  85 00
            hex b9 01 00 ; lda $0001,y  ; 3F632:  b9 01 00
            sta $01                     ; 3F635:  85 01
            pla                         ; 3F637:  68
            jsr b15_f669                ; 3F638:  20 69 f6
            txa                         ; 3F63B:  8a
            beq b15_f649                ; 3F63C:  f0 0b
b15_f63e:   asl $08                     ; 3F63E:  06 08
            rol $09                     ; 3F640:  26 09
            asl $0a                     ; 3F642:  06 0a
            rol $0b                     ; 3F644:  26 0b
            dex                         ; 3F646:  ca
            bne b15_f63e                ; 3F647:  d0 f5
b15_f649:   lda $08                     ; 3F649:  a5 08
            and $0a                     ; 3F64B:  25 0a
            sta $08                     ; 3F64D:  85 08
            lda $09                     ; 3F64F:  a5 09
            and $0b                     ; 3F651:  25 0b
            sta $09                     ; 3F653:  85 09
            iny                         ; 3F655:  c8
b15_f656:   hex b9 0a 00 ; lda $000a,y  ; 3F656:  b9 0a 00
            eor #$ff                    ; 3F659:  49 ff
            and ($00),y                 ; 3F65B:  31 00
            hex 19 08 00 ; ora $0008,y  ; 3F65D:  19 08 00
            sta ($00),y                 ; 3F660:  91 00
            dey                         ; 3F662:  88
            bpl b15_f656                ; 3F663:  10 f1
            txa                         ; 3F665:  8a
            ldy #$01                    ; 3F666:  a0 01
            rts                         ; 3F668:  60

b15_f669:   tay                         ; 3F669:  a8
            lda #$00                    ; 3F66A:  a9 00
            sta $0a                     ; 3F66C:  85 0a
            sta $0b                     ; 3F66E:  85 0b
b15_f670:   sec                         ; 3F670:  38
            rol $0a                     ; 3F671:  26 0a
            rol $0b                     ; 3F673:  26 0b
            dey                         ; 3F675:  88
            bne b15_f670                ; 3F676:  d0 f8
            rts                         ; 3F678:  60

tab_b15_f679: ; 84 bytes
            hex 60 3e 00 12 00 29 00 30 ; 3F679:  60 3e 00 12 00 29 00 30
            hex 00 3e 00 16 00 38 00 30 ; 3F681:  00 3e 00 16 00 38 00 30
            hex 00 43 6f 6e 74 72 6f 6c ; 3F689:  00 43 6f 6e 74 72 6f 6c
            hex 20 25 64 00 0a 28 59 2f ; 3F691:  20 25 64 00 0a 28 59 2f
            hex 4e 29 3f 20 00 25 64 00 ; 3F699:  4e 29 3f 20 00 25 64 00
            hex 25 64 00 25 64 00 20 00 ; 3F6A1:  25 64 00 25 64 00 20 00
            hex 25 64 00 0a 28 25 64 2d ; 3F6A9:  25 64 00 0a 28 25 64 2d
            hex 25 64 29 3f 20 00 48 69 ; 3F6B1:  25 64 29 3f 20 00 48 69
            hex 74 20 61 6e 79 20 6b 65 ; 3F6B9:  74 20 61 6e 79 20 6b 65
            hex 79 00 00 25 64 00 53 70 ; 3F6C1:  79 00 00 25 64 00 53 70
            hex 72 69 6e 67             ; 3F6C9:  72 69 6e 67

            brk                         ; 3F6CD:  00
            hex 53                      ; 3F6CE:  53
            adc $6d,x                   ; 3F6CF:  75 6d
            adc $7265                   ; 3F6D1:  6d 65 72
            brk                         ; 3F6D4:  00
            hex 46                      ; 3F6D5:  46
            adc ($6c,x)                 ; 3F6D6:  61 6c
            jmp ($5700)                 ; 3F6D8:  6c 00 57

            hex 69 6e 74 65 72 00 4c 6f ; 3F6DB:  69 6e 74 65 72 00 4c 6f
            hex 72 64 20 00 4c 6f 72 64 ; 3F6E3:  72 64 20 00 4c 6f 72 64
            hex 0a 00 50 69 72 61 74 65 ; 3F6EB:  0a 00 50 69 72 61 74 65
            hex 73 00 43 68 72 69 73 74 ; 3F6F3:  73 00 43 68 72 69 73 74
            hex 6e 73 00 52 69 6f 74 65 ; 3F6FB:  6e 73 00 52 69 6f 74 65
            hex 72 73 00 6e 6f 20 6c 6f ; 3F703:  72 73 00 6e 6f 20 6c 6f
            hex 72 64 00 0f 09 0d 14 15 ; 3F70B:  72 64 00 0f 09 0d 14 15
            hex 11 13 17 16 1f 1a 1b 19 ; 3F713:  11 13 17 16 1f 1a 1b 19
            hex 1e 20 0e 18 00 5a       ; 3F71B:  1e 20 0e 18 00 5a

            adc $61                     ; 3F721:  65 61
            jmp ($746f)                 ; 3F723:  6c 6f 74

            hex 73 00 4d 6f 6e 6b 73 00 ; 3F726:  73 00 4d 6f 6e 6b 73 00
            hex 52 65 62 65 6c 73 00 20 ; 3F72E:  52 65 62 65 6c 73 00 20
            hex 69 73 20 6e 6f 77 0a 66 ; 3F736:  69 73 20 6e 6f 77 0a 66
            hex 69 65 66 20 25 32 64 60 ; 3F73E:  69 65 66 20 25 32 64 60
            hex 73 20 64 61 69 6d 79 6f ; 3F746:  73 20 64 61 69 6d 79 6f
            hex 00 20 77 61 73 0a 6b    ; 3F74E:  00 20 77 61 73 0a 6b

            adc #$6c                    ; 3F755:  69 6c
            jmp ($6465)                 ; 3F757:  6c 65 64

            hex 00 20 69 6e 20 66 69 65 ; 3F75A:  00 20 69 6e 20 66 69 65
            hex 66 20 25 32 64 0a 69 6e ; 3F762:  66 20 25 32 64 0a 69 6e
            hex 20 74 68 65 20 79 65 61 ; 3F76A:  20 74 68 65 20 79 65 61
            hex 72 20 25 64 00 4c 6f 72 ; 3F772:  72 20 25 64 00 4c 6f 72
            hex 64 20 00 0a 00 20 77 61 ; 3F77A:  64 20 00 0a 00 20 77 61
            hex 6e 74 73 20 61 0a 25 73 ; 3F782:  6e 74 73 20 61 0a 25 73
            hex 0a 00 44 65 6d 61 6e 64 ; 3F78A:  0a 00 44 65 6d 61 6e 64

            jsr $6f67                   ; 3F792:  20 67 6f
            jmp ($0064)                 ; 3F795:  6c 64 00

            hex 6d 61 72 72 69 61 67 65 ; 3F798:  6d 61 72 72 69 61 67 65
            hex 20 70 61 63 74 00 61 63 ; 3F7A0:  20 70 61 63 74 00 61 63
            hex 63 65 70 74 00 70 61 63 ; 3F7A8:  63 65 70 74 00 70 61 63
            hex 74 00 46 69 65 66 20 00 ; 3F7B0:  74 00 46 69 65 66 20 00
            hex 25 64 20 6c 6f 73 74 20 ; 3F7B8:  25 64 20 6c 6f 73 74 20
            hex 69 74 73                ; 3F7C0:  69 74 73

            asl a                       ; 3F7C3:  0a
            jmp ($6165)                 ; 3F7C4:  6c 65 61

            hex 64 65 72 00 00 3e 00 38 ; 3F7C7:  64 65 72 00 00 3e 00 38
            hex 00 28 00 30 00 e0 f7 ea ; 3F7CF:  00 28 00 30 00 e0 f7 ea
            hex f7 f5 f7 fe f7 07 f8 0f ; 3F7D7:  f7 f5 f7 fe f7 07 f8 0f
            hex f8 48 6f 6d 65 20 66 69 ; 3F7DF:  f8 48 6f 6d 65 20 66 69
            hex 65 66 00 49 6e 64 75 73 ; 3F7E7:  65 66 00 49 6e 64 75 73
            hex 74 72                   ; 3F7EF:  74 72

            adc #$61                    ; 3F7F1:  69 61
            jmp ($4d00)                 ; 3F7F3:  6c 00 4d

            hex 69 6c 69 74 61 72 79 00 ; 3F7F6:  69 6c 69 74 61 72 79 00
            hex 42 61 6c 61 6e 63 65 64 ; 3F7FE:  42 61 6c 61 6e 63 65 64
            hex 00 46 61 72 6d 69 6e 67 ; 3F806:  00 46 61 72 6d 69 6e 67
            hex 00 44 69 72 65 63 74 00 ; 3F80E:  00 44 69 72 65 63 74 00
            hex 40 f8 45 f8 49 f8 4d f8 ; 3F816:  40 f8 45 f8 49 f8 4d f8
            hex 52 f8 56 f8 5b          ; 3F81E:  52 f8 56 f8 5b

            sed                         ; 3F823:  f8
            rts                         ; 3F824:  60

            sed                         ; 3F825:  f8
            ror $f8                     ; 3F826:  66 f8
            jmp ($71f8)                 ; 3F828:  6c f8 71

            hex f8 77 f8 7c f8 82 f8 87 ; 3F82B:  f8 77 f8 7c f8 82 f8 87
            hex f8 8d f8 94 f8 99 f8 9d ; 3F833:  f8 8d f8 94 f8 99 f8 9d
            hex f8 a3 f8 a9 f8 4d 6f 76 ; 3F83B:  f8 a3 f8 a9 f8 4d 6f 76
            hex 65 00 57 61 72 00 54 61 ; 3F843:  65 00 57 61 72 00 54 61
            hex 78 00 53 65 6e 64 00 44 ; 3F84B:  78 00 53 65 6e 64 00 44
            hex 61 6d 00 50 61 63 74 00 ; 3F853:  61 6d 00 50 61 63 74 00
            hex 47 72 6f 77 00 4d 61 72 ; 3F85B:  47 72 6f 77 00 4d 61 72
            hex 72 79 00 54 72 61 64 65 ; 3F863:  72 79 00 54 72 61 64 65
            hex 00 48 69 72 65 00 54 72 ; 3F86B:  00 48 69 72 65 00 54 72
            hex 61 69 6e 00 56 69 65 77 ; 3F873:  61 69 6e 00 56 69 65 77

            brk                         ; 3F87B:  00
            hex 42                      ; 3F87C:  42
            adc $69,x                   ; 3F87D:  75 69
            jmp ($0064)                 ; 3F87F:  6c 64 00

            hex 47 69 76 65 00 42 72 69 ; 3F882:  47 69 76 65 00 42 72 69
            hex 62 65 00 41 73 73 69 67 ; 3F88A:  62 65 00 41 73 73 69 67
            hex 6e 00 52 65 73 74 00 4d ; 3F892:  6e 00 52 65 73 74 00 4d
            hex 61 70 00 47 72 61 6e 74 ; 3F89A:  61 70 00 47 72 61 6e 74
            hex 00 4f 74 68 65 72 00 50 ; 3F8A2:  00 4f 74 68 65 72 00 50
            hex 61 73 73 00 d2 f8 d6 f8 ; 3F8AA:  61 73 73 00 d2 f8 d6 f8
            hex db f8 e0 f8 e5 f8 ea f8 ; 3F8B2:  db f8 e0 f8 e5 f8 ea f8
            hex ed f8 f2 f8 f7 f8 fc f8 ; 3F8BA:  ed f8 f2 f8 f7 f8 fc f8
            hex 01 f9 08 f9 0d f9 13    ; 3F8C2:  01 f9 08 f9 0d f9 13

            sbc tab_b15_f919+1,y        ; 3F8C9:  f9 1a f9
            asl $25f9,x                 ; 3F8CC:  1e f9 25
            sbc b15_f929+2,y            ; 3F8CF:  f9 2b f9
            eor ($67,x)                 ; 3F8D2:  41 67
            adc $00                     ; 3F8D4:  65 00
            pha                         ; 3F8D6:  48
b15_f8d7:   jmp ($6874)                 ; 3F8D7:  6c 74 68

            hex 00 44 72 69 76 00 4c 75 ; 3F8DA:  00 44 72 69 76 00 4c 75
            hex 63 6b 00 43 68 61 72 00 ; 3F8E2:  63 6b 00 43 68 61 72 00
            hex 49 51 00 47 6f 6c 64 00 ; 3F8EA:  49 51 00 47 6f 6c 64 00
            hex 44 65 62 74 00 54 6f 77 ; 3F8F2:  44 65 62 74 00 54 6f 77
            hex 6e 00 52 69 63 65 00 4f ; 3F8FA:  6e 00 52 69 63 65 00 4f
            hex 75 74 70 75 74 00 44 61 ; 3F902:  75 74 70 75 74 00 44 61
            hex 6d 73                   ; 3F90A:  6d 73

            brk                         ; 3F90C:  00
            hex 4c                      ; 3F90D:  4c
            adc $746c,y                 ; 3F90E:  79 6c 74
            adc $5700,y                 ; 3F911:  79 00 57
            adc $61                     ; 3F914:  65 61
            jmp ($6874)                 ; 3F916:  6c 74 68

tab_b15_f919: ; 14 bytes
            hex 00 4d 65 6e 00 4d 6f 72 ; 3F919:  00 4d 65 6e 00 4d 6f 72
            hex 61 6c 65 00 53 6b       ; 3F921:  61 6c 65 00 53 6b

            adc #$6c                    ; 3F927:  69 6c
b15_f929:   jmp ($4100)                 ; 3F929:  6c 00 41

            hex 72 6d 73 00 41 69 41 6f ; 3F92C:  72 6d 73 00 41 69 41 6f
            hex 49 65 55 65 4f 69 4b 61 ; 3F934:  49 65 55 65 4f 69 4b 61
            hex 4b 69 4b 75 53 61 53 69 ; 3F93C:  4b 69 4b 75 53 61 53 69
            hex 53 75 53 6f 54 61 54 75 ; 3F944:  53 75 53 6f 54 61 54 75
            hex 54 6f 4e 61 4e 6f 48 61 ; 3F94C:  54 6f 4e 61 4e 6f 48 61
            hex 48 69 48 75 59 75 59 6f ; 3F954:  48 69 48 75 59 75 59 6f
            hex 00 73 65 74 65 6e 6f 68 ; 3F95C:  00 73 65 74 65 6e 6f 68
            hex 6f 6d 61 6d 69 6d 65 6d ; 3F964:  6f 6d 61 6d 69 6d 65 6d
            hex 6f 79 61 72 61 77 61 67 ; 3F96C:  6f 79 61 72 61 77 61 67
            hex 61 67 69 7a 61 7a 65 64 ; 3F974:  61 67 69 7a 61 7a 65 64
            hex 61 64 75 62 61 62 69 62 ; 3F97C:  61 64 75 62 61 62 69 62
            hex 76 62 65 6a 6f 00 0a 6e ; 3F984:  76 62 65 6a 6f 00 0a 6e
            hex 6f 20 66 69 65 66 73 00 ; 3F98C:  6f 20 66 69 65 66 73 00
            hex 20 20 46 69 65 66 73 20 ; 3F994:  20 20 46 69 65 66 73 20
            hex 00 48 6f 77 20 6d 75 63 ; 3F99C:  00 48 6f 77 20 6d 75 63
            hex 68 00 48 6f 77 20 6d 61 ; 3F9A4:  68 00 48 6f 77 20 6d 61
            hex 6e 79 00 b5 f9 bd f9 c5 ; 3F9AC:  6e 79 00 b5 f9 bd f9 c5
            hex f9 52 69 66 6c 65 73 20 ; 3F9B4:  f9 52 69 66 6c 65 73 20
            hex 00 49 6e 66 6e 74 72 79 ; 3F9BC:  00 49 6e 66 6e 74 72 79
            hex 00 43 61 76 61 6c 72 79 ; 3F9C4:  00 43 61 76 61 6c 72 79
            hex 00 0a 4d 6f 76 65 20 77 ; 3F9CC:  00 0a 4d 6f 76 65 20 77
            hex 68 65 72 65 3f 0a 00 48 ; 3F9D4:  68 65 72 65 3f 0a 00 48
            hex 6f 77                   ; 3F9DC:  6f 77

            jsr $616d                   ; 3F9DE:  20 6d 61
            ror $2079                   ; 3F9E1:  6e 79 20
            adc $6e65                   ; 3F9E4:  6d 65 6e
            brk                         ; 3F9E7:  00
            hex 57                      ; 3F9E8:  57
            adc #$6c                    ; 3F9E9:  69 6c
            jmp ($7920)                 ; 3F9EB:  6c 20 79

            hex 6f                      ; 3F9EE:  6f

            adc $20,x                   ; 3F9EF:  75 20
            jmp ($6165)                 ; 3F9F1:  6c 65 61

            hex 64 0a 74 68 65 6d 20 70 ; 3F9F4:  64 0a 74 68 65 6d 20 70
            hex 65 72 73 6f             ; 3F9FC:  65 72 73 6f

            ror $6c61                   ; 3FA00:  6e 61 6c
            jmp ($0079)                 ; 3FA03:  6c 79 00

            hex 54 68 65 79 20 68 61 76 ; 3FA06:  54 68 65 79 20 68 61 76
            hex 65 0a 61 72 72          ; 3FA0E:  65 0a 61 72 72

            adc #$76                    ; 3FA13:  69 76
            adc $64                     ; 3FA15:  65 64
            jsr $6173                   ; 3FA17:  20 73 61
            ror $65                     ; 3FA1A:  66 65
            jmp ($0079)                 ; 3FA1C:  6c 79 00

            hex 0a 41 74 74 61 63 6b 20 ; 3FA1F:  0a 41 74 74 61 63 6b 20
            hex 77 68 65 72 65 3f 0a 00 ; 3FA27:  77 68 65 72 65 3f 0a 00
            hex 48 6f 77 20 6d 61 6e 79 ; 3FA2F:  48 6f 77 20 6d 61 6e 79
            hex 20 6d 65 6e 00 48 6f 77 ; 3FA37:  20 6d 65 6e 00 48 6f 77
            hex 20 6d 75 63 68 20 72 69 ; 3FA3F:  20 6d 75 63 68 20 72 69
            hex 63 65 0a 77             ; 3FA47:  63 65 0a 77

            adc #$6c                    ; 3FA4B:  69 6c
            jmp ($7420)                 ; 3FA4D:  6c 20 74

            hex 68 65 79 20 74 61 6b 65 ; 3FA50:  68 65 79 20 74 61 6b 65
            hex 00 57                   ; 3FA58:  00 57

            adc #$6c                    ; 3FA5A:  69 6c
            jmp ($7920)                 ; 3FA5C:  6c 20 79

            hex 6f                      ; 3FA5F:  6f

            adc $20,x                   ; 3FA60:  75 20
            jmp ($6165)                 ; 3FA62:  6c 65 61

            hex 64 0a 74 68 65 6d 20 70 ; 3FA65:  64 0a 74 68 65 6d 20 70
            hex 65 72 73 6f             ; 3FA6D:  65 72 73 6f

            ror $6c61                   ; 3FA71:  6e 61 6c
            jmp ($0079)                 ; 3FA74:  6c 79 00

            hex 54 61 78 20 69 73 20 25 ; 3FA77:  54 61 78 20 69 73 20 25
            hex 64 0a 45 6e 74 65 72 20 ; 3FA7F:  64 0a 45 6e 74 65 72 20
            hex 6e 65 77 20 74 61 78 00 ; 3FA87:  6e 65 77 20 74 61 78 00
            hex 54 68 65 20 70 65 61 73 ; 3FA8F:  54 68 65 20 70 65 61 73
            hex 61 6e 74 73 20 61 72 65 ; 3FA97:  61 6e 74 73 20 61 72 65
            hex 0a 64 65 6c 69 67 68 74 ; 3FA9F:  0a 64 65 6c 69 67 68 74
            hex 65 64 21 00 54 68 65 20 ; 3FAA7:  65 64 21 00 54 68 65 20
            hex 70 65 61 73 61 6e 74 73 ; 3FAAF:  70 65 61 73 61 6e 74 73
            hex 20 61 72 65 0a 70 72 6f ; 3FAB7:  20 61 72 65 0a 70 72 6f
            hex 74 65 73 74 69 6e 67 21 ; 3FABF:  74 65 73 74 69 6e 67 21
            hex 00 0a 53 65 6e 64 20 77 ; 3FAC7:  00 0a 53 65 6e 64 20 77
            hex 68 65 72 65 3f 20 00 4c ; 3FACF:  68 65 72 65 3f 20 00 4c
            hex 6f 72 64 2c 20 79 6f 75 ; 3FAD7:  6f 72 64 2c 20 79 6f 75
            hex 20 61 72 65 20 74 6f 6f ; 3FADF:  20 61 72 65 20 74 6f 6f
            hex 0a 77 65 61 6b 20 66 6f ; 3FAE7:  0a 77 65 61 6b 20 66 6f
            hex 72 20 62 61 74 74 6c 65 ; 3FAEF:  72 20 62 61 74 74 6c 65
            hex 21 00 00 47 6f 6c 64 00 ; 3FAF7:  21 00 00 47 6f 6c 64 00
            hex 52 69 63 65 00 54 68 65 ; 3FAFF:  52 69 63 65 00 54 68 65
            hex 20 73 75 70 70 6c 69 65 ; 3FB07:  20 73 75 70 70 6c 69 65
            hex 73 20 68 61 76 65 0a 61 ; 3FB0F:  73 20 68 61 76 65 0a 61
            hex 72 72                   ; 3FB17:  72 72

            adc #$76                    ; 3FB19:  69 76
            adc $64                     ; 3FB1B:  65 64
            jsr $6173                   ; 3FB1D:  20 73 61
            ror $65                     ; 3FB20:  66 65
            jmp ($0079)                 ; 3FB22:  6c 79 00

            hex 25 73 20 69 73 20 25 64 ; 3FB25:  25 73 20 69 73 20 25 64
            hex 0a 53 70 65 6e 64 20 68 ; 3FB2D:  0a 53 70 65 6e 64 20 68
            hex 6f 77 20 6d 75 63 68 0a ; 3FB35:  6f 77 20 6d 75 63 68 0a
            hex 6f 6e 20 69 74 00 44 61 ; 3FB3D:  6f 6e 20 69 74 00 44 61
            hex 6d 73                   ; 3FB45:  6d 73

            jsr $6176                   ; 3FB47:  20 76 61
            jmp ($6575)                 ; 3FB4A:  6c 75 65

            hex 20 69 73 0a 6e 6f 77 20 ; 3FB4D:  20 69 73 0a 6e 6f 77 20
            hex 25 64 00 4f 75 74 70 75 ; 3FB55:  25 64 00 4f 75 74 70 75
            hex 74 20 69 73 20 6e 6f 77 ; 3FB5D:  74 20 69 73 20 6e 6f 77
            hex 0a 25 64 00 4e 6f 20 6d ; 3FB65:  0a 25 64 00 4e 6f 20 6d
            hex 65 72 63 68 61 6e 74 20 ; 3FB6D:  65 72 63 68 61 6e 74 20
            hex 69 6e 0a 74 68 65 20 61 ; 3FB75:  69 6e 0a 74 68 65 20 61
            hex 72 65 61 00 52 65 63 72 ; 3FB7D:  72 65 61 00 52 65 63 72
            hex 75 69 74                ; 3FB85:  75 69 74

            jsr $6877                   ; 3FB88:  20 77 68
            adc #$63                    ; 3FB8B:  69 63
            pla                         ; 3FB8D:  68
            brk                         ; 3FB8E:  00
            hex 00                      ; 3FB8F:  00
            jmp $726f                   ; 3FB90:  4c 6f 72

            hex 64 20 25 73 2c 20 77 65 ; 3FB93:  64 20 25 73 2c 20 77 65
            hex 0a 6e 6f 77 20 68 61 76 ; 3FB9B:  0a 6e 6f 77 20 68 61 76
            hex 65 20 25 64 20 6d 65 6e ; 3FBA3:  65 20 25 64 20 6d 65 6e
            hex 00 00 00 57 68 61 74 20 ; 3FBAB:  00 00 00 57 68 61 74 20
            hex 6d 69 73 73 69 6f 6e 00 ; 3FBB3:  6d 69 73 73 69 6f 6e 00
            hex 45 6e 65 6d 79 20 6d 6f ; 3FBBB:  45 6e 65 6d 79 20 6d 6f
            hex 72                      ; 3FBC3:  72

            adc ($6c,x)                 ; 3FBC4:  61 6c
            adc $20                     ; 3FBC6:  65 20
            adc #$73                    ; 3FBC8:  69 73
            asl a                       ; 3FBCA:  0a
            ror $61                     ; 3FBCB:  66 61
            jmp ($696c)                 ; 3FBCD:  6c 6c 69

            hex 6e 67 20 74 6f 20 70 69 ; 3FBD0:  6e 67 20 74 6f 20 70 69
            hex 65 63 65 73 21 00 53 6b ; 3FBD8:  65 63 65 73 21 00 53 6b

            adc #$6c                    ; 3FBE0:  69 6c
            jmp ($6920)                 ; 3FBE2:  6c 20 69

            hex 73 20 6e 6f 77 20 25 64 ; 3FBE5:  73 20 6e 6f 77 20 25 64
            hex 00 00 56 69 65 77 20 77 ; 3FBED:  00 00 56 69 65 77 20 77
            hex 68 69 63 68 20 66 69 65 ; 3FBF5:  68 69 63 68 20 66 69 65
            hex 66 3f 0a 00 4f 75 72 20 ; 3FBFD:  66 3f 0a 00 4f 75 72 20
            hex 73 70 79 20 77 61 73 0a ; 3FC05:  73 70 79 20 77 61 73 0a
            hex 63 61 75 67 68 74 00 54 ; 3FC0D:  63 61 75 67 68 74 00 54
            hex 6f 77 6e 20 76 61 6c 75 ; 3FC15:  6f 77 6e 20 76 61 6c 75
            hex 65 20 69 73 20 6e 6f 77 ; 3FC1D:  65 20 69 73 20 6e 6f 77
            hex 0a 25 64 00 47 6f 6c 64 ; 3FC25:  0a 25 64 00 47 6f 6c 64
            hex 20 66 6f 72 20 73 70 79 ; 3FC2D:  20 66 6f 72 20 73 70 79
            hex 00 25 64 20 70 65 61 73 ; 3FC35:  00 25 64 20 70 65 61 73
            hex 61 6e 74 73 0a 68 61 76 ; 3FC3D:  61 6e 74 73 0a 68 61 76
            hex 65 20 64 65 66 65 63 74 ; 3FC45:  65 20 64 65 66 65 63 74
            hex 65 64 00 4e 6f 20 70 65 ; 3FC4D:  65 64 00 4e 6f 20 70 65
            hex 61 73 61 6e 74 73 0a 64 ; 3FC55:  61 73 61 6e 74 73 0a 64
            hex 65 66 65 63 74 65 64 21 ; 3FC5D:  65 66 65 63 74 65 64 21
            hex 00 53 65 61 73 6f       ; 3FC65:  00 53 65 61 73 6f

            hex 6e 73 00 ; ror $0073    ; 3FC6B:  6e 73 00
            eor #$74                    ; 3FC6E:  49 74
            jsr $6977                   ; 3FC70:  20 77 69
            jmp ($206c)                 ; 3FC73:  6c 6c 20

            hex 64 6f 20 79 6f 75 0a 67 ; 3FC76:  64 6f 20 79 6f 75 0a 67
            hex 6f 6f 64 00 4c 6f 72 64 ; 3FC7E:  6f 6f 64 00 4c 6f 72 64
            hex 2c 20 79 6f 75 20 61 72 ; 3FC86:  2c 20 79 6f 75 20 61 72
            hex 65 0a 74 72 75 6c 79 20 ; 3FC8E:  65 0a 74 72 75 6c 79 20
            hex 77 69 73 65 21 00 0a 57 ; 3FC96:  77 69 73 65 21 00 0a 57
            hex 68 69 63 68 20 66 69 65 ; 3FC9E:  68 69 63 68 20 66 69 65
            hex 66 3f 20 00 4c 6f 72 64 ; 3FCA6:  66 3f 20 00 4c 6f 72 64
            hex 20 25 73 0a 74          ; 3FCAE:  20 25 73 0a 74

            pla                         ; 3FCB3:  68
            adc $79                     ; 3FCB4:  65 79
            rts                         ; 3FCB6:  60

            hex 76 65 20 72 65 66 75 73 ; 3FCB7:  76 65 20 72 65 66 75 73
            hex 65 64 21 00 59 6f 75 72 ; 3FCBF:  65 64 21 00 59 6f 75 72
            hex 20 62 72 69 64 65 2d 74 ; 3FCC7:  20 62 72 69 64 65 2d 74
            hex 6f 2d 62 65 0a 68 61 73 ; 3FCCF:  6f 2d 62 65 0a 68 61 73
            hex 20 61 72 72 69 76 65 64 ; 3FCD7:  20 61 72 72 69 76 65 64
            hex 00 44 6f                ; 3FCDF:  00 44 6f

            ror $7460                   ; 3FCE2:  6e 60 74
            jsr $6f79                   ; 3FCE5:  20 79 6f
            adc $20,x                   ; 3FCE8:  75 20
            jmp ($6e6f)                 ; 3FCEA:  6c 6f 6e

            hex 67 20 74 6f 0a 68 65 61 ; 3FCED:  67 20 74 6f 0a 68 65 61
            hex 72 20 74 68 65 0a 70 69 ; 3FCF5:  72 20 74 68 65 0a 70 69
            hex 74 74 65 72 2d 70 61 74 ; 3FCFD:  74 74 65 72 2d 70 61 74
            hex 74                      ; 3FD05:  74

            adc $72                     ; 3FD06:  65 72
            jsr $666f                   ; 3FD08:  20 6f 66
            asl a                       ; 3FD0B:  0a
            adc ($20,x)                 ; 3FD0C:  61 20
            jmp ($7469)                 ; 3FD0E:  6c 69 74

            hex 74 6c 65 20 6c 6f 72 64 ; 3FD11:  74 6c 65 20 6c 6f 72 64
            hex 60 73 0a 66 6f 6f 74 73 ; 3FD19:  60 73 0a 66 6f 6f 74 73
            hex 74 65 70 73             ; 3FD21:  74 65 70 73

            brk                         ; 3FD25:  00
            hex 00                      ; 3FD26:  00
            jmp $726f                   ; 3FD27:  4c 6f 72

            hex 64 20 25 73 2c 0a 25 73 ; 3FD2A:  64 20 25 73 2c 0a 25 73

            jsr $6177                   ; 3FD32:  20 77 61
            ror $7374                   ; 3FD35:  6e 74 73
            asl a                       ; 3FD38:  0a
            and $64                     ; 3FD39:  25 64
            jsr $6f67                   ; 3FD3B:  20 67 6f
            jmp ($0a64)                 ; 3FD3E:  6c 64 0a

            hex 50 61 79 00 4c 6f 72 64 ; 3FD41:  50 61 79 00 4c 6f 72 64
            hex 20 25 73 2c 0a 25 73    ; 3FD49:  20 25 73 2c 0a 25 73

            jsr $6177                   ; 3FD50:  20 77 61
            ror $7374                   ; 3FD53:  6e 74 73
            asl a                       ; 3FD56:  0a
            and $64                     ; 3FD57:  25 64
            jsr $6f67                   ; 3FD59:  20 67 6f
            jmp ($0a64)                 ; 3FD5C:  6c 64 0a

            bvc b15_fdc0+2              ; 3FD5F:  50 61
            adc $5700,y                 ; 3FD61:  79 00 57
            adc ($72,x)                 ; 3FD64:  61 72
            jsr $7369                   ; 3FD66:  20 69 73
            jsr $6e69                   ; 3FD69:  20 69 6e
            adc $76                     ; 3FD6C:  65 76
            adc #$74                    ; 3FD6E:  69 74
            adc ($62,x)                 ; 3FD70:  61 62
            jmp ($0a65)                 ; 3FD72:  6c 65 0a

            hex 73 6f 20 64 6f 6e 60 74 ; 3FD75:  73 6f 20 64 6f 6e 60 74
            hex 20 6c 65 74 20 79 6f 75 ; 3FD7D:  20 6c 65 74 20 79 6f 75
            hex 72 0a 67 75 61 72 64 20 ; 3FD85:  72 0a 67 75 61 72 64 20
            hex 64 6f 77 6e 21 00 57 68 ; 3FD8D:  64 6f 77 6e 21 00 57 68
            hex 6f 20 6e 65 65 64 73 20 ; 3FD95:  6f 20 6e 65 65 64 73 20
            hex 68 69 6d 0a 61 6e 79 77 ; 3FD9D:  68 69 6d 0a 61 6e 79 77
            hex 61 79 00 47 69 76 65 20 ; 3FDA5:  61 79 00 47 69 76 65 20
            hex 68 6f 77 20 6d 75 63 68 ; 3FDAD:  68 6f 77 20 6d 75 63 68
            hex 00 54 68 61 6e 6b       ; 3FDB5:  00 54 68 61 6e 6b

            jsr $6f79                   ; 3FDBB:  20 79 6f
            adc $20,x                   ; 3FDBE:  75 20
b15_fdc0:   jmp $726f                   ; 3FDC0:  4c 6f 72

            hex 64 21 00 57 65 60 72 65 ; 3FDC3:  64 21 00 57 65 60 72 65
            hex 20 61 74 20 6f 75 72    ; 3FDCB:  20 61 74 20 6f 75 72

            asl a                       ; 3FDD2:  0a
            jmp ($6d69)                 ; 3FDD3:  6c 69 6d

            hex 69 74 00 59 6f 75 20 68 ; 3FDD6:  69 74 00 59 6f 75 20 68
            hex 61 76 65 20 6e 6f 20 67 ; 3FDDE:  61 76 65 20 6e 6f 20 67
            hex 6f 6c 64 21 00 59 6f 75 ; 3FDE6:  6f 6c 64 21 00 59 6f 75
            hex 20 68 61 76 65 20 6e 6f ; 3FDEE:  20 68 61 76 65 20 6e 6f
            hex 20 72 69 63 65 21 00 59 ; 3FDF6:  20 72 69 63 65 21 00 59
            hex 6f 75 20 68 61 76 65 20 ; 3FDFE:  6f 75 20 68 61 76 65 20
            hex 6e 6f 0a 73 6f 6c 64 69 ; 3FE06:  6e 6f 0a 73 6f 6c 64 69
            hex 65 72 73 21 00 59 6f 75 ; 3FE0E:  65 72 73 21 00 59 6f 75
            hex 20 68 61 76 65 20 6e 6f ; 3FE16:  20 68 61 76 65 20 6e 6f
            hex 0a 70 65 61 73 61 6e 74 ; 3FE1E:  0a 70 65 61 73 61 6e 74
            hex 73 21 00 54 68 65 79 20 ; 3FE26:  73 21 00 54 68 65 79 20
            hex 61 72 65 20 79 6f 75 72 ; 3FE2E:  61 72 65 20 79 6f 75 72

            asl a                       ; 3FE36:  0a
            adc ($6c,x)                 ; 3FE37:  61 6c
            jmp ($6569)                 ; 3FE39:  6c 69 65

            hex 73 21 00 00 0a 57 68 69 ; 3FE3C:  73 21 00 00 0a 57 68 69
            hex 63 68 20 66 69 65 66 20 ; 3FE44:  63 68 20 66 69 65 66 20
            hex 00 0a 57 68 61 74 20 61 ; 3FE4C:  00 0a 57 68 61 74 20 61
            hex 72 65 20 79 6f 75 72 0a ; 3FE54:  72 65 20 79 6f 75 72 0a
            hex 6f 72 64 65 72 73 3f 00 ; 3FE5C:  6f 72 64 65 72 73 3f 00
            hex 49 74 60 73 20 63 75 72 ; 3FE64:  49 74 60 73 20 63 75 72
            hex 72 65 6e 74 6c 79 20 61 ; 3FE6C:  72 65 6e 74 6c 79 20 61
            hex 0a 25 73 20 73 74 61 74 ; 3FE74:  0a 25 73 20 73 74 61 74
            hex 65 0a 4f 4b 20 74 6f 20 ; 3FE7C:  65 0a 4f 4b 20 74 6f 20
            hex 6d 61 6b 65 20 69 74 20 ; 3FE84:  6d 61 6b 65 20 69 74 20
            hex 61 0a 25 73 20 73 74 61 ; 3FE8C:  61 0a 25 73 20 73 74 61
            hex 74 65 00 0a 42 72 69 62 ; 3FE94:  74 65 00 0a 42 72 69 62
            hex 65 20 77 68 69 63 68 3f ; 3FE9C:  65 20 77 68 69 63 68 3f
            hex 20 00 02 02 02 02 02 02 ; 3FEA4:  20 00 02 02 02 02 02 02
            hex 02 04 04 04 04 04 04 04 ; 3FEAC:  02 04 04 04 04 04 04 04
            hex 03 03 03 03 03 05 03 05 ; 3FEB4:  03 03 03 03 03 05 03 05
            hex 05 05 05 06 06 06 06 06 ; 3FEBC:  05 05 05 06 06 06 06 06
            hex 06 06 06 06 07 07 07 07 ; 3FEC4:  06 06 06 06 07 07 07 07
            hex 08 07 07 07 07 07 08 08 ; 3FECC:  08 07 07 07 07 07 08 08
            hex 08 08 08 08 00 00 00 00 ; 3FED4:  08 08 08 08 00 00 00 00
            hex 01 00 00 00 00 01 01 01 ; 3FEDC:  01 00 00 00 00 01 01 01
            hex 01 01 01 00 00 f7 fe 00 ; 3FEE4:  01 01 01 00 00 f7 fe 00
            hex ff 04 ff 08 ff 0c ff 11 ; 3FEEC:  ff 04 ff 08 ff 0c ff 11
            hex ff 15 ff 41 73 73 69 67 ; 3FEF4:  ff 15 ff 41 73 73 69 67
            hex 6e 0a 0a 00 49 6e 64 00 ; 3FEFC:  6e 0a 0a 00 49 6e 64 00
            hex 4d 69 6c 00 42 61 6c 00 ; 3FF04:  4d 69 6c 00 42 61 6c 00
            hex 46 61 72 6d 00 44 69 72 ; 3FF0C:  46 61 72 6d 00 44 69 72
            hex 00 4d 65 6e 75 00 28 ff ; 3FF14:  00 4d 65 6e 75 00 28 ff
            hex 2e ff 35 ff 3a ff 3f ff ; 3FF1C:  2e ff 35 ff 3a ff 3f ff
            hex 46 ff 4a ff 53 6f 75 6e ; 3FF24:  46 ff 4a ff 53 6f 75 6e
            hex 64 00 41 6e 69 6d 61 74 ; 3FF2C:  64 00 41 6e 69 6d 61 74
            hex 00 57 61 69 74 00 53 61 ; 3FF34:  00 57 61 69 74 00 53 61
            hex 76 65 00 42 61 74 74 6c ; 3FF3C:  76 65 00 42 61 74 74 6c
            hex 65 00 45 6e 64 00 4d 65 ; 3FF44:  65 00 45 6e 64 00 4d 65
            hex 6e 75 00 5b ff 60 ff 66 ; 3FF4C:  6e 75 00 5b ff 60 ff 66
            hex ff 6b ff 6f ff 74 ff 4c ; 3FF54:  ff 6b ff 6f ff 74 ff 4c
            hex 6f 61                   ; 3FF5C:  6f 61

            ror $5200                   ; 3FF5E:  6e 00 52
            adc $70                     ; 3FF61:  65 70
            adc ($79,x)                 ; 3FF63:  61 79
            brk                         ; 3FF65:  00
            hex 53                      ; 3FF66:  53
            adc $6c                     ; 3FF67:  65 6c
            jmp ($4200)                 ; 3FF69:  6c 00 42

            hex 75 79 00 41 72 6d 73 00 ; 3FF6C:  75 79 00 41 72 6d 73 00
            hex 4d 65 6e 75 00 00 ff ff ; 3FF74:  4d 65 6e 75 00 00 ff ff
            hex ff ff ff ff ff ff ff ff ; 3FF7C:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FF84:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FF8C:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FF94:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FF9C:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FFA4:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FFAC:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FFB4:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FFBC:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FFC4:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FFCC:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 3FFD4:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff 4e 4f 42 55 ; 3FFDC:  ff ff ff ff 4e 4f 42 55
            hex 2d 4e 45 53 31 30 20 20 ; 3FFE4:  2d 4e 45 53 31 30 20 20
            hex 20 20 20 20 ff ff ff ff ; 3FFEC:  20 20 20 20 ff ff ff ff
            hex ff ff ff 09 ff ff       ; 3FFF4:  ff ff ff 09 ff ff

NMI:        word b15_c0da               ; 3FFFA: da c0
RESET:      word b15_c000               ; 3FFFC: 00 c0
IRQ:        word b15_c139               ; 3FFFE: 39 c1
