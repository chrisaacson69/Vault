.base $8000

bank0_entry:
            hex 4c 78 a7 20 23 e8 fa ff ; 00000:  4c 78 a7 20 23 e8 fa ff
            hex 60 60 6a e9 26 f2 06 ac ; 00008:  60 60 6a e9 26 f2 06 ac
            hex 20 cd ac 28 d6 d8 1c 81 ; 00010:  20 cd ac 28 d6 d8 1c 81
            hex 61 e9 35 cc 02 8e ae 00 ; 00018:  61 e9 35 cc 02 8e ae 00
            hex 8e 10 15 8e 54 90 66 e9 ; 00020:  8e 10 15 8e 54 90 66 e9
            hex 7c cf 08 66 8e 74       ; 00028:  7c cf 08 66 8e 74

            sta $168d                   ; 0002E:  8d 8d 16
            sta $601f                   ; 00031:  8d 1f 60
            rts                         ; 00034:  60

            hex e9 54 cc 0c 61 6d 8d 11 ; 00035:  e9 54 cc 0c 61 6d 8d 11
            hex 68 8d 10 e9 6a cf 0a 61 ; 0003D:  68 8d 10 e9 6a cf 0a 61
            hex 8d 1a 8d 1f 8d 18 62 e9 ; 00045:  8d 1a 8d 1f 8d 18 62 e9
            hex 6a cf                   ; 0004D:  6a cf

            asl a                       ; 0004F:  0a
            rti                         ; 00050:  40

            hex 2b 0b 8c ca b7 bb d3 b3 ; 00051:  2b 0b 8c ca b7 bb d3 b3
            hex 3b e9 8b cf 04 0b d0 2b ; 00059:  3b e9 8b cf 04 0b d0 2b
            hex 0b 58 c6 d7 52 80 60 e9 ; 00061:  0b 58 c6 d7 52 80 60 e9
            hex 35 cc 02 8d 18 62 e9 7b ; 00069:  35 cc 02 8d 18 62 e9 7b
            hex cc 04 8e da b7 e9 c4 ce ; 00071:  cc 04 8e da b7 e9 c4 ce
            hex 02 aa 9f 6d 8e f4 b7 e9 ; 00079:  02 aa 9f 6d 8e f4 b7 e9
            hex 34 d1 04 8e 05 b8 e9 c4 ; 00081:  34 d1 04 8e 05 b8 e9 c4
            hex ce 02 65 e9 03 ca 02 a4 ; 00089:  ce 02 65 e9 03 ca 02 a4
            hex 4d 6f d7 b8 80          ; 00091:  4d 6f d7 b8 80

            ldy $d759                   ; 00096:  ac 59 d7
            rti                         ; 00099:  40

            hex a8 d3 7f 8a ff 00 a8 df ; 0009A:  a8 d3 7f 8a ff 00 a8 df
            hex 7f 60 66 e9 26 f2 04 d7 ; 000A2:  7f 60 66 e9 26 f2 04 d7
            hex a3 80 61 66 e9 26 f2 04 ; 000AA:  a3 80 61 66 e9 26 f2 04
            hex d8 c5 80 d6 a3 80 62 61 ; 000B2:  d8 c5 80 d6 a3 80 62 61
            hex 6a e9 26 f2 06 d8 99 80 ; 000BA:  6a e9 26 f2 06 d8 99 80
            hex d6 b8 80 60 66 e9 26 f2 ; 000C2:  d6 b8 80 60 66 e9 26 f2
            hex 04 d7 d7 80 61 66 e9 26 ; 000CA:  04 d7 d7 80 61 66 e9 26
            hex f2 04 d8 c5 80 61 e9 35 ; 000D2:  f2 04 d8 c5 80 61 e9 35
            hex cc 02 8e fe 00 8e 00 10 ; 000DA:  cc 02 8e fe 00 8e 00 10
            hex 8e 04 9d 66 e9 7c cf    ; 000E2:  8e 04 9d 66 e9 7c cf

            php                         ; 000E9:  08
            rts                         ; 000EA:  60

            hex 60 65 e9 26 f2 06 ac 5d ; 000EB:  60 65 e9 26 f2 06 ac 5d
            hex cf 66 8e 24 9b 8d 13 8d ; 000F3:  cf 66 8e 24 9b 8d 13 8d
            hex 1f 65 60 e9 54 cc 0c 40 ; 000FB:  1f 65 60 e9 54 cc 0c 40
            hex 2b 0b 8c d2 b7 bb d3 b3 ; 00103:  2b 0b 8c d2 b7 bb d3 b3
            hex 3b e9 8b cf 04 0b d0 2b ; 0010B:  3b e9 8b cf 04 0b d0 2b
            hex 0b 54 c6 d7 04 81 d6 b1 ; 00113:  0b 54 c6 d7 04 81 d6 b1
            hex 81 66 e9 03 ca 02 8d 1a ; 0011B:  81 66 e9 03 ca 02 8d 1a
            hex 6b e9 7b cc 04 8e 17 b8 ; 00123:  6b e9 7b cc 04 8e 17 b8
            hex e9 c4 ce 02 40 29 40 2b ; 0012B:  e9 c4 ce 02 40 29 40 2b
            hex 3b 63 e9 8b cf 04 8d 13 ; 00133:  3b 63 e9 8b cf 04 8d 13
            hex e9 26 f2 02 0b 5f da 5c ; 0013B:  e9 26 f2 02 0b 5f da 5c

            cpy #$d8                    ; 00143:  c0 d8
            jmp $4381                   ; 00145:  4c 81 43

            hex cd 0b bb 2b 0b d0 2b 0b ; 00148:  cd 0b bb 2b 0b d0 2b 0b
            hex 8b 40 c6 d7 33 81 09 d0 ; 00150:  8b 40 c6 d7 33 81 09 d0
            hex 29 09 56 c6 d7 31 81 a4 ; 00158:  29 09 56 c6 d7 31 81 a4
            hex 4d 6f d8 6f 81 62 61 6a ; 00160:  4d 6f d8 6f 81 62 61 6a
            hex e9 26 f2 06 d7 65 81 61 ; 00168:  e9 26 f2 06 d7 65 81 61
            hex e9 35 cc 02 8e f8 00 8e ; 00170:  e9 35 cc 02 8e f8 00 8e
            hex 00 10 8e 64 af 66 e9 7c ; 00178:  00 10 8e 64 af 66 e9 7c
            hex cf                      ; 00180:  cf

            php                         ; 00181:  08
            rts                         ; 00182:  60

            hex 60 65 e9 26 f2 06 ac 5d ; 00183:  60 65 e9 26 f2 06 ac 5d
            hex cf 66 8e e4 ac 8d 18 8d ; 0018B:  cf 66 8e e4 ac 8d 18 8d
            hex 1f 65 60 e9 54 cc 0c 40 ; 00193:  1f 65 60 e9 54 cc 0c 40
            hex 2b 0b 8c d6 b7 bb d3 b3 ; 0019B:  2b 0b 8c d6 b7 bb d3 b3
            hex 3b e9 8b cf 04 0b d0 2b ; 001A3:  3b e9 8b cf 04 0b d0 2b
            hex 0b 54 c6 d7 9c 81 60 e9 ; 001AB:  0b 54 c6 d7 9c 81 60 e9
            hex 35 cc 02 60 e9 03 ca 02 ; 001B3:  35 cc 02 60 e9 03 ca 02
            hex 40 a8 d3 7f 8a ff 00 a8 ; 001BB:  40 a8 d3 7f 8a ff 00 a8
            hex df 7f 60 66 e9 26 f2 04 ; 001C3:  df 7f 60 66 e9 26 f2 04
            hex d7 c5 81 61 66 e9 26 f2 ; 001CB:  d7 c5 81 61 66 e9 26 f2
            hex 04 d7                   ; 001D3:  04 d7

            cmp nmi_busy                     ; 001D5:  c5 81
            rts                         ; 001D7:  60

            hex 66 e9 26 f2 04 d7 e9 81 ; 001D8:  66 e9 26 f2 04 d7 e9 81
            hex 61 66 e9 26 f2 04 d8 d7 ; 001E0:  61 66 e9 26 f2 04 d8 d7

            sta ($61,x)                 ; 001E8:  81 61
            sbc #$35                    ; 001EA:  e9 35
            cpy tab_b0_8bdc+294         ; 001EC:  cc 02 8d
            eor ($8e),y                 ; 001EF:  51 8e
            brk                         ; 001F1:  00
            hex 10                      ; 001F2:  10
            stx $b2ba                   ; 001F3:  8e ba b2
            rts                         ; 001F6:  60

            hex e9 7c cf                ; 001F7:  e9 7c cf

            php                         ; 001FA:  08
            ldy $cf50                   ; 001FB:  ac 50 cf
            ldy $cf5d                   ; 001FE:  ac 5d cf
            rts                         ; 00201:  60

            hex e9 35 cc 02 8e 21 b8 e9 ; 00202:  e9 35 cc 02 8e 21 b8 e9
            hex 26 d3 02 ac a7 d3 d7 1d ; 0020A:  26 d3 02 ac a7 d3 d7 1d
            hex 82 8e 3e b8 e9 26 d3 02 ; 00212:  82 8e 3e b8 e9 26 d3 02
            hex d6 1a 82 cf 20 23 e8 f8 ; 0021A:  d6 1a 82 cf 20 23 e8 f8
            hex ff d6 35 82 60 e9 a4 cb ; 00222:  ff d6 35 82 60 e9 a4 cb
            hex 02 8e 90 b8 e9 26 d3 02 ; 0022A:  02 8e 90 b8 e9 26 d3 02
            hex ac 66 d7 8e 82 b8 e9 26 ; 00232:  ac 66 d7 8e 82 b8 e9 26
            hex d3 02 ac a7 d3 d8 44 82 ; 0023A:  d3 02 ac a7 d3 d8 44 82
            hex 40 cf 61 e9 a4 cb 02 8e ; 00242:  40 cf 61 e9 a4 cb 02 8e
            hex 8b b8 8e ed 7f e9 b0 ca ; 0024A:  8b b8 8e ed 7f e9 b0 ca
            hex 04 d7                   ; 00252:  04 d7

            rol $82                     ; 00254:  26 82
            rts                         ; 00256:  60

            hex e9 a4 cb 02             ; 00257:  e9 a4 cb 02

            hex 8e ff 00 ; stx $00ff    ; 0025B:  8e ff 00
            stx $6001                   ; 0025E:  8e 01 60
            rts                         ; 00261:  60

            hex 61 8d 16 e9 26 f2 0a 28 ; 00262:  61 8d 16 e9 26 f2 0a 28
            hex 8a 00 61 2b 8e 00 01 3b ; 0026A:  8a 00 61 2b 8e 00 01 3b
            hex 60 61 8d 16 e9 26 f2 0a ; 00272:  60 61 8d 16 e9 26 f2 0a
            hex cd 08 bb 28 8a 00 01 cd ; 0027A:  cd 08 bb 28 8a 00 01 cd
            hex 0b bb 2b 0b 8c 00 70 c6 ; 00282:  0b bb 2b 0b 8c 00 70 c6
            hex d7 6e 82 8e ff          ; 0028A:  d7 6e 82 8e ff

            brk                         ; 0028F:  00
            hex 8e                      ; 00290:  8e
            ora ($70,x)                 ; 00291:  01 70
            rts                         ; 00293:  60

            hex 61 8d 16 e9 26 f2 0a cd ; 00294:  61 8d 16 e9 26 f2 0a cd
            hex 08 bb 28 8a 00 71 2b 8e ; 0029C:  08 bb 28 8a 00 71 2b 8e
            hex 00 01 3b 60 61 8d 16 e9 ; 002A4:  00 01 3b 60 61 8d 16 e9
            hex 26 f2 0a cd 08 bb 28 8a ; 002AC:  26 f2 0a cd 08 bb 28 8a
            hex 00 01 cd 0b bb 2b 0b 8c ; 002B4:  00 01 cd 0b bb 2b 0b 8c
            hex 00 7f c6 d7 a3 82       ; 002BC:  00 7f c6 d7 a3 82

            stx $81eb                   ; 002C2:  8e eb 81
            stx $7f00                   ; 002C5:  8e 00 7f
            rts                         ; 002C8:  60

            hex 61 8d 16 e9 26 f2 0a cd ; 002C9:  61 8d 16 e9 26 f2 0a cd
            hex 08 bb 28 61 e9 a4 cb 02 ; 002D1:  08 bb 28 61 e9 a4 cb 02
            hex a4 eb 7f 18 c0 d8 43 83 ; 002D9:  a4 eb 7f 18 c0 d8 43 83
            hex 60 e9 a4 cb 02 40       ; 002E1:  60 e9 a4 cb 02 40

            tay                         ; 002E7:  a8
            cmp ($7f),y                 ; 002E8:  d1 7f
            rti                         ; 002EA:  40

            hex a8 61 6f 8e 9e b8 e9 26 ; 002EB:  a8 61 6f 8e 9e b8 e9 26
            hex d3 02                   ; 002F3:  d3 02

            stx $b89f                   ; 002F5:  8e 9f b8
            sbc #$c4                    ; 002F8:  e9 c4
            dec $ac02                   ; 002FA:  ce 02 ac
            eor tab_b0_ac94+67,y        ; 002FD:  59 d7 ac
            jsr $61cd                   ; 00300:  20 cd 61
            sbc #$35                    ; 00303:  e9 35
            cpy $6402                   ; 00305:  cc 02 64
            stx $14d0                   ; 00308:  8e d0 14
            stx $b78a                   ; 0030B:  8e 8a b7
            rts                         ; 0030E:  60

            hex e9 7c cf 08 8e 9a 00 8e ; 0030F:  e9 7c cf 08 8e 9a 00 8e
            hex 10 15 8e bc 83 64 e9 7c ; 00317:  10 15 8e bc 83 64 e9 7c
            hex cf                      ; 0031F:  cf

            php                         ; 00320:  08
            rti                         ; 00321:  40

            hex 29 09 8c 52 b8 bb d3 b3 ; 00322:  29 09 8c 52 b8 bb d3 b3
            hex 39 e9 8b cf 04 09 d0 29 ; 0032A:  39 e9 8b cf 04 09 d0 29
            hex 09 58 c6 d7 23 83 60 e9 ; 00332:  09 58 c6 d7 23 83 60 e9
            hex 35 cc 02 41 a8 d1 7f 41 ; 0033A:  35 cc 02 41 a8 d1 7f 41
            hex cf 8e ab b8 8e ed 7f e9 ; 00342:  cf 8e ab b8 8e ed 7f e9
            hex d9 ca 04 60 e9 a4 cb 02 ; 0034A:  d9 ca 04 60 e9 a4 cb 02
            hex 89 32 a8 65 6d 41 a8 4d ; 00352:  89 32 a8 65 6d 41 a8 4d
            hex 6f 40 a8 c7 7f 40 a8 d3 ; 0035A:  6f 40 a8 c7 7f 40 a8 d3
            hex 7f 40 a8 d1 7f ac 89 cc ; 00362:  7f 40 a8 d1 7f ac 89 cc
            hex 8e b0 b8 e9 26 d3 02 ac ; 0036A:  8e b0 b8 e9 26 d3 02 ac
            hex 09 d6 d6 35 82 20 23 e8 ; 00372:  09 d6 d6 35 82 20 23 e8
            hex ff ff 3e 0d d3 b3 e9 0d ; 0037A:  ff ff 3e 0d d3 b3 e9 0d
            hex d7 04 a2 ff ff a3 ff ff ; 00382:  d7 04 a2 ff ff a3 ff ff
            hex 0c b4 b3 d3 bb d4 a3 ff ; 0038A:  0c b4 b3 d3 bb d4 a3 ff
            hex ff 0d b4 b3 d3 bc d4 cf ; 00392:  ff 0d b4 b3 d3 bc d4 cf
            hex 20 23 e8 fe ff 0c 55 b5 ; 0039A:  20 23 e8 fe ff 0c 55 b5
            hex 8c a9 76 bb 2b 8d 1e 0b ; 003A2:  8c a9 76 bb 2b 8d 1e 0b
            hex 73 b3 3b e9 77 83 06 8d ; 003AA:  73 b3 3b e9 77 83 06 8d
            hex 14 e9 52 ca 02 8f 14 b3 ; 003B2:  14 e9 52 ca 02 8f 14 b3
            hex 0b 74 b3 3b e9 77 83 06 ; 003BA:  0b 74 b3 3b e9 77 83 06
            hex 8d 1e 0b 74 b3 0b d0 b3 ; 003C2:  8d 1e 0b 74 b3 0b d0 b3
            hex e9 77 83 06 8d 14 e9 52 ; 003CA:  e9 77 83 06 8d 14 e9 52
            hex ca 02 8f 14 b3 0b 73 b3 ; 003D2:  ca 02 8f 14 b3 0b 73 b3
            hex 0b d0 b3 e9 77 83 06 cf ; 003DA:  0b d0 b3 e9 77 83 06 cf
            hex 20 23 e8 d8 ff 66 e9 52 ; 003E2:  20 23 e8 d8 ff 66 e9 52
            hex ca 02 8f 14 a8 0d 6e 40 ; 003EA:  ca 02 8f 14 a8 0d 6e 40
            hex 2b 29 d6 b4 85 3b e9 8d ; 003F2:  2b 29 d6 b4 85 3b e9 8d
            hex d9 02 d7 93 85 3b e9 72 ; 003FA:  d9 02 d7 93 85 3b e9 72
            hex d7 02 57 b5 8c 30 75 bb ; 00402:  d7 02 57 b5 8c 30 75 bb

            sta $d8                     ; 0040A:  85 d8
            rti                         ; 0040C:  40

            hex d6 23 84 a4 63 6d 55 b5 ; 0040D:  d6 23 84 a4 63 6d 55 b5
            hex b3 81 d8 d0 85 d8 d1 b4 ; 00415:  b3 81 d8 d0 85 d8 d1 b4
            hex b3 d3 bb d4 0a d0 2a 0a ; 0041D:  b3 d3 bb d4 0a d0 2a 0a
            hex 55 c6 d7 10 84 0b 8b 1a ; 00425:  55 c6 d7 10 84 0b 8b 1a
            hex b5 8c 01 70 bb 28 a4 63 ; 0042D:  b5 8c 01 70 bb 28 a4 63
            hex 6d 5a b5 b3 08 72 28 8f ; 00435:  6d 5a b5 b3 08 72 28 8f
            hex fe b4 b3 b0 bb b1 40 2a ; 0043D:  fe b4 b3 b0 bb b1 40 2a
            hex a4 63 6d 55 b5 b3 08 72 ; 00445:  a4 63 6d 55 b5 b3 08 72
            hex 28 b4 b3 b0 bb b1 0a d0 ; 0044D:  28 b4 b3 b0 bb b1 0a d0
            hex 2a 0a 5a c6 d7 45 84 a4 ; 00455:  2a 0a 5a c6 d7 45 84 a4
            hex 9d 6d 8b 32 c0 d8 07 85 ; 0045D:  9d 6d 8b 32 c0 d8 07 85
            hex 0b 55 c0 d7 b5 84 0b 59 ; 00465:  0b 55 c0 d7 b5 84 0b 59
            hex c0 d7 b5 84 0b 5d c0 d7 ; 0046D:  c0 d7 b5 84 0b 5d c0 d7
            hex b5 84 0b 5e c0 d7 b5 84 ; 00475:  b5 84 0b 5e c0 d7 b5 84
            hex 0b 8b 13 c0 d7 b5 84 0b ; 0047D:  0b 8b 13 c0 d7 b5 84 0b
            hex 8b 17 c0 d7 b5 84 0b 8b ; 00485:  8b 17 c0 d7 b5 84 0b 8b
            hex 1a c0 d7 b5 84 0b 8b 15 ; 0048D:  1a c0 d7 b5 84 0b 8b 15
            hex c0 d7 b5 84 0b 8b 26 c0 ; 00495:  c0 d7 b5 84 0b 8b 26 c0
            hex d7 b5 84 0b 8b 2a c0 d7 ; 0049D:  d7 b5 84 0b 8b 2a c0 d7
            hex b5 84 0b 8b 31 c0 d7 b5 ; 004A5:  b5 84 0b 8b 31 c0 d7 b5
            hex 84 0b 8b 18 c0 d8 8e 85 ; 004AD:  84 0b 8b 18 c0 d8 8e 85
            hex 62 e9 52 ca 02 d8 8e 85 ; 004B5:  62 e9 52 ca 02 d8 8e 85
            hex de da ff b3 09 d2 b4 bb ; 004BD:  de da ff b3 09 d2 b4 bb
            hex b3 0b b1 09 d0 29 62 0b ; 004C5:  b3 0b b1 09 d0 29 62 0b
            hex 8b 1a b5 8c 01 70 bb b4 ; 004CD:  8b 1a b5 8c 01 70 bb b4
            hex b3 b0 b5 b1 64 0b 8b 1a ; 004D5:  b3 b0 b5 b1 64 0b 8b 1a
            hex b5 8c 07 70 bb b4 b3 b0 ; 004DD:  b5 8c 07 70 bb b4 b3 b0
            hex b5 b1 62 0b 8b 1a b5 8c ; 004E5:  b5 b1 62 0b 8b 1a b5 8c
            hex 0d 70 bb b4 b3 b0 b5 b1 ; 004ED:  0d 70 bb b4 b3 b0 b5 b1
            hex 62 0b 8b 1a b5 8c 13 70 ; 004F5:  62 0b 8b 1a b5 8c 13 70
            hex bb b4 b3 b0 b5 b1 63 d6 ; 004FD:  bb b4 b3 b0 b5 b1 63 d6
            hex 81 85 0b 51 c0 d7 32 85 ; 00505:  81 85 0b 51 c0 d7 32 85
            hex 0b 52 c0 d7 32 85 0b 54 ; 0050D:  0b 52 c0 d7 32 85 0b 54
            hex c0 d7 32 85 0b 57 c0 d7 ; 00515:  c0 d7 32 85 0b 57 c0 d7
            hex 32 85 0b 5a c0 d7 32 85 ; 0051D:  32 85 0b 5a c0 d7 32 85
            hex 0b 5f c0 d7 32 85 0b 8b ; 00525:  0b 5f c0 d7 32 85 0b 8b
            hex 10 c0 d8 8e 85 62 e9 52 ; 0052D:  10 c0 d8 8e 85 62 e9 52
            hex ca 02 d8 8e 85 de da ff ; 00535:  ca 02 d8 8e 85 de da ff
            hex b3 09 d2 b4 bb b3 0b b1 ; 0053D:  b3 09 d2 b4 bb b3 0b b1
            hex 09 d0 29 62 0b 8b 1a b5 ; 00545:  09 d0 29 62 0b 8b 1a b5
            hex 8c 01 70 bb b4 b3 b0 b5 ; 0054D:  8c 01 70 bb b4 b3 b0 b5
            hex b1 63 0b 8b 1a b5 8c 07 ; 00555:  b1 63 0b 8b 1a b5 8c 07
            hex 70 bb b4 b3 b0 b5 b1 62 ; 0055D:  70 bb b4 b3 b0 b5 b1 62
            hex 0b 8b 1a b5 8c 0d 70 bb ; 00565:  0b 8b 1a b5 8c 0d 70 bb
            hex b4 b3 b0 b5 b1 62 0b 8b ; 0056D:  b4 b3 b0 b5 b1 62 0b 8b
            hex 1a b5 8c 13 70 bb b4 b3 ; 00575:  1a b5 8c 13 70 bb b4 b3
            hex b0 b5 b1 62 0b 8b 1a b5 ; 0057D:  b0 b5 b1 62 0b 8b 1a b5
            hex 8c 11 70 bb b4 b3 b0 b5 ; 00585:  8c 11 70 bb b4 b3 b0 b5
            hex b1 3b e9 9a 83 02 0b 8b ; 0058D:  b1 3b e9 9a 83 02 0b 8b
            hex 1a b5 8c 19 70 bb 28 38 ; 00595:  1a b5 8c 19 70 bb 28 38
            hex 8d 14 e9 52 ca 02 8f 50 ; 0059D:  8d 14 e9 52 ca 02 8f 50
            hex b3 08 b0 90 e8 03 b3 e9 ; 005A5:  b3 08 b0 90 e8 03 b3 e9
            hex 0d d7 04 b1 0b d0 2b 0b ; 005AD:  0d d7 04 b1 0b d0 2b 0b
            hex a6 9d 6d c6 d7 f7 83 40 ; 005B5:  a6 9d 6d c6 d7 f7 83 40
            hex d6 f4 85 40 d6 eb 85 de ; 005BD:  d6 f4 85 40 d6 eb 85 de
            hex da ff b3 0b d2 b4 bb b0 ; 005C5:  da ff b3 0b d2 b4 bb b0
            hex a8 5f 6f de da ff b3 0a ; 005CD:  a8 5f 6f de da ff b3 0a
            hex d2 b4 bb b0 a8 63 6f a4 ; 005D5:  d2 b4 bb b0 a8 63 6f a4
            hex 5f 6f a6 63 6f c1 d8 e9 ; 005DD:  5f 6f a6 63 6f c1 d8 e9
            hex 85 ac 7d da 0a d0 2a 0a ; 005E5:  85 ac 7d da 0a d0 2a 0a
            hex 19 c6 d7 c4 85 0b d0 2b ; 005ED:  19 c6 d7 c4 85 0b d0 2b
            hex 0b 19 c6 d7 c0 85 cf 20 ; 005F5:  0b 19 c6 d7 c0 85 cf 20
            hex 23 e8 fc ff a4 cd 7f 2b ; 005FD:  23 e8 fc ff a4 cd 7f 2b
            hex ac 4e d1 d7 05 86 d6 12 ; 00605:  ac 4e d1 d7 05 86 d6 12
            hex 86 0b a8 cd 7f 8d 32 e9 ; 0060D:  86 0b a8 cd 7f 8d 32 e9
            hex 52 ca 02 8f 3c 2a b3 8e ; 00615:  52 ca 02 8f 3c 2a b3 8e
            hex c3 b8 e9 34 d1 04 ac 4e ; 0061D:  c3 b8 e9 34 d1 04 ac 4e
            hex d1 d8 0e 86 0a cf 20 23 ; 00625:  d1 d8 0e 86 0a cf 20 23
            hex e8 fc ff 8e c7 b8 e9 26 ; 0062D:  e8 fc ff 8e c7 b8 e9 26
            hex d3 02 8e c8 b8 e9 51 d3 ; 00635:  d3 02 8e c8 b8 e9 51 d3
            hex 02 2a 0a 52 c0 d7 30 86 ; 0063D:  02 2a 0a 52 c0 d7 30 86
            hex 0a 51 c0 d8 56 86 89 11 ; 00645:  0a 51 c0 d8 56 86 89 11
            hex a8 9d 6d 8a 04 a0 d6 5e ; 0064D:  a8 9d 6d 8a 04 a0 d6 5e
            hex 86 89 32 a8 9d 6d 8a 04 ; 00655:  86 89 32 a8 9d 6d 8a 04
            hex 80 2b 8a cf 7f 8c 01 60 ; 0065D:  80 2b 8a cf 7f 8c 01 60
            hex bc 72 b3 8e 01 60 3b 63 ; 00665:  bc 72 b3 8e 01 60 3b 63
            hex e9 bd cb 08 8e dd b8 e9 ; 0066D:  e9 bd cb 08 8e dd b8 e9
            hex 26 d3 02 ac a7 d3 a8 7d ; 00675:  26 d3 02 ac a7 d3 a8 7d
            hex 6e cf 20 23 e8 00 00 8e ; 0067D:  6e cf 20 23 e8 00 00 8e
            hex f8 b8 e9 26 d3 02 3c 8e ; 00685:  f8 b8 e9 26 d3 02 3c 8e
            hex 00 b9 e9 34 d1 04 cf 20 ; 0068D:  00 b9 e9 34 d1 04 cf 20
            hex 23 e8 fc ff a4 9d 6d 8b ; 00695:  23 e8 fc ff a4 9d 6d 8b
rendering_off:
            hex 32 c0 d8 a6 86 42 d6 a7 ; 0069D:  32 c0 d8 a6 86 42 d6 a7
            hex 86 40 b3 e9 f2 e5 02 41 ; 006A5:  86 40 b3 e9 f2 e5 02 41
mul_xy_by_3:
            hex a8 e0 7b 42 2b 3c e9 7f ; 006AD:  a8 e0 7b 42 2b 3c e9 7f
            hex 86 02 d6 f1 86 a4 cf 7f ; 006B5:  86 02 d6 f1 86 a4 cf 7f
            hex d1 a8 cf 7f 0a 8b ff c0 ; 006BD:  d1 a8 cf 7f 0a 8b ff c0
            hex d8 f1 86 a4 9d 6d 8b 32 ; 006C5:  d8 f1 86 a4 9d 6d 8b 32
            hex c0 d8 df 86 0b d0 2b 59 ; 006CD:  c0 d8 df 86 0b d0 2b 59
            hex c9 d8 db 86 42 2b 3b d6 ; 006D5:  c9 d8 db 86 42 2b 3b d6
            hex ed 86 0b d0 2b 54 c9 d8 ; 006DD:  ed 86 0b d0 2b 54 c9 d8
            hex e9 86 42 2b 0b 8f fe b3 ; 006E5:  e9 86 42 2b 0b 8f fe b3
            hex e9 f2 e5 02 aa 9d 6d 61 ; 006ED:  e9 f2 e5 02 aa 9d 6d 61
            hex e9 e9 d5 04 2a 50 c3 d7 ; 006F5:  e9 e9 d5 04 2a 50 c3 d7
            hex ba 86 0a d1 2a 8c f7 6c ; 006FD:  ba 86 0a d1 2a 8c f7 6c
            hex bb d3 55 c1 d8 34 87 8e ; 00705:  bb d3 55 c1 d8 34 87 8e
            hex 26 b9 e9 26 d3 02 0a 59 ; 0070D:  26 b9 e9 26 d3 02 0a 59
            hex b5 8c a8 77 bb b3 e9 c4 ; 00715:  b5 8c a8 77 bb b3 e9 c4
            hex ce 02 0a d0 b3 8e 2a b9 ; 0071D:  ce 02 0a d0 b3 8e 2a b9
            hex e9 34 d1 04 ac a7 d3 d8 ; 00725:  e9 34 d1 04 ac a7 d3 d8
            hex 3e 87 49 2b d6 3e 87 8e ; 0072D:  3e 87 49 2b d6 3e 87 8e
            hex 3a b9 e9 26 d3 02 ac 66 ; 00735:  3a b9 e9 26 d3 02 ac 66
            hex d7 0b 59 c1 d7 b2 86 40 ; 0073D:  d7 0b 59 c1 d7 b2 86 40
            hex a8 e0 7b 0a 8c f7 6c bb ; 00745:  a8 e0 7b 0a 8c f7 6c bb
            hex b3 45 d4 0a a8 5f 6f 0a ; 0074D:  b3 45 d4 0a a8 5f 6f 0a
            hex a8 dd 7f 0c 8c d4 7f bb ; 00755:  a8 dd 7f 0c 8c d4 7f bb
            hex b3 ac 7e d7 d4 cf 20 23 ; 0075D:  b3 ac 7e d7 d4 cf 20 23
            hex e8 fa ff ac 20 cd 61 e9 ; 00765:  e8 fa ff ac 20 cd 61 e9
            hex 35 cc 02 8d 2b 67 e9 8b ; 0076D:  35 cc 02 8d 2b 67 e9 8b
            hex cf 04 8d 25 6b e9 8b cf ; 00775:  cf 04 8d 25 6b e9 8b cf
            hex 04 61 6a 6a 66 62 e9 6a ; 0077D:  04 61 6a 6a 66 62 e9 6a
            hex cf 0a 61 8d 10 8d 1a 6c ; 00785:  cf 0a 61 8d 10 8d 1a 6c
            hex 8d 10 e9 6a cf 0a 62 8d ; 0078D:  8d 10 e9 6a cf 0a 62 8d
            hex 12 8d 1a 8d 12 6e e9 6a ; 00795:  12 8d 1a 8d 12 6e e9 6a
            hex cf 0a 64 63 e9 7b cc 04 ; 0079D:  cf 0a 64 63 e9 7b cc 04
music_driver:
            hex a4 5f 6f d0 b3 8e 57 b9 ; 007A5:  a4 5f 6f d0 b3 8e 57 b9
            hex e9 34 d1 04 66 63 e9 7b ; 007AD:  e9 34 d1 04 66 63 e9 7b
            hex cc 04 a4 5f 6f 5a b5 8c ; 007B5:  cc 04 a4 5f 6f 5a b5 8c
            hex 85 79 bb b3 e9 c4 ce 02 ; 007BD:  85 79 bb b3 e9 c4 ce 02
            hex 68 63 e9 7b cc 04 a4 5f ; 007C5:  68 63 e9 7b cc 04 a4 5f
            hex 6f 59 b5 8c a8 77 bb b3 ; 007CD:  6f 59 b5 8c a8 77 bb b3
            hex e9 c4 ce 02 6a 63 e9 7b ; 007D5:  e9 c4 ce 02 6a 63 e9 7b
            hex cc 04 ac ea d7 2b 0b d0 ; 007DD:  cc 04 ac ea d7 2b 0b d0
            hex 2b d1 d3 b3 8e 60 b9 e9 ; 007E5:  2b d1 d3 b3 8e 60 b9 e9
            hex 34 d1 04 a4 5f 6f a8 5b ; 007ED:  34 d1 04 a4 5f 6f a8 5b
            hex 6f 6c 64 e9 6f e7 04 66 ; 007F5:  6f 6c 64 e9 6f e7 04 66
            hex 6d e9 7b cc 04 8e 69 b9 ; 007FD:  6d e9 7b cc 04 8e 69 b9
            hex e9 c4 ce 02 67 6d e9 7b ; 00805:  e9 c4 ce 02 67 6d e9 7b
            hex cc 04 8e 74 b9 e9 c4 ce ; 0080D:  cc 04 8e 74 b9 e9 c4 ce
            hex 02 69 6d e9 7b cc 04 8e ; 00815:  02 69 6d e9 7b cc 04 8e
            hex 85 b9 e9 c4 ce 02 6a 6d ; 0081D:  85 b9 e9 c4 ce 02 6a 6d
            hex e9 7b cc 04 8e 96 b9 e9 ; 00825:  e9 7b cc 04 8e 96 b9 e9
            hex c4 ce 02 41 29 09 7b b3 ; 0082D:  c4 ce 02 41 29 09 7b b3
            hex 8d 10 e9 7b cc 04 09 d2 ; 00835:  8d 10 e9 7b cc 04 09 d2
            hex 8c ae f8 bb b0 b3 e9 c4 ; 0083D:  8c ae f8 bb b0 b3 e9 c4
            hex ce 02 89 16 a8 cd 7f 8e ; 00845:  ce 02 89 16 a8 cd 7f 8e
            hex a7 b9 e9 34 d1 02 09 d0 ; 0084D:  a7 b9 e9 34 d1 02 09 d0
            hex 29 09 56 c2 d7 32       ; 00855:  29 09 56 c2 d7 32

            dey                         ; 0085B:  88
            rts                         ; 0085C:  60

tab_b0_885d: ; 93 bytes
            hex e9 35 cc 02 40 29 a4 5f ; 0085D:  e9 35 cc 02 40 29 a4 5f
            hex 6f 57 b5 8c 30 75 bb 2b ; 00865:  6f 57 b5 8c 30 75 bb 2b
            hex 41 2a 0a 7b b3 8d 17 e9 ; 0086D:  41 2a 0a 7b b3 8d 17 e9
            hex 7b cc 04 3b ac fc 85 d4 ; 00875:  7b cc 04 3b ac fc 85 d4
            hex 0b d0 2b d1 d3 cd 09 bb ; 0087D:  0b d0 2b d1 d3 cd 09 bb
            hex 29 0a d0 2a 0a 55 c7 d7 ; 00885:  29 0a d0 2a 0a 55 c7 d7
            hex 6f 88 8d 12 6f e9 7b cc ; 0088D:  6f 88 8d 12 6f e9 7b cc
            hex 04 39 8e ad b9 e9 34 d1 ; 00895:  04 39 8e ad b9 e9 34 d1
            hex 04 8e b8 b9 e9 26 d3 02 ; 0089D:  04 8e b8 b9 e9 26 d3 02
            hex ac a7 d3 d8 61 88 cf 20 ; 008A5:  ac a7 d3 d8 61 88 cf 20
            hex 23 e8 fe ff 40 a8 c5 7f ; 008AD:  23 e8 fe ff 40 a8 c5 7f
            hex 61 e9 35 cc 02          ; 008B5:  61 e9 35 cc 02

            sta $8e66                   ; 008BA:  8d 66 8e
            brk                         ; 008BD:  00
            hex 10                      ; 008BE:  10
            stx $ac4a                   ; 008BF:  8e 4a ac
            rts                         ; 008C2:  60

            hex e9 7c cf 08 64          ; 008C3:  e9 7c cf 08 64

            stx $23c0                   ; 008C8:  8e c0 23
            stx $a84a                   ; 008CB:  8e 4a a8
            rts                         ; 008CE:  60

            hex e9 7c cf                ; 008CF:  e9 7c cf

            php                         ; 008D2:  08
            rts                         ; 008D3:  60

            hex 8e 8a a8 8d 1d 8d 1f 60 ; 008D4:  8e 8a a8 8d 1d 8d 1f 60
            hex 60 e9 54 cc 0c 40 2b 0b ; 008DC:  60 e9 54 cc 0c 40 2b 0b
            hex 8c 62 b8 bb d3 b3 3b e9 ; 008E4:  8c 62 b8 bb d3 b3 3b e9
            hex 8b cf 04 0b d0 2b 0b 8b ; 008EC:  8b cf 04 0b d0 2b 0b 8b
            hex 20 c6 d7 e3             ; 008F4:  20 c6 d7 e3

            dey                         ; 008F8:  88
            rts                         ; 008F9:  60

            hex e9 35 cc 02 8a ff 00 a8 ; 008FA:  e9 35 cc 02 8a ff 00 a8
            hex df 7f 40 a8 d3 7f 60 66 ; 00902:  df 7f 40 a8 d3 7f 60 66
            hex e9 26 f2 04 d7 08 89 61 ; 0090A:  e9 26 f2 04 d7 08 89 61
            hex 66 e9 26 f2 04 d7 08 89 ; 00912:  66 e9 26 f2 04 d7 08 89
            hex 60 66 e9 26 f2 04 d7 2c ; 0091A:  60 66 e9 26 f2 04 d7 2c
            hex 89 61 66 e9 26 f2 04 d8 ; 00922:  89 61 66 e9 26 f2 04 d8
            hex 1a 89 61 e9 35 cc 02    ; 0092A:  1a 89 61 e9 35 cc 02

            sta $8e51                   ; 00931:  8d 51 8e
            brk                         ; 00934:  00
            hex 10                      ; 00935:  10
            stx $b2ba                   ; 00936:  8e ba b2
            rts                         ; 00939:  60

            hex e9 7c cf 08 8e b1 00 8e ; 0093A:  e9 7c cf 08 8e b1 00 8e
            hex d0 14 8e 64 82 66 e9 7c ; 00942:  d0 14 8e 64 82 66 e9 7c
            hex cf 08 ac 50 cf ac 5d cf ; 0094A:  cf 08 ac 50 cf ac 5d cf
            hex 66 8e 04 80 8d 15 8d 1f ; 00952:  66 8e 04 80 8d 15 8d 1f
            hex 63 60 e9 54 cc 0c 61 67 ; 0095A:  63 60 e9 54 cc 0c 61 67

            sta $6311                   ; 00962:  8d 11 63
            rts                         ; 00965:  60

            hex e9 6a cf 0a 61 8d 1a 8d ; 00966:  e9 6a cf 0a 61 8d 1a 8d
            hex 1d 8d 1a 8d 14 e9 6a cf ; 0096E:  1d 8d 1a 8d 14 e9 6a cf
            hex 0a 8d 1a 8d 15 e9 7b cc ; 00976:  0a 8d 1a 8d 15 e9 7b cc
            hex 04 8e c3 b9 e9 c4 ce 02 ; 0097E:  04 8e c3 b9 e9 c4 ce 02
            hex 40 2b 0b 8c 5a b8 bb d3 ; 00986:  40 2b 0b 8c 5a b8 bb d3
            hex b3 3b e9 8b cf 04 0b d0 ; 0098E:  b3 3b e9 8b cf 04 0b d0
            hex 2b 0b 58 c6 d7 88 89 60 ; 00996:  2b 0b 58 c6 d7 88 89 60
            hex e9 35 cc 02 cf 20 23 e8 ; 0099E:  e9 35 cc 02 cf 20 23 e8
            hex fe ff 41 a8 4d 6f 60 e9 ; 009A6:  fe ff 41 a8 4d 6f 60 e9
            hex 03 ca 02                ; 009AE:  03 ca 02

            ldy tab_b0_885d+79          ; 009B1:  ac ac 88
            rti                         ; 009B4:  40

            hex a8 e7 7f 89 32          ; 009B5:  a8 e7 7f 89 32

            tay                         ; 009BA:  a8
            adc $6d                     ; 009BB:  65 6d
            rti                         ; 009BD:  40

            hex a8 c7 7f 40 a8 d3 7f 40 ; 009BE:  a8 c7 7f 40 a8 d3 7f 40
            hex a8 d1 7f ac 1e 82 d8 d7 ; 009C6:  a8 d1 7f ac 1e 82 d8 d7
            hex 89 60 60 6a e9 26 f2    ; 009CE:  89 60 60 6a e9 26 f2

            asl $cf                     ; 009D5:  06 cf
            rti                         ; 009D7:  40

            hex 2b 0b 8c d5 7f bb b3 89 ; 009D8:  2b 0b 8c d5 7f bb b3 89
            hex ff d4 0b d0 2b 0b 58 c6 ; 009E0:  ff d4 0b d0 2b 0b 58 c6
            hex d7 d9 89 ac 2b 86 40 d6 ; 009E8:  d7 d9 89 ac 2b 86 40 d6
            hex fc 89 0b 8c 1b 6f bb b3 ; 009F0:  fc 89 0b 8c 1b 6f bb b3
            hex 0b d4 0b d0 2b 0b a6 9d ; 009F8:  0b d4 0b d0 2b 0b a6 9d
            hex 6d c6 d7 f2 89 40 d6 13 ; 00A00:  6d c6 d7 f2 89 40 d6 13
            hex 8a 0b 8c f7 6c bb b3 40 ; 00A08:  8a 0b 8c f7 6c bb b3 40
            hex d4 0b d0 2b a4 9d 6d 74 ; 00A10:  d4 0b d0 2b a4 9d 6d 74
            hex b3 0b b4 c6 d7 09 8a 8e ; 00A18:  b3 0b b4 c6 d7 09 8a 8e
            hex cd b9 e9 26 d3 02 68 61 ; 00A20:  cd b9 e9 26 d3 02 68 61
            hex e9 e9 d5 04 a8 61 6d d8 ; 00A28:  e9 e9 d5 04 a8 61 6d d8
            hex 1f                      ; 00A30:  1f

            txa                         ; 00A31:  8a
            rti                         ; 00A32:  40

            hex 2b 0b d2 8c 0b 6e bb b3 ; 00A33:  2b 0b d2 8c 0b 6e bb b3
            hex 6a e9 52 ca 02 78 b1 0b ; 00A3B:  6a e9 52 ca 02 78 b1 0b
            hex d0 2b 0b 55 c6 d7 34 8a ; 00A43:  d0 2b 0b 55 c6 d7 34 8a
            hex ac 20 cd 41 a8 d1 7f 61 ; 00A4B:  ac 20 cd 41 a8 d1 7f 61
            hex e9 35 cc 02 64          ; 00A53:  e9 35 cc 02 64

            stx $14d0                   ; 00A58:  8e d0 14
            stx $b78a                   ; 00A5B:  8e 8a b7
            rts                         ; 00A5E:  60

            hex e9 7c cf 08 8e 9a 00 8e ; 00A5F:  e9 7c cf 08 8e 9a 00 8e
            hex 10 15 8e bc 83 64 e9 7c ; 00A67:  10 15 8e bc 83 64 e9 7c
            hex cf                      ; 00A6F:  cf

            php                         ; 00A70:  08
            rti                         ; 00A71:  40

            hex 2b 0b 8c 52 b8 bb d3 b3 ; 00A72:  2b 0b 8c 52 b8 bb d3 b3
            hex 3b e9 8b cf 04 0b d0 2b ; 00A7A:  3b e9 8b cf 04 0b d0 2b
            hex 0b 58 c6 d7 73          ; 00A82:  0b 58 c6 d7 73

            txa                         ; 00A87:  8a
            rts                         ; 00A88:  60

            hex e9 35 cc 02 41 d6 bc 8a ; 00A89:  e9 35 cc 02 41 d6 bc 8a
            hex ac 20 cd 8d 21 67 e9 8b ; 00A91:  ac 20 cd 8d 21 67 e9 8b
            hex cf 04 8d 30 6b e9 8b cf ; 00A99:  cf 04 8d 30 6b e9 8b cf
            hex 04 0b 51 da 51 c0 d8 ae ; 00AA1:  04 0b 51 da 51 c0 d8 ae
            hex 8a 40 d6 af 8a 44 a8 d3 ; 00AA9:  8a 40 d6 af 8a 44 a8 d3
            hex 7f 3b e9 94 86 02 ac 63 ; 00AB1:  7f 3b e9 94 86 02 ac 63
            hex 87 0b d0 2b 0b          ; 00AB9:  87 0b d0 2b 0b

            ldx $61                     ; 00ABE:  a6 61
            adc $d7c7                   ; 00AC0:  6d c7 d7
            sta ($8a),y                 ; 00AC3:  91 8a
            rti                         ; 00AC5:  40

            hex a8 d3 7f 8e de b9 e9 26 ; 00AC6:  a8 d3 7f 8e de b9 e9 26
            hex d3 02 65 61 e9 e9 d5 04 ; 00ACE:  d3 02 65 61 e9 e9 d5 04
            hex a8 63 6d d8 c9 8a 8e f8 ; 00AD6:  a8 63 6d d8 c9 8a 8e f8
            hex b9 e9 26 d3 02 ac a7 d3 ; 00ADE:  b9 e9 26 d3 02 ac a7 d3
            hex d7 44 8b ac 20 cd 61 e9 ; 00AE6:  d7 44 8b ac 20 cd 61 e9
            hex 35 cc 02 8e b1 00 8e d0 ; 00AEE:  35 cc 02 8e b1 00 8e d0
            hex 14 8e 64 82 66 e9 7c cf ; 00AF6:  14 8e 64 82 66 e9 7c cf
            hex 08 66 8e 04 80 8d 15 8d ; 00AFE:  08 66 8e 04 80 8d 15 8d
            hex 1f 63 60 e9 54 cc 0c 61 ; 00B06:  1f 63 60 e9 54 cc 0c 61
            hex 67                      ; 00B0E:  67

            sta $6311                   ; 00B0F:  8d 11 63
            rts                         ; 00B12:  60

            hex e9 6a cf                ; 00B13:  e9 6a cf

            asl a                       ; 00B16:  0a
            rti                         ; 00B17:  40

            hex 2b 0b 58 c6 d8 26 8b 0b ; 00B18:  2b 0b 58 c6 d8 26 8b 0b
            hex 8c 5a b8 d6 2a 8b 0b 8c ; 00B20:  8c 5a b8 d6 2a 8b 0b 8c
            hex 62 b8 bb d3 b3 3b e9 8b ; 00B28:  62 b8 bb d3 b3 3b e9 8b
            hex cf 04 0b d0 2b 0b 8b 20 ; 00B30:  cf 04 0b d0 2b 0b 8b 20
            hex c6 d7 19 8b 60 e9 35 cc ; 00B38:  c6 d7 19 8b 60 e9 35 cc
            hex 02 d6 c1 89 8e 10 ba e9 ; 00B40:  02 d6 c1 89 8e 10 ba e9
            hex 26 d3 02 48 a6 61 6d bc ; 00B48:  26 d3 02 48 a6 61 6d bc
            hex a8 09 6e ac e2 83 41 a8 ; 00B50:  a8 09 6e ac e2 83 41 a8
            hex c7 7f 60 60 6a e9 26 f2 ; 00B58:  c7 7f 60 60 6a e9 26 f2
            hex 06 8d 21 67 e9 8b cf 04 ; 00B60:  06 8d 21 67 e9 8b cf 04
            hex 8d 30 6b e9 8b cf 04 cf ; 00B68:  8d 30 6b e9 8b cf 04 cf
            hex 20 23 e8 fe ff 0c 8c 79 ; 00B70:  20 23 e8 fe ff 0c 8c 79
            hex 7b bb d3 56 c0 d8 86 8b ; 00B78:  7b bb d3 56 c0 d8 86 8b
            hex 8a 28 ba d6 9a 8b 0c 8c ; 00B80:  8a 28 ba d6 9a 8b 0c 8c
            hex 79 7b bb d3 57 c0 d8 97 ; 00B88:  79 7b bb d3 57 c0 d8 97
            hex 8b 8a 31 ba d6 9a 8b 8a ; 00B90:  8b 8a 31 ba d6 9a 8b 8a
            hex 3a ba 2b 0b cf 20 23 e8 ; 00B98:  3a ba 2b 0b cf 20 23 e8
            hex fe ff a5 a1 6d 8b 20 da ; 00BA0:  fe ff a5 a1 6d 8b 20 da
            hex d8 af 8b 8a 55 ba cf a5 ; 00BA8:  d8 af 8b 8a 55 ba cf a5
            hex a1 6d 8b 10 da d8 bc 8b ; 00BB0:  a1 6d 8b 10 da d8 bc 8b
            hex 8a 6a 79 cf 0c d9 04 00 ; 00BB8:  8a 6a 79 cf 0c d9 04 00
            hex 07 00 d2 8b 0d 00 d8 8b ; 00BC0:  07 00 d2 8b 0d 00 d8 8b
            hex 17 00 d2 8b 1e 00 d8 8b ; 00BC8:  17 00 d2 8b 1e 00 d8 8b
            hex de 8b 8a 43 ba 2b 0b cf ; 00BD0:  de 8b 8a 43 ba 2b 0b cf

            txa                         ; 00BD8:  8a
            jmp $d6ba                   ; 00BD9:  4c ba d6

tab_b0_8bdc: ; 530 bytes
            hex d5 8b 3c e9 70 8b 02 d6 ; 00BDC:  d5 8b 3c e9 70 8b 02 d6
            hex d5 8b 20 23 e8 fe ff ac ; 00BE4:  d5 8b 20 23 e8 fe ff ac
            hex a2 e4 8a 89 6f d6 03 8c ; 00BEC:  a2 e4 8a 89 6f d6 03 8c
            hex 0b d3 b3 e9 b7 d9 02 d8 ; 00BF4:  0b d3 b3 e9 b7 d9 02 d8
            hex 01 8c 0b d3 cf 0b d0 2b ; 00BFC:  01 8c 0b d3 cf 0b d0 2b
            hex 0b d3 8c ff 00 c1 d7 f4 ; 00C04:  0b d3 8c ff 00 c1 d7 f4
            hex 8b cf 20 23 e8 00 00 a4 ; 00C0C:  8b cf 20 23 e8 00 00 a4
            hex 5f 6f 8c f7 6c bb d3 55 ; 00C14:  5f 6f 8c f7 6c bb d3 55
            hex c0 cf 20 23 e8 00 00 ac ; 00C1C:  c0 cf 20 23 e8 00 00 ac
            hex a9 d9 d8 2f 8c ac 0e 8c ; 00C24:  a9 d9 d8 2f 8c ac 0e 8c
            hex d7 33 8c 40 d6 34 8c 41 ; 00C2C:  d7 33 8c 40 d6 34 8c 41
            hex cf 20 23 e8 00 00 0c 8b ; 00C34:  cf 20 23 e8 00 00 0c 8b
            hex 36 b5 1d bb 8c 93 61 bb ; 00C3C:  36 b5 1d bb 8c 93 61 bb
            hex cf 20 23 e8 fc ff 40 2b ; 00C44:  cf 20 23 e8 fc ff 40 2b
            hex a4 9d 6d d6 68 8c 0a 8c ; 00C4C:  a4 9d 6d d6 68 8c 0a 8c
            hex 1a 6f bb d3 a8 5f 6f ac ; 00C54:  1a 6f bb d3 a8 5f 6f ac
            hex 1e 8c d8 66 8c 41 2b d6 ; 00C5C:  1e 8c d8 66 8c 41 2b d6
            hex 6d 8c 0a d1 2a 0a d7 52 ; 00C64:  6d 8c 0a d1 2a 0a d7 52
            hex 8c 0b d7 74 8c ac 62 d9 ; 00C6C:  8c 0b d7 74 8c ac 62 d9
            hex cf 20 23 e8 f4 ff 40 27 ; 00C74:  cf 20 23 e8 f4 ff 40 27
            hex 40 28 0c 52 c6 d8 8c 8c ; 00C7C:  40 28 0c 52 c6 d8 8c 8c
            hex aa 63 6f e9 1b e2 02 cf ; 00C84:  aa 63 6f e9 1b e2 02 cf
            hex 40 2b 8a 4f 6f 29 d6 36 ; 00C8C:  40 2b 8a 4f 6f 29 d6 36
            hex 8d 09 d3 a8 5f 6f ac e6 ; 00C94:  8d 09 d3 a8 5f 6f ac e6
            hex 8b a8 5f 6f aa 5f 6f e9 ; 00C9C:  8b a8 5f 6f aa 5f 6f e9
            hex 8d d9 02 d8 0a 8d ac 7e ; 00CA4:  8d d9 02 d8 0a 8d ac 7e
            hex d7 8c 67 6d bb d3 d7 22 ; 00CAC:  d7 8c 67 6d bb d3 d7 22
            hex 8d a4 5f 6f 8b 1a b5 8c ; 00CB4:  8d a4 5f 6f 8b 1a b5 8c
            hex 01 70 bb b0 50 c4 d8 22 ; 00CBC:  01 70 bb b0 50 c4 d8 22
            hex 8d 8d 1c e9 03 ca 02 8e ; 00CC4:  8d 8d 1c e9 03 ca 02 8e
            hex 5e ba e9 26 d3 02 09 d3 ; 00CCC:  5e ba e9 26 d3 02 09 d3
            hex b3 e9 8b d7 02 a4 63 6f ; 00CD4:  b3 e9 8b d7 02 a4 63 6f
            hex d0 b3 8e 5f ba e9 34 d1 ; 00CDC:  d0 b3 8e 5f ba e9 34 d1
            hex 04 ac a7 d3 d8 22 8d 8e ; 00CE4:  04 ac a7 d3 d8 22 8d 8e
            hex 83 ba e9 26 d3 02 a4 5f ; 00CEC:  83 ba e9 26 d3 02 a4 5f
            hex 6f 8b 1a b5 8c 01 70 bb ; 00CF4:  6f 8b 1a b5 8c 01 70 bb
            hex b0 b3 61 e9 e9 d5 04 28 ; 00CFC:  b0 b3 61 e9 e9 d5 04 28
            hex ac 89 cc d6 22 8d a4 5f ; 00D04:  ac 89 cc d6 22 8d a4 5f
            hex 6f 8b 1a b5 8c 01 70 bb ; 00D0C:  6f 8b 1a b5 8c 01 70 bb
            hex b0 26 06 18 c4 d8 22 8d ; 00D14:  b0 26 06 18 c4 d8 22 8d
            hex 36 e9 52 ca 02 28 07 18 ; 00D1C:  36 e9 52 ca 02 28 07 18
            hex c2 d8 2e 8d 08 27 a4 5f ; 00D24:  c2 d8 2e 8d 08 27 a4 5f
            hex 6f 2a 09 d0 29 d1 0b d0 ; 00D2C:  6f 2a 09 d0 29 d1 0b d0
            hex 2b d1 09 d3 8c ff 00 c1 ; 00D34:  2b d1 09 d3 8c ff 00 c1
            hex d7 95 8c 07 d7 4d 8d aa ; 00D3C:  d7 95 8c 07 d7 4d 8d aa
            hex 63 6f e9 1b e2 02 d6 e0 ; 00D44:  63 6f e9 1b e2 02 d6 e0
            hex 8d a4 63 6f 8c f7 6c bb ; 00D4C:  8d a4 63 6f 8c f7 6c bb
            hex b3 3a e9 8d d9 02 d8 61 ; 00D54:  b3 3a e9 8d d9 02 d8 61
            hex 8d 45 d6 62 8d 40 d4 a4 ; 00D5C:  8d 45 d6 62 8d 40 d4 a4
            hex 63 6f 8c a2 6d bb b3 40 ; 00D64:  63 6f 8c a2 6d bb b3 40
            hex d4 a4 63 6f 8c 15 6e bb ; 00D6C:  d4 a4 63 6f 8c 15 6e bb
            hex b3 3a e9 72 d7 02 d4 38 ; 00D74:  b3 3a e9 72 d7 02 d4 38
            hex 0a 8b 1a b5 8c 01 70 bb ; 00D7C:  0a 8b 1a b5 8c 01 70 bb
            hex b4 b3 b0 bc b1 3a e9 8d ; 00D84:  b4 b3 b0 bc b1 3a e9 8d
            hex d9 02 d8 ac 8d 8e 8c ba ; 00D8C:  d9 02 d8 ac 8d 8e 8c ba
            hex e9 26 d3 02 3a e9 8b d7 ; 00D94:  e9 26 d3 02 3a e9 8b d7
            hex 02 a4 63 6f d0 b3 8e 8d ; 00D9C:  02 a4 63 6f d0 b3 8e 8d
            hex ba e9 34 d1 04 d6 d6 8d ; 00DA4:  ba e9 34 d1 04 d6 d6 8d
            hex 8e a1 ba e9 26 d3 02 a4 ; 00DAC:  8e a1 ba e9 26 d3 02 a4
            hex 63 6f d0 b3 8e a7 ba e9 ; 00DB4:  63 6f d0 b3 8e a7 ba e9
            hex 34 d1 04 3a e9 72 d7 02 ; 00DBC:  34 d1 04 3a e9 72 d7 02
            hex 59 b5 8c a8 77 bb b3 e9 ; 00DC4:  59 b5 8c a8 77 bb b3 e9
            hex c4 ce 02 8e b3 ba e9 c4 ; 00DCC:  c4 ce 02 8e b3 ba e9 c4
            hex ce 02 aa 63 6f e9 54 e5 ; 00DD4:  ce 02 aa 63 6f e9 54 e5
            hex 02 ac 66 d7 cf 20 23 e8 ; 00DDC:  02 ac 66 d7 cf 20 23 e8
            hex f2 ff 0c d0 2c d1 d3 a2 ; 00DE4:  f2 ff 0c d0 2c d1 d3 a2
            hex f2 ff                   ; 00DEC:  f2 ff

            eor ($2a,x)                 ; 00DEE:  41 2a
            dec $33,x                   ; 00DF0:  d6 33
            stx $2940                   ; 00DF2:  8e 40 29
            rti                         ; 00DF5:  40

tab_b0_8df6: ; 94 bytes
            hex d6 17 8e 0c d3 b3 e9 72 ; 00DF6:  d6 17 8e 0c d3 b3 e9 72
            hex d7 02 b3 de f2 ff b3 0b ; 00DFE:  d7 02 b3 de f2 ff b3 0b
            hex b4 bb d3 b3 e9 72 d7 02 ; 00E06:  b4 bb d3 b3 e9 72 d7 02
            hex b4 c0 d8 15 8e 41 29 0b ; 00E0E:  b4 c0 d8 15 8e 41 29 0b
            hex d0 2b 0b 1a c6 d7 f9 8d ; 00E16:  d0 2b 0b 1a c6 d7 f9 8d
            hex 09 d7 30 8e de f2 ff b3 ; 00E1E:  09 d7 30 8e de f2 ff b3
            hex 0a d0 2a d1 b4 bb b3 0c ; 00E26:  0a d0 2a d1 b4 bb b3 0c
            hex d3 d4 0c d0 2c 0c d3 8c ; 00E2E:  d3 d4 0c d0 2c 0c d3 8c
            hex ff 00 c1 d7 f3 8d 40 d6 ; 00E36:  ff 00 c1 d7 f3 8d 40 d6
            hex 51 8e 0b 8c 4f 6f bb b3 ; 00E3E:  51 8e 0b 8c 4f 6f bb b3
            hex de f2 ff b3 0b b4 bb d3 ; 00E46:  de f2 ff b3 0b b4 bb d3
            hex d4 0b d0 2b 0b 1a       ; 00E4E:  d4 0b d0 2b 0b 1a

            dec $d7                     ; 00E54:  c6 d7
            rti                         ; 00E56:  40

            hex 8e 0b 8c 4f 6f bb b3 89 ; 00E57:  8e 0b 8c 4f 6f bb b3 89
            hex ff d4 0a cf 20 23 e8 fe ; 00E5F:  ff d4 0a cf 20 23 e8 fe
            hex ff 40 d6 8f 8e 3b e9 99 ; 00E67:  ff 40 d6 8f 8e 3b e9 99
            hex d9 02 d8 8d 8e 0b a8 5f ; 00E6F:  d9 02 d8 8d 8e 0b a8 5f
            hex 6f a4 5f 6f a8 63 6f ac ; 00E77:  6f a4 5f 6f a8 63 6f ac
            hex d7 da 8e 4f 6f e9 e1 8d ; 00E7F:  d7 da 8e 4f 6f e9 e1 8d
            hex 02 b3 e9 75 8c 02 0b d0 ; 00E87:  02 b3 e9 75 8c 02 0b d0
            hex 2b 0b                   ; 00E8F:  2b 0b

            ldx $9d                     ; 00E91:  a6 9d
            adc $d7c6                   ; 00E93:  6d c6 d7
            jmp ($cf8e)                 ; 00E96:  6c 8e cf

tab_b0_8e99: ; 314 bytes
            hex 20 23 e8 00 00 0d d2 8c ; 00E99:  20 23 e8 00 00 0d d2 8c
            hex 67 6f bb b3 0c d4 0d d2 ; 00EA1:  67 6f bb b3 0c d4 0d d2
            hex 8c 68 6f bb b3 0e d4 0d ; 00EA9:  8c 68 6f bb b3 0e d4 0d
            hex d0 d2 8c 67 6f bb b3 89 ; 00EB1:  d0 d2 8c 67 6f bb b3 89
            hex ff d4 cf 20 23 e8 00 00 ; 00EB9:  ff d4 cf 20 23 e8 00 00
            hex 0c 1d c0 d8 cf 8e 62 e9 ; 00EC1:  0c 1d c0 d8 cf 8e 62 e9
            hex 52 ca 02 50 c0 cf 0d 1c ; 00EC9:  52 ca 02 50 c0 cf 0d 1c
            hex c2 cf 20 23 e8 fa ff 3e ; 00ED1:  c2 cf 20 23 e8 fa ff 3e
            hex e9 78 de 02 2b 3e e9 9d ; 00ED9:  e9 78 de 02 2b 3e e9 9d
            hex 8b 02 2a 8e c0 ba e9 26 ; 00EE1:  8b 02 2a 8e c0 ba e9 26
            hex d3 02 3b 0e d0 b3 8e c9 ; 00EE9:  d3 02 3b 0e d0 b3 8e c9
            hex ba e9 34 d1 06 3c 3a 3d ; 00EF1:  ba e9 34 d1 06 3c 3a 3d
            hex 8e cf ba e9 34 d1 08 ac ; 00EF9:  8e cf ba e9 34 d1 08 ac
            hex 66 d7 3d 3c e9 bc 8e 04 ; 00F01:  66 d7 3d 3c e9 bc 8e 04
            hex cf 20 23 e8 f2 ff 3c e9 ; 00F09:  cf 20 23 e8 f2 ff 3c e9
            hex 78 de 02 2a 8d 1e e9 03 ; 00F11:  78 de 02 2a 8d 1e e9 03
            hex ca 02 0c 8b 1a b5 8c 01 ; 00F19:  ca 02 0c 8b 1a b5 8c 01
            hex 70 bb 2b 8d 14 e9 52 ca ; 00F21:  70 bb 2b 8d 14 e9 52 ca
            hex 02 b3 0b 7e b0 b3 e9 cd ; 00F29:  02 b3 0b 7e b0 b3 e9 cd
            hex cb 02 b3 0b 78 b0 b3 e9 ; 00F31:  cb 02 b3 0b 78 b0 b3 e9
            hex cd cb 02 b4 bb b4 bb 7a ; 00F39:  cd cb 02 b4 bb b4 bb 7a
            hex 29 0b 8f 10 b0 28 3c 38 ; 00F41:  29 0b 8f 10 b0 28 3c 38
            hex 39 e9 d3 8e 06 d8 96 8f ; 00F49:  39 e9 d3 8e 06 d8 96 8f
            hex 8e fd ba e9 26 d3 02 3a ; 00F51:  8e fd ba e9 26 d3 02 3a
            hex 8e fe ba e9 34 d1 04 ac ; 00F59:  8e fe ba e9 34 d1 04 ac
            hex 66 d7 0c 8c a2 6d bb d3 ; 00F61:  66 d7 0c 8c a2 6d bb d3
            hex d8 8e 8f 3c e9 72 d7 02 ; 00F69:  d8 8e 8f 3c e9 72 d7 02
            hex 25 3c e9 75 e2 02 35 e9 ; 00F71:  25 3c e9 75 e2 02 35 e9
            hex 0e dc 02 35 e9 3c dc 02 ; 00F79:  0e dc 02 35 e9 3c dc 02
            hex 3c e9 25 e4 02 3c e9 1b ; 00F81:  3c e9 25 e4 02 3c e9 1b
            hex e2 02 d6 d2 8f 3c e9 54 ; 00F89:  e2 02 d6 d2 8f 3c e9 54
            hex e4 02 d6 d2 8f 8e 0b bb ; 00F91:  e4 02 d6 d2 8f 8e 0b bb
            hex e9 26 d3 02 8d 32 e9 52 ; 00F99:  e9 26 d3 02 8d 32 e9 52
            hex ca 02 7a b3 0b 8f 10 b0 ; 00FA1:  ca 02 7a b3 0b 8f 10 b0
            hex b3 e9 0d d7 04 b3 0b 8f ; 00FA9:  b3 e9 0d d7 04 b3 0b 8f
            hex 10 b4 b3 b0 bc b1 8d 32 ; 00FB1:  10 b4 b3 b0 bc b1 8d 32
            hex e9 52 ca 02 7a b3 0b 78 ; 00FB9:  e9 52 ca 02 7a b3 0b 78
            hex b0 b3 e9 0d d7 04 b3 0b ; 00FC1:  b0 b3 e9 0d d7 04 b3 0b
            hex 78 b4 b3 b0 bc b1 ac 66 ; 00FC9:  78 b4 b3 b0 bc b1 ac 66
            hex d7 cf                   ; 00FD1:  d7 cf

            jsr $e823                   ; 00FD3:  20 23 e8
            brk                         ; 00FD6:  00
            hex 00                      ; 00FD7:  00
            rts                         ; 00FD8:  60

            hex 3d 3c e9 99 8e 06 cf    ; 00FD9:  3d 3c e9 99 8e 06 cf

            jsr $e823                   ; 00FE0:  20 23 e8
            brk                         ; 00FE3:  00
            hex 00                      ; 00FE4:  00
            ora $198b                   ; 00FE5:  0d 8b 19
            cpy $d8                     ; 00FE8:  c4 d8
            inc $8f,x                   ; 00FEA:  f6 8f
            ora b0_bc1a+2               ; 00FEC:  0d 1c bc
            eor $c4,x                   ; 00FEF:  55 c4
            cld                         ; 00FF1:  d8
            inc $8f,x                   ; 00FF2:  f6 8f
            eor ($cf,x)                 ; 00FF4:  41 cf
            rti                         ; 00FF6:  40

            hex cf 20 23 e8 f2 ff       ; 00FF7:  cf 20 23 e8 f2 ff

            txa                         ; 00FFD:  8a
b0_8ffe:    lda $2b7b                   ; 00FFE:  ad 7b 2b
            rti                         ; 01001:  40

            hex 29 d6 b6 90 ac 1e 8c d8 ; 01002:  29 d6 b6 90 ac 1e 8c d8
            hex 97 90 a4 5f 6f 8b 1a b5 ; 0100A:  97 90 a4 5f 6f 8b 1a b5
            hex 8c 01 70 bb 25 28 05 7c ; 01012:  8c 01 70 bb 25 28 05 7c
            hex 27 07 b0 26 08 b0 d8 8a ; 0101A:  27 07 b0 26 08 b0 d8 8a
            hex 90 ac 7e d7 8c 67 6d bb ; 01022:  90 ac 7e d7 8c 67 6d bb
            hex d3 d7 8a 90 8e 26 bb e9 ; 0102A:  d3 d7 8a 90 8e 26 bb e9
            hex 26 d3 02 aa 5f 6f e9 8b ; 01032:  26 d3 02 aa 5f 6f e9 8b
            hex d7 02 8e 27 bb e9 c4 ce ; 0103A:  d7 02 8e 27 bb e9 c4 ce
            hex 02 ac a7 d3             ; 01042:  02 ac a7 d3

            cld                         ; 01046:  d8
            txa                         ; 01047:  8a
            bcc b0_904f                 ; 01048:  90 05
            bcs b0_8ffe+1               ; 0104A:  b0 b3
            and $e9,x                   ; 0104C:  35 e9
            rti                         ; 0104E:  40

b0_904f:    cmp $3504,y                 ; 0104F:  d9 04 35
            rti                         ; 01052:  40

tab_b0_9053: ; 279 bytes
            hex b1 8e 62 bb e9 26 d3 02 ; 01053:  b1 8e 62 bb e9 26 d3 02
            hex 07 b0 b3 36 e9 e0 8f 04 ; 0105B:  07 b0 b3 36 e9 e0 8f 04
            hex d7 7d 90 8e 74 bb e9 c4 ; 01063:  d7 7d 90 8e 74 bb e9 c4
            hex ce 02 ac 59 d7 09 d0 29 ; 0106B:  ce 02 ac 59 d7 09 d0 29
            hex d1 b3 aa 5f 6f e9 d3 8f ; 01073:  d1 b3 aa 5f 6f e9 d3 8f
            hex 04 cf 8e 84 bb e9 c4 ce ; 0107B:  04 cf 8e 84 bb e9 c4 ce
            hex 02 ac 66 d7 d6 b6 90 09 ; 01083:  02 ac 66 d7 d6 b6 90 09
            hex d0 29 d1 b3 aa 5f 6f e9 ; 0108B:  d0 29 d1 b3 aa 5f 6f e9
            hex d3 8f 04 cf aa 5f 6f e9 ; 01093:  d3 8f 04 cf aa 5f 6f e9
            hex 0a 8f 02 8d 1e e9 52 ca ; 0109B:  0a 8f 02 8d 1e e9 52 ca
            hex 02 8f 32 b3 a4 5f 6f 8b ; 010A3:  02 8f 32 b3 a4 5f 6f 8b
            hex 1a b5 8c 0d 70 bb b4 b3 ; 010AB:  1a b5 8c 0d 70 bb b4 b3
            hex b0 bb b1 0b d0 2b d1 d3 ; 010B3:  b0 bb b1 0b d0 2b d1 d3
            hex a8 5f 6f 8c ff 00 c1 d7 ; 010BB:  a8 5f 6f 8c ff 00 c1 d7
            hex 06 90 cf 20 23 e8 00 00 ; 010C3:  06 90 cf 20 23 e8 00 00
            hex 0c d3 8b 64 c5 d8 d6 90 ; 010CB:  0c d3 8b 64 c5 d8 d6 90
            hex 3c 40 d4 cf 20 23 e8 00 ; 010D3:  3c 40 d4 cf 20 23 e8 00
            hex 00 3d 3c e9 12 ca 04 3c ; 010DB:  00 3d 3c e9 12 ca 04 3c
            hex e9 c6 90 02 cf 20 23 e8 ; 010E3:  e9 c6 90 02 cf 20 23 e8
            hex fc ff 40 d6 14 91 40 d6 ; 010EB:  fc ff 40 d6 14 91 40 d6
            hex 09 91 0b 1a c6 d8 07 91 ; 010F3:  09 91 0b 1a c6 d8 07 91
            hex 3c 3a 3b e9 35 8c 04 b3 ; 010FB:  3c 3a 3b e9 35 8c 04 b3
            hex e9 d7 90 04 0a d0 2a 0a ; 01103:  e9 d7 90 04 0a d0 2a 0a
            hex a6 9d 6d c6 d7 f5 90 0b ; 0110B:  a6 9d 6d c6 d7 f5 90 0b
            hex d0 2b 0b a6 9d 6d c6 d7 ; 01113:  d0 2b 0b a6 9d 6d c6 d7
            hex f1 90 cf 20 23 e8 fc ff ; 0111B:  f1 90 cf 20 23 e8 fc ff
            hex 40 d6 4a 91 40 d6 3f 91 ; 01123:  40 d6 4a 91 40 d6 3f 91
            hex 0b 1a c6 d8 3d 91 3c 3b ; 0112B:  0b 1a c6 d8 3d 91 3c 3b
            hex 3a e9 35 8c 04 b3 e9 d7 ; 01133:  3a e9 35 8c 04 b3 e9 d7
            hex 90 04 0a d0 2a 0a a6 9d ; 0113B:  90 04 0a d0 2a 0a a6 9d
            hex 6d c6 d7 2b 91 0b d0 2b ; 01143:  6d c6 d7 2b 91 0b d0 2b
            hex 0b a6 9d 6d c6 d7 27 91 ; 0114B:  0b a6 9d 6d c6 d7 27 91
            hex cf 20 23 e8 fe ff 3c e9 ; 01153:  cf 20 23 e8 fe ff 3c e9
            hex cd d7 02 2b 0b d0 d3 d7 ; 0115B:  cd d7 02 2b 0b d0 d3 d7
            hex 67 91 42 cf 0b d3 8b    ; 01163:  67 91 42 cf 0b d3 8b

            lsr $c2                     ; 0116A:  46 c2
            cld                         ; 0116C:  d8
            adc ($91),y                 ; 0116D:  71 91
            rti                         ; 0116F:  40

            hex cf 0b d0 d3 54 b6 b3 0b ; 01170:  cf 0b d0 d3 54 b6 b3 0b
            hex d3 8f f6 b4 bc b3 8e 2c ; 01178:  d3 8f f6 b4 bc b3 8e 2c
            hex 01 e9 52 ca 02 b4 c2 d8 ; 01180:  01 e9 52 ca 02 b4 c2 d8
            hex 92 91 0c 8c d4 6d bb d3 ; 01188:  92 91 0c 8c d4 6d bb d3

            bne tab_b0_9053+270         ; 01190:  d0 cf
            rti                         ; 01192:  40

            hex cf 20 23 e8 fc ff 0c 8c ; 01193:  cf 20 23 e8 fc ff 0c 8c
            hex a2 6d bb d3 d8 fc 91 3c ; 0119B:  a2 6d bb d3 d8 fc 91 3c
            hex e9 72 d7 02 2b 3b e9 54 ; 011A3:  e9 72 d7 02 2b 3b e9 54
            hex 91 02 2a d8 fc 91 0a 51 ; 011AB:  91 02 2a d8 fc 91 0a 51
            hex c0 d8 be 91 a4 5f 6d d8 ; 011B3:  c0 d8 be 91 a4 5f 6d d8
            hex be 91 cf 3b e9 0e dc 02 ; 011BB:  be 91 cf 3b e9 0e dc 02
            hex 3b e9 3c dc 02 3c e9 8d ; 011C3:  3b e9 3c dc 02 3c e9 8d
            hex d9 02 d8 d3 91 ac 35 db ; 011CB:  d9 02 d8 d3 91 ac 35 db
            hex 0b 59 b5 8c a8 77 bb b3 ; 011D3:  0b 59 b5 8c a8 77 bb b3
            hex e9 26 d3 02 0a d1 d2 8c ; 011DB:  e9 26 d3 02 0a d1 d2 8c
            hex a5 bb bb b0 b3 8e ba bb ; 011E3:  a5 bb bb b0 b3 8e ba bb
            hex e9 34 d1 04 3c e9 e7 e1 ; 011EB:  e9 34 d1 04 3c e9 e7 e1
            hex 02 ac 66 d7 3c e9 25 e4 ; 011F3:  02 ac 66 d7 3c e9 25 e4
            hex 02 cf 20 23 e8 00 00 0c ; 011FB:  02 cf 20 23 e8 00 00 0c
            hex 1d c4 d8 0a 92 0c cf 0d ; 01203:  1d c4 d8 0a 92 0c cf 0d
            hex 1e c4 d8 12 92 0e cf 0d ; 0120B:  1e c4 d8 12 92 0e cf 0d
            hex cf 20 23 e8 00 00 8d 33 ; 01213:  cf 20 23 e8 00 00 8d 33
            hex e9 52 ca 02 b3 a4 9f 6d ; 0121B:  e9 52 ca 02 b3 a4 9f 6d
            hex 90 e8 f9 52 b6 72 5a b5 ; 01223:  90 e8 f9 52 b6 72 5a b5
            hex b4 bb cf 20 23 e8 00 00 ; 0122B:  b4 bb cf 20 23 e8 00 00
            hex 62 e9 52 ca 02 d8 42 92 ; 01233:  62 e9 52 ca 02 d8 42 92
            hex 66 e9 52 ca 02 75 cf 6a ; 0123B:  66 e9 52 ca 02 75 cf 6a
            hex e9 52 ca 02 8f 1e cf 20 ; 01243:  e9 52 ca 02 8f 1e cf 20
            hex 23 e8 fc ff 6a e9 52 ca ; 0124B:  23 e8 fc ff 6a e9 52 ca
            hex 02 d0 a8 0b 6e 65 e9 52 ; 01253:  02 d0 a8 0b 6e 65 e9 52
            hex ca 02 d8 76 92 8d 1e 6b ; 0125B:  ca 02 d8 76 92 8d 1e 6b
            hex e9 52 ca 02 a6 0d 6e bb ; 01263:  e9 52 ca 02 a6 0d 6e bb
            hex 8f fb b3 6a e9 fd 91 06 ; 0126B:  8f fb b3 6a e9 fd 91 06
            hex d6 79 92 ac 2e 92 a8 0d ; 01273:  d6 79 92 ac 2e 92 a8 0d
            hex 6e ac 14 92 52 b6 a8 0f ; 0127B:  6e ac 14 92 52 b6 a8 0f
            hex 6e 8d 46 ac 14 92 b3 e9 ; 01283:  6e 8d 46 ac 14 92 b3 e9
            hex 0d d7 04 a8 11 6e a4 9f ; 0128B:  0d d7 04 a8 11 6e a4 9f
            hex 6d 90 e8 f9 5a b5 b3 8d ; 01293:  6d 90 e8 f9 5a b5 b3 8d
            hex 65 e9 52 ca 02 b4 bb 74 ; 0129B:  65 e9 52 ca 02 b4 bb 74
            hex 54 b6 a8 13 6e cf 20 23 ; 012A3:  54 b6 a8 13 6e cf 20 23
            hex e8 00 00 0c 72 b0 d7 b6 ; 012AB:  e8 00 00 0c 72 b0 d7 b6
            hex 92 41 cf 0c 72 b0 b3 0c ; 012B3:  92 41 cf 0c 72 b0 b3 0c
            hex b0 b3 e9 5e cb 04 b3 3d ; 012BB:  b0 b3 e9 5e cb 04 b3 3d
            hex e9 5e cb 04 2d 3d 0c b4 ; 012C3:  e9 5e cb 04 2d 3d 0c b4
            hex b3 b0 bc b1 3d 0c 72 b4 ; 012CB:  b3 b0 bc b1 3d 0c 72 b4
            hex b3 b0 bc b1 40 cf 20 23 ; 012D3:  b3 b0 bc b1 40 cf 20 23
            hex e8 00 00 0c b0 50 c3 d7 ; 012DB:  e8 00 00 0c b0 50 c3 d7
            hex f5 92 0d b0 b3 0c b4 b3 ; 012E3:  f5 92 0d b0 b3 0c b4 b3
            hex b0 bc b1 0c b0 50 c2 d8 ; 012EB:  b0 bc b1 0c b0 50 c2 d8
            hex f8 92 3d 40 b1 cf 20 23 ; 012F3:  f8 92 3d 40 b1 cf 20 23
            hex e8 00 00 62 e9 52 ca 02 ; 012FB:  e8 00 00 62 e9 52 ca 02
            hex d7 0d 93 0c b0 50 c3 d8 ; 01303:  d7 0d 93 0c b0 50 c3 d8
            hex 0f 93 40 cf 3c 8d 1e e9 ; 0130B:  0f 93 40 cf 3c 8d 1e e9
            hex 52 ca 02 8f 28 b3 0c b0 ; 01313:  52 ca 02 8f 28 b3 0c b0
            hex b3 e9 0d d7 04 b1 41 cf ; 0131B:  b3 e9 0d d7 04 b1 41 cf
            hex 20 23 e8 00 00 a4 63 6f ; 01323:  20 23 e8 00 00 a4 63 6f
            hex 8b 1a b5 8c 0b 70 bb b3 ; 0132B:  8b 1a b5 8c 0b 70 bb b3
            hex e9 f9 92 02 cf 20 23 e8 ; 01333:  e9 f9 92 02 cf 20 23 e8
            hex 00 00 a4 63 6f 8b 1a b5 ; 0133B:  00 00 a4 63 6f 8b 1a b5
            hex 8c 09 70 bb b3 e9 f9 92 ; 01343:  8c 09 70 bb b3 e9 f9 92
            hex 02 d8 69 93 8d 64 e9 52 ; 0134B:  02 d8 69 93 8d 64 e9 52
            hex ca 02 8f 64 b3 a4 5f 6f ; 01353:  ca 02 8f 64 b3 a4 5f 6f
            hex 8b 1a b5 8c 0f 70 bb b4 ; 0135B:  8b 1a b5 8c 0f 70 bb b4
            hex b3 b0 bb b1 41 cf 40 cf ; 01363:  b3 b0 bb b1 41 cf 40 cf
            hex 20 23 e8 00 00 a4 63 6f ; 0136B:  20 23 e8 00 00 a4 63 6f
            hex 8b 1a b5 8c 05 70 bb b3 ; 01373:  8b 1a b5 8c 05 70 bb b3
            hex e9 f9 92 02 cf 20 23 e8 ; 0137B:  e9 f9 92 02 cf 20 23 e8
            hex 00 00 a4 63 6f 8b 1a b5 ; 01383:  00 00 a4 63 6f 8b 1a b5
            hex 8c 0f 70 bb b3 e9 f9 92 ; 0138B:  8c 0f 70 bb b3 e9 f9 92
            hex 02 cf 20 23 e8 00 00 a4 ; 01393:  02 cf 20 23 e8 00 00 a4
            hex 63 6f 8b 1a b5 8c 13 70 ; 0139B:  63 6f 8b 1a b5 8c 13 70
            hex bb b3 e9 f9 92 02 cf 20 ; 013A3:  bb b3 e9 f9 92 02 cf 20
            hex 23 e8 00 00 a4 63 6f 8b ; 013AB:  23 e8 00 00 a4 63 6f 8b
            hex 1a b5 8c 0d 70 bb b3 e9 ; 013B3:  1a b5 8c 0d 70 bb b3 e9
            hex f9 92 02 cf 20 23 e8 fc ; 013BB:  f9 92 02 cf 20 23 e8 fc
            hex ff 8e c6 bb e9 26 d3 02 ; 013C3:  ff 8e c6 bb e9 26 d3 02
            hex aa 63 6f e9 8b d7 02 8e ; 013CB:  aa 63 6f e9 8b d7 02 8e
            hex c7 bb e9 c4 ce 02 a4 63 ; 013D3:  c7 bb e9 c4 ce 02 a4 63
            hex 6f d0 b3 8e ec bb e9 34 ; 013DB:  6f d0 b3 8e ec bb e9 34
            hex d1 04 ac 66 d7 6f e9 0c ; 013E3:  d1 04 ac 66 d7 6f e9 0c
            hex e8 02 ac 23 93 d7 4e 94 ; 013EB:  e8 02 ac 23 93 d7 4e 94
            hex ac 6b 93 d7 4e 94 ac aa ; 013F3:  ac 6b 93 d7 4e 94 ac aa
            hex 93 d7 4e 94 ac 95 93 d7 ; 013FB:  93 d7 4e 94 ac 95 93 d7
            hex 4e 94 ac 80 93 d7 4e 94 ; 01403:  4e 94 ac 80 93 d7 4e 94
            hex ac 38 93 d7 4e 94 62 e9 ; 0140B:  ac 38 93 d7 4e 94 62 e9
            hex 52 ca 02 d8 6b 94 a4 63 ; 01413:  52 ca 02 d8 6b 94 a4 63
            hex 6f 8b 1a b5 8c 01 70 bb ; 0141B:  6f 8b 1a b5 8c 01 70 bb
            hex 2b aa 63 6f e9 da d7 02 ; 01423:  2b aa 63 6f e9 da d7 02
            hex 2a 0b 7a b0 50 c3 d8 53 ; 0142B:  2a 0b 7a b0 50 c3 d8 53
            hex 94 65 e9 52 ca 02 b3 0a ; 01433:  94 65 e9 52 ca 02 b3 0a
            hex 74 b3 e9 12 ca 04 65 e9 ; 0143B:  74 b3 e9 12 ca 04 65 e9
            hex 52 ca 02 b3 0a d0 b3 e9 ; 01443:  52 ca 02 b3 0a d0 b3 e9
            hex 12 ca 04 ac 66 d7 41 cf ; 0144B:  12 ca 04 ac 66 d7 41 cf
            hex 0b 7a b3 8d 1e e9 52 ca ; 01453:  0b 7a b3 8d 1e e9 52 ca
            hex 02 8f 3c b3 0b 7a b0 b3 ; 0145B:  02 8f 3c b3 0b 7a b0 b3
            hex e9 0d d7 04 b1 d6 4e 94 ; 01463:  e9 0d d7 04 b1 d6 4e 94
            hex 40 cf 20 23 e8 00 00 3c ; 0146B:  40 cf 20 23 e8 00 00 3c
            hex e9 da d7 02 74 d3 cf 20 ; 01473:  e9 da d7 02 74 d3 cf 20
            hex 23 e8 fa ff             ; 0147B:  23 e8 fa ff

            hex 8e ff 00 ; stx $00ff    ; 0147F:  8e ff 00
            sbc #$dc                    ; 01482:  e9 dc
            cpx ptr1_lo                     ; 01484:  e4 02
            rti                         ; 01486:  40

            hex 29 40 2a 8a 89 6f 2b d6 ; 01487:  29 40 2a 8a 89 6f 2b d6
            hex a4 94 0b d3 b3 e9 6d 94 ; 0148F:  a4 94 0b d3 b3 e9 6d 94
            hex 02 cd 0a bb 2a 0b d0 2b ; 01497:  02 cd 0a bb 2a 0b d0 2b
            hex d1 09 d0 29 d1 0b d3 8c ; 0149F:  d1 09 d0 29 d1 0b d3 8c
            hex ff 00 c1 d7 91 94 0a 19 ; 014A7:  ff 00 c1 d7 91 94 0a 19
            hex b8 cf 20 23 e8 fc ff 0c ; 014AF:  b8 cf 20 23 e8 fc ff 0c
            hex d9 02 00 01 00 c4 94 02 ; 014B7:  d9 02 00 01 00 c4 94 02
            hex 00 e9 94 ce 94 8e f1 bb ; 014BF:  00 e9 94 ce 94 8e f1 bb
            hex e9 26 d3 02             ; 014C7:  e9 26 d3 02

            ldy $d766                   ; 014CB:  ac 66 d7
            rti                         ; 014CE:  40

            hex 2b d6 1d 95 3a e9 8d d9 ; 014CF:  2b d6 1d 95 3a e9 8d d9
            hex 02 d8 1d 95 0c d9 02 00 ; 014D7:  02 d8 1d 95 0c d9 02 00
            hex 01 00 ef 94 02 00 04 95 ; 014DF:  01 00 ef 94 02 00 04 95
            hex 1d 95 8e 13 bc d6 c7 94 ; 014E7:  1d 95 8e 13 bc d6 c7 94
            hex 8e 2a bc e9 26 d3 02 3a ; 014EF:  8e 2a bc e9 26 d3 02 3a
            hex e9 8b d7 02 0a d0 b3 8e ; 014F7:  e9 8b d7 02 0a d0 b3 8e
            hex 2b bc d6 16 95 8e 4b bc ; 014FF:  2b bc d6 16 95 8e 4b bc
            hex e9 26 d3 02 3a e9 8b d7 ; 01507:  e9 26 d3 02 3a e9 8b d7
            hex 02 0a d0 b3 8e 4c bc e9 ; 0150F:  02 0a d0 b3 8e 4c bc e9
            hex 34 d1 04 ac 66 d7 0b d0 ; 01517:  34 d1 04 ac 66 d7 0b d0
            hex 2b d1 8c ad 7b bb d3 2a ; 0151F:  2b d1 8c ad 7b bb d3 2a
            hex 8c ff 00 c1 d7 d3 94 cf ; 01527:  8c ff 00 c1 d7 d3 94 cf
            hex 20 23 e8 fc ff 40 2b 40 ; 0152F:  20 23 e8 fc ff 40 2b 40
            hex d6 46 95 0a 8c 2d 6d bb ; 01537:  d6 46 95 0a 8c 2d 6d bb
            hex d3 cd 0b bb 2b 0a d0 2a ; 0153F:  d3 cd 0b bb 2b 0a d0 2a
            hex 0a a6 9d 6d c6 d7 3a 95 ; 01547:  0a a6 9d 6d c6 d7 3a 95
            hex a4 9d 6d cd 0b b8 2b 0b ; 0154F:  a4 9d 6d cd 0b b8 2b 0b
            hex cf 20 23 e8 f8 ff 40    ; 01557:  cf 20 23 e8 f8 ff 40

            plp                         ; 0155E:  28
            rti                         ; 0155F:  40

            hex 2b 40 2a d6 85 95 08 8b ; 01560:  2b 40 2a d6 85 95 08 8b
            hex 1a b5 8c 0f 70 bb b0 29 ; 01568:  1a b5 8c 0f 70 bb b0 29
            hex 09 a6 9d 6d b8 cd 0b bb ; 01570:  09 a6 9d 6d b8 cd 0b bb
            hex 2b 09 a6 9d 6d ba cd 0a ; 01578:  2b 09 a6 9d 6d ba cd 0a
            hex bb 2a 08 d0 28 08 a6 9d ; 01580:  bb 2a 08 d0 28 08 a6 9d
            hex 6d c6 d7 66 95 0a a6 9d ; 01588:  6d c6 d7 66 95 0a a6 9d
            hex 6d b8 1b bb cf 20 23 e8 ; 01590:  6d b8 1b bb cf 20 23 e8
            hex fa ff 8e 6a bc e9 26 d3 ; 01598:  fa ff 8e 6a bc e9 26 d3
            hex 02 0c d0 b3 8e 73 bc e9 ; 015A0:  02 0c d0 b3 8e 73 bc e9
            hex 34 d1 04 0c 8b 1a b5 8c ; 015A8:  34 d1 04 0c 8b 1a b5 8c
            hex 01 70 bb 2b 8d 1f e9 52 ; 015B0:  01 70 bb 2b 8d 1f e9 52
            hex ca 02 b3 3c e9 da d7 02 ; 015B8:  ca 02 b3 3c e9 da d7 02
            hex 74 d3 b3 8e c8 00 e9 5e ; 015C0:  74 d3 b3 8e c8 00 e9 5e
            hex cb 04 53 b5 8b 14 b6 b3 ; 015C8:  cb 04 53 b5 8b 14 b6 b3
            hex 0b 8f 12 b0 b3 8d 64 e9 ; 015D0:  0b 8f 12 b0 b3 8d 64 e9
            hex 5e cb 04 53 b5 5a b6 b4 ; 015D8:  5e cb 04 53 b5 5a b6 b4
            hex bb b4 bb 7a b3 0b 8f 10 ; 015E0:  bb b4 bb 7a b3 0b 8f 10
            hex b0 b3 e9 0d d7 04 2a 0b ; 015E8:  b0 b3 e9 0d d7 04 2a 0b
            hex 8f 10 b0 1a bc 29 39 3a ; 015F0:  8f 10 b0 1a bc 29 39 3a
            hex 8e 78 bc e9 34 d1 06 ac ; 015F8:  8e 78 bc e9 34 d1 06 ac
            hex 66 d7 0a 19 c0 d8 10 96 ; 01600:  66 d7 0a 19 c0 d8 10 96
            hex 62 e9 52 ca 02 50 c0 cf ; 01608:  62 e9 52 ca 02 50 c0 cf
            hex 0a 19 c2 cf 20 23 e8 00 ; 01610:  0a 19 c2 cf 20 23 e8 00
            hex 00 61 3d 3c e9 99 8e 06 ; 01618:  00 61 3d 3c e9 99 8e 06
            hex cf 20 23 e8 fb ff a4 ab ; 01620:  cf 20 23 e8 fb ff a4 ab
            hex 7b a8 5f 6f 89 1e a8 63 ; 01628:  7b a8 5f 6f 89 1e a8 63
            hex 6f 40 d6 59 96 3b e9 72 ; 01630:  6f 40 d6 59 96 3b e9 72
            hex d7 02 8b 18 c0 d8 57 96 ; 01638:  d7 02 8b 18 c0 d8 57 96
            hex 0b 8c a2 6d bb d3 d7 57 ; 01640:  0b 8c a2 6d bb d3 d7 57
            hex 96 0b 8c 15 6e bb b3 89 ; 01648:  96 0b 8c 15 6e bb b3 89
            hex 32 d4 3b e9 54 e5 02 0b ; 01650:  32 d4 3b e9 54 e5 02 0b
            hex d0 2b 0b a6 9d 6d c6 d7 ; 01658:  d0 2b 0b a6 9d 6d c6 d7
            hex 35 96 a4 5f 6f 8c f7 6c ; 01660:  35 96 a4 5f 6f 8c f7 6c
            hex bb b3 40 d4 a4 4d 6f 2a ; 01668:  bb b3 40 d4 a4 4d 6f 2a
            hex a5 a1 6d a2 fb ff 41 a8 ; 01670:  a5 a1 6d a2 fb ff 41 a8
            hex 4d 6f 44 cd a5 a1 6d db ; 01678:  4d 6f 44 cd a5 a1 6d db
            hex a9 a1 6d 8e ac bc e9 26 ; 01680:  a9 a1 6d 8e ac bc e9 26
            hex d3 02 8d 62 e9 3e d7 02 ; 01688:  d3 02 8d 62 e9 3e d7 02
            hex ac 89 cc 65 e9 0c e8 02 ; 01690:  ac 89 cc 65 e9 0c e8 02
            hex 0a a8 4d 6f a0 fb ff a9 ; 01698:  0a a8 4d 6f a0 fb ff a9
            hex a1 6d 40 a9 65 6f a4 81 ; 016A0:  a1 6d 40 a9 65 6f a4 81
            hex 6f a8 7f 6f             ; 016A8:  6f a8 7f 6f

            tay                         ; 016AC:  a8
            adc $cf6f,x                 ; 016AD:  7d 6f cf
            jsr $e823                   ; 016B0:  20 23 e8
            inc $ff,x                   ; 016B3:  f6 ff
            rti                         ; 016B5:  40

            hex 2a a4 9d 6d 8b 32 c0 d8 ; 016B6:  2a a4 9d 6d 8b 32 c0 d8
            hex 76 97 0c 8b 1e c0 d8 76 ; 016BE:  76 97 0c 8b 1e c0 d8 76
            hex 97 3c e9 72 d7 02 8b 18 ; 016C6:  97 3c e9 72 d7 02 8b 18
            hex c0 d8 76 97 8d 1e e9 da ; 016CE:  c0 d8 76 97 8d 1e e9 da
            hex d7 02 d3 8b 28 c5 d8 76 ; 016D6:  d7 02 d3 8b 28 c5 d8 76
            hex 97 a4 5f 6f 28 89 1e a8 ; 016DE:  97 a4 5f 6f 28 89 1e a8
            hex 5f 6f ac 1e 8c d8 6e 97 ; 016E6:  5f 6f ac 1e 8c d8 6e 97
            hex a5 a1 6d 52 da d7 6e 97 ; 016EE:  a5 a1 6d 52 da d7 6e 97
            hex ac d7 da 8e 4f 6f 61 e9 ; 016F6:  ac d7 da 8e 4f 6f 61 e9
            hex 3a dd 04 40 a8 81 6f 8a ; 016FE:  3a dd 04 40 a8 81 6f 8a
            hex 4f 6f d6 34 97 0b d3 a8 ; 01706:  4f 6f d6 34 97 0b d3 a8
            hex ab 7b 0b d3 8b 1a b5 8c ; 0170E:  ab 7b 0b d3 8b 1a b5 8c
            hex 11 70 bb b0 cd a4 81 6f ; 01716:  11 70 bb b0 cd a4 81 6f
            hex bb a8 81 6f a4 81 6f 8c ; 0171E:  bb a8 81 6f a4 81 6f 8c
            hex 0f 27 c4 d8 32 97 8a 0f ; 01726:  0f 27 c4 d8 32 97 8a 0f
            hex 27 a8 81 6f 0b d0 2b 0b ; 0172E:  27 a8 81 6f 0b d0 2b 0b
            hex d3 8c ff 00 c1 d7 0b 97 ; 01736:  d3 8c ff 00 c1 d7 0b 97
            hex a4 5f 6f 8b 1a b5 8c 11 ; 0173E:  a4 5f 6f 8b 1a b5 8c 11
            hex 70 bb b0 b3 a4 81 6f b4 ; 01746:  70 bb b0 b3 a4 81 6f b4
            hex c4 d8 6e 97 61 e9 10 e5 ; 0174E:  c4 d8 6e 97 61 e9 10 e5
            hex 02 53 c9 d8 6e 97 42 cd ; 01756:  02 53 c9 d8 6e 97 42 cd
            hex a5 a1 6d db a9 a1 6d ac ; 0175E:  a5 a1 6d db a9 a1 6d ac
            hex 21 96 41 a8 48 6e 41 2a ; 01766:  21 96 41 a8 48 6e 41 2a
            hex 0a d7 76 97 08 a8 5f 6f ; 0176E:  0a d7 76 97 08 a8 5f 6f
            hex 0a cf 20 23 e8 f2 ff 40 ; 01776:  0a cf 20 23 e8 f2 ff 40
            hex 27 8a ad 7b d6 6e 98 0b ; 0177E:  27 8a ad 7b d6 6e 98 0b
            hex d3 b3 e9 b0 96 02 d7 78 ; 01786:  d3 b3 e9 b0 96 02 d7 78
            hex 98 0b d3 a8 5f 6f 8d 1e ; 0178E:  98 0b d3 a8 5f 6f 8d 1e
            hex e9 03 ca 02 ac 1e 8c d8 ; 01796:  e9 03 ca 02 ac 1e 8c d8
            hex af 97 07 d0 27 d1 b3 0b ; 0179E:  af 97 07 d0 27 d1 b3 0b
            hex d3 b3 e9 14 96 04 d6 6c ; 017A6:  d3 b3 e9 14 96 04 d6 6c
            hex 98 0b d3 b3 e9 95 95 02 ; 017AE:  98 0b d3 b3 e9 95 95 02
            hex d8 19 98 8e f1 bc e9 26 ; 017B6:  d8 19 98 8e f1 bc e9 26
            hex d3 02 ac 66 d7 0b d3 8c ; 017BE:  d3 02 ac 66 d7 0b d3 8c
            hex 15 6e bb 2a 0b d3 8c a2 ; 017C6:  15 6e bb 2a 0b d3 8c a2
            hex 6d bb d3 d8 fc 97 0b d3 ; 017CE:  6d bb d3 d8 fc 97 0b d3
            hex b3 e9 75 e2 02 0a d3 b3 ; 017D6:  b3 e9 75 e2 02 0a d3 b3
            hex e9 0e dc 02 0a d3 b3 e9 ; 017DE:  e9 0e dc 02 0a d3 b3 e9
            hex 3c dc 02 0b d3 8c a2 6d ; 017E6:  3c dc 02 0b d3 8c a2 6d
            hex bb b3 40 d4 0b d3 b3 e9 ; 017EE:  bb b3 40 d4 0b d3 b3 e9
            hex 25 e4 02 d6 06 98 0b d3 ; 017F6:  25 e4 02 d6 06 98 0b d3
            hex 8c 7f 6e bb b3 0a d3 d4 ; 017FE:  8c 7f 6e bb b3 0a d3 d4
            hex 0b d3 b3 e9 1b e2 02 0b ; 01806:  0b d3 b3 e9 1b e2 02 0b
            hex d3 8c f7 6c bb b3 40 d4 ; 0180E:  d3 8c f7 6c bb b3 40 d4
            hex d6 69 98 8e 06 bd e9 26 ; 01816:  d6 69 98 8e 06 bd e9 26
            hex d3 02 0b d3 8b 1a b5 8c ; 0181E:  d3 02 0b d3 8b 1a b5 8c
            hex 01 70 bb 25 8d 1e e9 52 ; 01826:  01 70 bb 25 8d 1e e9 52
            hex ca 02 b3 6a e9 52 ca 02 ; 0182E:  ca 02 b3 6a e9 52 ca 02
            hex 8f 1e b3 05 8f 12 b0 b3 ; 01836:  8f 1e b3 05 8f 12 b0 b3
            hex e9 0d d7 04 b4 bb 8f 1e ; 0183E:  e9 0d d7 04 b4 bb 8f 1e
            hex b3 05 8f 12 b4 b3 b0 bb ; 01846:  b3 05 8f 12 b4 b3 b0 bb
            hex b1 8d 14 e9 52 ca 02 7a ; 0184E:  b1 8d 14 e9 52 ca 02 7a
            hex b3 05 8f 10 b0 b3 e9 0d ; 01856:  b3 05 8f 10 b0 b3 e9 0d
            hex d7 04 b3 05 8f 10 b4 b3 ; 0185E:  d7 04 b3 05 8f 10 b4 b3
            hex b0 bc b1 ac 66 d7 0b d0 ; 01866:  b0 bc b1 ac 66 d7 0b d0
            hex 2b 0b d3 8c ff 00 c1 d7 ; 0186E:  2b 0b d3 8c ff 00 c1 d7
            hex 85 97 cf 20 23 e8 fe ff ; 01876:  85 97 cf 20 23 e8 fe ff
            hex 8a 89 6f d6 98 98 a0 0b ; 0187E:  8a 89 6f d6 98 98 a0 0b
            hex 00 b3 0b d3 b4 c0 d8 96 ; 01886:  00 b3 0b d3 b4 c0 d8 96
            hex 98 3b 89 c8 d4 d6 a2 98 ; 0188E:  98 3b 89 c8 d4 d6 a2 98
            hex 0b d0 2b 0b d3 8c ff 00 ; 01896:  0b d0 2b 0b d3 8c ff 00
            hex c1 d7 84 98 cf 20 23 e8 ; 0189E:  c1 d7 84 98 cf 20 23 e8
            hex fe ff 0f 8c 15 6e bb b3 ; 018A6:  fe ff 0f 8c 15 6e bb b3
            hex 0c d4 0f 8c a2 6d bb b3 ; 018AE:  0c d4 0f 8c a2 6d bb b3
            hex 0d d4 0f 8c f7 6c bb b3 ; 018B6:  0d d4 0f 8c f7 6c bb b3
            hex 0e d4 3f e9 54 e5 02 cf ; 018BE:  0e d4 3f e9 54 e5 02 cf
            hex 20 23 e8 c6 ff ac d7 da ; 018C6:  20 23 e8 c6 ff ac d7 da
            hex 8e 4f 6f 61 e9 3a dd 04 ; 018CE:  8e 4f 6f 61 e9 3a dd 04
            hex de ca ff 2a 8a 4f 6f 2b ; 018D6:  de ca ff 2a 8a 4f 6f 2b
            hex 40 85 c8 d6 06 99 0b d3 ; 018DE:  40 85 c8 d6 06 99 0b d3
            hex 8c ff 00 c0 d7 0d 99 0a ; 018E6:  8c ff 00 c0 d7 0d 99 0a
            hex d0 2a d1 b3 0b d3 d4 0b ; 018EE:  d0 2a d1 b3 0b d3 d4 0b
            hex d3 b3 e9 79 98 02 0b d0 ; 018F6:  d3 b3 e9 79 98 02 0b d0
            hex 2b d1 81 c8 d0 85 c8 d1 ; 018FE:  2b d1 81 c8 d0 85 c8 d1
            hex 81 c8 1c c6 d7 e4 98 81 ; 01906:  81 c8 1c c6 d7 e4 98 81
            hex c8 1c c6 d8 4b 99 0c 83 ; 0190E:  c8 1c c6 d8 4b 99 0c 83
            hex c8 bc d6 2a 99 0a d0 2a ; 01916:  c8 bc d6 2a 99 0a d0 2a
            hex d1 b3 0d d3 d4 3d 89 c8 ; 0191E:  d1 b3 0d d3 d4 3d 89 c8
            hex d4 81 c6 d1 85 c6 d6 44 ; 01926:  d4 81 c6 d1 85 c6 d6 44
            hex 99 0d d3 8c c8 00 c1 d7 ; 0192E:  99 0d d3 8c c8 00 c1 d7
            hex 1b 99 0d d0 2d 0d d3 8c ; 01936:  1b 99 0d d0 2d 0d d3 8c
            hex ff 00 c1 d7 2f 99 81 c6 ; 0193E:  ff 00 c1 d7 2f 99 81 c6
            hex 50 c8 d7 3b 99 3a 89 ff ; 01946:  50 c8 d7 3b 99 3a 89 ff
            hex d4 de ca ff d6 69 99 0a ; 0194E:  d4 de ca ff d6 69 99 0a
            hex d3 b3 0a d3 8c f7 6c bb ; 01956:  d3 b3 0a d3 8c f7 6c bb
            hex d3 b3 60 8d 33 e9 a3 98 ; 0195E:  d3 b3 60 8d 33 e9 a3 98
            hex 08 0a d0 2a 0a d3 8c ff ; 01966:  08 0a d0 2a 0a d3 8c ff
            hex 00 c1 d7 55 99 cf 20 23 ; 0196E:  00 c1 d7 55 99 cf 20 23
            hex e8 fe ff 41 2b d6 a6 99 ; 01976:  e8 fe ff 41 2b d6 a6 99
            hex 0d d3 8c ff 00 c0 d7 aa ; 0197E:  0d d3 8c ff 00 c0 d7 aa
            hex 99 0d d3 8c c8 00 c1 d8 ; 01986:  99 0d d3 8c c8 00 c1 d8
            hex a3 99 0d d3 b3 60 3b 3e ; 0198E:  a3 99 0d d3 b3 60 3b 3e
            hex e9 a3 98 08 3d 89 c8 d4 ; 01996:  e9 a3 98 08 3d 89 c8 d4
            hex 40 2b 0c d1 2c 0d d0 2d ; 0199E:  40 2b 0c d1 2c 0d d0 2d
            hex 0c d7 7e 99 cf 20 23 e8 ; 019A6:  0c d7 7e 99 cf 20 23 e8
            hex f8 ff ac 20 cd 61 e9 35 ; 019AE:  f8 ff ac 20 cd 61 e9 35
            hex cc 02 a4 57 6f a6 5f 6f ; 019B6:  cc 02 a4 57 6f a6 5f 6f
            hex c0 d8 04 9a a4 5f 6f 8c ; 019BE:  c0 d8 04 9a a4 5f 6f 8c
            hex f7 6c bb b3 45 d4 65 62 ; 019C6:  f7 6c bb b3 45 d4 65 62
            hex e9 7b cc 04 8e 1e bd e9 ; 019CE:  e9 7b cc 04 8e 1e bd e9
            hex c4 ce 02 40 d6 f8 99 3b ; 019D6:  c4 ce 02 40 d6 f8 99 3b
            hex e9 72 d7 02 8b 32 c0 d8 ; 019DE:  e9 72 d7 02 8b 32 c0 d8
            hex f6 99 0b 8c 15 6e bb b3 ; 019E6:  f6 99 0b 8c 15 6e bb b3
            hex 89 18 d4 3b e9 54 e5 02 ; 019EE:  89 18 d4 3b e9 54 e5 02
            hex 0b d0 2b 0b a6 9d 6d c6 ; 019F6:  0b d0 2b 0b a6 9d 6d c6
            hex d7 dd 99 d6 9e 9a a4 5f ; 019FE:  d7 dd 99 d6 9e 9a a4 5f
            hex 6f 8c f7 6c bb b3 45 d4 ; 01A06:  6f 8c f7 6c bb b3 45 d4
            hex 89 1e a8 5f 6f 61 e9 10 ; 01A0E:  89 1e a8 5f 6f 61 e9 10
            hex e5 02 d0 2a 0a 53 b8 2b ; 01A16:  e5 02 d0 2a 0a 53 b8 2b
            hex 8e 89 6f 0b d1 b3 e9 c6 ; 01A1E:  8e 89 6f 0b d1 b3 e9 c6
            hex 98 04 8d 34 8e 89 6f 3b ; 01A26:  98 04 8d 34 8e 89 6f 3b
            hex e9 74 99 06 8d 32 8e 89 ; 01A2E:  e9 74 99 06 8d 32 8e 89
            hex 6f 0b d2 b3 0a b4 bc b3 ; 01A36:  6f 0b d2 b3 0a b4 bc b3
            hex e9 74 99 06 89 33 a9 33 ; 01A3E:  e9 74 99 06 89 33 a9 33
            hex 6e 41 a9 c0 6d 45 a9 15 ; 01A46:  6e 41 a9 c0 6d 45 a9 15
            hex 6d 8d 1e e9 54          ; 01A4E:  6d 8d 1e e9 54

            sbc ptr1_lo                     ; 01A53:  e5 02
            rti                         ; 01A55:  40

            hex 28 08 8c d5 7f bb d3 8b ; 01A56:  28 08 8c d5 7f bb d3 8b

            clc                         ; 01A5E:  18
            cpy #$d8                    ; 01A5F:  c0 d8
            jmp ($089a)                 ; 01A61:  6c 9a 08

            hex 8c d5 7f bb b3 89 33 d4 ; 01A64:  8c d5 7f bb b3 89 33 d4
            hex 08 d0 28 08 58 c6 d7 57 ; 01A6C:  08 d0 28 08 58 c6 d7 57

            txs                         ; 01A74:  9a
            adc $62                     ; 01A75:  65 62
            sbc #$7b                    ; 01A77:  e9 7b
            cpy tab_b0_8df6+14          ; 01A79:  cc 04 8e
            lsr $bd,x                   ; 01A7C:  56 bd
            sbc #$c4                    ; 01A7E:  e9 c4
            dec $8e02                   ; 01A80:  ce 02 8e
            rts                         ; 01A83:  60

tab_b0_9a84: ; 940 bytes
            hex bd e9 c4 ce 02 8e 88 bd ; 01A84:  bd e9 c4 ce 02 8e 88 bd
            hex e9 c4 ce 02 8e 9c bd e9 ; 01A8C:  e9 c4 ce 02 8e 9c bd e9
            hex c4 ce 02 8e d8 bd e9 c4 ; 01A94:  c4 ce 02 8e d8 bd e9 c4
            hex ce 02 60 e9 35 cc 02 ac ; 01A9C:  ce 02 60 e9 35 cc 02 ac
            hex 09 d6 66 e9 f2 e5 02 cf ; 01AA4:  09 d6 66 e9 f2 e5 02 cf
            hex 20 23 e8 fe ff ac a4 e3 ; 01AAC:  20 23 e8 fe ff ac a4 e3
            hex 2b d8 11 9b ac 89 cc aa ; 01AB4:  2b d8 11 9b ac 89 cc aa
            hex 5f 6f e9 8b d7 02 3b a4 ; 01ABC:  5f 6f e9 8b d7 02 3b a4
            hex 63 6f d0 b3 8e fe bd e9 ; 01AC4:  63 6f d0 b3 8e fe bd e9
            hex 34 d1 06 ac a7 d3 d8 07 ; 01ACC:  34 d1 06 ac a7 d3 d8 07
            hex 9b 67 e9 0c e8 02 3b a4 ; 01AD4:  9b 67 e9 0c e8 02 3b a4
            hex 5f 6f 8b 1a b5 8c 01 70 ; 01ADC:  5f 6f 8b 1a b5 8c 01 70
            hex bb b4 b3 b0 bb b1 8e 31 ; 01AE4:  bb b4 b3 b0 bb b1 8e 31
            hex be e9 26 d3 02 ac 4f da ; 01AEC:  be e9 26 d3 02 ac 4f da
            hex 3b a4 63 6f 8b 1a b5 8c ; 01AF4:  3b a4 63 6f 8b 1a b5 8c
            hex 01 70 bb b4 b3 b0 bc b1 ; 01AFC:  01 70 bb b4 b3 b0 bc b1
            hex d6 0e 9b 8e 57 be e9 26 ; 01B04:  d6 0e 9b 8e 57 be e9 26
            hex d3 02 ac 66 d7 cf 20 23 ; 01B0C:  d3 02 ac 66 d7 cf 20 23
            hex e8 fe ff 40 d6 71 9b a4 ; 01B14:  e8 fe ff 40 d6 71 9b a4
            hex 5f 6f 8c a2 6d bb d3 d8 ; 01B1C:  5f 6f 8c a2 6d bb d3 d8
            hex 6d 9b aa 5f 6f e9 8d d9 ; 01B24:  6d 9b aa 5f 6f e9 8d d9
            hex 02 d7 6d 9b ac d7 da 8a ; 01B2C:  02 d7 6d 9b ac d7 da 8a
            hex 4f 6f d6 63 9b a4 5f 6f ; 01B34:  4f 6f d6 63 9b a4 5f 6f
            hex a8 63 6f 0b d3 a8 5f 6f ; 01B3C:  a8 63 6f 0b d3 a8 5f 6f
            hex ac 1e 8c d8 5b 9b ac 7e ; 01B44:  ac 1e 8c d8 5b 9b ac 7e
            hex d7 8c 67 6d bb d3 d7 5b ; 01B4C:  d7 8c 67 6d bb d3 d7 5b
            hex 9b ac ac 9a d6 7e 9b a4 ; 01B54:  9b ac ac 9a d6 7e 9b a4
            hex 63 6f a8 5f 6f 0b d0 2b ; 01B5C:  63 6f a8 5f 6f 0b d0 2b
            hex 0b d3 8c ff 00 c1 d7 39 ; 01B64:  0b d3 8c ff 00 c1 d7 39
            hex 9b a4 5f 6f d0 a8 5f 6f ; 01B6C:  9b a4 5f 6f d0 a8 5f 6f
            hex a4 5f 6f a6 9d 6d c6 d7 ; 01B74:  a4 5f 6f a6 9d 6d c6 d7
            hex 1b 9b cf 20 23 e8 fe ff ; 01B7C:  1b 9b cf 20 23 e8 fe ff
            hex ac 15 e3 2b d8 e4 9b ac ; 01B84:  ac 15 e3 2b d8 e4 9b ac
            hex 89 cc aa 5f 6f e9 8b d7 ; 01B8C:  89 cc aa 5f 6f e9 8b d7
            hex 02 a4 63 6f d0 b3 3b 8e ; 01B94:  02 a4 63 6f d0 b3 3b 8e
            hex 78 be e9 34 d1 06 ac a7 ; 01B9C:  78 be e9 34 d1 06 ac a7
            hex d3 d8 da 9b 64 e9 0c e8 ; 01BA4:  d3 d8 da 9b 64 e9 0c e8
            hex 02 3b a4 5f 6f 8b 1a b5 ; 01BAC:  02 3b a4 5f 6f 8b 1a b5
            hex 8c 01 70 bb b4 b3 b0 bb ; 01BB4:  8c 01 70 bb b4 b3 b0 bb
            hex b1 8e ba be e9 26 d3 02 ; 01BBC:  b1 8e ba be e9 26 d3 02
            hex ac 7d da 3b a4 63 6f 8b ; 01BC4:  ac 7d da 3b a4 63 6f 8b
            hex 1a b5 8c 01 70 bb b4 b3 ; 01BCC:  1a b5 8c 01 70 bb b4 b3
            hex b0 bc b1 d6 e1 9b 8e e9 ; 01BD4:  b0 bc b1 d6 e1 9b 8e e9
            hex be e9 26 d3 02 ac 66 d7 ; 01BDC:  be e9 26 d3 02 ac 66 d7
            hex cf 20 23 e8 fc ff 40 d6 ; 01BE4:  cf 20 23 e8 fc ff 40 d6
            hex 18 9c aa 9d 6d e9 52 ca ; 01BEC:  18 9c aa 9d 6d e9 52 ca
            hex 02 2a 3a e9 8d d9 02 d7 ; 01BF4:  02 2a 3a e9 8d d9 02 d7
            hex 16 9c ac 45 8c ac 7e d7 ; 01BFC:  16 9c ac 45 8c ac 7e d7
            hex 8c 67 6d bb d3 d7 16 9c ; 01C04:  8c 67 6d bb d3 d7 16 9c
            hex 0a a8 63 6f ac 7f 9b d6 ; 01C0C:  0a a8 63 6f ac 7f 9b d6
            hex 21 9c 0b d0 2b 0b a6 9d ; 01C14:  21 9c 0b d0 2b 0b a6 9d
            hex 6d c6 d7 ee 9b cf 20 23 ; 01C1C:  6d c6 d7 ee 9b cf 20 23
            hex e8 fc ff 40 2a 62 e9 52 ; 01C24:  e8 fc ff 40 2a 62 e9 52
            hex ca 02 d8 83 9c 40 d6 7a ; 01C2C:  ca 02 d8 83 9c 40 d6 7a
            hex 9c 8d 14 e9 52 ca 02 53 ; 01C34:  9c 8d 14 e9 52 ca 02 53
            hex c2 d8 78 9c 3b e9 8d d9 ; 01C3C:  c2 d8 78 9c 3b e9 8d d9
            hex 02 d7 78 9c 48 a6 09 6e ; 01C44:  02 d7 78 9c 48 a6 09 6e
            hex bc b3 0a d0 2a d1 b4 c6 ; 01C4C:  bc b3 0a d0 2a d1 b4 c6
            hex d8 78 9c ac 45 8c 0b a8 ; 01C54:  d8 78 9c ac 45 8c 0b a8
            hex 63 6f 8e 5f 6f 8e 63 6f ; 01C5C:  63 6f 8e 5f 6f 8e 63 6f
            hex e9 94 cb 04 ac bf 93 8e ; 01C64:  e9 94 cb 04 ac bf 93 8e
            hex 5f 6f 8e 63 6f e9 94 cb ; 01C6C:  5f 6f 8e 63 6f e9 94 cb
            hex 04 d6 83 9c 0b d0 2b 0b ; 01C74:  04 d6 83 9c 0b d0 2b 0b
            hex a6 9d 6d c6 d7 35 9c cf ; 01C7C:  a6 9d 6d c6 d7 35 9c cf
            hex 20 23 e8 00 00 62 e9 52 ; 01C84:  20 23 e8 00 00 62 e9 52
            hex ca 02 d8 a6 9c 64 e9 52 ; 01C8C:  ca 02 d8 a6 9c 64 e9 52
            hex ca 02 d9 02 00 00 00 a3 ; 01C94:  ca 02 d9 02 00 00 00 a3
            hex 9c 01 00 a7 9c ad 9c ac ; 01C9C:  9c 01 00 a7 9c ad 9c ac
            hex e5 9b cf ac 12 9b d6 a6 ; 01CA4:  e5 9b cf ac 12 9b d6 a6
            hex 9c ac 22 9c d6 a6 9c 20 ; 01CAC:  9c ac 22 9c d6 a6 9c 20
            hex 23 e8 fc ff 8d 14 e9 0c ; 01CB4:  23 e8 fc ff 8d 14 e9 0c
            hex e8 02 8a ad 7b d6 f5 9c ; 01CBC:  e8 02 8a ad 7b d6 f5 9c
            hex 0b d3 8b 1a b5 8c 01 70 ; 01CC4:  0b d3 8b 1a b5 8c 01 70
            hex bb 2a 64 e9 52 ca 02 d0 ; 01CCC:  bb 2a 64 e9 52 ca 02 d0
            hex b3 0a 7e b4 b3 b0 bc b1 ; 01CD4:  b3 0a 7e b4 b3 b0 bc b1
            hex 0a 78 b3 8d 5a 0a 7a b0 ; 01CDC:  0a 78 b3 8d 5a 0a 7a b0
            hex b3 e9 0d d7 04 b3 0a 78 ; 01CE4:  b3 e9 0d d7 04 b3 0a 78
            hex b0 b3 e9 0d d7 04 b1 0b ; 01CEC:  b0 b3 e9 0d d7 04 b1 0b
            hex d0 2b 0b d3 8c ff 00 c1 ; 01CF4:  d0 2b 0b d3 8c ff 00 c1
            hex d7 c4 9c cf 20 23 e8 fa ; 01CFC:  d7 c4 9c cf 20 23 e8 fa
            hex ff 8d 1f e9 0c e8 02 8a ; 01D04:  ff 8d 1f e9 0c e8 02 8a
            hex ad 7b d6 7b 9d 0b d3 8b ; 01D0C:  ad 7b d6 7b 9d 0b d3 8b
            hex 1a b5 8c 01 70 bb 2a 0a ; 01D14:  1a b5 8c 01 70 bb 2a 0a
            hex 8f 10 b3 8d 32 e9 52 ca ; 01D1C:  8f 10 b3 8d 32 e9 52 ca
            hex 02 8f 32 b3 0a 8f 10 b0 ; 01D24:  02 8f 32 b3 0a 8f 10 b0
            hex b3 e9 0d d7 04 b1 0a 78 ; 01D2C:  b3 e9 0d d7 04 b1 0a 78
            hex b3 8d 32 e9 52 ca 02 8f ; 01D34:  b3 8d 32 e9 52 ca 02 8f
            hex 32 b3 0a 78 b0 b3 e9 0d ; 01D3C:  32 b3 0a 78 b0 b3 e9 0d
            hex d7 04 b1 0b d3 8c a2 6d ; 01D44:  d7 04 b1 0b d3 8c a2 6d
            hex bb d3 d8 79 9d 69 e9 52 ; 01D4C:  bb d3 d8 79 9d 69 e9 52
            hex ca 02 d0 b3 0b d3 b3 e9 ; 01D54:  ca 02 d0 b3 0b d3 b3 e9
            hex da d7 02 29 d0 b3 e9 12 ; 01D5C:  da d7 02 29 d0 b3 e9 12
            hex ca 04 0b d3 b3 e9 72 d7 ; 01D64:  ca 04 0b d3 b3 e9 72 d7
            hex 02 8c d4 6d bb b3 09 d0 ; 01D6C:  02 8c d4 6d bb b3 09 d0
            hex d3 8b 32 c3 d4 0b d0 2b ; 01D74:  d3 8b 32 c3 d4 0b d0 2b
            hex 0b d3 8c ff 00 c1 d7 11 ; 01D7C:  0b d3 8c ff 00 c1 d7 11
            hex 9d cf 20 23 e8 00 00 0c ; 01D84:  9d cf 20 23 e8 00 00 0c
            hex 8b 32 c4 d8 95 9d 89 32 ; 01D8C:  8b 32 c4 d8 95 9d 89 32
            hex 2c 8e e9 07 e9 52 ca 02 ; 01D94:  2c 8e e9 07 e9 52 ca 02
            hex b3 0c 1c b5 b4 c2 cf 20 ; 01D9C:  b3 0c 1c b5 b4 c2 cf 20
            hex 23 e8 00 00 0c a8 63 6f ; 01DA4:  23 e8 00 00 0c a8 63 6f
            hex 0c 8b 1a b5 8c 0d 70 bb ; 01DAC:  0c 8b 1a b5 8c 0d 70 bb
            hex b0 b3 e9 86 9d 02 d7 e9 ; 01DB4:  b0 b3 e9 86 9d 02 d7 e9
            hex 9d 0c 8c 2d 6d bb d3 b3 ; 01DBC:  9d 0c 8c 2d 6d bb d3 b3
            hex 89 64 b4 bc b3 e9 86 9d ; 01DC4:  89 64 b4 bc b3 e9 86 9d
            hex 02 d7 e9 9d 3c e9 da d7 ; 01DCC:  02 d7 e9 9d 3c e9 da d7
            hex 02 74 d3 b3 e9 86 9d 02 ; 01DD4:  02 74 d3 b3 e9 86 9d 02
            hex d7 e9 9d 8e e8 03 e9 52 ; 01DDC:  d7 e9 9d 8e e8 03 e9 52
            hex ca 02 d7 1b 9e 0c 8b 1a ; 01DE4:  ca 02 d7 1b 9e 0c 8b 1a
            hex b5 8c 09 70 bb b0 50 c4 ; 01DEC:  b5 8c 09 70 bb b0 50 c4
            hex d8 1b 9e 0c 8b 1a b5 8c ; 01DF4:  d8 1b 9e 0c 8b 1a b5 8c
            hex 11 70 bb b0 52 c4 d8 1b ; 01DFC:  11 70 bb b0 52 c4 d8 1b
            hex 9e ac 12 db d7 1b 9e 3c ; 01E04:  9e ac 12 db d7 1b 9e 3c
            hex e9 99 d9 02 d7 1b 9e 64 ; 01E0C:  e9 99 d9 02 d7 1b 9e 64
            hex e9 52 ca 02 d8 1f 9e 40 ; 01E14:  e9 52 ca 02 d8 1f 9e 40
            hex d6 20 9e 41 cf 20 23 e8 ; 01E1C:  d6 20 9e 41 cf 20 23 e8
            hex 00 00 0c a8 63 6f 0c 8b ; 01E24:  00 00 0c a8 63 6f 0c 8b
            hex 1a b5 8c 13             ; 01E2C:  1a b5 8c 13

            bvs tab_b0_9a84+873         ; 01E30:  70 bb
            bcs tab_b0_9a84+867         ; 01E32:  b0 b3
            sbc #$86                    ; 01E34:  e9 86
            sta $d702,x                 ; 01E36:  9d 02 d7
            rts                         ; 01E39:  60

            hex 9e 3c e9 da d7 02 74 d3 ; 01E3A:  9e 3c e9 da d7 02 74 d3
            hex b3                      ; 01E42:  b3

            sbc #$86                    ; 01E43:  e9 86
            sta $d702,x                 ; 01E45:  9d 02 d7
            rts                         ; 01E48:  60

            hex 9e ac 12 db d8 55 9e 89 ; 01E49:  9e ac 12 db d8 55 9e 89
            hex 14 d6 58 9e 8a e8 03 b3 ; 01E51:  14 d6 58 9e 8a e8 03 b3
            hex e9 52 ca 02 d7 76 9e 0c ; 01E59:  e9 52 ca 02 d7 76 9e 0c
            hex 8b 1a b5 8c 11 70 bb b0 ; 01E61:  8b 1a b5 8c 11 70 bb b0
            hex 52 c4 d8 76 9e 3c e9 99 ; 01E69:  52 c4 d8 76 9e 3c e9 99
            hex d9 02 d8 7a 9e 40 d6 7b ; 01E71:  d9 02 d8 7a 9e 40 d6 7b
            hex 9e 41 cf 20 23 e8 00 00 ; 01E79:  9e 41 cf 20 23 e8 00 00
            hex 3d e9 99 d9 02 d8 8b 9e ; 01E81:  3d e9 99 d9 02 d8 8b 9e
            hex 40 cf 0c 51 c0 d8 97 9e ; 01E89:  40 cf 0c 51 c0 d8 97 9e
            hex 3d e9 a3 9d 02 cf 3d e9 ; 01E91:  3d e9 a3 9d 02 cf 3d e9
            hex 21 9e 02 cf 20 23 e8 fa ; 01E99:  21 9e 02 cf 20 23 e8 fa
            hex ff 40                   ; 01EA1:  ff 40

            and #$8a                    ; 01EA3:  29 8a
            lda $2b7b                   ; 01EA5:  ad 7b 2b
            rti                         ; 01EA8:  40

            hex d6 ca 9e 0a 8c 1b 6f bb ; 01EA9:  d6 ca 9e 0a 8c 1b 6f bb
            hex d3 b3 3c e9 7c 9e 04 d8 ; 01EB1:  d3 b3 3c e9 7c 9e 04 d8
            hex c8 9e 3b 0a 8c 1b 6f bb ; 01EB9:  c8 9e 3b 0a 8c 1b 6f bb
            hex d3 d4 0b d0 2b 41 29 0a ; 01EC1:  d3 d4 0b d0 2b 41 29 0a
            hex d0 2a 0a a6 9d 6d c6 d7 ; 01EC9:  d0 2a 0a a6 9d 6d c6 d7
            hex ac 9e 3b 89 ff d4 09 cf ; 01ED1:  ac 9e 3b 89 ff d4 09 cf
            hex 20 23 e8 fa ff 41 2b 62 ; 01ED9:  20 23 e8 fa ff 41 2b 62
            hex e9 52 ca 02             ; 01EE1:  e9 52 ca 02

            rol a                       ; 01EE5:  2a
            rti                         ; 01EE6:  40

tab_b0_9ee7: ; 186 bytes
            hex d6 00 9f 0a d0 b3 e9 9d ; 01EE7:  d6 00 9f 0a d0 b3 e9 9d
            hex 9e 02 d8 f9 9e 40 2b d6 ; 01EEF:  9e 02 d8 f9 9e 40 2b d6
            hex 07 9f 41 cd 0a dc 2a 09 ; 01EF7:  07 9f 41 cd 0a dc 2a 09
            hex d0 29 09 52 c6 d7 ea 9e ; 01EFF:  d0 29 09 52 c6 d7 ea 9e
            hex 0b 51 c0 d8 11 9f ac 84 ; 01F07:  0b 51 c0 d8 11 9f ac 84
            hex 9c cf 0a d9 02 00 00 00 ; 01F0F:  9c cf 0a d9 02 00 00 00
            hex 1f 9f 01 00 3b 9f 10 9f ; 01F17:  1f 9f 01 00 3b 9f 10 9f
            hex 8d 1e e9 03 ca 02 8e 0b ; 01F1F:  8d 1e e9 03 ca 02 8e 0b
            hex bf e9 26 d3 02 ac 66 d7 ; 01F27:  bf e9 26 d3 02 ac 66 d7
            hex 8d 17 e9 0c e8 02 ac f8 ; 01F2F:  8d 17 e9 0c e8 02 ac f8
            hex 8f d6 10 9f 8d 1e e9 03 ; 01F37:  8f d6 10 9f 8d 1e e9 03
            hex ca 02 8e 10 bf e9 26 d3 ; 01F3F:  ca 02 8e 10 bf e9 26 d3
            hex 02 ac 66 d7 8d 19 e9 0c ; 01F47:  02 ac 66 d7 8d 19 e9 0c
            hex e8 02 ac 78 97 d6 10 9f ; 01F4F:  e8 02 ac 78 97 d6 10 9f
            hex 20 23 e8 fe ff 3c e9 6d ; 01F57:  20 23 e8 fe ff 3c e9 6d
            hex 94 02 5a b6 2b 62 e9 52 ; 01F5F:  94 02 5a b6 2b 62 e9 52
            hex ca 02 d8 8b 9f 6a e9 52 ; 01F67:  ca 02 d8 8b 9f 6a e9 52
            hex ca 02 1b bb b3 0d 7e b4 ; 01F6F:  ca 02 1b bb b3 0d 7e b4
            hex b3 b0 bb b1 8d 28 e9 52 ; 01F77:  b3 b0 bb b1 8d 28 e9 52
            hex ca 02 1b bb b3 0d 7c b4 ; 01F7F:  ca 02 1b bb b3 0d 7c b4
            hex b3 b0 bb b1 cf 20 23 e8 ; 01F87:  b3 b0 bb b1 cf 20 23 e8
            hex f8 ff a4 9f 6d 8c 18 06 ; 01F8F:  f8 ff a4 9f 6d 8c 18 06
            hex c1 d8 37 a0 64 e9 e8 90 ; 01F97:  c1 d8 37 a0 64 e9 e8 90
            hex 02 62                   ; 01F9F:  02 62

            sbc #$1e                    ; 01FA1:  e9 1e
            sta (ptr1_lo),y                 ; 01FA3:  91 02
            rti                         ; 01FA5:  40

            hex 2b 60 e9 cd d7 02 29 d6 ; 01FA6:  2b 60 e9 cd d7 02 29 d6
            hex c4 9f 09 b3 d3 d0 d4 09 ; 01FAE:  c4 9f 09 b3 d3 d0 d4 09
            hex d0 b3 d3 d1 d4 0b d0 2b ; 01FB6:  d0 b3 d3 d1 d4 0b d0 2b
            hex d1 09 77 29 8f f9 a4 9d ; 01FBE:  d1 09 77 29 8f f9 a4 9d
            hex 6d 73 b3 0b b4 c6 d7    ; 01FC6:  6d 73 b3 0b b4 c6 d7

            bcs tab_b0_9ee7+135         ; 01FCD:  b0 9f
            rti                         ; 01FCF:  40

            hex d6 2b a0 3b e9 8d d9 02 ; 01FD0:  d6 2b a0 3b e9 8d d9 02
            hex d7 e9 9f 0b 8b 1a b5 8c ; 01FD8:  d7 e9 9f 0b 8b 1a b5 8c
            hex 01 70 bb b3 3b e9 57 9f ; 01FE0:  01 70 bb b3 3b e9 57 9f
            hex 04 0b 8b 1a b5 8c 0d 70 ; 01FE8:  04 0b 8b 1a b5 8c 0d 70
            hex bb 2a 3b e9 8d d9 02 d8 ; 01FF0:  bb 2a 3b e9 8d d9 02 d8
            hex 29 a0 a4 63 6d 51 c1 d8 ; 01FF8:  29 a0 a4 63 6d 51 c1 d8
            hex 29 a0 aa 63 6d e9 52 ca ; 02000:  29 a0 aa 63 6d e9 52 ca
            hex 02 28 38 0a 72 2a 8f fe ; 02008:  02 28 38 0a 72 2a 8f fe
            hex b4 b3 b0 bc b1 38 0a 72 ; 02010:  b4 b3 b0 bc b1 38 0a 72
            hex 2a 8f fe b4 b3 b0 bc b1 ; 02018:  2a 8f fe b4 b3 b0 bc b1
            hex 38 0a 72 2a b4 b3 b0 bc ; 02020:  38 0a 72 2a b4 b3 b0 bc
            hex b1 0b d0 2b 0b a6 9d 6d ; 02028:  b1 0b d0 2b 0b a6 9d 6d
            hex c6 d7 d3 9f d6 65 a0 8d ; 02030:  c6 d7 d3 9f d6 65 a0 8d
            hex 18 e9 8d d9 02 d8 4e a0 ; 02038:  18 e9 8d d9 02 d8 4e a0
            hex a4 9d 6d 8b 32 c0 d8 4e ; 02040:  a4 9d 6d 8b 32 c0 d8 4e
            hex a0 89 64 a8 71 72 8d 10 ; 02048:  a0 89 64 a8 71 72 8d 10
            hex e9 8d d9 02 d8 65 a0 a4 ; 02050:  e9 8d d9 02 d8 65 a0 a4
            hex 9d 6d 8b 11 c0 d8 65 a0 ; 02058:  9d 6d 8b 11 c0 d8 65 a0
            hex 89 64 a8 a1 71 cf 20 23 ; 02060:  89 64 a8 a1 71 cf 20 23
            hex e8 f8 ff 62             ; 02068:  e8 f8 ff 62

            sbc #$e8                    ; 0206C:  e9 e8
            bcc tab_b0_a071+1           ; 0206E:  90 02
            rti                         ; 02070:  40

tab_b0_a071: ; 5 bytes
            hex d6 9f a0 0b 53          ; 02071:  d6 9f a0 0b 53

            lda $038c,x                 ; 02076:  bd 8c 03
            rts                         ; 02079:  60

            hex bb 29 0b 8b 1a b5 8c 09 ; 0207A:  bb 29 0b 8b 1a b5 8c 09
            hex 70 bb                   ; 02082:  70 bb

            plp                         ; 02084:  28
            rti                         ; 02085:  40

            hex 2a 09 72 29 8f fe b3 08 ; 02086:  2a 09 72 29 8f fe b3 08
            hex 72 28 8f fe b0 b1 0a d0 ; 0208E:  72 28 8f fe b0 b1 0a d0
            hex 2a 0a 54 c6 d7 87 a0 0b ; 02096:  2a 0a 54 c6 d7 87 a0 0b
            hex d0 2b 0b a6 9d 6d c6 d7 ; 0209E:  d0 2b 0b a6 9d 6d c6 d7
            hex 74 a0 cf 20 23 e8 fc ff ; 020A6:  74 a0 cf 20 23 e8 fc ff
            hex 0c 8b 1a b5 8c 01 70 bb ; 020AE:  0c 8b 1a b5 8c 01 70 bb
            hex 2b 0b 78 b0 2a b3 0c 53 ; 020B6:  2b 0b 78 b0 2a b3 0c 53

            lda $038c,x                 ; 020BE:  bd 8c 03
            rts                         ; 020C1:  60

            hex bb b0 b4 c5 d8 d3 a0 0c ; 020C2:  bb b0 b4 c5 d8 d3 a0 0c
            hex 53                      ; 020CA:  53

            lda $038c,x                 ; 020CB:  bd 8c 03
            rts                         ; 020CE:  60

            hex bb b3 0a b1 0b 7a b0 2a ; 020CF:  bb b3 0a b1 0b 7a b0 2a
            hex b3 0c 53                ; 020D7:  b3 0c 53

            lda $058c,x                 ; 020DA:  bd 8c 05
            rts                         ; 020DD:  60

            hex bb b0 b4 c5 d8 ef a0 0c ; 020DE:  bb b0 b4 c5 d8 ef a0 0c
            hex 53                      ; 020E6:  53

            lda $058c,x                 ; 020E7:  bd 8c 05
            rts                         ; 020EA:  60

            hex bb b3 0a b1 0b 7c b0 2a ; 020EB:  bb b3 0a b1 0b 7c b0 2a
            hex b3 0c 53                ; 020F3:  b3 0c 53

            lda $078c,x                 ; 020F6:  bd 8c 07
            rts                         ; 020F9:  60

            hex bb b0 b4 c5 d8 0b a1 0c ; 020FA:  bb b0 b4 c5 d8 0b a1 0c
            hex 53                      ; 02102:  53

            lda $078c,x                 ; 02103:  bd 8c 07
            rts                         ; 02106:  60

            hex bb b3 0a b1 0b 7e b0 2a ; 02107:  bb b3 0a b1 0b 7e b0 2a
            hex b3 0c 53                ; 0210F:  b3 0c 53

            lda $098c,x                 ; 02112:  bd 8c 09
            rts                         ; 02115:  60

            hex bb b0 b4 c5 d8 27 a1 0c ; 02116:  bb b0 b4 c5 d8 27 a1 0c
            hex 53                      ; 0211E:  53

            lda $098c,x                 ; 0211F:  bd 8c 09
            rts                         ; 02122:  60

            hex bb b3 0a b1 cf 20 23 e8 ; 02123:  bb b3 0a b1 cf 20 23 e8
            hex fe ff 3c e9 6d 94 02 5a ; 0212B:  fe ff 3c e9 6d 94 02 5a
            hex b6 2b 6a e9 52 ca 02 1b ; 02133:  b6 2b 6a e9 52 ca 02 1b
            hex bb b3 0d b4 b3 b0 bb b1 ; 0213B:  bb b3 0d b4 b3 b0 bb b1
            hex 62 e9 52 ca 02 d8 5a a1 ; 02143:  62 e9 52 ca 02 d8 5a a1
            hex 6a e9 52 ca 02 1b bb b3 ; 0214B:  6a e9 52 ca 02 1b bb b3
            hex 0d 78 b4 b3 b0 bb b1 cf ; 02153:  0d 78 b4 b3 b0 bb b1 cf
            hex 20 23 e8 fc ff 0c 8f 10 ; 0215B:  20 23 e8 fc ff 0c 8f 10
            hex b0 52 b6 2b 0c 76 b0 b3 ; 02163:  b0 52 b6 2b 0c 76 b0 b3
            hex 0c b0 b3 e9 5e cb 04 2a ; 0216B:  0c b0 b3 e9 5e cb 04 2a
            hex 1b c2 d8 81 a1 0a 2b 0c ; 02173:  1b c2 d8 81 a1 0a 2b 0c
            hex 8f 10 b3 0a d2 b1 3b 0c ; 0217B:  8f 10 b3 0a d2 b1 3b 0c
            hex b4 b3 b0 bc b1 3b 0c 76 ; 02183:  b4 b3 b0 bc b1 3b 0c 76
            hex b4 b3 b0 bc b1 cf 20 23 ; 0218B:  b4 b3 b0 bc b1 cf 20 23
            hex e8 00 00 0c 8c 2d 6d bb ; 02193:  e8 00 00 0c 8c 2d 6d bb
            hex d3 b3 3c e9 6d 94 02 52 ; 0219B:  d3 b3 3c e9 6d 94 02 52
            hex b6 b3 e9 0d d7 04 cf 20 ; 021A3:  b6 b3 e9 0d d7 04 cf 20
            hex 23 e8 00 00 0c 8c 2d 6d ; 021AB:  23 e8 00 00 0c 8c 2d 6d
            hex bb d3 b3 8d 28 0c 53    ; 021B3:  bb d3 b3 8d 28 0c 53

            lda $078c,x                 ; 021BA:  bd 8c 07
            rts                         ; 021BD:  60

            hex bb b0 b3 e9 0d d7 04 b3 ; 021BE:  bb b0 b3 e9 0d d7 04 b3
            hex e9 0d d7 04 b3 0c 8c 2d ; 021C6:  e9 0d d7 04 b3 0c 8c 2d
            hex 6d bb d3 b3 0c 53       ; 021CE:  6d bb d3 b3 0c 53

            lda $098c,x                 ; 021D4:  bd 8c 09
            rts                         ; 021D7:  60

            hex bb b0 b3 e9 0d d7 04 b4 ; 021D8:  bb b0 b3 e9 0d d7 04 b4
            hex bb cf 20 23 e8 fe ff 3c ; 021E0:  bb cf 20 23 e8 fe ff 3c
            hex e9 91 a1 02 d0 b3 e9 52 ; 021E8:  e9 91 a1 02 d0 b3 e9 52
            hex ca 02 b3 0c 8c 2d 6d bb ; 021F0:  ca 02 b3 0c 8c 2d 6d bb
            hex d3 b3 0d 74 b0 b3 e9 0d ; 021F8:  d3 b3 0d 74 b0 b3 e9 0d
            hex d7 04 b3 3c e9 aa a1 02 ; 02200:  d7 04 b3 3c e9 aa a1 02
            hex b4 bb b4 bb 2b 0d 8f 18 ; 02208:  b4 bb b4 bb 2b 0d 8f 18
            hex b0 b3 0b b4 c4 d8 1d a2 ; 02210:  b0 b3 0b b4 c4 d8 1d a2
            hex 0d 8f 18 b0 2b 0b cf 20 ; 02218:  0d 8f 18 b0 2b 0b cf 20
            hex 23 e8 fe ff 3c e9 91 a1 ; 02220:  23 e8 fe ff 3c e9 91 a1
            hex 02 d0 b3 e9 52 ca 02 b3 ; 02228:  02 d0 b3 e9 52 ca 02 b3
            hex 0c 8c 2d 6d bb d3 b3 0c ; 02230:  0c 8c 2d 6d bb d3 b3 0c
            hex 53                      ; 02238:  53

            lda $058c,x                 ; 02239:  bd 8c 05
            rts                         ; 0223C:  60

            hex bb b0 b3 0c 53          ; 0223D:  bb b0 b3 0c 53

            lda $038c,x                 ; 02242:  bd 8c 03
            rts                         ; 02245:  60

            hex bb b0 b3 e9 0d d7 04 b3 ; 02246:  bb b0 b3 e9 0d d7 04 b3
            hex e9 0d d7 04 b3 3c e9 aa ; 0224E:  e9 0d d7 04 b3 3c e9 aa
            hex a1 02 b4 bb b4 bb 2b 0d ; 02256:  a1 02 b4 bb b4 bb 2b 0d
            hex 8f 18 b0 b3 0b b4 c4 d8 ; 0225E:  8f 18 b0 b3 0b b4 c4 d8
            hex 6d a2 0d 8f 18 b0 2b 0b ; 02266:  6d a2 0d 8f 18 b0 2b 0b
            hex cf 20 23 e8 fa ff 62    ; 0226E:  cf 20 23 e8 fa ff 62

            sbc #$e8                    ; 02275:  e9 e8
            bcc tab_b0_a27a+1           ; 02277:  90 02
            rti                         ; 02279:  40

tab_b0_a27a: ; 258 bytes
            hex d6 d5 a2 3a e9 a9 a0 02 ; 0227A:  d6 d5 a2 3a e9 a9 a0 02
            hex 0a 8b 1a b5 8c 01 70 bb ; 02282:  0a 8b 1a b5 8c 01 70 bb
            hex 2b 3a e9 8d d9 02 d7 99 ; 0228A:  2b 3a e9 8d d9 02 d7 99
            hex a2 3b 3a e9 28 a1 04 0b ; 02292:  a2 3b 3a e9 28 a1 04 0b
            hex 7c b0 d8 c1 a2 0a 8c 2d ; 0229A:  7c b0 d8 c1 a2 0a 8c 2d
            hex 6d bb d3 29 3b 3a e9 e2 ; 022A2:  6d bb d3 29 3b 3a e9 e2
            hex a1 04 b3 0b b4 b3 b0 bb ; 022AA:  a1 04 b3 0b b4 b3 b0 bb
            hex b1 3b 3a e9 1f a2 04 b3 ; 022B2:  b1 3b 3a e9 1f a2 04 b3
            hex 0b 76 b4 b3 b0 bb b1 0b ; 022BA:  0b 76 b4 b3 b0 bb b1 0b
            hex b0 b3 3b e9 a9 92 04 3b ; 022C2:  b0 b3 3b e9 a9 92 04 3b
            hex e9 5b a1 02 3a e9 36 d8 ; 022CA:  e9 5b a1 02 3a e9 36 d8
            hex 02 0a d0 2a 0a a6 9d 6d ; 022D2:  02 0a d0 2a 0a a6 9d 6d
            hex c6 d7 7d a2 cf 20 23 e8 ; 022DA:  c6 d7 7d a2 cf 20 23 e8
            hex 00 00 8d 64 e9 52 ca 02 ; 022E2:  00 00 8d 64 e9 52 ca 02
            hex 53 c2 cf 20 23 e8 fe ff ; 022EA:  53 c2 cf 20 23 e8 fe ff
            hex 3c e9 cd d7 02 73 2b 6b ; 022F2:  3c e9 cd d7 02 73 2b 6b
            hex e9 52 ca 02 b3 0b b4 b3 ; 022FA:  e9 52 ca 02 b3 0b b4 b3
            hex d3 bb d4 65 0b b4 b3 d3 ; 02302:  d3 bb d4 65 0b b4 b3 d3
            hex bc d4 cf 20 23 e8 fe ff ; 0230A:  bc d4 cf 20 23 e8 fe ff
            hex 40 d6 49 a3 3b e9 ed a2 ; 02312:  40 d6 49 a3 3b e9 ed a2
            hex 02 89 5a a6 63 6d bc b3 ; 0231A:  02 89 5a a6 63 6d bc b3
            hex 0b 8c 2d 6d bb d3 b4 c9 ; 02322:  0b 8c 2d 6d bb d3 b4 c9
            hex d8 47 a3 0b 8b 1a b5 8c ; 0232A:  d8 47 a3 0b 8b 1a b5 8c
            hex 0d 70 bb b3 8d 5a 0b 8b ; 02332:  0d 70 bb b3 8d 5a 0b 8b
            hex 1a b5 8c 0d 70 bb b0 b3 ; 0233A:  1a b5 8c 0d 70 bb b0 b3
            hex e9 0d d7 04 b1 0b d0 2b ; 02342:  e9 0d d7 04 b1 0b d0 2b
            hex 0b a6 9d 6d c6 d7 16 a3 ; 0234A:  0b a6 9d 6d c6 d7 16 a3
            hex 63 62 e9 7b cc 04 ac 77 ; 02352:  63 62 e9 7b cc 04 ac 77
            hex d6 63 67 e9 7b cc 04 ac ; 0235A:  d6 63 67 e9 7b cc 04 ac
            hex 87 d6 ac 63 8e 89 ff a9 ; 02362:  87 d6 ac 63 8e 89 ff a9
            hex 67 6f a4 5f 6d d5 00 00 ; 0236A:  67 6f a4 5f 6d d5 00 00
            hex 04 00 81 a3 7e a3 85 a3 ; 02372:  04 00 81 a3 7e a3 85 a3
            hex 8b a3                   ; 0237A:  8b a3

            sta ($a3),y                 ; 0237C:  91 a3
            ldy tab_b0_9ee7+165         ; 0237E:  ac 8c 9f
            rti                         ; 02381:  40

            hex d6 a0 a3 ac 66 a0 d6 81 ; 02382:  d6 a0 a3 ac 66 a0 d6 81
            hex a3 ac 6f a2 d6 81 a3 62 ; 0238A:  a3 ac 6f a2 d6 81 a3 62
            hex e9 e8 90 02 d6 81 a3 3b ; 02392:  e9 e8 90 02 d6 81 a3 3b
            hex e9 94 91 02 0b d0 2b 0b ; 0239A:  e9 94 91 02 0b d0 2b 0b
            hex a6 9d 6d c6 d7 99 a3 cf ; 023A2:  a6 9d 6d c6 d7 99 a3 cf
            hex 20 23 e8 fa ff a4 61 6f ; 023AA:  20 23 e8 fa ff a4 61 6f
            hex 29 8e ff 00 8e 01 60 39 ; 023B2:  29 8e ff 00 8e 01 60 39
            hex 60 8d 16 e9 26 f2 0a 2a ; 023BA:  60 8d 16 e9 26 f2 0a 2a
            hex 8a 00 61 2b 8e 00 01 3b ; 023C2:  8a 00 61 2b 8e 00 01 3b
            hex 39 60 8d 16 e9 26 f2 0a ; 023CA:  39 60 8d 16 e9 26 f2 0a
            hex cd 0a bb 2a 8a 00 01 cd ; 023D2:  cd 0a bb 2a 8a 00 01 cd
            hex 0b bb 2b 0b 8c 00 70 c6 ; 023DA:  0b bb 2b 0b 8c 00 70 c6
            hex d7 c6 a3 8e ff 00 8e 01 ; 023E2:  d7 c6 a3 8e ff 00 8e 01
            hex 70 39 60 8d 16 e9 26 f2 ; 023EA:  70 39 60 8d 16 e9 26 f2
            hex 0a cd 0a bb 2a 8a 00 71 ; 023F2:  0a cd 0a bb 2a 8a 00 71
            hex 2b 8e 00 01 3b 39 60 8d ; 023FA:  2b 8e 00 01 3b 39 60 8d
            hex 16 e9 26 f2 0a cd 0a bb ; 02402:  16 e9 26 f2 0a cd 0a bb
            hex 2a 8a 00 01 cd 0b bb 2b ; 0240A:  2a 8a 00 01 cd 0b bb 2b
            hex 0b 8c 00 7f c6 d7 fb a3 ; 02412:  0b 8c 00 7f c6 d7 fb a3
            hex 8e eb 81 8e 00 7f 39 60 ; 0241A:  8e eb 81 8e 00 7f 39 60
            hex 8d 16 e9 26 f2 0a cd 0a ; 02422:  8d 16 e9 26 f2 0a cd 0a
            hex bb 2a 0a a8 eb 7f 8e 17 ; 0242A:  bb 2a 0a a8 eb 7f 8e 17
            hex bf 8e ed 7f e9 d9 ca 04 ; 02432:  bf 8e ed 7f e9 d9 ca 04
            hex 60 e9 a4 cb 02 40 a8 61 ; 0243A:  60 e9 a4 cb 02 40 a8 61
            hex 6f 8e 1c bf e9 26 d3 02 ; 02442:  6f 8e 1c bf e9 26 d3 02
            hex 8e 1d bf e9 c4 ce 02 ac ; 0244A:  8e 1d bf e9 c4 ce 02 ac
            hex 66 d7 cf 20 23 e8 f8 ff ; 02452:  66 d7 cf 20 23 e8 f8 ff
            hex 41 a8 d3 7f ac 20 cd a4 ; 0245A:  41 a8 d3 7f ac 20 cd a4
            hex 48 6e 51 c0 d8 73 a4 ac ; 02462:  48 6e 51 c0 d8 73 a4 ac
            hex ab 99 42 a8 48 6e d6 d4 ; 0246A:  ab 99 42 a8 48 6e d6 d4
            hex a5 ac 94 e6 a4 61 6f d8 ; 02472:  a5 ac 94 e6 a4 61 6f d8
            hex 7f a4 ac aa a3 a4 5f 6d ; 0247A:  7f a4 ac aa a3 a4 5f 6d
            hex d0 a8 5f 6d 53 da a8 5f ; 02482:  d0 a8 5f 6d 53 da a8 5f
            hex 6d d7 98 a4 a4 9f 6d d0 ; 0248A:  6d d7 98 a4 a4 9f 6d d0
            hex a8 9f 6d ac 4a 92       ; 02492:  a8 9f 6d ac 4a 92

            ldy tab_b0_a27a+147         ; 02498:  ac 0d a3
            rti                         ; 0249B:  40

            hex d6 ae a4 39 e9 36 d8 02 ; 0249C:  d6 ae a4 39 e9 36 d8 02
            hex 09 8c d4                ; 024A4:  09 8c d4

            adc tab_b0_b3a4+23          ; 024A7:  6d bb b3
            rti                         ; 024AA:  40

            hex d4 09 d0 29 09 a6 9d 6d ; 024AB:  d4 09 d0 29 09 a6 9d 6d
            hex c6 d7 9f a4 a5 a1 6d 8c ; 024B3:  c6 d7 9f a4 a5 a1 6d 8c
            hex 80 00 da d8 c2          ; 024BB:  80 00 da d8 c2

            ldy $cf                     ; 024C0:  a4 cf
            rti                         ; 024C2:  40

            hex a8 7b 6f a4 5f 6d 51 c0 ; 024C3:  a8 7b 6f a4 5f 6d 51 c0
            hex d8 de a4 62 e9 52 ca 02 ; 024CB:  d8 de a4 62 e9 52 ca 02
            hex d8 de a4 41 a8 7b 6f 8a ; 024D3:  d8 de a4 41 a8 7b 6f 8a
            hex b3 9c 2b a4 7b 6f d7 fe ; 024DB:  b3 9c 2b a4 7b 6f d7 fe
            hex a4 64 e9 52 ca 02 d7 f6 ; 024E3:  a4 64 e9 52 ca 02 d7 f6
            hex a4 42 a8 7b 6f 8a 00 9d ; 024EB:  a4 42 a8 7b 6f 8a 00 9d
            hex d6 fd a4 43 a8 7b 6f    ; 024F3:  d6 fd a4 43 a8 7b 6f

            txa                         ; 024FA:  8a
            cmp $2b9e,y                 ; 024FB:  d9 9e 2b
            rti                         ; 024FE:  40

            hex 29 40 28 d6 34 a5 39 e9 ; 024FF:  29 40 28 d6 34 a5 39 e9
            hex 99 d9 02 d7 31 a5 a4 7b ; 02507:  99 d9 02 d7 31 a5 a4 7b
            hex 6f 53 c1 d8 20 a5 8d 28 ; 0250F:  6f 53 c1 d8 20 a5 8d 28
            hex e9 52 ca 02 53 c2 d6 23 ; 02517:  e9 52 ca 02 53 c2 d6 23
            hex a5 ac df a2 d8 31 a5 08 ; 0251F:  a5 ac df a2 d8 31 a5 08
            hex d0 28 d1 8c ad 7b bb b3 ; 02527:  d0 28 d1 8c ad 7b bb b3
            hex 09 d4 09 d0 29 09 a6 9d ; 0252F:  09 d4 09 d0 29 09 a6 9d
            hex 6d c6 d7 05 a5 08 8c ad ; 02537:  6d c6 d7 05 a5 08 8c ad
            hex 7b bb b3 89 ff d4 08 d8 ; 0253F:  7b bb b3 89 ff d4 08 d8
            hex 5b a5 aa 7b 6f e9 b1 94 ; 02547:  5b a5 aa 7b 6f e9 b1 94
            hex 02 0b dd a4 48 6e 51 c0 ; 0254F:  02 0b dd a4 48 6e 51 c0
            hex d8 5b                   ; 02557:  d8 5b

            lda $cf                     ; 02559:  a5 cf
            rti                         ; 0255B:  40

            hex d6 cb a5 39 e9 cd d7 02 ; 0255C:  d6 cb a5 39 e9 cd d7 02
            hex 2a 0a d0 d3 8b 63 c4 d7 ; 02564:  2a 0a d0 d3 8b 63 c4 d7
            hex c9 a5 39 e9 72 d7 02 8c ; 0256C:  c9 a5 39 e9 72 d7 02 8c
            hex 67 6d bb d3 d7 c9 a5 09 ; 02574:  67 6d bb d3 d7 c9 a5 09
            hex 8c d4 6d bb b3 09 8c d4 ; 0257C:  8c d4 6d bb b3 09 8c d4
            hex 6d bb d3 b3 0a d0 d3 b3 ; 02584:  6d bb d3 b3 0a d0 d3 b3
            hex 89 64 b4 bc b3 8e 90 01 ; 0258C:  89 64 b4 bc b3 8e 90 01
            hex e9 52 ca 02 b4 c2 b4 db ; 02594:  e9 52 ca 02 b4 c2 b4 db
            hex d4 09 a8 5f 6f 39 e9 72 ; 0259C:  d4 09 a8 5f 6f 39 e9 72
            hex d9 02 d8 c9 a5 ac 1e 8c ; 025A4:  d9 02 d8 c9 a5 ac 1e 8c
            hex d8 c9 a5 39 e9 72 d7 02 ; 025AC:  d8 c9 a5 39 e9 72 d7 02
            hex 59 b5 8c a8 77 bb b3 e9 ; 025B4:  59 b5 8c a8 77 bb b3 e9
            hex 26 d3 02 8e 31 bf e9 c4 ; 025BC:  26 d3 02 8e 31 bf e9 c4
            hex ce 02 ac 66 d7 09 d0 29 ; 025C4:  ce 02 ac 66 d7 09 d0 29
            hex 09 a6 9d 6d c6 d7 5f a5 ; 025CC:  09 a6 9d 6d c6 d7 5f a5
            hex cf 20 23 e8 00 00 a4 63 ; 025D4:  cf 20 23 e8 00 00 a4 63
            hex 6d d0 5a b5 b3 e9 52 ca ; 025DC:  6d d0 5a b5 b3 e9 52 ca
            hex 02 cf 20 23 e8 f2 ff a4 ; 025E4:  02 cf 20 23 e8 f2 ff a4
            hex 63 6f 8b 1a b5 8c 01 70 ; 025EC:  63 6f 8b 1a b5 8c 01 70
            hex bb 25 78 2a 05 8f 10 29 ; 025F4:  bb 25 78 2a 05 8f 10 29
            hex 0c d8 86 a6 0a b0 50 c3 ; 025FC:  0c d8 86 a6 0a b0 50 c3
            hex d8 16 a6 3a 09 b0 52 b6 ; 02604:  d8 16 a6 3a 09 b0 52 b6
            hex b1 0a b0 b3 09 b4 b3 b0 ; 0260C:  b1 0a b0 b3 09 b4 b3 b0
            hex bc b1 09 b0 50 c3 d8 2c ; 02614:  bc b1 09 b0 50 c3 d8 2c
            hex a6 39 0a b0 52 b6 b1 09 ; 0261C:  a6 39 0a b0 52 b6 b1 09
            hex b0 b3 0a b4 b3 b0 bc b1 ; 02624:  b0 b3 0a b4 b3 b0 bc b1
            hex aa 63 6d e9 52 ca 02 8f ; 0262C:  aa 63 6d e9 52 ca 02 8f
            hex 46 b3 aa 63 6f e9 da d7 ; 02634:  46 b3 aa 63 6f e9 da d7
            hex 02 74 d3 b4 c2 d8 61 a6 ; 0263C:  02 74 d3 b4 c2 d8 61 a6
            hex 8d 32 e9 52 ca 02 b3 09 ; 02644:  8d 32 e9 52 ca 02 b3 09
            hex b0 b3 e9 0d d7 04 2b b3 ; 0264C:  b0 b3 e9 0d d7 04 2b b3
            hex 0a b4 b3 b0 bb b1 3b 09 ; 02654:  0a b4 b3 b0 bb b1 3b 09
            hex b4 b3 b0 bc b1 0a b0 a8 ; 0265C:  b4 b3 b0 bc b1 0a b0 a8
            hex 81 6f 05 76 29 8d 1f e9 ; 02664:  81 6f 05 76 29 8d 1f e9
            hex 52 ca 02 8f 32 b3 09 b0 ; 0266C:  52 ca 02 8f 32 b3 09 b0
            hex b3 e9 0d d7 04 a8 7f 6f ; 02674:  b3 e9 0d d7 04 a8 7f 6f
            hex b3 09 b4 b3 b0 bc b1 d6 ; 0267C:  b3 09 b4 b3 b0 bc b1 d6
            hex b8 a6 09 b0 8b 14 c4 d8 ; 02684:  b8 a6 09 b0 8b 14 c4 d8
            hex ab a6 8d 46 e9 52 ca 02 ; 0268C:  ab a6 8d 46 e9 52 ca 02
            hex 8f 14 b3 09 b0 b3 e9 0d ; 02694:  8f 14 b3 09 b0 b3 e9 0d
            hex d7 04 a8 81 6f b3 09 b4 ; 0269C:  d7 04 a8 81 6f b3 09 b4
            hex b3 b0 bc b1 d6 66 a6 6a ; 026A4:  b3 b0 bc b1 d6 66 a6 6a
            hex e9 52 ca 02 8f 19 a8 81 ; 026AC:  e9 52 ca 02 8f 19 a8 81
            hex 6f a8 7f 6f 40 a8 7d 6f ; 026B4:  6f a8 7f 6f 40 a8 7d 6f
            hex 0c d8 c5 a6 89 40 d6 c7 ; 026BC:  0c d8 c5 a6 89 40 d6 c7
            hex a6 89 20 cd a5 a1 6d db ; 026C4:  a6 89 20 cd a5 a1 6d db

            lda #$a1                    ; 026CC:  a9 a1
            adc tab_b0_a7d1+367         ; 026CE:  6d 40 a9
            adc p2_buttons                     ; 026D1:  65 6f
            txa                         ; 026D3:  8a
            ora $75,x                   ; 026D4:  15 75
            plp                         ; 026D6:  28
            ora $27                     ; 026D7:  05 27
            rti                         ; 026D9:  40

            hex 26 d6 fe a6 38 8d 14 e9 ; 026DA:  26 d6 fe a6 38 8d 14 e9
            hex 52 ca 02 8f 28 b3 07 b0 ; 026E2:  52 ca 02 8f 28 b3 07 b0
            hex b3 e9 0d d7 04 b1 08 72 ; 026EA:  b3 e9 0d d7 04 b1 08 72
            hex 28 8f fe 07 72 27 8f fe ; 026F2:  28 8f fe 07 72 27 8f fe
            hex 06 d0 26 d1 06 58 c6 d7 ; 026FA:  06 d0 26 d1 06 58 c6 d7
            hex de a6 08 72 28 8f fe b3 ; 02702:  de a6 08 72 28 8f fe b3
            hex a4 81 6f b1 08 72 28 8f ; 0270A:  a4 81 6f b1 08 72 28 8f
            hex fe b3 05 8f 12 b0 b3 05 ; 02712:  fe b3 05 8f 12 b0 b3 05
            hex 8f 18 b0 b4 bc b1 08 72 ; 0271A:  8f 18 b0 b4 bc b1 08 72
            hex 28 8f fe b3 ac d5 a5 b1 ; 02722:  28 8f fe b3 ac d5 a5 b1
            hex 38 ac d5 a5 b1 05 7c b0 ; 0272A:  38 ac d5 a5 b1 05 7c b0
            hex b3 05 8f 18 b0 b4 bc a8 ; 02732:  b3 05 8f 18 b0 b4 bc a8
            hex 21 75 89 32 a8 5f 6f cf ; 0273A:  21 75 89 32 a8 5f 6f cf
            hex 20 23 e8 fe ff 40 d6 6e ; 02742:  20 23 e8 fe ff 40 d6 6e
            hex a7 3b e9 36 d8 02 aa 9d ; 0274A:  a7 3b e9 36 d8 02 aa 9d
            hex 6d e9 52 ca 02 8c 1b 6f ; 02752:  6d e9 52 ca 02 8c 1b 6f
            hex bb b3 aa 9d 6d e9 52 ca ; 0275A:  bb b3 aa 9d 6d e9 52 ca
            hex 02 8c 1b 6f bb b3 e9 80 ; 02762:  02 8c 1b 6f bb b3 e9 80
            hex cb 04 0b d0 2b 0b a6 9d ; 0276A:  cb 04 0b d0 2b 0b a6 9d
            hex 6d c6 d7 4b a7 cf 20 23 ; 02772:  6d c6 d7 4b a7 cf 20 23
            hex e8 00 00 ac a3 89 61 e9 ; 0277A:  e8 00 00 ac a3 89 61 e9
            hex 03 ca 02 40 a8 79 6f ac ; 02782:  03 ca 02 40 a8 79 6f ac
            hex 55 a4 a4 48 6e 51 c0 d8 ; 0278A:  55 a4 a4 48 6e 51 c0 d8
            hex b0 a7 89 ff a9 67 6f 62 ; 02792:  b0 a7 89 ff a9 67 6f 62
            hex e9 b1 cb 02 a5 a1 6d 8c ; 0279A:  e9 b1 cb 02 a5 a1 6d 8c
            hex 80 00 da d7 ad a7 61 e9 ; 027A2:  80 00 da d7 ad a7 61 e9
            hex 03 ca 02 ac 55 a4 a5 a1 ; 027AA:  03 ca 02 ac 55 a4 a5 a1
            hex 6d 8c 80 00 da d7 43 a8 ; 027B2:  6d 8c 80 00 da d7 43 a8
            hex a5 67 6f a8 63 6f 8c ff ; 027BA:  a5 67 6f a8 63 6f 8c ff
            hex 00 c1 d8 fd a7 a5 68 6f ; 027C2:  00 c1 d8 fd a7 a5 68 6f

            eor ($c0),y                 ; 027CA:  51 c0
            cld                         ; 027CC:  d8
            cmp tab_b0_8e99+14,y        ; 027CD:  d9 a7 8e
            rti                         ; 027D0:  40

tab_b0_a7d1: ; 745 bytes
            hex bf e9 26 d3 02 ac 66 d7 ; 027D1:  bf e9 26 d3 02 ac 66 d7
            hex a5 68 6f d8 e3 a7 40 d6 ; 027D9:  a5 68 6f d8 e3 a7 40 d6
            hex e4 a7 41 b3 e9 e6 a5 02 ; 027E1:  e4 a7 41 b3 e9 e6 a5 02
            hex 62 e9 b1 cb 02 a5 a1 6d ; 027E9:  62 e9 b1 cb 02 a5 a1 6d
            hex 8c 80 00 da d7 fd a7 61 ; 027F1:  8c 80 00 da d7 fd a7 61
            hex e9 03 ca 02 a4 79 6f d7 ; 027F9:  e9 03 ca 02 a4 79 6f d7
            hex 85 a7 ac 42 a7 61 e9 b1 ; 02801:  85 a7 ac 42 a7 61 e9 b1
            hex cb 02 a5 a1 6d 8c 80 00 ; 02809:  cb 02 a5 a1 6d 8c 80 00
            hex da d7 43 a8 a4 79 6f d8 ; 02811:  da d7 43 a8 a4 79 6f d8
            hex 39 a8 62 e9 b1 cb 02 a5 ; 02819:  39 a8 62 e9 b1 cb 02 a5
            hex a1 6d 8c 80 00 da d7 2f ; 02821:  a1 6d 8c 80 00 da d7 2f
            hex a8 61 e9 03 ca 02 40 a8 ; 02829:  a8 61 e9 03 ca 02 40 a8
            hex 79 6f d6 06 a8 d6 06 a8 ; 02831:  79 6f d6 06 a8 d6 06 a8
            hex a5 a1 6d 8c 80 00 da d8 ; 02839:  a5 a1 6d 8c 80 00 da d8
            hex 85 a7 ac 03 80 d6 7d a7 ; 02841:  85 a7 ac 03 80 d6 7d a7
            hex cf 55 55 55 55 55 55 55 ; 02849:  cf 55 55 55 55 55 55 55
            hex 55 55 55 55 55 55 55 55 ; 02851:  55 55 55 55 55 55 55 55
            hex 55 55 55 00 00 00 00 55 ; 02859:  55 55 55 00 00 00 00 55
            hex 55 00 04 05 05 05 05 01 ; 02861:  55 00 04 05 05 05 05 01
            hex 00 f5 f5 f5 f5 f5 f5 f5 ; 02869:  00 f5 f5 f5 f5 f5 f5 f5
            hex f5 00 00 ff 05 05 05 00 ; 02871:  f5 00 00 ff 05 05 05 00
            hex 00 00 00 00 00 00 00 00 ; 02879:  00 00 00 00 00 00 00 00
            hex 00 05 45 55 55 55 55 15 ; 02881:  00 05 45 55 55 55 55 15
            hex 05 02 02 02 02 02 02 02 ; 02889:  05 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02891:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02899:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028A1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028A9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028B1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028B9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028C1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028C9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028D1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028D9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028E1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028E9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028F1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 028F9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02901:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02909:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02911:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02919:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02921:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02929:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02931:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02939:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02941:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02949:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02951:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02959:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02961:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02969:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02971:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02979:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02981:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02989:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02991:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02999:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029A1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029A9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029B1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029B9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029C1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029C9:  02 02 02 02 02 02 02 02
            hex 02 00 01 03 04 05 06 07 ; 029D1:  02 00 01 03 04 05 06 07
            hex 08 09 0a 0b 0c 0d 0e 0f ; 029D9:  08 09 0a 0b 0c 0d 0e 0f
            hex 10 02 02 02 02 02 02 02 ; 029E1:  10 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029E9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029F1:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 029F9:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A01:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A09:  02 02 02 02 02 02 02 02
            hex 02 02 11 13 14 17 18 1b ; 02A11:  02 02 11 13 14 17 18 1b
            hex 1c 1f 20 23 24 27 28 2b ; 02A19:  1c 1f 20 23 24 27 28 2b
            hex 02 02 02 02 02 02 02 02 ; 02A21:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A29:  02 02 02 02 02 02 02 02
            hex 02 02 12 15 16 19 1a 1d ; 02A31:  02 02 12 15 16 19 1a 1d
            hex 1e 21 22 25 26 29 2a 2c ; 02A39:  1e 21 22 25 26 29 2a 2c
            hex 02 02 02 02 02 02 02 02 ; 02A41:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A49:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A51:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A59:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A61:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A69:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A71:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A79:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A81:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02A89:  02 02 02 02 02 02 02 02
            hex 02 2d 2e 31 32 35 36 2d ; 02A91:  02 2d 2e 31 32 35 36 2d
            hex 39 3b 3c 31 3f 41 42 45 ; 02A99:  39 3b 3c 31 3f 41 42 45
            hex 46 02 02 02 02 02 02 02 ; 02AA1:  46 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02AA9:  02 02 02 02 02 02 02 02
            hex 02 2f 30 33 34 37 38 2f ; 02AB1:  02 2f 30 33 34 37 38 2f
            hex 3a                      ; 02AB9:  3a

            and $333e,x                 ; 02ABA:  3d 3e 33
            rti                         ; 02ABD:  40

            hex 43 44 47 48 02 02 02 02 ; 02ABE:  43 44 47 48 02 02 02 02
            hex 02 02 02 02 02 02 49 4a ; 02AC6:  02 02 02 02 02 02 49 4a
            hex 4b 4c 4d 4e 4f 50 51 52 ; 02ACE:  4b 4c 4d 4e 4f 50 51 52
            hex 54 55 56 57 58 59 5a 5b ; 02AD6:  54 55 56 57 58 59 5a 5b
            hex 5c                      ; 02ADE:  5c

            eor $5f5e,x                 ; 02ADF:  5d 5e 5f
            rts                         ; 02AE2:  60

            hex 61 62 63 64 65 02 02 02 ; 02AE3:  61 62 63 64 65 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02AEB:  02 02 02 02 02 02 02 02
            hex 02 53 02 02 02 02 02 02 ; 02AF3:  02 53 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02AFB:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B03:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B0B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B13:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B1B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B23:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B2B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B33:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B3B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B43:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B4B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B53:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B5B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B63:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B6B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B73:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B7B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B83:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B8B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B93:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02B9B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BA3:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BAB:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BB3:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BBB:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BC3:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BCB:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BD3:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BDB:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BE3:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BEB:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BF3:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02BFB:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C03:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C0B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C13:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C1B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C23:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C2B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C33:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 02 ; 02C3B:  02 02 02 02 02 02 02 02
            hex 02 02 02 02 02 02 02 30 ; 02C43:  02 02 02 02 02 02 02 30
            hex 31 37 3f 31 30 30 00 30 ; 02C4B:  31 37 3f 31 30 30 00 30
            hex 31 37 3f 31 30 30 00 71 ; 02C53:  31 37 3f 31 30 30 00 71
            hex c3 06 86 c6 e3 71 00 71 ; 02C5B:  c3 06 86 c6 e3 71 00 71
            hex c3 06 86 c6 e3 71 00 00 ; 02C63:  c3 06 86 c6 e3 71 00 00
            hex 00 00 00 00 00 00 00 00 ; 02C6B:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 f8 ; 02C73:  00 00 00 00 00 00 00 f8
            hex 0c 06 06 06 0c f8 00 f8 ; 02C7B:  0c 06 06 06 0c f8 00 f8
            hex 0c                      ; 02C83:  0c

            asl ptr3_lo                     ; 02C84:  06 06
            asl $0c                     ; 02C86:  06 0c
            sed                         ; 02C88:  f8
            brk                         ; 02C89:  00
            hex 7f                      ; 02C8A:  7f
            rts                         ; 02C8B:  60

            hex 60 7f 60 60 7f          ; 02C8C:  60 7f 60 60 7f

            brk                         ; 02C91:  00
            hex 7f                      ; 02C92:  7f
            rts                         ; 02C93:  60

tab_b0_ac94: ; 242 bytes
            hex 60 7f 60 60 7f 00 8c 0c ; 02C94:  60 7f 60 60 7f 00 8c 0c
            hex 0c 0c 0c 0c 8c 00 8c 0c ; 02C9C:  0c 0c 0c 0c 8c 00 8c 0c
            hex 0c 0c 0c 0c 8c 00 01 01 ; 02CA4:  0c 0c 0c 0c 8c 00 01 01
            hex 01 01 01 01 01 00 01 01 ; 02CAC:  01 01 01 01 01 00 01 01
            hex 01 01 01 01 01 00 fc 86 ; 02CB4:  01 01 01 01 01 00 fc 86
            hex 86 fc 80 80 80 00 fc 86 ; 02CBC:  86 fc 80 80 80 00 fc 86
            hex 86 fc 80 80 80 00 7f 61 ; 02CC4:  86 fc 80 80 80 00 7f 61
            hex 61 7f 66 63 61 00 7f 61 ; 02CCC:  61 7f 66 63 61 00 7f 61
            hex 61 7f 66 63 61 00 1f 98 ; 02CD4:  61 7f 66 63 61 00 1f 98
            hex 98 1f 18 18 9f 00 1f 98 ; 02CDC:  98 1f 18 18 9f 00 1f 98
            hex 98 1f 18 18 9f 00 e3 06 ; 02CE4:  98 1f 18 18 9f 00 e3 06
            hex 06 c3 00 06 e3 00 e3 06 ; 02CEC:  06 c3 00 06 e3 00 e3 06
            hex 06 c3 00 06 e3 00 f1 19 ; 02CF4:  06 c3 00 06 e3 00 f1 19
            hex 01 f1 19 19 f1 00 f1 19 ; 02CFC:  01 f1 19 19 f1 00 f1 19
            hex 01 f1 19 19 f1 00 fe 80 ; 02D04:  01 f1 19 19 f1 00 fe 80
            hex 80 fc 80 80 fe 00 fe 80 ; 02D0C:  80 fc 80 80 fe 00 fe 80
            hex 80 fc 80 80 fe 00 61 71 ; 02D14:  80 fc 80 80 fe 00 61 71
            hex 79 6d 67 63 61 00 61 71 ; 02D1C:  79 6d 67 63 61 00 61 71
            hex 79 6d 67 63 61 00 9f 81 ; 02D24:  79 6d 67 63 61 00 9f 81
            hex 81 81 81 81 81 00 9f 81 ; 02D2C:  81 81 81 81 81 00 9f 81
            hex 81 81 81 81 81 00 f9 83 ; 02D34:  81 81 81 81 81 00 f9 83
            hex 83 81 80 83 81 00 f9 83 ; 02D3C:  83 81 80 83 81 00 f9 83
            hex 83 81 80 83 81 00 f8 0c ; 02D44:  83 81 80 83 81 00 f8 0c
            hex 00 f8 0c 0c f8 00 f8 0c ; 02D4C:  00 f8 0c 0c f8 00 f8 0c
            hex 00 f8 0c 0c f8 00 00 00 ; 02D54:  00 f8 0c 0c f8 00 00 00
            hex 00 00 04 00 08 08 00 00 ; 02D5C:  00 00 04 00 08 08 00 00
            hex 01 02 02 04 04 04 08 08 ; 02D64:  01 02 02 04 04 04 08 08
            hex 0e 04 07 03 01 00 04 04 ; 02D6C:  0e 04 07 03 01 00 04 04
            hex 02 02 01 00 00 00 5e 3d ; 02D74:  02 02 01 00 00 00 5e 3d
            hex 87 0d 1a 8c 86 c0 7e c3 ; 02D7C:  87 0d 1a 8c 86 c0 7e c3
            hex 00 3c                   ; 02D84:  00 3c

            ror $42                     ; 02D86:  66 42
            rti                         ; 02D88:  40

            hex 40 01 00 80 c9 cf e3 63 ; 02D89:  40 01 00 80 c9 cf e3 63
            hex 63 01 03 87 47 41 21 21 ; 02D91:  63 01 03 87 47 41 21 21
            hex 21 80 c2                ; 02D99:  21 80 c2

            ldy #$c0                    ; 02D9C:  a0 c0
            sei                         ; 02D9E:  78
            rti                         ; 02D9F:  40

            hex 80 fc 40 42 66 3c 00 c3 ; 02DA0:  80 fc 40 42 66 3c 00 c3
            hex 7e 00 42 62 02 82 02 02 ; 02DA8:  7e 00 42 62 02 82 02 02
            hex 02 03 21 21 41 41 81 01 ; 02DB0:  02 03 21 21 41 41 81 01
            hex 01 00 82 80 81 90 94 90 ; 02DB8:  01 00 82 80 81 90 94 90
            hex 94 12 83 87 8e 8c 8c 8c ; 02DC0:  94 12 83 87 8e 8c 8c 8c
            hex 8c 8e c0 20 b0 f5 75 77 ; 02DC8:  8c 8e c0 20 b0 f5 75 77
            hex 56 17 c0 e1 73 33 33 33 ; 02DD0:  56 17 c0 e1 73 33 33 33
            hex 33 71 9f 0e 87 14 92 19 ; 02DD8:  33 71 9f 0e 87 14 92 19
            hex 0e 87 87 83 8c 8c 8e 87 ; 02DE0:  0e 87 87 83 8c 8c 8e 87
            hex 83 00 02 14 e4 54 04 07 ; 02DE8:  83 00 02 14 e4 54 04 07
            hex 03 81 f3 f3 33 33 73 e1 ; 02DF0:  03 81 f3 f3 33 33 73 e1
            hex c0 00 b0 38 7c 3d 15 11 ; 02DF8:  c0 00 b0 38 7c 3d 15 11
            hex 85 09 f0 f8 9c 0c 0c 0c ; 02E00:  85 09 f0 f8 9c 0c 0c 0c
            hex 9c f8 2c 0e 1f 0f 45 c4 ; 02E08:  9c f8 2c 0e 1f 0f 45 c4
            hex 45 c2 3c 7e e7 c3 c3 c3 ; 02E10:  45 c2 3c 7e e7 c3 c3 c3
            hex c3 e7 75 3c 14 10 85 41 ; 02E18:  c3 e7 75 3c 14 10 85 41
            hex 80 e0 9c 0c 0c 0c 9c f8 ; 02E20:  80 e0 9c 0c 0c 0c 9c f8
            hex f0 00 a5 c3 7d 04 21 d0 ; 02E28:  f0 00 a5 c3 7d 04 21 d0
            hex e0 78 7f 3f 03 c3 e7 7e ; 02E30:  e0 78 7f 3f 03 c3 e7 7e
            hex 3c 00 00 01 01 01 01 01 ; 02E38:  3c 00 00 01 01 01 01 01
            hex 01 01 00 00 00 00 00 00 ; 02E40:  01 01 00 00 00 00 00 00
            hex 00 00 e0 20 20 21 22 64 ; 02E48:  00 00 e0 20 20 21 22 64
            hex cc 92 e0 e1 e3 e7 ef fe ; 02E50:  cc 92 e0 e1 e3 e7 ef fe
            hex fc fe 01 01 01 01 01 01 ; 02E58:  fc fe 01 01 01 01 01 01
            hex 01 01 00 00 00 00 00 00 ; 02E60:  01 01 00 00 00 00 00 00
            hex 00 00 21 59 ad 27 27 03 ; 02E68:  00 00 21 59 ad 27 27 03
            hex 21 c0 ff e7 e3 e3 e1 e0 ; 02E70:  21 c0 ff e7 e3 e3 e1 e0
            hex e0 00 f1 40 80 00 10 00 ; 02E78:  e0 00 f1 40 80 00 10 00
            hex 20 20 f1 e3 c7 8e 0c 1c ; 02E80:  20 20 f1 e3 c7 8e 0c 1c
            hex 1c 1c 78 1c fe 1d 0d 04 ; 02E88:  1c 1c 78 1c fe 1d 0d 04
            hex 05 06 f8 fc 0e 07 03 03 ; 02E90:  05 06 f8 fc 0e 07 03 03
            hex 03 03 24 2c bc de 39 2c ; 02E98:  03 03 24 2c bc de 39 2c
            hex 96 e3 1c 1c 8c ce e7 e3 ; 02EA0:  96 e3 1c 1c 8c ce e7 e3
            hex 71 00 04 04 04 00 00 c0 ; 02EA8:  71 00 04 04 04 00 00 c0
            hex 80 f0 03 03 03 07       ; 02EB0:  80 f0 03 03 03 07

            asl $f8fc                   ; 02EB6:  0e fc f8
            brk                         ; 02EB9:  00
            hex 3a                      ; 02EBA:  3a
            bvc tab_b0_af0b+25          ; 02EBB:  50 67
            rti                         ; 02EBD:  40

            hex 40 c0 c2 c4 3f 3f 38 38 ; 02EBE:  40 c0 c2 c4 3f 3f 38 38
            hex 38 b8 bf bf f9 1a f2 02 ; 02EC6:  38 b8 bf bf f9 1a f2 02
            hex 02 03 fb 63             ; 02ECE:  02 03 fb 63

            sbc $01f9,y                 ; 02ED2:  f9 f9 01
            ora (ptr0_hi,x)                 ; 02ED5:  01 01
            ora ($f9,x)                 ; 02ED7:  01 f9
            sbc $d04f,y                 ; 02ED9:  f9 4f d0
            rts                         ; 02EDC:  60

            hex 40 40 4c 59 7f b8 b8 38 ; 02EDD:  40 40 4c 59 7f b8 b8 38
            hex 38 38 3f 3f 00 f2 02 03 ; 02EE5:  38 38 3f 3f 00 f2 02 03
            hex 02 02 c2 82 f3          ; 02EED:  02 02 c2 82 f3

            ora (ptr0_hi,x)                 ; 02EF2:  01 01
            ora (ptr0_hi,x)                 ; 02EF4:  01 01
            ora ($f9,x)                 ; 02EF6:  01 f9
            sbc $e000,y                 ; 02EF8:  f9 00 e0
            jsr $6020                   ; 02EFB:  20 20 60
            cpx #$e0                    ; 02EFE:  e0 e0
            ldy #$20                    ; 02F00:  a0 20
            cpx #$e0                    ; 02F02:  e0 e0
            cpx #$e0                    ; 02F04:  e0 e0
            cpx #$e0                    ; 02F06:  e0 e0
            cpx #$e0                    ; 02F08:  e0 e0
            rts                         ; 02F0A:  60

tab_b0_af0b: ; 100 bytes
            hex 80 20 00 00 20 00 c0 e0 ; 02F0B:  80 20 00 00 20 00 c0 e0
            hex e0 e0 e0 e0 e0 e0 00 00 ; 02F13:  e0 e0 e0 e0 e0 e0 00 00
            hex 00 00 00 03 03 03 03 00 ; 02F1B:  00 00 00 03 03 03 03 00
            hex 00 00 00 03 03 03 03 00 ; 02F23:  00 00 00 03 03 03 03 00
            hex 00 00 00 06 8e de 76 00 ; 02F2B:  00 00 00 06 8e de 76 00
            hex 00 00 00 06 8e de 76 03 ; 02F33:  00 00 00 06 8e de 76 03
            hex 03 03 00 00 00 00 00 03 ; 02F3B:  03 03 00 00 00 00 00 03
            hex 03 03 00 00 00 00 00 26 ; 02F43:  03 03 00 00 00 00 00 26
            hex 06 06 00 00 00 00 00 26 ; 02F4B:  06 06 00 00 00 00 00 26
            hex 06 06 00 00 00 00 00 00 ; 02F53:  06 06 00 00 00 00 00 00
            hex 00 00 00 0f 19 19 30 00 ; 02F5B:  00 00 00 0f 19 19 30 00
            hex 00 00 00 0f 19 19 30 00 ; 02F63:  00 00 00 0f 19 19 30 00
            hex 00 00 00 07             ; 02F6B:  00 00 00 07

            stx clock_b_lo                     ; 02F6F:  86 86
            dec ptr0_lo                     ; 02F71:  c6 00
            brk                         ; 02F73:  00
            hex 00                      ; 02F74:  00
            brk                         ; 02F75:  00
            hex 07                      ; 02F76:  07
            stx clock_b_lo                     ; 02F77:  86 86
            dec $3f                     ; 02F79:  c6 3f
            rts                         ; 02F7B:  60

            hex 60                      ; 02F7C:  60

            brk                         ; 02F7D:  00
            hex 00                      ; 02F7E:  00
            brk                         ; 02F7F:  00
            hex 00                      ; 02F80:  00
            brk                         ; 02F81:  00
            hex 3f                      ; 02F82:  3f
            rts                         ; 02F83:  60

            hex 60 00 00 00 00 00 c6 66 ; 02F84:  60 00 00 00 00 00 c6 66
            hex 67 00 00 00 00 00 c6 66 ; 02F8C:  67 00 00 00 00 00 c6 66
            hex 67 00 00 00 00 00 00 00 ; 02F94:  67 00 00 00 00 00 00 00
            hex 00 00 e1 31 19 19 00 00 ; 02F9C:  00 00 e1 31 19 19 00 00
            hex 00 00 e1 31 19 19 00 00 ; 02FA4:  00 00 e1 31 19 19 00 00
            hex 00 00 fe 80 80 fc 00 00 ; 02FAC:  00 00 fe 80 80 fc 00 00
            hex 00 00 fe 80 80 fc 19 31 ; 02FB4:  00 00 fe 80 80 fc 19 31
            hex e1 00 00 00 00 00 19 31 ; 02FBC:  e1 00 00 00 00 00 19 31
            hex e1 00 00 00 00 00 80 80 ; 02FC4:  e1 00 00 00 00 00 80 80
            hex fe 00 00 00 00 00 80 80 ; 02FCC:  fe 00 00 00 00 00 80 80
            hex fe 00 00 00 00 00 00 00 ; 02FD4:  fe 00 00 00 00 00 00 00
            hex 00 00 30 38 3c 36 00 00 ; 02FDC:  00 00 30 38 3c 36 00 00
            hex 00 00 30 38 3c 36 33 31 ; 02FE4:  00 00 30 38 3c 36 33 31
            hex 30 00 00 00 00 00 33 31 ; 02FEC:  30 00 00 00 00 00 33 31
            hex 30 00 00 00 00 00 00 00 ; 02FF4:  30 00 00 00 00 00 00 00
            hex 00 00 c0 c0 c0 c0 00 00 ; 02FFC:  00 00 c0 c0 c0 c0 00 00
            hex 00 00 c0 c0 c0 c0 00 00 ; 03004:  00 00 c0 c0 c0 c0 00 00
            hex 00 00 06 06 06 06 00 00 ; 0300C:  00 00 06 06 06 06 00 00
            hex 00 00 06 06 06 06 c0 c0 ; 03014:  00 00 06 06 06 06 c0 c0
            hex c0 00 00 00 00 00 c0 c0 ; 0301C:  c0 00 00 00 00 00 c0 c0
            hex c0 00 00 00 00 00 c6 c6 ; 03024:  c0 00 00 00 00 00 c6 c6
            hex 7c 00 00 00 00 00 c6 c6 ; 0302C:  7c 00 00 00 00 00 c6 c6
            hex 7c 00 00 00 00 00 00 00 ; 03034:  7c 00 00 00 00 00 00 00
            hex 00 00 07 86 86 c7 00 00 ; 0303C:  00 00 07 86 86 c7 00 00
            hex 00 00 07 86 86 c7 c6 66 ; 03044:  00 00 07 86 86 c7 c6 66
            hex 66 00 00 00 00 00 c6 66 ; 0304C:  66 00 00 00 00 00 c6 66
            hex 66 00 00 00 00 00 00 00 ; 03054:  66 00 00 00 00 00 00 00
            hex 00 00 f0 18 18 f1 00 00 ; 0305C:  00 00 f0 18 18 f1 00 00
            hex 00 00 f0 18 18 f1 00 00 ; 03064:  00 00 f0 18 18 f1 00 00
            hex 00 00 78 cc cc 86 00 00 ; 0306C:  00 00 78 cc cc 86 00 00
            hex 00 00 78 cc cc 86 01 03 ; 03074:  00 00 78 cc cc 86 01 03
            hex 03 00 00 00 00 00 01 03 ; 0307C:  03 00 00 00 00 00 01 03
            hex 03 00 00 00 00 00 fe 03 ; 03084:  03 00 00 00 00 00 fe 03
            hex 03 00 00 00 00 00 fe 03 ; 0308C:  03 00 00 00 00 00 fe 03
            hex 03 00 00 00 00 00 00 00 ; 03094:  03 00 00 00 00 00 00 00
            hex 00 00 18 1c 1e 1b 00 00 ; 0309C:  00 00 18 1c 1e 1b 00 00
            hex 00 00 18 1c             ; 030A4:  00 00 18 1c

            hex 1e 1b 00 ; asl $001b,x  ; 030A8:  1e 1b 00
            brk                         ; 030AB:  00
            hex 00                      ; 030AC:  00
            brk                         ; 030AD:  00
            hex 60                      ; 030AE:  60
            rts                         ; 030AF:  60

            hex 60 60                   ; 030B0:  60 60

            brk                         ; 030B2:  00
            hex 00                      ; 030B3:  00
            brk                         ; 030B4:  00
            hex 00                      ; 030B5:  00
            rts                         ; 030B6:  60

            hex 60 60 60 19 18 18 00 00 ; 030B7:  60 60 60 19 18 18 00 00
            hex 00 00 00 19 18 18 00 00 ; 030BF:  00 00 00 19 18 18 00 00
            hex 00 00 00 e0 e0 60 00 00 ; 030C7:  00 00 00 e0 e0 60 00 00
            hex 00 00 00 e0 e0 60 00 00 ; 030CF:  00 00 00 e0 e0 60 00 00
            hex 00 00 00 c3 c3 c0 c3 c3 ; 030D7:  00 00 00 c3 c3 c0 c3 c3
            hex c3 fb 00 c3 c3 c0 c3 c3 ; 030DF:  c3 fb 00 c3 c3 c0 c3 c3
            hex c3 fb 00 00 00 3e 70 70 ; 030E7:  c3 fb 00 00 00 3e 70 70
            hex 70 3e 00 00 00 3e 70 70 ; 030EF:  70 3e 00 00 00 3e 70 70
            hex 70 3e 00 00 00 79 cd fd ; 030F7:  70 3e 00 00 00 79 cd fd
            hex c1 7d 00 00 00 79 cd fd ; 030FF:  c1 7d 00 00 00 79 cd fd
            hex c1 7d 00 00 00 f1 9b 99 ; 03107:  c1 7d 00 00 00 f1 9b 99
            hex 98 9b 00 00 00 f1 9b    ; 0310F:  98 9b 00 00 00 f1 9b

            sta $9b98,y                 ; 03116:  99 98 9b
            brk                         ; 03119:  00
            hex 00                      ; 0311A:  00
            brk                         ; 0311B:  00
            hex f3                      ; 0311C:  f3
            stx $e7                     ; 0311D:  86 e7
            ror $e3,x                   ; 0311F:  76 e3
            brk                         ; 03121:  00
            hex 00                      ; 03122:  00
            brk                         ; 03123:  00
            hex f3                      ; 03124:  f3
            stx $e7                     ; 03125:  86 e7
            ror $e3,x                   ; 03127:  76 e3
            brk                         ; 03129:  00
            hex 00                      ; 0312A:  00
            brk                         ; 0312B:  00
            hex c7                      ; 0312C:  c7
            jmp ($0cec)                 ; 0312D:  6c ec 0c

            hex e7                      ; 03130:  e7

            brk                         ; 03131:  00
            hex 00                      ; 03132:  00
            brk                         ; 03133:  00
            hex c7                      ; 03134:  c7
            jmp ($0cec)                 ; 03135:  6c ec 0c

            hex e7                      ; 03138:  e7

            brk                         ; 03139:  00
            hex c0                      ; 0313A:  c0
            cpy #$c0                    ; 0313B:  c0 c0
            cpy #$c0                    ; 0313D:  c0 c0
            cpy #$c0                    ; 0313F:  c0 c0
            brk                         ; 03141:  00
            hex c0                      ; 03142:  c0
            cpy #$c0                    ; 03143:  c0 c0
            cpy #$c0                    ; 03145:  c0 c0
            cpy #$c0                    ; 03147:  c0 c0
            brk                         ; 03149:  00
            hex 60                      ; 0314A:  60
            rts                         ; 0314B:  60

            hex 60 7c 66 66 7c          ; 0314C:  60 7c 66 66 7c

            brk                         ; 03151:  00
            hex 60                      ; 03152:  60
            rts                         ; 03153:  60

            hex 60 7c 66 66 7c 00 00 00 ; 03154:  60 7c 66 66 7c 00 00 00
            hex 00 cc cc cc 7c 0c 00 00 ; 0315C:  00 cc cc cc 7c 0c 00 00
            hex 00 cc cc cc 7c 0c 06 07 ; 03164:  00 cc cc cc 7c 0c 06 07
            hex 07 06 06 06 06 00 06 07 ; 0316C:  07 06 06 06 06 00 06 07
            hex 07 06 06 06 06 00 f8 00 ; 03174:  07 06 06 06 06 00 f8 00
            hex 00 00 00 00 00 00 f8 00 ; 0317C:  00 00 00 00 00 00 f8 00
            hex 00 00 00 00 00 00 36 36 ; 03184:  00 00 00 00 00 00 36 36
            hex b0 f6 76 36 16 00 36 36 ; 0318C:  b0 f6 76 36 16 00 36 36
            hex b0 f6 76 36 16 00 00 00 ; 03194:  b0 f6 76 36 16 00 00 00
            hex fb cc cc cc cc 00 00 00 ; 0319C:  fb cc cc cc cc 00 00 00
            hex fb cc cc cc cc 00 00 c0 ; 031A4:  fb cc cc cc cc 00 00 c0
            hex f7 cc cf cc c7 00 00 c0 ; 031AC:  f7 cc cf cc c7 00 00 c0
            hex f7 cc cf cc c7 00 00 00 ; 031B4:  f7 cc cf cc c7 00 00 00
            hex 9f d9 d9 19 d9 00 00 00 ; 031BC:  9f d9 d9 19 d9 00 00 00
            hex 9f d9 d9 19 d9 00 03 03 ; 031C4:  9f d9 d9 19 d9 00 03 03
            hex 1f b3 b3 b3 9f 00 03 03 ; 031CC:  1f b3 b3 b3 9f 00 03 03
            hex 1f b3 b3 b3 9f 00 00 00 ; 031D4:  1f b3 b3 b3 9f 00 00 00
            hex 3c 66 66 66 3c 00 00 00 ; 031DC:  3c 66 66 66 3c 00 00 00
            hex 3c 66 66 66 3c 00 00 00 ; 031E4:  3c 66 66 66 3c 00 00 00
            hex 01 03 03 03 01 00 00 00 ; 031EC:  01 03 03 03 01 00 00 00
            hex 01 03 03 03 01 00 03    ; 031F4:  01 03 03 03 01 00 03

            asl $ef                     ; 031FB:  06 ef
            rol $36,x                   ; 031FD:  36 36
            rol $e6,x                   ; 031FF:  36 e6
            brk                         ; 03201:  00
            hex 03                      ; 03202:  03
            asl $ef                     ; 03203:  06 ef
            rol $36,x                   ; 03205:  36 36
            rol $e6,x                   ; 03207:  36 e6
            brk                         ; 03209:  00
            hex 80                      ; 0320A:  80
            brk                         ; 0320B:  00
            hex 80                      ; 0320C:  80
            brk                         ; 0320D:  00
            hex 00                      ; 0320E:  00
            brk                         ; 0320F:  00
            hex 00                      ; 03210:  00
            brk                         ; 03211:  00
            hex 80                      ; 03212:  80
            brk                         ; 03213:  00
            hex 80                      ; 03214:  80
            brk                         ; 03215:  00
            hex 00                      ; 03216:  00
            brk                         ; 03217:  00
            hex 00                      ; 03218:  00
            brk                         ; 03219:  00
            hex 38                      ; 0321A:  38
            jmp $4c4c                   ; 0321B:  4c 4c 4c

            inc $8686,x                 ; 0321E:  fe 86 86
            brk                         ; 03221:  00
            hex 38                      ; 03222:  38
            jmp $4c4c                   ; 03223:  4c 4c 4c

            hex fe 86 86 00 00 00 fe db ; 03226:  fe 86 86 00 00 00 fe db
            hex db db db 00 00 00 fe db ; 0322E:  db db db 00 00 00 fe db
            hex db db db                ; 03236:  db db db

            brk                         ; 03239:  00
            hex 00                      ; 0323A:  00
            brk                         ; 0323B:  00
            hex 3c                      ; 0323C:  3c
            ror $7e                     ; 0323D:  66 7e
            rts                         ; 0323F:  60

            hex 3e 00 00 ; rol ptr0_lo,x  ; 03240:  3e 00 00
            brk                         ; 03243:  00
            hex 3c                      ; 03244:  3c
            ror $7e                     ; 03245:  66 7e
            rts                         ; 03247:  60

            hex 3e 00 03 03 d8 e3 c3 c3 ; 03248:  3e 00 03 03 d8 e3 c3 c3
            hex c3 00 03 03 d8 e3 c3 c3 ; 03250:  c3 00 03 03 d8 e3 c3 c3
            hex c3 00 00 00 3c 61 61 61 ; 03258:  c3 00 00 00 3c 61 61 61
            hex 3c 00 00 00 3c 61 61 61 ; 03260:  3c 00 00 00 3c 61 61 61
            hex 3c 00 00 00 f8 98 98 98 ; 03268:  3c 00 00 00 f8 98 98 98
            hex e8 00 00 00 f8 98 98 98 ; 03270:  e8 00 00 00 f8 98 98 98
            hex e8 00 0f 06 06 06 06 06 ; 03278:  e8 00 0f 06 06 06 06 06
            hex 0f 00 0f 06 06 06 06 06 ; 03280:  0f 00 0f 06 06 06 06 06
            hex 0f 00 00 00 7c 66 66 66 ; 03288:  0f 00 00 00 7c 66 66 66
            hex 66 00 00 00 7c 66 66 66 ; 03290:  66 00 00 00 7c 66 66 66
            hex 66 00 00 00 78 c0 c0 c3 ; 03298:  66 00 00 00 78 c0 c0 c3
            hex 7b 00 00 00 78 c0 c0 c3 ; 032A0:  7b 00 00 00 78 c0 c0 c3
            hex 7b 00 00 00 00 00 00 00 ; 032A8:  7b 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 032B0:  00 00 00 00 00 00 00 00
            hex 00 00 ff ff ff ff ff ff ; 032B8:  00 00 ff ff ff ff ff ff
            hex ff ff 00 00 00 00 00 00 ; 032C0:  ff ff 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 032C8:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 032D0:  00 00 00 00 00 00 00 00
            hex 00 00 06 0e 0c          ; 032D8:  00 00 06 0e 0c

            clc                         ; 032DD:  18
            bpl tab_b0_b339+7           ; 032DE:  10 60
            rts                         ; 032E0:  60

            brk                         ; 032E1:  00
            hex 06                      ; 032E2:  06
            asl $180c                   ; 032E3:  0e 0c 18
            bpl tab_b0_b339+15          ; 032E6:  10 60
            rts                         ; 032E8:  60

            hex 00 08 10 20 20 20 10 08 ; 032E9:  00 08 10 20 20 20 10 08
            hex 00 08 10 20 20 20 10 08 ; 032F1:  00 08 10 20 20 20 10 08
            hex 00 10 08 04 04 04 08 10 ; 032F9:  00 10 08 04 04 04 08 10
            hex 00 10 08 04 04 04 08 10 ; 03301:  00 10 08 04 04 04 08 10
            hex 00 00 00 00 00 3c 00 00 ; 03309:  00 00 00 00 00 3c 00 00
            hex 00 00 00 00 00 3c 00 00 ; 03311:  00 00 00 00 00 3c 00 00
            hex 00 00 00 00 00 00 18 18 ; 03319:  00 00 00 00 00 00 18 18
            hex 00 00 00 00 00 00 18 18 ; 03321:  00 00 00 00 00 00 18 18
            hex 00 00 02 04             ; 03329:  00 00 02 04

            php                         ; 0332D:  08
            bpl tab_b0_b339+23          ; 0332E:  10 20
            rti                         ; 03330:  40

            hex 00 00 02 04             ; 03331:  00 00 02 04

            php                         ; 03335:  08
            bpl tab_b0_b339+31          ; 03336:  10 20
            rti                         ; 03338:  40

tab_b0_b339: ; 96 bytes
            hex 00 7c ce ce de ee ce 7c ; 03339:  00 7c ce ce de ee ce 7c
            hex 00 7c ce ce de ee ce 7c ; 03341:  00 7c ce ce de ee ce 7c
            hex 00 38 78 38 38 38 38 7c ; 03349:  00 38 78 38 38 38 38 7c
            hex 00 38 78 38 38 38 38 7c ; 03351:  00 38 78 38 38 38 38 7c
            hex 00 7c ce ce 1c 38 70 fe ; 03359:  00 7c ce ce 1c 38 70 fe
            hex 00 7c ce ce 1c 38 70 fe ; 03361:  00 7c ce ce 1c 38 70 fe
            hex 00 7c ce 0e 3c 0e ce 7c ; 03369:  00 7c ce 0e 3c 0e ce 7c
            hex 00 7c ce 0e 3c 0e ce 7c ; 03371:  00 7c ce 0e 3c 0e ce 7c
            hex 00 0c 1c 2c 4c fe 0c 0c ; 03379:  00 0c 1c 2c 4c fe 0c 0c
            hex 00 0c 1c 2c 4c fe 0c 0c ; 03381:  00 0c 1c 2c 4c fe 0c 0c
            hex 00 fe c0 fc ce 0e ce 7c ; 03389:  00 fe c0 fc ce 0e ce 7c
            hex 00 fe c0 fc ce 0e ce 7c ; 03391:  00 fe c0 fc ce 0e ce 7c

            brk                         ; 03399:  00
            hex 3c                      ; 0339A:  3c
            rts                         ; 0339B:  60

            hex fc ce ce ce 7c          ; 0339C:  fc ce ce ce 7c

            brk                         ; 033A1:  00
            hex 3c                      ; 033A2:  3c
            rts                         ; 033A3:  60

tab_b0_b3a4: ; 85 bytes
            hex fc ce ce ce 7c 00 fe c6 ; 033A4:  fc ce ce ce 7c 00 fe c6
            hex 0c 1c 38 38 38 00 fe c6 ; 033AC:  0c 1c 38 38 38 00 fe c6
            hex 0c 1c 38 38 38 00 7c ce ; 033B4:  0c 1c 38 38 38 00 7c ce
            hex ce 7c ce ce 7c 00 7c ce ; 033BC:  ce 7c ce ce 7c 00 7c ce
            hex ce 7c ce ce 7c 00 7c ce ; 033C4:  ce 7c ce ce 7c 00 7c ce
            hex ce ce 7e 0e 7c 00 7c ce ; 033CC:  ce ce 7e 0e 7c 00 7c ce
            hex ce ce 7e 0e 7c 00 00 18 ; 033D4:  ce ce 7e 0e 7c 00 00 18
            hex 18 00 00 18 18 00 00 18 ; 033DC:  18 00 00 18 18 00 00 18
            hex 18 00 00 18 18 00 03 0f ; 033E4:  18 00 00 18 18 00 03 0f
            hex 3f 7f 3f 0f 03 00 03 0f ; 033EC:  3f 7f 3f 0f 03 00 03 0f
            hex 3f 7f 3f 0f 03          ; 033F4:  3f 7f 3f 0f 03

            brk                         ; 033F9:  00
            hex 60                      ; 033FA:  60
            sei                         ; 033FB:  78
            ror $7e7f,x                 ; 033FC:  7e 7f 7e
            sei                         ; 033FF:  78
            rts                         ; 03400:  60

            brk                         ; 03401:  00
            hex 60                      ; 03402:  60
            sei                         ; 03403:  78
            ror $7e7f,x                 ; 03404:  7e 7f 7e
            sei                         ; 03407:  78
            rts                         ; 03408:  60

            hex 00 3c 66 66 0c 18 00 18 ; 03409:  00 3c 66 66 0c 18 00 18
            hex 00 3c 66 66 0c 18 00 18 ; 03411:  00 3c 66 66 0c 18 00 18
            hex 00 38 7c ce ce fe ce ce ; 03419:  00 38 7c ce ce fe ce ce
            hex 00 38 7c ce ce fe ce ce ; 03421:  00 38 7c ce ce fe ce ce
            hex 00 fc ce ce fc ce ce fc ; 03429:  00 fc ce ce fc ce ce fc
            hex 00 fc ce ce fc ce ce fc ; 03431:  00 fc ce ce fc ce ce fc
            hex 00 7c e6 e6 e0 e6 e6 7c ; 03439:  00 7c e6 e6 e0 e6 e6 7c
            hex 00 7c e6 e6 e0 e6 e6 7c ; 03441:  00 7c e6 e6 e0 e6 e6 7c
            hex 00 fc ce ce ce ce ce fc ; 03449:  00 fc ce ce ce ce ce fc
            hex 00 fc ce ce ce ce ce fc ; 03451:  00 fc ce ce ce ce ce fc
            hex 00 fe e0 e0 fc e0 e0 fe ; 03459:  00 fe e0 e0 fc e0 e0 fe
            hex 00 fe e0 e0 fc e0 e0 fe ; 03461:  00 fe e0 e0 fc e0 e0 fe
            hex 00 fe e0 e0 fc e0 e0 e0 ; 03469:  00 fe e0 e0 fc e0 e0 e0
            hex 00 fe e0 e0 fc e0 e0 e0 ; 03471:  00 fe e0 e0 fc e0 e0 e0
            hex 00 7c e6 e0 ee e6 e6 7c ; 03479:  00 7c e6 e0 ee e6 e6 7c
            hex 00 7c e6 e0 ee e6 e6 7c ; 03481:  00 7c e6 e0 ee e6 e6 7c
            hex 00 ce ce ce fe ce ce ce ; 03489:  00 ce ce ce fe ce ce ce
            hex 00 ce ce ce fe ce ce ce ; 03491:  00 ce ce ce fe ce ce ce
            hex 00 1c 1c 1c 1c 1c 1c 1c ; 03499:  00 1c 1c 1c 1c 1c 1c 1c
            hex 00 1c 1c 1c 1c 1c 1c 1c ; 034A1:  00 1c 1c 1c 1c 1c 1c 1c
            hex 00 0e 0e 0e 0e ee ee 7c ; 034A9:  00 0e 0e 0e 0e ee ee 7c
            hex 00 0e 0e 0e 0e ee ee 7c ; 034B1:  00 0e 0e 0e 0e ee ee 7c
            hex 00 e6 ec f8 f8 ec ee e6 ; 034B9:  00 e6 ec f8 f8 ec ee e6
            hex 00 e6 ec f8 f8 ec ee e6 ; 034C1:  00 e6 ec f8 f8 ec ee e6
            hex 00 e0 e0 e0 e0 e0 e0 fe ; 034C9:  00 e0 e0 e0 e0 e0 e0 fe
            hex 00 e0 e0 e0 e0 e0 e0 fe ; 034D1:  00 e0 e0 e0 e0 e0 e0 fe
            hex 00 c6 ee fe fe fe d6 c6 ; 034D9:  00 c6 ee fe fe fe d6 c6
            hex 00 c6 ee fe fe fe d6 c6 ; 034E1:  00 c6 ee fe fe fe d6 c6
            hex 00 66 76 7e 7e 7e 6e 66 ; 034E9:  00 66 76 7e 7e 7e 6e 66
            hex 00 66 76 7e 7e 7e 6e 66 ; 034F1:  00 66 76 7e 7e 7e 6e 66
            hex 00 7c ce ce ce ce ce 7c ; 034F9:  00 7c ce ce ce ce ce 7c
            hex 00 7c ce ce ce ce ce 7c ; 03501:  00 7c ce ce ce ce ce 7c
            hex 00 fc ce ce ce fc c0 c0 ; 03509:  00 fc ce ce ce fc c0 c0
            hex 00 fc ce ce ce fc c0 c0 ; 03511:  00 fc ce ce ce fc c0 c0
            hex 00 7c ce ce ce de cc 76 ; 03519:  00 7c ce ce ce de cc 76
            hex 00 7c ce ce ce de cc 76 ; 03521:  00 7c ce ce ce de cc 76
            hex 00 fc ce ce ce fc ce ce ; 03529:  00 fc ce ce ce fc ce ce
            hex 00 fc ce ce ce fc ce ce ; 03531:  00 fc ce ce ce fc ce ce
            hex 00 7c e6 e0 7c 0e ce 7c ; 03539:  00 7c e6 e0 7c 0e ce 7c
            hex 00 7c e6 e0 7c          ; 03541:  00 7c e6 e0 7c

            asl $7cce                   ; 03546:  0e ce 7c
            brk                         ; 03549:  00
            hex fe                      ; 0354A:  fe
            sec                         ; 0354B:  38
            sec                         ; 0354C:  38
            sec                         ; 0354D:  38
            sec                         ; 0354E:  38
            sec                         ; 0354F:  38
            sec                         ; 03550:  38
            brk                         ; 03551:  00
            hex fe                      ; 03552:  fe
            sec                         ; 03553:  38
            sec                         ; 03554:  38
            sec                         ; 03555:  38
            sec                         ; 03556:  38
            sec                         ; 03557:  38
            sec                         ; 03558:  38
            brk                         ; 03559:  00
            hex ce                      ; 0355A:  ce
            dec $cece                   ; 0355B:  ce ce ce
            dec $7cce                   ; 0355E:  ce ce 7c
            brk                         ; 03561:  00
            hex ce                      ; 03562:  ce
            dec $cece                   ; 03563:  ce ce ce
            dec $7cce                   ; 03566:  ce ce 7c
            brk                         ; 03569:  00
            hex c6                      ; 0356A:  c6
            dec $c6                     ; 0356B:  c6 c6
            jmp ($386c)                 ; 0356D:  6c 6c 38

            sec                         ; 03570:  38
            brk                         ; 03571:  00
            hex c6                      ; 03572:  c6
            dec $c6                     ; 03573:  c6 c6
            jmp ($386c)                 ; 03575:  6c 6c 38

            sec                         ; 03578:  38
            brk                         ; 03579:  00
            hex b6                      ; 0357A:  b6
            ldx $b6,y                   ; 0357B:  b6 b6
            ldx $b6,y                   ; 0357D:  b6 b6
            hex fe 6c 00 ; inc $006c,x  ; 0357F:  fe 6c 00
            ldx $b6,y                   ; 03582:  b6 b6
            ldx $b6,y                   ; 03584:  b6 b6
            ldx $fe,y                   ; 03586:  b6 fe
            jmp ($c600)                 ; 03588:  6c 00 c6

            hex ee 7c 38 7c ee c6 00 c6 ; 0358B:  ee 7c 38 7c ee c6 00 c6
            hex ee 7c 38 7c             ; 03593:  ee 7c 38 7c

            hex ee c6 00 ; inc $00c6    ; 03597:  ee c6 00
            dec $c6                     ; 0359A:  c6 c6
            dec $6c                     ; 0359C:  c6 6c
            sec                         ; 0359E:  38
            sec                         ; 0359F:  38
            sec                         ; 035A0:  38
            brk                         ; 035A1:  00
            hex c6                      ; 035A2:  c6
            dec $c6                     ; 035A3:  c6 c6
            jmp ($3838)                 ; 035A5:  6c 38 38

            hex 38 00 fe 0e 1c 38 70 e0 ; 035A8:  38 00 fe 0e 1c 38 70 e0
            hex fe 00 fe 0e 1c 38 70 e0 ; 035B0:  fe 00 fe 0e 1c 38 70 e0
            hex fe 00 00 00 00 ff       ; 035B8:  fe 00 00 00 00 ff

            brk                         ; 035BE:  00
            hex 00                      ; 035BF:  00
            brk                         ; 035C0:  00
            hex 00                      ; 035C1:  00
            brk                         ; 035C2:  00
            hex 00                      ; 035C3:  00
            brk                         ; 035C4:  00
            hex ff                      ; 035C5:  ff
            brk                         ; 035C6:  00
            hex 00                      ; 035C7:  00
            brk                         ; 035C8:  00
            hex 00                      ; 035C9:  00
            clc                         ; 035CA:  18
            clc                         ; 035CB:  18
            php                         ; 035CC:  08
            bpl b0_b5cf                 ; 035CD:  10 00
b0_b5cf:    brk                         ; 035CF:  00
            hex 00                      ; 035D0:  00
            brk                         ; 035D1:  00
            hex 18                      ; 035D2:  18
            clc                         ; 035D3:  18
            php                         ; 035D4:  08
            bpl b0_b5d7                 ; 035D5:  10 00
b0_b5d7:    brk                         ; 035D7:  00
            hex 00                      ; 035D8:  00
            brk                         ; 035D9:  00
            hex 00                      ; 035DA:  00
            brk                         ; 035DB:  00
            hex 3e                      ; 035DC:  3e
            ror $76,x                   ; 035DD:  76 76
            ror $3a,x                   ; 035DF:  76 3a
            brk                         ; 035E1:  00
            hex 00                      ; 035E2:  00
            brk                         ; 035E3:  00
            hex 3e                      ; 035E4:  3e
            ror $76,x                   ; 035E5:  76 76
            ror $3a,x                   ; 035E7:  76 3a
            brk                         ; 035E9:  00
            hex 60                      ; 035EA:  60
            rts                         ; 035EB:  60

            hex 7c 6e 6e 6e 7c          ; 035EC:  7c 6e 6e 6e 7c

            brk                         ; 035F1:  00
            hex 60                      ; 035F2:  60
            rts                         ; 035F3:  60

            hex 7c 6e 6e 6e 7c          ; 035F4:  7c 6e 6e 6e 7c

            brk                         ; 035F9:  00
            hex 00                      ; 035FA:  00
            brk                         ; 035FB:  00
            hex 3c                      ; 035FC:  3c
            ror $70,x                   ; 035FD:  76 70
            ror $3c,x                   ; 035FF:  76 3c
            brk                         ; 03601:  00
            hex 00                      ; 03602:  00
            brk                         ; 03603:  00
            hex 3c                      ; 03604:  3c
            ror $70,x                   ; 03605:  76 70
            ror $3c,x                   ; 03607:  76 3c
            brk                         ; 03609:  00
            hex 06                      ; 0360A:  06
            asl $3e                     ; 0360B:  06 3e
            ror $76,x                   ; 0360D:  76 76
            ror $3e,x                   ; 0360F:  76 3e
            brk                         ; 03611:  00
            hex 06                      ; 03612:  06
            asl $3e                     ; 03613:  06 3e
            ror $76,x                   ; 03615:  76 76
            ror $3e,x                   ; 03617:  76 3e
            brk                         ; 03619:  00
            hex 00                      ; 0361A:  00
            brk                         ; 0361B:  00
            hex 3c                      ; 0361C:  3c
            ror $7e,x                   ; 0361D:  76 7e
            bvs b0_b65f                 ; 0361F:  70 3e
            brk                         ; 03621:  00
            hex 00                      ; 03622:  00
            brk                         ; 03623:  00
            hex 3c                      ; 03624:  3c
            ror $7e,x                   ; 03625:  76 7e
            bvs b0_b667                 ; 03627:  70 3e
            brk                         ; 03629:  00
            hex 1e                      ; 0362A:  1e
            sec                         ; 0362B:  38
            sec                         ; 0362C:  38
            ror $3838,x                 ; 0362D:  7e 38 38
            sec                         ; 03630:  38
            brk                         ; 03631:  00
            hex 1e                      ; 03632:  1e
            sec                         ; 03633:  38
            sec                         ; 03634:  38
            ror $3838,x                 ; 03635:  7e 38 38
            sec                         ; 03638:  38
            brk                         ; 03639:  00
            hex 00                      ; 0363A:  00
            brk                         ; 0363B:  00
            hex 3a                      ; 0363C:  3a
            ror $7e6e                   ; 0363D:  6e 6e 7e
            hex 0e 7c 00 ; asl $007c    ; 03640:  0e 7c 00
            brk                         ; 03643:  00
            hex 3a                      ; 03644:  3a
            ror $7e6e                   ; 03645:  6e 6e 7e
            asl $607c                   ; 03648:  0e 7c 60
            rts                         ; 0364B:  60

            hex 6c 7e 6e                ; 0364C:  6c 7e 6e

            hex 6e 6e 00 ; ror p1_buttons    ; 0364F:  6e 6e 00
            rts                         ; 03652:  60

            hex 60 6c 7e 6e             ; 03653:  60 6c 7e 6e

            hex 6e 6e 00 ; ror p1_buttons    ; 03657:  6e 6e 00
            sec                         ; 0365A:  38
            brk                         ; 0365B:  00
            hex 38                      ; 0365C:  38
            sec                         ; 0365D:  38
            sec                         ; 0365E:  38
b0_b65f:    sec                         ; 0365F:  38
            sec                         ; 03660:  38
            brk                         ; 03661:  00
            hex 38                      ; 03662:  38
            brk                         ; 03663:  00
            hex 38                      ; 03664:  38
            sec                         ; 03665:  38
            sec                         ; 03666:  38
b0_b667:    sec                         ; 03667:  38
            sec                         ; 03668:  38
            brk                         ; 03669:  00
            hex 38                      ; 0366A:  38
            brk                         ; 0366B:  00
            hex 38                      ; 0366C:  38
            sec                         ; 0366D:  38
            sec                         ; 0366E:  38
            sec                         ; 0366F:  38
            sec                         ; 03670:  38
            beq tab_b0_b683+40          ; 03671:  f0 38
            brk                         ; 03673:  00
            hex 38                      ; 03674:  38
            sec                         ; 03675:  38
            sec                         ; 03676:  38
            sec                         ; 03677:  38
            sec                         ; 03678:  38
            beq tab_b0_b683+88          ; 03679:  f0 60
            rts                         ; 0367B:  60

            hex 66 6c 78 7c             ; 0367C:  66 6c 78 7c

            ror ptr0_lo                     ; 03680:  66 00
            rts                         ; 03682:  60

tab_b0_b683: ; 345 bytes
            hex 60 66 6c 78 7c 66 00 38 ; 03683:  60 66 6c 78 7c 66 00 38
            hex 18 18 18 18 18 18 00 38 ; 0368B:  18 18 18 18 18 18 00 38
            hex 18 18 18 18 18 18 00 00 ; 03693:  18 18 18 18 18 18 00 00
            hex 00 b6 db db db db 00 00 ; 0369B:  00 b6 db db db db 00 00
            hex 00 b6 db db db db 00 00 ; 036A3:  00 b6 db db db db 00 00
            hex 00 6c 7e 6e 6e 6e 00 00 ; 036AB:  00 6c 7e 6e 6e 6e 00 00
            hex 00 6c 7e 6e 6e 6e 00 00 ; 036B3:  00 6c 7e 6e 6e 6e 00 00
            hex 00 3c 6e 6e 6e 3c 00 00 ; 036BB:  00 3c 6e 6e 6e 3c 00 00
            hex 00 3c 6e 6e 6e 3c 00 00 ; 036C3:  00 3c 6e 6e 6e 3c 00 00
            hex 00 7c 6e 6e 6e 7c 60 00 ; 036CB:  00 7c 6e 6e 6e 7c 60 00
            hex 00 7c 6e 6e 6e 7c 60 00 ; 036D3:  00 7c 6e 6e 6e 7c 60 00
            hex 00 3e 6e 6e 6e 3e 0e 00 ; 036DB:  00 3e 6e 6e 6e 3e 0e 00
            hex 00 3e 6e 6e 6e 3e 0e 00 ; 036E3:  00 3e 6e 6e 6e 3e 0e 00
            hex 00 76 78 70 70 70 00 00 ; 036EB:  00 76 78 70 70 70 00 00
            hex 00 76 78 70 70 70 00 00 ; 036F3:  00 76 78 70 70 70 00 00
            hex 00 3c 70 3c 0e 7c 00 00 ; 036FB:  00 3c 70 3c 0e 7c 00 00
            hex 00 3c 70 3c 0e 7c 00 00 ; 03703:  00 3c 70 3c 0e 7c 00 00
            hex 38 fe 38 38 38 38 00 00 ; 0370B:  38 fe 38 38 38 38 00 00
            hex 38 fe 38 38 38 38 00 00 ; 03713:  38 fe 38 38 38 38 00 00
            hex 00 6e 6e 6e 6e 3c 00 00 ; 0371B:  00 6e 6e 6e 6e 3c 00 00
            hex 00 6e 6e 6e 6e 3c 00 00 ; 03723:  00 6e 6e 6e 6e 3c 00 00
            hex 00 6e 6e 6e 3c 18 00 00 ; 0372B:  00 6e 6e 6e 3c 18 00 00
            hex 00 6e 6e 6e 3c 18 00 00 ; 03733:  00 6e 6e 6e 3c 18 00 00
            hex 00 db db db db 6e 00 00 ; 0373B:  00 db db db db 6e 00 00
            hex 00 db db db db 6e 00 00 ; 03743:  00 db db db db 6e 00 00
            hex 00 66 3c 18 3c 66 00 00 ; 0374B:  00 66 3c 18 3c 66 00 00
            hex 00 66 3c 18 3c 66 00 00 ; 03753:  00 66 3c 18 3c 66 00 00
            hex 00 6e 6e 6e 3e 0e 7c 00 ; 0375B:  00 6e 6e 6e 3e 0e 7c 00
            hex 00 6e 6e 6e 3e 0e 7c 00 ; 03763:  00 6e 6e 6e 3e 0e 7c 00
            hex 00 7e 1c 38 70 7e 00 00 ; 0376B:  00 7e 1c 38 70 7e 00 00
            hex 00 7e 1c 38 70 7e 00 00 ; 03773:  00 7e 1c 38 70 7e 00 00
            hex 24 7e 24 24 7e 24 00 00 ; 0377B:  24 7e 24 24 7e 24 00 00
            hex 24 7e 24 24 7e 24 00 00 ; 03783:  24 7e 24 24 7e 24 00 00
            hex 72 54 78 1e 2a 4e 00 00 ; 0378B:  72 54 78 1e 2a 4e 00 00
            hex 72 54 78 1e 2a 4e 00 00 ; 03793:  72 54 78 1e 2a 4e 00 00
            hex 10 54 38 38 54 10 00 00 ; 0379B:  10 54 38 38 54 10 00 00
            hex 10 54 38 38 54 10 00 00 ; 037A3:  10 54 38 38 54 10 00 00
            hex 00 10 10 7c 10 10 00 00 ; 037AB:  00 10 10 7c 10 10 00 00
            hex 00 10 10 7c 10 10 00 00 ; 037B3:  00 10 10 7c 10 10 00 00
            hex 00 00 00 18 18 08 10 00 ; 037BB:  00 00 00 18 18 08 10 00
            hex 00 00 00 18 18 08 10 3e ; 037C3:  00 00 00 18 18 08 10 3e
            hex 16 2a 28 3e 16 28 30 3e ; 037CB:  16 2a 28 3e 16 28 30 3e
            hex 16 28 30 3e 16 38 30 43 ; 037D3:  16 28 30 3e 16 38 30 43
            hex 6f                      ; 037DB:  6f

            ror $7267                   ; 037DC:  6e 67 72
            adc (palette_dirty,x)                 ; 037DF:  61 74
            adc $6c,x                   ; 037E1:  75 6c
            adc (palette_dirty,x)                 ; 037E3:  61 74
            adc #$6f                    ; 037E5:  69 6f
            ror $2073                   ; 037E7:  6e 73 20
            adc $2079                   ; 037EA:  6d 79 20
            jmp $726f                   ; 037ED:  4c 6f 72

            hex 64 21 0a 00 49 6e 20 74 ; 037F0:  64 21 0a 00 49 6e 20 74
            hex 68 65 20 79 65 61 72 20 ; 037F8:  68 65 20 79 65 61 72 20
            hex 25 34 64 0a 00 79 6f 75 ; 03800:  25 34 64 0a 00 79 6f 75
            hex 20 75 6e 69 74 65 64 20 ; 03808:  20 75 6e 69 74 65 64 20
            hex 4a 61 70 61 6e 21 00 47 ; 03810:  4a 61 70 61 6e 21 00 47
            hex 61 6d 65 20 6f 76 65 72 ; 03818:  61 6d 65 20 6f 76 65 72
            hex 00 57 6f 75 6c 64       ; 03820:  00 57 6f 75 6c 64

            jsr $6f79                   ; 03826:  20 79 6f
            adc $20,x                   ; 03829:  75 20
            jmp ($6b69)                 ; 0382B:  6c 69 6b

            hex 65 20 74 6f 0a 70 6c 61 ; 0382E:  65 20 74 6f 0a 70 6c 61
            hex 79 20 61 67 61 69 6e 00 ; 03836:  79 20 61 67 61 69 6e 00
            hex 54 68 61 6e 6b 73 20 66 ; 0383E:  54 68 61 6e 6b 73 20 66
            hex 6f 72 0a 70 6c 61 79 69 ; 03846:  6f 72 0a 70 6c 61 79 69
            hex 6e 67 00 00 3e 12 29 30 ; 0384E:  6e 67 00 00 3e 12 29 30
            hex 3e 02 12 21 3e 16 27 30 ; 03856:  3e 02 12 21 3e 16 27 30
            hex 3e 38 30 30 3e 16 28 30 ; 0385E:  3e 38 30 30 3e 16 28 30
            hex 3e 06 28 30 3e 18 29 30 ; 03866:  3e 06 28 30 3e 18 29 30
            hex 3e 18 01 30 3e 20 21 30 ; 0386E:  3e 18 01 30 3e 20 21 30
            hex 3e 23 24 25 3e 26 27 28 ; 03876:  3e 23 24 25 3e 26 27 28
            hex 3e 29 2a 2b 4e 65 77 20 ; 0387E:  3e 29 2a 2b 4e 65 77 20
            hex 67 61 6d 65 00 4b 4f 45 ; 03886:  67 61 6d 65 00 4b 4f 45
            hex 49 00 4e 6f 20 73 61 76 ; 0388E:  49 00 4e 6f 20 73 61 76
            hex 65 64 20 64 61 74       ; 03896:  65 64 20 64 61 74

            adc (ptr0_lo,x)                 ; 0389C:  61 00
            brk                         ; 0389E:  00
            hex 44                      ; 0389F:  44
            adc (palette_dirty,x)                 ; 038A0:  61 74
            adc ($20,x)                 ; 038A2:  61 20
            jmp ($616f)                 ; 038A4:  6c 6f 61

            hex 64 65 64 00 20 20 20 20 ; 038A7:  64 65 64 00 20 20 20 20
            hex 00 44 61 74 61 20 63    ; 038AF:  00 44 61 74 61 20 63

            adc (p1_buttons,x)                 ; 038B6:  61 6e
            rts                         ; 038B8:  60

            hex 74 20 62 65 0a 75 73 65 ; 038B9:  74 20 62 65 0a 75 73 65
            hex 64 00 25 33 64 00 00 28 ; 038C1:  64 00 25 33 64 00 00 28
            hex 31 37 66 69 65 66 73 2f ; 038C9:  31 37 66 69 65 66 73 2f
            hex 35 30 66 69 65 66 73 29 ; 038D1:  35 30 66 69 65 66 73 29
            hex 0a 3f 20 00 57 61 74 63 ; 038D9:  0a 3f 20 00 57 61 74 63
            hex 68 20 6f 74 68 65 72 0a ; 038E1:  68 20 6f 74 68 65 72 0a
            hex 64 61 69 6d 79 6f 73 20 ; 038E9:  64 61 69 6d 79 6f 73 20
            hex 62 61 74 74 6c 65 00 50 ; 038F1:  62 61 74 74 6c 65 00 50
            hex 6c 61 79 65 72 20 00 25 ; 038F9:  6c 61 79 65 72 20 00 25
            hex 64 2c 20 77 68 69 63 68 ; 03901:  64 2c 20 77 68 69 63 68
            hex 0a 66 69 65 66 20 77 6f ; 03909:  0a 66 69 65 66 20 77 6f
            hex 75 6c 64                ; 03911:  75 6c 64

            jsr $6f79                   ; 03914:  20 79 6f
            adc $0a,x                   ; 03917:  75 0a
            jmp ($6b69)                 ; 03919:  6c 69 6b

            hex 65 20 74 6f             ; 0391C:  65 20 74 6f

            jsr $7572                   ; 03920:  20 72 75
            jmp ($0065)                 ; 03923:  6c 65 00

            hex 49 73 20 00 20 6f 66 0a ; 03926:  49 73 20 00 20 6f 66 0a
            hex 66 69 65 66 20 25 32 64 ; 0392E:  66 69 65 66 20 25 32 64
            hex 20 4f 4b 00 54 68 61 74 ; 03936:  20 4f 4b 00 54 68 61 74
            hex 20 64 61 69 6d 79 6f 20 ; 0393E:  20 64 61 69 6d 79 6f 20
            hex 69 73 0a 61 6c 72 65 61 ; 03946:  69 73 0a 61 6c 72 65 61
            hex 64 79 20 74 61 6b 65 6e ; 0394E:  64 79 20 74 61 6b 65 6e
            hex 00 46 69 65 66 20 25 32 ; 03956:  00 46 69 65 66 20 25 32
            hex 64 00 41 67 65 2d 25 32 ; 0395E:  64 00 41 67 65 2d 25 32
            hex 64                      ; 03966:  64

            and $5000                   ; 03967:  2d 00 50
            jmp ($6165)                 ; 0396A:  6c 65 61

            hex 73 65 20 73 65 74 00 64 ; 0396D:  73 65 20 73 65 74 00 64
            hex 61 69 6d 79 6f 20 61 62 ; 03975:  61 69 6d 79 6f 20 61 62
            hex 69 6c 69 74 69 65 73 00 ; 0397D:  69 6c 69 74 69 65 73 00
            hex 50 72 65 73 73 20 61 6e ; 03985:  50 72 65 73 73 20 61 6e
            hex 79 20 62 75 74 74 6f 6e ; 0398D:  79 20 62 75 74 74 6f 6e
            hex 00 74 6f 20 73 65 74 20 ; 03995:  00 74 6f 20 73 65 74 20
            hex 61 62 69 6c 69 74 69 65 ; 0399D:  61 62 69 6c 69 74 69 65
            hex 73 00 2d 20 20 20 2d 00 ; 039A5:  73 00 2d 20 20 20 2d 00
            hex 54 6f 74 61 6c 20 20 25 ; 039AD:  54 6f 74 61 6c 20 20 25
            hex 34 64 00 49 73 20 74 68 ; 039B5:  34 64 00 49 73 20 74 68
            hex 69 73 20 4f 4b 00 43 6f ; 039BD:  69 73 20 4f 4b 00 43 6f
            hex 6e 74 72 6f 6c 20 31 00 ; 039C5:  6e 74 72 6f 6c 20 31 00
            hex 48 6f 77 20 6d 61 6e 79 ; 039CD:  48 6f 77 20 6d 61 6e 79
            hex 20 70 6c 61 79 65 72 73 ; 039D5:  20 70 6c 61 79 65 72 73

            brk                         ; 039DD:  00
            hex 50                      ; 039DE:  50
            jmp ($6165)                 ; 039DF:  6c 65 61

            hex 73 65 20 73 65 6c 65 63 ; 039E2:  73 65 20 73 65 6c 65 63
            hex 74 0a 73 6b             ; 039EA:  74 0a 73 6b

            adc #$6c                    ; 039EE:  69 6c
            jmp ($6c20)                 ; 039F0:  6c 20 6c

            hex 65 76 65 6c 00 49 73 20 ; 039F3:  65 76 65 6c 00 49 73 20
            hex 65 76 65 72 79 74 68 69 ; 039FB:  65 76 65 72 79 74 68 69
            hex 6e 67 20 4f 4b 0a 73 6f ; 03A03:  6e 67 20 4f 4b 0a 73 6f
            hex 20 66 61 72 00 54 68 65 ; 03A0B:  20 66 61 72 00 54 68 65
            hex 6e 20 6f 6e 20 77 69 74 ; 03A13:  6e 20 6f 6e 20 77 69 74
            hex 68 20 74 68 65 0a 67 61 ; 03A1B:  68 20 74 68 65 0a 67 61
            hex 6d 65 21 00 00 50 69 72 ; 03A23:  6d 65 21 00 00 50 69 72
            hex 61 74 65 73 20 00 43 68 ; 03A2B:  61 74 65 73 20 00 43 68
            hex 72 69 73 74 6e 73 00 52 ; 03A33:  72 69 73 74 6e 73 00 52
            hex 69 6f 74 65 72 73       ; 03A3B:  69 6f 74 65 72 73

            jsr $5a00                   ; 03A41:  20 00 5a
            adc $61                     ; 03A44:  65 61
            jmp ($746f)                 ; 03A46:  6c 6f 74

            hex 73 20 00 4d 6f 6e 6b 73 ; 03A49:  73 20 00 4d 6f 6e 6b 73
            hex 20 20 20 00 52 65 62 65 ; 03A51:  20 20 20 00 52 65 62 65
            hex 6c 73 20 20 00 00 0a 57 ; 03A59:  6c 73 20 20 00 00 0a 57
            hex 6f 75 6c 64             ; 03A61:  6f 75 6c 64

            jsr $6f79                   ; 03A65:  20 79 6f
            adc $20,x                   ; 03A68:  75 20
            jmp ($6b69)                 ; 03A6A:  6c 69 6b

            hex 65 20 74 6f 0a 62 69 64 ; 03A6D:  65 20 74 6f 0a 62 69 64
            hex 20 66 6f 72 20 66 69 65 ; 03A75:  20 66 6f 72 20 66 69 65
            hex 66 20 25 32 64 00 48 6f ; 03A7D:  66 20 25 32 64 00 48 6f
            hex 77 20 6d 75 63 68 00 00 ; 03A85:  77 20 6d 75 63 68 00 00
            hex 0a 46 69 65 66 20 25 32 ; 03A8D:  0a 46 69 65 66 20 25 32
            hex 64 20 69 73 20 79 6f 75 ; 03A95:  64 20 69 73 20 79 6f 75
            hex 72 73 21 00 46 69 65 66 ; 03A9D:  72 73 21 00 46 69 65 66
            hex 20 00 25 32 64 20 69 73 ; 03AA5:  20 00 25 32 64 20 69 73
            hex 20 6e 6f 77 0a 00 60 73 ; 03AAD:  20 6e 6f 77 0a 00 60 73
            hex 0a 74 65 72 72 69 74 6f ; 03AB5:  0a 74 65 72 72 69 74 6f
            hex 72 79 00 49 6e 20 66 69 ; 03ABD:  72 79 00 49 6e 20 66 69
            hex 65 66 20 00 25 64 2c 0a ; 03AC5:  65 66 20 00 25 64 2c 0a
            hex 0a 00 4c 6f 79 61 6c 73 ; 03ACD:  0a 00 4c 6f 79 61 6c 73
            hex 0a 20 20 20 20 20 20 20 ; 03AD5:  0a 20 20 20 20 20 20 20
            hex 20 20 20 25 34 64 20 6d ; 03ADD:  20 20 20 25 34 64 20 6d
            hex 65 6e 0a 25 73 0a 20 20 ; 03AE5:  65 6e 0a 25 73 0a 20 20
            hex 20 20 20 20 20 20 20 20 ; 03AED:  20 20 20 20 20 20 20 20
            hex 25 34 64 20 6d 65 6e 00 ; 03AF5:  25 34 64 20 6d 65 6e 00
            hex 00 25 73 20 68 61 76 65 ; 03AFD:  00 25 73 20 68 61 76 65
            hex 20 77 6f 6e 21 00 54    ; 03B05:  20 77 6f 6e 21 00 54

            pla                         ; 03B0C:  68
            adc $20                     ; 03B0D:  65 20
            jmp ($796f)                 ; 03B0F:  6c 6f 79

            hex 61 6c 20 66 6f 72 63 65 ; 03B12:  61 6c 20 66 6f 72 63 65
            hex 73 0a 68 61 76 65 20 77 ; 03B1A:  73 0a 68 61 76 65 20 77
            hex 6f 6e 21 00 00 0a 74 68 ; 03B22:  6f 6e 21 00 00 0a 74 68
            hex 65 20 70 65 6f 70 6c 65 ; 03B2A:  65 20 70 65 6f 70 6c 65
            hex 20 61 72 65 0a 72       ; 03B32:  20 61 72 65 0a 72

            adc $62                     ; 03B38:  65 62
            adc $6c                     ; 03B3A:  65 6c
            jmp ($6e69)                 ; 03B3C:  6c 69 6e

            hex 67 21 20 57             ; 03B3F:  67 21 20 57

            adc #$6c                    ; 03B43:  69 6c
            jmp ($790a)                 ; 03B45:  6c 0a 79

            hex 6f 75 20 61 70 70 65 61 ; 03B48:  6f 75 20 61 70 70 65 61
            hex 73 65 20 74 68 65 6d 0a ; 03B50:  73 65 20 74 68 65 6d 0a
            hex 77                      ; 03B58:  77

            adc #$74                    ; 03B59:  69 74
            pla                         ; 03B5B:  68
            jsr $6f67                   ; 03B5C:  20 67 6f
            jmp ($0064)                 ; 03B5F:  6c 64 00

            hex 47 69 76 69 6e 67       ; 03B62:  47 69 76 69 6e 67

            jsr $6c61                   ; 03B68:  20 61 6c
            jmp ($6f20)                 ; 03B6B:  6c 20 6f

            hex 66 20 69 74 0a 00 49 74 ; 03B6E:  66 20 69 74 0a 00 49 74
            hex 20 64 69 64 6e 60 74 20 ; 03B76:  20 64 69 64 6e 60 74 20
            hex 77 6f 72 6b 21 00 54 68 ; 03B7E:  77 6f 72 6b 21 00 54 68
            hex 65 79 20 61 70 70 65 61 ; 03B86:  65 79 20 61 70 70 65 61
            hex 72 20 74 6f 0a 68 61 76 ; 03B8E:  72 20 74 6f 0a 68 61 76
            hex 65 20 73 65 74 74 6c 65 ; 03B96:  65 20 73 65 74 74 6c 65
            hex 64 20 64 6f 77 6e 00 a9 ; 03B9E:  64 20 64 6f 77 6e 00 a9
            hex bb b1 bb 6f 6c 64 20 61 ; 03BA6:  bb b1 bb 6f 6c 64 20 61
            hex 67 65 00 73 69 63 6b 6e ; 03BAE:  67 65 00 73 69 63 6b 6e
            hex 65 73 73 00 20 64 69 65 ; 03BB6:  65 73 73 00 20 64 69 65
            hex 64 20 6f 66 0a 25 73 00 ; 03BBE:  64 20 6f 66 0a 25 73 00
            hex 00 0a 73 6f 6d 65 6f 6e ; 03BC6:  00 0a 73 6f 6d 65 6f 6e
            hex 65 20 68 61 73 20 73 65 ; 03BCE:  65 20 68 61 73 20 73 65
            hex 6e 74 0a 6e 69 6e 6a 61 ; 03BD6:  6e 74 0a 6e 69 6e 6a 61
            hex 20 61 67 69 6e 73 74 0a ; 03BDE:  20 61 67 69 6e 73 74 0a
            hex 66 69 65 66 20 00 25 32 ; 03BE6:  66 69 65 66 20 00 25 32
            hex 64 21 00 53 75 6d 6d 65 ; 03BEE:  64 21 00 53 75 6d 6d 65
            hex 72 20 74 68 69 73 20 79 ; 03BF6:  72 20 74 68 69 73 20 79
            hex 65 61 72 0a 62 72 69 6e ; 03BFE:  65 61 72 0a 62 72 69 6e
            hex 67 73 20 74 79 70 68 6f ; 03C06:  67 73 20 74 79 70 68 6f
            hex 6f 6e 73 21 00 4c 6f 72 ; 03C0E:  6f 6e 73 21 00 4c 6f 72
            hex 64                      ; 03C16:  64

            bit $700a                   ; 03C17:  2c 0a 70
b0_bc1a:    jmp ($6761)                 ; 03C1A:  6c 61 67

            hex 75 65 20 68 61 73 20 63 ; 03C1D:  75 65 20 68 61 73 20 63
            hex 6f 6d 65 21 00 00 0a 61 ; 03C25:  6f 6d 65 21 00 00 0a 61
            hex 20 74 79 70 68 6f 6f 6e ; 03C2D:  20 74 79 70 68 6f 6f 6e
            hex 20 68 61 73 0a 73 74 72 ; 03C35:  20 68 61 73 0a 73 74 72
            hex 75 63 6b 20 66 69 65 66 ; 03C3D:  75 63 6b 20 66 69 65 66
            hex 20 25 32 64 21 00 00 0a ; 03C45:  20 25 32 64 21 00 00 0a
            hex 70 6c 61 67 75 65 20 68 ; 03C4D:  70 6c 61 67 75 65 20 68
            hex 61 73 20 63 6f 6d 65 0a ; 03C55:  61 73 20 63 6f 6d 65 0a
            hex 74 6f 20 66 69 65 66 20 ; 03C5D:  74 6f 20 66 69 65 66 20
            hex 25 32 64 21 00 49 6e 20 ; 03C65:  25 32 64 21 00 49 6e 20
            hex 66 69 65 66 20 00 25 32 ; 03C6D:  66 69 65 66 20 00 25 32
            hex 64                      ; 03C75:  64

            bit $0a00                   ; 03C76:  2c 00 0a
            asl a                       ; 03C79:  0a
            jmp $796f                   ; 03C7A:  4c 6f 79

            hex 61 6c 73 0a 20 20 20 20 ; 03C7D:  61 6c 73 0a 20 20 20 20
            hex 20 20 20 20 20 20 25 34 ; 03C85:  20 20 20 20 20 20 25 34
            hex 64 20 6d 65 6e 0a 52 65 ; 03C8D:  64 20 6d 65 6e 0a 52 65
            hex 62 65 6c 73 0a 20 20 20 ; 03C95:  62 65 6c 73 0a 20 20 20
            hex 20 20 20 20 20 20 20 25 ; 03C9D:  20 20 20 20 20 20 20 25
            hex 34 64 20 6d 65 6e 00 42 ; 03CA5:  34 64 20 6d 65 6e 00 42
            hex 65 77 61 72 65 21 0a 41 ; 03CAD:  65 77 61 72 65 21 0a 41
            hex 20 74 72 65 61 63 68 65 ; 03CB5:  20 74 72 65 61 63 68 65
            hex 72 6f 75 73 0a 73 75 62 ; 03CBD:  72 6f 75 73 0a 73 75 62
            hex 6f 72 64 69 6e 61 74 65 ; 03CC5:  6f 72 64 69 6e 61 74 65
            hex 20 68 61 73 0a 72 61 69 ; 03CCD:  20 68 61 73 0a 72 61 69
            hex 73 65 64 20 61 6e 20 61 ; 03CD5:  73 65 64 20 61 6e 20 61
            hex 72 6d 79 20 74 6f 0a 64 ; 03CDD:  72 6d 79 20 74 6f 0a 64
            hex 65 73 74 72 6f 79 20 79 ; 03CE5:  65 73 74 72 6f 79 20 79
            hex 6f 75 21 00 54 68 65 20 ; 03CED:  6f 75 21 00 54 68 65 20
            hex 72 65 62 65 6c 73 20 68 ; 03CF5:  72 65 62 65 6c 73 20 68
            hex 61 76 65 0a 77 6f 6e 21 ; 03CFD:  61 76 65 0a 77 6f 6e 21
            hex 00 54                   ; 03D05:  00 54

            pla                         ; 03D07:  68
            adc $20                     ; 03D08:  65 20
            jmp ($796f)                 ; 03D0A:  6c 6f 79

            hex 61 6c 20 6d 65 6e 0a 68 ; 03D0D:  61 6c 20 6d 65 6e 0a 68
            hex 61 76 65 20 77 6f 6e 21 ; 03D15:  61 76 65 20 77 6f 6e 21
            hex 00 41 6b 65 63 68 69 20 ; 03D1D:  00 41 6b 65 63 68 69 20
            hex 4d 69 74 73 75 68 69 64 ; 03D25:  4d 69 74 73 75 68 69 64
            hex 65 20 66 61 69 6c 65 64 ; 03D2D:  65 20 66 61 69 6c 65 64
            hex 20 74 6f 0a 74 61 6b 65 ; 03D35:  20 74 6f 0a 74 61 6b 65
            hex 20 79 6f 75 72 20 6c 69 ; 03D3D:  20 79 6f 75 72 20 6c 69
            hex 66 65 20 61 6e 64       ; 03D45:  66 65 20 61 6e 64

            jsr $6977                   ; 03D4B:  20 77 69
            jmp ($206c)                 ; 03D4E:  6c 6c 20

            hex 70 61 79 21 00 4e 6f 62 ; 03D51:  70 61 79 21 00 4e 6f 62
            hex 75 6e 61 67 61 20 00 68 ; 03D59:  75 6e 61 67 61 20 00 68
            hex 61 73 20 62 65 65 6e 20 ; 03D61:  61 73 20 62 65 65 6e 20
            hex 64 65 73 74 72 6f 79 65 ; 03D69:  64 65 73 74 72 6f 79 65
            hex 64 2c 0a 62 75 74 20 69 ; 03D71:  64 2c 0a 62 75 74 20 69
            hex 6e 20 74 68 65 20 72 6f ; 03D79:  6e 20 74 68 65 20 72 6f
            hex 6c 65 20 6f 66 0a 00 48 ; 03D81:  6c 65 20 6f 66 0a 00 48
            hex 61 73 68 69 62 61 20 48 ; 03D89:  61 73 68 69 62 61 20 48
            hex 69 64 65 79 6f 73 68 69 ; 03D91:  69 64 65 79 6f 73 68 69
            hex 2c 0a 00 4e 6f 62 75 6e ; 03D99:  2c 0a 00 4e 6f 62 75 6e
            hex 61 67 61 60 73 20 6c 6f ; 03DA1:  61 67 61 60 73 20 6c 6f
            hex 79 61 6c 0a 73 75 62 6f ; 03DA9:  79 61 6c 0a 73 75 62 6f
            hex 72 64 69 6e 61 74 65 2c ; 03DB1:  72 64 69 6e 61 74 65 2c
            hex 20 79 6f 75 20 6d 61 79 ; 03DB9:  20 79 6f 75 20 6d 61 79
            hex 0a 63 6f 6e 74 69 6e 75 ; 03DC1:  0a 63 6f 6e 74 69 6e 75
            hex 65 20 74 6f 20 77 6f 72 ; 03DC9:  65 20 74 6f 20 77 6f 72
            hex 6b 20 66 6f 72 0a 00 4e ; 03DD1:  6b 20 66 6f 72 0a 00 4e
            hex 6f 62 75 6e 61 67 61 60 ; 03DD9:  6f 62 75 6e 61 67 61 60
            hex 73 20 61 6d 62 69 74 69 ; 03DE1:  73 20 61 6d 62 69 74 69
            hex 6f 6e 20 6f 66 20 61 0a ; 03DE9:  6f 6e 20 6f 66 20 61 0a
            hex 75 6e 69 74 65 64 20 4a ; 03DF1:  75 6e 69 74 65 64 20 4a
            hex 61 70 61 6e 00 0a 77    ; 03DF9:  61 70 61 6e 00 0a 77

            adc #$6c                    ; 03E00:  69 6c
            jmp ($7920)                 ; 03E02:  6c 20 79

            hex 6f                      ; 03E05:  6f

            adc $20,x                   ; 03E06:  75 20
            adc ($6c,x)                 ; 03E08:  61 6c
            jmp ($2079)                 ; 03E0A:  6c 79 20

            hex 77 69 74 68 0a 66 69 65 ; 03E0D:  77 69 74 68 0a 66 69 65
            hex 66 20 25 32 64 20 66 6f ; 03E15:  66 20 25 32 64 20 66 6f
            hex 72 20 25 34 64 0a 75 6e ; 03E1D:  72 20 25 34 64 0a 75 6e
            hex 69 74 73                ; 03E25:  69 74 73

            jsr $666f                   ; 03E28:  20 6f 66
            jsr $6f67                   ; 03E2B:  20 67 6f
            jmp ($0064)                 ; 03E2E:  6c 64 00

            hex 54 68 69 73 20 70 61 63 ; 03E31:  54 68 69 73 20 70 61 63
            hex 74 20 64 6f 65 73 6e 60 ; 03E39:  74 20 64 6f 65 73 6e 60
            hex 74 0a 6d 65 61 6e 20 79 ; 03E41:  74 0a 6d 65 61 6e 20 79
            hex 6f 75 20 63 61 6e 0a 72 ; 03E49:  6f 75 20 63 61 6e 0a 72
            hex 65 6c 61 78 21 00 57 68 ; 03E51:  65 6c 61 78 21 00 57 68
            hex 6f 20 6e 65 65 64 73    ; 03E59:  6f 20 6e 65 65 64 73

            jsr $6977                   ; 03E60:  20 77 69
            adc $7370                   ; 03E63:  6d 70 73
            asl a                       ; 03E66:  0a
            jmp ($6b69)                 ; 03E67:  6c 69 6b

            hex 65 20 68 69 6d 20 61 6e ; 03E6A:  65 20 68 69 6d 20 61 6e
            hex 79 77 61 79 3f 00 0a 57 ; 03E72:  79 77 61 79 3f 00 0a 57

            adc #$6c                    ; 03E7A:  69 6c
            jmp ($7920)                 ; 03E7C:  6c 20 79

            hex 6f 75 20 61 63 63 65 70 ; 03E7F:  6f 75 20 61 63 63 65 70
            hex 74 0a 25 34 64 20 75 6e ; 03E87:  74 0a 25 34 64 20 75 6e
            hex 69 74 73                ; 03E8F:  69 74 73

            jsr $666f                   ; 03E92:  20 6f 66
            jsr $6f67                   ; 03E95:  20 67 6f
            jmp ($0a64)                 ; 03E98:  6c 64 0a

            hex 66 72 6f 6d 20 66 69 65 ; 03E9B:  66 72 6f 6d 20 66 69 65
            hex 66 20 25 32 64 20 66 6f ; 03EA3:  66 20 25 32 64 20 66 6f
            hex 72 0a 74 68 65 20 70 72 ; 03EAB:  72 0a 74 68 65 20 70 72
            hex 69 6e 63 65 73 73 00 79 ; 03EB3:  69 6e 63 65 73 73 00 79
            hex 6f 75 60 76 65 20 6c 6f ; 03EBB:  6f 75 60 76 65 20 6c 6f
            hex 73 74 20 61 0a 64 61 75 ; 03EC3:  73 74 20 61 0a 64 61 75
            hex 67 68 74 65 72 20 62 75 ; 03ECB:  67 68 74 65 72 20 62 75
            hex 74 0a 67 61 69 6e 65 64 ; 03ED3:  74 0a 67 61 69 6e 65 64
            hex 20 61 0a 73 6f 6e 2d 69 ; 03EDB:  20 61 0a 73 6f 6e 2d 69
            hex 6e 2d 6c 61 77 00 54 68 ; 03EE3:  6e 2d 6c 61 77 00 54 68
            hex 65 20 70 72 69 6e 63 65 ; 03EEB:  65 20 70 72 69 6e 63 65
            hex 73 73 20 77 61 73 0a 74 ; 03EF3:  73 73 20 77 61 73 0a 74
            hex 6f 6f 20 67 6f 6f 64 20 ; 03EFB:  6f 6f 20 67 6f 6f 64 20
            hex 66 6f 72 20 68 69 6d 00 ; 03F03:  66 6f 72 20 68 69 6d 00
            hex 52 69 6f 74 00 52 65 76 ; 03F0B:  52 69 6f 74 00 52 65 76
            hex 6f 6c 74 00 4b 4f 45 49 ; 03F13:  6f 6c 74 00 4b 4f 45 49
            hex 00 00 44 61 74 61 20 68 ; 03F1B:  00 00 44 61 74 61 20 68
            hex 61 73 20 62 65 65 6e 0a ; 03F23:  61 73 20 62 65 65 6e 0a
            hex 73 61 76 65 64 00 20 68 ; 03F2B:  73 61 76 65 64 00 20 68
            hex 61 73 0a 74             ; 03F33:  61 73 0a 74

            adc ($6b,x)                 ; 03F37:  61 6b
            adc p1_buttons                     ; 03F39:  65 6e
            jsr $6c69                   ; 03F3B:  20 69 6c
            jmp ($4400)                 ; 03F3E:  6c 00 44

            adc #$73                    ; 03F41:  69 73
            jmp ($796f)                 ; 03F43:  6c 6f 79

            hex 61 6c 20 74 72 6f 6f 70 ; 03F46:  61 6c 20 74 72 6f 6f 70
            hex 73 0a 68 61 76 65 20 72 ; 03F4E:  73 0a 68 61 76 65 20 72
            hex 65 76 6f 6c 74 65 64 00 ; 03F56:  65 76 6f 6c 74 65 64 00
            hex ff ff ff ff ff ff ff ff ; 03F5E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F66:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F6E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F76:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F7E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F86:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F8E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F96:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03F9E:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FA6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FAE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FB6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FBE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FC6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FCE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FD6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FDE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FE6:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FEE:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 03FF6:  ff ff ff ff ff ff ff ff
            hex ff ff                   ; 03FFE:  ff ff

