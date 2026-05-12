.base $8000

            hex 4c e1 af                ; 08000:  4c e1 af

            ldx #$00                    ; 08003:  a2 00
            ldy #$07                    ; 08005:  a0 07
b2_8007:    lda (ptr1_lo),y                 ; 08007:  b1 02
            hex 99 08 00 ; sta $0008,y  ; 08009:  99 08 00
            dey                         ; 0800C:  88
            bne b2_8007                 ; 0800D:  d0 f8
            lda $0e                     ; 0800F:  a5 0e
            tay                         ; 08011:  a8
            beq b2_8025                 ; 08012:  f0 11
            dey                         ; 08014:  88
            beq b2_8032                 ; 08015:  f0 1b
            dey                         ; 08017:  88
            beq b2_8040                 ; 08018:  f0 26
            dey                         ; 0801A:  88
            beq b2_8051                 ; 0801B:  f0 34
            dey                         ; 0801D:  88
            beq b2_805e                 ; 0801E:  f0 3e
            dey                         ; 08020:  88
            beq b2_806a                 ; 08021:  f0 47
            bne b2_807b                 ; 08023:  d0 56
b2_8025:    lda ($0a),y                 ; 08025:  b1 0a
            beq b2_807b                 ; 08027:  f0 52
            sec                         ; 08029:  38
            sbc #$01                    ; 0802A:  e9 01
            sta ($0a),y                 ; 0802C:  91 0a
            and #$01                    ; 0802E:  29 01
            bne b2_807f                 ; 08030:  d0 4d
b2_8032:    lda ($0c),y                 ; 08032:  b1 0c
            cmp #$04                    ; 08034:  c9 04
            beq b2_807b                 ; 08036:  f0 43
            clc                         ; 08038:  18
            adc #$01                    ; 08039:  69 01
            sta ($0c),y                 ; 0803B:  91 0c
            jmp b2_807f                 ; 0803D:  4c 7f 80

b2_8040:    lda ($0a),y                 ; 08040:  b1 0a
            cmp #$0a                    ; 08042:  c9 0a
            beq b2_807b                 ; 08044:  f0 35
            clc                         ; 08046:  18
            adc #$01                    ; 08047:  69 01
            sta ($0a),y                 ; 08049:  91 0a
            and #$01                    ; 0804B:  29 01
            beq b2_8032                 ; 0804D:  f0 e3
            bne b2_807f                 ; 0804F:  d0 2e
b2_8051:    lda ($0a),y                 ; 08051:  b1 0a
            beq b2_807b                 ; 08053:  f0 26
            sec                         ; 08055:  38
            sbc #$01                    ; 08056:  e9 01
            sta ($0a),y                 ; 08058:  91 0a
            and #$01                    ; 0805A:  29 01
            beq b2_807f                 ; 0805C:  f0 21
b2_805e:    lda ($0c),y                 ; 0805E:  b1 0c
            beq b2_807b                 ; 08060:  f0 19
            sec                         ; 08062:  38
            sbc #$01                    ; 08063:  e9 01
            sta ($0c),y                 ; 08065:  91 0c
            jmp b2_807f                 ; 08067:  4c 7f 80

b2_806a:    lda ($0a),y                 ; 0806A:  b1 0a
            cmp #$0a                    ; 0806C:  c9 0a
            beq b2_807b                 ; 0806E:  f0 0b
            clc                         ; 08070:  18
            adc #$01                    ; 08071:  69 01
            sta ($0a),y                 ; 08073:  91 0a
            and #$01                    ; 08075:  29 01
            bne b2_805e                 ; 08077:  d0 e5
            beq b2_807f                 ; 08079:  f0 04
b2_807b:    lda #$00                    ; 0807B:  a9 00
            beq b2_8081                 ; 0807D:  f0 02
b2_807f:    lda #$01                    ; 0807F:  a9 01
b2_8081:    sta $08                     ; 08081:  85 08
            stx $09                     ; 08083:  86 09
            rts                         ; 08085:  60

            hex 20 23 e8 f6 ff a4 5b 6f ; 08086:  20 23 e8 f6 ff a4 5b 6f
            hex d2 8c b1 6e bb b0 2b 0b ; 0808E:  d2 8c b1 6e bb b0 2b 0b
            hex 55 b8 29 0b 55 ba 2a 09 ; 08096:  55 b8 29 0b 55 ba 2a 09
            hex 55 b8 28 09 55 ba 29 08 ; 0809E:  55 b8 28 09 55 ba 29 08
            hex 55 b8 27                ; 080A6:  55 b8 27

            php                         ; 080A9:  08
            eor $ba,x                   ; 080AA:  55 ba
            plp                         ; 080AC:  28
            jmp ($f08e)                 ; 080AD:  6c 8e f0

            hex 17 0a 8c c0 00 b5 8c 04 ; 080B0:  17 0a 8c c0 00 b5 8c 04
            hex a6 bb b3 68 e9 7c cf    ; 080B8:  a6 bb b3 68 e9 7c cf

            php                         ; 080BF:  08
            ror $8e                     ; 080C0:  66 8e
            bcs tab_b2_80c7+21          ; 080C2:  b0 18
            ora #$8b                    ; 080C4:  09 8b
            rts                         ; 080C6:  60

tab_b2_80c7: ; 28 bytes
            hex b5 8c c4 a9 bb b3 68 e9 ; 080C7:  b5 8c c4 a9 bb b3 68 e9
            hex 7c cf 08 66 8e 10 19 08 ; 080CF:  7c cf 08 66 8e 10 19 08
            hex 8b 60 b5 8c a4 ab bb b3 ; 080D7:  8b 60 b5 8c a4 ab bb b3
            hex 68 e9 7c cf             ; 080DF:  68 e9 7c cf

            php                         ; 080E3:  08
            jmp ($708e)                 ; 080E4:  6c 8e 70

            hex 19 07 8c c0 00 b5 8c 84 ; 080E7:  19 07 8c c0 00 b5 8c 84
            hex ad bb b3 68 e9 7c cf    ; 080EF:  ad bb b3 68 e9 7c cf

            php                         ; 080F6:  08
            jmp ($0a3c)                 ; 080F7:  6c 3c 0a

            hex 5c b5 8c 34 ae bb b3 69 ; 080FA:  5c b5 8c 34 ae bb b3 69
            hex e9 bd cb 08 66 0c 7c b3 ; 08102:  e9 bd cb 08 66 0c 7c b3
            hex 09 56 b5 8c 70 ae bb b3 ; 0810A:  09 56 b5 8c 70 ae bb b3
            hex 69 e9 bd cb 08 66 0c 8f ; 08112:  69 e9 bd cb 08 66 0c 8f
            hex 12 b3 08 56 b5 8c 8e ae ; 0811A:  12 b3 08 56 b5 8c 8e ae
            hex bb b3                   ; 08122:  bb b3

            adc #$e9                    ; 08124:  69 e9
            lda $08cb,x                 ; 08126:  bd cb 08
            jmp ($8f0c)                 ; 08129:  6c 0c 8f

            hex 18 b3 07 5c b5 8c ac ae ; 0812C:  18 b3 07 5c b5 8c ac ae
            hex bb b3 69 e9 bd cb 08 cf ; 08134:  bb b3 69 e9 bd cb 08 cf

            jsr $e823                   ; 0813C:  20 23 e8
            cmp ($ff),y                 ; 0813F:  d1 ff
            rti                         ; 08141:  40

            hex 85 d7 81 d7 d2 8c 1e b5 ; 08142:  85 d7 81 d7 d2 8c 1e b5
            hex bb b0 b3 87 d7 e9 8b cf ; 0814A:  bb b0 b3 87 d7 e9 8b cf
            hex 04 81 d7 d0 85 d7 81 d7 ; 08152:  04 81 d7 d0 85 d7 81 d7
            hex 54 c6 d7 44 81 aa 5b 6f ; 0815A:  54 c6 d7 44 81 aa 5b 6f
            hex e9 cd d7 02 76 d3 d7 e8 ; 08162:  e9 cd d7 02 76 d3 d7 e8
            hex 81 aa 5b 6f e9 66 dc 02 ; 0816A:  81 aa 5b 6f e9 66 dc 02
            hex d2 d2 8c d0 bb bb 85 d5 ; 08172:  d2 d2 8c d0 bb bb 85 d5
            hex 64 de d1 ff b3 87 d5 68 ; 0817A:  64 de d1 ff b3 87 d5 68
            hex e9 bd cb 08 de d1 ff 85 ; 08182:  e9 bd cb 08 de d1 ff 85
            hex d5 81 d5 d0 d3 b3 8e f0 ; 0818A:  d5 81 d5 d0 d3 b3 8e f0
            hex 17 81 d5 72 b0 b3 81 d5 ; 08192:  17 81 d5 72 b0 b3 81 d5
            hex d3 b3 e9 7c cf          ; 0819A:  d3 b3 e9 7c cf

            php                         ; 0819F:  08
            rti                         ; 081A0:  40

tab_b2_81a1: ; 437 bytes
            hex 85 d7 aa 5b 6f e9 66 dc ; 081A1:  85 d7 aa 5b 6f e9 66 dc
            hex 02 8b 24 b5 8c 44 b1 bb ; 081A9:  02 8b 24 b5 8c 44 b1 bb
            hex 85 da d6 dd 81 61 de d9 ; 081B1:  85 da d6 dd 81 61 de d9
            hex ff b3 87 da 68 e9 bd cb ; 081B9:  ff b3 87 da 68 e9 bd cb
            hex 08 de dc ff b3 81 d7 b4 ; 081C1:  08 de dc ff b3 81 d7 b4
            hex bb b3 a0 d9 ff 8f 24 d4 ; 081C9:  bb b3 a0 d9 ff 8f 24 d4
            hex 81 d7 d0 85 d7 d1 81 da ; 081D1:  81 d7 d0 85 d7 d1 81 da
            hex d0 85 da d1 81 d7 8b 24 ; 081D9:  d0 85 da d1 81 d7 8b 24
            hex c6 d7 b6 81 d6 18 82 de ; 081E1:  c6 d7 b6 81 d6 18 82 de
            hex dc ff b3 e9 86 80 02 40 ; 081E9:  dc ff b3 e9 86 80 02 40
            hex 85 d7 de dc ff 85 da d6 ; 081F1:  85 d7 de dc ff 85 da d6
            hex 10 82 8d 24 81 da b4 b3 ; 081F9:  10 82 8d 24 81 da b4 b3
            hex d3 bb d4 81 d7 d0 85 d7 ; 08201:  d3 bb d4 81 d7 d0 85 d7
            hex d1 81 da d0 85 da d1 81 ; 08209:  d1 81 da d0 85 da d1 81
            hex d7 8b 24 c6 d7 fb 81 68 ; 08211:  d7 8b 24 c6 d7 fb 81 68
            hex de dc ff b3 0d 75 b3 0c ; 08219:  de dc ff b3 0d 75 b3 0c
            hex 75 b3 3d 3c e9 54 cc 0c ; 08221:  75 b3 3d 3c e9 54 cc 0c
            hex cf 20 23 e8 fe ff 8e 26 ; 08229:  cf 20 23 e8 fe ff 8e 26
            hex b5 e9 c4 ce 02 61 e9 9d ; 08231:  b5 e9 c4 ce 02 61 e9 9d
            hex d2 02 ac 87 d2 2b 8b 40 ; 08239:  d2 02 ac 87 d2 2b 8b 40
            hex c1 d8 4d 82 0b 8c 80 00 ; 08241:  c1 d8 4d 82 0b 8c 80 00
            hex c1 d7 3b 82 60 e9 9d d2 ; 08249:  c1 d7 3b 82 60 e9 9d d2
            hex 02 0b 8b 40 c0 d8 63 82 ; 08251:  02 0b 8b 40 c0 d8 63 82
            hex 8d 59 e9 81 ce 02 41 d6 ; 08259:  8d 59 e9 81 ce 02 41 d6
            hex 6a 82 8d 4e e9 81 ce 02 ; 08261:  6a 82 8d 4e e9 81 ce 02
            hex 40 2b ac 09 d3 0b cf 20 ; 08269:  40 2b ac 09 d3 0b cf 20
            hex 23 e8 00 00 0c a8 f5 7b ; 08271:  23 e8 00 00 0c a8 f5 7b
            hex 0d a8 f7 7b cf 20 23 e8 ; 08279:  0d a8 f7 7b cf 20 23 e8
            hex 00 00 0c 56 b5 8c 7d 6f ; 08281:  00 00 0c 56 b5 8c 7d 6f
            hex bb cf 20 23 e8 00 00 0c ; 08289:  bb cf 20 23 e8 00 00 0c
            hex 55 b5 1d bb 8c d0 6f bb ; 08291:  55 b5 1d bb 8c d0 6f bb
            hex cf 20 23 e8 00 00 0c 55 ; 08299:  cf 20 23 e8 00 00 0c 55
            hex b5 1d bb 8c da 6f bb cf ; 082A1:  b5 1d bb 8c da 6f bb cf
            hex 20 23 e8 00 00 aa e4 7b ; 082A9:  20 23 e8 00 00 aa e4 7b
            hex aa e8 7b e9 8b 82 04 cf ; 082B1:  aa e8 7b e9 8b 82 04 cf
            hex 20 23 e8 00 00 aa e4 7b ; 082B9:  20 23 e8 00 00 aa e4 7b
            hex aa e8 7b e9 9a 82 04 cf ; 082C1:  aa e8 7b e9 9a 82 04 cf
            hex 20 23 e8 00 00 0d d2 b3 ; 082C9:  20 23 e8 00 00 0d d2 b3
            hex 0c 5a b5 b4 bb 8c bc 6f ; 082D1:  0c 5a b5 b4 bb 8c bc 6f
            hex bb cf 20 23 e8 00 00 0c ; 082D9:  bb cf 20 23 e8 00 00 0c
            hex 5a c8 d7 ec 82 0d 54 c8 ; 082E1:  5a c8 d7 ec 82 0d 54 c8
            hex d8 ee 82 41 cf 3d 3c e9 ; 082E9:  d8 ee 82 41 cf 3d 3c e9
            hex 88 dc 04 1e da d7 fd 82 ; 082F1:  88 dc 04 1e da d7 fd 82
            hex 41 d6 fe 82 40 cf 20 23 ; 082F9:  41 d6 fe 82 40 cf 20 23
            hex e8 00 00 a4 5f 6f 8b 32 ; 08301:  e8 00 00 a4 5f 6f 8b 32
            hex c0 cf 20 23 e8 f8 ff 40 ; 08309:  c0 cf 20 23 e8 f8 ff 40
            hex 28 38 e9 7e 82 02 74 b0 ; 08311:  28 38 e9 7e 82 02 74 b0
            hex 2b 0b 8b 1e b6 2a 0b 8b ; 08319:  2b 0b 8b 1e b6 2a 0b 8b
            hex 1e b9 29 39 08 d2 1d bb ; 08321:  1e b9 29 39 08 d2 1d bb
            hex b4 b3 b0 bb b1 8b 1e c9 ; 08329:  b4 b3 b0 bb b1 8b 1e c9
            hex d8 42 83 8d 1e 08 d2 1d ; 08331:  d8 42 83 8d 1e 08 d2 1d
            hex bb b4 b3 b0 bc b1 0a d0 ; 08339:  bb b4 b3 b0 bc b1 0a d0
            hex 2a 3a 08 d2 1c bb b0 b4 ; 08341:  2a 3a 08 d2 1c bb b0 b4
            hex b3 b0 bc b1 50 c3 d8 5a ; 08349:  b3 b0 bc b1 50 c3 d8 5a
            hex 83 08 d2 1c bb          ; 08351:  83 08 d2 1c bb

            bcs tab_b2_81a1+362         ; 08356:  b0 b3
            rti                         ; 08358:  40

            hex b1 61 38 e9 8a 8b 04 08 ; 08359:  b1 61 38 e9 8a 8b 04 08
            hex d0 28 08 52 c6 d7 12 83 ; 08361:  d0 28 08 52 c6 d7 12 83
            hex cf 20 23 e8 fc ff 3c e9 ; 08369:  cf 20 23 e8 fc ff 3c e9
            hex 7e 82 02 74 b0 2b 5f b8 ; 08371:  7e 82 02 74 b0 2b 5f b8
            hex 2a 0b 5f ba d8 83 83 0a ; 08379:  2a 0b 5f ba d8 83 83 0a
            hex d0 2a 3c e9 7e 82 02 72 ; 08381:  d0 2a 3c e9 7e 82 02 72
            hex b0 b3 0a b4 c7 cf 20 23 ; 08389:  b0 b3 0a b4 c7 cf 20 23
            hex e8 00 00 0c d7 9e 83 a4 ; 08391:  e8 00 00 0c d7 9e 83 a4
            hex 5f 6f d6 a1 83 a4 63 6f ; 08399:  5f 6f d6 a1 83 a4 63 6f
            hex cf 20 23 e8 00 00 3d 0c ; 083A1:  cf 20 23 e8 00 00 3d 0c
            hex b0 51 da d2 b3 0d b0 d0 ; 083A9:  b0 51 da d2 b3 0d b0 d0
            hex d2 d2 b4 bb b1 3c a4 fe ; 083B1:  d2 d2 b4 bb b1 3c a4 fe
            hex 6f 53 b5 b3 0c b0 b4 bc ; 083B9:  6f 53 b5 b3 0c b0 b4 bc
            hex d2 d2 7a b1 cf 20 23 e8 ; 083C1:  d2 d2 7a b1 cf 20 23 e8
            hex fe ff 45 2b 3d 3c e9 88 ; 083C9:  fe ff 45 2b 3d 3c e9 88
            hex dc 04 8c fe 00 da d9 06 ; 083D1:  dc 04 8c fe 00 da d9 06
            hex 00 04 00 00 84 08 00 fa ; 083D9:  00 04 00 00 84 08 00 fa
            hex 83 10 00 f7 83 20 00 f4 ; 083E1:  83 10 00 f7 83 20 00 f4
            hex 83 40 00 03 84 80 00 fd ; 083E9:  83 40 00 03 84 80 00 fd
            hex 83 03 84 0b d1 2b 0b d1 ; 083F1:  83 03 84 0b d1 2b 0b d1
            hex 2b 0b d1 2b 0b d1 2b 0b ; 083F9:  2b 0b d1 2b 0b d1 2b 0b
            hex d1 2b 0b 54 bd 8c 1e b1 ; 08401:  d1 2b 0b 54 bd 8c 1e b1
            hex bb cf 20 23 e8 fa ff aa ; 08409:  bb cf 20 23 e8 fa ff aa
            hex f5 7b e9 0e 96 02 d7 1b ; 08411:  f5 7b e9 0e 96 02 d7 1b
            hex 84 cf 0c 51 c0 d8 67 84 ; 08419:  84 cf 0c 51 c0 d8 67 84
            hex a4 f5 7b 2a a4 f7 7b 29 ; 08421:  a4 f5 7b 2a a4 f7 7b 29
            hex de fa ff b3 de fc ff b3 ; 08429:  de fa ff b3 de fc ff b3
            hex e9 a2 83 04             ; 08431:  e9 a2 83 04

            eor ($2b,x)                 ; 08435:  41 2b
            rts                         ; 08437:  60

            hex 60 09 53 bd d1 b3 0a 53 ; 08438:  60 09 53 bd d1 b3 0a 53
            hex bd b3 3b 63 e9 26 f2 0c ; 08440:  bd b3 3b 63 e9 26 f2 0c
            hex 0a d0 2a 53 da 52 c0 d8 ; 08448:  0a d0 2a 53 da 52 c0 d8
            hex 5a 84 44 cd 0a bc 2a 09 ; 08450:  5a 84 44 cd 0a bc 2a 09
            hex d0 29 0b d0 2b 0b 8b 10 ; 08458:  d0 29 0b d0 2b 0b 8b 10
            hex c3 d7 37 84 d6 81 84 41 ; 08460:  c3 d7 37 84 d6 81 84 41
            hex 2b 62 60 8e f8 00 8e f8 ; 08468:  2b 62 60 8e f8 00 8e f8
            hex 00 3b 63 e9 26 f2 0c 0b ; 08470:  00 3b 63 e9 26 f2 0c 0b
            hex d0 2b 0b 8b 10 c3 d7 69 ; 08478:  d0 2b 0b 8b 10 c3 d7 69
            hex 84 8d 13 e9 26 f2 02 cf ; 08480:  84 8d 13 e9 26 f2 02 cf
            hex 20 23 e8 fe ff ac 4e d1 ; 08488:  20 23 e8 fe ff ac 4e d1
            hex d9 0a 00 01 00 d1 84 02 ; 08490:  d9 0a 00 01 00 d1 84 02
            hex 00 d6 84 10 00 c7 84 20 ; 08498:  00 d6 84 10 00 c7 84 20
            hex 00 cc 84 40 00 bd 84 50 ; 084A0:  00 cc 84 40 00 bd 84 50
            hex 00 bd 84 60 00 bd 84 80 ; 084A8:  00 bd 84 60 00 bd 84 80
            hex 00 c2 84 90 00 c2 84 a0 ; 084B0:  00 c2 84 90 00 c2 84 a0
            hex 00 c2 84 f3 84 89 34 2b ; 084B8:  00 c2 84 f3 84 89 34 2b
            hex 0b cf 89 36 d6 bf 84 89 ; 084C0:  0b cf 89 36 d6 bf 84 89
            hex 38 d6 bf 84 89 32 d6 bf ; 084C8:  38 d6 bf 84 89 32 d6 bf
            hex 84 89 30 d6 bf 84 60 e9 ; 084D0:  84 89 30 d6 bf 84 60 e9
            hex 0e 96 02 d8 e2          ; 084D8:  0e 96 02 d8 e2

            sty $65                     ; 084DD:  84 65
            dec $ef,x                   ; 084DF:  d6 ef
            sty $65                     ; 084E1:  84 65
            sbc #$0e                    ; 084E3:  e9 0e
            stx ptr1_lo,y                   ; 084E5:  96 02
            cld                         ; 084E7:  d8
            inc $6a84                   ; 084E8:  ee 84 6a
            dec $ef,x                   ; 084EB:  d6 ef
            sty $60                     ; 084ED:  84 60
            sbc #$be                    ; 084EF:  e9 be
            sta ptr1_lo,x                   ; 084F1:  95 02
            rti                         ; 084F3:  40

            hex d6 bf 84 20 23 e8 fc ff ; 084F4:  d6 bf 84 20 23 e8 fc ff
            hex 0e 54 c6 d8 22 85 0e d5 ; 084FC:  0e 54 c6 d8 22 85 0e d5
            hex 00 00 04 00 19 85 12 85 ; 08504:  00 00 04 00 19 85 12 85
            hex 2c 85 35 85 3b 85 0c b0 ; 0850C:  2c 85 35 85 3b 85 0c b0
            hex 2b 0d b0 d0 2a 3a 3b e9 ; 08514:  2b 0d b0 d0 2a 3a 3b e9
            hex 11 8f 04 d7             ; 0851C:  11 8f 04 d7

            bit clock_b_hi                     ; 08520:  24 85
            rti                         ; 08522:  40

            hex cf 3c 0b b1 3d 0a b1 41 ; 08523:  cf 3c 0b b1 3d 0a b1 41
            hex cf 0c b0 d1 2b 0d b0 d6 ; 0852B:  cf 0c b0 d1 2b 0d b0 d6
            hex 18 85 0c b0 d0 d6 2f 85 ; 08533:  18 85 0c b0 d0 d6 2f 85
            hex 0c b0 2b 0d b0 d1 d6 18 ; 0853B:  0c b0 2b 0d b0 d1 d6 18
            hex 85 20 23 e8 00 00 0e 8b ; 08543:  85 20 23 e8 00 00 0e 8b
            hex 30 c1 d8 5f 85 0e 8f d0 ; 0854B:  30 c1 d8 5f 85 0e 8f d0
            hex 51 be d1 2e 3e 3d 3c e9 ; 08553:  51 be d1 2e 3e 3d 3c e9
            hex f7 84 06 cf 40 cf 20 23 ; 0855B:  f7 84 06 cf 40 cf 20 23
            hex e8 fc ff 3d 3c e9 70 82 ; 08563:  e8 fc ff 3d 3c e9 70 82
            hex 04 61 e9 0b             ; 0856B:  04 61 e9 0b

            sty ptr1_lo                     ; 0856F:  84 02
            rti                         ; 08571:  40

            hex 2a ac 88 84 2b d7 84 85 ; 08572:  2a ac 88 84 2b d7 84 85
            hex 0a d0 2a 0a 8b 64 c6 d7 ; 0857A:  0a d0 2a 0a 8b 64 c6 d7
            hex 73 85 60 e9 0b 84 02 0b ; 08582:  73 85 60 e9 0b 84 02 0b
            hex d8 8f 85 0b cf 40 2a ac ; 0858A:  d8 8f 85 0b cf 40 2a ac
            hex 88 84 2b d8 9a 85 0b cf ; 08592:  88 84 2b d8 9a 85 0b cf
            hex 0a d0 2a 0a 8b 64 c6 d7 ; 0859A:  0a d0 2a 0a 8b 64 c6 d7
            hex 91 85 d6 6c 85 20 23 e8 ; 085A2:  91 85 d6 6c 85 20 23 e8
            hex fa ff ac 4e d1 2b d9 06 ; 085AA:  fa ff ac 4e d1 2b d9 06
            hex 00 01 00 00 86 02 00 00 ; 085B2:  00 01 00 00 86 02 00 00
            hex 86 10 00 00 86 20 00 00 ; 085BA:  86 10 00 00 86 20 00 00
            hex 86 40 00 cd 85 80 00 02 ; 085C2:  86 40 00 cd 85 80 00 02
            hex 86 fe 85 60 e9 0e 96 02 ; 085CA:  86 fe 85 60 e9 0e 96 02
            hex d7 fe 85 60 e9 9d d2 02 ; 085D2:  d7 fe 85 60 e9 9d d2 02
            hex a4 cd 7f 2a a4 cf 7f 29 ; 085DA:  a4 cd 7f 2a a4 cf 7f 29
            hex 65 e9 0e 96 02 d7 ee 85 ; 085E2:  65 e9 0e 96 02 d7 ee 85
            hex 65 d6 ef 85 60 e9 be 95 ; 085EA:  65 d6 ef 85 60 e9 be 95
            hex 02 39 3a e9 7b cc 04 62 ; 085F2:  02 39 3a e9 7b cc 04 62
            hex e9 9d d2 02 40 2b 0b cf ; 085FA:  e9 9d d2 02 40 2b 0b cf
            hex 6a e9 0e 96 02 d7 fe 85 ; 08602:  6a e9 0e 96 02 d7 fe 85
            hex 60 e9 9d d2 02 a4 cd 7f ; 0860A:  60 e9 9d d2 02 a4 cd 7f
            hex 2a a4 cf 7f 29 65 e9 0e ; 08612:  2a a4 cf 7f 29 65 e9 0e
            hex 96 02 d8 ea 85 6a d6 ef ; 0861A:  96 02 d8 ea 85 6a d6 ef
            hex 85 20 23 e8 fc ff 3d 3c ; 08622:  85 20 23 e8 fc ff 3d 3c
            hex e9 70 82 04 61 e9 0b    ; 0862A:  e9 70 82 04 61 e9 0b

            sty ptr1_lo                     ; 08631:  84 02
            rti                         ; 08633:  40

            hex 2a ac a7 85 2b d7 46 86 ; 08634:  2a ac a7 85 2b d7 46 86
            hex 0a d0 2a 0a 8b 64       ; 0863C:  0a d0 2a 0a 8b 64

            dec $d7                     ; 08642:  c6 d7
            and clock_b_lo,x                   ; 08644:  35 86
            rts                         ; 08646:  60

            hex e9 0b 84 02 0b d8 51 86 ; 08647:  e9 0b 84 02 0b d8 51 86
            hex 0b cf 40 2a ac a7 85 2b ; 0864F:  0b cf 40 2a ac a7 85 2b
            hex d8 5c 86 0b cf 0a d0 2a ; 08657:  d8 5c 86 0b cf 0a d0 2a
            hex 0a 8b 64 c6 d7 53 86 d6 ; 0865F:  0a 8b 64 c6 d7 53 86 d6
            hex 2e 86 20 23 e8 fc ff 6a ; 08667:  2e 86 20 23 e8 fc ff 6a
            hex 63 e9 7b cc 04 62 e9 9d ; 0866F:  63 e9 7b cc 04 62 e9 9d
            hex d2 02 40                ; 08677:  d2 02 40

            rol a                       ; 0867A:  2a
            rti                         ; 0867B:  40

            hex 2b 0b d8 83 86 0a cf 3d ; 0867C:  2b 0b d8 83 86 0a cf 3d
            hex 3c e9 23 86 04 d9 04 00 ; 08684:  3c e9 23 86 04 d9 04 00
            hex 01 00 a0 86 02          ; 0868C:  01 00 a0 86 02

            brk                         ; 08691:  00
            hex 9e                      ; 08692:  9e
            stx $10                     ; 08693:  86 10
            brk                         ; 08695:  00
            hex ad                      ; 08696:  ad
            stx $20                     ; 08697:  86 20
            brk                         ; 08699:  00
            hex e2                      ; 0869A:  e2
            stx $7d                     ; 0869B:  86 7d
            stx $44                     ; 0869D:  86 44
            rol a                       ; 0869F:  2a
            rts                         ; 086A0:  60

            hex e9 9d d2 02 41 2b ac 09 ; 086A1:  e9 9d d2 02 41 2b ac 09
            hex d3 d6 7d 86 60 e9 9d d2 ; 086A9:  d3 d6 7d 86 60 e9 9d d2
            hex 02 a4 cf 7f d1 a8 cf 7f ; 086B1:  02 a4 cf 7f d1 a8 cf 7f
            hex 59 c0 d8 c8 86 6f 63 e9 ; 086B9:  59 c0 d8 c8 86 6f 63 e9
            hex 7b cc 04 45 d6 d4 86 0a ; 086C1:  7b cc 04 45 d6 d4 86 0a
            hex d1 d6 d4 86 6a 63 e9 7b ; 086C9:  d1 d6 d4 86 6a 63 e9 7b
            hex cc 04 40 2a 62 e9 9d d2 ; 086D1:  cc 04 40 2a 62 e9 9d d2
            hex 02 62 e9 3e d7 02 d6 7d ; 086D9:  02 62 e9 3e d7 02 d6 7d
            hex 86 60 e9 9d d2 02 a4 cf ; 086E1:  86 60 e9 9d d2 02 a4 cf
            hex 7f d0 a8 cf 7f 8b 10 c0 ; 086E9:  7f d0 a8 cf 7f 8b 10 c0
            hex d7 cd 86 0a d0 d6 d4 86 ; 086F1:  d7 cd 86 0a d0 d6 d4 86
            hex 20 23 e8 fc ff 8d 15 62 ; 086F9:  20 23 e8 fc ff 8d 15 62
            hex e9 7b cc 04 62 e9 9d d2 ; 08701:  e9 7b cc 04 62 e9 9d d2
            hex 02 40                   ; 08709:  02 40

            rol a                       ; 0870B:  2a
            rti                         ; 0870C:  40

            hex 2b 0b d8 19 87 0a 8c 2f ; 0870D:  2b 0b d8 19 87 0a 8c 2f
            hex b5 bb d3 cf 3d 3c e9 23 ; 08715:  b5 bb d3 cf 3d 3c e9 23
            hex 86 04 d9 04 00 01 00 36 ; 0871D:  86 04 d9 04 00 01 00 36
            hex 87 02 00 34 87 10 00 43 ; 08725:  87 02 00 34 87 10 00 43
            hex 87 20 00 7b 87          ; 0872D:  87 20 00 7b 87

            asl $4687                   ; 08732:  0e 87 46
            rol a                       ; 08735:  2a
            rts                         ; 08736:  60

            hex e9 9d d2 02 41 2b ac 09 ; 08737:  e9 9d d2 02 41 2b ac 09
            hex d3 d6 0e 87 60 e9 9d d2 ; 0873F:  d3 d6 0e 87 60 e9 9d d2
            hex 02 a4 cf 7f d1 a8 cf 7f ; 08747:  02 a4 cf 7f d1 a8 cf 7f
            hex 8b 14                   ; 0874F:  8b 14

            cpy #$d8                    ; 08751:  c0 d8
            rts                         ; 08753:  60

            hex 87 8d 1a 62 e9 7b cc 04 ; 08754:  87 8d 1a 62 e9 7b cc 04
            hex 45 d6 6d 87 0a d1 d6 6d ; 0875C:  45 d6 6d 87 0a d1 d6 6d
            hex 87 8d 15 62 e9 7b cc 04 ; 08764:  87 8d 15 62 e9 7b cc 04
            hex 40 2a 62 e9 9d d2 02 62 ; 0876C:  40 2a 62 e9 9d d2 02 62
            hex e9 3e d7 02 d6 0e 87 60 ; 08774:  e9 3e d7 02 d6 0e 87 60
            hex e9 9d d2 02 a4 cf 7f d0 ; 0877C:  e9 9d d2 02 a4 cf 7f d0
            hex a8 cf 7f 8b 1b c0 d7 65 ; 08784:  a8 cf 7f 8b 1b c0 d7 65
            hex 87 0a d0 d6 6d 87 20 23 ; 0878C:  87 0a d0 d6 6d 87 20 23
            hex e8 fe ff 3d 3c 8e 36 b5 ; 08794:  e8 fe ff 3d 3c 8e 36 b5
            hex e9 34 d1 06 3d 3c e9 9d ; 0879C:  e9 34 d1 06 3d 3c e9 9d
            hex d5 04 2b 0b d8 b5 87 0b ; 087A4:  d5 04 2b 0b d8 b5 87 0b
            hex 8b ff c1 d8 b5 87 ac 09 ; 087AC:  8b ff c1 d8 b5 87 ac 09
            hex d3 0b cf 20 23 e8 f6 ff ; 087B4:  d3 0b cf 20 23 e8 f6 ff
            hex 62 3d 3c e9 db 82 06 d8 ; 087BC:  62 3d 3c e9 db 82 06 d8
            hex 21 88 0c 2b 0d 2a de fc ; 087C4:  21 88 0c 2b 0d 2a de fc
            hex ff b3 de fe ff b3 e9 a2 ; 087CC:  ff b3 de fe ff b3 e9 a2
            hex 83 04 3d 3c e9 c6 83 04 ; 087D4:  83 04 3d 3c e9 c6 83 04
            hex 27 62 07 78 b3 0a 73 b3 ; 087DC:  27 62 07 78 b3 0a 73 b3
            hex 0b 73 b3 0a 72 b3 3b e9 ; 087E4:  0b 73 b3 0a 72 b3 3b e9
            hex 54 cc 0c 07 d3 d9 06 00 ; 087EC:  54 cc 0c 07 d3 d9 06 00
            hex 57 00 26 88 63 00 26 88 ; 087F4:  57 00 26 88 63 00 26 88
            hex 73 00 22 88 82 00 22 88 ; 087FC:  73 00 22 88 82 00 22 88
            hex 92 00 0e 88 a2 00 0e 88 ; 08804:  92 00 0e 88 a2 00 0e 88
            hex 10 88 41 28 38 0a 72 b3 ; 0880C:  10 88 41 28 38 0a 72 b3
            hex 0b 72 b3 0a 72 b3 0b d0 ; 08814:  0b 72 b3 0a 72 b3 0b d0
            hex b3 e9 6a cf 0a cf 42 d6 ; 0881C:  b3 e9 6a cf 0a cf 42 d6
            hex 0f 88 43 d6 0f 88 20 23 ; 08824:  0f 88 43 d6 0f 88 20 23
            hex e8 00 00 61 0d 59 b5 8c ; 0882C:  e8 00 00 61 0d 59 b5 8c
            hex e4 6f bb b3 0c 8b 31 b5 ; 08834:  e4 6f bb b3 0c 8b 31 b5
            hex 8c 24 9c bb b3 65 e9 bd ; 0883C:  8c 24 9c bb b3 65 e9 bd
            hex cb 08 63 0d 8b 30 b5 90 ; 08844:  cb 08 63 0d 8b 30 b5 90
            hex 10 15 b3 0c 8b 31 b5 8c ; 0884C:  10 15 b3 0c 8b 31 b5 8c
            hex 25 9c bb b3 65 e9 7c cf ; 08854:  25 9c bb b3 65 e9 7c cf
            hex 08 cf 20 23 e8 fa ff 40 ; 0885C:  08 cf 20 23 e8 fa ff 40
            hex 29 09 d2 d2 7a 2b 62 a4 ; 08864:  29 09 d2 d2 7a 2b 62 a4
            hex fe 6f 53 b5 19 bb 8b 58 ; 0886C:  fe 6f 53 b5 19 bb 8b 58
            hex b5 8c fd 7b bb b3 8d 19 ; 08874:  b5 8c fd 7b bb b3 8d 19
            hex 0b 73 b3 64 3b e9 54 cc ; 0887C:  0b 73 b3 64 3b e9 54 cc
            hex 0c 09 d0 29 09 55 c6 d7 ; 08884:  0c 09 d0 29 09 55 c6 d7
            hex 65 88 63 8e c8 23 a4 fe ; 0888C:  65 88 63 8e c8 23 a4 fe
            hex 6f 8b 30 b5 b3 aa 63 6f ; 08894:  6f 8b 30 b5 b3 aa 63 6f
            hex e9 66 dc 02 8c 90 00 b5 ; 0889C:  e9 66 dc 02 8c 90 00 b5
            hex b4 bb 8c 04 80 bb b3 65 ; 088A4:  b4 bb 8c 04 80 bb b3 65
            hex e9 7c cf 08 a4 fe 6f d8 ; 088AC:  e9 7c cf 08 a4 fe 6f d8
            hex c5 88 62 8e 40 b5 63 6c ; 088B4:  c5 88 62 8e 40 b5 63 6c
            hex 63 6b e9 54 cc 0c d6 d2 ; 088BC:  63 6b e9 54 cc 0c d6 d2
            hex 88 63 6b e9 7b cc 04 8e ; 088C4:  88 63 6b e9 7b cc 04 8e
            hex 44 b5 e9 c4 ce 02 a4 fe ; 088CC:  44 b5 e9 c4 ce 02 a4 fe
            hex 6f 52 c1 d8 eb 88 62 8e ; 088D4:  6f 52 c1 d8 eb 88 62 8e
            hex 42 b5 63 8d 1c 63 8d 1b ; 088DC:  42 b5 63 8d 1c 63 8d 1b
            hex e9 54 cc 0c d6 f9 88 63 ; 088E4:  e9 54 cc 0c d6 f9 88 63
            hex 8d 1b e9 7b cc 04 8e 47 ; 088EC:  8d 1b e9 7b cc 04 8e 47
            hex b5 e9 c4 ce 02 61 66 68 ; 088F4:  b5 e9 c4 ce 02 61 66 68
            hex 63 62 e9 6a cf 0a cf 20 ; 088FC:  63 62 e9 6a cf 0a cf 20
            hex 23 e8 f4 ff 40          ; 08904:  23 e8 f4 ff 40

            rol a                       ; 08909:  2a
            rti                         ; 0890A:  40

tab_b2_890b: ; 154 bytes
            hex 2b 62 3a 3b e9 db 82 06 ; 0890B:  2b 62 3a 3b e9 db 82 06
            hex d8 1f 89 3a 3b e9 c6 83 ; 08913:  d8 1f 89 3a 3b e9 c6 83
            hex 04 d6 22 89 8a 4a b5 26 ; 0891B:  04 d6 22 89 8a 4a b5 26
            hex 0a d2 d2 27 0b 51 da d8 ; 08923:  0a d2 d2 27 0b 51 da d8
            hex 32 89 42 cd 07 bb 27 40 ; 0892B:  32 89 42 cd 07 bb 27 40
            hex 29 40 28 07 d2 d2 b3 0b ; 08933:  29 40 28 07 d2 d2 b3 0b
            hex 8b 58 b5 b4 bb 18 bb 8c ; 0893B:  8b 58 b5 b4 bb 18 bb 8c
            hex fd 7b bb b3 06 d0 26 d1 ; 08943:  fd 7b bb b3 06 d0 26 d1
            hex d3 d4 08 d0 28 08 54 c6 ; 0894B:  d3 d4 08 d0 28 08 54 c6
            hex d7 36 89 09 d0 29 d1 07 ; 08953:  d7 36 89 09 d0 29 d1 07
            hex d0 27 d1 09 54 c6 d7 34 ; 0895B:  d0 27 d1 09 54 c6 d7 34
            hex 89 0b d0 2b 0b 5b c6 d7 ; 08963:  89 0b d0 2b 0b 5b c6 d7
            hex 0c 89 0a d0 2a 0a 55 c6 ; 0896B:  0c 89 0a d0 2a 0a 55 c6
            hex d7 0a 89 cf 20 23 e8 fe ; 08973:  d7 0a 89 cf 20 23 e8 fe
            hex ff 61 e9 35 cc 02 40 2b ; 0897B:  ff 61 e9 35 cc 02 40 2b
            hex 0b 8c 5a b5 bb d3 b3 3b ; 08983:  0b 8c 5a b5 bb d3 b3 3b
            hex e9 8b cf 04 0b d0 2b 0b ; 0898B:  e9 8b cf 04 0b d0 2b 0b
            hex 8b 10 c6 d7 83 89 8d 61 ; 08993:  8b 10 c6 d7 83 89 8d 61
            hex 8e 70 15 8e 6e 9f 64 e9 ; 0899B:  8e 70 15 8e 6e 9f 64 e9
            hex 7c cf                   ; 089A3:  7c cf

            php                         ; 089A5:  08
            rts                         ; 089A6:  60

tab_b2_89a7: ; 439 bytes
            hex ac ff 82 d8 b3 89 a4 eb ; 089A7:  ac ff 82 d8 b3 89 a4 eb
            hex 7f d6 bb 89 ac 7e d7 b3 ; 089AF:  7f d6 bb 89 ac 7e d7 b3
            hex e9 66 dc 02 b3 e9 2a 88 ; 089B7:  e9 66 dc 02 b3 e9 2a 88
            hex 04 61 aa 63 6f e9 72 d7 ; 089BF:  04 61 aa 63 6f e9 72 d7
            hex 02 b3 e9 66 dc 02 b3 e9 ; 089C7:  02 b3 e9 66 dc 02 b3 e9
            hex 2a 88 04 40 a8 fe 6f ac ; 089CF:  2a 88 04 40 a8 fe 6f ac
            hex 5e 88 60 e9 35 cc 02 cf ; 089D7:  5e 88 60 e9 35 cc 02 cf
            hex 20 23 e8 f6 ff 3d 3c e9 ; 089DF:  20 23 e8 f6 ff 3d 3c e9
            hex 8b 82 04 d3 29 3d 3c e9 ; 089E7:  8b 82 04 d3 29 3d 3c e9
            hex 9a 82 04 d3 28 09 5a c8 ; 089EF:  9a 82 04 d3 28 09 5a c8
            hex d7 00 8a 08 54 c8 d8 01 ; 089F7:  d7 00 8a 08 54 c8 d8 01
            hex 8a cf 39 e9 0e 96 02 d7 ; 089FF:  8a cf 39 e9 0e 96 02 d7
            hex 11 8a 39 e9 be 95 02 d6 ; 08A07:  11 8a 39 e9 be 95 02 d6
            hex 24 8b de f8 ff b3 de fa ; 08A0F:  24 8b de f8 ff b3 de fa
            hex ff b3 e9 a2 83 04 0d d8 ; 08A17:  ff b3 e9 a2 83 04 0d d8
            hex 2e 8a 0c 59 b5 8c e5 6f ; 08A1F:  2e 8a 0c 59 b5 8c e5 6f
            hex bb b3 0d 79 d6 47 8a 0c ; 08A27:  bb b3 0d 79 d6 47 8a 0c
            hex 59 b5 8c e5 6f bb b3 3c ; 08A2F:  59 b5 8c e5 6f bb b3 3c
            hex e9 e5 d9 02 d8 44 8a 8a ; 08A37:  e9 e5 d9 02 d8 44 8a 8a
            hex b2 00 d6 47 8a 8a b3 00 ; 08A3F:  b2 00 d6 47 8a 8a b3 00
            hex d4 8e 0f 27 3d 3c e9 c9 ; 08A47:  d4 8e 0f 27 3d 3c e9 c9
            hex 82 04 b0 b3 e9 5e cb 04 ; 08A4F:  82 04 b0 b3 e9 5e cb 04
            hex 2b 40 27 0b 8c e8 03 b8 ; 08A57:  2b 40 27 0b 8c e8 03 b8
            hex 2a d7 6f 8a 0c 59 b5 8c ; 08A5F:  2a d7 6f 8a 0c 59 b5 8c
            hex e9 6f bb b3 41 d6 7b 8a ; 08A67:  e9 6f bb b3 41 d6 7b 8a
            hex 41 27 0c 59 b5 8c e9 6f ; 08A6F:  41 27 0c 59 b5 8c e9 6f
            hex bb b3 0a 78 d4 0b 8c e8 ; 08A77:  bb b3 0a 78 d4 0b 8c e8
            hex 03 ba 2b 0b 8b 64 b8 2a ; 08A7F:  03 ba 2b 0b 8b 64 b8 2a
            hex d7 9e 8a 0c 59 b5 8c ea ; 08A87:  d7 9e 8a 0c 59 b5 8c ea
            hex 6f bb b3 07 d7 9a 8a 41 ; 08A8F:  6f bb b3 07 d7 9a 8a 41
            hex d6 aa 8a 48 d6 aa 8a 41 ; 08A97:  d6 aa 8a 48 d6 aa 8a 41
            hex 27 0c 59 b5 8c ea 6f bb ; 08A9F:  27 0c 59 b5 8c ea 6f bb
            hex b3 0a 78 d4 0b 8b 64 ba ; 08AA7:  b3 0a 78 d4 0b 8b 64 ba
            hex 2b 0b 5a b8 2a d7 cb 8a ; 08AAF:  2b 0b 5a b8 2a d7 cb 8a
            hex 0c 59 b5 8c eb 6f bb b3 ; 08AB7:  0c 59 b5 8c eb 6f bb b3
            hex 07 d7 c7 8a 41 d6 d5 8a ; 08ABF:  07 d7 c7 8a 41 d6 d5 8a
            hex 48 d6 d5 8a 0c 59 b5 8c ; 08AC7:  48 d6 d5 8a 0c 59 b5 8c
            hex eb 6f bb b3 0a 78 d4 0b ; 08ACF:  eb 6f bb b3 0a 78 d4 0b
            hex 5a ba 2a d7 e9 8a 0c 59 ; 08AD7:  5a ba 2a d7 e9 8a 0c 59
            hex b5 8c ec 6f bb b3 48 d6 ; 08ADF:  b5 8c ec 6f bb b3 48 d6
            hex f3 8a 0c 59 b5 8c ec 6f ; 08AE7:  f3 8a 0c 59 b5 8c ec 6f
            hex bb b3 0a 78 d4 0c 59 b5 ; 08AEF:  bb b3 0a 78 d4 0c 59 b5
            hex 8c e4 6f bb d3 b3 08 72 ; 08AF7:  8c e4 6f bb d3 b3 08 72
            hex b3 09 72 b3 08 72 b3 09 ; 08AFF:  b3 09 72 b3 08 72 b3 09
            hex d0 b3 e9 6a cf 0a 62 0c ; 08B07:  d0 b3 e9 6a cf 0a 62 0c
            hex 59 b5 8c e5 6f bb b3 08 ; 08B0F:  59 b5 8c e5 6f bb b3 08
            hex 73 b3 09 73 b3 08 72 b3 ; 08B17:  73 b3 09 73 b3 08 72 b3
            hex 39 e9 54 cc 0c cf 20 23 ; 08B1F:  39 e9 54 cc 0c cf 20 23
            hex e8 00 00 3c e9 0e 96 02 ; 08B27:  e8 00 00 3c e9 0e 96 02
            hex d8 38 8b 3d 3c e9 b7 87 ; 08B2F:  d8 38 8b 3d 3c e9 b7 87
            hex 04 cf 20 23 e8 00 00 65 ; 08B37:  04 cf 20 23 e8 00 00 65
            hex 62 e9 7b cc 04 ac 77 d6 ; 08B3F:  62 e9 7b cc 04 ac 77 d6
            hex 6a e9 81 ce 02 ac 87 d6 ; 08B47:  6a e9 81 ce 02 ac 87 d6
            hex 3c 8e 6a b5 e9 34 d1 04 ; 08B4F:  3c 8e 6a b5 e9 34 d1 04
            hex cf 20 23 e8 fa ff 40    ; 08B57:  cf 20 23 e8 fa ff 40

            rol a                       ; 08B5E:  2a
            rti                         ; 08B5F:  40

tab_b2_8b60: ; 889 bytes
            hex 29 39 3a e9 8b 82 04 d3 ; 08B60:  29 39 3a e9 8b 82 04 d3
            hex 2b 3b e9 0e 96 02 d8 77 ; 08B68:  2b 3b e9 0e 96 02 d8 77
            hex 8b 39 3a e9 df 89 04 09 ; 08B70:  8b 39 3a e9 df 89 04 09
            hex d0 29 09 55 c6 d7 61 8b ; 08B78:  d0 29 09 55 c6 d7 61 8b
            hex 0a d0 2a 0a 52 c6 d7 5f ; 08B80:  0a d0 2a 0a 52 c6 d7 5f
            hex 8b cf 20 23 e8 fa ff a4 ; 08B88:  8b cf 20 23 e8 fa ff a4
            hex fb 7b 52 c0 d8 d7 8b a4 ; 08B90:  fb 7b 52 c0 d8 d7 8b a4
            hex cd 7f 2b a4 cf 7f 2a 0c ; 08B98:  cd 7f 2b a4 cf 7f 2a 0c
            hex d8 a7 8b 49 d6 a8 8b 4f ; 08BA0:  d8 a7 8b 49 d6 a8 8b 4f
            hex 1d bb b3 66 e9 7b cc 04 ; 08BA8:  1d bb b3 66 e9 7b cc 04
            hex 0d d9 03 00 00 00 c2 8b ; 08BB0:  0d d9 03 00 00 00 c2 8b
            hex 01 00 d8 8b 02 00 e1 8b ; 08BB8:  01 00 d8 8b 02 00 e1 8b
            hex c9 8b 3c e9 7e 82 02 b0 ; 08BC0:  c9 8b 3c e9 7e 82 02 b0
            hex 29 39 8e 74 b5 e9 34 d1 ; 08BC8:  29 39 8e 74 b5 e9 34 d1
            hex 04 3a 3b e9 7b cc 04 cf ; 08BD0:  04 3a 3b e9 7b cc 04 cf
            hex 3c e9 7e 82 02 72 d6 c7 ; 08BD8:  3c e9 7e 82 02 72 d6 c7
            hex 8b 3c e9 7e 82 02 74 d6 ; 08BE0:  8b 3c e9 7e 82 02 74 d6
            hex c7 8b 20 23 e8 fe ff a4 ; 08BE8:  c7 8b 20 23 e8 fe ff a4
            hex fb 7b 52 c0 d8 f8 8b cf ; 08BF0:  fb 7b 52 c0 d8 f8 8b cf
            hex ac f9 d2 41 2b 0b d7 1d ; 08BF8:  ac f9 d2 41 2b 0b d7 1d
            hex 8c 6e 62 e9 7b cc 04 ac ; 08C00:  8c 6e 62 e9 7b cc 04 ac
            hex ff 82 d8 17 8c aa 63 6f ; 08C08:  ff 82 d8 17 8c aa 63 6f
            hex e9 78 de 02 d6 30 8c ac ; 08C10:  e9 78 de 02 d6 30 8c ac
            hex 7e d7 d6 2a 8c 68 62 e9 ; 08C18:  7e d7 d6 2a 8c 68 62 e9
            hex 7b cc 04 aa 63 6f e9 72 ; 08C20:  7b cc 04 aa 63 6f e9 72
            hex d7 02 59 b5 8c a8 77 bb ; 08C28:  d7 02 59 b5 8c a8 77 bb
            hex b3 e9 c4 ce 02 3b e9 7e ; 08C30:  b3 e9 c4 ce 02 3b e9 7e
            hex 82 02 74 b0 b3 3b e9 7e ; 08C38:  82 02 74 b0 b3 3b e9 7e
            hex 82 02 72 b0 b3 3b e9 7e ; 08C40:  82 02 72 b0 b3 3b e9 7e
            hex 82 02 b0 b3 8e 78 b5 e9 ; 08C48:  82 02 b0 b3 8e 78 b5 e9
            hex 34 d1 08 0b d1 2b 0b 50 ; 08C50:  34 d1 08 0b d1 2b 0b 50
            hex c5 d7 fd 8b 42 a8 fb 7b ; 08C58:  c5 d7 fd 8b 42 a8 fb 7b
            hex cf 20 23 e8 fa ff 3c e9 ; 08C60:  cf 20 23 e8 fa ff 3c e9
            hex 8f 83 02 8b 1a b5 8c 13 ; 08C68:  8f 83 02 8b 1a b5 8c 13
            hex 70 bb 2a 3c e9 8f 83 02 ; 08C70:  70 bb 2a 3c e9 8f 83 02
            hex b3 e9 da d7 02 2b 3c e9 ; 08C78:  b3 e9 da d7 02 2b 3c e9
            hex 7e 82 02 29 46 a8 cf 7f ; 08C80:  7e 82 02 29 46 a8 cf 7f
            hex 0c d0 5c b5 a8 cd 7f a4 ; 08C88:  0c d0 5c b5 a8 cd 7f a4
            hex cf 7f d5 fa ff 0c 00 12 ; 08C90:  cf 7f d5 fa ff 0c 00 12
            hex 8d b1 8c b1 8c b1 8c b1 ; 08C98:  8d b1 8c b1 8c b1 8c b1
            hex 8c b1 8c b1 8c e7 8c e7 ; 08CA0:  8c b1 8c b1 8c e7 8c e7
            hex 8c e7 8c f4 8c f4 8c f4 ; 08CA8:  8c e7 8c f4 8c f4 8c f4
            hex 8c ac ff 82 d8 bb 8c 0c ; 08CB0:  8c ac ff 82 d8 bb 8c 0c
            hex d8 e1 8c 0b d0 2b d1 d3 ; 08CB8:  d8 e1 8c 0b d0 2b d1 d3
            hex b3 8e 91 b5 e9 34 d1 04 ; 08CC0:  b3 8e 91 b5 e9 34 d1 04
            hex d6 12 8d ac ff 82 d7 38 ; 08CC8:  d6 12 8d ac ff 82 d7 38
            hex 8d ac 7e d7 a8 5b 6f 8d ; 08CD0:  8d ac 7e d7 a8 5b 6f 8d
            hex 14 6c e9 3c 81 04 d6 38 ; 08CD8:  14 6c e9 3c 81 04 d6 38
            hex 8d 8e 95 b5 d6 0e 8d 09 ; 08CE0:  8d 8e 95 b5 d6 0e 8d 09
            hex 72 29 8f fe b0 b3 8e 9a ; 08CE8:  72 29 8f fe b0 b3 8e 9a
            hex b5 d6 c4 8c ac ff 82 d8 ; 08CF0:  b5 d6 c4 8c ac ff 82 d8
            hex fe 8c 0c d8 0b 8d 0a 72 ; 08CF8:  fe 8c 0c d8 0b 8d 0a 72
            hex 2a 8f fe b0 b3 8e 9e b5 ; 08D00:  2a 8f fe b0 b3 8e 9e b5
            hex d6 c4 8c 8e a2 b5 e9 c4 ; 08D08:  d6 c4 8c 8e a2 b5 e9 c4
            hex ce 02 a4 cf 7f d0 a8 cf ; 08D10:  ce 02 a4 cf 7f d0 a8 cf
            hex 7f a4 cf 7f 8b 12 c6 d7 ; 08D18:  7f a4 cf 7f 8b 12 c6 d7
            hex 88 8c 0c d8 cb 8c aa 63 ; 08D20:  88 8c 0c d8 cb 8c aa 63
            hex 6f e9 72 d7 02 a8 5b 6f ; 08D28:  6f e9 72 d7 02 a8 5b 6f
            hex 8d 14 8d 18 e9 6f e7 04 ; 08D30:  8d 14 8d 18 e9 6f e7 04
            hex cf 20 23 e8 00 00 63 62 ; 08D38:  cf 20 23 e8 00 00 63 62
            hex e9 7b cc 04 aa 63 6f e9 ; 08D40:  e9 7b cc 04 aa 63 6f e9
            hex d3 d9 02 a4 63 6f d0 b3 ; 08D48:  d3 d9 02 a4 63 6f d0 b3
            hex 8e a7 b5 e9 34 d1 04 61 ; 08D50:  8e a7 b5 e9 34 d1 04 61
            hex e9 39 8b 02 cf 20 23 e8 ; 08D58:  e9 39 8b 02 cf 20 23 e8
            hex fc ff 61 e9 35 cc 02 8d ; 08D60:  fc ff 61 e9 35 cc 02 8d
            hex 2b 67 e9 8b cf 04 8d 23 ; 08D68:  2b 67 e9 8b cf 04 8d 23
            hex 6b e9 8b cf 04 61 63 8d ; 08D70:  6b e9 8b cf 04 61 63 8d
            hex 1d 63 6b e9 42 cc 0a 61 ; 08D78:  1d 63 6b e9 42 cc 0a 61
            hex 66 8d 1d 64 6a e9 42 cc ; 08D80:  66 8d 1d 64 6a e9 42 cc
            hex 0a 61 8d 1a 8d 1d 67 62 ; 08D88:  0a 61 8d 1a 8d 1d 67 62
            hex e9 42 cc 0a ac 5d cf 61 ; 08D90:  e9 42 cc 0a ac 5d cf 61
            hex 6b 8d 16 66 8d 12 e9 6a ; 08D98:  6b 8d 16 66 8d 12 e9 6a
            hex cf 0a 62 8d 11 8d 17 6c ; 08DA0:  cf 0a 62 8d 11 8d 17 6c
            hex 8d 12 e9 6a cf 0a 8a ff ; 08DA8:  8d 12 e9 6a cf 0a 8a ff
            hex 00 a8 df 7f 40 a8 fb 7b ; 08DB0:  00 a8 df 7f 40 a8 fb 7b
            hex 64 6c e9 7b cc 04 ac ff ; 08DB8:  64 6c e9 7b cc 04 ac ff
            hex 82 d8 ce 8d aa 63 6f e9 ; 08DC0:  82 d8 ce 8d aa 63 6f e9
            hex 78 de 02 d6 d7 8d ac 7e ; 08DC8:  78 de 02 d6 d7 8d ac 7e
            hex d7 59 b5 8c a8 77 bb b3 ; 08DD0:  d7 59 b5 8c a8 77 bb b3
            hex e9 c4 ce 02 89 16 a8 cd ; 08DD8:  e9 c4 ce 02 89 16 a8 cd
            hex 7f aa 63 6f e9 72 d7 02 ; 08DE0:  7f aa 63 6f e9 72 d7 02
            hex 59 b5 8c a8 77 bb b3 e9 ; 08DE8:  59 b5 8c a8 77 bb b3 e9
            hex c4 ce 02 40 2b 46 2a d6 ; 08DF0:  c4 ce 02 40 2b 46 2a d6
            hex 29 8e 0b d5 f9 ff 07 00 ; 08DF8:  29 8e 0b d5 f9 ff 07 00
            hex 10 8e 26 8e 26 8e 10 8e ; 08E00:  10 8e 26 8e 26 8e 10 8e
            hex 26 8e 26 8e 26 8e 26 8e ; 08E08:  26 8e 26 8e 26 8e 26 8e
            hex 3a 8d 12 e9 7b cc 04 0b ; 08E10:  3a 8d 12 e9 7b cc 04 0b
            hex d2 8c ae f8 bb b0 b3 e9 ; 08E18:  d2 8c ae f8 bb b0 b3 e9
            hex c4 ce 02 0a d0 2a 0b d0 ; 08E20:  c4 ce 02 0a d0 2a 0b d0
            hex 2b 0b 8b 12 c6 d7 fa 8d ; 08E28:  2b 0b 8b 12 c6 d7 fa 8d
            hex 60 e9 61 8c 02 61 e9 61 ; 08E30:  60 e9 61 8c 02 61 e9 61
            hex 8c 02 60 e9 35 cc 02 cf ; 08E38:  8c 02 60 e9 35 cc 02 cf
            hex 20 23 e8 00 00 0d d2 8c ; 08E40:  20 23 e8 00 00 0d d2 8c
            hex ea 7b bb b0 b3 8d 28 3c ; 08E48:  ea 7b bb b0 b3 8d 28 3c
            hex e9 0d d7 04 b3 e9 0d d7 ; 08E50:  e9 0d d7 04 b3 e9 0d d7
            hex 04 1c bb cf 20 23 e8 f4 ; 08E58:  04 1c bb cf 20 23 e8 f4
            hex ff 40 a8 ec 7b a8 ea 7b ; 08E60:  ff 40 a8 ec 7b a8 ea 7b
            hex ac ea d7 d0 2b aa 63 6f ; 08E68:  ac ea d7 d0 2b aa 63 6f
            hex e9 da d7 02 d0 2a 8a b1 ; 08E70:  e9 da d7 02 d0 2a 8a b1
            hex b5 29 40 d6 a5 8e 09 d0 ; 08E78:  b5 29 40 d6 a5 8e 09 d0
            hex 29 d1 d3 b3 0a d0 2a d1 ; 08E80:  29 d1 d3 b3 0a d0 2a d1
            hex d3 b3 0b d0 2b d1 d3 b4 ; 08E88:  d3 b3 0b d0 2b d1 d3 b4
            hex c3 d8 98 8e 41 d6 99 8e ; 08E90:  c3 d8 98 8e 41 d6 99 8e
            hex 40 d2 8c ea 7b bb b4 b3 ; 08E98:  40 d2 8c ea 7b bb b4 b3
            hex b0 bb b1 06 d0 26 06 55 ; 08EA0:  b0 bb b1 06 d0 26 06 55
            hex c2 d7 7e 8e a4 5f 6f 8b ; 08EA8:  c2 d7 7e 8e a4 5f 6f 8b
            hex 1a b5 8c 13 70 bb 28 a4 ; 08EB0:  1a b5 8c 13 70 bb 28 a4
            hex 63 6f 8b 1a b5 8c 13 70 ; 08EB8:  63 6f 8b 1a b5 8c 13 70
            hex bb 27 45 26 09 d0 29 d1 ; 08EC0:  bb 27 45 26 09 d0 29 d1
            hex d3 b3 07 72 27 8f fe b0 ; 08EC8:  d3 b3 07 72 27 8f fe b0
            hex b3 08 72 28 8f fe b0 b4 ; 08ED0:  b3 08 72 28 8f fe b0 b4
            hex c3                      ; 08ED8:  c3

            cld                         ; 08ED9:  d8
            cpx #$8e                    ; 08EDA:  e0 8e
            eor ($d6,x)                 ; 08EDC:  41 d6
            sbc ($8e,x)                 ; 08EDE:  e1 8e
            rti                         ; 08EE0:  40

            hex d2 8c ea 7b bb b4 b3 b0 ; 08EE1:  d2 8c ea 7b bb b4 b3 b0
            hex bb b1 06 d0 26 06 57 c3 ; 08EE9:  bb b1 06 d0 26 06 57 c3
            hex d7 c4 8e cf 20 23 e8 00 ; 08EF1:  d7 c4 8e cf 20 23 e8 00
            hex 00 ac 5c 8e 61 aa 87 6f ; 08EF9:  00 ac 5c 8e 61 aa 87 6f

            sbc #$40                    ; 08F01:  e9 40
            stx $b304                   ; 08F03:  8e 04 b3
            rts                         ; 08F06:  60

            hex aa 81 6f e9 40 8e 04 b4 ; 08F07:  aa 81 6f e9 40 8e 04 b4
            hex c4 cf 20 23 e8 00 00 0c ; 08F0F:  c4 cf 20 23 e8 00 00 0c
            hex 5a c7 d8 22 8f 0d 54 c7 ; 08F17:  5a c7 d8 22 8f 0d 54 c7
            hex d7                      ; 08F1F:  d7

            rol $8f                     ; 08F20:  26 8f
            rti                         ; 08F22:  40

            hex d6 27 8f 41 cf 20 23 e8 ; 08F23:  d6 27 8f 41 cf 20 23 e8
            hex 00 00 0e 8b 33 c7 d7 3b ; 08F2B:  00 00 0e 8b 33 c7 d7 3b
            hex 8f 0e 8b 37 c9 d8 53 8f ; 08F33:  8f 0e 8b 37 c9 d8 53 8f
            hex 89 31 cd 0e bc 2e 56 c9 ; 08F3B:  89 31 cd 0e bc 2e 56 c9
            hex d8 4b 8f 43 cd 0e bc 2e ; 08F43:  d8 4b 8f 43 cd 0e bc 2e
            hex 3e 3d 3c e9 03 80       ; 08F4B:  3e 3d 3c e9 03 80

            asl $cf                     ; 08F51:  06 cf
            rti                         ; 08F53:  40

            hex cf 20 23 e8 00 00 8d 7f ; 08F54:  cf 20 23 e8 00 00 8d 7f
            hex a4 e8 7b 8c 65 6f bb b4 ; 08F5C:  a4 e8 7b 8c 65 6f bb b4
            hex b3 d3 da d4 0c 8c a2 6d ; 08F64:  b3 d3 da d4 0c 8c a2 6d
            hex bb b3 40 d4 0d 8c a2 6d ; 08F6C:  bb b3 40 d4 0d 8c a2 6d
            hex bb b3 41 d4 cf 20 23 e8 ; 08F74:  bb b3 41 d4 cf 20 23 e8
            hex 00 00 0d 55 c6 d8 91 8f ; 08F7C:  00 00 0d 55 c6 d8 91 8f
            hex 0c 8c 65 6f bb d3 1d be ; 08F84:  0c 8c 65 6f bb d3 1d be
            hex 51 da d7                ; 08F8C:  51 da d7

            sta $8f,x                   ; 08F8F:  95 8f
            rti                         ; 08F91:  40

            hex d6 96 8f 41 cf 20 23 e8 ; 08F92:  d6 96 8f 41 cf 20 23 e8
            hex 00 00 0d 8c b9 b5 bb d3 ; 08F9A:  00 00 0d 8c b9 b5 bb d3
            hex b3 0c 8c 65 6f bb b4 b3 ; 08FA2:  b3 0c 8c 65 6f bb b4 b3
            hex d3 da d4 3d 3c e9 8b 82 ; 08FAA:  d3 da d4 3d 3c e9 8b 82
            hex 04 b3 3d 3c e9 9a 82 04 ; 08FB2:  04 b3 3d 3c e9 9a 82 04
            hex b3 89 c8 d4 d4 cf 20 23 ; 08FBA:  b3 89 c8 d4 d4 cf 20 23
            hex e8 fe ff 40 2b 3b 3c e9 ; 08FC2:  e8 fe ff 40 2b 3b 3c e9
            hex 8b 82 04 d3 1d c0 d8 e1 ; 08FCA:  8b 82 04 d3 1d c0 d8 e1
            hex 8f 3b 3c e9 9a 82 04 d3 ; 08FD2:  8f 3b 3c e9 9a 82 04 d3
            hex 1e c0 d8 e1 8f 41 cf 0b ; 08FDA:  1e c0 d8 e1 8f 41 cf 0b
            hex d0 2b 0b 55 c6 d7 c7 8f ; 08FE2:  d0 2b 0b 55 c6 d7 c7 8f
            hex 40 cf 20 23 e8 fc ff 40 ; 08FEA:  40 cf 20 23 e8 fc ff 40
            hex 2b 3d 3c 3b e9 c0 8f 06 ; 08FF2:  2b 3d 3c 3b e9 c0 8f 06
            hex d8 ff 8f 41 cf 0b d0 2b ; 08FFA:  d8 ff 8f 41 cf 0b d0 2b
            hex 0b 52 c6 d7 f3 8f 40 cf ; 09002:  0b 52 c6 d7 f3 8f 40 cf
            hex 20 23 e8 00 00 0c 52 c8 ; 0900A:  20 23 e8 00 00 0c 52 c8
            hex d8 17 90 40 2c 0c cf 20 ; 09012:  d8 17 90 40 2c 0c cf 20
            hex 23 e8 00 00 8e c2 00 3d ; 0901A:  23 e8 00 00 8e c2 00 3d
            hex 3c e9 db 82 06 d8 2e 90 ; 09022:  3c e9 db 82 06 d8 2e 90
            hex 40 d6 2f 90 41 cf 20 23 ; 0902A:  40 d6 2f 90 41 cf 20 23
            hex e8 fe ff 3c e9 8f 83 02 ; 09032:  e8 fe ff 3c e9 8f 83 02
            hex 2b 3b e9 8d d9 02 55 c1 ; 0903A:  2b 3b e9 8d d9 02 55 c1
            hex d7 56 90 3b e9 72 d7 02 ; 09042:  d7 56 90 3b e9 72 d7 02
            hex 8c 67 6d bb d3 d7       ; 0904A:  8c 67 6d bb d3 d7

            lsr $90,x                   ; 09050:  56 90
            rti                         ; 09052:  40

            hex d6 57 90 41 cf 20 23 e8 ; 09053:  d6 57 90 41 cf 20 23 e8
            hex 00 00 3d 3c e9 11 8f 04 ; 0905B:  00 00 3d 3c e9 11 8f 04
            hex d8 9e 90 3d 3c e9 ec 8f ; 09063:  d8 9e 90 3d 3c e9 ec 8f
            hex 04 d7 9e 90 3d 3c e9 19 ; 0906B:  04 d7 9e 90 3d 3c e9 19
            hex 90 04 d7 9e 90 ac b9 82 ; 09073:  90 04 d7 9e 90 ac b9 82
            hex d3 b3 ac a9 82 d3 b3 e9 ; 0907B:  d3 b3 ac a9 82 d3 b3 e9
            hex 25 8b 04 ac a9 82 b3 0c ; 09083:  25 8b 04 ac a9 82 b3 0c
            hex d4 ac b9 82 b3 0d d4 aa ; 0908B:  d4 ac b9 82 b3 0d d4 aa
            hex e4 7b aa e8 7b e9 df 89 ; 09093:  e4 7b aa e8 7b e9 df 89
            hex 04                      ; 0909B:  04

            eor ($cf,x)                 ; 0909C:  41 cf
            rti                         ; 0909E:  40

            hex cf 20 23 e8 00 00 8e be ; 0909F:  cf 20 23 e8 00 00 8e be
            hex b5 e9 c4 ce 02 ac b9 82 ; 090A7:  b5 e9 c4 ce 02 ac b9 82
            hex d3 b3 ac a9 82 d3 b3 e9 ; 090AF:  d3 b3 ac a9 82 d3 b3 e9
            hex f9 86 04 cf 20 23 e8 f2 ; 090B7:  f9 86 04 cf 20 23 e8 f2
            hex ff 3c e9 72 d7 02 25 de ; 090BF:  ff 3c e9 72 d7 02 25 de
            hex f8 ff 27 8a 4f 6f d6 f0 ; 090C7:  f8 ff 27 8a 4f 6f d6 f0
            hex 90 06 d3 b3 e9 99 d9 02 ; 090CF:  90 06 d3 b3 e9 99 d9 02
            hex d7 ee 90 06 d3 b3 e9 72 ; 090D7:  d7 ee 90 06 d3 b3 e9 72
            hex d7 02 15 c0 d8 ee 90 07 ; 090DF:  d7 02 15 c0 d8 ee 90 07
            hex d0 27 d1 b3 06 d3 d4 06 ; 090E7:  d0 27 d1 b3 06 d3 d4 06
            hex d0 26 06 d3 8c ff 00 c1 ; 090EF:  d0 26 06 d3 8c ff 00 c1
            hex d7 d0 90 37 89 ff d4 68 ; 090F7:  d7 d0 90 37 89 ff d4 68
            hex 8e 4f 6f de f8 ff b3 62 ; 090FF:  8e 4f 6f de f8 ff b3 62
            hex e9 bd cb 08 cf 20 23 e8 ; 09107:  e9 bd cb 08 cf 20 23 e8
            hex fe ff 8d 18 62 e9 7b cc ; 0910F:  fe ff 8d 18 62 e9 7b cc
            hex 04 8e e9 b5 e9 c4 ce 02 ; 09117:  04 8e e9 b5 e9 c4 ce 02
            hex ac 87 d2 2b ac 09 d3 ac ; 0911F:  ac 87 d2 2b ac 09 d3 ac
            hex e1 cc 0b cf 20 23 e8 fa ; 09127:  e1 cc 0b cf 20 23 e8 fa
            hex ff 40 2b 8e f6 b5 e9 26 ; 0912F:  ff 40 2b 8e f6 b5 e9 26
            hex d3 02 40 2a 8a 4f 6f 29 ; 09137:  d3 02 40 2a 8a 4f 6f 29
            hex d6 88 91 41 2a 09 d0 29 ; 0913F:  d6 88 91 41 2a 09 d0 29
            hex d1 d3 d0 b3 8e fd b5 e9 ; 09147:  d1 d3 d0 b3 8e fd b5 e9
            hex 34 d1 04 0b d0 2b 0b 53 ; 0914F:  34 d1 04 0b d0 2b 0b 53
            hex ba d7 5f 91 4a d6 61 91 ; 09157:  ba d7 5f 91 4a d6 61 91
            hex 89 20 b3 e9 81 ce 02 0b ; 0915F:  89 20 b3 e9 81 ce 02 0b
            hex 56 c0 d8 88 91 09 d3 8c ; 09167:  56 c0 d8 88 91 09 d3 8c
            hex ff 00 c1 d8 88 91 ac 0c ; 0916F:  ff 00 c1 d8 88 91 ac 0c
            hex 91 52 c0 d8 7f 91 40 cf ; 09177:  91 52 c0 d8 7f 91 40 cf
            hex 8e 01 b6 e9 26 d3 02 40 ; 0917F:  8e 01 b6 e9 26 d3 02 40
            hex 2b 09 d3 8c ff 00 c1 d7 ; 09187:  2b 09 d3 8c ff 00 c1 d7
            hex 42 91 0a d7 9f 91 8e 08 ; 0918F:  42 91 0a d7 9f 91 8e 08
            hex b6 e9 c4 ce 02 ac 1a d3 ; 09197:  b6 e9 c4 ce 02 ac 1a d3
            hex 0a cf 20 23 e8 fc ff 8a ; 0919F:  0a cf 20 23 e8 fc ff 8a
            hex 4f 6f 2a aa 9d 6d 61 e9 ; 091A7:  4f 6f 2a aa 9d 6d 61 e9
            hex 9d d5 04 2b d8 d1 91 0b ; 091AF:  9d d5 04 2b d8 d1 91 0b
            hex d1 2b d6 c8 91 0a d3 1b ; 091B7:  d1 2b d6 c8 91 0a d3 1b
            hex c0 d8 c5 91 0b cf 0a d0 ; 091BF:  c0 d8 c5 91 0b cf 0a d0
            hex 2a 0a d3 8c ff 00 c1 d7 ; 091C7:  2a 0a d3 8c ff 00 c1 d7
            hex bc 91 8a ff 00 cf 20 23 ; 091CF:  bc 91 8a ff 00 cf 20 23
            hex e8 f4 ff 40 28 38 e9 7e ; 091D7:  e8 f4 ff 40 28 38 e9 7e
            hex 82 02 74 b0 2b 08 5a b5 ; 091DF:  82 02 74 b0 2b 08 5a b5
            hex 8c bc 6f bb 29 38 e9 8f ; 091E7:  8c bc 6f bb 29 38 e9 8f
            hex 83 02 55 b5 8c a9 76 bb ; 091EF:  83 02 55 b5 8c a9 76 bb
            hex 26 8d 1f 08 8c 65 6f bb ; 091F7:  26 8d 1f 08 8c 65 6f bb
            hex b4 b3 d3 db d4 39 06 d3 ; 091FF:  b4 b3 d3 db d4 39 06 d3
            hex b3 3b e9 0d d7 04 b1 2a ; 09207:  b3 3b e9 0d d7 04 b1 2a
            hex 50 c3 d8 18 92 39 41 b1 ; 0920F:  50 c3 d8 18 92 39 41 b1
            hex 2a 41 27 0b 1a bc 50 c4 ; 09217:  2a 41 27 0b 1a bc 50 c4
            hex d8 39 92 07 d2 19 bb b3 ; 0921F:  d8 39 92 07 d2 19 bb b3
            hex 06 17 bb d3 b3 3b e9 0d ; 09227:  06 17 bb d3 b3 3b e9 0d
            hex d7 04 b1 cd 0a bb 2a d6 ; 0922F:  d7 04 b1 cd 0a bb 2a d6
            hex 40 92 07 d2             ; 09237:  40 92 07 d2

            ora tab_b2_b36f+76,y        ; 0923B:  19 bb b3
            rti                         ; 0923E:  40

            hex b1 07 d0 27 07 55 c6 d7 ; 0923F:  b1 07 d0 27 07 55 c6 d7
            hex 1a 92 0a cd 0b bc 2b 50 ; 09247:  1a 92 0a cd 0b bc 2b 50
            hex c4 d8 79 92 40 27 d6 73 ; 0924F:  c4 d8 79 92 40 27 d6 73
            hex 92 45 cd 07 ba 27 16 bb ; 09257:  92 45 cd 07 ba 27 16 bb
            hex d3 d8 6b 92 07 d2 19 bb ; 0925F:  d3 d8 6b 92 07 d2 19 bb
            hex b3 b0 d0 b1 0b d1 2b d0 ; 09267:  b3 b0 d0 b1 0b d1 2b d0
            hex 07 d0 27 d1 0b 50 c4 d7 ; 0926F:  07 d0 27 d1 0b 50 c4 d7
            hex 58 92 40 27 07 d2 19 bb ; 09277:  58 92 40 27 07 d2 19 bb
            hex b0 d7 89 92 37 38 e9 97 ; 0927F:  b0 d7 89 92 37 38 e9 97
            hex 8f 04 07 d0 27 07 55 c6 ; 09287:  8f 04 07 d0 27 07 55 c6
            hex d7 7b 92 08 d0 28 08 52 ; 0928F:  d7 7b 92 08 d0 28 08 52
            hex c6 d7 dc 91 cf 20 23 e8 ; 09297:  c6 d7 dc 91 cf 20 23 e8
            hex fc ff 40 2b 40 2a 3a 3b ; 0929F:  fc ff 40 2b 40 2a 3a 3b
            hex e9 8b 82 04 b3 3a 3b e9 ; 092A7:  e9 8b 82 04 b3 3a 3b e9
            hex 9a 82 04 b3 89 c8 d4 d4 ; 092AF:  9a 82 04 b3 89 c8 d4 d4
            hex 0a d0 2a 0a 55 c6 d7 a5 ; 092B7:  0a d0 2a 0a 55 c6 d7 a5
            hex 92 0b d0 2b 0b 52 c6 d7 ; 092BF:  92 0b d0 2b 0b 52 c6 d7
            hex a3 92 cf 20 23 e8 fe ff ; 092C7:  a3 92 cf 20 23 e8 fe ff
            hex 8a ff                   ; 092CF:  8a ff

            brk                         ; 092D1:  00
            hex a8                      ; 092D2:  a8
            sbc ($7f,x)                 ; 092D3:  e1 7f
            rti                         ; 092D5:  40

            hex 2b a4 63 6f 8c a2 6d bb ; 092D6:  2b a4 63 6f 8c a2 6d bb
            hex d3 57 bd a9 66 6f a4 63 ; 092DE:  d3 57 bd a9 66 6f a4 63
            hex 6f 8b 1a b5 8c 01 70 bb ; 092E6:  6f 8b 1a b5 8c 01 70 bb
            hex b0 a8 83 6f 50 c3 d8 07 ; 092EE:  b0 a8 83 6f 50 c3 d8 07
            hex 93 a4 63 6f 8b 1a b5 8c ; 092F6:  93 a4 63 6f 8b 1a b5 8c
            hex 01 70 bb b3 40 b1 a8 83 ; 092FE:  01 70 bb b3 40 b1 a8 83
            hex 6f a4 63 6f 8b 1a b5 8c ; 09306:  6f a4 63 6f 8b 1a b5 8c
            hex 07 70 bb b0 a8 85 6f 50 ; 0930E:  07 70 bb b0 a8 85 6f 50
            hex c3 d8 2c 93 a4 63 6f 8b ; 09316:  c3 d8 2c 93 a4 63 6f 8b
            hex 1a b5 8c 07 70 bb b3 40 ; 0931E:  1a b5 8c 07 70 bb b3 40
            hex b1 a8 85 6f 47 2b a4 63 ; 09326:  b1 a8 85 6f 47 2b a4 63
            hex 6f 8b 1a b5 8c 11 70 bb ; 0932E:  6f 8b 1a b5 8c 11 70 bb
            hex b0 a8 87 6f 50 c3 d8 51 ; 09336:  b0 a8 87 6f 50 c3 d8 51
            hex 93 a4 63 6f 8b 1a b5 8c ; 0933E:  93 a4 63 6f 8b 1a b5 8c
            hex 11 70 bb b3 40 b1 a8 87 ; 09346:  11 70 bb b3 40 b1 a8 87
            hex 6f 48 2b 0b d7 62 93 ac ; 0934E:  6f 48 2b 0b d7 62 93 ac
            hex d5 91 ac 9c 92 41 a8 e8 ; 09356:  d5 91 ac 9c 92 41 a8 e8
            hex 7b d6 68 93 a4 63 6f a8 ; 0935E:  7b d6 68 93 a4 63 6f a8
            hex 57 6f 0b cf 20 23 e8 00 ; 09366:  57 6f 0b cf 20 23 e8 00
            hex 00 8e 26 b6 e9 26 d3 02 ; 0936E:  00 8e 26 b6 e9 26 d3 02
            hex 0d d0 2d b3 0c d2 8c 96 ; 09376:  0d d0 2d b3 0c d2 8c 96
            hex b1 bb b0 b3 e9 34 d1 04 ; 0937E:  b1 bb b0 b3 e9 34 d1 04
            hex cf 20 23 e8 00 00 aa e4 ; 09386:  cf 20 23 e8 00 00 aa e4
            hex 7b e9 0a 90 02 d0 53 ba ; 0938E:  7b e9 0a 90 02 d0 53 ba
            hex d2 8c af f9 bb b0 b3 a4 ; 09396:  d2 8c af f9 bb b0 b3 a4
            hex e4 7b d0 b3 8e 27 b6 e9 ; 0939E:  e4 7b d0 b3 8e 27 b6 e9
            hex 34 d1 06 cf 20 23 e8 f4 ; 093A6:  34 d1 06 cf 20 23 e8 f4
            hex ff 0c a6 63 6f c0 27 07 ; 093AE:  ff 0c a6 63 6f c0 27 07
            hex 51 dc b3 e9 8f 83 02 29 ; 093B6:  51 dc b3 e9 8f 83 02 29
            hex 3c e9 72 d7 02 2a 0c a6 ; 093BE:  3c e9 72 d7 02 2a 0c a6
            hex 57 6f c0 28 ac 20 cd 61 ; 093C6:  57 6f c0 28 ac 20 cd 61
            hex e9 35 cc 02 40 2b 0b 8c ; 093CE:  e9 35 cc 02 40 2b 0b 8c
            hex 58 b6 bb d3 b3 3b e9 8b ; 093D6:  58 b6 bb d3 b3 3b e9 8b
            hex cf 04 0b d0 2b 0b 8b 10 ; 093DE:  cf 04 0b d0 2b 0b 8b 10
            hex c6 d7 d4 93 8e 9a 00 8e ; 093E6:  c6 d7 d4 93 8e 9a 00 8e
            hex 10 15 8e bc 83 64 e9 7c ; 093EE:  10 15 8e bc 83 64 e9 7c
            hex cf                      ; 093F6:  cf

            php                         ; 093F7:  08
            rts                         ; 093F8:  60

            hex e9 35 cc 02 63 62 e9 7b ; 093F9:  e9 35 cc 02 63 62 e9 7b
            hex cc 04 3c e9 8d d9 02 d8 ; 09401:  cc 04 3c e9 8d d9 02 d8
            hex 86 94 08 d7 39 94 0d 57 ; 09409:  86 94 08 d7 39 94 0d 57
            hex c8 d8 19 94 47 d6 2e 94 ; 09411:  c8 d8 19 94 47 d6 2e 94
            hex 07 d8 2f 94 0d 51 c0 d8 ; 09419:  07 d8 2f 94 0d 51 c0 d8
            hex 2f 94 60 37 e9 79 8f 04 ; 09421:  2f 94 60 37 e9 79 8f 04
            hex d7 2f 94 0d d0 2d 0d d1 ; 09429:  d7 2f 94 0d d0 2d 0d d1
            hex 2d d2 8c 32 b6 d6 51 94 ; 09431:  2d d2 8c 32 b6 d6 51 94
            hex 0d 51 c0 d8 4a 94 37 e9 ; 09439:  0d 51 c0 d8 4a 94 37 e9
            hex 6a 83 02 d7 4a 94 0d d0 ; 09441:  6a 83 02 d7 4a 94 0d d0
            hex 2d 0d d1 2d d2 8c 40 b6 ; 09449:  2d 0d d1 2d d2 8c 40 b6
            hex bb b0 26 3c e9 8b d7 02 ; 09451:  bb b0 26 3c e9 8b d7 02
            hex 8e 6c b9 e9 c4 ce 02 36 ; 09459:  8e 6c b9 e9 c4 ce 02 36
            hex e9 c4 ce 02 08 d8 6d 94 ; 09461:  e9 c4 ce 02 08 d8 6d 94
            hex 44 d6 6e 94 43 b3 e9 03 ; 09469:  44 d6 6e 94 43 b3 e9 03
            hex ca 02 a4 4d 6f d8 f2 94 ; 09471:  ca 02 a4 4d 6f d8 f2 94
            hex 62 61 6a e9 26 f2 06 d8 ; 09479:  62 61 6a e9 26 f2 06 d8
            hex f5 94 d6 79 94 08 d7 f2 ; 09481:  f5 94 d6 79 94 08 d7 f2
            hex 94 0d 52 c7 d8 b4 94 39 ; 09489:  94 0d 52 c7 d8 b4 94 39
            hex e9 72 d7 02 59 b5 8c a8 ; 09491:  e9 72 d7 02 59 b5 8c a8
            hex 77 bb b3 8e 6e b9 d6 ad ; 09499:  77 bb b3 8e 6e b9 d6 ad
            hex 94 0a 59 b5 8c a8 77 bb ; 094A1:  94 0a 59 b5 8c a8 77 bb
            hex b3 8e 7f b9 e9 34 d1 04 ; 094A9:  b3 8e 7f b9 e9 34 d1 04
            hex d6 f2 94 0d 53 c0 d7 a2 ; 094B1:  d6 f2 94 0d 53 c0 d7 a2
            hex 94 39 e9 8d d9 02 d7 f2 ; 094B9:  94 39 e9 8d d9 02 d7 f2
            hex 94 0d 57 c0 d8 cc 94 44 ; 094C1:  94 0d 57 c0 d8 cc 94 44
            hex d6 d4 94 0d 58 c0 d8 d5 ; 094C9:  d6 d4 94 0d 58 c0 d8 d5
            hex 94 0d d1 2d 44 cd 0d bc ; 094D1:  94 0d d1 2d 44 cd 0d bc
            hex 2d 53 c7 d8 f2 94 aa 57 ; 094D9:  2d 53 c7 d8 f2 94 aa 57
            hex 6f e9 4b db 02 0d d2 8c ; 094E1:  6f e9 4b db 02 0d d2 8c
            hex 50 b6 bb b0 b3 e9 c4 ce ; 094E9:  50 b6 bb b0 b3 e9 c4 ce
            hex 02 ac 59 d7 cf 20 23 e8 ; 094F1:  02 ac 59 d7 cf 20 23 e8
            hex fc ff a4 e8 7b 51 dc 2a ; 094F9:  fc ff a4 e8 7b 51 dc 2a
            hex aa e8 7b e9 8f 83 02 2b ; 09501:  aa e8 7b e9 8f 83 02 2b
            hex b3 e9 8d d9 02 d8 69 95 ; 09509:  b3 e9 8d d9 02 d8 69 95
            hex 0c d7 1f 95 aa c6 b1 e9 ; 09511:  0c d7 1f 95 aa c6 b1 e9
            hex 26 d3 02 d6 3f 95 8e 9d ; 09519:  26 d3 02 d6 3f 95 8e 9d
            hex b9 e9 26 d3 02 3b e9 af ; 09521:  b9 e9 26 d3 02 3b e9 af
            hex d7 02 6a e9 81 ce 02 0c ; 09529:  d7 02 6a e9 81 ce 02 0c
            hex d1 d2 74 d2 8c 96 b1 bb ; 09531:  d1 d2 74 d2 8c 96 b1 bb
            hex b0 b3 e9 c4 ce 02 41 cd ; 09539:  b0 b3 e9 c4 ce 02 41 cd
            hex 0a dc 2a ac 1a d3 aa e4 ; 09541:  0a dc 2a ac 1a d3 aa e4
            hex 7b aa e8 7b e9 79 8f 04 ; 09549:  7b aa e8 7b e9 79 8f 04
            hex d7 a3 95 aa e4 7b 0a a6 ; 09551:  d7 a3 95 aa e4 7b 0a a6
            hex e8 7b c0 d8 ba 95 47 b3 ; 09559:  e8 7b c0 d8 ba 95 47 b3
            hex e9 6a 93 04 ac 1a d3 cf ; 09561:  e9 6a 93 04 ac 1a d3 cf
            hex 3a e9 8f 83 02 2b b3 e9 ; 09569:  3a e9 8f 83 02 2b b3 e9
            hex 8d d9 02 d8 a2 95 8e 9e ; 09571:  8d d9 02 d8 a2 95 8e 9e
            hex b9 e9 26 d3 02 3b e9 af ; 09579:  b9 e9 26 d3 02 3b e9 af
            hex d7 02 6a e9 81 ce 02 aa ; 09581:  d7 02 6a e9 81 ce 02 aa
            hex a6 b1 e9 c4 ce 02 0c 52 ; 09589:  a6 b1 e9 c4 ce 02 0c 52
            hex c0 d8 44 95 ac 1a d3 aa ; 09591:  c0 d8 44 95 ac 1a d3 aa
            hex d6 b1 e9 26 d3 02 d6 44 ; 09599:  d6 b1 e9 26 d3 02 d6 44
            hex 95 cf 3d a4 e8 7b 51 dc ; 095A1:  95 cf 3d a4 e8 7b 51 dc
            hex b3 e9 79 8f 04 d7 68 95 ; 095A9:  b3 e9 79 8f 04 d7 68 95
            hex 3d 0a a6 e8 7b c0 d8 5f ; 095B1:  3d 0a a6 e8 7b c0 d8 5f
            hex 95 45 d6 60 95 20 23    ; 095B9:  95 45 d6 60 95 20 23

            inx                         ; 095C0:  e8
            brk                         ; 095C1:  00
            hex 00                      ; 095C2:  00
            rts                         ; 095C3:  60

            hex e9 0b 84 02 a4 fe 6f d9 ; 095C4:  e9 0b 84 02 a4 fe 6f d9
            hex 03 00 00 00 dc 95 01 00 ; 095CC:  03 00 00 00 dc 95 01 00
            hex fb 95 02 00 05 96 e6 95 ; 095D4:  fb 95 02 00 05 96 e6 95
            hex 0c 58 c9 d8 f7 95 42 a8 ; 095DC:  0c 58 c9 d8 f7 95 42 a8
            hex fe 6f 61 e9 35 cc 02 ac ; 095E4:  fe 6f 61 e9 35 cc 02 ac
            hex 5e 88 60 e9 35 cc 02 ac ; 095EC:  5e 88 60 e9 35 cc 02 ac
            hex 58 8b cf 41 d6 e3 95 0c ; 095F4:  58 8b cf 41 d6 e3 95 0c
            hex 55 c8 d7 e2 95 40 d6 e3 ; 095FC:  55 c8 d7 e2 95 40 d6 e3
            hex 95 0c 52 c7 d8 f7 95 d6 ; 09604:  95 0c 52 c7 d8 f7 95 d6
            hex 01 96 20 23 e8 00 00 0c ; 0960C:  01 96 20 23 e8 00 00 0c
            hex 55 c6 d8 1f 96 a4 fe 6f ; 09614:  55 c6 d8 1f 96 a4 fe 6f
            hex d8 45 96 0c 52 c8 d8 33 ; 0961C:  d8 45 96 0c 52 c8 d8 33
            hex 96 0c 58 c6 d8 33 96 a4 ; 09624:  96 0c 58 c6 d8 33 96 a4
            hex fe 6f 51 c0 d7 45 96 0c ; 0962C:  fe 6f 51 c0 d7 45 96 0c
            hex 55 c8 d8 41 96 a4 fe 6f ; 09634:  55 c8 d8 41 96 a4 fe 6f
            hex 52                      ; 0963C:  52

            cpy #$d7                    ; 0963D:  c0 d7
            eor $96                     ; 0963F:  45 96
            rti                         ; 09641:  40

            hex d6 46 96 41 cf 20 23 e8 ; 09642:  d6 46 96 41 cf 20 23 e8
            hex fc ff 40 2b 40 2a 8d 20 ; 0964A:  fc ff 40 2b 40 2a 8d 20
            hex 3a 3b e9 db 82 06 d7 62 ; 09652:  3a 3b e9 db 82 06 d7 62
            hex 96 3c 0b b1 3d 0a b1 cf ; 0965A:  96 3c 0b b1 3d 0a b1 cf
            hex 0a d0 2a 0a 55 c6 d7 50 ; 09662:  0a d0 2a 0a 55 c6 d7 50
            hex 96 0b d0 2b 0b 5b       ; 0966A:  96 0b d0 2b 0b 5b

            dec $d7                     ; 09670:  c6 d7
            lsr $cf96                   ; 09672:  4e 96 cf
            jsr $e823                   ; 09675:  20 23 e8
            inc $ff,x                   ; 09678:  f6 ff
            rti                         ; 0967A:  40

            hex a8 f8 6f a8 f6 6f 27 4a ; 0967B:  a8 f8 6f a8 f6 6f 27 4a
            hex a8 fa 6f 44 a8 fc 6f ac ; 09683:  a8 fa 6f 44 a8 fc 6f ac
            hex ff 82 d7 08 97 a4 e8 7b ; 0968B:  ff 82 d7 08 97 a4 e8 7b
            hex d7 08 97 aa 5f 6f e9 66 ; 09693:  d7 08 97 aa 5f 6f e9 66
            hex dc 02 8c ba b0 bb d3 2b ; 0969B:  dc 02 8c ba b0 bb d3 2b
            hex aa 63 6f e9 66 dc 02 8c ; 096A3:  aa 63 6f e9 66 dc 02 8c
            hex ba b0 bb d3 2a aa 5f 6f ; 096AB:  ba b0 bb d3 2a aa 5f 6f
            hex e9 66 dc 02 8c ec b0 bb ; 096B3:  e9 66 dc 02 8c ec b0 bb
            hex d3 29 aa 63 6f e9 66 dc ; 096BB:  d3 29 aa 63 6f e9 66 dc
            hex 02 8c ec b0 bb d3       ; 096C3:  02 8c ec b0 bb d3

            plp                         ; 096C9:  28
            ora #$18                    ; 096CA:  09 18
            ldy $e9b3,x                 ; 096CC:  bc b3 e9
            jmp $02cb                   ; 096CF:  4c cb 02

            hex b3 0b 1a                ; 096D2:  b3 0b 1a

            ldy $e9b3,x                 ; 096D5:  bc b3 e9
            jmp $02cb                   ; 096D8:  4c cb 02

            hex b4 c2 d8 f5 96 09 18 c6 ; 096DB:  b4 c2 d8 f5 96 09 18 c6
            hex d8 ee 96 42 a8 fc 6f 41 ; 096E3:  d8 ee 96 42 a8 fc 6f 41
            hex d6 07 97 42 a8 f8 6f d6 ; 096EB:  d6 07 97 42 a8 f8 6f d6
            hex 07 97 0b 1a c8 d8 03 97 ; 096F3:  07 97 0b 1a c8 d8 03 97
            hex 47 a8 f6 6f 44 d6 07 97 ; 096FB:  47 a8 f6 6f 44 d6 07 97
            hex 43 a8 fa 6f 27 07 cf 20 ; 09703:  43 a8 fa 6f 27 07 cf 20
            hex 23 e8 00 00 0c a6 f6 6f ; 0970B:  23 e8 00 00 0c a6 f6 6f
            hex c6 d7 2f 97 0c a6 fa 6f ; 09713:  c6 d7 2f 97 0c a6 fa 6f
            hex c8 d7 2f 97 0d a6 f8 6f ; 0971B:  c8 d7 2f 97 0d a6 f8 6f
            hex c6 d7 2f 97 0d a6 fc 6f ; 09723:  c6 d7 2f 97 0d a6 fc 6f
            hex c8 d8 33 97 40 d6 34 97 ; 0972B:  c8 d8 33 97 40 d6 34 97
            hex 41 cf 20 23 e8 f6 ff a4 ; 09733:  41 cf 20 23 e8 f6 ff a4
            hex e8 7b d7 90 97 8d 20 3d ; 0973B:  e8 7b d7 90 97 8d 20 3d
            hex 3c e9 db 82 06 d8 55 97 ; 09743:  3c e9 db 82 06 d8 55 97
            hex 68 3d 3c e9 db 82 06 d7 ; 0974B:  68 3d 3c e9 db 82 06 d7
            hex 57 97 41 cf de fc ff b3 ; 09753:  57 97 41 cf de fc ff b3
            hex de fe ff b3             ; 0975B:  de fe ff b3

            sbc #$47                    ; 0975F:  e9 47
            stx ptr2_lo,y                   ; 09761:  96 04
            rti                         ; 09763:  40

            hex 27 0b 29 0a 28 37 de f8 ; 09764:  27 0b 29 0a 28 37 de f8
            hex ff b3 de fa ff b3 e9 03 ; 0976C:  ff b3 de fa ff b3 e9 03
            hex 80 06 d8 87 97 09 1c c0 ; 09774:  80 06 d8 87 97 09 1c c0
            hex d8 87 97 08 1d c0 d8 87 ; 0977C:  d8 87 97 08 1d c0 d8 87
            hex 97 41 cf 07 d0 27 07 56 ; 09784:  97 41 cf 07 d0 27 07 56
            hex c6 d7                   ; 0978C:  c6 d7

            adc $97                     ; 0978E:  65 97
            rti                         ; 09790:  40

tab_b2_9791: ; 145 bytes
            hex cf 20 23 e8 00 00 3d 3c ; 09791:  cf 20 23 e8 00 00 3d 3c
            hex e9 ec 8f 04 d7 d7 97 3d ; 09799:  e9 ec 8f 04 d7 d7 97 3d
            hex 3c e9 19 90 04 d7 d7 97 ; 097A1:  3c e9 19 90 04 d7 d7 97
            hex 3d 3c e9 35 97 04 d7 d7 ; 097A9:  3d 3c e9 35 97 04 d7 d7
            hex 97 3d 3c e9 0a 97 04 d8 ; 097B1:  97 3d 3c e9 0a 97 04 d8
            hex d7 97 aa e4 7b aa e8 7b ; 097B9:  d7 97 aa e4 7b aa e8 7b
            hex e9 8b 82 04 b3 0c d4 aa ; 097C1:  e9 8b 82 04 b3 0c d4 aa
            hex e4 7b aa e8 7b e9 9a 82 ; 097C9:  e4 7b aa e8 7b e9 9a 82
            hex 04 b3 0d d4 41 cf 40 cf ; 097D1:  04 b3 0d d4 41 cf 40 cf
            hex 20 23 e8 00 00 3d 3c e9 ; 097D9:  20 23 e8 00 00 3d 3c e9
            hex 92 97 04 d8 f7 97 a4 e4 ; 097E1:  92 97 04 d8 f7 97 a4 e4
            hex 7b d0 a8 e4 7b d1 b3 aa ; 097E9:  7b d0 a8 e4 7b d1 b3 aa
            hex e8 7b e9 df 89 04 cf 20 ; 097F1:  e8 7b e9 df 89 04 cf 20
            hex 23 e8 00 00 aa e4 7b aa ; 097F9:  23 e8 00 00 aa e4 7b aa
            hex e8 7b e9 79 8f 04 d8 0e ; 09801:  e8 7b e9 79 8f 04 d8 0e
            hex 98 40 d6 0f 98 41 cf 20 ; 09809:  98 40 d6 0f 98 41 cf 20
            hex 23 e8 fa ff 40 d6 55 98 ; 09811:  23 e8 fa ff 40 d6 55 98
            hex ac f8 97 d8 29 98 a4 e4 ; 09819:  ac f8 97 d8 29 98 a4 e4
            hex 7b                      ; 09821:  7b

            bne tab_b2_9791+59          ; 09822:  d0 a8
            cpx music_ptr_hi                     ; 09824:  e4 7b
            dec $53,x                   ; 09826:  d6 53
            tya                         ; 09828:  98
            rts                         ; 09829:  60

            hex aa e8 7b e9 8b 82 04 d3 ; 0982A:  aa e8 7b e9 8b 82 04 d3
            hex 2b 60 aa e8 7b e9 9a 82 ; 09832:  2b 60 aa e8 7b e9 9a 82
            hex 04 d3 2a 39 de fc ff b3 ; 0983A:  04 d3 2a 39 de fc ff b3
            hex de fe ff b3 e9 03 80 06 ; 09842:  de fe ff b3 e9 03 80 06
            hex d8 53 98 3a 3b e9 d9 97 ; 0984A:  d8 53 98 3a 3b e9 d9 97
            hex 04 09 d0 29 09 56 c6 d8 ; 09852:  04 09 d0 29 09 56 c6 d8
            hex 64 98 a4 e4 7b 1c c6 d7 ; 0985A:  64 98 a4 e4 7b 1c c6 d7
            hex 19 98 cf 20 23 e8 f4 ff ; 09862:  19 98 cf 20 23 e8 f4 ff
            hex de fc ff b3 de fe ff b3 ; 0986A:  de fc ff b3 de fe ff b3
            hex e9 47 96 04 3a 3b e9 d9 ; 09872:  e9 47 96 04 3a 3b e9 d9
            hex 97 04 ac f5 8e d8 fd 98 ; 0987A:  97 04 ac f5 8e d8 fd 98
            hex 65 e9 10 98 02 41 d6 ec ; 09882:  65 e9 10 98 02 41 d6 ec
            hex 98 ac f8 97 d8 9b 98 a4 ; 0988A:  98 ac f8 97 d8 9b 98 a4
            hex e4 7b d0 a8 e4 7b d6 ea ; 09892:  e4 7b d0 a8 e4 7b d6 ea
            hex 98 37 aa e8 7b e9 8b 82 ; 0989A:  98 37 aa e8 7b e9 8b 82
            hex 04 d3 2b 37 aa e8 7b e9 ; 098A2:  04 d3 2b 37 aa e8 7b e9
            hex 9a 82 04 d3             ; 098AA:  9a 82 04 d3

            rol a                       ; 098AE:  2a
            rti                         ; 098AF:  40

            hex 26 0b 29 0a 28 36 de f8 ; 098B0:  26 0b 29 0a 28 36 de f8
            hex ff b3 de fa ff b3 e9 03 ; 098B8:  ff b3 de fa ff b3 e9 03
            hex 80 06 d8 e1 98 38 39 e9 ; 098C0:  80 06 d8 e1 98 38 39 e9
            hex 92 97 04 d8 e1 98 a4 e4 ; 098C8:  92 97 04 d8 e1 98 a4 e4
            hex 7b d0 a8 e4 7b d1 b3 aa ; 098D0:  7b d0 a8 e4 7b d1 b3 aa
            hex e8 7b e9 df 89 04 d6 ea ; 098D8:  e8 7b e9 df 89 04 d6 ea
            hex 98 06 d0 26 06 56 c6 d7 ; 098E0:  98 06 d0 26 06 56 c6 d7
            hex b1 98 07 d0 27 07 a6 e4 ; 098E8:  b1 98 07 d0 27 07 a6 e4
            hex 7b c6 d8 fd 98 a4 e4 7b ; 098F0:  7b c6 d8 fd 98 a4 e4 7b
            hex 55 c6 d7 8b 98 cf 20 23 ; 098F8:  55 c6 d7 8b 98 cf 20 23
            hex e8 fa ff 40 2b 0c 2a 0d ; 09900:  e8 fa ff 40 2b 0c 2a 0d
            hex 29 3b de fa ff b3 de fc ; 09908:  29 3b de fa ff b3 de fc
            hex ff b3 e9 03 80 06 d8 28 ; 09910:  ff b3 e9 03 80 06 d8 28
            hex 99 39 3a a4 e8 7b 51 dc ; 09918:  99 39 3a a4 e8 7b 51 dc
            hex b3 e9 c0 8f 06 d7 31 99 ; 09920:  b3 e9 c0 8f 06 d7 31 99
            hex 0b d0 2b 0b 56 c6 d7 05 ; 09928:  0b d0 2b 0b 56 c6 d7 05
            hex 99 0b 56 c9 d8 52 99 3d ; 09930:  99 0b 56 c9 d8 52 99 3d
            hex 3c e9 92 97 04 d8 52 99 ; 09938:  3c e9 92 97 04 d8 52 99
            hex a4 e4 7b d0 a8 e4 7b d1 ; 09940:  a4 e4 7b d0 a8 e4 7b d1
            hex b3 aa e8 7b e9 df 89 04 ; 09948:  b3 aa e8 7b e9 df 89 04

            eor ($cf,x)                 ; 09950:  41 cf
            rti                         ; 09952:  40

            hex cf 20 23 e8 f4 ff 62 e9 ; 09953:  cf 20 23 e8 f4 ff 62 e9
            hex 52 ca 02 27 62 e9 52 ca ; 0995B:  52 ca 02 27 62 e9 52 ca
            hex 02 26 0c d5 ff ff 04 00 ; 09963:  02 26 0c d5 ff ff 04 00
            hex 77 99 75 99 7d 99 81 99 ; 0996B:  77 99 75 99 7d 99 81 99
            hex 86 99 41 26 a4 f6 6f d6 ; 09973:  86 99 41 26 a4 f6 6f d6
            hex c8 99 40 d6 76 99 41 27 ; 0997B:  c8 99 40 d6 76 99 41 27
            hex d6 77 99 40 d6 82 99 a4 ; 09983:  d6 77 99 40 d6 82 99 a4
            hex f8 6f d6 bd 99 07 d8 98 ; 0998B:  f8 6f d6 bd 99 07 d8 98
            hex 99 0b d6 9d 99 a4 fa 6f ; 09993:  99 0b d6 9d 99 a4 fa 6f
            hex 1b bc 29 06 d8 a6 99 0a ; 0999B:  1b bc 29 06 d8 a6 99 0a
            hex d6 ab 99 a4 fc 6f 1a bc ; 099A3:  d6 ab 99 a4 fc 6f 1a bc
            hex 28 38 39 e9 fe 98 04 d8 ; 099AB:  28 38 39 e9 fe 98 04 d8
            hex bb 99 63 e9 10 98 02 cf ; 099B3:  bb 99 63 e9 10 98 02 cf
            hex 0a d0 2a 0a a6 fc 6f c7 ; 099BB:  0a d0 2a 0a a6 fc 6f c7
            hex d7 90 99 0b d0 2b 0b a6 ; 099C3:  d7 90 99 0b d0 2b 0b a6
            hex fa 6f c7 d7 8a 99 cf 20 ; 099CB:  fa 6f c7 d7 8a 99 cf 20
            hex 23 e8 fc ff 40 a8 e4 7b ; 099D3:  23 e8 fc ff 40 a8 e4 7b
            hex a4 e8 7b d8 e7 99 ac 65 ; 099DB:  a4 e8 7b d8 e7 99 ac 65
            hex 98 d6 0f 9a 3c e9 54 99 ; 099E3:  98 d6 0f 9a 3c e9 54 99
            hex 02 d6 0f 9a a4 e4 7b d0 ; 099EB:  02 d6 0f 9a a4 e4 7b d0
            hex a8 e4 7b d6 0f 9a ac f8 ; 099F3:  a8 e4 7b d6 0f 9a ac f8
            hex 97 d7 ef 99 65 e9 52 ca ; 099FB:  97 d7 ef 99 65 e9 52 ca
            hex 02 b3 6b e9 52 ca 02 b3 ; 09A03:  02 b3 6b e9 52 ca 02 b3
            hex e9 d9 97 04 a4 e4 7b 55 ; 09A0B:  e9 d9 97 04 a4 e4 7b 55
            hex c6 d7                   ; 09A13:  c6 d7

            sbc $cf99,y                 ; 09A15:  f9 99 cf
            jsr $e823                   ; 09A18:  20 23 e8
            inc $ff,x                   ; 09A1B:  f6 ff
            rti                         ; 09A1D:  40

tab_b2_9a1e: ; 239 bytes
            hex a8 e4 7b ac f8 97 d7 f5 ; 09A1E:  a8 e4 7b ac f8 97 d7 f5
            hex 9a a4 e4 7b d7 56 9a 8e ; 09A26:  9a a4 e4 7b d7 56 9a 8e
            hex a0 b9 e9 26 d3 02 aa e8 ; 09A2E:  a0 b9 e9 26 d3 02 aa e8
            hex 7b e9 8f 83 02 b3 e9 72 ; 09A36:  7b e9 8f 83 02 b3 e9 72
            hex d7 02 59 b5 8c a8 77 bb ; 09A3E:  d7 02 59 b5 8c a8 77 bb
            hex b3 e9 c4 ce 02 a4 e4 7b ; 09A46:  b3 e9 c4 ce 02 a4 e4 7b
            hex d0 b3 8e a6 b9 d6 65 9a ; 09A4E:  d0 b3 8e a6 b9 d6 65 9a
            hex 8d 18 67 e9 7b cc 04 a4 ; 09A56:  8d 18 67 e9 7b cc 04 a4
            hex e4 7b d0 b3 8e bf b9 e9 ; 09A5E:  e4 7b d0 b3 8e bf b9 e9
            hex 34 d1 04 a4 f8 6f d6 8c ; 09A66:  34 d1 04 a4 f8 6f d6 8c
            hex 9a a4 f6 6f d6 81 9a 62 ; 09A6E:  9a a4 f6 6f d6 81 9a 62
            hex 39 3a e9 db 82 06 d7 95 ; 09A76:  39 3a e9 db 82 06 d7 95
            hex 9a 0a d0 2a 0a a6 fa 6f ; 09A7E:  9a 0a d0 2a 0a a6 fa 6f
            hex c7 d7 75 9a 09 d0 29 09 ; 09A86:  c7 d7 75 9a 09 d0 29 09
            hex a6 fc 6f c7 d7 6f 9a 0a ; 09A8E:  a6 fc 6f c7 d7 6f 9a 0a
            hex 28 09 27 d6 c8 9a 3b de ; 09A96:  28 09 27 d6 c8 9a 3b de
            hex fa ff b3 de fc ff b3 e9 ; 09A9E:  fa ff b3 de fc ff b3 e9
            hex 44 85 06 d8 c4 9a 39 3a ; 09AA6:  44 85 06 d8 c4 9a 39 3a
            hex e9 0a 97 04 d8 c4 9a 0a ; 09AAE:  e9 0a 97 04 d8 c4 9a 0a
            hex 28 09 27 62 e9 3e d7 02 ; 09AB6:  28 09 27 62 e9 3e d7 02
            hex d6 c8 9a d6 c8 9a 08 2a ; 09ABE:  d6 c8 9a d6 c8 9a 08 2a
            hex 07 29 3a e9 0e 96 02 d7 ; 09AC6:  07 29 3a e9 0e 96 02 d7
            hex d5 9a 3a e9 be 95 02 39 ; 09ACE:  d5 9a 3a e9 be 95 02 39
            hex 3a e9 61 85 04 2b 8b 30 ; 09AD6:  3a e9 61 85 04 2b 8b 30
            hex c1 d7 9c 9a 39 3a e9 92 ; 09ADE:  c1 d7 9c 9a 39 3a e9 92
            hex 97 04 d8 c8 9a aa e4 7b ; 09AE6:  97 04 d8 c8 9a aa e4 7b
            hex aa e8 7b e9 df 89 04 a4 ; 09AEE:  aa e8 7b e9 df 89 04 a4
            hex e4 7b d0 a8 e4 7b a4 e4 ; 09AF6:  e4 7b d0 a8 e4 7b a4 e4
            hex 7b 55 c6 d7 21 9a ac 09 ; 09AFE:  7b 55 c6 d7 21 9a ac 09
            hex d3 cf 20 23 e8 fc ff    ; 09B06:  d3 cf 20 23 e8 fc ff

            ldy tab_b2_8b60+138         ; 09B0D:  ac ea 8b
            rti                         ; 09B10:  40

            hex 2b ac 75 96 2a ac ff 82 ; 09B11:  2b ac 75 96 2a ac ff 82
            hex d8 22 9b a4 e8 7b d8 2c ; 09B19:  d8 22 9b a4 e8 7b d8 2c
            hex 9b aa e8 7b e9 30 90 02 ; 09B21:  9b aa e8 7b e9 30 90 02
            hex d8 34 9b 3a e9 d2 99 02 ; 09B29:  d8 34 9b 3a e9 d2 99 02
            hex d6 37 9b ac 18 9a 41 cd ; 09B31:  d6 37 9b ac 18 9a 41 cd
            hex a4 e8 7b dc a8 e8 7b 0b ; 09B39:  a4 e8 7b dc a8 e8 7b 0b
            hex d0 2b 0b 52 c6 d7 12 9b ; 09B41:  d0 2b 0b 52 c6 d7 12 9b
            hex cf 20 23 e8 f8 ff aa e4 ; 09B49:  cf 20 23 e8 f8 ff aa e4
            hex 7b e9 0a 90 02 8f 1f b3 ; 09B51:  7b e9 0a 90 02 8f 1f b3
            hex e9 03 ca 02 a4 e8 7b 51 ; 09B59:  e9 03 ca 02 a4 e8 7b 51
            hex dc 28 3c 38 e9 8b 82 04 ; 09B61:  dc 28 3c 38 e9 8b 82 04
            hex d3 2a 3c 38 e9 9a 82 04 ; 09B69:  d3 2a 3c 38 e9 9a 82 04
            hex d3 29 3a e9 0e 96 02 d7 ; 09B71:  d3 29 3a e9 0e 96 02 d7
            hex 80 9b 3a                ; 09B79:  80 9b 3a

            sbc #$be                    ; 09B7C:  e9 be
            sta ptr1_lo,x                   ; 09B7E:  95 02
            rti                         ; 09B80:  40

            hex 2b ac b9 82 d3 b3 ac a9 ; 09B81:  2b ac b9 82 d3 b3 ac a9
            hex 82 d3 b3 e9 70 82 04 61 ; 09B89:  82 d3 b3 e9 70 82 04 61
            hex e9 0b                   ; 09B91:  e9 0b

            sty ptr1_lo                     ; 09B93:  84 02
            rts                         ; 09B95:  60

            hex e9 0b 84 02 39 3a e9 70 ; 09B96:  e9 0b 84 02 39 3a e9 70
            hex 82 04 61 e9 0b          ; 09B9E:  82 04 61 e9 0b

            sty ptr1_lo                     ; 09BA3:  84 02
            rts                         ; 09BA5:  60

tab_b2_9ba6: ; 131 bytes
            hex e9 0b 84 02 0b d0 2b 0b ; 09BA6:  e9 0b 84 02 0b d0 2b 0b
            hex 53 c6 d7 82 9b cf 20 23 ; 09BAE:  53 c6 d7 82 9b cf 20 23
            hex e8 fe ff 43 2b 3d 3c e9 ; 09BB6:  e8 fe ff 43 2b 3d 3c e9
            hex 9a 82 04 d3 b3 3d 3c e9 ; 09BBE:  9a 82 04 d3 b3 3d 3c e9
            hex 8b 82 04 d3 b3 e9 88 dc ; 09BC6:  8b 82 04 d3 b3 e9 88 dc
            hex 04 8c fe 00 da d9 03 00 ; 09BCE:  04 8c fe 00 da d9 03 00
            hex 20 00 e4 9b 10 00 e7 9b ; 09BD6:  20 00 e4 9b 10 00 e7 9b
            hex 08 00 ea 9b ed 9b 0b d1 ; 09BDE:  08 00 ea 9b ed 9b 0b d1
            hex 2b 0b d1 2b 0b d1 2b 0b ; 09BE6:  2b 0b d1 2b 0b d1 2b 0b
            hex d2 8c c2 b9 bb b0 b3 3d ; 09BEE:  d2 8c c2 b9 bb b0 b3 3d
            hex 3c e9 c9 82 04 b0 b3 e9 ; 09BF6:  3c e9 c9 82 04 b0 b3 e9
            hex 0d d7 04 53 b5 cf 20 23 ; 09BFE:  0d d7 04 53 b5 cf 20 23
            hex e8 f6 ff 3c e9 8f 83 02 ; 09C06:  e8 f6 ff 3c e9 8f 83 02
            hex 8b 1a b5 8c 13 70 bb 29 ; 09C0E:  8b 1a b5 8c 13 70 bb 29
            hex 0c d8 1e 9c 40 d6 1f 9c ; 09C16:  0c d8 1e 9c 40 d6 1f 9c
            hex 41 b3 e9 8f 83 02 8b 1a ; 09C1E:  41 b3 e9 8f 83 02 8b 1a
            hex b5 8c 13                ; 09C26:  b5 8c 13

            bvs tab_b2_9ba6+64          ; 09C29:  70 bb
            plp                         ; 09C2B:  28
            rti                         ; 09C2C:  40

tab_b2_9c2d: ; 87 bytes
            hex 2b 27 d6 5f 9c 08 72 28 ; 09C2D:  2b 27 d6 5f 9c 08 72 28
            hex 8f fe b0 b3 09 72 29 8f ; 09C35:  8f fe b0 b3 09 72 29 8f
            hex fe b0 b4 bc 2a 50 c4 d8 ; 09C3D:  fe b0 b4 bc 2a 50 c4 d8
            hex 5c 9c 0a 8b 64 b6 b3 3d ; 09C45:  5c 9c 0a 8b 64 b6 b3 3d
            hex 3c e9 c9 82 04 b0 b3 e9 ; 09C4D:  3c e9 c9 82 04 b0 b3 e9
            hex 0d d7 04 cd 07 bb 27 0b ; 09C55:  0d d7 04 cd 07 bb 27 0b
            hex d0 2b 0b 53 c6 d7 32 9c ; 09C5D:  d0 2b 0b 53 c6 d7 32 9c
            hex 07 53 b5 cf 20 23 e8 00 ; 09C65:  07 53 b5 cf 20 23 e8 00
            hex 00 3e e9 0a 90 02 b3 3d ; 09C6D:  00 3e e9 0a 90 02 b3 3d
            hex e9 0a 90 02 b4 c8 d8 86 ; 09C75:  e9 0a 90 02 b4 c8 d8 86
            hex 9c 3d 3c e9 c9 82 04    ; 09C7D:  9c 3d 3c e9 c9 82 04

            bcs tab_b2_9c2d+40          ; 09C84:  b0 cf
            rti                         ; 09C86:  40

            hex cf 20 23 e8 fc ff ac 5c ; 09C87:  cf 20 23 e8 fc ff ac 5c
            hex 8e 3d 3c e9 c9 82 04 b0 ; 09C8F:  8e 3d 3c e9 c9 82 04 b0
            hex 2b 0e 8c ee 7b bb d3 8b ; 09C97:  2b 0e 8c ee 7b bb d3 8b
            hex 14 b5 b3 3b e9 0d d7 04 ; 09C9F:  14 b5 b3 3b e9 0d d7 04
            hex b3 3c 3b e9 40 8e 04 b3 ; 09CA7:  b3 3c 3b e9 40 8e 04 b3
            hex 3e 3d 3c e9 69 9c 06 b3 ; 09CAF:  3e 3d 3c e9 69 9c 06 b3
            hex 3d 3c e9 04 9c 04 b3 3d ; 09CB7:  3d 3c e9 04 9c 04 b3 3d
            hex 3c e9 b4 9b 04 b3 3c e9 ; 09CBF:  3c e9 b4 9b 04 b3 3c e9
            hex e5 d9 02 d8 d1 9c 0b d6 ; 09CC7:  e5 d9 02 d8 d1 9c 0b d6
            hex d2 9c 40 b4 bb b4 bb b4 ; 09CCF:  d2 9c 40 b4 bb b4 bb b4
            hex bb b4 bb b4 bb 2a 3c e9 ; 09CD7:  bb b4 bb b4 bb 2a 3c e9
            hex 8f 83 02 b3 e9 8d d9 02 ; 09CDF:  8f 83 02 b3 e9 8d d9 02
            hex d8 f7 9c a4 63 6d 5f b5 ; 09CE7:  d8 f7 9c a4 63 6d 5f b5
            hex b3 89 73 b4 bc d6 f9 9c ; 09CEF:  b3 89 73 b4 bc d6 f9 9c
            hex 89 64 b3 0b 1a bb b3 e9 ; 09CF7:  89 64 b3 0b 1a bb b3 e9
            hex 0d d7 04 cf 20 23 e8 fc ; 09CFF:  0d d7 04 cf 20 23 e8 fc
            hex ff 3d 3c e9 c9 82 04 2b ; 09D07:  ff 3d 3c e9 c9 82 04 2b
            hex 0b b0 b3 0e 8b 32 c9 d8 ; 09D0F:  0b b0 b3 0e 8b 32 c9 d8
            hex 1d 9d 41 d6 1e 9d 40 b3 ; 09D17:  1d 9d 41 d6 1e 9d 40 b3
            hex 3e 0b b0 b3 e9 0d d7 04 ; 09D1F:  3e 0b b0 b3 e9 0d d7 04
            hex b4 bb 2a b4 c8 d8 32 9d ; 09D27:  b4 bb 2a b4 c8 d8 32 9d
            hex 0b b0 2a 3a 3c e9 7e 82 ; 09D2F:  0b b0 2a 3a 3c e9 7e 82
            hex 02 74 b4 b3 b0 bc b1 62 ; 09D37:  02 74 b4 b3 b0 bc b1 62
            hex 3c e9 8a 8b 04 3a 0b b4 ; 09D3F:  3c e9 8a 8b 04 3a 0b b4
            hex b3 b0 bc b1 50 c3 d8 6d ; 09D47:  b3 b0 bc b1 50 c3 d8 6d
            hex 9d 3d 3c e9 9a 82 04 d3 ; 09D4F:  9d 3d 3c e9 9a 82 04 d3
            hex b3 3d 3c e9 8b 82 04 d3 ; 09D57:  b3 3d 3c e9 8b 82 04 d3
            hex b3 e9 25 8b 04 3d 3c e9 ; 09D5F:  b3 e9 25 8b 04 3d 3c e9
            hex 97 8f 04 d6 73 9d 3d 3c ; 09D67:  97 8f 04 d6 73 9d 3d 3c
            hex e9 df 89 04 0a cf 20 23 ; 09D6F:  e9 df 89 04 0a cf 20 23
            hex e8 00 00 aa e4 7b 3c a4 ; 09D77:  e8 00 00 aa e4 7b 3c a4
            hex e8 7b 51 dc b3 e9 88 9c ; 09D7F:  e8 7b 51 dc b3 e9 88 9c
            hex 06 b3 3c aa e4 7b aa e8 ; 09D87:  06 b3 3c aa e4 7b aa e8
            hex 7b e9 88 9c 06 b3 e9 de ; 09D8F:  7b e9 88 9c 06 b3 e9 de
            hex d6 04 cf 20 23 e8 00 00 ; 09D97:  d6 04 cf 20 23 e8 00 00
            hex 3c e9 75 9d 02 8b 32 c2 ; 09D9F:  3c e9 75 9d 02 8b 32 c2
            hex cf 20 23 e8 fc ff a4 e8 ; 09DA7:  cf 20 23 e8 fc ff a4 e8
            hex 7b 51 dc 2b 68 ac b9 82 ; 09DAF:  7b 51 dc 2b 68 ac b9 82
            hex d3 b3 ac a9 82 d3 b3 e9 ; 09DB7:  d3 b3 ac a9 82 d3 b3 e9
            hex db 82 06 d8 de 9d 68 3d ; 09DBF:  db 82 06 d8 de 9d 68 3d
            hex 3b e9 9a 82 04 d3 b3 3d ; 09DC7:  3b e9 9a 82 04 d3 b3 3d
            hex 3b e9 8b 82 04 d3 b3 e9 ; 09DCF:  3b e9 8b 82 04 d3 b3 e9
            hex db 82 06 d8 de 9d cf 8e ; 09DD7:  db 82 06 d8 de 9d cf 8e
            hex ca b9 e9 26 d3 02 42 cd ; 09DDF:  ca b9 e9 26 d3 02 42 cd
            hex 0c b8 2c a4 63 6f 8b 1a ; 09DE7:  0c b8 2c a4 63 6f 8b 1a
            hex b5 8c 05 70 bb 2a 0a b0 ; 09DEF:  b5 8c 05 70 bb 2a 0a b0
            hex 1c c7 d8 02 9e 3a 40 b1 ; 09DF7:  1c c7 d8 02 9e 3a 40 b1
            hex d6 1c 9e 0a b0 1c bc b3 ; 09DFF:  d6 1c 9e 0a b0 1c bc b3
            hex 3c e9 de d6 04 b3 0a b0 ; 09E07:  3c e9 de d6 04 b3 0a b0
            hex b3 e9 0d d7 04 5a b5 b3 ; 09E0F:  b3 e9 0d d7 04 5a b5 b3
            hex 3a e9 31 ca 04 ac 1a d3 ; 09E17:  3a e9 31 ca 04 ac 1a d3
            hex cf 20 23 e8 fe ff 3c e9 ; 09E1F:  cf 20 23 e8 fe ff 3c e9
            hex 4a 9b 02 0c 8c ee 7b bb ; 09E27:  4a 9b 02 0c 8c ee 7b bb
            hex b3 d3 d0 d4 3c e9 75 9d ; 09E2F:  b3 d3 d0 d4 3c e9 75 9d
            hex 02 2b 3c 3b 3c a4 e8 7b ; 09E37:  02 2b 3c 3b 3c a4 e8 7b
            hex 51 dc b3 e9 03 9d 06 b3 ; 09E3F:  51 dc b3 e9 03 9d 06 b3
            hex 89 64 1b bc b3 aa e4 7b ; 09E47:  89 64 1b bc b3 aa e4 7b
            hex aa e8 7b e9 03 9d 06 b4 ; 09E4F:  aa e8 7b e9 03 9d 06 b4
            hex bb b3 e9 a8 9d 04 0b 8b ; 09E57:  bb b3 e9 a8 9d 04 0b 8b
            hex 32                      ; 09E5F:  32

            cpy #$d8                    ; 09E60:  c0 d8
            ror $9e                     ; 09E62:  66 9e
            rti                         ; 09E64:  40

            hex cf 0b 8b 32 c8 d8 71 9e ; 09E65:  cf 0b 8b 32 c8 d8 71 9e
            hex 41 d6 72 9e 42 cf 20 23 ; 09E6D:  41 d6 72 9e 42 cf 20 23
            hex e8 f6 ff 3d aa e8 7b e9 ; 09E75:  e8 f6 ff 3d aa e8 7b e9
            hex 7e 82 02 b4 b3 b0 bc b1 ; 09E7D:  7e 82 02 b4 b3 b0 bc b1
            hex 60 aa e8 7b e9 8a 8b 04 ; 09E85:  60 aa e8 7b e9 8a 8b 04
            hex aa e8 7b e9 8f 83 02 29 ; 09E8D:  aa e8 7b e9 8f 83 02 29
            hex a4 e8 7b 51 dc 27 b3 e9 ; 09E95:  a4 e8 7b 51 dc 27 b3 e9
            hex 8f 83 02 28 39 e9 da d7 ; 09E9D:  8f 83 02 28 39 e9 da d7
            hex 02 74 d3 b3 09 8b 1a b5 ; 09EA5:  02 74 d3 b3 09 8b 1a b5
            hex 8c 13 70 bb b0 b3 46 a6 ; 09EAD:  8c 13 70 bb b0 b3 46 a6
            hex 63 6d bc b3 e9 52 ca 02 ; 09EB5:  63 6d bc b3 e9 52 ca 02
            hex b4 bb b4 bb 2b a4 63 6d ; 09EBD:  b4 bb b4 bb 2b a4 63 6d
            hex d2 b3 38 e9 da d7 02 74 ; 09EC5:  d2 b3 38 e9 da d7 02 74
            hex d3 b3 08 8b 1a b5 8c 13 ; 09ECD:  d3 b3 08 8b 1a b5 8c 13
            hex 70 bb b0 b4 bb b4 bb 2a ; 09ED5:  70 bb b0 b4 bb b4 bb 2a
            hex a4 f3 7b d7 37 9f 0b 1a ; 09EDD:  a4 f3 7b d7 37 9f 0b 1a
            hex c4 d8 37 9f 3c 37 e9 c9 ; 09EE5:  c4 d8 37 9f 3c 37 e9 c9
            hex 82 04 b0 cd 0d b6 2d 0d ; 09EED:  82 04 b0 cd 0d b6 2d 0d
            hex 50 c4 d8 ce 9f 3b 0b 1a ; 09EF5:  50 c4 d8 ce 9f 3b 0b 1a
            hex bc b3 e9 de d6 04 b3 3c ; 09EFD:  bc b3 e9 de d6 04 b3 3c
            hex 37 e9 c9 82 04 b0 b3 e9 ; 09F05:  37 e9 c9 82 04 b0 b3 e9
            hex 0d d7 04 2b aa e8 7b e9 ; 09F0D:  0d d7 04 2b aa e8 7b e9
            hex 7e 82 02 74 b0 1b bb 8c ; 09F15:  7e 82 02 74 b0 1b bb 8c
            hex 0f 27 c4 d8 33 9f aa e8 ; 09F1D:  0f 27 c4 d8 33 9f aa e8
            hex 7b e9 7e 82 02 74 b0 b3 ; 09F25:  7b e9 7e 82 02 74 b0 b3
            hex 8a 0f 27 b4 bc 2b 0b d7 ; 09F2D:  8a 0f 27 b4 bc 2b 0b d7
            hex 58 9f 39 e9 8d d9 02 d8 ; 09F35:  58 9f 39 e9 8d d9 02 d8
            hex 46 9f aa ce b1 e9 26 d3 ; 09F3D:  46 9f aa ce b1 e9 26 d3
            hex 02 3c 37 e9 df 89 04 60 ; 09F45:  02 3c 37 e9 df 89 04 60
            hex aa e8 7b e9 df 89 04 ac ; 09F4D:  aa e8 7b e9 df 89 04 ac
            hex 1a d3 cf 3b 3c 37 e9 c9 ; 09F55:  1a d3 cf 3b 3c 37 e9 c9
            hex 82 04 b4 b3 b0 bc b1 3b ; 09F5D:  82 04 b4 b3 b0 bc b1 3b
            hex 37 e9 7e 82 02 74 b4 b3 ; 09F65:  37 e9 7e 82 02 74 b4 b3
            hex b0 bc b1 62 37 e9 8a 8b ; 09F6D:  b0 bc b1 62 37 e9 8a 8b
            hex 04 3b 60 aa e8 7b e9 c9 ; 09F75:  04 3b 60 aa e8 7b e9 c9
            hex 82 04 b4 b3 b0 bb b1 3b ; 09F7D:  82 04 b4 b3 b0 bb b1 3b
            hex aa e8 7b e9 7e 82 02 74 ; 09F85:  aa e8 7b e9 7e 82 02 74
            hex b4 b3 b0 bb b1 62 aa e8 ; 09F8D:  b4 b3 b0 bb b1 62 aa e8
            hex 7b e9 8a 8b 04 38 e9 8d ; 09F95:  7b e9 8a 8b 04 38 e9 8d
            hex d9 02 d8 a9 9f aa 9a b1 ; 09F9D:  d9 02 d8 a9 9f aa 9a b1
            hex e9 26 d3 02 39 e9 8d d9 ; 09FA5:  e9 26 d3 02 39 e9 8d d9
            hex 02 d8 c7 9f aa 96 b1 e9 ; 09FAD:  02 d8 c7 9f aa 96 b1 e9
            hex 26 d3 02 3b 8e e9 b9 e9 ; 09FB5:  26 d3 02 3b 8e e9 b9 e9
            hex 34 d1 04 aa 98 b1 e9 c4 ; 09FBD:  34 d1 04 aa 98 b1 e9 c4
            hex ce 02 41 a8 f3 7b d6 46 ; 09FC5:  ce 02 41 a8 f3 7b d6 46
            hex 9f 39 e9 8d d9 02 d8 de ; 09FCD:  9f 39 e9 8d d9 02 d8 de
            hex 9f 46 a6 63 6d bc d6 e1 ; 09FD5:  9f 46 a6 63 6d bc d6 e1
            hex 9f a4 63 6d b3 08 8b 1a ; 09FDD:  9f a4 63 6d b3 08 8b 1a
            hex b5 8c 13 70 bb b4 b3 b0 ; 09FE5:  b5 8c 13 70 bb b4 b3 b0
            hex bc b1 08 8b 1a b5 8c 13 ; 09FED:  bc b1 08 8b 1a b5 8c 13
            hex 70 bb b0 50 c3 d8 08 a0 ; 09FF5:  70 bb b0 50 c3 d8 08 a0
            hex 08 8b 1a b5 8c 13 70 bb ; 09FFD:  08 8b 1a b5 8c 13 70 bb
            hex b3 40 b1 39 e9 8d d9 02 ; 0A005:  b3 40 b1 39 e9 8d d9 02
            hex d8 c7 9f aa ca b1 e9 26 ; 0A00D:  d8 c7 9f aa ca b1 e9 26
            hex d3 02 d6 c7 9f 20 23 e8 ; 0A015:  d3 02 d6 c7 9f 20 23 e8
            hex fc ff 40 2b d6 34 a0 3a ; 0A01D:  fc ff 40 2b d6 34 a0 3a
            hex aa e8 7b e9 79 8f 04 d8 ; 0A025:  aa e8 7b e9 79 8f 04 d8
            hex 32 a0 0b d0 2b 0a d0 2a ; 0A02D:  32 a0 0b d0 2b 0a d0 2a
            hex 0a 55 c6 d7 24 a0 0b 53 ; 0A035:  0a 55 c6 d7 24 a0 0b 53

            iny                         ; 0A03D:  c8
            cld                         ; 0A03E:  d8
            pha                         ; 0A03F:  48
            ldy #$0b                    ; 0A040:  a0 0b
            cmp (ppu_queue_a_lo),y                 ; 0A042:  d1 1c
            cpy #$d7                    ; 0A044:  c0 d7
            jmp $40a0                   ; 0A046:  4c a0 40

            hex d6 4d a0 41 cf 20 23 e8 ; 0A049:  d6 4d a0 41 cf 20 23 e8
            hex 00 00 3f 3e e9 79 8f 04 ; 0A051:  00 00 3f 3e e9 79 8f 04
            hex d8 74 a0 3f 3e e9 8b 82 ; 0A059:  d8 74 a0 3f 3e e9 8b 82
            hex 04 d3 1c c0 d8 74 a0 3f ; 0A061:  04 d3 1c c0 d8 74 a0 3f
            hex 3e e9 9a 82 04 d3 1d c0 ; 0A069:  3e e9 9a 82 04 d3 1d c0
            hex d7 78 a0 40 d6 79 a0 41 ; 0A071:  d7 78 a0 40 d6 79 a0 41
            hex cf 20 23 e8 fa ff 40 2b ; 0A079:  cf 20 23 e8 fa ff 40 2b
            hex 0c 2a 0d 29 3b de fa ff ; 0A081:  0c 2a 0d 29 3b de fa ff
            hex b3 de fc ff b3 e9 03 80 ; 0A089:  b3 de fc ff b3 e9 03 80
            hex 06 d8 a2 a0 3f 3e 39 3a ; 0A091:  06 d8 a2 a0 3f 3e 39 3a
            hex e9 4e a0 08 d8 a2 a0 41 ; 0A099:  e9 4e a0 08 d8 a2 a0 41
            hex cf 0b d0 2b 0b 56 c6 d7 ; 0A0A1:  cf 0b d0 2b 0b 56 c6 d7

            sta ($a0,x)                 ; 0A0A9:  81 a0
            rti                         ; 0A0AB:  40

            hex cf 20 23 e8 fe ff a4 e8 ; 0A0AC:  cf 20 23 e8 fe ff a4 e8
            hex 7b 51 dc 2b 3c 3b e9 79 ; 0A0B4:  7b 51 dc 2b 3c 3b e9 79
            hex 8f 04 d8 d4 a0 3c 3b ac ; 0A0BC:  8f 04 d8 d4 a0 3c 3b ac
            hex b9 82 d3 b3 ac a9 82 d3 ; 0A0C4:  b9 82 d3 b3 ac a9 82 d3
            hex b3 e9 7a a0 08 d7 d8 a0 ; 0A0CC:  b3 e9 7a a0 08 d7 d8 a0
            hex 40 d6 d9 a0 41 cf 20 23 ; 0A0D4:  40 d6 d9 a0 41 cf 20 23
            hex e8 00 00 3c e9 ad a0 02 ; 0A0DC:  e8 00 00 3c e9 ad a0 02
            hex d8 f2 a0 3c 3c e9 20 9e ; 0A0E4:  d8 f2 a0 3c 3c e9 20 9e
            hex 02 b3 e9 f6 94 04 cf 20 ; 0A0EC:  02 b3 e9 f6 94 04 cf 20
            hex 23 e8 f6 ff 0e 27 40 2b ; 0A0F4:  23 e8 f6 ff 0e 27 40 2b
            hex d6 40 a1 37 89 ff d4 0c ; 0A0FC:  d6 40 a1 37 89 ff d4 0c
            hex 29 0d 28 3b de f8 ff b3 ; 0A104:  29 0d 28 3b de f8 ff b3
            hex de fa ff b3 e9 03 80 06 ; 0A10C:  de fa ff b3 e9 03 80 06
            hex d8 38 a1 40 2a 3a a4 e8 ; 0A114:  d8 38 a1 40 2a 3a a4 e8
            hex 7b 51 dc b3 38 39 e9 4e ; 0A11C:  7b 51 dc b3 38 39 e9 4e
            hex a0 08 d8 2f a1 37 0a d4 ; 0A124:  a0 08 d8 2f a1 37 0a d4
            hex d6 38 a1 0a d0 2a 0a 55 ; 0A12C:  d6 38 a1 0a d0 2a 0a 55
            hex c6 d7 19 a1 07 d0 27 d1 ; 0A134:  c6 d7 19 a1 07 d0 27 d1
            hex 0b d0 2b d1 0b 56 c6 d7 ; 0A13C:  0b d0 2b d1 0b 56 c6 d7
            hex ff a0 0e cf 20 23 e8 fc ; 0A144:  ff a0 0e cf 20 23 e8 fc
            hex ff 8a ff                ; 0A14C:  ff 8a ff

            brk                         ; 0A14F:  00
            hex 2a                      ; 0A150:  2a
            rti                         ; 0A151:  40

            hex 2b d6 8c a1 0c d3 55 c2 ; 0A152:  2b d6 8c a1 0c d3 55 c2
            hex d8 84 a1 0a 55 c6 d8 75 ; 0A15A:  d8 84 a1 0a 55 c6 d8 75
            hex a1 0a 8c ee 7b bb d3 b3 ; 0A162:  a1 0a 8c ee 7b bb d3 b3
            hex 0c d3 8c ee 7b bb d3 b4 ; 0A16A:  0c d3 8c ee 7b bb d3 b4
            hex d6 7d a1 0c d3 8c ee 7b ; 0A172:  d6 7d a1 0c d3 8c ee 7b
            hex bb d3 50 c4 d8 84 a1 0c ; 0A17A:  bb d3 50 c4 d8 84 a1 0c
            hex d3 2a 0c d0 2c d1 0b d0 ; 0A182:  d3 2a 0c d0 2c d1 0b d0
            hex 2b d1 0b 56 c6 d7 56 a1 ; 0A18A:  2b d1 0b 56 c6 d7 56 a1
            hex 0a cf 20 23 e8 ee ff 40 ; 0A192:  0a cf 20 23 e8 ee ff 40
            hex 25 ac a9 82 d3 27 ac b9 ; 0A19A:  25 ac a9 82 d3 27 ac b9
            hex 82 d3 26 35 de f4 ff b3 ; 0A1A2:  82 d3 26 35 de f4 ff b3
            hex de f6 ff b3 e9 03 80 06 ; 0A1AA:  de f6 ff b3 e9 03 80 06
            hex d8 e5 a1 de fa ff b3    ; 0A1B2:  d8 e5 a1 de fa ff b3

            rol $37,x                   ; 0A1B9:  36 37
            sbc #$f3                    ; 0A1BB:  e9 f3
            ldy #$06                    ; 0A1BD:  a0 06
            plp                         ; 0A1BF:  28
            rti                         ; 0A1C0:  40

            hex 24 08 d0 28 d1 d3 55 c2 ; 0A1C1:  24 08 d0 28 d1 d3 55 c2
            hex d7 d5 a1 04 d0 24 04 56 ; 0A1C9:  d7 d5 a1 04 d0 24 04 56
            hex c6 d7 c2 a1 04 56 c9 d8 ; 0A1D1:  c6 d7 c2 a1 04 56 c9 d8
            hex e5 a1 36 37 e9 58 90 04 ; 0A1D9:  e5 a1 36 37 e9 58 90 04
            hex d8 e5 a1 cf 05 d0 25 05 ; 0A1E1:  d8 e5 a1 cf 05 d0 25 05
            hex 56 c6 d7 9b a1 cf 20 23 ; 0A1E9:  56 c6 d7 9b a1 cf 20 23
            hex e8 00 00 3c e9 ad a0 02 ; 0A1F1:  e8 00 00 3c e9 ad a0 02
            hex d8 1f a2 0c d8 18 a2 3c ; 0A1F9:  d8 1f a2 0c d8 18 a2 3c
            hex e9 9a 9d 02 d8 18 a2 a4 ; 0A201:  e9 9a 9d 02 d8 18 a2 a4
            hex e4 7b d8 1f a2 aa e8 7b ; 0A209:  e4 7b d8 1f a2 aa e8 7b
            hex e9 6a 83 02 d7 1f       ; 0A211:  e9 6a 83 02 d7 1f

            ldx #$3c                    ; 0A217:  a2 3c
            sbc #$da                    ; 0A219:  e9 da
            ldy #$02                    ; 0A21B:  a0 02
            eor ($cf,x)                 ; 0A21D:  41 cf
            rti                         ; 0A21F:  40

            hex cf 20 23 e8 2f ff ac a9 ; 0A220:  cf 20 23 e8 2f ff ac a9
            hex 82 d3 25 ac b9 82 d3 24 ; 0A228:  82 d3 25 ac b9 82 d3 24
            hex 05 1c c0 d8 3e a2 04 1d ; 0A230:  05 1c c0 d8 3e a2 04 1d
            hex c0 d8 3e a2 40 cf 8a ff ; 0A238:  c0 d8 3e a2 40 cf 8a ff
            hex 00 2a de 2f ff 23 40    ; 0A240:  00 2a de 2f ff 23 40

            plp                         ; 0A247:  28
            rti                         ; 0A248:  40

            hex 29 03 d0 23 d1 b3 38 39 ; 0A249:  29 03 d0 23 d1 b3 38 39
            hex e9 88 dc 04 8c c2 00 da ; 0A251:  e9 88 dc 04 8c c2 00 da
            hex d8 62 a2 8a 80 00 d6 63 ; 0A259:  d8 62 a2 8a 80 00 d6 63
            hex a2 40 d4 09 d0 29 09 5b ; 0A261:  a2 40 d4 09 d0 29 09 5b
            hex c6 d7 4a a2 08 d0 28 08 ; 0A269:  c6 d7 4a a2 08 d0 28 08
            hex 55 c6 d7                ; 0A271:  55 c6 d7

            pha                         ; 0A274:  48
            ldx #$0a                    ; 0A275:  a2 0a
            hex 8c ff 00 ; sty $00ff    ; 0A277:  8c ff 00
            cpy #$d8                    ; 0A27A:  c0 d8
            lda $a2,x                   ; 0A27C:  b5 a2
            rti                         ; 0A27E:  40

            hex 2b 3b aa e8 7b e9 79 8f ; 0A27F:  2b 3b aa e8 7b e9 79 8f
            hex 04 d8 ac a2 de 2f ff b3 ; 0A287:  04 d8 ac a2 de 2f ff b3
            hex 3b aa e8 7b e9 8b 82 04 ; 0A28F:  3b aa e8 7b e9 8b 82 04
            hex d3 b3 3b aa e8 7b e9 9a ; 0A297:  d3 b3 3b aa e8 7b e9 9a
            hex 82 04 d3 5b b5 b4 bb b4 ; 0A29F:  82 04 d3 5b b5 b4 bb b4
            hex bb b3 89 80 d4 0b d0 2b ; 0A2A7:  bb b3 89 80 d4 0b d0 2b
            hex 0b 55 c6 d7 80 a2 de 2f ; 0A2AF:  0b 55 c6 d7 80 a2 de 2f
            hex ff b3 0d 5b b5 1c bb b4 ; 0A2B7:  ff b3 0d 5b b5 1c bb b4
            hex bb b3 89 ff d4 de 66 ff ; 0A2BF:  bb b3 89 ff d4 de 66 ff
            hex 22 23 02 d0 22 d1 b3 0c ; 0A2C7:  22 23 02 d0 22 d1 b3 0c
            hex d4 02 d0 22 d1 b3 0d d4 ; 0A2CF:  d4 02 d0 22 d1 b3 0d d4
            hex 02 d0 22 d1 b3 89 ff d4 ; 0A2D7:  02 d0 22 d1 b3 89 ff d4
            hex 03 d0 23 d1 d3 27 8c ff ; 0A2DF:  03 d0 23 d1 d3 27 8c ff
            hex 00 c0 d8 18 a3 de eb ff ; 0A2E7:  00 c0 d8 18 a3 de eb ff
            hex 13 c0 d8 f8 a2 de 66 ff ; 0A2EF:  13 c0 d8 f8 a2 de 66 ff
            hex 23 03 12 c0 d7 af a3 02 ; 0A2F7:  23 03 12 c0 d7 af a3 02
            hex d0 22 d1 b3 89 ff d4 de ; 0A2FF:  d0 22 d1 b3 89 ff d4 de
            hex eb ff 12 c0 d8 12 a3 de ; 0A307:  eb ff 12 c0 d8 12 a3 de
            hex 66 ff 22 03 d0 23 d1 d3 ; 0A30F:  66 ff 22 03 d0 23 d1 d3
            hex 27 de eb ff 13 c0 d8 24 ; 0A317:  27 de eb ff 13 c0 d8 24
            hex a3 de 66 ff 23 03 d0 23 ; 0A31F:  a3 de 66 ff 23 03 d0 23
            hex d1 d3 26 de eb ff 13 c0 ; 0A327:  d1 d3 26 de eb ff 13 c0
            hex d8 36 a3 de 66 ff 23 40 ; 0A32F:  d8 36 a3 de 66 ff 23 40
            hex 2b 07 29 06 28 3b de f8 ; 0A337:  2b 07 29 06 28 3b de f8
            hex ff b3 de fa ff b3 e9 03 ; 0A33F:  ff b3 de fa ff b3 e9 03
            hex 80 06 d8 a3 a3 09 15 c0 ; 0A347:  80 06 d8 a3 a3 09 15 c0
            hex d8 5c a3 08 14 c0 d8 5c ; 0A34F:  d8 5c a3 08 14 c0 d8 5c
            hex a3 46 1b bc cf de 2f ff ; 0A357:  a3 46 1b bc cf de 2f ff
            hex b3 08 5b b5 19 bb b4 bb ; 0A35F:  b3 08 5b b5 19 bb b4 bb
            hex d3 8b 10 c2 d8 a3 a3 de ; 0A367:  d3 8b 10 c2 d8 a3 a3 de
            hex 2f ff b3 08 5b b5 19 bb ; 0A36F:  2f ff b3 08 5b b5 19 bb
            hex b4 bb b3 89 ff d4 02 d0 ; 0A377:  b4 bb b3 89 ff d4 02 d0
            hex 22 d1 b3 09 d4 de eb ff ; 0A37F:  22 d1 b3 09 d4 de eb ff
            hex 12 c0 d8 90 a3 de 66 ff ; 0A387:  12 c0 d8 90 a3 de 66 ff
            hex 22 02 d0 22 d1 b3 08 d4 ; 0A38F:  22 02 d0 22 d1 b3 08 d4
            hex de eb ff 12 c0 d8 a3 a3 ; 0A397:  de eb ff 12 c0 d8 a3 a3
            hex de 66 ff 22 0b d0 2b 0b ; 0A39F:  de 66 ff 22 0b d0 2b 0b
            hex 56 c6 d7 38 a3 d6 df a2 ; 0A3A7:  56 c6 d7 38 a3 d6 df a2
            hex 41 cd 0a be 2a 0a 8b 7f ; 0A3AF:  41 cd 0a be 2a 0a 8b 7f
            hex c9 d7 42 a2 40 cf 20 23 ; 0A3B7:  c9 d7 42 a2 40 cf 20 23
            hex e8 fe ff 3d 3c e9 21 a2 ; 0A3BF:  e8 fe ff 3d 3c e9 21 a2
            hex 04 2b 50 c8 d8 f6 a3 ac ; 0A3C7:  04 2b 50 c8 d8 f6 a3 ac
            hex a9 82 d3 2c ac b9 82 d3 ; 0A3CF:  a9 82 d3 2c ac b9 82 d3
            hex 2d 0b d1 2b b3 de 0d 00 ; 0A3D7:  2d 0b d1 2b b3 de 0d 00
            hex b3 de 0b 00 b3 e9 03 80 ; 0A3DF:  b3 de 0b 00 b3 e9 03 80

            asl $d8                     ; 0A3E7:  06 d8
            inc $a3,x                   ; 0A3E9:  f6 a3
            and $e93c,x                 ; 0A3EB:  3d 3c e9
            cli                         ; 0A3EE:  58
            bcc b2_a3f4+1               ; 0A3EF:  90 04
            cld                         ; 0A3F1:  d8
            inc $a3,x                   ; 0A3F2:  f6 a3
b2_a3f4:    eor ($cf,x)                 ; 0A3F4:  41 cf
            rti                         ; 0A3F6:  40

            hex cf 20 23 e8 f4 ff a4 e4 ; 0A3F7:  cf 20 23 e8 f4 ff a4 e4
            hex 7b d7                   ; 0A3FF:  7b d7

            ora $a4                     ; 0A401:  05 a4
            rti                         ; 0A403:  40

            hex cf de f6 ff b3 60 aa e8 ; 0A404:  cf de f6 ff b3 60 aa e8
            hex 7b e9 9a 82 04 d3 b3 60 ; 0A40C:  7b e9 9a 82 04 d3 b3 60
            hex aa e8 7b e9 8b 82 04 d3 ; 0A414:  aa e8 7b e9 8b 82 04 d3
            hex b3 e9 f3 a0 06 26 40 2b ; 0A41C:  b3 e9 f3 a0 06 26 40 2b
            hex 06 d3 55 c2 d8 39 a4 06 ; 0A424:  06 d3 55 c2 d8 39 a4 06
            hex d3 b3 e9 ad a0 02 d7 39 ; 0A42C:  d3 b3 e9 ad a0 02 d7 39
            hex a4 36 89 ff d4 06 d0 26 ; 0A434:  a4 36 89 ff d4 06 d0 26
            hex d1 0b d0 2b d1 0b 56 c6 ; 0A43C:  d1 0b d0 2b d1 0b 56 c6
            hex d7 24 a4 de f6 ff b3 e9 ; 0A444:  d7 24 a4 de f6 ff b3 e9
            hex 48 a1 02 2a 55 c9 d8 ad ; 0A44C:  48 a1 02 2a 55 c9 d8 ad
            hex a4 de f6 ff 26 40 2b d6 ; 0A454:  a4 de f6 ff 26 40 2b d6
            hex 7d a4 06 d3 55 c2 d8 75 ; 0A45C:  7d a4 06 d3 55 c2 d8 75
            hex a4 06 d3 b3 e9 9a 9d 02 ; 0A464:  a4 06 d3 b3 e9 9a 9d 02
            hex d7 75 a4 06 d3 2a d6 83 ; 0A46C:  d7 75 a4 06 d3 2a d6 83
            hex a4 06 d0 26 d1 0b d0 2b ; 0A474:  a4 06 d0 26 d1 0b d0 2b
            hex d1 0b 56 c6 d7 5e a4 0a ; 0A47C:  d1 0b 56 c6 d7 5e a4 0a
            hex 55 c9 d8 ad a4 de f6 ff ; 0A484:  55 c9 d8 ad a4 de f6 ff
            hex 26 40 2b d6 a7 a4 06 d3 ; 0A48C:  26 40 2b d6 a7 a4 06 d3
            hex 55 c2 d8 9f a4 06 d3 2a ; 0A494:  55 c2 d8 9f a4 06 d3 2a
            hex d6 ad a4 06 d0 26 d1 0b ; 0A49C:  d6 ad a4 06 d0 26 d1 0b
            hex d0 2b d1 0b 56 c6 d7 92 ; 0A4A4:  d0 2b d1 0b 56 c6 d7 92

            ldy $0a                     ; 0A4AC:  a4 0a
            eor $c6,x                   ; 0A4AE:  55 c6
            cld                         ; 0A4B0:  d8
            tsx                         ; 0A4B1:  ba
            ldy $3a                     ; 0A4B2:  a4 3a
            sbc #$da                    ; 0A4B4:  e9 da
            ldy #$02                    ; 0A4B6:  a0 02
            eor ($cf,x)                 ; 0A4B8:  41 cf
            rti                         ; 0A4BA:  40

            hex cf 20 23 e8 f8 ff 40 2a ; 0A4BB:  cf 20 23 e8 f8 ff 40 2a
            hex 29 d6 e8 a4 0c d3 55 c2 ; 0A4C3:  29 d6 e8 a4 0c d3 55 c2
            hex d8 e0 a4 0c d3 b3 e9 75 ; 0A4CB:  d8 e0 a4 0c d3 b3 e9 75
            hex 9d 02 28 19 c4 d8 e0 a4 ; 0A4D3:  9d 02 28 19 c4 d8 e0 a4
            hex 08 29 0c d3 2b 0c d0 2c ; 0A4DB:  08 29 0c d3 2b 0c d0 2c
            hex d1 0a d0 2a d1 0a 56 c6 ; 0A4E3:  d1 0a d0 2a d1 0a 56 c6
            hex d7 c7 a4 09 1d c2 d8 fa ; 0A4EB:  d7 c7 a4 09 1d c2 d8 fa
            hex a4 8a ff 00 d6 fb a4 0b ; 0A4F3:  a4 8a ff 00 d6 fb a4 0b
            hex cf 20 23 e8 fa ff 89 64 ; 0A4FB:  cf 20 23 e8 fa ff 89 64

            rol a                       ; 0A503:  2a
            rti                         ; 0A504:  40

tab_b2_a505: ; 255 bytes
            hex 2b d6 27 a5 0c d3 55 c2 ; 0A505:  2b d6 27 a5 0c d3 55 c2
            hex d8 1f a5 0c d3 b3 e9 75 ; 0A50D:  d8 1f a5 0c d3 b3 e9 75
            hex 9d 02 29 1a c6 d8 1f a5 ; 0A515:  9d 02 29 1a c6 d8 1f a5
            hex 09 2a 0c d0 2c d1 0b d0 ; 0A51D:  09 2a 0c d0 2c d1 0b d0
            hex 2b d1 0b 56 c6 d7 09 a5 ; 0A525:  2b d1 0b 56 c6 d7 09 a5
            hex 0a cf 20 23 e8 f6 ff aa ; 0A52D:  0a cf 20 23 e8 f6 ff aa
            hex e4 7b e9 1a a0 02 d7 44 ; 0A535:  e4 7b e9 1a a0 02 d7 44
            hex a5 a4 e8 7b d7 48 a5 40 ; 0A53D:  a5 a4 e8 7b d7 48 a5 40
            hex d6 4a a5 89 32 27 de f8 ; 0A545:  d6 4a a5 89 32 27 de f8
            hex ff b3 ac b9 82 d3 b3 ac ; 0A54D:  ff b3 ac b9 82 d3 b3 ac
            hex a9 82 d3 b3 e9 f3 a0 06 ; 0A555:  a9 82 d3 b3 e9 f3 a0 06
            hex b3 e9 48 a1 02 2b 55 c9 ; 0A55D:  b3 e9 48 a1 02 2b 55 c9
            hex d8 72 a5 37 de f8 ff b3 ; 0A565:  d8 72 a5 37 de f8 ff b3
            hex e9 bc a4 04 2b 0b 55 c6 ; 0A56D:  e9 bc a4 04 2b 0b 55 c6
            hex d8 7e a5 3b e9 da a0 02 ; 0A575:  d8 7e a5 3b e9 da a0 02
            hex cf 60 aa e8 7b ac b9 82 ; 0A57D:  cf 60 aa e8 7b ac b9 82
            hex d3 b3 ac a9 82 d3 b3 e9 ; 0A585:  d3 b3 ac a9 82 d3 b3 e9
            hex 7a a0 08 d7 a3 a5 de f8 ; 0A58D:  7a a0 08 d7 a3 a5 de f8
            hex ff b3 e9 fc a4 02 17 c8 ; 0A595:  ff b3 e9 fc a4 02 17 c8
            hex d8 a3 a5 ac 94 a1 cf 20 ; 0A59D:  d8 a3 a5 ac 94 a1 cf 20
            hex 23 e8 f4 ff ac f8 a3 d8 ; 0A5A5:  23 e8 f4 ff ac f8 a3 d8
            hex b0 a5 cf a4 e8 7b 51 dc ; 0A5AD:  b0 a5 cf a4 e8 7b 51 dc
            hex 2a de f6 ff b3 60 aa e8 ; 0A5B5:  2a de f6 ff b3 60 aa e8
            hex 7b e9 9a 82 04 d3 b3 60 ; 0A5BD:  7b e9 9a 82 04 d3 b3 60
            hex aa e8 7b e9 8b 82 04 d3 ; 0A5C5:  aa e8 7b e9 8b 82 04 d3
            hex b3 e9 f3 a0 06 26 40 2b ; 0A5CD:  b3 e9 f3 a0 06 26 40 2b
            hex 06 d3 55 c2 d8 f8 a5 06 ; 0A5D5:  06 d3 55 c2 d8 f8 a5 06
            hex d3 b3 3a e9 9a 82 04 d3 ; 0A5DD:  d3 b3 3a e9 9a 82 04 d3
            hex b3 06 d3 b3 3a e9 8b 82 ; 0A5E5:  b3 06 d3 b3 3a e9 8b 82
            hex 04 d3 b3 e9 bd a3 04 d8 ; 0A5ED:  04 d3 b3 e9 bd a3 04 d8
            hex f8 a5 cf 06 d0 26 d1 0b ; 0A5F5:  f8 a5 cf 06 d0 26 d1 0b
            hex d0 2b d1 0b 56 c6 d7    ; 0A5FD:  d0 2b d1 0b 56 c6 d7

            cmp $a5,x                   ; 0A604:  d5 a5
            rts                         ; 0A606:  60

            hex aa e8 7b e9 9a 82 04 d3 ; 0A607:  aa e8 7b e9 9a 82 04 d3
            hex b3 60 aa e8 7b e9 8b 82 ; 0A60F:  b3 60 aa e8 7b e9 8b 82
            hex 04 d3 b3 e9 bd a3 04 d7 ; 0A617:  04 d3 b3 e9 bd a3 04 d7
            hex 24 a6 ac 2f a5 cf 20 23 ; 0A61F:  24 a6 ac 2f a5 cf 20 23
            hex e8 f2 ff ac f8 a3 d8 31 ; 0A627:  e8 f2 ff ac f8 a3 d8 31
            hex a6 cf ac a9 82 d3 28 ac ; 0A62F:  a6 cf ac a9 82 d3 28 ac
            hex b9 82 d3 27 40 25 40 d6 ; 0A637:  b9 82 d3 27 40 25 40 d6
            hex 77 a6 08 2a 07 29 3b de ; 0A63F:  77 a6 08 2a 07 29 3b de
            hex fa ff b3 de fc ff b3 e9 ; 0A647:  fa ff b3 de fc ff b3 e9
            hex 03 80 06 d8 75 a6 39 3a ; 0A64F:  03 80 06 d8 75 a6 39 3a
            hex e9 11 8f 04 d8 75 a6 39 ; 0A657:  e9 11 8f 04 d8 75 a6 39
            hex 3a e9 ec 8f 04 d7 75 a6 ; 0A65F:  3a e9 ec 8f 04 d7 75 a6
            hex 39 3a e9 19 90 04 d7 75 ; 0A667:  39 3a e9 19 90 04 d7 75
            hex a6 41 25 d6 7e a6 0b d0 ; 0A66F:  a6 41 25 d6 7e a6 0b d0
            hex 2b 0b 56 c6 d7 41 a6 a4 ; 0A677:  2b 0b 56 c6 d7 41 a6 a4
            hex e8 7b 51 dc 26 40 2b 3b ; 0A67F:  e8 7b 51 dc 26 40 2b 3b
            hex 36 e9 79 8f 04 d8 b8 a6 ; 0A687:  36 e9 79 8f 04 d8 b8 a6
            hex 05 d8 af a6 0b d7 af a6 ; 0A68F:  05 d8 af a6 0b d7 af a6
            hex 60 36 e9 9a 82 04 d3 b3 ; 0A697:  60 36 e9 9a 82 04 d3 b3
            hex 60 36 e9 8b 82 04 d3 b3 ; 0A69F:  60 36 e9 8b 82 04 d3 b3
            hex e9 bd a3 04 d8 af a6 cf ; 0A6A7:  e9 bd a3 04 d8 af a6 cf
            hex 3b e9 ef a1 02 d8 b8 a6 ; 0A6AF:  3b e9 ef a1 02 d8 b8 a6
            hex cf 0b d0 2b 0b 55 c6 d7 ; 0A6B7:  cf 0b d0 2b 0b 55 c6 d7
            hex 86 a6 ac 2f a5 cf 20 23 ; 0A6BF:  86 a6 ac 2f a5 cf 20 23
            hex e8 ec ff de ee ff b3 ac ; 0A6C7:  e8 ec ff de ee ff b3 ac
            hex b9 82 d3 b3 ac a9 82 d3 ; 0A6CF:  b9 82 d3 b3 ac a9 82 d3
            hex b3 e9 f3 a0 06 b3 e9 fc ; 0A6D7:  b3 e9 f3 a0 06 b3 e9 fc
            hex a4 02 22 02 8b 14 c6 d7 ; 0A6DF:  a4 02 22 02 8b 14 c6 d7
            hex f7 a6 60 aa e8 7b e9 c9 ; 0A6E7:  f7 a6 60 aa e8 7b e9 c9
            hex 82 04 b0 51 c3 d8 fb a6 ; 0A6EF:  82 04 b0 51 c3 d8 fb a6
            hex ac 94 a1 cf 8d 46 de ee ; 0A6F7:  ac 94 a1 cf 8d 46 de ee
            hex ff b3 e9 bc a4 04 26 55 ; 0A6FF:  ff b3 e9 bc a4 04 26 55
            hex c6 d8 11 a7 36 e9 da a0 ; 0A707:  c6 d8 11 a7 36 e9 da a0
            hex 02 cf a4 e8 7b d7 20 a7 ; 0A70F:  02 cf a4 e8 7b d7 20 a7
            hex 0c 55 c8 d8 20 a7 ac 25 ; 0A717:  0c 55 c8 d8 20 a7 ac 25
            hex a6 cf 20 23 e8 f8 ff a4 ; 0A71F:  a6 cf 20 23 e8 f8 ff a4
            hex e8 7b 51 dc 28 a4 63 6d ; 0A727:  e8 7b 51 dc 28 a4 63 6d
            hex d0 b3 e9 52 ca 02 d8 99 ; 0A72F:  d0 b3 e9 52 ca 02 d8 99
            hex a7 aa e8 7b e9 7e 82 02 ; 0A737:  a7 aa e8 7b e9 7e 82 02
            hex 74 b0 b3 aa e8 7b e9 7e ; 0A73F:  74 b0 b3 aa e8 7b e9 7e
            hex 82 02 b0 b4 c3 d7 99 a7 ; 0A747:  82 02 b0 b4 c3 d7 99 a7
            hex ac ff 82 d7 99 a7 38 e9 ; 0A74F:  ac ff 82 d7 99 a7 38 e9
            hex 8f 83 02 b3 e9 8d d9 02 ; 0A757:  8f 83 02 b3 e9 8d d9 02
            hex d8 99 a7 a4 e4 7b d7 99 ; 0A75F:  d8 99 a7 a4 e4 7b d7 99
            hex a7 38 e9 7e 82 02 74 b0 ; 0A767:  a7 38 e9 7e 82 02 74 b0
            hex 52 b6 b3 aa e8 7b e9 7e ; 0A76F:  52 b6 b3 aa e8 7b e9 7e
            hex 82 02 74 b0 b4 c4 d7 99 ; 0A777:  82 02 74 b0 b4 c4 d7 99
            hex a7 a4 63 6d 8b 64 b5 b3 ; 0A77F:  a7 a4 63 6d 8b 64 b5 b3
            hex 38 e9 8f 83 02 8b 1a b5 ; 0A787:  38 e9 8f 83 02 8b 1a b5
            hex 8c 13 70 bb b0 b4 c8 d8 ; 0A78F:  8c 13 70 bb b0 b4 c8 d8
            hex 9a a7 cf 40 2a 29 d6 c4 ; 0A797:  9a a7 cf 40 2a 29 d6 c4
            hex a7 3a 38 e9 79 8f 04 d8 ; 0A79F:  a7 3a 38 e9 79 8f 04 d8
            hex c1 a7 3a 38 e9 c9 82 04 ; 0A7A7:  c1 a7 3a 38 e9 c9 82 04
            hex b0 b3 09 b4 c2 d8 c1 a7 ; 0A7AF:  b0 b3 09 b4 c2 d8 c1 a7
            hex 0a 2b b3 38 e9 c9 82 04 ; 0A7B7:  0a 2b b3 38 e9 c9 82 04
            hex b0 29 0a d0 2a 0a 55 c6 ; 0A7BF:  b0 29 0a d0 2a 0a 55 c6
            hex d7 a0 a7 aa e8 7b e9 7e ; 0A7C7:  d7 a0 a7 aa e8 7b e9 7e
            hex 82 02 74 b0 b3 aa e8 7b ; 0A7CF:  82 02 74 b0 b3 aa e8 7b
            hex e9 7e 82 02 b0 b4 bc b3 ; 0A7D7:  e9 7e 82 02 b0 b4 bc b3
            hex 3b e9 73 9e 04 cf 20 23 ; 0A7DF:  3b e9 73 9e 04 cf 20 23
            hex e8 f2 ff de f8 ff b3 60 ; 0A7E7:  e8 f2 ff de f8 ff b3 60
            hex aa e8 7b e9 9a 82 04 d3 ; 0A7EF:  aa e8 7b e9 9a 82 04 d3
            hex b3 60 aa e8 7b e9 8b 82 ; 0A7F7:  b3 60 aa e8 7b e9 8b 82
            hex 04 d3 b3 e9 f3 a0 06 2b ; 0A7FF:  04 d3 b3 e9 f3 a0 06 2b
            hex a4 e8 7b 51 dc 26 40 27 ; 0A807:  a4 e8 7b 51 dc 26 40 27
            hex 25 d6 3a a8 0b d3 55 c2 ; 0A80F:  25 d6 3a a8 0b d3 55 c2
            hex d8 32 a8 0b d3 b3 36 e9 ; 0A817:  d8 32 a8 0b d3 b3 36 e9
            hex 79 8f 04 d8 32 a8 0b d3 ; 0A81F:  79 8f 04 d8 32 a8 0b d3
            hex b3 36 e9 c9 82 04 b0 cd ; 0A827:  b3 36 e9 c9 82 04 b0 cd
            hex 05 bb 25 07 d0 27 d1 0b ; 0A82F:  05 bb 25 07 d0 27 d1 0b
            hex d0 2b d1 07 56 c6 d7 13 ; 0A837:  d0 2b d1 07 56 c6 d7 13

            tay                         ; 0A83F:  a8
            rts                         ; 0A840:  60

            hex aa e8 7b e9 c9 82 04 b0 ; 0A841:  aa e8 7b e9 c9 82 04 b0
            hex d2 15 c6 cf 20 23 e8 fc ; 0A849:  d2 15 c6 cf 20 23 e8 fc
            hex ff a4 e4 7b d7 68 a8 aa ; 0A851:  ff a4 e4 7b d7 68 a8 aa
            hex e8 7b                   ; 0A859:  e8 7b

            sbc #$e5                    ; 0A85B:  e9 e5
            cmp $d802,y                 ; 0A85D:  d9 02 d8
            pla                         ; 0A860:  68
            tay                         ; 0A861:  a8
            ldy tab_b2_81a1+350         ; 0A862:  ac ff 82
            cld                         ; 0A865:  d8
            ror a                       ; 0A866:  6a
            tay                         ; 0A867:  a8
            rti                         ; 0A868:  40

            hex cf ac e5 a7 d7 87 a8 aa ; 0A869:  cf ac e5 a7 d7 87 a8 aa
            hex e8 7b e9 6a 83 02 d8 87 ; 0A871:  e8 7b e9 6a 83 02 d8 87
            hex a8 a4 e8 7b d7 cd a8 0c ; 0A879:  a8 a4 e8 7b d7 cd a8 0c
            hex 8b 1d c8 d8 cd a8 aa 63 ; 0A881:  8b 1d c8 d8 cd a8 aa 63
            hex 6f e9 ab da 02 aa e8 7b ; 0A889:  6f e9 ab da 02 aa e8 7b
            hex e9 8f 83 02 2b b3 e9 bb ; 0A891:  e9 8f 83 02 2b b3 e9 bb
            hex 90 02 a5 4f 6f 2a 8c ff ; 0A899:  90 02 a5 4f 6f 2a 8c ff
            hex 00 c1 d8 cd a8 0b a8 57 ; 0A8A1:  00 c1 d8 cd a8 0b a8 57
            hex 6f aa e8 7b e9 e5 d9 02 ; 0A8A9:  6f aa e8 7b e9 e5 d9 02
            hex d8 cd a8 3a 3b e9 55 8f ; 0A8B1:  d8 cd a8 3a 3b e9 55 8f
            hex 04 0a 8c f7 6c bb d3 d8 ; 0A8B9:  04 0a 8c f7 6c bb d3 d8
            hex cb a8 0a 8c f7 6c bb b3 ; 0A8C1:  cb a8 0a 8c f7 6c bb b3

            eor $d4                     ; 0A8C9:  45 d4
            eor ($cf,x)                 ; 0A8CB:  41 cf
            rti                         ; 0A8CD:  40

            hex cf 20 23 e8 00 00 3c e9 ; 0A8CE:  cf 20 23 e8 00 00 3c e9
            hex 4d a8 02 d8 de a8 41 cf ; 0A8D6:  4d a8 02 d8 de a8 41 cf
            hex ac 21 a7 a4 e4 7b d7 ef ; 0A8DE:  ac 21 a7 a4 e4 7b d7 ef
            hex a8 3c e9 c5 a6 02 d6 0c ; 0A8E6:  a8 3c e9 c5 a6 02 d6 0c
            hex a9 a4 e8 7b d8 09 a9 ac ; 0A8EE:  a9 a4 e8 7b d8 09 a9 ac
            hex f5 8e d8 09 a9 3d e9 1a ; 0A8F6:  f5 8e d8 09 a9 3d e9 1a
            hex a0 02 d7                ; 0A8FE:  a0 02 d7

            ora #$a9                    ; 0A901:  09 a9
            ldy tab_b2_a505+159         ; 0A903:  ac a4 a5
            dec $0c,x                   ; 0A906:  d6 0c
            lda #$ac                    ; 0A908:  a9 ac
            and $a6                     ; 0A90A:  25 a6
            rti                         ; 0A90C:  40

            hex cf 20 23 e8 f8 ff aa e8 ; 0A90D:  cf 20 23 e8 f8 ff aa e8
            hex 7b e9 8f 83 02 2b aa f0 ; 0A915:  7b e9 8f 83 02 2b aa f0
            hex b4 e9 26 d3 02 ac a9 82 ; 0A91D:  b4 e9 26 d3 02 ac a9 82
            hex d3 29 ac b9 82 d3 28 ac ; 0A925:  d3 29 ac b9 82 d3 28 ac
            hex a0 90 2a 8b 30 c0 d8 3b ; 0A92D:  a0 90 2a 8b 30 c0 d8 3b
            hex a9 ac 09 d3 41 cf 3a de ; 0A935:  a9 ac 09 d3 41 cf 3a de
            hex f8 ff b3 de fa ff b3 e9 ; 0A93D:  f8 ff b3 de fa ff b3 e9
            hex 28 8f 06 d8 5f a9 38 39 ; 0A945:  28 8f 06 d8 5f a9 38 39
            hex e9 11 8f 04 d8 5f a9 38 ; 0A94D:  e9 11 8f 04 d8 5f a9 38
            hex 39 e9 58 90 04 d8 5f a9 ; 0A955:  39 e9 58 90 04 d8 5f a9
            hex 40 cf aa c4 b1 e9 26 d3 ; 0A95D:  40 cf aa c4 b1 e9 26 d3
            hex 02 ac 1a d3 d6 1b a9 20 ; 0A965:  02 ac 1a d3 d6 1b a9 20
            hex 23 e8 f4 ff aa e8 7b e9 ; 0A96D:  23 e8 f4 ff aa e8 7b e9
            hex 8f 83 02 29 a4 e8 7b 51 ; 0A975:  8f 83 02 29 a4 e8 7b 51
            hex dc 2b aa f2 b4 e9 26 d3 ; 0A97D:  dc 2b aa f2 b4 e9 26 d3
            hex 02 ac a9 82 d3 27 ac b9 ; 0A985:  02 ac a9 82 d3 27 ac b9
            hex 82 d3 26 ac a0 90 28 8b ; 0A98D:  82 d3 26 ac a0 90 28 8b
            hex 30 c0 d8 9f a9 ac 09 d3 ; 0A995:  30 c0 d8 9f a9 ac 09 d3
            hex 41 cf 38 de f4 ff b3 de ; 0A99D:  41 cf 38 de f4 ff b3 de
            hex f6 ff b3 e9 28 8f 06 d8 ; 0A9A5:  f6 ff b3 e9 28 8f 06 d8
            hex ee a9 36 37 e9 11 8f 04 ; 0A9AD:  ee a9 36 37 e9 11 8f 04
            hex d8 ee a9 40 2a 3a 3b e9 ; 0A9B5:  d8 ee a9 40 2a 3a 3b e9
            hex 8b 82 04 d3 17 c0 d8 d2 ; 0A9BD:  8b 82 04 d3 17 c0 d8 d2
            hex a9 3a 3b e9 9a 82 04 d3 ; 0A9C5:  a9 3a 3b e9 9a 82 04 d3
            hex 16 c0 d7 db a9 0a d0 2a ; 0A9CD:  16 c0 d7 db a9 0a d0 2a
            hex 0a 55 c6 d7 ba a9 0a 55 ; 0A9D5:  0a 55 c6 d7 ba a9 0a 55
            hex c6 d8 ee a9 3a 3a e9 20 ; 0A9DD:  c6 d8 ee a9 3a 3a e9 20
            hex 9e 02 b3                ; 0A9E5:  9e 02 b3

            sbc #$f6                    ; 0A9E8:  e9 f6
            sty ptr2_lo,x                   ; 0A9EA:  94 04
            rti                         ; 0A9EC:  40

            hex cf aa c0 b1 e9 26 d3 02 ; 0A9ED:  cf aa c0 b1 e9 26 d3 02
            hex ac 1a d3 d6 7f a9 20 23 ; 0A9F5:  ac 1a d3 d6 7f a9 20 23
            hex e8 f8 ff aa e8 7b e9 8f ; 0A9FD:  e8 f8 ff aa e8 7b e9 8f
            hex 83 02 29 aa f4 b4 e9 26 ; 0AA05:  83 02 29 aa f4 b4 e9 26
            hex d3 02 6a e9 81 ce 02 ac ; 0AA0D:  d3 02 6a e9 81 ce 02 ac
            hex ff 82 d7 22 aa a4 48 6e ; 0AA15:  ff 82 d7 22 aa a4 48 6e
            hex 51 c0 d8 32 aa aa d4 b1 ; 0AA1D:  51 c0 d8 32 aa aa d4 b1
            hex e9 c4 ce 02 d6 62 aa aa ; 0AA25:  e9 c4 ce 02 d6 62 aa aa
            hex b8 b1 d6 25 aa a4 e4 7b ; 0AA2D:  b8 b1 d6 25 aa a4 e4 7b
            hex d7 2c aa aa a8 b1 e9 c4 ; 0AA35:  d7 2c aa aa a8 b1 e9 c4
            hex ce 02 65 61 e9 92 87 04 ; 0AA3D:  ce 02 65 61 e9 92 87 04
            hex 2a d8 a2 aa 0a d1 2a b3 ; 0AA45:  2a d8 a2 aa 0a d1 2a b3
            hex a4 e8 7b 51 dc 28 b3 e9 ; 0AA4D:  a4 e8 7b 51 dc 28 b3 e9
            hex 79 8f 04 d7 67 aa aa c2 ; 0AA55:  79 8f 04 d7 67 aa aa c2
            hex b1 e9 26 d3 02 ac 1a d3 ; 0AA5D:  b1 e9 26 d3 02 ac 1a d3
            hex 41 cf aa e8 7b e9 7e 82 ; 0AA65:  41 cf aa e8 7b e9 7e 82
            hex 02 74 b0 b3 aa e8 7b e9 ; 0AA6D:  02 74 b0 b3 aa e8 7b e9
            hex 7e 82 02 b0 b4 bc 2b 0b ; 0AA75:  7e 82 02 b0 b4 bc 2b 0b
            hex 50 c3 d8 88 aa aa cc b1 ; 0AA7D:  50 c3 d8 88 aa aa cc b1
            hex d6 5e aa aa c8 b1 e9 26 ; 0AA85:  d6 5e aa aa c8 b1 e9 26
            hex d3 02 3b 61 e9 92 87 04 ; 0AA8D:  d3 02 3b 61 e9 92 87 04
            hex 2b d8 62 aa 3b 3a e9 73 ; 0AA95:  2b d8 62 aa 3b 3a e9 73
            hex 9e 04 d6 62 aa ac 09 d3 ; 0AA9D:  9e 04 d6 62 aa ac 09 d3
            hex 41 cf 20 23 e8 fc ff aa ; 0AAA5:  41 cf 20 23 e8 fc ff aa
            hex e8 7b e9 8f 83 02 2b aa ; 0AAAD:  e8 7b e9 8f 83 02 2b aa
            hex f6 b4 e9 26 d3 02 6a e9 ; 0AAB5:  f6 b4 e9 26 d3 02 6a e9
            hex 81 ce 02 a4 e4 7b d8 d3 ; 0AABD:  81 ce 02 a4 e4 7b d8 d3
            hex aa aa b8 b1 e9 c4 ce 02 ; 0AAC5:  aa aa b8 b1 e9 c4 ce 02
            hex ac 1a d3 d6 35 ab aa aa ; 0AACD:  ac 1a d3 d6 35 ab aa aa
            hex b1 e9 c4 ce 02 ac 2a 82 ; 0AAD5:  b1 e9 c4 ce 02 ac 2a 82
            hex d8 35 ab aa 63 6f e9 ab ; 0AADD:  d8 35 ab aa 63 6f e9 ab
            hex da 02 3b e9 bb 90 02 ac ; 0AAE5:  da 02 3b e9 bb 90 02 ac
            hex 2b 91 d8 32 ab aa d0 b1 ; 0AAED:  2b 91 d8 32 ab aa d0 b1
            hex e9 c4 ce 02 ac a1 91 2a ; 0AAF5:  e9 c4 ce 02 ac a1 91 2a
            hex 8c ff 00 c1 d8 32 ab ac ; 0AAFD:  8c ff 00 c1 d8 32 ab ac
            hex 09 d3 aa d2 b1 e9 26 d3 ; 0AB05:  09 d3 aa d2 b1 e9 26 d3
            hex 02 ac 2a 82 d8 35 ab 0b ; 0AB0D:  02 ac 2a 82 d8 35 ab 0b
            hex a8 57 6f aa e8 7b e9 e5 ; 0AB15:  a8 57 6f aa e8 7b e9 e5
            hex d9 02 d8 30 ab 3a 3b e9 ; 0AB1D:  d9 02 d8 30 ab 3a 3b e9
            hex 55 8f 04 0a 8c f7 6c bb ; 0AB25:  55 8f 04 0a 8c f7 6c bb
            hex b3                      ; 0AB2D:  b3

            eor $d4                     ; 0AB2E:  45 d4
            rti                         ; 0AB30:  40

            hex cf ac 09 d3 41 cf 20 23 ; 0AB31:  cf ac 09 d3 41 cf 20 23
            hex e8 00 00 aa f8 b4 e9 26 ; 0AB39:  e8 00 00 aa f8 b4 e9 26
            hex d3 02 a4 e4 7b d7 65 ab ; 0AB41:  d3 02 a4 e4 7b d7 65 ab
            hex aa e8 7b e9 e5 d9 02 d7 ; 0AB49:  aa e8 7b e9 e5 d9 02 d7
            hex 58 ab 89 13 d6 5a ab 89 ; 0AB51:  58 ab 89 13 d6 5a ab 89
            hex 12 d2 8c 96 b1 bb b0 b3 ; 0AB59:  12 d2 8c 96 b1 bb b0 b3
            hex e9 c4 ce 02 ac 1a d3 40 ; 0AB61:  e9 c4 ce 02 ac 1a d3 40
            hex cf 20 23 e8 00 00 ac 5d ; 0AB69:  cf 20 23 e8 00 00 ac 5d
            hex 8d 8d 1a 62 e9 7b cc 04 ; 0AB71:  8d 8d 1a 62 e9 7b cc 04
            hex 8e ec b9 e9 c4 ce 02    ; 0AB79:  8e ec b9 e9 c4 ce 02

            ldy $d287                   ; 0AB80:  ac 87 d2
            ldy $cce1                   ; 0AB83:  ac e1 cc
            ldy tab_b2_890b+108         ; 0AB86:  ac 77 89
            ldy tab_b2_89a7+433         ; 0AB89:  ac 58 8b
            eor ($cf,x)                 ; 0AB8C:  41 cf
            jsr $e823                   ; 0AB8E:  20 23 e8
            brk                         ; 0AB91:  00
            hex 00                      ; 0AB92:  00
            rts                         ; 0AB93:  60

            hex 60 e9 79 8f 04 d7 a4 ab ; 0AB94:  60 e9 79 8f 04 d7 a4 ab
            hex a4 5f 6f a8 57 6f       ; 0AB9C:  a4 5f 6f a8 57 6f

            eor $cf                     ; 0ABA2:  45 cf
            rts                         ; 0ABA4:  60

            hex 61 e9 79 8f 04 d7 b5 ab ; 0ABA5:  61 e9 79 8f 04 d7 b5 ab
            hex a4 63 6f a8 57 6f       ; 0ABAD:  a4 63 6f a8 57 6f

            eor $cf                     ; 0ABB3:  45 cf
            rti                         ; 0ABB5:  40

            hex cf 20 23 e8 f8 ff 40 a8 ; 0ABB6:  cf 20 23 e8 f8 ff 40 a8
            hex e4 7b 28 29 d6 72 ac aa ; 0ABBE:  e4 7b 28 29 d6 72 ac aa
            hex e4 7b aa e8 7b e9 79 8f ; 0ABC6:  e4 7b aa e8 7b e9 79 8f
            hex 04 d8 6b ac ac ea 8b ac ; 0ABCE:  04 d8 6b ac ac ea 8b ac
            hex ff 82 d8 f4 ab aa e8 7b ; 0ABD6:  ff 82 d8 f4 ab aa e8 7b
            hex e9 8f 83 02 b3 e9 8d d9 ; 0ABDE:  e9 8f 83 02 b3 e9 8d d9
            hex 02 d7 f4 ab aa 63 6f e9 ; 0ABE6:  02 d7 f4 ab aa 63 6f e9
            hex 78 de 02 d6 06 ac aa e8 ; 0ABEE:  78 de 02 d6 06 ac aa e8
            hex 7b e9 8f 83 02 b3 e9 72 ; 0ABF6:  7b e9 8f 83 02 b3 e9 72
            hex d7 02 59 b5 8c a8 77 bb ; 0ABFE:  d7 02 59 b5 8c a8 77 bb
            hex b3 e9 26 d3 02 8e 04 ba ; 0AC06:  b3 e9 26 d3 02 8e 04 ba
            hex e9 c4 ce 02 ac 87 93 ac ; 0AC0E:  e9 c4 ce 02 ac 87 93 ac
            hex a9 82 d3 2a b3 e9 0e 96 ; 0AC16:  a9 82 d3 2a b3 e9 0e 96
            hex 02 d7 27 ac 3a e9 be 95 ; 0AC1E:  02 d7 27 ac 3a e9 be 95
            hex 02 41 2a ac b9 82 d3 b3 ; 0AC26:  02 41 2a ac b9 82 d3 b3
            hex ac a9 82 d3 b3 e9 70 82 ; 0AC2E:  ac a9 82 d3 b3 e9 70 82
            hex 04 0a 51 da b3 e9 0b 84 ; 0AC36:  04 0a 51 da b3 e9 0b 84
            hex 02 0a d0 2a 0a 57 c6 d7 ; 0AC3E:  02 0a d0 2a 0a 57 c6 d7
            hex 29 ac 41 a8 c5 7f 08 d0 ; 0AC46:  29 ac 41 a8 c5 7f 08 d0
            hex 28 d1 b3 3c e9 cf a8 04 ; 0AC4E:  28 d1 b3 3c e9 cf a8 04
            hex 2b 40 a8 c5 7f 0b d8 64 ; 0AC56:  2b 40 a8 c5 7f 0b d8 64
            hex ac 41 29 d6 7a ac ac 8e ; 0AC5E:  ac 41 29 d6 7a ac ac 8e
            hex ab 29 d7 7a ac a4 e4 7b ; 0AC66:  ab 29 d7 7a ac a4 e4 7b
            hex d0 a8 e4 7b a4 e4 7b 55 ; 0AC6E:  d0 a8 e4 7b a4 e4 7b 55
            hex c6 d7 c5 ab ac 09 d3 09 ; 0AC76:  c6 d7 c5 ab ac 09 d3 09
            hex cf 20 23 e8 f8 ff 40 a8 ; 0AC7E:  cf 20 23 e8 f8 ff 40 a8
            hex e4 7b 2a d6 2e ad aa e4 ; 0AC86:  e4 7b 2a d6 2e ad aa e4
            hex 7b aa e8 7b e9 79 8f 04 ; 0AC8E:  7b aa e8 7b e9 79 8f 04
            hex d8 27 ad a4 fb 7b 51 c1 ; 0AC96:  d8 27 ad a4 fb 7b 51 c1
            hex d8 ca ac ac f9 d2       ; 0AC9E:  d8 ca ac ac f9 d2

            ldy $d309                   ; 0ACA4:  ac 09 d3
            rti                         ; 0ACA7:  40

tab_b2_aca8: ; 235 bytes
            hex 2b 0b 7a b3 64 e9 7b cc ; 0ACA8:  2b 0b 7a b3 64 e9 7b cc
            hex 04 0b d2 8c f0 b4 bb b0 ; 0ACB0:  04 0b d2 8c f0 b4 bb b0
            hex b3 e9 c4 ce 02 0b d0 2b ; 0ACB8:  b3 e9 c4 ce 02 0b d0 2b
            hex 0b 56 c6 d7 a9 ac 41 a8 ; 0ACC0:  0b 56 c6 d7 a9 ac 41 a8
            hex fb 7b ac a9 82 d3 29 39 ; 0ACC8:  fb 7b ac a9 82 d3 29 39
            hex e9 0e 96 02 d7 dc ac 39 ; 0ACD0:  e9 0e 96 02 d7 dc ac 39
            hex e9 be 95 02 8e 18 ba e9 ; 0ACD8:  e9 be 95 02 8e 18 ba e9
            hex 26 d3 02 aa e8 7b e9 8f ; 0ACE0:  26 d3 02 aa e8 7b e9 8f
            hex 83 02 b3 e9 af d7 02 8e ; 0ACE8:  83 02 b3 e9 af d7 02 8e
            hex 19 ba e9 c4 ce 02 ac 87 ; 0ACF0:  19 ba e9 c4 ce 02 ac 87
            hex 93 ac b9 82 d3 b3 ac a9 ; 0ACF8:  93 ac b9 82 d3 b3 ac a9
            hex 82 d3 b3 e9 69 86 04 2b ; 0AD00:  82 d3 b3 e9 69 86 04 2b
            hex 0b d2 8c f8 b9 bb b0 28 ; 0AD08:  0b d2 8c f8 b9 bb b0 28
            hex 08 dd d7 99 ac 0b 53 c0 ; 0AD10:  08 dd d7 99 ac 0b 53 c0
            hex d8 20 ad 41 2a d6 36 ad ; 0AD18:  d8 20 ad 41 2a d6 36 ad
            hex ac 8e ab 2a d7 36 ad a4 ; 0AD20:  ac 8e ab 2a d7 36 ad a4
            hex e4 7b d0 a8 e4 7b a4 e4 ; 0AD28:  e4 7b d0 a8 e4 7b a4 e4
            hex 7b 55 c6 d7 8c ac 0a cf ; 0AD30:  7b 55 c6 d7 8c ac 0a cf
            hex 20 23 e8 00 00 aa 63 6f ; 0AD38:  20 23 e8 00 00 aa 63 6f
            hex e9 8d d9 02 d8 7b ad 8e ; 0AD40:  e9 8d d9 02 d8 7b ad 8e
            hex 2b ba e9 26 d3 02 aa 63 ; 0AD48:  2b ba e9 26 d3 02 aa 63
            hex 6f e9 af d7 02 8e 2c ba ; 0AD50:  6f e9 af d7 02 8e 2c ba
            hex e9 c4 ce 02 8e 39 ba e9 ; 0AD58:  e9 c4 ce 02 8e 39 ba e9
            hex c4 ce 02 ac 1a d3 cf 8e ; 0AD60:  c4 ce 02 ac 1a d3 cf 8e
            hex 31 ba e9 26 d3 02 aa 5f ; 0AD68:  31 ba e9 26 d3 02 aa 5f
            hex 6f e9 af d7 02 8e 32 ba ; 0AD70:  6f e9 af d7 02 8e 32 ba
            hex d6 58 ad aa 5f 6f e9 8d ; 0AD78:  d6 58 ad aa 5f 6f e9 8d
            hex d9 02 d7 67 ad cf 20 23 ; 0AD80:  d9 02 d7 67 ad cf 20 23
            hex e8 fc ff a4 63 6f 8b 1a ; 0AD88:  e8 fc ff a4 63 6f 8b 1a
            hex b5 8c 13                ; 0AD90:  b5 8c 13

            bvs tab_b2_aca8+168         ; 0AD93:  70 bb
            rol a                       ; 0AD95:  2a
            rti                         ; 0AD96:  40

            hex 2b 3b 60 e9 79 8f 04 d8 ; 0AD97:  2b 3b 60 e9 79 8f 04 d8
            hex c7 ad 8d 20 3b 60 e9 9a ; 0AD9F:  c7 ad 8d 20 3b 60 e9 9a
            hex 82 04 d3 b3 3b 60 e9 8b ; 0ADA7:  82 04 d3 b3 3b 60 e9 8b
            hex 82 04 d3 b3 e9 db 82 06 ; 0ADAF:  82 04 d3 b3 e9 db 82 06
            hex d7 c7 ad 62 0a b4 b3 b0 ; 0ADB7:  d7 c7 ad 62 0a b4 b3 b0
            hex b6 b1 ac 38 ad d6 d0 ad ; 0ADBF:  b6 b1 ac 38 ad d6 d0 ad
            hex 0b d0 2b 0b 55 c6 d7 98 ; 0ADC7:  0b d0 2b 0b 55 c6 d7 98
            hex ad cf 20 23 e8 fa ff    ; 0ADCF:  ad cf 20 23 e8 fa ff

            ldy tab_b2_aca8+222         ; 0ADD6:  ac 86 ad
            rti                         ; 0ADD9:  40

            rol a                       ; 0ADDA:  2a
            rti                         ; 0ADDB:  40

            hex a8 f3 7b 40 2b 0b 8c ee ; 0ADDC:  a8 f3 7b 40 2b 0b 8c ee
            hex 7b bb b3 40 d4 0b d0 2b ; 0ADE4:  7b bb b3 40 d4 0b d0 2b
            hex 0b 55 c6 d7 e1 ad ac ff ; 0ADEC:  0b 55 c6 d7 e1 ad ac ff
            hex 82 d8 fe ad a4 e8 7b d8 ; 0ADF4:  82 d8 fe ad a4 e8 7b d8
            hex 08 ae aa e8 7b e9 30 90 ; 0ADFC:  08 ae aa e8 7b e9 30 90
            hex 02 d8 10 ae 3c e9 b7 ab ; 0AE04:  02 d8 10 ae 3c e9 b7 ab
            hex 02 d6 13 ae ac 7f ac 29 ; 0AE0C:  02 d6 13 ae ac 7f ac 29
            hex 09 d7 2a ae 41 cd a4 e8 ; 0AE14:  09 d7 2a ae 41 cd a4 e8
            hex 7b dc a8 e8 7b 0a d0 2a ; 0AE1C:  7b dc a8 e8 7b 0a d0 2a
            hex 0a 52 c6 d7 db ad 09 cf ; 0AE24:  0a 52 c6 d7 db ad 09 cf
            hex 20 23 e8 f6 ff ac 20 cd ; 0AE2C:  20 23 e8 f6 ff ac 20 cd
            hex aa 57 6f e9 72 d7 02 2a ; 0AE34:  aa 57 6f e9 72 d7 02 2a
            hex a4 57 6f a6 63 6f c0 27 ; 0AE3C:  a4 57 6f a6 63 6f c0 27
            hex b3 e9 e5 d9 02 d8 69 ae ; 0AE44:  b3 e9 e5 d9 02 d8 69 ae
            hex a4 57 6f 8b 32 c1 d8 69 ; 0AE4C:  a4 57 6f 8b 32 c1 d8 69
            hex ae aa 57 6f e9 75 e2 02 ; 0AE54:  ae aa 57 6f e9 75 e2 02
            hex aa 57 6f e9 8d d9 02 d8 ; 0AE5C:  aa 57 6f e9 8d d9 02 d8
            hex 69 ae ac 35 db ac ff 82 ; 0AE64:  69 ae ac 35 db ac ff 82
            hex d8 70 ae cf 8a 89 6f 28 ; 0AE6C:  d8 70 ae cf 8a 89 6f 28
            hex 37                      ; 0AE74:  37

            sbc #$e5                    ; 0AE75:  e9 e5
            cmp $d802,y                 ; 0AE77:  d9 02 d8
            ldx $ae,y                   ; 0AE7A:  b6 ae
            rti                         ; 0AE7C:  40

            hex d6 93 ae 3b e9 72 d7 02 ; 0AE7D:  d6 93 ae 3b e9 72 d7 02
            hex 1a c0 d8 91 ae 08 d0 28 ; 0AE85:  1a c0 d8 91 ae 08 d0 28
            hex d1 b3 0b d4 0b d0 2b 0b ; 0AE8D:  d1 b3 0b d4 0b d0 2b 0b
            hex a6 9d 6d c6 d7 80 ae 38 ; 0AE95:  a6 9d 6d c6 d7 80 ae 38
            hex 89 ff d4 63 62          ; 0AE9D:  89 ff d4 63 62

            sbc #$7b                    ; 0AEA2:  e9 7b
            cpy tab_b2_8b60+676         ; 0AEA4:  cc 04 8e
            jmp $e9ba                   ; 0AEA7:  4c ba e9

            hex c4 ce 02 8a 89 6f       ; 0AEAA:  c4 ce 02 8a 89 6f

            plp                         ; 0AEB0:  28
            rti                         ; 0AEB1:  40

            hex 29 d6 f4 ae 07 d8 c6 ae ; 0AEB2:  29 d6 f4 ae 07 d8 c6 ae
            hex 08 d0 28 d1 b3 a4 63 6f ; 0AEBA:  08 d0 28 d1 b3 a4 63 6f
            hex d4 d6 9c ae cf 08 d3 b3 ; 0AEC2:  d4 d6 9c ae cf 08 d3 b3
            hex e9 8d d9 02 8c ff 00 c1 ; 0AECA:  e9 8d d9 02 8c ff 00 c1
            hex d8 f1 ae 08 d3 d0 b3 8e ; 0AED2:  d8 f1 ae 08 d3 d0 b3 8e
            hex 52 ba e9 34 d1 04 09 d0 ; 0AEDA:  52 ba e9 34 d1 04 09 d0
            hex 29 59 c0 d8 f1 ae 8e 57 ; 0AEE2:  29 59 c0 d8 f1 ae 8e 57
            hex ba e9 c4 ce 02 40 29 08 ; 0AEEA:  ba e9 c4 ce 02 40 29 08
            hex d0 28 08 d3 8c ff 00 c1 ; 0AEF2:  d0 28 08 d3 8c ff 00 c1
            hex d7 c7 ae 8e 59 ba e9 c4 ; 0AEFA:  d7 c7 ae 8e 59 ba e9 c4
            hex ce 02 aa 57 6f e9 72 d7 ; 0AF02:  ce 02 aa 57 6f e9 72 d7
            hex 02 59 b5 8c a8 77 bb b3 ; 0AF0A:  02 59 b5 8c a8 77 bb b3
            hex 8e 6b ba e9 34 d1 04 07 ; 0AF12:  8e 6b ba e9 34 d1 04 07
            hex 51 dc b3 e9 8f 83 02 b3 ; 0AF1A:  51 dc b3 e9 8f 83 02 b3
            hex e9 72 d7 02 59 b5 8c a8 ; 0AF22:  e9 72 d7 02 59 b5 8c a8
            hex 77 bb b3 8e 77 ba e9 34 ; 0AF2A:  77 bb b3 8e 77 ba e9 34
            hex d1 04 ac 59 d7 ac 20 cd ; 0AF32:  d1 04 ac 59 d7 ac 20 cd
            hex cf                      ; 0AF3A:  cf

            jsr $e823                   ; 0AF3B:  20 23 e8
            inc $60ff,x                 ; 0AF3E:  fe ff 60
            rts                         ; 0AF41:  60

            hex 6a e9 26 f2 06 0c 55 c0 ; 0AF42:  6a e9 26 f2 06 0c 55 c0
            hex d8 6a af a4 57 6f a6 63 ; 0AF4A:  d8 6a af a4 57 6f a6 63
            hex 6f c0 d8 5b af 41 d6 5c ; 0AF52:  6f c0 d8 5b af 41 d6 5c
            hex af 40 8c 65 6f bb d3 8b ; 0AF5A:  af 40 8c 65 6f bb d3 8b
            hex 1f da d7 6a af 0c d0 2c ; 0AF62:  1f da d7 6a af 0c d0 2c
            hex a4 48 6e 51 c1 d8 a2 af ; 0AF6A:  a4 48 6e 51 c1 d8 a2 af
            hex ac ff 82 d7 80 af 3c aa ; 0AF72:  ac ff 82 d7 80 af 3c aa
            hex 5f 6f e9 aa 93 04 3c aa ; 0AF7A:  5f 6f e9 aa 93 04 3c aa
            hex 63 6f e9 aa 93 04 ac 2c ; 0AF82:  63 6f e9 aa 93 04 ac 2c
            hex ae ac 3c e0 a5 a1 6d 8c ; 0AF8A:  ae ac 3c e0 a5 a1 6d 8c
            hex 80 00 da d7 e0 af aa e6 ; 0AF92:  80 00 da d7 e0 af aa e6
            hex 7b e9 f2 e5 02 d6 e0 af ; 0AF9A:  7b e9 f2 e5 02 d6 e0 af
            hex ac 20 cd 61 e9 35 cc 02 ; 0AFA2:  ac 20 cd 61 e9 35 cc 02
            hex 40 2b 0b 8c 7f ba bb d3 ; 0AFAA:  40 2b 0b 8c 7f ba bb d3
            hex b3 3b e9 8b cf 04 0b d0 ; 0AFB2:  b3 3b e9 8b cf 04 0b d0
            hex 2b 0b 8b 10 c6 d7 ac af ; 0AFBA:  2b 0b 8b 10 c6 d7 ac af
            hex 8e 9a 00 8e 10 15 8e bc ; 0AFC2:  8e 9a 00 8e 10 15 8e bc
            hex 83 64 e9 7c cf          ; 0AFCA:  83 64 e9 7c cf

            php                         ; 0AFCF:  08
            rts                         ; 0AFD0:  60

            hex e9 35 cc 02 89 32 a9 33 ; 0AFD1:  e9 35 cc 02 89 32 a9 33
            hex 6e 8d 1e e9 54 e5 02 cf ; 0AFD9:  6e 8d 1e e9 54 e5 02 cf
            hex 20 23 e8 f0 ff 43 a8 d3 ; 0AFE1:  20 23 e8 f0 ff 43 a8 d3
            hex 7f 64 e9 52 ca 02 8f 35 ; 0AFE9:  7f 64 e9 52 ca 02 8f 35
            hex a8 eb 7f ac 20 cd 62 e9 ; 0AFF1:  a8 eb 7f ac 20 cd 62 e9
            hex 03 ca 02 ac 03 89 ac 77 ; 0AFF9:  03 ca 02 ac 03 89 ac 77
            hex 89 ac ca 92 26 ac 39 8d ; 0B001:  89 ac ca 92 26 ac 39 8d
            hex a4 9d 6d 8b 32 c0 d8 1b ; 0B009:  a4 9d 6d 8b 32 c0 d8 1b
            hex b0 a4 63 6f 8c a6 fe d6 ; 0B011:  b0 a4 63 6f 8c a6 fe d6
            hex 21 b0 a4 63 6f 8c d8 fe ; 0B019:  21 b0 a4 63 6f 8c d8 fe
            hex bb d3 a8 e6 7b 06 d8 30 ; 0B021:  bb d3 a8 e6 7b 06 d8 30
            hex b0 36 e9 3b af 02 cf    ; 0B029:  b0 36 e9 3b af 02 cf

            ldy tab_b2_9a1e+234         ; 0B030:  ac 08 9b
            rti                         ; 0B033:  40

            hex 25 de fc ff b3 05 d2 b4 ; 0B034:  25 de fc ff b3 05 d2 b4
            hex bb b3 35 e9 7e 82 02 72 ; 0B03C:  bb b3 35 e9 7e 82 02 72
            hex b1 de f8 ff b3 05 d2 b4 ; 0B044:  b1 de f8 ff b3 05 d2 b4
            hex bb b3 40 b1 05 d0 25 05 ; 0B04C:  bb b3 40 b1 05 d0 25 05
            hex 52 c6 d7 35 b0 41 27 37 ; 0B054:  52 c6 d7 35 b0 41 27 37
            hex e9 39 8b 02 40 25 de fc ; 0B05C:  e9 39 8b 02 40 25 de fc
            hex ff b3 05 d2 b4 bb b0 b0 ; 0B064:  ff b3 05 d2 b4 bb b0 b0
            hex 50 c3 d8 7f b0 35 e9 8f ; 0B06C:  50 c3 d8 7f b0 35 e9 8f
            hex 83 02 a8 57 6f 64 e9 3b ; 0B074:  83 02 a8 57 6f 64 e9 3b
            hex af 02 cf 05 d0 25 05 52 ; 0B07C:  af 02 cf 05 d0 25 05 52
            hex c6 d7 62 b0 37 e9 d1 ad ; 0B084:  c6 d7 62 b0 37 e9 d1 ad
            hex 02 26 d8 97 b0 36 e9 3b ; 0B08C:  02 26 d8 97 b0 36 e9 3b
            hex af 02 cf de f8 ff b3 de ; 0B094:  af 02 cf de f8 ff b3 de
            hex fc ff b3 e9 0b 83 04 07 ; 0B09C:  fc ff b3 e9 0b 83 04 07
            hex d0 27 07 8b 1f c6 d7 5b ; 0B0A4:  d0 27 07 8b 1f c6 d7 5b
            hex b0 a4 5f 6f a8 57 6f 63 ; 0B0AC:  b0 a4 5f 6f a8 57 6f 63
            hex e9 3b af 02 cf 00 4c 4d ; 0B0B4:  e9 3b af 02 cf 00 4c 4d
            hex 4d 4d 49 4a 48 48 45 3c ; 0B0BC:  4d 4d 49 4a 48 48 45 3c
            hex 46 43 3f 3f 37 32 34 33 ; 0B0C4:  46 43 3f 3f 37 32 34 33
            hex 34 36 2f 2e 30 31 2e 2c ; 0B0CC:  34 36 2f 2e 30 31 2e 2c
            hex 2b 2a 25 26 28 27 26 29 ; 0B0D4:  2b 2a 25 26 28 27 26 29
            hex 20 21 19 19 0d 1f 20 15 ; 0B0DC:  20 21 19 19 0d 1f 20 15
            hex 17 15 0c 08 0c 09 0b 07 ; 0B0E4:  17 15 0c 08 0c 09 0b 07
            hex 03 09 0a 0b 0a 0f 0f 13 ; 0B0EC:  03 09 0a 0b 0a 0f 0f 13
            hex 12 11 18 14 1b 1a 15 11 ; 0B0F4:  12 11 18 14 1b 1a 15 11
            hex 12 14 16 1a 12 13 17 19 ; 0B0FC:  12 14 16 1a 12 13 17 19
            hex 18 1a 17 18 14 16 18 1a ; 0B104:  18 1a 17 18 14 16 18 1a
            hex 18 1f 15 16 13 14 14 18 ; 0B10C:  18 1f 15 16 13 14 14 18
            hex 1b 18 1b 1b 16 16 18 18 ; 0B114:  1b 18 1b 1b 16 16 18 18
            hex 1b 1c 63 64 67 68 65 66 ; 0B11C:  1b 1c 63 64 67 68 65 66
            hex 69 6a 6b 6c 6f 70 6d 6e ; 0B124:  69 6a 6b 6c 6f 70 6d 6e
            hex 71 72 a2 a3 a6 a7 a4 a5 ; 0B12C:  71 72 a2 a3 a6 a7 a4 a5
            hex a8 a9 aa ab ae af ac ad ; 0B134:  a8 a9 aa ab ae af ac ad
            hex b0 b1 73 74 77 78 75 76 ; 0B13C:  b0 b1 73 74 77 78 75 76
            hex 79 7a 7b 7c 7c 7f 7d 7e ; 0B144:  79 7a 7b 7c 7c 7f 7d 7e
            hex 80 81 92 93 96 97 94 95 ; 0B14C:  80 81 92 93 96 97 94 95
            hex 98 99 9a 9b 9e 9f 9c 9d ; 0B154:  98 99 9a 9b 9e 9f 9c 9d
            hex a0 a1 82 83 86 87 84 85 ; 0B15C:  a0 a1 82 83 86 87 84 85
            hex 88 89 8a 8b 8e 8f 8c 8d ; 0B164:  88 89 8a 8b 8e 8f 8c 8d
            hex 90 91 57 58 5b 5c       ; 0B16C:  90 91 57 58 5b 5c

            eor $5d5a,y                 ; 0B172:  59 5a 5d
            eor $5d5e,y                 ; 0B175:  59 5e 5d
            eor $5f5a,y                 ; 0B178:  59 5a 5f
            rts                         ; 0B17B:  60

            hex 61 62 03 03 03 03 01 01 ; 0B17C:  61 62 03 03 03 03 01 01
            hex 01 01 02 02 02 02 01 01 ; 0B184:  01 01 02 02 02 02 01 01
            hex 01 01 02 02 02 02 03 03 ; 0B18C:  01 01 02 02 02 02 03 03
            hex 03 03 d8 b1 d9 b1 f9 b1 ; 0B194:  03 03 d8 b1 d9 b1 f9 b1
            hex 17 b2 2d b2 4d b2 77 b2 ; 0B19C:  17 b2 2d b2 4d b2 77 b2
            hex 91 b2 ad b2 cc b2 e9 b2 ; 0B1A4:  91 b2 ad b2 cc b2 e9 b2
            hex f6 b2 0f b3 30 b3 31 b3 ; 0B1AC:  f6 b2 0f b3 30 b3 31 b3
            hex 32 b3 33 b3 34 b3 58 b3 ; 0B1B4:  32 b3 33 b3 34 b3 58 b3
            hex 7e b3 a2 b3 a3 b3 b3 b3 ; 0B1BC:  7e b3 a2 b3 a3 b3 b3 b3
            hex c8 b3 dd b3 fb b3 18 b4 ; 0B1C4:  c8 b3 dd b3 fb b3 18 b4
            hex 3f b4 51 b4 64 b4 7a b4 ; 0B1CC:  3f b4 51 b4 64 b4 7a b4
            hex a3 b4 c8 b4 00 20 6d 65 ; 0B1D4:  a3 b4 c8 b4 00 20 6d 65
            hex 6e 0a 68 61 76 65 0a 64 ; 0B1DC:  6e 0a 68 61 76 65 0a 64
            hex 65 73 65 72 74 65 64 0a ; 0B1E4:  65 73 65 72 74 65 64 0a
            hex 74 6f 20 6f 75 72 0a 73 ; 0B1EC:  74 6f 20 6f 75 72 0a 73
            hex 69 64 65 21 00 53 6f 6d ; 0B1F4:  69 64 65 21 00 53 6f 6d
            hex 65 20 6f 66 0a 6f 75 72 ; 0B1FC:  65 20 6f 66 0a 6f 75 72
            hex 20 6d 65 6e 0a 68 61 76 ; 0B204:  20 6d 65 6e 0a 68 61 76
            hex 65 0a 64 65 73 65 72 74 ; 0B20C:  65 0a 64 65 73 65 72 74
            hex 65 64 00 59 6f 75 0a 63 ; 0B214:  65 64 00 59 6f 75 0a 63

            adc (p1_buttons,x)                 ; 0B21C:  61 6e
            rts                         ; 0B21E:  60

            hex 74 0a 6d 6f 76 65 0a 74 ; 0B21F:  74 0a 6d 6f 76 65 0a 74
            hex 68 65 72 65 21 00 77 65 ; 0B227:  68 65 72 65 21 00 77 65
            hex 20 73 65 65 6d 0a 74 6f ; 0B22F:  20 73 65 65 6d 0a 74 6f
            hex 20 68 61 76 65 0a 74 68 ; 0B237:  20 68 61 76 65 0a 74 68
            hex 65 0a 75 70 70 65 72 0a ; 0B23F:  65 0a 75 70 70 65 72 0a
            hex 68 61 6e 64 21 00 45 6e ; 0B247:  68 61 6e 64 21 00 45 6e
            hex 65 6d 79 0a 75 6e 69 74 ; 0B24F:  65 6d 79 0a 75 6e 69 74
            hex 20 25 64 0a 68 61 73 20 ; 0B257:  20 25 64 0a 68 61 73 20
            hex 62 65 65 6e 0a 75 74 74 ; 0B25F:  62 65 65 6e 0a 75 74 74

            adc ppumask_shadow                     ; 0B267:  65 72
            jmp ($0a79)                 ; 0B269:  6c 79 0a

            hex 77 69 70 65 64 0a 6f 75 ; 0B26C:  77 69 70 65 64 0a 6f 75
            hex 74 21 00 74             ; 0B274:  74 21 00 74

            pla                         ; 0B278:  68
            adc music_voice_idx                     ; 0B279:  65 79
            rts                         ; 0B27B:  60

            hex 76 65 0a 63 6f 75 6e 74 ; 0B27C:  76 65 0a 63 6f 75 6e 74
            hex 65 72 2d 0a 61 74 74 61 ; 0B284:  65 72 2d 0a 61 74 74 61
            hex 63 6b 65 64 00 55 6e 69 ; 0B28C:  63 6b 65 64 00 55 6e 69
            hex 74 20 25 64 0a 68 61 73 ; 0B294:  74 20 25 64 0a 68 61 73
            hex 20 62 65 65 6e 0a 77 69 ; 0B29C:  20 62 65 65 6e 0a 77 69
            hex 70 65 64 0a 6f 75 74 21 ; 0B2A4:  70 65 64 0a 6f 75 74 21
            hex 00 77 65 20 68 61 76 65 ; 0B2AC:  00 77 65 20 68 61 76 65
            hex 0a 74 61 6b 65 6e 20 61 ; 0B2B4:  0a 74 61 6b 65 6e 20 61
            hex 6e 0a 65 6e 65 6d 79 0a ; 0B2BC:  6e 0a 65 6e 65 6d 79 0a
            hex 61 74 74 61 63 6b 21 00 ; 0B2C4:  61 74 74 61 63 6b 21 00
            hex 57 68 69 63 68 0a 75 6e ; 0B2CC:  57 68 69 63 68 0a 75 6e
            hex 69 74 0a 73             ; 0B2D4:  69 74 0a 73

            pla                         ; 0B2D8:  68
            adc ($6c,x)                 ; 0B2D9:  61 6c
            jmp ($7720)                 ; 0B2DB:  6c 20 77

            hex 65 0a 67 6f 20 61 66 74 ; 0B2DE:  65 0a 67 6f 20 61 66 74
            hex 65 72 00 41 72 65 20 79 ; 0B2E6:  65 72 00 41 72 65 20 79
            hex 6f 75 0a 73 75 72 65 00 ; 0B2EE:  6f 75 0a 73 75 72 65 00
            hex 57                      ; 0B2F6:  57

            adc $20                     ; 0B2F7:  65 20
            pla                         ; 0B2F9:  68
            adc ($76,x)                 ; 0B2FA:  61 76
            adc $0a                     ; 0B2FC:  65 0a
            jmp ($736f)                 ; 0B2FE:  6c 6f 73

            hex 74 0a 74 68 61 74 0a 62 ; 0B301:  74 0a 74 68 61 74 0a 62
            hex 61 74 74 6c 65 00 59 6f ; 0B309:  61 74 74 6c 65 00 59 6f
            hex 75 20 68 61 76 65 0a 74 ; 0B311:  75 20 68 61 76 65 0a 74
            hex 61 6b 65 6e 0a 74 68 65 ; 0B319:  61 6b 65 6e 0a 74 68 65
            hex 0a 65 6e 65 6d 79 0a 63 ; 0B321:  0a 65 6e 65 6d 79 0a 63
            hex 61 73 74 6c 65 21 00 00 ; 0B329:  61 73 74 6c 65 21 00 00
            hex 00 00 00 4f 6e 6c 79 20 ; 0B331:  00 00 00 4f 6e 6c 79 20
            hex 74 68 65 0a 64 61 69 6d ; 0B339:  74 68 65 0a 64 61 69 6d
            hex 79 6f 0a 6d 61 79 20 67 ; 0B341:  79 6f 0a 6d 61 79 20 67
            hex 69 76 65 0a 74 68 61 74 ; 0B349:  69 76 65 0a 74 68 61 74
            hex 0a 6f 72 64             ; 0B351:  0a 6f 72 64

            adc ppumask_shadow                     ; 0B355:  65 72
            brk                         ; 0B357:  00
            hex 0a                      ; 0B358:  0a
            jmp $726f                   ; 0B359:  4c 6f 72

            hex 64 2c 0a 79 6f 75 72 0a ; 0B35C:  64 2c 0a 79 6f 75 72 0a
            hex 73                      ; 0B364:  73

            adc (brk_scratch_lo,x)                 ; 0B365:  61 66
            adc palette_dirty                     ; 0B367:  65 74
            adc $610a,y                 ; 0B369:  79 0a 61
            jmp ($6177)                 ; 0B36C:  6c 77 61

tab_b2_b36f: ; 94 bytes
            hex 79 73 0a 63 6f 6d 65 73 ; 0B36F:  79 73 0a 63 6f 6d 65 73
            hex 0a 66 69 72 73 74 00 0a ; 0B377:  0a 66 69 72 73 74 00 0a
            hex 54 68 65 20 62 65 73 74 ; 0B37F:  54 68 65 20 62 65 73 74
            hex 0a 6f 66 66 65 6e 73 65 ; 0B387:  0a 6f 66 66 65 6e 73 65
            hex 0a 69 73 20 61 0a 67 6f ; 0B38F:  0a 69 73 20 61 0a 67 6f
            hex 6f 64 0a 64 65 66 65 6e ; 0B397:  6f 64 0a 64 65 66 65 6e
            hex 73 65 00 00 4e 6f 20 65 ; 0B39F:  73 65 00 00 4e 6f 20 65
            hex 6e 65 6d 79 0a 74 68 65 ; 0B3A7:  6e 65 6d 79 0a 74 68 65
            hex 72 65 21 00 4e 6f 20 73 ; 0B3AF:  72 65 21 00 4e 6f 20 73
            hex 75 63 68 0a 75 6e 69 74 ; 0B3B7:  75 63 68 0a 75 6e 69 74
            hex 0a 65 78 69 73 74 73 21 ; 0B3BF:  0a 65 78 69 73 74 73 21
            hex 00 59 6f 75 0a 63       ; 0B3C7:  00 59 6f 75 0a 63

            adc (p1_buttons,x)                 ; 0B3CD:  61 6e
            rts                         ; 0B3CF:  60

            hex 74 0a 6d 6f 76 65 0a 74 ; 0B3D0:  74 0a 6d 6f 76 65 0a 74
            hex 68 65 72 65 00 54 68 6f ; 0B3D8:  68 65 72 65 00 54 68 6f
            hex 73 65 0a 75 6e 69 74 73 ; 0B3E0:  73 65 0a 75 6e 69 74 73
            hex 0a 77 65 72 65 0a 77    ; 0B3E8:  0a 77 65 72 65 0a 77

            adc $6c                     ; 0B3EF:  65 6c
            jmp ($6d0a)                 ; 0B3F1:  6c 0a 6d

            hex 61 74 63 68 65 64 00 48 ; 0B3F4:  61 74 63 68 65 64 00 48
            hex 6f 77 20 6d 75 63 68 0a ; 0B3FC:  6f 77 20 6d 75 63 68 0a
            hex 67 6f 6c 64 0a 77       ; 0B404:  67 6f 6c 64 0a 77

            adc #$6c                    ; 0B40A:  69 6c
            jmp ($7920)                 ; 0B40C:  6c 20 79

            hex 6f 75 0a 6f 66 66 65 72 ; 0B40F:  6f 75 0a 6f 66 66 65 72
            hex 00 45 6e 65 6d 79 0a 73 ; 0B417:  00 45 6e 65 6d 79 0a 73
            hex 6f 6c 64 69 65 72 73    ; 0B41F:  6f 6c 64 69 65 72 73

            asl a                       ; 0B426:  0a
            pla                         ; 0B427:  68
            adc ($76,x)                 ; 0B428:  61 76
            adc $0a                     ; 0B42A:  65 0a
            jmp ($776f)                 ; 0B42C:  6c 6f 77

            hex 65 72 65 64 0a 6f 75 72 ; 0B42F:  65 72 65 64 0a 6f 75 72
            hex 0a 6d 6f 72 61 6c 65 00 ; 0B437:  0a 6d 6f 72 61 6c 65 00
            hex 59 6f 75 20 68 61 76 65 ; 0B43F:  59 6f 75 20 68 61 76 65
            hex 0a 6e 6f 20 67 6f 6c 64 ; 0B447:  0a 6e 6f 20 67 6f 6c 64
            hex 21 00 54 68 65 20 73 70 ; 0B44F:  21 00 54 68 65 20 73 70
            hex 79 0a 68 61 73 0a 66 61 ; 0B457:  79 0a 68 61 73 0a 66 61
            hex 69 6c 65 64 00 0a 46 6c ; 0B45F:  69 6c 65 64 00 0a 46 6c
            hex 65 65 20 74 6f 0a 77 68 ; 0B467:  65 65 20 74 6f 0a 77 68
            hex 69 63 68 0a 66 69 65 66 ; 0B46F:  69 63 68 0a 66 69 65 66
            hex 3f 20 00 44 6f 20 79 6f ; 0B477:  3f 20 00 44 6f 20 79 6f
            hex 75 0a 72                ; 0B47F:  75 0a 72

            adc $61                     ; 0B482:  65 61
            jmp ($796c)                 ; 0B484:  6c 6c 79

            hex 0a 77 61 6e 74          ; 0B487:  0a 77 61 6e 74

            jsr $6f74                   ; 0B48C:  20 74 6f
            asl a                       ; 0B48F:  0a
            jmp ($736f)                 ; 0B490:  6c 6f 73

            hex 65 0a 66 61 63 65 20 61 ; 0B493:  65 0a 66 61 63 65 20 61
            hex 6e 64 0a 66 6c 65 65 00 ; 0B49B:  6e 64 0a 66 6c 65 65 00
            hex 54 68 65 72 65 20 69 73 ; 0B4A3:  54 68 65 72 65 20 69 73
            hex 0a 61 6c 6d 6f 73 74 0a ; 0B4AB:  0a 61 6c 6d 6f 73 74 0a
            hex 6e 6f 0a 63 68 61 6e 63 ; 0B4B3:  6e 6f 0a 63 68 61 6e 63
            hex 65 0a 6f 66 0a 73 75 63 ; 0B4BB:  65 0a 6f 66 0a 73 75 63
            hex 63 65 73 73 00 54 68 61 ; 0B4C3:  63 65 73 73 00 54 68 61
            hex 74 0a 75 6e 69 74 20 69 ; 0B4CB:  74 0a 75 6e 69 74 20 69
            hex 73 0a 70 72 65 74 74    ; 0B4D3:  73 0a 70 72 65 74 74

            adc $770a,y                 ; 0B4DA:  79 0a 77
            adc $6c                     ; 0B4DD:  65 6c
            jmp ($740a)                 ; 0B4DF:  6c 0a 74

            hex 61 6b 65 6e 0a 63 61 72 ; 0B4E2:  61 6b 65 6e 0a 63 61 72
            hex 65 20 6f 66 21 00 fc b4 ; 0B4EA:  65 20 6f 66 21 00 fc b4
            hex 01 b5 08 b5 0e b5 13 b5 ; 0B4F2:  01 b5 08 b5 0e b5 13 b5
            hex 18 b5 4d 6f 76 65 00 41 ; 0B4FA:  18 b5 4d 6f 76 65 00 41
            hex 74 74 61 63 6b 00 42 72 ; 0B502:  74 74 61 63 6b 00 42 72
            hex 69 62 65 00 46 6c 65 65 ; 0B50A:  69 62 65 00 46 6c 65 65
            hex 00 50 61 73 73 00 56 69 ; 0B512:  00 50 61 73 73 00 56 69
            hex 65 77 00 00 3e 00 38 00 ; 0B51A:  65 77 00 00 3e 00 38 00
            hex 28 00 30 00 0a 28 59 2f ; 0B522:  28 00 30 00 0a 28 59 2f
            hex 4e 29 3f 20 00 38 39 33 ; 0B52A:  4e 29 3f 20 00 38 39 33
            hex 32 31 37 30 0a 28 25 64 ; 0B532:  32 31 37 30 0a 28 25 64
            hex 2d 25 64 29 0a 00 b4 b5 ; 0B53A:  2d 25 64 29 0a 00 b4 b5
            hex b6 b7 20 20 00 20 20 00 ; 0B542:  b6 b7 20 20 00 20 20 00
            hex 01 01 01 01 01 01 01 01 ; 0B54A:  01 01 01 01 01 01 01 01
            hex 01 01 01 01 01 01 01 01 ; 0B552:  01 01 01 01 01 01 01 01
            hex 3e 16 38 30 3e 1a 2a 3c ; 0B55A:  3e 16 38 30 3e 1a 2a 3c
            hex 3e 1c 38 30 3e 01 3c 30 ; 0B562:  3e 1c 38 30 3e 01 3c 30
            hex 0a 44 61 79 20 20 25 32 ; 0B56A:  0a 44 61 79 20 20 25 32
            hex 64 00 25 34 64 00 0a 47 ; 0B572:  64 00 25 34 64 00 0a 47
            hex 6f 6c 64 25 34 64 0a 52 ; 0B57A:  6f 6c 64 25 34 64 0a 52
            hex 69 63 65 25 34 64 0a 4d ; 0B582:  69 63 65 25 34 64 0a 4d
            hex 65 6e 20 25 34 64 00 25 ; 0B58A:  65 6e 20 25 34 64 00 25
            hex 34 64 00 2d 2d 2d 2d 00 ; 0B592:  34 64 00 2d 2d 2d 2d 00
            hex 25 34 64 00 25 34 64 00 ; 0B59A:  25 34 64 00 25 34 64 00
            hex 2d 2d 2d 2d 00 0a 46 69 ; 0B5A2:  2d 2d 2d 2d 00 0a 46 69
            hex 65 66 20 25 32 64 00 05 ; 0B5AA:  65 66 20 25 32 64 00 05
            hex 0a 0a 05 14 0a 19 0f fe ; 0B5B2:  0a 0a 05 14 0a 19 0f fe
            hex fd fb f7 ef 0a 20 55 70 ; 0B5BA:  fd fb f7 ef 0a 20 55 70
            hex 0a 20 55 70 20 52 74 0a ; 0B5C2:  0a 20 55 70 20 52 74 0a
            hex 20 44 6f 77 6e 20 52 74 ; 0B5CA:  20 44 6f 77 6e 20 52 74
            hex 0a 20 44 6f 77 6e 0a 20 ; 0B5D2:  0a 20 44 6f 77 6e 0a 20
            hex 44 6f 77 6e 20 4c 74 0a ; 0B5DA:  44 6f 77 6e 20 4c 74 0a
            hex 20 55 70 20 4c 74 00 0a ; 0B5E2:  20 55 70 20 4c 74 00 0a
            hex 48 69 74 20 61 6e 79 0a ; 0B5EA:  48 69 74 20 61 6e 79 0a
            hex 6b 65 79 00 46 69 65 66 ; 0B5F2:  6b 65 79 00 46 69 65 66
            hex 3a 0a 00 25 32 64 00 46 ; 0B5FA:  3a 0a 00 25 32 64 00 46
            hex 69 65 66 3a 0a 00 0a 54 ; 0B602:  69 65 66 3a 0a 00 0a 54
            hex 68 65 72 65 20 69 73 0a ; 0B60A:  68 65 72 65 20 69 73 0a
            hex 6e 6f 20 66 69 65 66 0a ; 0B612:  6e 6f 20 66 69 65 66 0a
            hex 74 6f 20 66 6c 65 65 0a ; 0B61A:  74 6f 20 66 6c 65 65 0a
            hex 74 6f 21 00 00 75 6e 69 ; 0B622:  74 6f 21 00 00 75 6e 69
            hex 74 20 25 64 0a 25 73 00 ; 0B62A:  74 20 25 64 0a 25 73 00
            hex 68 b6 9b b6 ba b6 fc b6 ; 0B632:  68 b6 9b b6 ba b6 fc b6
            hex 2e b7 5c b7 7c b7 b1 b7 ; 0B63A:  2e b7 5c b7 7c b7 b1 b7
            hex ce b7 f3 b7 0b b8 48 b8 ; 0B642:  ce b7 f3 b7 0b b8 48 b8
            hex 7b b8 a9 b8 bb b8 d1 b8 ; 0B64A:  7b b8 a9 b8 bb b8 d1 b8
            hex f4 b8 29 b9 4f b9 3e 12 ; 0B652:  f4 b8 29 b9 4f b9 3e 12
            hex 29 30 3e 02 12 21 3e 18 ; 0B65A:  29 30 3e 02 12 21 3e 18
            hex 29 30 3e 18 01 30 74 68 ; 0B662:  29 30 3e 18 01 30 74 68
            hex 65 20 65 6e 65 6d 79 20 ; 0B66A:  65 20 65 6e 65 6d 79 20
            hex 68 61 73 20 74 75 72 6e ; 0B672:  68 61 73 20 74 75 72 6e
            hex 65 64 0a 74             ; 0B67A:  65 64 0a 74

            adc (brk_jmp_target_hi,x)                 ; 0B67E:  61 69
            jmp ($6120)                 ; 0B680:  6c 20 61

            hex 6e 64 20 66 6c 65 64 21 ; 0B683:  6e 64 20 66 6c 65 64 21
            hex 0a 48 61 20 48 61 20 48 ; 0B68B:  0a 48 61 20 48 61 20 48
            hex 61 20 48 61 20 48 61 00 ; 0B693:  61 20 48 61 20 48 61 00
            hex 74 68 61 74 20 77 61 73 ; 0B69B:  74 68 61 74 20 77 61 73
            hex 20 74 6f 6f 20 63 6c 6f ; 0B6A3:  20 74 6f 6f 20 63 6c 6f
            hex 73 65 0a 66 6f 72 20 63 ; 0B6AB:  73 65 0a 66 6f 72 20 63
            hex 6f 6d 66 6f 72 74 00 74 ; 0B6B3:  6f 6d 66 6f 72 74 00 74
            hex 68 65 20 65 6e 65 6d 79 ; 0B6BB:  68 65 20 65 6e 65 6d 79
            hex 20 69 73 20 74 6f 6f 20 ; 0B6C3:  20 69 73 20 74 6f 6f 20
            hex 65 78 68 61 75 73 74 65 ; 0B6CB:  65 78 68 61 75 73 74 65
            hex 64 0a 74 6f 20 66 69 67 ; 0B6D3:  64 0a 74 6f 20 66 69 67
            hex 68 74 20 61 6e 79 20 6c ; 0B6DB:  68 74 20 61 6e 79 20 6c
            hex 6f 6e 67 65 72 0a 57 65 ; 0B6E3:  6f 6e 67 65 72 0a 57 65
            hex 20 68 61 76 65 20 74 72 ; 0B6EB:  20 68 61 76 65 20 74 72
            hex 69 75 6d 70 68 65 64 21 ; 0B6F3:  69 75 6d 70 68 65 64 21
            hex 00 74 68 65 20 65 6e 65 ; 0B6FB:  00 74 68 65 20 65 6e 65
            hex 6d 79 20 69 73 20 6f 75 ; 0B703:  6d 79 20 69 73 20 6f 75
            hex 74 20 6f 66 0a 70 72 6f ; 0B70B:  74 20 6f 66 0a 70 72 6f
            hex 76 69 73 69 6f 6e 73 0a ; 0B713:  76 69 73 69 6f 6e 73 0a
            hex 57 65 20 68 61 76 65 20 ; 0B71B:  57 65 20 68 61 76 65 20
            hex 74 72 69 75 6d 70 68 65 ; 0B723:  74 72 69 75 6d 70 68 65
            hex 64 21 00 72 65 6a 6f 69 ; 0B72B:  64 21 00 72 65 6a 6f 69
            hex 63 65 21 0a 49 20 67    ; 0B733:  63 65 21 0a 49 20 67

            adc #$76                    ; 0B73A:  69 76
            adc $20                     ; 0B73C:  65 20
            adc $756f,y                 ; 0B73E:  79 6f 75
            jsr $6874                   ; 0B741:  20 74 68
            adc $20                     ; 0B744:  65 20
            adc p1_buttons                     ; 0B746:  65 6e
            adc $6d                     ; 0B748:  65 6d
            adc $670a,y                 ; 0B74A:  79 0a 67
            adc p1_buttons                     ; 0B74D:  65 6e
            adc ppumask_shadow                     ; 0B74F:  65 72
            adc ($6c,x)                 ; 0B751:  61 6c
            rts                         ; 0B753:  60

            hex 73 20 68 65 61 64 21 00 ; 0B754:  73 20 68 65 61 64 21 00
            hex 74 68 65 20 65 6e 65 6d ; 0B75C:  74 68 65 20 65 6e 65 6d
            hex 79 20 68 61 73 20 62 65 ; 0B764:  79 20 68 61 73 20 62 65
            hex 65 6e 0a 61 6e 6e 69 68 ; 0B76C:  65 6e 0a 61 6e 6e 69 68
            hex 69 6c 61 74 65 64 21 00 ; 0B774:  69 6c 61 74 65 64 21 00
            hex 74 68 65 79 20 68 61 76 ; 0B77C:  74 68 65 79 20 68 61 76
            hex 65 20 6e 6f 74 20 61 20 ; 0B784:  65 20 6e 6f 74 20 61 20
            hex 73 69 6e 67 6c 65 0a 73 ; 0B78C:  73 69 6e 67 6c 65 0a 73
            hex 6f 6c 64 69 65 72 20 74 ; 0B794:  6f 6c 64 69 65 72 20 74
            hex 6f 20 73 74 61 6e 64 20 ; 0B79C:  6f 20 73 74 61 6e 64 20
            hex 61 67 61 69 6e 73 74 0a ; 0B7A4:  61 67 61 69 6e 73 74 0a
            hex 79 6f 75 21 00 74 68 69 ; 0B7AC:  79 6f 75 21 00 74 68 69
            hex 73 20 69 73 20 74 72 75 ; 0B7B4:  73 20 69 73 20 74 72 75
            hex 6c 79 20 75 6e 66 6f 72 ; 0B7BC:  6c 79 20 75 6e 66 6f 72
            hex 74 75 6e 61 74 65 2e 2e ; 0B7C4:  74 75 6e 61 74 65 2e 2e
            hex 2e 00 73 6f             ; 0B7CC:  2e 00 73 6f

            adc $6465                   ; 0B7D0:  6d 65 64
            adc (music_voice_idx,x)                 ; 0B7D3:  61 79
            jsr $6577                   ; 0B7D5:  20 77 65
            jsr $6977                   ; 0B7D8:  20 77 69
            jmp ($206c)                 ; 0B7DB:  6c 6c 20

            hex 61 76 65 6e 67 65 20 74 ; 0B7DE:  61 76 65 6e 67 65 20 74
            hex 68 69 73 0a 6f 75 74 72 ; 0B7E6:  68 69 73 0a 6f 75 74 72
            hex 61 67 65 21 00 79 6f 75 ; 0B7EE:  61 67 65 21 00 79 6f 75
            hex 72 20 6d 65 6e 20 61 72 ; 0B7F6:  72 20 6d 65 6e 20 61 72
            hex 65 20 65 78 68 61 75 73 ; 0B7FE:  65 20 65 78 68 61 75 73
            hex 74 65 64 21 00 73 75 70 ; 0B806:  74 65 64 21 00 73 75 70
            hex 70 6c 79 20 72 65 70 6f ; 0B80E:  70 6c 79 20 72 65 70 6f
            hex 72 74 73 20 74 68 61 74 ; 0B816:  72 74 73 20 74 68 61 74
            hex 20 77 65 20 61 72 65 0a ; 0B81E:  20 77 65 20 61 72 65 0a
            hex 6f 75 74 20 6f 66 20 72 ; 0B826:  6f 75 74 20 6f 66 20 72
            hex 69 63 65 0a 54 68 65 20 ; 0B82E:  69 63 65 0a 54 68 65 20
            hex 6d 65 6e 20 63 61 6e 6e ; 0B836:  6d 65 6e 20 63 61 6e 6e
            hex 6f 74 20 67 6f 20 6f 6e ; 0B83E:  6f 74 20 67 6f 20 6f 6e
            hex 21 00 74 68 65 20 63 6f ; 0B846:  21 00 74 68 65 20 63 6f
            hex 6d 6d 61 6e 64 20 75 6e ; 0B84E:  6d 6d 61 6e 64 20 75 6e
            hex 69 74 20 68 61 73 20 62 ; 0B856:  69 74 20 68 61 73 20 62
            hex 65 65 6e 0a 64 65 73 74 ; 0B85E:  65 65 6e 0a 64 65 73 74
            hex 72 6f 79 65 64 21 0a 57 ; 0B866:  72 6f 79 65 64 21 0a 57

            adc $20                     ; 0B86E:  65 20
            pla                         ; 0B870:  68
            adc ($76,x)                 ; 0B871:  61 76
            adc $20                     ; 0B873:  65 20
            jmp ($736f)                 ; 0B875:  6c 6f 73

            hex 74 21 00 6e 6f 74 20 61 ; 0B878:  74 21 00 6e 6f 74 20 61
            hex 20 73 69 6e 67 6c 65 20 ; 0B880:  20 73 69 6e 67 6c 65 20
            hex 73 6f 6c 64 69 65 72 0a ; 0B888:  73 6f 6c 64 69 65 72 0a
            hex 72 65 6d 61 69 6e 73 0a ; 0B890:  72 65 6d 61 69 6e 73 0a
            hex 57 65 20 61 72 65 20 66 ; 0B898:  57 65 20 61 72 65 20 66
            hex 69 6e 69 73 68 65 64 21 ; 0B8A0:  69 6e 69 73 68 65 64 21
            hex 00 79 6f 75 20 68 61 76 ; 0B8A8:  00 79 6f 75 20 68 61 76
            hex 65 20 6e 6f 20 72 69 63 ; 0B8B0:  65 20 6e 6f 20 72 69 63
            hex 65 21 00 79 6f 75 20 68 ; 0B8B8:  65 21 00 79 6f 75 20 68
            hex 61 76 65 20 6e 6f 20 73 ; 0B8C0:  61 76 65 20 6e 6f 20 73
            hex 6f 6c 64 69 65 72 73 21 ; 0B8C8:  6f 6c 64 69 65 72 73 21
            hex 00 20 69 73 20 6f 75 74 ; 0B8D0:  00 20 69 73 20 6f 75 74
            hex 20 6f 66 20 72 69 63 65 ; 0B8D8:  20 6f 66 20 72 69 63 65
            hex 0a 61 6e 64 20 6d 75 73 ; 0B8E0:  0a 61 6e 64 20 6d 75 73
            hex 74 20 73 75 72 72 65 6e ; 0B8E8:  74 20 73 75 72 72 65 6e
            hex 64 65 72 00 60 73 0a 63 ; 0B8F0:  64 65 72 00 60 73 0a 63
            hex 6f 6d 6d 61 6e 64 20 75 ; 0B8F8:  6f 6d 6d 61 6e 64 20 75
            hex 6e 69 74 20 68 61 73 20 ; 0B900:  6e 69 74 20 68 61 73 20
            hex 62 65 65 6e 0a 77 69 70 ; 0B908:  62 65 65 6e 0a 77 69 70
            hex 65 64 20 6f 75 74 0a 54 ; 0B910:  65 64 20 6f 75 74 0a 54
            hex 68 65 20 66 69 67 68 74 ; 0B918:  68 65 20 66 69 67 68 74
            hex 20 69 73 20 6f 76 65 72 ; 0B920:  20 69 73 20 6f 76 65 72
            hex 00 60 73 0a 6d 65 6e 20 ; 0B928:  00 60 73 0a 6d 65 6e 20
            hex 68 61 76 65 20 62 65 65 ; 0B930:  68 61 76 65 20 62 65 65
            hex 6e 20 63 6f 6d 70 6c 65 ; 0B938:  6e 20 63 6f 6d 70 6c 65
            hex 74 65 6c 79 0a 64 65 73 ; 0B940:  74 65 6c 79 0a 64 65 73
            hex 74 72 6f                ; 0B948:  74 72 6f

            adc $6465,y                 ; 0B94B:  79 65 64
            brk                         ; 0B94E:  00
            hex 20                      ; 0B94F:  20
            pla                         ; 0B950:  68
            adc (kernel_var_73,x)                 ; 0B951:  61 73
            jsr $6f6e                   ; 0B953:  20 6e 6f
            jsr $6f73                   ; 0B956:  20 73 6f
            jmp ($6964)                 ; 0B959:  6c 64 69

            hex 65 72 73 0a 48 65 20 68 ; 0B95C:  65 72 73 0a 48 65 20 68
            hex 61 73 20 6c 6f 73 74 00 ; 0B964:  61 73 20 6c 6f 73 74 00
            hex 0a 00 25 73 20 68 61 73 ; 0B96C:  0a 00 25 73 20 68 61 73
            hex 20 72 65 74 72 65 61 74 ; 0B974:  20 72 65 74 72 65 61 74
            hex 65 64 00 25 73 20 68 75 ; 0B97C:  65 64 00 25 73 20 68 75
            hex 6e 67 20 6f 6e 20 74 6f ; 0B984:  6e 67 20 6f 6e 20 74 6f
            hex 20 74 68 65 20 65 6e 64 ; 0B98C:  20 74 68 65 20 65 6e 64
            hex 0a 61 6e 64             ; 0B994:  0a 61 6e 64

            jsr $6f77                   ; 0B998:  20 77 6f
            hex 6e 00 00 ; ror ptr0_lo    ; 0B99B:  6e 00 00
            brk                         ; 0B99E:  00
            hex 00                      ; 0B99F:  00
            jmp $726f                   ; 0B9A0:  4c 6f 72

            hex 64 0a 00 0a 50 6c 65 61 ; 0B9A3:  64 0a 00 0a 50 6c 65 61
            hex 73 65 0a 70 6f 73 69 74 ; 0B9AB:  73 65 0a 70 6f 73 69 74
            hex 69 6f 6e 0a 75 6e 69 74 ; 0B9B3:  69 6f 6e 0a 75 6e 69 74
            hex 20 25 64 00 25 64 00 5a ; 0B9BB:  20 25 64 00 25 64 00 5a
            hex 00 14 00 0a 00 00 00 54 ; 0B9C3:  00 14 00 0a 00 00 00 54
            hex 68 65 0a 74 6f 77 6e 0a ; 0B9CB:  68 65 0a 74 6f 77 6e 0a
            hex 69 73 20 69 6e 0a 63 6f ; 0B9D3:  69 73 20 69 6e 0a 63 6f
            hex 6d 70 6c 65 74 65 0a 63 ; 0B9DB:  6d 70 6c 65 74 65 0a 63
            hex 68 61 6f 73 21 00 25 64 ; 0B9E3:  68 61 6f 73 21 00 25 64
            hex 00 48 69 74 20 61 6e 79 ; 0B9EB:  00 48 69 74 20 61 6e 79
            hex 20 6b 65 79 00 0e a9 6c ; 0B9F3:  20 6b 65 79 00 0e a9 6c
            hex a9 fb a9 a7 aa 37 ab 6a ; 0B9FB:  a9 fb a9 a7 aa 37 ab 6a
            hex ab 0a 47 69 76 69 6e 67 ; 0BA03:  ab 0a 47 69 76 69 6e 67
            hex 0a 6f 72 64 65 72 73 0a ; 0BA0B:  0a 6f 72 64 65 72 73 0a
            hex 66 6f 72 0a 00 00 0a 59 ; 0BA13:  66 6f 72 0a 00 00 0a 59
            hex 6f 75 72 0a 6f 72 64 65 ; 0BA1B:  6f 75 72 0a 6f 72 64 65
            hex 72 73 0a 66 6f 72 0a 00 ; 0BA23:  72 73 0a 66 6f 72 0a 00
            hex 00 0a 6f                ; 0BA2B:  00 0a 6f

            adc ppumask_shadow,x                   ; 0BA2E:  75 72
            brk                         ; 0BA30:  00
            hex 00                      ; 0BA31:  00
            asl a                       ; 0BA32:  0a
            adc p1_buttons                     ; 0BA33:  65 6e
            adc $6d                     ; 0BA35:  65 6d
            adc $0a00,y                 ; 0BA37:  79 00 0a
            adc $726f                   ; 0BA3A:  6d 6f 72
            adc ($6c,x)                 ; 0BA3D:  61 6c
            adc $0a                     ; 0BA3F:  65 0a
            adc #$73                    ; 0BA41:  69 73
            asl a                       ; 0BA43:  0a
            ror $61                     ; 0BA44:  66 61
            jmp ($696c)                 ; 0BA46:  6c 6c 69

            hex 6e 67 00 46 69 65 66 0a ; 0BA49:  6e 67 00 46 69 65 66 0a
            hex 00 20 25 32 64 00 0a 00 ; 0BA51:  00 20 25 32 64 00 0a 00
            hex 0a 68 61 73 20 70 61 73 ; 0BA59:  0a 68 61 73 20 70 61 73
            hex 73 65 64 20 66 72 6f    ; 0BA61:  73 65 64 20 66 72 6f

            hex 6d 0a 00 ; adc $000a    ; 0BA68:  6d 0a 00
            jmp $726f                   ; 0BA6B:  4c 6f 72

            hex 64 20 25 73 20 74 6f 0a ; 0BA6E:  64 20 25 73 20 74 6f 0a
            hex 00 4c 6f 72 64 20 25 73 ; 0BA76:  00 4c 6f 72 64 20 25 73
            hex 00 3e 12 29 30 3e 02 12 ; 0BA7E:  00 3e 12 29 30 3e 02 12
            hex 21 3e 18 29 30 3e 18 01 ; 0BA86:  21 3e 18 29 30 3e 18 01
            hex 30 00 ff ff ff ff ff ff ; 0BA8E:  30 00 ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BA96:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BA9E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAA6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAAE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAB6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BABE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAC6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BACE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAD6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BADE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAE6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAEE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAF6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BAFE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB06:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB0E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB16:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB1E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB26:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB2E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB36:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB3E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB46:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB4E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB56:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB5E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB66:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB6E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB76:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB7E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB86:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB8E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB96:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BB9E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBA6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBAE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBB6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBBE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBC6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBCE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBD6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBDE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBE6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBEE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBF6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BBFE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC06:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC0E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC16:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC1E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC26:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC2E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC36:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC3E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC46:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC4E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC56:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC5E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC66:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC6E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC76:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC7E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC86:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC8E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC96:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BC9E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCA6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCAE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCB6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCBE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCC6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCCE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCD6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCDE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCE6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCEE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCF6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BCFE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD06:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD0E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD16:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD1E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD26:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD2E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD36:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD3E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD46:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD4E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD56:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD5E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD66:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD6E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD76:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD7E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD86:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD8E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD96:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BD9E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDA6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDAE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDB6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDBE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDC6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDCE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDD6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDDE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDE6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDEE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDF6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BDFE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE06:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE0E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE16:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE1E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE26:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE2E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE36:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE3E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE46:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE4E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE56:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE5E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE66:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE6E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE76:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE7E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE86:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE8E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE96:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BE9E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEA6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEAE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEB6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEBE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEC6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BECE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BED6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEDE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEE6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEEE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEF6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BEFE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF06:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF0E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF16:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF1E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF26:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF2E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF36:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF3E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF46:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF4E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF56:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF5E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF66:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF6E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF76:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF7E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF86:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF8E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF96:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BF9E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFA6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFAE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFB6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFBE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFC6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFCE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFD6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFDE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFE6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFEE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 0BFF6:  ff ff ff ff ff ff ff ff
            hex ff ff                   ; 0BFFE:  ff ff

