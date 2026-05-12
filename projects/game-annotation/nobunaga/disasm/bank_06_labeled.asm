.base $8000

tab_b6_8000: ; 77 bytes
            hex 4c 00 00 00 4d 4d 4d 4d ; 18000:  4c 00 00 00 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18008:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18010:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18018:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4e 4f ; 18020:  4d 4d 4d 4d 4d 4d 4e 4f
            hex 4d 52 4d 4d 4d 4d 4d 4d ; 18028:  4d 52 4d 4d 4d 4d 4d 4d
            hex 4d 4d 5c 4d 4d 5f 4d 4d ; 18030:  4d 4d 5c 4d 4d 5f 4d 4d
            hex 4d 4d 66 67 6a 6b 6e 6f ; 18038:  4d 4d 66 67 6a 6b 6e 6f
            hex 72 4d 4d 4d 4d 4d 50 51 ; 18040:  72 4d 4d 4d 4d 4d 50 51
            hex 53 54 55 56 57          ; 18048:  53 54 55 56 57

            cli                         ; 1804D:  58
            eor $5b5a,y                 ; 1804E:  59 5a 5b
            eor $5e5d                   ; 18051:  4d 5d 5e
            rts                         ; 18054:  60

tab_b6_8055: ; 639 bytes
            hex 61 62 63 64 65 68 69 6c ; 18055:  61 62 63 64 65 68 69 6c
            hex 6d 70 71 73 4d 4d 4d 4d ; 1805D:  6d 70 71 73 4d 4d 4d 4d
            hex 4d 74 75 76 77 78 79 7a ; 18065:  4d 74 75 76 77 78 79 7a
            hex 7b 7d 7e 80 81 82 83 84 ; 1806D:  7b 7d 7e 80 81 82 83 84
            hex 85 86 87 88 89 8a 4d 8b ; 18075:  85 86 87 88 89 8a 4d 8b
            hex 4d 8d 8e 4d 4d 4d 4d 4d ; 1807D:  4d 8d 8e 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18085:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 7c 7f 4d 4d 4d 4d 4d 4d ; 1808D:  7c 7f 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 8c ; 18095:  4d 4d 4d 4d 4d 4d 4d 8c
            hex 4d 8f 4d 4d 4d 4d 4d 4d ; 1809D:  4d 8f 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 180A5:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 180AD:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 90 ; 180B5:  4d 4d 4d 4d 4d 4d 4d 90
            hex 4d 92 4d 4d 4d 4d 4d 4d ; 180BD:  4d 92 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 180C5:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 180CD:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 91 ; 180D5:  4d 4d 4d 4d 4d 4d 4d 91
            hex 4d 93 4d 4d 4d 4d 4d 4d ; 180DD:  4d 93 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 180E5:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 180ED:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 95 97 98 9b ; 180F5:  4d 4d 4d 4d 95 97 98 9b
            hex 4d 9d 4d 4d 4d 4d 4d 4d ; 180FD:  4d 9d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18105:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 1810D:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 94 4d 4d 96 99 9a 9c ; 18115:  4d 94 4d 4d 96 99 9a 9c
            hex 4d 9e 4d 4d 4d 4d 4d 4d ; 1811D:  4d 9e 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18125:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 1812D:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 9f a1 a2 a3 a4 4d a7 a8 ; 18135:  9f a1 a2 a3 a4 4d a7 a8
            hex 4d aa 4d 4d 4d 4d 4d 4d ; 1813D:  4d aa 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18145:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 1814D:  4d 4d 4d 4d 4d 4d 4d 4d
            hex a0 4d 4d a5 a6 4d 4d a9 ; 18155:  a0 4d 4d a5 a6 4d 4d a9
            hex 4d 93 4d 4d 4d 4d 4d 4d ; 1815D:  4d 93 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18165:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 1816D:  4d 4d 4d 4d 4d 4d 4d 4d
            hex ab ad ae 4d b1 4d 4d b2 ; 18175:  ab ad ae 4d b1 4d 4d b2
            hex b3 b5 b6 4d 4d 4d 4d 4d ; 1817D:  b3 b5 b6 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18185:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 1818D:  4d 4d 4d 4d 4d 4d 4d 4d
            hex ac af b0 4d 4d 4d 4d 4d ; 18195:  ac af b0 4d 4d 4d 4d 4d
            hex b4 b7 b8 4d 4d 4d 4d 4d ; 1819D:  b4 b7 b8 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 181A5:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 181AD:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d b9 ba bd 4d 4d 4d 4d ; 181B5:  4d b9 ba bd 4d 4d 4d 4d
            hex 4d c1 c2 c5 4d 4d 4d 4d ; 181BD:  4d c1 c2 c5 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 181C5:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 181CD:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d bb bc be 4d bf 4d c0 ; 181D5:  4d bb bc be 4d bf 4d c0
            hex 4d c3 c4 4d 4d 4d 4d 4d ; 181DD:  4d c3 c4 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 181E5:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 181ED:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d c6 c7 ca cb ce cf d2 ; 181F5:  4d c6 c7 ca cb ce cf d2
            hex d3 d6 4d 4d 4d 4d 4d 4d ; 181FD:  d3 d6 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 18205:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d 4d 4d 4d 4d 4d 4d 4d ; 1820D:  4d 4d 4d 4d 4d 4d 4d 4d
            hex 4d c8 c9 cc cd d0 d1 d4 ; 18215:  4d c8 c9 cc cd d0 d1 d4
            hex d5 d7 d8 4d 4d 4d 4d d9 ; 1821D:  d5 d7 d8 4d 4d 4d 4d d9
            hex d9 d9 d9 d9 d9 d9 d9 d9 ; 18225:  d9 d9 d9 d9 d9 d9 d9 d9
            hex d9 db dc df e0 e0 e2 e4 ; 1822D:  d9 db dc df e0 e0 e2 e4
            hex e5 e8 e9 eb ec ef f0 f3 ; 18235:  e5 e8 e9 eb ec ef f0 f3
            hex f4 f6 f7 fa fb fd e0 da ; 1823D:  f4 f6 f7 fa fb fd e0 da
            hex da da da da da da da da ; 18245:  da da da da da da da da
            hex da dd de de e1 e3 e3 e6 ; 1824D:  da dd de de e1 e3 e3 e6
            hex e7 e7 ea ed ee f1 f2 f5 ; 18255:  e7 e7 ea ed ee f1 f2 f5
            hex ea f8 f9 fc e3 e3 e3 00 ; 1825D:  ea f8 f9 fc e3 e3 e3 00
            hex 00 00 00 00 00 00 00 00 ; 18265:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1826D:  00 00 00 00 00 00 00 00
            hex 00 00 00 18 3c 3e 7e 00 ; 18275:  00 00 00 18 3c 3e 7e 00
            hex 00 00 00 18 3c 3e 7e 00 ; 1827D:  00 00 00 18 3c 3e 7e 00
            hex 00 00 00 0c 0e 0e 0c 00 ; 18285:  00 00 00 0c 0e 0e 0c 00
            hex 00 00 00 0c 0e 0e 0c 7f ; 1828D:  00 00 00 0c 0e 0e 0c 7f
            hex 7f 7f 7f 7f 7f 7f f7 7f ; 18295:  7f 7f 7f 7f 7f 7f f7 7f
            hex 7f 7f 7f 7f 7f 7f f7 1c ; 1829D:  7f 7f 7f 7f 7f 7f f7 1c
            hex 1c 1c 1c 19 bb bb bb 1c ; 182A5:  1c 1c 1c 19 bb bb bb 1c
            hex 1c 1c 1c 19 bb bb bb 00 ; 182AD:  1c 1c 1c 19 bb bb bb 00
            hex 00 00 00 30 78 f8 f8 00 ; 182B5:  00 00 00 30 78 f8 f8 00
            hex 00 00 00 30 78 f8 f8 00 ; 182BD:  00 00 00 30 78 f8 f8 00
            hex 01 01 f1 f9 fb fb 3b 00 ; 182C5:  01 01 f1 f9 fb fb 3b 00
            hex 01 01 f1 f9 fb fb 3b    ; 182CD:  01 01 f1 f9 fb fb 3b

            beq tab_b6_8055+625         ; 182D4:  f0 f0
            beq tab_b6_8055+611         ; 182D6:  f0 e0
            sbc ($c1,x)                 ; 182D8:  e1 c1
            cmp ($b3,x)                 ; 182DA:  c1 b3
            beq tab_b6_8055+633         ; 182DC:  f0 f0
            beq tab_b6_8055+619         ; 182DE:  f0 e0
            sbc ($c1,x)                 ; 182E0:  e1 c1
            cmp ($b3,x)                 ; 182E2:  c1 b3
            brk                         ; 182E4:  00
            hex 00                      ; 182E5:  00
            brk                         ; 182E6:  00
            hex 00                      ; 182E7:  00
            cpy #$cc                    ; 182E8:  c0 cc
            hex 8e 9c 00 ; stx $009c    ; 182EA:  8e 9c 00
            brk                         ; 182ED:  00
            hex 00                      ; 182EE:  00
            brk                         ; 182EF:  00
            hex c0                      ; 182F0:  c0
            cpy tab_b6_9bef+159         ; 182F1:  cc 8e 9c
            brk                         ; 182F4:  00
            hex 00                      ; 182F5:  00
            brk                         ; 182F6:  00
            hex 00                      ; 182F7:  00
            rts                         ; 182F8:  60

            ror $ff7f                   ; 182F9:  6e 7f ff
            brk                         ; 182FC:  00
            hex 00                      ; 182FD:  00
            brk                         ; 182FE:  00
            hex 00                      ; 182FF:  00
            rts                         ; 18300:  60

            hex 6e 7f ff 00 00 03 0f 0f ; 18301:  6e 7f ff 00 00 03 0f 0f
            hex 1b 11 11 00 00 03 0f 0f ; 18309:  1b 11 11 00 00 03 0f 0f
            hex 1b 11 11 00 00 00 81 c3 ; 18311:  1b 11 11 00 00 00 81 c3
            hex c7 c7 cf 00 00 00 81 c3 ; 18319:  c7 c7 cf 00 00 00 81 c3
            hex c7 c7 cf                ; 18321:  c7 c7 cf

            brk                         ; 18324:  00
            hex 00                      ; 18325:  00
            rts                         ; 18326:  60

            hex f0 f8 ef                ; 18327:  f0 f8 ef

            sta $0d                     ; 1832A:  85 0d
            brk                         ; 1832C:  00
            hex 00                      ; 1832D:  00
            rts                         ; 1832E:  60

            hex f0 f8 ef 85 0d 00 00 18 ; 1832F:  f0 f8 ef 85 0d 00 00 18
            hex 7c fe fe 9e 1c 00 00 18 ; 18337:  7c fe fe 9e 1c 00 00 18
            hex 7c fe fe 9e 1c 60 e0 c0 ; 1833F:  7c fe fe 9e 1c 60 e0 c0
            hex 83 8e 1c 3c 3f 60 e0 c0 ; 18347:  83 8e 1c 3c 3f 60 e0 c0
            hex 83 8e 1c 3c 3f 00 00 00 ; 1834F:  83 8e 1c 3c 3f 00 00 00
            hex 00 00 0f 1f 1f 00 00 00 ; 18357:  00 00 0f 1f 1f 00 00 00
            hex 00 00 0f 1f 1f 3f 3f 33 ; 1835F:  00 00 0f 1f 1f 3f 3f 33
            hex 73 73 63 e3 ef 3f 3f 33 ; 18367:  73 73 63 e3 ef 3f 3f 33
            hex 73 73 63 e3 ef 00 00 00 ; 1836F:  73 73 63 e3 ef 00 00 00
            hex 00 87 87 87 ff 00 00 00 ; 18377:  00 87 87 87 ff 00 00 00
            hex 00 87 87 87 ff 00 00 00 ; 1837F:  00 87 87 87 ff 00 00 00
            hex 00 00 03 07 07 00 00 00 ; 18387:  00 00 03 07 07 00 00 00
            hex 00 00 03 07 07 00 00 00 ; 1838F:  00 00 03 07 07 00 00 00
            hex 00 00 36 7f ff 00 00 00 ; 18397:  00 00 36 7f ff 00 00 00
            hex 00 00 36 7f ff 0f 0f 0f ; 1839F:  00 00 36 7f ff 0f 0f 0f
            hex 1f 1f 1e 1e 3c 0f 0f 0f ; 183A7:  1f 1f 1e 1e 3c 0f 0f 0f
            hex 1f 1f 1e 1e 3c 83 87 07 ; 183AF:  1f 1f 1e 1e 3c 83 87 07
            hex 0e 1c 00 06 0f 83 87 07 ; 183B7:  0e 1c 00 06 0f 83 87 07
            hex 0e 1c 00 06 0f 0e 8c 1c ; 183BF:  0e 1c 00 06 0f 0e 8c 1c
            hex 1f 7f 7f 7f 38 0e 8c 1c ; 183C7:  1f 7f 7f 7f 38 0e 8c 1c
            hex 1f 7f 7f 7f 38 06 0e 1c ; 183CF:  1f 7f 7f 7f 38 06 0e 1c
            hex 98 00 04 0e 1c 06 0e 1c ; 183D7:  98 00 04 0e 1c 06 0e 1c
            hex 98 00 04 0e 1c 00 00 00 ; 183DF:  98 00 04 0e 1c 00 00 00
            hex 00 38 7c 7e fe 00 00 00 ; 183E7:  00 38 7c 7e fe 00 00 00
            hex 00 38 7c 7e fe 00 00 00 ; 183EF:  00 38 7c 7e fe 00 00 00
            hex 00 00 00 01 02 00 00 00 ; 183F7:  00 00 00 01 02 00 00 00
            hex 00 00 00 01 02 00 00 00 ; 183FF:  00 00 00 01 02 00 00 00
            hex 00 00 fc 02 f9 00 00 00 ; 18407:  00 00 fc 02 f9 00 00 00
            hex 00 00 fc 02 f9 02 02 02 ; 1840F:  00 00 fc 02 f9 02 02 02
            hex 02 e2 f1 f0 fe 02 02 02 ; 18417:  02 e2 f1 f0 fe 02 02 02
            hex 02 e2 f1 f0 fe cd cd f9 ; 1841F:  02 e2 f1 f0 fe cd cd f9
            hex cd cd 02 fc 00 cd cd f9 ; 18427:  cd cd 02 fc 00 cd cd f9
            hex cd cd 02 fc 00 00 00 0f ; 1842F:  cd cd 02 fc 00 00 00 0f
            hex 18 13 14 14 14 00 00 00 ; 18437:  18 13 14 14 14 00 00 00
            hex 07 0f 0c 0c 0c 00 00 ff ; 1843F:  07 0f 0c 0c 0c 00 00 ff
            hex 40 9e e1 00 80 00 00 00 ; 18447:  40 9e e1 00 80 00 00 00
            hex bf ff e1 00 80 14 34 24 ; 1844F:  bf ff e1 00 80 14 34 24
            hex 28 28 28 28 29 0c 0c 1c ; 18457:  28 28 28 28 29 0c 0c 1c
            hex 18 18 18 18 19 c0 a0 9f ; 1845F:  18 18 18 18 19 c0 a0 9f
            hex f0 0e 01 00 00 c0 e0 ff ; 18467:  f0 0e 01 00 00 c0 e0 ff
            hex ff 0f 01 00 00 00 00 83 ; 1846F:  ff 0f 01 00 00 00 00 83
            hex ee 38 83 7c 00 00 00 00 ; 18477:  ee 38 83 7c 00 00 00 00
            hex 01 c7 ff 7c 00 00 ff 80 ; 1847F:  01 c7 ff 7c 00 00 ff 80
            hex 3e c1 1e 43 2c 00 00 7f ; 18487:  3e c1 1e 43 2c 00 00 7f
            hex ff c1 1e 43 2c 01 00 e0 ; 1848F:  ff c1 1e 43 2c 01 00 e0
            hex 18 07 e0 1e 01 01 00 e0 ; 18497:  18 07 e0 1e 01 01 00 e0
            hex f8 ff ff 1f 01 df 01 0e ; 1849F:  f8 ff ff 1f 01 df 01 0e
            hex 71 86 3f 19 c8 df 01 0e ; 184A7:  71 86 3f 19 c8 df 01 0e
            hex 7f f9 c0 e0 f0 00 80    ; 184AF:  7f f9 c0 e0 f0 00 80

            beq tab_b6_84c7+9           ; 184B6:  f0 18
            cpy $d424                   ; 184B8:  cc 24 d4
            ldy ptr0_lo                     ; 184BB:  a4 00
            brk                         ; 184BD:  00
            hex 00                      ; 184BE:  00
            cpx #$f0                    ; 184BF:  e0 f0
            sec                         ; 184C1:  38
            cld                         ; 184C2:  d8
            sed                         ; 184C3:  f8
            jmp $48a8                   ; 184C4:  4c a8 48

tab_b6_84c7: ; 16 bytes
            hex a8 48 18 f0 00 70 b0 70 ; 184C7:  a8 48 18 f0 00 70 b0 70
            hex b0 f0 e0 00 00 f3 e3 e3 ; 184CF:  b0 f0 e0 00 00 f3 e3 e3

            sbc ($e1,x)                 ; 184D7:  e1 e1
            rts                         ; 184D9:  60

            hex 60 00 f3 e3 e3          ; 184DA:  60 00 f3 e3 e3

            sbc ($e1,x)                 ; 184DF:  e1 e1
            rts                         ; 184E1:  60

            hex 60 00 b7 f7 f7 f7 f7 e3 ; 184E2:  60 00 b7 f7 f7 f7 f7 e3
            hex e0 00 b7 f7 f7 f7 f7 e3 ; 184EA:  e0 00 b7 f7 f7 f7 f7 e3
            hex e0 00 3b 77 f7 eb c1 81 ; 184F2:  e0 00 3b 77 f7 eb c1 81
            hex 00 00 3b 77 f7 eb c1 81 ; 184FA:  00 00 3b 77 f7 eb c1 81
            hex 00 00 fb 9f 93 db fb    ; 18502:  00 00 fb 9f 93 db fb

            sbc ($f0),y                 ; 18509:  f1 f0
            rts                         ; 1850B:  60

            hex fb 9f 93 db fb          ; 1850C:  fb 9f 93 db fb

            sbc ($f0),y                 ; 18511:  f1 f0
            rts                         ; 18513:  60

            hex 9c bc fc fc dc 0c 0c 00 ; 18514:  9c bc fc fc dc 0c 0c 00
            hex 9c bc fc fc dc 0c 0c 00 ; 1851C:  9c bc fc fc dc 0c 0c 00
            hex ff f7 e7 c7 c7 03 03 00 ; 18524:  ff f7 e7 c7 c7 03 03 00
            hex ff f7 e7 c7 c7 03 03 00 ; 1852C:  ff f7 e7 c7 c7 03 03 00
            hex 33 37 3f 3d 3d 80 00 00 ; 18534:  33 37 3f 3d 3d 80 00 00
            hex 33 37 3f 3d 3d 80 00 00 ; 1853C:  33 37 3f 3d 3d 80 00 00
            hex cf cf cf cf c7 c1 07 0e ; 18544:  cf cf cf cf c7 c1 07 0e
            hex cf cf cf cf c7 c1 07 0e ; 1854C:  cf cf cf cf c7 c1 07 0e
            hex 1c 1d 1f 0f 00 00 00 00 ; 18554:  1c 1d 1f 0f 00 00 00 00
            hex 1c 1d 1f 0f 00 00 00 00 ; 1855C:  1c 1d 1f 0f 00 00 00 00
            hex 1b 3f fb f3 b3          ; 18564:  1b 3f fb f3 b3

            beq tab_b6_8574+87          ; 18569:  f0 60
            rts                         ; 1856B:  60

            hex 1b 3f fb f3 b3          ; 1856C:  1b 3f fb f3 b3

            beq tab_b6_8574+95          ; 18571:  f0 60
            rts                         ; 18573:  60

tab_b6_8574: ; 439 bytes
            hex 3c 7c fc ec cc 06 00 00 ; 18574:  3c 7c fc ec cc 06 00 00
            hex 3c 7c fc ec cc 06 00 00 ; 1857C:  3c 7c fc ec cc 06 00 00
            hex c0 c0 80 00 00 00 00 00 ; 18584:  c0 c0 80 00 00 00 00 00
            hex c0 c0 80 00 00 00 00 00 ; 1858C:  c0 c0 80 00 00 00 00 00
            hex 3f 3f 1f 07 07 0f 3e 00 ; 18594:  3f 3f 1f 07 07 0f 3e 00
            hex 3f 3f 1f 07 07 0f 3e 00 ; 1859C:  3f 3f 1f 07 07 0f 3e 00
            hex 80 83 81 81 81 03 03 03 ; 185A4:  80 83 81 81 81 03 03 03
            hex 80 83 81 81 81 03 03 03 ; 185AC:  80 83 81 81 81 03 03 03
            hex ff ff ff e3 83 83 83 03 ; 185B4:  ff ff ff e3 83 83 83 03
            hex ff ff ff e3 83 83 83 03 ; 185BC:  ff ff ff e3 83 83 83 03
            hex ef cf 8f 9e 9e 1c 1c 18 ; 185C4:  ef cf 8f 9e 9e 1c 1c 18
            hex ef cf 8f 9e 9e 1c 1c 18 ; 185CC:  ef cf 8f 9e 9e 1c 1c 18
            hex ff ff f7 e6 c6 c6 02 00 ; 185D4:  ff ff f7 e6 c6 c6 02 00
            hex ff ff f7 e6 c6 c6 02 00 ; 185DC:  ff ff f7 e6 c6 c6 02 00
            hex 3d 3b 39 79 5d 9f 0f 07 ; 185E4:  3d 3b 39 79 5d 9f 0f 07
            hex 3d 3b 39 79 5d 9f 0f 07 ; 185EC:  3d 3b 39 79 5d 9f 0f 07
            hex 0e 9e fe 9e 9c 8c 8c 00 ; 185F4:  0e 9e fe 9e 9c 8c 8c 00
            hex 0e 9e fe 9e 9c 8c 8c 00 ; 185FC:  0e 9e fe 9e 9c 8c 8c 00
            hex 38 38 30 30 32 3b 1e 0e ; 18604:  38 38 30 30 32 3b 1e 0e
            hex 38 38 30 30 32 3b 1e 0e ; 1860C:  38 38 30 30 32 3b 1e 0e
            hex 3c 7d 7d 79 39 19 18 00 ; 18614:  3c 7d 7d 79 39 19 18 00
            hex 3c 7d 7d 79 39 19 18 00 ; 1861C:  3c 7d 7d 79 39 19 18 00
            hex ce ce cc fc f8 f8 f0 00 ; 18624:  ce ce cc fc f8 f8 f0 00
            hex ce ce cc fc f8 f8 f0 00 ; 1862C:  ce ce cc fc f8 f8 f0 00
            hex ff ff ff e7 e7 c6 c6 02 ; 18634:  ff ff ff e7 e7 c6 c6 02
            hex ff ff ff e7 e7 c6 c6 02 ; 1863C:  ff ff ff e7 e7 c6 c6 02
            hex 29 29 29 29 29 68 48 50 ; 18644:  29 29 29 29 29 68 48 50
            hex 19 19 19 19 19 18 38 30 ; 1864C:  19 19 19 19 19 18 38 30
            hex 52 52 52 52 52 52 52 52 ; 18654:  52 52 52 52 52 52 52 52
            hex 32 32 32 32 32 32 32 32 ; 1865C:  32 32 32 32 32 32 32 32
            hex 00 07 04 05 05 05 05 05 ; 18664:  00 07 04 05 05 05 05 05
            hex 00 07 07 06 06 06 06 06 ; 1866C:  00 07 07 06 06 06 06 06
            hex 28 c8 18 f0 00 00 00 00 ; 18674:  28 c8 18 f0 00 00 00 00
            hex 30 f0 e0 00 00 00 00 00 ; 1867C:  30 f0 e0 00 00 00 00 00
            hex 05 05 05 05 05 05 09 0b ; 18684:  05 05 05 05 05 05 09 0b
            hex 06 06 06 06 06 06 0e 0c ; 1868C:  06 06 06 06 06 06 0e 0c
            hex 52 50 50 50 52 52 d2 92 ; 18694:  52 50 50 50 52 52 d2 92
            hex 32 30 30 30 32 32 32 72 ; 1869C:  32 30 30 30 32 32 32 72
            hex a4 a4 a4 a4 a4 a4 a4 a0 ; 186A4:  a4 a4 a4 a4 a4 a4 a4 a0
            hex 64 64 64 64 64 64 64 60 ; 186AC:  64 64 64 64 64 64 64 60
            hex 0a 0a 0a 0a 0a 0a 0a 16 ; 186B4:  0a 0a 0a 0a 0a 0a 0a 16
            hex 0c 0c 0c 0c 0c 0c 0c 18 ; 186BC:  0c 0c 0c 0c 0c 0c 0c 18
            hex 14 14 14 14 14 14 14 14 ; 186C4:  14 14 14 14 14 14 14 14
            hex 18 18 18 18 18 18 18 18 ; 186CC:  18 18 18 18 18 18 18 18
            hex 00 00 00 7c c6 92 ab 69 ; 186D4:  00 00 00 7c c6 92 ab 69
            hex 00 00 00 00 38 7c 6c ee ; 186DC:  00 00 00 00 38 7c 6c ee
            hex 00 00 00 00 00 07 0c 09 ; 186E4:  00 00 00 00 00 07 0c 09
            hex 00 00 00 00 00 00 03 07 ; 186EC:  00 00 00 00 00 00 03 07
            hex 0a 09 0c 06 0c 09 1a 32 ; 186F4:  0a 09 0c 06 0c 09 1a 32
            hex 06 07 03 01 03 07 06 0e ; 186FC:  06 07 03 01 03 07 06 0e
            hex 00 00 00 00 07 fc 01 ae ; 18704:  00 00 00 00 07 fc 01 ae
            hex 00 00 00 00 00 03 ff fe ; 1870C:  00 00 00 00 00 03 ff fe
            hex 00 00 00 00 fc 06 73 8b ; 18714:  00 00 00 00 fc 06 73 8b
            hex 00 00 00 00 00 f8 fc 8c ; 1871C:  00 00 00 00 00 f8 fc 8c
            hex 52 00 80 40 c0 40 1b    ; 18724:  52 00 80 40 c0 40 1b

            brk                         ; 1872B:  00
            hex 52                      ; 1872C:  52
            brk                         ; 1872D:  00
            hex 80                      ; 1872E:  80
            cpy #$c0                    ; 1872F:  c0 c0
            rti                         ; 18731:  40

            hex 1b 00 33 47 8d 67 53 09 ; 18732:  1b 00 33 47 8d 67 53 09
            hex 04 02 3c 78 f0 78 5c    ; 1873A:  04 02 3c 78 f0 78 5c

            asl $0307                   ; 18741:  0e 07 03
            ldy #$a0                    ; 18744:  a0 a0
            ldy $a4                     ; 18746:  a4 a4
            ldy $a4                     ; 18748:  a4 a4
            ldy $24                     ; 1874A:  a4 24
            rts                         ; 1874C:  60

            hex 60 64 64 64 64 64       ; 1874D:  60 64 64 64 64 64

            cpx $48                     ; 18753:  e4 48
            pha                         ; 18755:  48
            pha                         ; 18756:  48
            pha                         ; 18757:  48
            pha                         ; 18758:  48
            pha                         ; 18759:  48
            pha                         ; 1875A:  48
            rti                         ; 1875B:  40

tab_b6_875c: ; 149 bytes
            hex c8 c8 c8 c8 c8 c8 c8 c0 ; 1875C:  c8 c8 c8 c8 c8 c8 c8 c0
            hex 14 24 2c 28 28 28 28 28 ; 18764:  14 24 2c 28 28 28 28 28
            hex 18 38 30 30 30 30 30 30 ; 1876C:  18 38 30 30 30 30 30 30
            hex 28 28 28 28 28 28 28 28 ; 18774:  28 28 28 28 28 28 28 28
            hex 30 30 30 30 30 30 30 30 ; 1877C:  30 30 30 30 30 30 30 30
            hex 06 05 05 05 04 0c 09 0a ; 18784:  06 05 05 05 04 0c 09 0a
            hex 01 03 03 03 03 03 07 06 ; 1878C:  01 03 03 03 03 03 07 06
            hex 0a 1a 12 34 24 68 c8 90 ; 18794:  0a 1a 12 34 24 68 c8 90
            hex 06 06 0e 0c 1c 18 38 70 ; 1879C:  06 06 0e 0c 1c 18 38 70
            hex e4 62 23 10 80 80 00 00 ; 187A4:  e4 62 23 10 80 80 00 00
            hex e7 63 23 10 80 80 00 00 ; 187AC:  e7 63 23 10 80 80 00 00
            hex 07 a8 55 0a 25 00 05 00 ; 187B4:  07 a8 55 0a 25 00 05 00
            hex f8 ff 57 0a 25 00 05 00 ; 187BC:  f8 ff 57 0a 25 00 05 00
            hex c0 60 20 b8 8e 63 59 34 ; 187C4:  c0 60 20 b8 8e 63 59 34
            hex 00 80 c0 c0 f0 7c 5e 37 ; 187CC:  00 80 c0 c0 f0 7c 5e 37
            hex 64 4e 53 d0 90 a0 a2 20 ; 187D4:  64 4e 53 d0 90 a0 a2 20
            hex 1c 3e 33 30 70 60 62 e0 ; 187DC:  1c 3e 33 30 70 60 62 e0
            hex 8d 22 09 02 04 01 00 00 ; 187E4:  8d 22 09 02 04 01 00 00
            hex 8f 22 09 02 04          ; 187EC:  8f 22 09 02 04

            ora (ptr0_lo,x)                 ; 187F1:  01 00
            brk                         ; 187F3:  00
            hex 48                      ; 187F4:  48
            bne tab_b6_875c+91          ; 187F5:  d0 c0
            brk                         ; 187F7:  00
            hex 80                      ; 187F8:  80
            brk                         ; 187F9:  00
            hex 00                      ; 187FA:  00
            ora ($c8,x)                 ; 187FB:  01 c8
            bne tab_b6_875c+99          ; 187FD:  d0 c0
            brk                         ; 187FF:  00
            hex 80                      ; 18800:  80
            brk                         ; 18801:  00
            hex 00                      ; 18802:  00
            ora (ptr2_hi,x)                 ; 18803:  01 05
            ora #$90                    ; 18805:  09 90
            brk                         ; 18807:  00
            hex 00                      ; 18808:  00
            brk                         ; 18809:  00
            hex 00                      ; 1880A:  00
            brk                         ; 1880B:  00
            hex 05                      ; 1880C:  05
            ora #$90                    ; 1880D:  09 90
            brk                         ; 1880F:  00
            hex 00                      ; 18810:  00
            brk                         ; 18811:  00
            hex 00                      ; 18812:  00
            brk                         ; 18813:  00
            hex 40                      ; 18814:  40
            rti                         ; 18815:  40

            hex c8 c8 48 48 08 08 c0 c0 ; 18816:  c8 c8 48 48 08 08 c0 c0
            hex c8 c8 48 48 08 08 08 08 ; 1881E:  c8 c8 48 48 08 08 08 08
            hex 08 10 10 10 00 80 08 08 ; 18826:  08 10 10 10 00 80 08 08
            hex 08 10 10 10 00 80 28 28 ; 1882E:  08 10 10 10 00 80 28 28
            hex 2c 24 14 14 14 14       ; 18836:  2c 24 14 14 14 14

            bmi tab_b6_8848+38          ; 1883C:  30 30
            bmi tab_b6_8848+48          ; 1883E:  30 38
            clc                         ; 18840:  18
            clc                         ; 18841:  18
            clc                         ; 18842:  18
            clc                         ; 18843:  18
            jsr $4040                   ; 18844:  20 40 40
            rti                         ; 18847:  40

tab_b6_8848: ; 131 bytes
            hex 40 20 a1 9e e0 c0 c0 c0 ; 18848:  40 20 a1 9e e0 c0 c0 c0
            hex c0 e0 61 7f c1 7d 04 06 ; 18850:  c0 e0 61 7f c1 7d 04 06
            hex 03 01 00 00 3f 03 03 01 ; 18858:  03 01 00 00 3f 03 03 01
            hex 00 00 00 00 02 06 19 61 ; 18860:  00 00 00 00 02 06 19 61
            hex 8c 46 b1 ec 02 06 1f 7f ; 18868:  8c 46 b1 ec 02 06 1f 7f
            hex f3 79 be ef 00 02 00 02 ; 18870:  f3 79 be ef 00 02 00 02
            hex 80 41 20 21 00 02 00 02 ; 18878:  80 41 20 21 00 02 00 02
            hex 80 c1 e0 e1 5b 56 a5 51 ; 18880:  80 c1 e0 e1 5b 56 a5 51
            hex 2c 9b c6 71 7b 6e bb de ; 18888:  2c 9b c6 71 7b 6e bb de
            hex ef 7b 3e 0f 70 80 70 48 ; 18890:  ef 7b 3e 0f 70 80 70 48
            hex 08 b0 58 a8 f0 80 f0 b8 ; 18898:  08 b0 58 a8 f0 80 f0 b8
            hex f8 f0 58 f8 01 0e 10 02 ; 188A0:  f8 f0 58 f8 01 0e 10 02
            hex 00 01 00 00 01 0e 10 02 ; 188A8:  00 01 00 00 01 0e 10 02
            hex 00 01 00 00 9d 95 95 95 ; 188B0:  00 01 00 00 9d 95 95 95
            hex 1b 1a 10 10 9d 9d 9d 9d ; 188B8:  1b 1a 10 10 9d 9d 9d 9d
            hex 1b 1a 10 10 00 40 5f 50 ; 188C0:  1b 1a 10 10 00 40 5f 50
            hex 57 d4 a7                ; 188C8:  57 d4 a7

            bit ptr0_lo                     ; 188CB:  24 00
            rti                         ; 188CD:  40

            hex 5f 5f 58 d8 b8 3b 11 16 ; 188CE:  5f 5f 58 d8 b8 3b 11 16
            hex 39 00 02 01 00 00 1f 1e ; 188D6:  39 00 02 01 00 00 1f 1e
            hex 39 00 02 01 00 00 12 0a ; 188DE:  39 00 02 01 00 00 12 0a
            hex fa 02 fc ff 81 3c 1c 0c ; 188E6:  fa 02 fc ff 81 3c 1c 0c
            hex fc fc 00 00 7e ff 00 00 ; 188EE:  fc fc 00 00 7e ff 00 00
            hex 00 00 00 00 e0 38 00 00 ; 188F6:  00 00 00 00 e0 38 00 00
            hex 00 00 00 00 00 c0 c3 20 ; 188FE:  00 00 00 00 00 c0 c3 20
            hex 00 00 00 70 8a 45 c3 20 ; 18906:  00 00 00 70 8a 45 c3 20
            hex 00 00 00 70 fa 7d 8c 66 ; 1890E:  00 00 00 70 fa 7d 8c 66
            hex 93 29 05 0c 02 06 f0 78 ; 18916:  93 29 05 0c 02 06 f0 78
            hex 9c 2e 06 0f 03 07 1c 07 ; 1891E:  9c 2e 06 0f 03 07 1c 07
            hex 00 00 00 00 00 00 03 00 ; 18926:  00 00 00 00 00 00 03 00
            hex 00 00 00 00 00 00 10 d0 ; 1892E:  00 00 00 00 00 00 10 d0
            hex 50 50 50 48 68 28 f0 30 ; 18936:  50 50 50 48 68 28 f0 30
            hex 30 30 30 38 18 18 00 01 ; 1893E:  30 30 30 38 18 18 00 01
            hex 07 1c 31 26 28 28 00 00 ; 18946:  07 1c 31 26 28 28 00 00
            hex 00 03 0f 1e 18 18 68 c8 ; 1894E:  00 03 0f 1e 18 18 68 c8
            hex 10 60 80 00 00 01 18 38 ; 18956:  10 60 80 00 00 01 18 38
            hex f0 e0 80                ; 1895E:  f0 e0 80

            brk                         ; 18961:  00
            hex 00                      ; 18962:  00
            ora ($20,x)                 ; 18963:  01 20
            rti                         ; 18965:  40

            brk                         ; 18966:  00
            hex 40                      ; 18967:  40
b6_8968:    brk                         ; 18968:  00
            hex 00                      ; 18969:  00
            brk                         ; 1896A:  00
            hex 04                      ; 1896B:  04
            jsr $0040                   ; 1896C:  20 40 00
            rti                         ; 1896F:  40

            hex 00 00 00 04 00 04 00 40 ; 18970:  00 00 00 04 00 04 00 40
            hex 20 1c 20 c4 00 04 00 40 ; 18978:  20 1c 20 c4 00 04 00 40
            hex 20 1c 38 fc 00 00 00 00 ; 18980:  20 1c 38 fc 00 00 00 00
            hex 00 00 01 ff 00 00 00 00 ; 18988:  00 00 01 ff 00 00 00 00
            hex 00 00 01 ff 00 04 10 a8 ; 18990:  00 00 01 ff 00 04 10 a8
            hex 18 24 24 24 00 04 10 a8 ; 18998:  18 24 24 24 00 04 10 a8
            hex 18 3c 3c 3c 22 2b 2a 12 ; 189A0:  18 3c 3c 3c 22 2b 2a 12
            hex 15 14 18 11 3e 37 36 1e ; 189A8:  15 14 18 11 3e 37 36 1e
            hex 1d 1c 18 11 41 05 81 45 ; 189B0:  1d 1c 18 11 41 05 81 45
            hex 01 02 8a 54 41 05 81 45 ; 189B8:  01 02 8a 54 41 05 81 45
            hex 01 03 8b 57 0a 15 1a 11 ; 189C0:  01 03 8b 57 0a 15 1a 11
            hex 14 27 2c 28 0a 17       ; 189C8:  14 27 2c 28 0a 17

            asl $1b1f,x                 ; 189CE:  1e 1f 1b
            sec                         ; 189D1:  38
            bmi tab_b6_89e6+30          ; 189D2:  30 30
            lda #$53                    ; 189D4:  a9 53
            stx $3c                     ; 189D6:  86 3c
            rts                         ; 189D8:  60

            hex c0 00 00 ae 7c          ; 189D9:  c0 00 00 ae 7c

            sed                         ; 189DE:  f8
            cpy #$80                    ; 189DF:  c0 80
            brk                         ; 189E1:  00
            hex 00                      ; 189E2:  00
            brk                         ; 189E3:  00
            hex 40                      ; 189E4:  40
            rti                         ; 189E5:  40

tab_b6_89e6: ; 134 bytes
            hex 40 40 40 40 c0 80 80 80 ; 189E6:  40 40 40 40 c0 80 80 80
            hex 80 80 80 80 00 00 28 28 ; 189EE:  80 80 80 80 00 00 28 28
            hex 28 68 48 50 51 51 18 18 ; 189F6:  28 68 48 50 51 51 18 18
            hex 18 18 38 30 31 31 0e 30 ; 189FE:  18 18 38 30 31 31 0e 30
            hex c7 9c b0 a0 20 60 0f 3f ; 18A06:  c7 9c b0 a0 20 60 0f 3f
            hex f8 e0 c0 c0 c0 80 51 51 ; 18A0E:  f8 e0 c0 c0 c0 80 51 51
            hex 50 50 50 4c 64 f2 31 31 ; 18A16:  50 50 50 4c 64 f2 31 31
            hex 30 30 30 3c 1c 0e 60 30 ; 18A1E:  30 30 30 3c 1c 0e 60 30
            hex 98 cf 2f 2f 27 17 80 c0 ; 18A26:  98 cf 2f 2f 27 17 80 c0
            hex e0 f0 30 30 38 18 14 f4 ; 18A2E:  e0 f0 30 30 38 18 14 f4
            hex 94 14 12 1a 12 14 ec 0c ; 18A36:  94 14 12 1a 12 14 ec 0c
            hex 0c 0c 0e 06 0e 0c 04 05 ; 18A3E:  0c 0c 0e 06 0e 0c 04 05
            hex 09 13 16 14 24 2c 07 06 ; 18A46:  09 13 16 14 24 2c 07 06
            hex 0e 1c 18 18 38 30 14 34 ; 18A4E:  0e 1c 18 18 38 30 14 34
            hex 74 e4 e8 e8 e8 e8 0c 0c ; 18A56:  74 e4 e8 e8 e8 e8 0c 0c
            hex 0c 1c 18 18 18 18 2e 2f ; 18A5E:  0c 1c 18 18 18 18 2e 2f
            hex 2f 4f 5f 5f 5f 9f       ; 18A66:  2f 4f 5f 5f 5f 9f

            bmi tab_b6_8a89+21          ; 18A6C:  30 30
            bmi tab_b6_8a89+87          ; 18A6E:  30 70
            rts                         ; 18A70:  60

            hex 60 60 e0 01 fd 05 04 06 ; 18A71:  60 60 e0 01 fd 05 04 06
            hex 03 01 01 ff 03 03 03    ; 18A79:  03 01 01 ff 03 03 03

            ora (ptr0_lo,x)                 ; 18A80:  01 00
            brk                         ; 18A82:  00
            hex 00                      ; 18A83:  00
            brk                         ; 18A84:  00
            hex 00                      ; 18A85:  00
            brk                         ; 18A86:  00
            hex 80                      ; 18A87:  80
            rti                         ; 18A88:  40

tab_b6_8a89: ; 101 bytes
            hex 20 98 c4 00 00 00 80 c0 ; 18A89:  20 98 c4 00 00 00 80 c0
            hex e0 78 3c 03 ff ff ff ff ; 18A91:  e0 78 3c 03 ff ff ff ff
            hex ff ff ff 00 00 00 00 00 ; 18A99:  ff ff ff 00 00 00 00 00
            hex 00 00 00 f4 f4 f2 fa fa ; 18AA1:  00 00 00 f4 f4 f2 fa fa
            hex fa fa fa 0c 0c 0e 06 06 ; 18AA9:  fa fa fa 0c 0c 0e 06 06
            hex 06 06 06 22 4a 49 24 12 ; 18AB1:  06 06 06 22 4a 49 24 12
            hex 0b 0a 0a 3e 76 77 3b 1d ; 18AB9:  0b 0a 0a 3e 76 77 3b 1d
            hex 0c 0c 0c 00 00 00 c0 30 ; 18AC1:  0c 0c 0c 00 00 00 c0 30
            hex 88 e6 31 00 00 00 c0 f0 ; 18AC9:  88 e6 31 00 00 00 c0 f0
            hex 78 1e 0f 12 16 17 17 17 ; 18AD1:  78 1e 0f 12 16 17 17 17
            hex 17 27 2f 1c 18 18 18 18 ; 18AD9:  17 27 2f 1c 18 18 18 18
            hex 18 38 30 1d 04 0e fe ff ; 18AE1:  18 38 30 1d 04 0e fe ff
            hex ff ff ff 03 03          ; 18AE9:  ff ff ff 03 03

            ora (ptr0_hi,x)                 ; 18AEE:  01 01
            brk                         ; 18AF0:  00
            hex 00                      ; 18AF1:  00
            brk                         ; 18AF2:  00
            hex 00                      ; 18AF3:  00
            pha                         ; 18AF4:  48
            cli                         ; 18AF5:  58
            jmp $1266                   ; 18AF6:  4c 66 12

            hex 0a 0b                   ; 18AF9:  0a 0b

            ora #$70                    ; 18AFB:  09 70
            rts                         ; 18AFD:  60

tab_b6_8afe: ; 534 bytes
            hex 70 78 1c 0c 0c 0e 05 85 ; 18AFE:  70 78 1c 0c 0c 0e 05 85
            hex 85 44 42 42 22 a1 06 86 ; 18B06:  85 44 42 42 22 a1 06 86
            hex 86 c7 c3 c3 e3 61 00 00 ; 18B0E:  86 c7 c3 c3 e3 61 00 00
            hex 80 80 80 c0 60 7c 00 00 ; 18B16:  80 80 80 c0 60 7c 00 00
            hex 00 00 00 00 80 80 00 00 ; 18B1E:  00 00 00 00 80 80 00 00
            hex 00 00 00 ff 00 ff 00 00 ; 18B26:  00 00 00 ff 00 ff 00 00
            hex 00 00 00 00 ff ff 00 ff ; 18B2E:  00 00 00 00 ff ff 00 ff
            hex 00 ff 00 00 00 00 00 ff ; 18B36:  00 ff 00 00 00 00 00 ff
            hex ff 00 00 00 00 00 00 00 ; 18B3E:  ff 00 00 00 00 00 00 00
            hex 00 00 03 ff 00 ff 00 00 ; 18B46:  00 00 03 ff 00 ff 00 00
            hex 00 00 00 00 ff ff 00 00 ; 18B4E:  00 00 00 00 ff ff 00 00
            hex 00 00 ff ff 00 ff 00 00 ; 18B56:  00 00 ff ff 00 ff 00 00
            hex 00 00 00 00 ff ff 00 ff ; 18B5E:  00 00 00 00 ff ff 00 ff
            hex 00 ff 03 00 00 00 00 ff ; 18B66:  00 ff 03 00 00 00 00 ff
            hex ff 00 00 00 00 00 00 ff ; 18B6E:  ff 00 00 00 00 00 00 ff
            hex 00 ff ff 00 00 00 00 ff ; 18B76:  00 ff ff 00 00 00 00 ff
            hex ff 00 00 00 00 00 00 00 ; 18B7E:  ff 00 00 00 00 00 00 00
            hex 00 03 ff fc 00 ff 00 00 ; 18B86:  00 03 ff fc 00 ff 00 00
            hex 00 00 00 03 ff ff 00 00 ; 18B8E:  00 00 00 03 ff ff 00 00
            hex 00 ff ff 00 00 ff 00 00 ; 18B96:  00 ff ff 00 00 ff 00 00
            hex 00 00 00 ff ff ff 00 ff ; 18B9E:  00 00 00 ff ff ff 00 ff
            hex 00 fc ff 03 00 00 00 ff ; 18BA6:  00 fc ff 03 00 00 00 ff
            hex ff 03 00 00 00 00 00 00 ; 18BAE:  ff 03 00 00 00 00 00 00
            hex 03 ff ff 00 00 ff 00 00 ; 18BB6:  03 ff ff 00 00 ff 00 00
            hex 00 00 00 ff ff ff 00 ff ; 18BBE:  00 00 00 ff ff ff 00 ff
            hex 00 00 ff ff 00 00 00 ff ; 18BC6:  00 00 ff ff 00 00 00 ff
            hex ff ff 00 00 00 00 00 03 ; 18BCE:  ff ff 00 00 00 00 00 03
            hex ff ff fc 00 00 ff 00 00 ; 18BD6:  ff ff fc 00 00 ff 00 00
            hex 00 00 03 ff ff ff 03 ff ; 18BDE:  00 00 03 ff ff ff 03 ff
            hex ff ff 00 00 03 ff 00 00 ; 18BE6:  ff ff 00 00 03 ff 00 00
            hex 00 00 ff ff ff ff 00 ff ; 18BEE:  00 00 ff ff ff ff 00 ff
            hex 03 00 fc ff 03 00 00 ff ; 18BF6:  03 00 fc ff 03 00 00 ff
            hex ff ff 03 00 00 00 00 ff ; 18BFE:  ff ff 03 00 00 00 00 ff
            hex ff 00 00 ff ff 00 00 ff ; 18C06:  ff 00 00 ff ff 00 00 ff
            hex ff ff ff 00 00 00 fd fc ; 18C0E:  ff ff ff 00 00 00 fd fc
            hex ff fc 00 00 ff ff 03 03 ; 18C16:  ff fc 00 00 ff ff 03 03
            hex 00 03 ff ff ff ff 97 67 ; 18C1E:  00 03 ff ff ff ff 97 67
            hex 0c 00 00 01 ff ff 98 f8 ; 18C26:  0c 00 00 01 ff ff 98 f8
            hex f3 ff ff ff ff ff 00 ff ; 18C2E:  f3 ff ff ff ff ff 00 ff
            hex ff 01 00 fc ff 03 00 ff ; 18C36:  ff 01 00 fc ff 03 00 ff
            hex ff ff ff 03 00 00 e8 c8 ; 18C3E:  ff ff ff 03 00 00 e8 c8
            hex 19 31 71 c1 83 03 18 38 ; 18C46:  19 31 71 c1 83 03 18 38
            hex f9 f1 f1 c1 83 03 9f 9f ; 18C4E:  f9 f1 f1 c1 83 03 9f 9f
            hex 8f 83 c0 fc ff ff e0 e0 ; 18C56:  8f 83 c0 fc ff ff e0 e0
            hex f0 fc ff ff ff ff 00 03 ; 18C5E:  f0 fc ff ff ff ff 00 03
            hex 83 c1 71 31 19 c8 00 03 ; 18C66:  83 c1 71 31 19 c8 00 03
            hex 83 c1 f1 f1 f9 38 00 ff ; 18C6E:  83 c1 f1 f1 f9 38 00 ff
            hex ff fc c0 83 8f 9c 00 ff ; 18C76:  ff fc c0 83 8f 9c 00 ff
            hex ff ff ff fc f0 e0 ff ff ; 18C7E:  ff ff ff fc f0 e0 ff ff
            hex ff fc 00 03 ff ff 00 00 ; 18C86:  ff fc 00 03 ff ff 00 00
            hex 00 03 ff ff ff ff f2 e2 ; 18C8E:  00 03 ff ff ff ff f2 e2
            hex 82 06 1c f8 f0 e0 0e 1e ; 18C96:  82 06 1c f8 f0 e0 0e 1e
            hex 7e fe fc f8 f0 e0 00 ff ; 18C9E:  7e fe fc f8 f0 e0 00 ff
            hex ff 03 00 fc ff 03 00 ff ; 18CA6:  ff 03 00 fc ff 03 00 ff
            hex ff ff ff 03 00 00 00 e0 ; 18CAE:  ff ff ff 03 00 00 00 e0
            hex f0 f8 1c 06 c2 e2 00 e0 ; 18CB6:  f0 f8 1c 06 c2 e2 00 e0
            hex f0 f8 fc fe 3e 1e 2f 27 ; 18CBE:  f0 f8 fc fe 3e 1e 2f 27
            hex 17 13 18 3c 7f 7f 30 38 ; 18CC6:  17 13 18 3c 7f 7f 30 38
            hex 18 1c 1f 3f 7f 7f ff ff ; 18CCE:  18 1c 1f 3f 7f 7f ff ff
            hex ff fc 00 01 ff ff 00 00 ; 18CD6:  ff fc 00 01 ff ff 00 00
            hex 00 03 ff ff ff ff 00 7f ; 18CDE:  00 03 ff ff ff ff 00 7f
            hex 7f 3c 18 13 17 2c 00 7f ; 18CE6:  7f 3c 18 13 17 2c 00 7f
            hex 7f 3f 1f 1c 18 30 a1 a1 ; 18CEE:  7f 3f 1f 1c 18 30 a1 a1
            hex 30 30 60 c1 c1 81 61 61 ; 18CF6:  30 30 60 c1 c1 81 61 61
            hex f0 f0 e0 c1 c1 81 7f 3f ; 18CFE:  f0 f0 e0 c1 c1 81 7f 3f
            hex bf 9f 80 80 ff ff 80 c0 ; 18D06:  bf 9f 80 80 ff ff 80 c0
            hex c0 e0 ff ff ff ff       ; 18D0E:  c0 e0 ff ff ff ff

            brk                         ; 18D14:  00
            hex 81                      ; 18D15:  81
            cmp ($c1,x)                 ; 18D16:  c1 c1
            rts                         ; 18D18:  60

            bmi tab_b6_8d24+39          ; 18D19:  30 30
            ldy #$00                    ; 18D1B:  a0 00
            sta ($c1,x)                 ; 18D1D:  81 c1
            cmp ($e0,x)                 ; 18D1F:  c1 e0
            beq tab_b6_8afe+533         ; 18D21:  f0 f0
            rts                         ; 18D23:  60

tab_b6_8d24: ; 104 bytes
            hex 00 ff ff c0 c0 8f 9f b8 ; 18D24:  00 ff ff c0 c0 8f 9f b8
            hex 00 ff ff ff ff f0 e0 c0 ; 18D2C:  00 ff ff ff ff f0 e0 c0
            hex fc ff ff ff 00 00 fc ff ; 18D34:  fc ff ff ff 00 00 fc ff
            hex 00 00 00 00 ff ff ff ff ; 18D3C:  00 00 00 00 ff ff ff ff
            hex 00 fc ff ff 03 00 00 ff ; 18D44:  00 fc ff ff 03 00 00 ff
            hex 00 00 00 00 fc ff ff ff ; 18D4C:  00 00 00 00 fc ff ff ff
            hex 00 ff fc 00 03 ff fc 00 ; 18D54:  00 ff fc 00 03 ff fc 00
            hex 00 ff ff ff fc 00 00 00 ; 18D5C:  00 ff ff ff fc 00 00 00
            hex 00 00 fc ff ff 00 00 ff ; 18D64:  00 00 fc ff ff 00 00 ff
            hex 00 00 00 00 00 ff ff ff ; 18D6C:  00 00 00 00 00 ff ff ff
            hex 51 51 51 51 51 51 51 51 ; 18D74:  51 51 51 51 51 51 51 51
            hex 51 51 51 51 51 52 53 54 ; 18D7C:  51 51 51 51 51 52 53 54
            hex 55 56 57 58 59 5a 5b 5c ; 18D84:  55 56 57 58 59 5a 5b 5c

            eor $5f5e,x                 ; 18D8C:  5d 5e 5f
            rts                         ; 18D8F:  60

            hex 61 61 62 61 51 51 51 51 ; 18D90:  61 61 62 61 51 51 51 51
            hex 51 51 51 51 51 51 51 51 ; 18D98:  51 51 51 51 51 51 51 51
            hex 51 52 53 54 55 56 57 58 ; 18DA0:  51 52 53 54 55 56 57 58
            hex 59 5a 5b 5c             ; 18DA8:  59 5a 5b 5c

            eor $5f5e,x                 ; 18DAC:  5d 5e 5f
            rts                         ; 18DAF:  60

            hex 61 61 62 61 51 51 51 51 ; 18DB0:  61 61 62 61 51 51 51 51
            hex 51 51 51 51 51 51 51 51 ; 18DB8:  51 51 51 51 51 51 51 51
            hex 51 52 53 54 55 56 57 58 ; 18DC0:  51 52 53 54 55 56 57 58
            hex 59 5a 5b 5c             ; 18DC8:  59 5a 5b 5c

            eor $5f5e,x                 ; 18DCC:  5d 5e 5f
            rts                         ; 18DCF:  60

            hex 61 61 62 61 51 51 51 51 ; 18DD0:  61 61 62 61 51 51 51 51
            hex 51 51 51 51 51 51 51 51 ; 18DD8:  51 51 51 51 51 51 51 51
            hex 51 52 53 54 55 56 57 58 ; 18DE0:  51 52 53 54 55 56 57 58
            hex 59 5a 5b 5c             ; 18DE8:  59 5a 5b 5c

            eor $5f5e,x                 ; 18DEC:  5d 5e 5f
            rts                         ; 18DEF:  60

            hex 61 61 62 61 51 51 51 51 ; 18DF0:  61 61 62 61 51 51 51 51
            hex 51 51 51 51 51 51 51 51 ; 18DF8:  51 51 51 51 51 51 51 51
            hex 51 52 53 54 55 56 57 58 ; 18E00:  51 52 53 54 55 56 57 58
            hex 59 5a 5b 5c             ; 18E08:  59 5a 5b 5c

            eor $5f5e,x                 ; 18E0C:  5d 5e 5f
            rts                         ; 18E0F:  60

            hex 61 61 62 61 51 51 51 51 ; 18E10:  61 61 62 61 51 51 51 51
            hex 51 51 51 51 51 51 51 52 ; 18E18:  51 51 51 51 51 51 51 52
            hex 53 54 55 56 57 58 59 5a ; 18E20:  53 54 55 56 57 58 59 5a
            hex 5b 5c                   ; 18E28:  5b 5c

            eor $5f5e,x                 ; 18E2A:  5d 5e 5f
            rts                         ; 18E2D:  60

            hex 61 61 61 61 61 61 51 51 ; 18E2E:  61 61 61 61 61 61 51 51
            hex 51 51 51 51 51 51 51 51 ; 18E36:  51 51 51 51 51 51 51 51
            hex 51 52 53 54 55 56 57 58 ; 18E3E:  51 52 53 54 55 56 57 58
            hex 59 5a 5b 5c             ; 18E46:  59 5a 5b 5c

            eor $5f5e,x                 ; 18E4A:  5d 5e 5f
            rts                         ; 18E4D:  60

            hex 61 61 61 61 61 61 51 51 ; 18E4E:  61 61 61 61 61 61 51 51
            hex 51 51 51 51 51 51 51 51 ; 18E56:  51 51 51 51 51 51 51 51
            hex 63 64 65 66 67 68 69 6a ; 18E5E:  63 64 65 66 67 68 69 6a
            hex 6b 6c 6d 6e 6f 70 71 72 ; 18E66:  6b 6c 6d 6e 6f 70 71 72
            hex 73 61 61 61 61 61 51 51 ; 18E6E:  73 61 61 61 61 61 51 51
            hex 51 51 51 51 51 74 74 74 ; 18E76:  51 51 51 51 51 74 74 74
            hex 76 77 7a 7b 7e 7f 82 83 ; 18E7E:  76 77 7a 7b 7e 7f 82 83
            hex 86 87 8a 8b 8e 8f 92 93 ; 18E86:  86 87 8a 8b 8e 8f 92 93
            hex 96 97 97 97 97 61 51 51 ; 18E8E:  96 97 97 97 97 61 51 51
            hex 51 51 51 74 74 75 75 75 ; 18E96:  51 51 51 74 74 75 75 75
            hex 78 79 7c 7d 80 81 84 85 ; 18E9E:  78 79 7c 7d 80 81 84 85
            hex 88 89 8c 8d 90 91 94 95 ; 18EA6:  88 89 8c 8d 90 91 94 95
            hex 98 99 99 99 99 97 51 51 ; 18EAE:  98 99 99 99 99 97 51 51
            hex 51 51 74 75 75 9a 9a 9a ; 18EB6:  51 51 74 75 75 9a 9a 9a
            hex 9c 9d a0 a1 a4 a5 a7 a8 ; 18EBE:  9c 9d a0 a1 a4 a5 a7 a8
            hex ab ac ad ae b1 b2 b5 b6 ; 18EC6:  ab ac ad ae b1 b2 b5 b6
            hex b9 ba ba ba ba 99 51 51 ; 18ECE:  b9 ba ba ba ba 99 51 51
            hex 51 74 75 9a 9a 9b 9b 9b ; 18ED6:  51 74 75 9a 9a 9b 9b 9b
            hex 9e 9f a2 a3 a6 a6 a9 aa ; 18EDE:  9e 9f a2 a3 a6 a6 a9 aa
            hex a6 a6 af b0 b3 b4 b7 b8 ; 18EE6:  a6 a6 af b0 b3 b4 b7 b8
            hex bb bc bc bc bc ba 51 51 ; 18EEE:  bb bc bc bc bc ba 51 51
            hex 74 75 9a 9b 9b bd bd bd ; 18EF6:  74 75 9a 9b 9b bd bd bd
            hex bf c0 c3 c4 a6 a6 a6 a6 ; 18EFE:  bf c0 c3 c4 a6 a6 a6 a6
            hex a6 a6 cc cd d0 d1 d4 d5 ; 18F06:  a6 a6 cc cd d0 d1 d4 d5
            hex d8 d9 d9 d9 d9 bc 74 74 ; 18F0E:  d8 d9 d9 d9 d9 bc 74 74
            hex 75 9a 9b bd bd be be be ; 18F16:  75 9a 9b bd bd be be be
            hex c1 c2 c5 c6 c7 c8 c9 ca ; 18F1E:  c1 c2 c5 c6 c7 c8 c9 ca
            hex cb a6 ce cf d2 d3 d6 d7 ; 18F26:  cb a6 ce cf d2 d3 d6 d7
            hex da db db db db d9 75 75 ; 18F2E:  da db db db db d9 75 75
            hex 9a 9b bd be be dc dc dc ; 18F36:  9a 9b bd be be dc dc dc
            hex de df e2 e3 a6 a6 a6 a6 ; 18F3E:  de df e2 e3 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 e9 eb ec ; 18F46:  a6 a6 a6 a6 a6 e9 eb ec
            hex ef f0 f0 f0 f0 db 9a 9a ; 18F4E:  ef f0 f0 f0 f0 db 9a 9a
            hex 9b bd be dc dc dd dd dd ; 18F56:  9b bd be dc dc dd dd dd
            hex e0 e1 e4 e5 a6 e6 e7 e8 ; 18F5E:  e0 e1 e4 e5 a6 e6 e7 e8
            hex a6 a6 a6 a6 a6 ea ed ee ; 18F66:  a6 a6 a6 a6 a6 ea ed ee
            hex a6 f1 f1 f1 f1 f0 9b 9b ; 18F6E:  a6 f1 f1 f1 f1 f0 9b 9b
            hex bd be dc dd dd f2 f2 f2 ; 18F76:  bd be dc dd dd f2 f2 f2
            hex f4 f5 f8 a6 a6 a6 a6 a6 ; 18F7E:  f4 f5 f8 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 fb fc a6 ; 18F86:  a6 a6 a6 a6 a6 fb fc a6
            hex a6 a6 a6 a6 a6 f1 bd bd ; 18F8E:  a6 a6 a6 a6 a6 f1 bd bd
            hex be dc dd f2 f2 f3 f3 f3 ; 18F96:  be dc dd f2 f2 f3 f3 f3
            hex f6 f7 f9 fa a6 a6 a6 a6 ; 18F9E:  f6 f7 f9 fa a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 18FA6:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 be be ; 18FAE:  a6 a6 a6 a6 a6 a6 be be
            hex dc dd f2 f3 f3 a6 a6 a6 ; 18FB6:  dc dd f2 f3 f3 a6 a6 a6
            hex a6 a6 fd a6 a6 a6 a6 a6 ; 18FBE:  a6 a6 fd a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 18FC6:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 dc dc ; 18FCE:  a6 a6 a6 a6 a6 a6 dc dc
            hex dd f2 f3 a6 a6 a6 a6 a6 ; 18FD6:  dd f2 f3 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 18FDE:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 18FE6:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 dd dd ; 18FEE:  a6 a6 a6 a6 a6 a6 dd dd
            hex f2 f3 a6 a6 a6 a6 a6 a6 ; 18FF6:  f2 f3 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 18FFE:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 19006:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 f2 f2 ; 1900E:  a6 a6 a6 a6 a6 a6 f2 f2
            hex f3 a6 a6 a6 a6 a6 a6 a6 ; 19016:  f3 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 1901E:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 19026:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 f3 f3 ; 1902E:  a6 a6 a6 a6 a6 a6 f3 f3
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 19036:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 1903E:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 a6 a6 ; 19046:  a6 a6 a6 a6 a6 a6 a6 a6
            hex a6 a6 a6 a6 a6 a6 35 ce ; 1904E:  a6 a6 a6 a6 a6 a6 35 ce
            hex 3b ec 9b e7 3c db 48 24 ; 19056:  3b ec 9b e7 3c db 48 24
            hex 02 48 11 24 88 13 cd b6 ; 1905E:  02 48 11 24 88 13 cd b6
            hex 7b 4d fb b6 ce bb 45 90 ; 19066:  7b 4d fb b6 ce bb 45 90
            hex 25 48 89 12 64 12 76 ed ; 1906E:  25 48 89 12 64 12 76 ed
            hex 9b 76 ef dc bb 6f 01 28 ; 19076:  9b 76 ef dc bb 6f 01 28
            hex 54 82 13 a8 44 2b f2 cf ; 1907E:  54 82 13 a8 44 2b f2 cf
            hex bd 76 db dd b6 77 05 a2 ; 19086:  bd 76 db dd b6 77 05 a2
            hex 54 48 13 aa 44 19 ed 5b ; 1908E:  54 48 13 aa 44 19 ed 5b
            hex be e5 de bb ed b7 02 ac ; 19096:  be e5 de bb ed b7 02 ac
            hex 51 8a 64 13 c8 2c cc 7b ; 1909E:  51 8a 64 13 c8 2c cc 7b
            hex ef db b6 ed 7b 97 44 ab ; 190A6:  ef db b6 ed 7b 97 44 ab
            hex 10 6a a5 88 5d a2 ee d9 ; 190AE:  10 6a a5 88 5d a2 ee d9
            hex 3f ea df b5 6e db d1 2a ; 190B6:  3f ea df b5 6e db d1 2a
            hex 45 a8 15 a2 59 22 fb ad ; 190BE:  45 a8 15 a2 59 22 fb ad
            hex b6 dd 77 ba ef 75 51 2a ; 190C6:  b6 dd 77 ba ef 75 51 2a
            hex 44 a9 15 a2 4c 29 35 fb ; 190CE:  44 a9 15 a2 4c 29 35 fb
            hex ce b6 bb f6 6e dd 10 a5 ; 190D6:  ce b6 bb f6 6e dd 10 a5
            hex 46 58 02 b5 4a 91 f3 4d ; 190DE:  46 58 02 b5 4a 91 f3 4d
            hex fe d3 bd ee db bd 62 11 ; 190E6:  fe d3 bd ee db bd 62 11
            hex 4a 95 a0 4d 2a 51 3a e7 ; 190EE:  4a 95 a0 4d 2a 51 3a e7
            hex dd ba b7 ed 6b be 84 33 ; 190F6:  dd ba b7 ed 6b be 84 33
            hex 48 14 a3 44 29 4c e7 9e ; 190FE:  48 14 a3 44 29 4c e7 9e
            hex 79 e7 be b9 67 de 82 24 ; 19106:  79 e7 be b9 67 de 82 24
            hex 49 92 24 48 13 a8 9c 67 ; 1910E:  49 92 24 48 13 a8 9c 67
            hex fd 9b e6 5d bb f6 41 aa ; 19116:  fd 9b e6 5d bb f6 41 aa
            hex 04 11 c4 28 05 98 b7 6a ; 1911E:  04 11 c4 28 05 98 b7 6a
            hex dd 33 de eb 3d d6 14 82 ; 19126:  dd 33 de eb 3d d6 14 82
            hex 10 22 45 a0 14 00 6e d9 ; 1912E:  10 22 45 a0 14 00 6e d9
            hex 57 ad d9 37 e6 6e 10 84 ; 19136:  57 ad d9 37 e6 6e 10 84
            hex 11 42 08 a2 10 41 ae 51 ; 1913E:  11 42 08 a2 10 41 ae 51
            hex 6e bb 24 dd 73 ae 80 21 ; 19146:  6e bb 24 dd 73 ae 80 21
            hex 04 48 02 90 20 0a 31 8d ; 1914E:  04 48 02 90 20 0a 31 8d
            hex 72 8a 73 4c 59 d3 04 88 ; 19156:  72 8a 73 4c 59 d3 04 88
            hex 00 22 00 88 44 20 11 dd ; 1915E:  00 22 00 88 44 20 11 dd
            hex 22 aa 33 cc 99 33 44 88 ; 19166:  22 aa 33 cc 99 33 44 88
            hex 00 22 00 88 44 00 b6 6f ; 1916E:  00 22 00 88 44 00 b6 6f
            hex d9 b7 6e db b6 dd 2a 54 ; 19176:  d9 b7 6e db b6 dd 2a 54
            hex 80                      ; 1917E:  80

            sta $2b,x                   ; 1917F:  95 2b
            rti                         ; 19181:  40

            hex aa 15 eb 5d f7 36 db ed ; 19182:  aa 15 eb 5d f7 36 db ed
            hex be db a5 48 93 4a 24 5a ; 1918A:  be db a5 48 93 4a 24 5a
            hex c5 14 ed 57 bb ee 76 ad ; 19192:  c5 14 ed 57 bb ee 76 ad
            hex fd 5b 50 8a 35 89 ca 32 ; 1919A:  fd 5b 50 8a 35 89 ca 32
            hex a8 47 db 6d 76 dd ef da ; 191A2:  a8 47 db 6d 76 dd ef da
            hex bb 77 c9 26 58 45 aa 95 ; 191AA:  bb 77 c9 26 58 45 aa 95
            hex aa 45 7a d7 be ed 5b fb ; 191B2:  aa 45 7a d7 be ed 5b fb

            lda tab_b6_9357+32          ; 191BA:  ad 77 93
            jmp $46b2                   ; 191BD:  4c b2 46

            hex 3d 51 a6 5c fe 6d db d7 ; 191C0:  3d 51 a6 5c fe 6d db d7
            hex bc 6b df 76 15 ea 95 14 ; 191C8:  bc 6b df 76 15 ea 95 14
            hex f5 02 bd e2 7d d7 bb 6e ; 191D0:  f5 02 bd e2 7d d7 bb 6e
            hex ef bf 76 ed 55 aa 54 a3 ; 191D8:  ef bf 76 ed 55 aa 54 a3
            hex 5f 67 9e 65 de 5b ef ba ; 191E0:  5f 67 9e 65 de 5b ef ba
            hex d7 fd eb de 56 c8 36 e5 ; 191E8:  d7 fd eb de 56 c8 36 e5
            hex 0a f4 cb 94 d7 bb 6d f6 ; 191F0:  0a f4 cb 94 d7 bb 6d f6
            hex db 6d b7 fe 66 94 aa 51 ; 191F8:  db 6d b7 fe 66 94 aa 51
            hex 66 95 aa 55 b6 6b de ed ; 19200:  66 95 aa 55 b6 6b de ed
            hex bb b6 6f ed aa 44 aa 55 ; 19208:  bb b6 6f ed aa 44 aa 55
            hex 2a 52 ad 24 db b6 ef 99 ; 19210:  2a 52 ad 24 db b6 ef 99
            hex 76 fb ae 76 62 94 99 22 ; 19218:  76 fb ae 76 62 94 99 22
            hex cc 73 86 b9 bb e5 3f e9 ; 19220:  cc 73 86 b9 bb e5 3f e9
            hex df b5 ee db 45 92 a9 22 ; 19228:  df b5 ee db 45 92 a9 22
            hex d4 19 65 8a 2d f7 5b ec ; 19230:  d4 19 65 8a 2d f7 5b ec
            hex 37 db f6 ad 43 28 44 a2 ; 19238:  37 db f6 ad 43 28 44 a2
            hex 55 28 25 98 db 6d b6 db ; 19240:  55 28 25 98 db 6d b6 db
            hex 75 6f da b7 4d a0 12 a4 ; 19248:  75 6f da b7 4d a0 12 a4
            hex 08 62 8c 11 d9 b7 da 6b ; 19250:  08 62 8c 11 d9 b7 da 6b
            hex b6 6d db b6 0c a0 12 c4 ; 19258:  b6 6d db b6 0c a0 12 c4
            hex 09 b2 00 55 ea 5d 6b b6 ; 19260:  09 b2 00 55 ea 5d 6b b6
            hex da 6d b6 db 41 88 24 21 ; 19268:  da 6d b6 db 41 88 24 21
            hex 44 12 90 4a d6 5c b3 6a ; 19270:  44 12 90 4a d6 5c b3 6a
            hex ce b5 b6 6d 05 88 10 22 ; 19278:  ce b5 b6 6d 05 88 10 22
            hex 45 10 44 88 dc bb e3 ae ; 19280:  45 10 44 88 dc bb e3 ae
            hex 7d db 96 7b 28 c5 0a 51 ; 19288:  7d db 96 7b 28 c5 0a 51
            hex 66 89 a6 58 ed b7 db 76 ; 19290:  66 89 a6 58 ed b7 db 76
            hex be ed db b7 26 53 cd 10 ; 19298:  be ed db b7 26 53 cd 10
            hex b7 a4 4b ac b7 ee 39 f7 ; 192A0:  b7 a4 4b ac b7 ee 39 f7
            hex ce bb f7 6e a2 54 49 12 ; 192A8:  ce bb f7 6e a2 54 49 12
            hex 66 10 cf 90 77 ed bb b6 ; 192B0:  66 10 cf 90 77 ed bb b6
            hex de 6b bd f7 b3 8c 63 5c ; 192B8:  de 6b bd f7 b3 8c 63 5c
            hex 91 a7 5a a4 db bb 76 dd ; 192C0:  91 a7 5a a4 db bb 76 dd
            hex f7 dd b7 6e 35 6b 44 9a ; 192C8:  f7 dd b7 6e 35 6b 44 9a
            hex 75 8a 55 aa 6f ba db f7 ; 192D0:  75 8a 55 aa 6f ba db f7
            hex bd 6b de f7 5b 69 96 aa ; 192D8:  bd 6b de f7 5b 69 96 aa
            hex 59 a6 7b 8c f7 ae 7d db ; 192E0:  59 a6 7b 8c f7 ae 7d db
            hex f7 ae bd 73 38 c5 2a d5 ; 192E8:  f7 ae bd 73 38 c5 2a d5
            hex 2a 55 aa b3 dd 6d fb 9e ; 192F0:  2a 55 aa b3 dd 6d fb 9e
            hex 77 ed bb ee aa 55 aa 93 ; 192F8:  77 ed bb ee aa 55 aa 93
            hex 6c 55 aa 57 de dd 77 bb ; 19300:  6c 55 aa 57 de dd 77 bb
            hex ed 77 de bb             ; 19308:  ed 77 de bb

            ldy $6a55                   ; 1930C:  ac 55 6a
            cmp $96,x                   ; 1930F:  d5 96
            adc $ab,x                   ; 19311:  75 ab
            jmp ($ddbb)                 ; 19313:  6c bb dd

            hex 76 bb df 76 ef bb b4 4d ; 19316:  76 bb df 76 ef bb b4 4d
            hex b3 d4 2d eb 1a e5 de bd ; 1931E:  b3 d4 2d eb 1a e5 de bd
            hex 73 ee dd 77 bb ee a3 4d ; 19326:  73 ee dd 77 bb ee a3 4d
            hex ba 24 ed 57 98 6f ed df ; 1932E:  ba 24 ed 57 98 6f ed df
            hex ba e7 bd bb 77 ef 16 6c ; 19336:  ba e7 bd bb 77 ef 16 6c
            hex b3 cc bb 26 f9 8f dd bb ; 1933E:  b3 cc bb 26 f9 8f dd bb
            hex ef de 75 db bf ff b2 97 ; 19346:  ef de 75 db bf ff b2 97
            hex 6d aa b3 7c 86 fb df    ; 1934E:  6d aa b3 7c 86 fb df

            sed                         ; 19355:  f8
            rti                         ; 19356:  40

tab_b6_9357: ; 630 bytes
            hex e0 e9 fe 7f bd 7f 78 c0 ; 19357:  e0 e9 fe 7f bd 7f 78 c0
            hex e0 a9 fe b3 dd 44 30 c4 ; 1935F:  e0 a9 fe b3 dd 44 30 c4
            hex 20 48 00 21 88 9e cd 34 ; 19367:  20 48 00 21 88 9e cd 34
            hex dc b8 70 e0 c0 c1 18 d4 ; 1936F:  dc b8 70 e0 c0 c1 18 d4
            hex 22 54 28 04 0a b6 e5 aa ; 19377:  22 54 28 04 0a b6 e5 aa
            hex dd 69 37 1a 0f 02 88 21 ; 1937F:  dd 69 37 1a 0f 02 88 21
            hex 15 8b 17 4a 10 00 00 06 ; 19387:  15 8b 17 4a 10 00 00 06
            hex 4f 3f bf 2f 06 40 80 50 ; 1938F:  4f 3f bf 2f 06 40 80 50
            hex 08 90 40 90 01 03 00 80 ; 19397:  08 90 40 90 01 03 00 80
            hex e0 e4 fb e7 86 6d db b7 ; 1939F:  e0 e4 fb e7 86 6d db b7
            hex ee 5d fb b7 dd cd 51 ae ; 193A7:  ee 5d fb b7 dd cd 51 ae
            hex 55 92 37 e9 56 de bb 6d ; 193AF:  55 92 37 e9 56 de bb 6d
            hex f6 bb af 76 dd 6b 48 b7 ; 193B7:  f6 bb af 76 dd 6b 48 b7
            hex 49 b4 4b bd 62 fb 77 1e ; 193BF:  49 b4 4b bd 62 fb 77 1e
            hex 3b bd f6 ef db fa 75 1d ; 193C7:  3b bd f6 ef db fa 75 1d
            hex 3b b3 fe 69 d6 bb 77 ec ; 193CF:  3b b3 fe 69 d6 bb 77 ec
            hex df bb ee db b7 df a4 5d ; 193D7:  df bb ee db b7 df a4 5d
            hex 73 4c fb 26 eb db de b5 ; 193DF:  73 4c fb 26 eb db de b5
            hex ef ba 67 fd db 44 b2 4d ; 193E7:  ef ba 67 fd db 44 b2 4d
            hex b2 94 67 18 eb bd 67 fe ; 193EF:  b2 94 67 18 eb bd 67 fe
            hex 99 ef 76 dd bb 31 cd b2 ; 193F7:  99 ef 76 dd bb 31 cd b2
            hex 09 f6 89 69 9e 77 ae fd ; 193FF:  09 f6 89 69 9e 77 ae fd
            hex db 6f f6 bb 6d 36 c9 b6 ; 19407:  db 6f f6 bb 6d 36 c9 b6
            hex 59 67 bc 93 6e 6e ed bb ; 1940F:  59 67 bc 93 6e 6e ed bb
            hex 77 de ed 3b f7 60 9b dd ; 19417:  77 de ed 3b f7 60 9b dd
            hex 22 6e d9 24 ff 7d d7 bb ; 1941F:  22 6e d9 24 ff 7d d7 bb
            hex ee 76 dd bb ee 42 36 44 ; 19427:  ee 76 dd bb ee 42 36 44
            hex a9 56 49 b2 26 ed 5d 73 ; 1942F:  a9 56 49 b2 26 ed 5d 73
            hex ee dd b7 76 ed a2 54 82 ; 19437:  ee dd b7 76 ed a2 54 82
            hex 35 c8 14 aa 49 b5 df 75 ; 1943F:  35 c8 14 aa 49 b5 df 75
            hex ae fb de 73 7e d9 14 e6 ; 19447:  ae fb de 73 7e d9 14 e6
            hex 19 e6 99 e2 5d db 6e bd ; 1944F:  19 e6 99 e2 5d db 6e bd
            hex eb df b6 ed bb a6 51 9a ; 19457:  eb df b6 ed bb a6 51 9a
            hex 55 a2 35 ca 59 db 6d b6 ; 1945F:  55 a2 35 ca 59 db 6d b6
            hex ed 5b 5d eb de aa 00 aa ; 19467:  ed 5b 5d eb de aa 00 aa
            hex 55 88 51 26 50 6d d7 ba ; 1946F:  55 88 51 26 50 6d d7 ba
            hex d5 37 ee 69 df 21 98 42 ; 19477:  d5 37 ee 69 df 21 98 42
            hex 24 88 11 a6 48 75 d7 bb ; 1947F:  24 88 11 a6 48 75 d7 bb
            hex 6e ed b7 dc 77 8b 54 22 ; 19487:  6e ed b7 dc 77 8b 54 22
            hex 55 88 33 a6 44 b6 75 5b ; 1948F:  55 88 33 a6 44 b6 75 5b
            hex ee bb ad f6 ad 49 92 64 ; 19497:  ee bb ad f6 ad 49 92 64
            hex 49 90 35 24 ca ab 5c f3 ; 1949F:  49 90 35 24 ca ab 5c f3
            hex 9d 6b ee 99 76 11 22 c4 ; 194A7:  9d 6b ee 99 76 11 22 c4
            hex 08 91 22 44 98 26 ed 59 ; 194AF:  08 91 22 44 98 26 ed 59
            hex d6 35 ce b3 dd 44 22 10 ; 194B7:  d6 35 ce b3 dd 44 22 10
            hex 80 46 10 88 21 ed 9b 76 ; 194BF:  80 46 10 88 21 ed 9b 76
            hex ed 5b b6 ed 9b 02 22 d8 ; 194C7:  ed 5b b6 ed 9b 02 22 d8
            hex 04 62 99 02 54 66 9d 79 ; 194CF:  04 62 99 02 54 66 9d 79
            hex e7 9d 76 eb 9c 88 44 22 ; 194D7:  e7 9d 76 eb 9c 88 44 22
            hex 91 08 44 22 51 ee 7d b7 ; 194DF:  91 08 44 22 51 ee 7d b7
            hex db 6e f7 bd 6e 33 ca 35 ; 194E7:  db 6e f7 bd 6e 33 ca 35
            hex a2 4d ba 44 bb db 77 ee ; 194EF:  a2 4d ba 44 bb db 77 ee
            hex dd bb 77 ee dd 45 ba 95 ; 194F7:  dd bb 77 ee dd 45 ba 95
            hex 66 9c d3 35 a6 db fb 2e ; 194FF:  66 9c d3 35 a6 db fb 2e
            hex fd db 76 df ed 55 aa 54 ; 19507:  fd db 76 df ed 55 aa 54
            hex ab aa 6a d5 9b 6d bb df ; 1950F:  ab aa 6a d5 9b 6d bb df
            hex f6 7d d7 bd ee 73 ae d3 ; 19517:  f6 7d d7 bd ee 73 ae d3
            hex 9c 6b ad d5 3a bb 77 ee ; 1951F:  9c 6b ad d5 3a bb 77 ee
            hex bd db 7f ea bf 34 e7 59 ; 19527:  bd db 7f ea bf 34 e7 59
            hex db d7 28 77 cd 7b b7 dd ; 1952F:  db d7 28 77 cd 7b b7 dd
            hex ef bd 77 dd ee e7 3c cb ; 19537:  ef bd 77 dd ee e7 3c cb
            hex 3b 66 de b5 4d ed 77 be ; 1953F:  3b 66 de b5 4d ed 77 be
            hex ed ef 7b dd f6 9b 66 b9 ; 19547:  ed ef 7b dd f6 9b 66 b9
            hex d7 2c eb 9d 66 d7 7e ef ; 1954F:  d7 2c eb 9d 66 d7 7e ef
            hex bb ee 76 bf db bf 4a b7 ; 19557:  bb ee 76 bf db bf 4a b7
            hex af 6a da 37 ef df 75 6e ; 1955F:  af 6a da 37 ef df 75 6e
            hex ff d9 77 bf f6 fb ad 57 ; 19567:  ff d9 77 bf f6 fb ad 57
            hex 7a ad f3 de 2b f6 be ee ; 1956F:  7a ad f3 de 2b f6 be ee
            hex 76 de ba 76 ee 5e aa 76 ; 19577:  76 de ba 76 ee 5e aa 76
            hex ce 7a ee 96 7a ed 7f 35 ; 1957F:  ce 7a ee 96 7a ed 7f 35
            hex 6e 5f 1b 0f 00 d6 6f 35 ; 19587:  6e 5f 1b 0f 00 d6 6f 35
            hex 7e 57 1f 0f 00 fe f8 e0 ; 1958F:  7e 57 1f 0f 00 fe f8 e0
            hex 00 00 60 fd 00 6e b8 e0 ; 19597:  00 00 60 fd 00 6e b8 e0
            hex 00 00 60 fc 00 00 00 00 ; 1959F:  00 00 60 fc 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 195A7:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 45 02 28 ; 195AF:  00 00 00 00 00 45 02 28
            hex 04 00 aa 65 26 10 00 00 ; 195B7:  04 00 aa 65 26 10 00 00
            hex 01 a4 62 46 60 48 a0 00 ; 195BF:  01 a4 62 46 60 48 a0 00
            hex 80 00 20 10 10 03       ; 195C7:  80 00 20 10 10 03

            brk                         ; 195CD:  00
            hex 00                      ; 195CE:  00
            brk                         ; 195CF:  00
            hex 08                      ; 195D0:  08
            rts                         ; 195D1:  60

            hex 31 20 88 20 00 00 00 00 ; 195D2:  31 20 88 20 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 195DA:  00 00 00 00 00 00 00 00
            hex 00 00 00 90 00 00 00 00 ; 195E2:  00 00 00 90 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 195EA:  00 00 00 00 00 00 00 00
            hex 00 00 ee ff 1d 03 07 35 ; 195F2:  00 00 ee ff 1d 03 07 35
            hex ff 00 bd f7 1d 03 07 37 ; 195FA:  ff 00 bd f7 1d 03 07 37
            hex ff 00 fd 6f bb f7 6f de ; 19602:  ff 00 fd 6f bb f7 6f de
            hex f0 00 dd 33 6d eb 9b 7e ; 1960A:  f0 00 dd 33 6d eb 9b 7e
            hex f0 00 ff 36 3d b7 3b 3e ; 19612:  f0 00 ff 36 3d b7 3b 3e
            hex 3e 0d fa 35 36 bb 2d 36 ; 1961A:  3e 0d fa 35 36 bb 2d 36
            hex 39 0e dd bb ef 76 db bd ; 19622:  39 0e dd bb ef 76 db bd
            hex f7 ee 48 d7 b2 6d 4d f3 ; 1962A:  f7 ee 48 d7 b2 6d 4d f3
            hex 8c 77 0f 0b 0f 0e 0d 0f ; 19632:  8c 77 0f 0b 0f 0e 0d 0f
            hex 0b 0e 0f 09 0e 0b 0e 0d ; 1963A:  0b 0e 0f 09 0e 0b 0e 0d
            hex 0b 0e 5b f7 5d ee fb 37 ; 19642:  0b 0e 5b f7 5d ee fb 37

            cmp $59ee,x                 ; 1964A:  dd ee 59
            ror $dd                     ; 1964D:  66 dd
            lsr $d9,x                   ; 1964F:  56 d9
            ldx $76,y                   ; 19651:  b6 76
            eor $dfb5                   ; 19653:  4d b5 df
            adc tab_b6_be5f+152         ; 19656:  6d f7 be
            sbc $fe5b                   ; 19659:  ed 5b fe
            ldx #$5e                    ; 1965C:  a2 5e
            cmp ($36),y                 ; 1965E:  d1 36
            tax                         ; 19660:  aa
            eor $b6,x                   ; 19661:  55 b6
            jmp $6ef6                   ; 19663:  4c f6 6e

            hex db 7f e6 bb fe a7 a6 59 ; 19666:  db 7f e6 bb fe a7 a6 59
            hex aa 94 eb 0c f3 4c b5 6f ; 1966E:  aa 94 eb 0c f3 4c b5 6f
            hex db fd b7 6e dd fb b3 59 ; 19676:  db fd b7 6e dd fb b3 59
            hex ce b2 bd c6 7b cc fa 6f ; 1967E:  ce b2 bd c6 7b cc fa 6f
            hex dd 7b b7 dd f7 6d b3 cd ; 19686:  dd 7b b7 dd f7 6d b3 cd
            hex 54 bb cc 33 d9 a6 dd ee ; 1968E:  54 bb cc 33 d9 a6 dd ee
            hex bb 77 dd bd eb ae b9 46 ; 19696:  bb 77 dd bd eb ae b9 46
            hex 99 e5 2c 4a d1 2e 7b e6 ; 1969E:  99 e5 2c 4a d1 2e 7b e6
            hex be bb 65 de bb          ; 196A6:  be bb 65 de bb

            sbc $2299                   ; 196AB:  ed 99 22
            jmp b6_8968+1               ; 196AE:  4c 69 89

            hex b2 4c 23 fe 69 df bb 6e ; 196B1:  b2 4c 23 fe 69 df bb 6e
            hex dd 77 da 69 92 6d 8a d4 ; 196B9:  dd 77 da 69 92 6d 8a d4
            hex 2b d4 a9 b6 db 6d bb de ; 196C1:  2b d4 a9 b6 db 6d bb de
            hex f3 9d 6f dc 21 4d b2 c9 ; 196C9:  f3 9d 6f dc 21 4d b2 c9
            hex 36 64 89 76 ed d7       ; 196D1:  36 64 89 76 ed d7

            lda $efb6,y                 ; 196D7:  b9 b6 ef
            jmp ($a2bb)                 ; 196DA:  6c bb a2

            hex 44 98 21 4a 54 a0 19 73 ; 196DD:  44 98 21 4a 54 a0 19 73
            hex ee 9b f5 6e 99 f7 6e 8a ; 196E5:  ee 9b f5 6e 99 f7 6e 8a
            hex 40 a4 11 8a 50 82 54 d7 ; 196ED:  40 a4 11 8a 50 82 54 d7
            hex 7c b7 cd 7b b6 ef 69 a6 ; 196F5:  7c b7 cd 7b b6 ef 69 a6
            hex 48 32 45 98 66 91 96 d9 ; 196FD:  48 32 45 98 66 91 96 d9
            hex b6 6f d9 5e f3 9c 77 88 ; 19705:  b6 6f d9 5e f3 9c 77 88
            hex 21 ca 10 26 c8 11 6a bb ; 1970D:  21 ca 10 26 c8 11 6a bb
            hex 76 df eb be d5 7f eb d9 ; 19715:  76 df eb be d5 7f eb d9
            hex 66 bd 93 7d a6 da 5d dd ; 1971D:  66 bd 93 7d a6 da 5d dd
            hex 77 ef ba df fb 6e b7 b3 ; 19725:  77 ef ba df fb 6e b7 b3
            hex a6 7e 45 fa 2d d7 b9 b5 ; 1972D:  a6 7e 45 fa 2d d7 b9 b5
            hex ef 7b ee db bd 77 ee b2 ; 19735:  ef 7b ee db bd 77 ee b2
            hex 6d db 35 ae d3 be d5 bb ; 1973D:  6d db 35 ae d3 be d5 bb
            hex 77 de fd b7 db 7d ef db ; 19745:  77 de fd b7 db 7d ef db
            hex b2 6d 57 f9 af b6 5d db ; 1974D:  b2 6d 57 f9 af b6 5d db
            hex 3d f7 de 7b ee db be 2f ; 19755:  3d f7 de 7b ee db be 2f
            hex d5 ea 9b ff 51 ae 7b bb ; 1975D:  d5 ea 9b ff 51 ae 7b bb
            hex f7 3d f6 df ed bf f6 6d ; 19765:  f7 3d f6 df ed bf f6 6d
            hex db b6 6d 7d 9b f6 dd 5d ; 1976D:  db b6 6d 7d 9b f6 dd 5d
            hex f7 db ff 6e b7 dd 7d f7 ; 19775:  f7 db ff 6e b7 dd 7d f7
            hex da bd 6f c6 7b dd d7 be ; 1977D:  da bd 6f c6 7b dd d7 be
            hex ec 60 e0 f0 70 00 80 fe ; 19785:  ec 60 e0 f0 70 00 80 fe
            hex ac e0 a0 f0 70 00 80 f6 ; 1978D:  ac e0 a0 f0 70 00 80 f6
            hex 5b ef fd d7 7e ed bf 7b ; 19795:  5b ef fd d7 7e ed bf 7b
            hex b6 ed df ba b7 fd ce c0 ; 1979D:  b6 ed df ba b7 fd ce c0
            hex e0 bc 77 dd f7 bb 6f c0 ; 197A5:  e0 bc 77 dd f7 bb 6f c0
            hex e0 fc b7 ef             ; 197AD:  e0 fc b7 ef

            adc tab_b6_bab1+294,x       ; 197B1:  7d d7 bb
            brk                         ; 197B4:  00
            hex 00                      ; 197B5:  00
            brk                         ; 197B6:  00
            hex 00                      ; 197B7:  00
            brk                         ; 197B8:  00
            hex 02                      ; 197B9:  02
            brk                         ; 197BA:  00
            hex 00                      ; 197BB:  00
            brk                         ; 197BC:  00
            hex 00                      ; 197BD:  00
            brk                         ; 197BE:  00
            hex 00                      ; 197BF:  00
            brk                         ; 197C0:  00
            hex 04                      ; 197C1:  04
            brk                         ; 197C2:  00
            hex 00                      ; 197C3:  00
            brk                         ; 197C4:  00
            hex 00                      ; 197C5:  00
            brk                         ; 197C6:  00
            hex 00                      ; 197C7:  00
            rts                         ; 197C8:  60

            hex 60                      ; 197C9:  60

            brk                         ; 197CA:  00
            hex 00                      ; 197CB:  00
            brk                         ; 197CC:  00
            hex 00                      ; 197CD:  00
            brk                         ; 197CE:  00
            hex 00                      ; 197CF:  00
            rts                         ; 197D0:  60

tab_b6_97d1: ; 479 bytes
            hex 40 00 00 00 00 00 00 00 ; 197D1:  40 00 00 00 00 00 00 00
            hex 03 00 00 00 00 00 00 03 ; 197D9:  03 00 00 00 00 00 00 03
            hex 00 00 00 00 00 00 00 00 ; 197E1:  00 00 00 00 00 00 00 00
            hex 09 00 00 00 00 00 00 0d ; 197E9:  09 00 00 00 00 00 00 0d
            hex 04 00 00 00 00 00 00 82 ; 197F1:  04 00 00 00 00 00 00 82
            hex 80 00 00 00 00 00 00 80 ; 197F9:  80 00 00 00 00 00 00 80
            hex 00 00 00 0b 0d 0f 0f 07 ; 19801:  00 00 00 0b 0d 0f 0f 07
            hex 01 00 00 0b 0d 0f 0f 07 ; 19809:  01 00 00 0b 0d 0f 0f 07
            hex 01 00 00 bb dd 77 ee fb ; 19811:  01 00 00 bb dd 77 ee fb
            hex 97 3e 75 fd 93 7e 66 fd ; 19819:  97 3e 75 fd 93 7e 66 fd
            hex 9d 36 7b 00 03 0f 0f 00 ; 19821:  9d 36 7b 00 03 0f 0f 00
            hex 00 00 00 00 03 0f 0f 00 ; 19829:  00 00 00 00 03 0f 0f 00
            hex 00 00 00 df fa ef ff 00 ; 19831:  00 00 00 df fa ef ff 00
            hex 00 00 00 ed b7 7e ff 00 ; 19839:  00 00 00 ed b7 7e ff 00
            hex 00 00 00 ae 77 dd eb be ; 19841:  00 00 00 ae 77 dd eb be
            hex 7b d6 dd b3 3e f1 ce b6 ; 19849:  7b d6 dd b3 3e f1 ce b6
            hex dd 72 ef db be eb 5d f7 ; 19851:  dd 72 ef db be eb 5d f7
            hex bb ee b7 5c eb 95 ba e6 ; 19859:  bb ee b7 5c eb 95 ba e6
            hex 59 f7 9a bb f7 df fe 00 ; 19861:  59 f7 9a bb f7 df fe 00
            hex 00 00 00 9d 76 db fe 00 ; 19869:  00 00 00 9d 76 db fe 00
            hex 00 00 00 dd fb b6 2d 7f ; 19871:  00 00 00 dd fb b6 2d 7f
            hex 7b 6d 76 65 ee b9 37 7a ; 19879:  7b 6d 76 65 ee b9 37 7a
            hex 65 5d 76 b7 ee bd 6b df ; 19881:  65 5d 76 b7 ee bd 6b df
            hex 75 ee db 57 b2 4c eb 55 ; 19889:  75 ee db 57 b2 4c eb 55
            hex ac 73 4c f9 ce b7 dd 7a ; 19891:  ac 73 4c f9 ce b7 dd 7a
            hex b7 ed dd 7a 46 c9 bb 24 ; 19899:  b7 ed dd 7a 46 c9 bb 24
            hex ed 33 cc 7b b6 ef dd bb ; 198A1:  ed 33 cc 7b b6 ef dd bb
            hex 76 dd f7 b3 da 2d b1 6e ; 198A9:  76 dd f7 b3 da 2d b1 6e
            hex c9 37 d4 37 fb ce 7e b3 ; 198B1:  c9 37 d4 37 fb ce 7e b3
            hex dd f7 9d 33 cc 36 c9 66 ; 198B9:  dd f7 9d 33 cc 36 c9 66
            hex 9c 63 5c 9e fb 66 dd bb ; 198C1:  9c 63 5c 9e fb 66 dd bb
            hex b7 ea 5f 68 93 54 23 cc ; 198C9:  b7 ea 5f 68 93 54 23 cc
            hex 3a 41 d6 e5 be d9 b7 6e ; 198D1:  3a 41 d6 e5 be d9 b7 6e
            hex b9 cf 7a 84 29 d4 0a 61 ; 198D9:  b9 cf 7a 84 29 d4 0a 61
            hex 9a 44 aa b4 6f db dc bb ; 198E1:  9a 44 aa b4 6f db dc bb
            hex e5 3c d9 19 66 d2 8d 32 ; 198E9:  e5 3c d9 19 66 d2 8d 32
            hex e8 49 90 db b5 6d d8 b8 ; 198F1:  e8 49 90 db b5 6d d8 b8
            hex 68 c0 b0 11 4c 71 88 54 ; 198F9:  68 c0 b0 11 4c 71 88 54
            hex 30 c0 28 dd 7b f7 ae 7d ; 19901:  30 c0 28 dd 7b f7 ae 7d
            hex db ef b6 56 6d db 4d 76 ; 19909:  db ef b6 56 6d db 4d 76
            hex db 4d 7b fb 6f dd b6 f7 ; 19911:  db 4d 7b fb 6f dd b6 f7
            hex 7d ae f6 db 26 fd 4b b6 ; 19919:  7d ae f6 db 26 fd 4b b6
            hex 7d c3 5e ee 77 dd eb bf ; 19921:  7d c3 5e ee 77 dd eb bf
            hex 76 dd b7 cd b7 76 5b ed ; 19929:  76 dd b7 cd b7 76 5b ed
            hex 56 db 7f ed bf db 77 bc ; 19931:  56 db 7f ed bf db 77 bc
            hex f7 db 6e 37 ed db 6e bb ; 19939:  f7 db 6e 37 ed db 6e bb
            hex f6 af 7a fb 6e bf aa 9f ; 19941:  f6 af 7a fb 6e bf aa 9f
            hex bd 2b 9f 64 df db 36 9d ; 19949:  bd 2b 9f 64 df db 36 9d
            hex af 39 8f ff da bb ef 7d ; 19951:  af 39 8f ff da bb ef 7d
            hex eb be 77 d7 dd 6f f9 bf ; 19959:  eb be 77 d7 dd 6f f9 bf
            hex 66 df 79 db ef 39 fc e8 ; 19961:  66 df 79 db ef 39 fc e8
            hex dc 7e ef bb 7f d9 ec b8 ; 19969:  dc 7e ef bb 7f d9 ec b8
            hex dc 76 ef dd ff f0 00 00 ; 19971:  dc 76 ef dd ff f0 00 00
            hex 00 00 80 ef 7f f0 00 00 ; 19979:  00 00 80 ef 7f f0 00 00
            hex 00 00 80 bd ec f8 2e fa ; 19981:  00 00 80 bd ec f8 2e fa
            hex de b6 fe dd bc 78 ee be ; 19989:  de b6 fe dd bc 78 ee be
            hex da 76 f6 e0 78 00 00 00 ; 19991:  da 76 f6 e0 78 00 00 00
            hex 00 00 00 e0 78 00 00 00 ; 19999:  00 00 00 e0 78 00 00 00
            hex 00 00 00 00 24 18 1c 00 ; 199A1:  00 00 00 00 24 18 1c 00
            hex 00 00 00 00 0c 08 0c    ; 199A9:  00 00 00 00 0c 08 0c

            brk                         ; 199B0:  00
            hex 00                      ; 199B1:  00
            brk                         ; 199B2:  00
            hex 00                      ; 199B3:  00
            brk                         ; 199B4:  00
            hex 60                      ; 199B5:  60
            rts                         ; 199B6:  60

            hex 40                      ; 199B7:  40

            brk                         ; 199B8:  00
            hex 00                      ; 199B9:  00
            brk                         ; 199BA:  00
            hex 00                      ; 199BB:  00
            brk                         ; 199BC:  00
            hex 40                      ; 199BD:  40
            rts                         ; 199BE:  60

tab_b6_99bf: ; 55 bytes
            hex 60 00 00 00 00 00 22 33 ; 199BF:  60 00 00 00 00 00 22 33
            hex 33 00 00 00 00 00 32 32 ; 199C7:  33 00 00 00 00 00 32 32
            hex 10 00 00 00 00 5f 6d 3b ; 199CF:  10 00 00 00 00 5f 6d 3b
            hex 06 0f 1a bb f7 4a 5d 36 ; 199D7:  06 0f 1a bb f7 4a 5d 36
            hex 05 0d 3a eb d6 de 3b 0f ; 199DF:  05 0d 3a eb d6 de 3b 0f
            hex 00 00 00 00 03 fd 3d 0e ; 199E7:  00 00 00 00 03 fd 3d 0e
            hex 00 00 00 00 01 9d fb    ; 199EF:  00 00 00 00 01 9d fb

            ror $f6db                   ; 199F6:  6e db f6
            sta $79ef,x                 ; 199F9:  9d ef 79
            lda #$df                    ; 199FC:  a9 df
            sta ($76),y                 ; 199FE:  91 76
            tax                         ; 19A00:  aa
            cmp $3b,x                   ; 19A01:  d5 3b
            dec $76                     ; 19A03:  c6 76
            inc $bad8                   ; 19A05:  ee d8 ba
b6_9a08:    cpx $a8                     ; 19A08:  e4 a8
            bvs tab_b6_99bf+33          ; 19A0A:  70 d4
            ldx #$5c                    ; 19A0C:  a2 5c
            ldy #$5c                    ; 19A0E:  a0 5c
            ldx #$58                    ; 19A10:  a2 58
            tay                         ; 19A12:  a8
            bvc tab_b6_99bf+52          ; 19A13:  50 de
            ldx $78,y                   ; 19A15:  b6 78
            dec $381c                   ; 19A17:  ce 1c 38
            bvs b6_9a08                 ; 19A1A:  70 ec
            clv                         ; 19A1C:  b8
            lsr $f0,x                   ; 19A1D:  56 f0
            sty $1412                   ; 19A1F:  8c 12 14
            inx                         ; 19A22:  e8
            txa                         ; 19A23:  8a
            dey                         ; 19A24:  88
            bcc b6_9a27                 ; 19A25:  90 00
b6_9a27:    brk                         ; 19A27:  00
            hex 80                      ; 19A28:  80
            brk                         ; 19A29:  00
            hex 00                      ; 19A2A:  00
b6_9a2b:    brk                         ; 19A2B:  00
            hex a8                      ; 19A2C:  a8
            bpl tab_b6_97d1+478         ; 19A2D:  10 80
            brk                         ; 19A2F:  00
            hex 00                      ; 19A30:  00
            brk                         ; 19A31:  00
            hex 00                      ; 19A32:  00
            brk                         ; 19A33:  00
            hex e0                      ; 19A34:  e0
            ldy brk_dispatch_id,x                   ; 19A35:  b4 50
            bvs tab_b6_9a55+4           ; 19A37:  70 20
            pla                         ; 19A39:  68
            bvc b6_9a3c                 ; 19A3A:  50 00
b6_9a3c:    bcs tab_b6_9a55+49          ; 19A3C:  b0 48
            jsr $00d9                   ; 19A3E:  20 d9 00
            sec                         ; 19A41:  38
            rti                         ; 19A42:  40

            brk                         ; 19A43:  00
            hex 68                      ; 19A44:  68
            bne b6_9a47                 ; 19A45:  d0 00
b6_9a47:    cld                         ; 19A47:  d8
            bvc tab_b6_9a55+85          ; 19A48:  50 60
            bpl b6_9a2b+1               ; 19A4A:  10 e0
            bne b6_9a4e                 ; 19A4C:  d0 00
b6_9a4e:    brk                         ; 19A4E:  00
            hex 50                      ; 19A4F:  50
            rti                         ; 19A50:  40

            jsr DMC_FREQ                ; 19A51:  20 10 40
            rti                         ; 19A54:  40

tab_b6_9a55: ; 178 bytes
            hex 10 50 00 00 00 00 00 40 ; 19A55:  10 50 00 00 00 00 00 40
            hex 10 40 00 00 00 00 00 9d ; 19A5D:  10 40 00 00 00 00 00 9d
            hex 39 ee b7 5a 28 7d 17 b9 ; 19A65:  39 ee b7 5a 28 7d 17 b9
            hex 15 ee 39 48 30 6d 16 0c ; 19A6D:  15 ee 39 48 30 6d 16 0c
            hex 21 10 0e 02 00 00 08 00 ; 19A75:  21 10 0e 02 00 00 08 00
            hex 11 00 06 00 00 00 00 06 ; 19A7D:  11 00 06 00 00 00 00 06
            hex 1f 0d 23 0e 07 01 0b 06 ; 19A85:  1f 0d 23 0e 07 01 0b 06
            hex 1b 0f 21 17 0a 01 07 dd ; 19A8D:  1b 0f 21 17 0a 01 07 dd
            hex fb ae ef c8 4f a5 ab d6 ; 19A95:  fb ae ef c8 4f a5 ab d6
            hex bf 6e c9 45 cd a3 2e 05 ; 19A9D:  bf 6e c9 45 cd a3 2e 05
            hex 00 03 0e 03 00 00 01 0d ; 19AA5:  00 03 0e 03 00 00 01 0d
            hex 01 06 0a 01 00 01 01 43 ; 19AAD:  01 06 0a 01 00 01 01 43
            hex 8e 85 81 a0 00 00 80 c1 ; 19AB5:  8e 85 81 a0 00 00 80 c1
            hex 83 c7 80 00 00 00 00 9c ; 19ABD:  83 c7 80 00 00 00 00 9c
            hex c0 80 c0 e0 30 bc 87 9c ; 19AC5:  c0 80 c0 e0 30 bc 87 9c
            hex c0 80 c0 60 b0 ac 97 2d ; 19ACD:  c0 80 c0 60 b0 ac 97 2d
            hex 9f 1d 15 07 17 0d 07 2b ; 19AD5:  9f 1d 15 07 17 0d 07 2b
            hex 0f 16 1d 05 1f 0b 07 80 ; 19ADD:  0f 16 1d 05 1f 0b 07 80
            hex 80 80 80 80 00 00 00 80 ; 19AE5:  80 80 80 80 00 00 00 80
            hex 80 80 80 00 00 00 00 03 ; 19AED:  80 80 80 00 00 00 00 03
            hex 00 00 00 03 02 03 21 03 ; 19AF5:  00 00 00 03 02 03 21 03
            hex 00 00 00 01 02 01 01 50 ; 19AFD:  00 00 00 01 02 01 01 50
            hex f0 3c                   ; 19B05:  f0 3c

            bvs tab_b6_9a55+124         ; 19B07:  70 c8
            rts                         ; 19B09:  60

            hex b8 d0 20 f0 28 72 e0 10 ; 19B0A:  b8 d0 20 f0 28 72 e0 10
            hex e8 00 1e 04 04 00 00 00 ; 19B12:  e8 00 1e 04 04 00 00 00
            hex 00 00 1e 04 04 00 00 00 ; 19B1A:  00 00 1e 04 04 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19B22:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 01 02 03 00 ; 19B2A:  00 00 00 00 01 02 03 00
            hex 00 00 04 05 06 00 00 00 ; 19B32:  00 00 04 05 06 00 00 00
            hex 00 00 00 07 08 00 00 00 ; 19B3A:  00 00 00 07 08 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19B42:  00 00 00 00 00 00 00 00
            hex 00 00 00 0c 0f 10 13 14 ; 19B4A:  00 00 00 0c 0f 10 13 14
            hex 14 14 19 1a 1d 14 20 00 ; 19B52:  14 14 19 1a 1d 14 20 00
            hex 23 24 27 28 00 00 00 00 ; 19B5A:  23 24 27 28 00 00 00 00
            hex 00 00 00 00 00 00 00 09 ; 19B62:  00 00 00 00 00 00 00 09
            hex 0a 0b 0d 0e 11 12 15 16 ; 19B6A:  0a 0b 0d 0e 11 12 15 16
            hex 17 18 1b 1c 1e 1f 21 22 ; 19B72:  17 18 1b 1c 1e 1f 21 22
            hex 25 26 29 2a 2b          ; 19B7A:  25 26 29 2a 2b

            bit ptr0_lo                     ; 19B7F:  24 00
            brk                         ; 19B81:  00
            hex 00                      ; 19B82:  00
            brk                         ; 19B83:  00
            hex 00                      ; 19B84:  00
            brk                         ; 19B85:  00
            hex 00                      ; 19B86:  00
            brk                         ; 19B87:  00
            hex 00                      ; 19B88:  00
            hex 2c 2e 00 ; bit $002e    ; 19B89:  2c 2e 00
            and ($32),y                 ; 19B8C:  31 32
            and $36,x                   ; 19B8E:  35 36
            and $3d3a,y                 ; 19B90:  39 3a 3d
            rol $4241,x                 ; 19B93:  3e 41 42
            eor $46                     ; 19B96:  45 46
            eor #$14                    ; 19B98:  49 14
            jmp $4f00                   ; 19B9A:  4c 00 4f

            hex 50 53 00 00 00 00 00 00 ; 19B9D:  50 53 00 00 00 00 00 00
            hex 00 00 00 00 2d 2f 30 33 ; 19BA5:  00 00 00 00 2d 2f 30 33
            hex 34 37 38 3b 3c 3f 40 43 ; 19BAD:  34 37 38 3b 3c 3f 40 43
            hex 44 47 48 4a 4b 4d 4e 51 ; 19BB5:  44 47 48 4a 4b 4d 4e 51
            hex 52 54 00 00 00 00 00 00 ; 19BBD:  52 54 00 00 00 00 00 00
            hex 00 00 00 00 00 56 57 5a ; 19BC5:  00 00 00 00 00 56 57 5a
            hex 5b 5e 5f 62 63 66 67 6a ; 19BCD:  5b 5e 5f 62 63 66 67 6a
            hex 6b 6e 6f 72 73 76 77 7a ; 19BD5:  6b 6e 6f 72 73 76 77 7a
            hex 7b                      ; 19BDD:  7b

            brk                         ; 19BDE:  00
            hex 00                      ; 19BDF:  00
            brk                         ; 19BE0:  00
            hex 00                      ; 19BE1:  00
            brk                         ; 19BE2:  00
            hex 00                      ; 19BE3:  00
            brk                         ; 19BE4:  00
            hex 00                      ; 19BE5:  00
            brk                         ; 19BE6:  00
            hex 00                      ; 19BE7:  00
            brk                         ; 19BE8:  00
            hex 55                      ; 19BE9:  55
            cli                         ; 19BEA:  58
            eor $5d5c,y                 ; 19BEB:  59 5c 5d
            rts                         ; 19BEE:  60

tab_b6_9bef: ; 468 bytes
            hex 61 64 65 68 69 6c 6d 70 ; 19BEF:  61 64 65 68 69 6c 6d 70
            hex 71 74 75 78 79 7c 7d 7e ; 19BF7:  71 74 75 78 79 7c 7d 7e
            hex 00 00 00 00 00 00 00 00 ; 19BFF:  00 00 00 00 00 00 00 00
            hex 00 00 7f 81 82 85 86 89 ; 19C07:  00 00 7f 81 82 85 86 89
            hex 8a 8d 8e 91 92 94 95 97 ; 19C0F:  8a 8d 8e 91 92 94 95 97
            hex 98 9b 9c 9f a0 a3 a4 a7 ; 19C17:  98 9b 9c 9f a0 a3 a4 a7
            hex 00 00 00 00 00 00 00 00 ; 19C1F:  00 00 00 00 00 00 00 00
            hex 00 00 80 83 84 87 88 8b ; 19C27:  00 00 80 83 84 87 88 8b
            hex 8c 8f 90 93 00 00 96 99 ; 19C2F:  8c 8f 90 93 00 00 96 99
            hex 9a 9d 9e a1 a2 a5 a6 00 ; 19C37:  9a 9d 9e a1 a2 a5 a6 00
            hex 00 00 00 00 00 00 00 00 ; 19C3F:  00 00 00 00 00 00 00 00
            hex 00 00 a8 aa ab ae af b2 ; 19C47:  00 00 a8 aa ab ae af b2
            hex b3 b6 b7 ba bb be bf c2 ; 19C4F:  b3 b6 b7 ba bb be bf c2
            hex c3 c5 c6 c9 ca cd ce 00 ; 19C57:  c3 c5 c6 c9 ca cd ce 00
            hex 00 00 00 00 00 00 00 00 ; 19C5F:  00 00 00 00 00 00 00 00
            hex 00 00 a9 ac ad b0 b1 b4 ; 19C67:  00 00 a9 ac ad b0 b1 b4
            hex b5 b8 b9 bc bd c0 c1 c4 ; 19C6F:  b5 b8 b9 bc bd c0 c1 c4
            hex 00 c7 c8 cb cc 00 cf 0b ; 19C77:  00 c7 c8 cb cc 00 cf 0b
            hex 00 00 00 00 00 00 00 d0 ; 19C7F:  00 00 00 00 00 00 00 d0
            hex d1 d4 d5 d7 d8 db dc df ; 19C87:  d1 d4 d5 d7 d8 db dc df
            hex e0 e3 e4 e7 e8 00 00 00 ; 19C8F:  e0 e3 e4 e7 e8 00 00 00
            hex ea ec ed f0 f1 00 f2 00 ; 19C97:  ea ec ed f0 f1 00 f2 00
            hex 00 00 00 00 00 00 00 d2 ; 19C9F:  00 00 00 00 00 00 00 d2
            hex d3 d6 00 d9 da dd de e1 ; 19CA7:  d3 d6 00 d9 da dd de e1
            hex e2 e5 e6 e9 00 00 00 00 ; 19CAF:  e2 e5 e6 e9 00 00 00 00
            hex eb ee ef 00 00 00 f3 00 ; 19CB7:  eb ee ef 00 00 00 f3 00
            hex 00 00 00 00 00 00 00 00 ; 19CBF:  00 00 00 00 00 00 00 00
            hex 00 00 f4 f5 f6 00 f7 00 ; 19CC7:  00 00 f4 f5 f6 00 f7 00
            hex f8 fa fb fd 00 00 00 00 ; 19CCF:  f8 fa fb fd 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19CD7:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19CDF:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19CE7:  00 00 00 00 00 00 00 00
            hex f9 fc 00 00 00 00 00 00 ; 19CEF:  f9 fc 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19CF7:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19CFF:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19D07:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 19D0F:  00 00 00 00 00 00 00 00
            hex 00 00 00 01 00 00 00 00 ; 19D17:  00 00 00 01 00 00 00 00
            hex 00 00 00 01 00 00 00 00 ; 19D1F:  00 00 00 01 00 00 00 00
            hex 00 1f 3f ff 3c 00 00 00 ; 19D27:  00 1f 3f ff 3c 00 00 00
            hex 00 1f 3f ff 3c 00 00 00 ; 19D2F:  00 1f 3f ff 3c 00 00 00
            hex c0 e0 f0 c0 00 00 00 00 ; 19D37:  c0 e0 f0 c0 00 00 00 00
            hex c0 e0 f0 c0 00 00 00 00 ; 19D3F:  c0 e0 f0 c0 00 00 00 00
            hex 00 00 0e 07 03 00 00 00 ; 19D47:  00 00 0e 07 03 00 00 00
            hex 00 00 0e 07 03 00 30 18 ; 19D4F:  00 00 0e 07 03 00 30 18
            hex 1c 1c 1c 1f 9f 00 30 18 ; 19D57:  1c 1c 1c 1f 9f 00 30 18
            hex 1c 1c 1c 1f 9f 00 00 00 ; 19D5F:  1c 1c 1c 1f 9f 00 00 00
            hex 00 00 00 c0 c0 00 00 00 ; 19D67:  00 00 00 c0 c0 00 00 00
            hex 00 00 00 c0 c0 00 00 00 ; 19D6F:  00 00 00 c0 c0 00 00 00
            hex 02 03 0f 07 0f 00 00 00 ; 19D77:  02 03 0f 07 0f 00 00 00
            hex 02 03 0f 07 0f 00 00 00 ; 19D7F:  02 03 0f 07 0f 00 00 00
            hex 00 00 80 80 80 00 00 00 ; 19D87:  00 00 80 80 80 00 00 00
            hex 00 00 80 80 80 00 00 00 ; 19D8F:  00 00 80 80 80 00 00 00
            hex 00 00 00 00 01 00 00 00 ; 19D97:  00 00 00 00 01 00 00 00
            hex 00 00 00 00 01 00 00 00 ; 19D9F:  00 00 00 00 01 00 00 00
            hex c0 ef ff ff fe 00 00 00 ; 19DA7:  c0 ef ff ff fe 00 00 00
            hex c0 ef ff ff fe 00 00 00 ; 19DAF:  c0 ef ff ff fe 00 00 00
            hex 00 00 80 80 00 00 00 00 ; 19DB7:  00 00 80 80 00 00 00 00
            hex 00 00 80 80             ; 19DBF:  00 00 80 80

            brk                         ; 19DC3:  00
            hex 00                      ; 19DC4:  00
            brk                         ; 19DC5:  00
            hex 00                      ; 19DC6:  00
            brk                         ; 19DC7:  00
            hex 40                      ; 19DC8:  40
            rti                         ; 19DC9:  40

            hex 42 63                   ; 19DCA:  42 63

            brk                         ; 19DCC:  00
            hex 00                      ; 19DCD:  00
            brk                         ; 19DCE:  00
            hex 00                      ; 19DCF:  00
            rti                         ; 19DD0:  40

tab_b6_9dd1: ; 295 bytes
            hex 40 42 63 0c 0c 06 03 00 ; 19DD1:  40 42 63 0c 0c 06 03 00
            hex 7c 3e 02 0c 0c 06 03 00 ; 19DD9:  7c 3e 02 0c 0c 06 03 00
            hex 7c 3e 02 31 7b f2 30 71 ; 19DE1:  7c 3e 02 31 7b f2 30 71
            hex f0 93 fb 31 79 f2 30 70 ; 19DE9:  f0 93 fb 31 79 f2 30 70
            hex f0 93 fb 11 02 00 2a 55 ; 19DF1:  f0 93 fb 11 02 00 2a 55
            hex 22 11 db 00 00 00 00 00 ; 19DF9:  22 11 db 00 00 00 00 00
            hex 00 00 c0 80 60 81 8a 45 ; 19E01:  00 00 c0 80 60 81 8a 45
            hex 4c 8e 0e 00 00 00 00 00 ; 19E09:  4c 8e 0e 00 00 00 00 00
            hex 0c 0e 0e c8 80 00 11 2b ; 19E11:  0c 0e 0e c8 80 00 11 2b
            hex 14 d4 04 c0 80 00 01 02 ; 19E19:  14 d4 04 c0 80 00 01 02
            hex 00 02 20 1f 3f f0 c3 1f ; 19E21:  00 02 20 1f 3f f0 c3 1f
            hex 3b 23 2f 1f 3f f0 c3 1f ; 19E29:  3b 23 2f 1f 3f f0 c3 1f
            hex 3b 23 2f 02 6c 81 9a 55 ; 19E31:  3b 23 2f 02 6c 81 9a 55
            hex 2a 15 fa 00 00 00 00 00 ; 19E39:  2a 15 fa 00 00 00 00 00
            hex 00 00 f0 92 6c 81 9a 55 ; 19E41:  00 00 f0 92 6c 81 9a 55
            hex 6a 95 aa 00 00 00 00 00 ; 19E49:  6a 95 aa 00 00 00 00 00
            hex 00 00 00 f0 01 00 c0 00 ; 19E51:  00 00 00 f0 01 00 c0 00
            hex 00 1c a2 f2 00 01 f6 1d ; 19E59:  00 1c a2 f2 00 01 f6 1d
            hex 0f 3f bd 66 15 4a 51 06 ; 19E61:  0f 3f bd 66 15 4a 51 06
            hex 08 42 10 00 80 80 a0 91 ; 19E69:  08 42 10 00 80 80 a0 91
            hex e4 e0 e9 67 30 a1 30 1c ; 19E71:  e4 e0 e9 67 30 a1 30 1c
            hex 1e 38 c0 00 09 26 b8 1e ; 19E79:  1e 38 c0 00 09 26 b8 1e
            hex 1d 79 e0 22 ac 11 0e 21 ; 19E81:  1d 79 e0 22 ac 11 0e 21
            hex b5 20 c0 00 01 c4 20 0a ; 19E89:  b5 20 c0 00 01 c4 20 0a
            hex bb ac 40 81 43 8f 9f 55 ; 19E91:  bb ac 40 81 43 8f 9f 55
            hex 41 81 8f 01 03 0f 0f 05 ; 19E99:  41 81 8f 01 03 0f 0f 05
            hex 01 01 0f fa f8 f1 f0 ff ; 19EA1:  01 01 0f fa f8 f1 f0 ff
            hex e7 b6 be fa f8 f0 f0 ff ; 19EA9:  e7 b6 be fa f8 f0 f0 ff
            hex e7 b6 be 0c 2e af 02 04 ; 19EB1:  e7 b6 be 0c 2e af 02 04
            hex 0f 18 30 0c 4e 4f 82 84 ; 19EB9:  0f 18 30 0c 4e 4f 82 84
            hex 0f 18 30 fc f8 e7 10 80 ; 19EC1:  0f 18 30 fc f8 e7 10 80
            hex 33 3f 7b fc f8 e7 10 80 ; 19EC9:  33 3f 7b fc f8 e7 10 80
            hex 33 3f 7b 02 0c 01 9a 55 ; 19ED1:  33 3f 7b 02 0c 01 9a 55
            hex 6a 15 2a 00 00 00 00 00 ; 19ED9:  6a 15 2a 00 00 00 00 00
            hex 00 00 00 1c 33 f4 72 e3 ; 19EE1:  00 00 00 1c 33 f4 72 e3
            hex c0 82 c8 00 30 f0 71 e0 ; 19EE9:  c0 82 c8 00 30 f0 71 e0
            hex c2 87 c7 ab 14 ab 44    ; 19EF1:  c2 87 c7 ab 14 ab 44

            plp                         ; 19EF8:  28
            pha                         ; 19EF9:  48
            bpl tab_b6_9dd1+171         ; 19EFA:  10 80
            brk                         ; 19EFC:  00
            hex 00                      ; 19EFD:  00
            rti                         ; 19EFE:  40

            hex 10 44 90 a0 e8 a0 48 00 ; 19EFF:  10 44 90 a0 e8 a0 48 00
            hex 12 a1 00 a8 41 00 00 00 ; 19F07:  12 a1 00 a8 41 00 00 00
            hex 00 00 00 00 00 54 48 a8 ; 19F0F:  00 00 00 00 00 54 48 a8
            hex 1b 02 3c 72             ; 19F17:  1b 02 3c 72

            sbc (ptr0_lo,x)                 ; 19F1B:  e1 00
            brk                         ; 19F1D:  00
            hex 00                      ; 19F1E:  00
            brk                         ; 19F1F:  00
            hex 00                      ; 19F20:  00
            bmi tab_b6_9f28+107         ; 19F21:  30 70
            cpx #$a0                    ; 19F23:  e0 a0
            jmp $1203                   ; 19F25:  4c 03 12

tab_b6_9f28: ; 110 bytes
            hex a1 00 a8 41 00 04 03 00 ; 19F28:  a1 00 a8 41 00 04 03 00
            hex 00 00 00 00 00 00 00 00 ; 19F30:  00 00 00 00 00 00 00 00
            hex 00 00 07 1f 00 00 00 00 ; 19F38:  00 00 07 1f 00 00 00 00
            hex 00 00 07 1f 00 00 00 00 ; 19F40:  00 00 07 1f 00 00 00 00
            hex 00 00 00 80 00 00 00 00 ; 19F48:  00 00 00 80 00 00 00 00
            hex 00 00 00 80 7f ff ff 07 ; 19F50:  00 00 00 80 7f ff ff 07
            hex 07 07 07 07 7f ff ff 07 ; 19F58:  07 07 07 07 7f ff ff 07
            hex 07 07 07 07 80 00 00 00 ; 19F60:  07 07 07 07 80 00 00 00
            hex 70 38 00 00 80 00 00 00 ; 19F68:  70 38 00 00 80 00 00 00
            hex 70 38 00 00 00 00 00 00 ; 19F70:  70 38 00 00 00 00 00 00
            hex 00 00 01 03 00 00 00 00 ; 19F78:  00 00 01 03 00 00 00 00
            hex 00 00 01 03 0e 1c 3c 78 ; 19F80:  00 00 01 03 0e 1c 3c 78
            hex 78 fc de cf 0e 1c 3c 78 ; 19F88:  78 fc de cf 0e 1c 3c 78
            hex 78 fc de cf 07 07       ; 19F90:  78 fc de cf 07 07

            asl $701c,x                 ; 19F96:  1e 1c 70
            rts                         ; 19F99:  60

            hex 00 01 07 07             ; 19F9A:  00 01 07 07

            asl $701c,x                 ; 19F9E:  1e 1c 70
            rts                         ; 19FA1:  60

            hex 00 01 87 01 00 00 00 00 ; 19FA2:  00 01 87 01 00 00 00 00
            hex 41 e4 87 01 00 00 00 00 ; 19FAA:  41 e4 87 01 00 00 00 00
            hex 41 e4 c0 e0 f0 3c 0c 06 ; 19FB2:  41 e4 c0 e0 f0 3c 0c 06
            hex e3 30 c0 e0 f0 3c 0c 06 ; 19FBA:  e3 30 c0 e0 f0 3c 0c 06
            hex e3 30 0f 07 01 01 03 03 ; 19FC2:  e3 30 0f 07 01 01 03 03
            hex 03 06 0f 07 01 01 03 03 ; 19FCA:  03 06 0f 07 01 01 03 03
            hex 03 06 06 0c 1d 19 39 30 ; 19FD2:  03 06 06 0c 1d 19 39 30
            hex 60 c0 06 0c 1d 19 39 30 ; 19FDA:  60 c0 06 0c 1d 19 39 30
            hex 60 c0 f0 ee c6 c6 c6 e6 ; 19FE2:  60 c0 f0 ee c6 c6 c6 e6
            hex f6 d6 f0 ee c6 c6 c6 e6 ; 19FEA:  f6 d6 f0 ee c6 c6 c6 e6
            hex f6 d6 b6 b6 b7 97 9f 1e ; 19FF2:  f6 d6 b6 b6 b7 97 9f 1e
            hex 1e 0e b6 b6 b7 97 9f 1e ; 19FFA:  1e 0e b6 b6 b7 97 9f 1e
            hex 1e 0e 05 22 4f 04 1a 25 ; 1A002:  1e 0e 05 22 4f 04 1a 25
            hex 2a 35 00 00 00 00 00 00 ; 1A00A:  2a 35 00 00 00 00 00 00
            hex 00 00 0b 1b 36 76 6d 3f ; 1A012:  00 00 0b 1b 36 76 6d 3f
            hex 3a 70 0b 1b 36 76 6d 3f ; 1A01A:  3a 70 0b 1b 36 76 6d 3f
            hex 3a 70 ff ee ce 9e c2 03 ; 1A022:  3a 70 ff ee ce 9e c2 03
            hex 01 2d ff ee ce 9e c2 0b ; 1A02A:  01 2d ff ee ce 9e c2 0b
            hex 07 1b 80 40 ac 4a d4 a0 ; 1A032:  07 1b 80 40 ac 4a d4 a0
            hex 10 62 01 00 02 14       ; 1A03A:  10 62 01 00 02 14

            brk                         ; 1A040:  00
            hex 04                      ; 1A041:  04
            brk                         ; 1A042:  00
            hex 02                      ; 1A043:  02
            plp                         ; 1A044:  28
            ora ($40,x)                 ; 1A045:  01 40
            rti                         ; 1A047:  40

            hex 47 4f 78 e0 57 bf 23 41 ; 1A048:  47 4f 78 e0 57 bf 23 41
            hex 47 4f                   ; 1A050:  47 4f

            sei                         ; 1A052:  78
            cpx #$20                    ; 1A053:  e0 20
            clc                         ; 1A055:  18
            rts                         ; 1A056:  60

            hex 41 61 61 f3 fb 1c 00 58 ; 1A057:  41 61 61 f3 fb 1c 00 58
            hex 49 61 61 f3 fb 51 ce 98 ; 1A05F:  49 61 61 f3 fb 51 ce 98
            hex 8d 87 07 0f bc 51 ce 98 ; 1A067:  8d 87 07 0f bc 51 ce 98
            hex 8d 87 07 0f bc 3e 0c 9c ; 1A06F:  8d 87 07 0f bc 3e 0c 9c

            pla                         ; 1A077:  68
            bit $42                     ; 1A078:  24 42
            asl a                       ; 1A07A:  0a
            jsr $ccbe                   ; 1A07B:  20 be cc
            jmp ($d8b8)                 ; 1A07E:  6c b8 d8

            hex 7f 39 19 00 00 27 c2 87 ; 1A081:  7f 39 19 00 00 27 c2 87
            hex 27 46 c6 20 10 41 a1 66 ; 1A089:  27 46 c6 20 10 41 a1 66
            hex c7 a6 26 90 94 80 85 1a ; 1A091:  c7 a6 26 90 94 80 85 1a
            hex 80 d5 e4 bf 8f 9f 9b 0d ; 1A099:  80 d5 e4 bf 8f 9f 9b 0d
            hex 9f fa e7 a9 45 3a 49 21 ; 1A0A1:  9f fa e7 a9 45 3a 49 21
            hex 88 20 e4 41 b9 80 b6 cd ; 1A0A9:  88 20 e4 41 b9 80 b6 cd
            hex 77 de 3f 30 1e 6f 08 08 ; 1A0B1:  77 de 3f 30 1e 6f 08 08
            hex 04 3e 78 31 de bf f0 0c ; 1A0B9:  04 3e 78 31 de bf f0 0c
            hex 03 3f 79 13 90 a6 2c 04 ; 1A0C1:  03 3f 79 13 90 a6 2c 04
            hex 8b d2 41 ec ff d8 36 1a ; 1A0C9:  8b d2 41 ec ff d8 36 1a
            hex 74 fd be 11 88 e7 fd 3e ; 1A0D1:  74 fd be 11 88 e7 fd 3e
            hex 06 b0 44 11 87 e7       ; 1A0D9:  06 b0 44 11 87 e7

            inc $c6bf,x                 ; 1A0DF:  fe bf c6
            rti                         ; 1A0E2:  40

            hex ba 80 2d 21 48 86 80 2b ; 1A0E3:  ba 80 2d 21 48 86 80 2b
            hex 32 f0 fd d1 f0 fc 7f 5c ; 1A0EB:  32 f0 fd d1 f0 fc 7f 5c
            hex 4f 15 63 c0 44 41 40 4e ; 1A0F3:  4f 15 63 c0 44 41 40 4e
            hex 3c ef be 3f 7f 46 43 4e ; 1A0FB:  3c ef be 3f 7f 46 43 4e
            hex 3c 94 2a ba 81 1d b0 96 ; 1A103:  3c 94 2a ba 81 1d b0 96
            hex e0 ff d5 ed 7e f7 df 7a ; 1A10B:  e0 ff d5 ed 7e f7 df 7a
            hex f0 e0 c1 84 03 00 48 08 ; 1A113:  f0 e0 c1 84 03 00 48 08
            hex 20 e1 c0 80 0f 9c bc f0 ; 1A11B:  20 e1 c0 80 0f 9c bc f0
            hex f8 e7 4e 1c b8 b0 60 e1 ; 1A123:  f8 e7 4e 1c b8 b0 60 e1
            hex c2 e7 4e 1c b8 b0 61 e2 ; 1A12B:  c2 e7 4e 1c b8 b0 61 e2
            hex c7 81 21 03 47 0e 0c 1c ; 1A133:  c7 81 21 03 47 0e 0c 1c
            hex 38 71 e1 c3 87 8e 0c 1c ; 1A13B:  38 71 e1 c3 87 8e 0c 1c
            hex 38 82 81 00 14          ; 1A143:  38 82 81 00 14

            brk                         ; 1A148:  00
            hex 10                      ; 1A149:  10
            jsr tab_b6_8055+171         ; 1A14A:  20 00 81
            sta $1e18                   ; 1A14D:  8d 18 1e
            bpl tab_b6_a153+49          ; 1A150:  10 32
            rts                         ; 1A152:  60

tab_b6_a153: ; 76 bytes
            hex 40 14 03 0c 19 04 a2 b8 ; 1A153:  40 14 03 0c 19 04 a2 b8
            hex 20 1b 0e 1b 07 df dd 77 ; 1A15B:  20 1b 0e 1b 07 df dd 77
            hex 5f 41 81 31 9d 45 18 b5 ; 1A163:  5f 41 81 31 9d 45 18 b5
            hex 42 a9 f9 ed 53 fe ef 7b ; 1A16B:  42 a9 f9 ed 53 fe ef 7b
            hex b7 4a 29 10 26 09 1c 14 ; 1A173:  b7 4a 29 10 26 09 1c 14
            hex 05 3d 5e 3e 5d 37 9c 1f ; 1A17B:  05 3d 5e 3e 5d 37 9c 1f
            hex 05 49 02 11 c9 a1 11 c9 ; 1A183:  05 49 02 11 c9 a1 11 c9
            hex f1 f9 1a 39 31 f9 69 79 ; 1A18B:  f1 f9 1a 39 31 f9 69 79
            hex f9 c2 82 85 cc eb 66 31 ; 1A193:  f9 c2 82 85 cc eb 66 31
            hex b4 c0 80 80             ; 1A19B:  b4 c0 80 80

            cpy #$f0                    ; 1A19F:  c0 f0
b6_a1a1:    rts                         ; 1A1A1:  60

            hex 34 b3 a3 20 80 a1 81 00 ; 1A1A2:  34 b3 a3 20 80 a1 81 00
            hex 01 70 e0 63 f6 9e 9e 1f ; 1A1AA:  01 70 e0 63 f6 9e 9e 1f
            hex 08 77 65 99 76 25 2c 19 ; 1A1B2:  08 77 65 99 76 25 2c 19
            hex 4a 01 00 00 00 80 10 e4 ; 1A1BA:  4a 01 00 00 00 80 10 e4
            hex 11 f6 47 07 a7 47 80 74 ; 1A1C2:  11 f6 47 07 a7 47 80 74
            hex 41 00 07 07 07 07 00 00 ; 1A1CA:  41 00 07 07 07 07 00 00
            hex 00 00 83 7f ff 8c 0f 0f ; 1A1D2:  00 00 83 7f ff 8c 0f 0f
            hex be 1e 83 7f 3f 0c 0f 0f ; 1A1DA:  be 1e 83 7f 3f 0c 0f 0f
            hex 3e 1e c0 c0 88 05 d0 c1 ; 1A1E2:  3e 1e c0 c0 88 05 d0 c1
            hex 04 02 80 c0 80 00 c0 c0 ; 1A1EA:  04 02 80 c0 80 00 c0 c0
            hex 00 00 00 01 02 02 03 03 ; 1A1F2:  00 00 00 01 02 02 03 03
            hex 02 02 00 01 02 02 03 03 ; 1A1FA:  02 02 00 01 02 02 03 03
            hex 02 02 66 e7 66 67 e3 07 ; 1A202:  02 02 66 e7 66 67 e3 07
            hex 3c 26 66 e7 66 67 e3 07 ; 1A20A:  3c 26 66 e7 66 67 e3 07
            hex 3c 26 02 06 06 02 00 00 ; 1A212:  3c 26 02 06 06 02 00 00
            hex 00 00 02 06 06 02 00 00 ; 1A21A:  00 00 02 06 06 02 00 00
            hex 00 00 42 7a 32 1e 0f 00 ; 1A222:  00 00 42 7a 32 1e 0f 00
            hex 00 00 42 7a 32 1e 0f 00 ; 1A22A:  00 00 42 7a 32 1e 0f 00
            hex 00 00 30 b0 30 b0 b0 30 ; 1A232:  00 00 30 b0 30 b0 b0 30
            hex 30 30 30 b0 30 b0 b0 30 ; 1A23A:  30 30 30 b0 30 b0 b0 30
            hex 30 30 30 30 30 30 f0 f0 ; 1A242:  30 30 30 30 30 30 f0 f0
            hex 30 00 30 30 30 30 f0 f0 ; 1A24A:  30 00 30 30 30 30 f0 f0
            hex 30 00 00 00 00 00 01 01 ; 1A252:  30 00 00 00 00 00 01 01
            hex 03 07 00 00 00 00 01 01 ; 1A25A:  03 07 00 00 00 00 01 01
            hex 03 07                   ; 1A262:  03 07

            brk                         ; 1A264:  00
            hex 40                      ; 1A265:  40
            ora $12                     ; 1A266:  05 12
            ldy #$12                    ; 1A268:  a0 12
            ora $2b                     ; 1A26A:  05 2b
            brk                         ; 1A26C:  00
            hex 00                      ; 1A26D:  00
            brk                         ; 1A26E:  00
            hex 00                      ; 1A26F:  00
            brk                         ; 1A270:  00
            hex 00                      ; 1A271:  00
            brk                         ; 1A272:  00
            hex 00                      ; 1A273:  00
            lsr a                       ; 1A274:  4a
            and $1a,x                   ; 1A275:  35 1a
            jmp ($94d0)                 ; 1A277:  6c d0 94

            hex 2d 40 00 00 00 00 00 08 ; 1A27A:  2d 40 00 00 00 00 00 08
            hex 01 16 54 4b c4 82 ff    ; 1A282:  01 16 54 4b c4 82 ff

            dec $0c86                   ; 1A289:  ce 86 0c
            rti                         ; 1A28C:  40

            hex 40 c0 80 fe ce 86 0c 81 ; 1A28D:  40 c0 80 fe ce 86 0c 81
            hex 20 b3 48 25 91 34 56 12 ; 1A295:  20 b3 48 25 91 34 56 12
            hex 5f 0e b7 1e 6e 0b 3d 83 ; 1A29D:  5f 0e b7 1e 6e 0b 3d 83
            hex 07 0e 1f 71 e0 80 02 03 ; 1A2A5:  07 0e 1f 71 e0 80 02 03
            hex 07 0e 1f 71 e0 81 02 c1 ; 1A2AD:  07 0e 1f 71 e0 81 02 c1
            hex c2 05 05 f2 14 23 e0 c0 ; 1A2B5:  c2 05 05 f2 14 23 e0 c0
            hex c5 0f 0a ff 17 21 eb 00 ; 1A2BD:  c5 0f 0a ff 17 21 eb 00
            hex 13 52 22 43 16 47 4b 90 ; 1A2C5:  13 52 22 43 16 47 4b 90
            hex f3 f2 c2 e3 d6 87 8b 80 ; 1A2CD:  f3 f2 c2 e3 d6 87 8b 80
            hex 4f 44 ff c2 82 86 76 d7 ; 1A2D5:  4f 44 ff c2 82 86 76 d7
            hex 4f 43 ff c3 82 86 76 a1 ; 1A2DD:  4f 43 ff c3 82 86 76 a1
            hex 61 91 03 3b c7 25 e8 f9 ; 1A2E5:  61 91 03 3b c7 25 e8 f9
            hex 91 f1 fb ff 79 fe b4 26 ; 1A2ED:  91 f1 fb ff 79 fe b4 26
            hex 07 07 1f fe fe 84 07 c6 ; 1A2F5:  07 07 1f fe fe 84 07 c6
            hex 07 07 1f fe fe 84 07 4c ; 1A2FD:  07 07 1f fe fe 84 07 4c
            hex a0 a6 fc a0 7d 15 7d fc ; 1A305:  a0 a6 fc a0 7d 15 7d fc
            hex de fb ff ff ff 6e 7f 3f ; 1A30D:  de fb ff ff ff 6e 7f 3f
            hex f7 fe 1c 8c 4f 6f 98 3f ; 1A315:  f7 fe 1c 8c 4f 6f 98 3f
            hex f7 fe 9c 4c ef 9f 70 f0 ; 1A31D:  f7 fe 9c 4c ef 9f 70 f0
            hex e0 c0 03 01 1f 09 df f0 ; 1A325:  e0 c0 03 01 1f 09 df f0
            hex e1 c3 07 0f 3f 77 ff fd ; 1A32D:  e1 c3 07 0f 3f 77 ff fd
            hex d0 bf d4 5f e0 97 fa ff ; 1A335:  d0 bf d4 5f e0 97 fa ff
            hex 6f f7 ff fb ff 6d ff af ; 1A33D:  6f f7 ff fb ff 6d ff af
            hex 03 0c 32 f4 e1 81 02 bd ; 1A345:  03 0c 32 f4 e1 81 02 bd
            hex 1f 13 3c f3 e2 83 05 00 ; 1A34D:  1f 13 3c f3 e2 83 05 00
            hex fa e1 14 49 3b 46 9a ff ; 1A355:  fa e1 14 49 3b 46 9a ff
            hex fc de ff f7 cc b9 65 38 ; 1A35D:  fc de ff f7 cc b9 65 38
            hex 30 30 73 1e 10 c8 a8 38 ; 1A365:  30 30 73 1e 10 c8 a8 38
            hex 30 b1 b3 ff e0 f8 d7 10 ; 1A36D:  30 b1 b3 ff e0 f8 d7 10
            hex f3 d3 7f 46 9f 5f 10 60 ; 1A375:  f3 d3 7f 46 9f 5f 10 60
            hex 73 fb ff de ff 77 fe 6b ; 1A37D:  73 fb ff de ff 77 fe 6b
            hex 04 04 07 8e 1c 18 30 ae ; 1A385:  04 04 07 8e 1c 18 30 ae
            hex e2 c7 86 0e 1c 18 30 70 ; 1A38D:  e2 c7 86 0e 1c 18 30 70
            hex 02 38 08 56 01 00 00 df ; 1A395:  02 38 08 56 01 00 00 df
            hex 7e 2c 74 1a 06 40 00 70 ; 1A39D:  7e 2c 74 1a 06 40 00 70
            hex e0 c0 01 03 07 8e 0c 70 ; 1A3A5:  e0 c0 01 03 07 8e 0c 70
            hex e0 c0 01 03 07 8e 0c 10 ; 1A3AD:  e0 c0 01 03 07 8e 0c 10
            hex 21 e8 e8 f6 86 00 00 10 ; 1A3B5:  21 e8 e8 f6 86 00 00 10
            hex 20 e8 e0 f4 86 00 00 1c ; 1A3BD:  20 e8 e0 f4 86 00 00 1c
            hex 38 38 77 ff f7 6e 0d 1c ; 1A3C5:  38 38 77 ff f7 6e 0d 1c
            hex 38 38 77 ff f7 6e 0d 07 ; 1A3CD:  38 38 77 ff f7 6e 0d 07
            hex be 38 00 a0 68 c0 80 07 ; 1A3D5:  be 38 00 a0 68 c0 80 07
            hex 3e 38 00 a0 68 c0 80 03 ; 1A3DD:  3e 38 00 a0 68 c0 80 03
            hex 00 00 00 00 80 07 02 03 ; 1A3E5:  00 00 00 00 80 07 02 03
            hex 00 00 01 04 83 0f 07 65 ; 1A3ED:  00 00 01 04 83 0f 07 65
            hex 75 1a 3d a7 d4 d4 5a dd ; 1A3F5:  75 1a 3d a7 d4 d4 5a dd
            hex 7b 1f 2f 1f f4 ad f2 e5 ; 1A3FD:  7b 1f 2f 1f f4 ad f2 e5
            hex f2 76 f1 f1 f2 f1 e0 e0 ; 1A405:  f2 76 f1 f1 f2 f1 e0 e0
            hex f0 70 f2 f0 f0 f1 e0 e1 ; 1A40D:  f0 70 f2 f0 f0 f1 e0 e1
            hex 23 50 90 e7 25 38 08 e5 ; 1A415:  23 50 90 e7 25 38 08 e5
            hex 55 10 00 07 b5 fc 30 ff ; 1A41D:  55 10 00 07 b5 fc 30 ff
            hex 9c 1c 1c 18 38 30 60 fc ; 1A425:  9c 1c 1c 18 38 30 60 fc
            hex 9d 1c 1c 18 38 31 61 42 ; 1A42D:  9d 1c 1c 18 38 31 61 42
            hex 93 00 60 32 08 ff       ; 1A435:  93 00 60 32 08 ff

            cpx $b9                     ; 1A43B:  e4 b9
            jmp ($9c7e)                 ; 1A43D:  6c 7e 9c

            hex c0 b1 47 0a 82 a5 44 24 ; 1A440:  c0 b1 47 0a 82 a5 44 24
            hex d4 e4 ec 80             ; 1A448:  d4 e4 ec 80

            sta ($a7,x)                 ; 1A44C:  81 a7
            jmp $d624                   ; 1A44E:  4c 24 d6

            hex fc e4 80 29 1a 02 19 e4 ; 1A451:  fc e4 80 29 1a 02 19 e4
            hex c1 00 02 d2 05 3f 2e db ; 1A459:  c1 00 02 d2 05 3f 2e db
            hex de 0f 0c 1b             ; 1A461:  de 0f 0c 1b

            ora $3119,y                 ; 1A465:  19 19 31
            rts                         ; 1A468:  60

            hex c0 06 08 9b 19 19 30 61 ; 1A469:  c0 06 08 9b 19 19 30 61
            hex c0 83 46 4c 33 c9 e4 72 ; 1A471:  c0 83 46 4c 33 c9 e4 72
            hex bd 3e 17 00 00 c0 e0 70 ; 1A479:  bd 3e 17 00 00 c0 e0 70
            hex 3c 9e 47 22 40          ; 1A481:  3c 9e 47 22 40

            cpy $27                     ; 1A486:  c4 27
            jmp $2c14                   ; 1A488:  4c 14 2c

            hex 78 05 a1 04 87 4c 14 ac ; 1A48B:  78 05 a1 04 87 4c 14 ac

            clv                         ; 1A493:  b8
            rti                         ; 1A494:  40

            hex d0 0d a2 c5 ca c9 c2 b0 ; 1A495:  d0 0d a2 c5 ca c9 c2 b0
            hex 00 d0 90 f0 d4 c0 c4 80 ; 1A49D:  00 d0 90 f0 d4 c0 c4 80

            pha                         ; 1A4A5:  48
            brk                         ; 1A4A6:  00
            hex 20                      ; 1A4A7:  20
            bcc b6_a4aa                 ; 1A4A8:  90 00
b6_a4aa:    rti                         ; 1A4AA:  40

            hex 80 00 00 00 00 00 00 00 ; 1A4AB:  80 00 00 00 00 00 00 00
            hex 00 20 20 30 18 1e 7e 36 ; 1A4B3:  00 20 20 30 18 1e 7e 36
            hex 24 20 20 30 18 1e 7e 36 ; 1A4BB:  24 20 20 30 18 1e 7e 36
            hex 24 50 00 60 97 40 b4 40 ; 1A4C3:  24 50 00 60 97 40 b4 40
            hex 88 00 00 00 07 00 00 00 ; 1A4CB:  88 00 00 00 07 00 00 00
            hex 00 64 ff 7f e0 00 00 00 ; 1A4D3:  00 64 ff 7f e0 00 00 00
            hex 00 64 ff 7f             ; 1A4DB:  00 64 ff 7f

            cpx #$00                    ; 1A4DF:  e0 00
            brk                         ; 1A4E1:  00
            hex 00                      ; 1A4E2:  00
            brk                         ; 1A4E3:  00
            hex 00                      ; 1A4E4:  00
            cpy #$e0                    ; 1A4E5:  c0 e0
            rts                         ; 1A4E7:  60

            hex 00 00 00 00 00 c0 e0 60 ; 1A4E8:  00 00 00 00 00 c0 e0 60
            hex 00 00 00 00 08 00 10 48 ; 1A4F0:  00 00 00 00 08 00 10 48
            hex 05 02 04 09 00 00 00 00 ; 1A4F8:  05 02 04 09 00 00 00 00
            hex 00 00 00 00 20 84 01 22 ; 1A500:  00 00 00 00 20 84 01 22
            hex 46 2b 04 28 00 00 01 02 ; 1A508:  46 2b 04 28 00 00 01 02
            hex 06 03 00 00 7c          ; 1A510:  06 03 00 00 7c

            clv                         ; 1A515:  b8
            sed                         ; 1A516:  f8
            beq tab_b6_a526+3           ; 1A517:  f0 10
            bcc tab_b6_a535+73          ; 1A519:  90 63
            cpy #$7c                    ; 1A51B:  c0 7c
            clv                         ; 1A51D:  b8
            sed                         ; 1A51E:  f8
            sbc ($10),y                 ; 1A51F:  f1 10
            ora ($20),y                 ; 1A521:  11 20
            pha                         ; 1A523:  48
            php                         ; 1A524:  08
            rti                         ; 1A525:  40

tab_b6_a526: ; 8 bytes
            hex a2 40 92 14 98 5b 77 bf ; 1A526:  a2 40 92 14 98 5b 77 bf

            eor $6d3f,x                 ; 1A52E:  5d 3f 6d
            lsr a                       ; 1A531:  4a
            asl $24                     ; 1A532:  06 24
            rti                         ; 1A534:  40

tab_b6_a535: ; 1188 bytes
            hex c0 2f 79 f8 3d 18 0c 01 ; 1A535:  c0 2f 79 f8 3d 18 0c 01
            hex 80 17 61 f4 3a 19 0c 6e ; 1A53D:  80 17 61 f4 3a 19 0c 6e
            hex be d8 8d 15 8b 48 90 91 ; 1A545:  be d8 8d 15 8b 48 90 91
            hex 01 a3 82 0a 0c 36 68 ab ; 1A54D:  01 a3 82 0a 0c 36 68 ab
            hex 9e 34 c8 c0 30 83 ab 4b ; 1A555:  9e 34 c8 c0 30 83 ab 4b
            hex 3e cc 34 32 d0 73 5b 4c ; 1A55D:  3e cc 34 32 d0 73 5b 4c
            hex 7e 32 60 52 58 02 da 4c ; 1A565:  7e 32 60 52 58 02 da 4c
            hex 7e 32 20 f3 ef 7d ff f3 ; 1A56D:  7e 32 20 f3 ef 7d ff f3
            hex 41 c1 37 07 21 03 07 2b ; 1A575:  41 c1 37 07 21 03 07 2b
            hex 21 21 e7 f7 c1 03 07 c2 ; 1A57D:  21 21 e7 f7 c1 03 07 c2
            hex f0 f6 ef d9 ff fc e0 c7 ; 1A585:  f0 f6 ef d9 ff fc e0 c7
            hex f0 f6 ef d9 ff fc e0 69 ; 1A58D:  f0 f6 ef d9 ff fc e0 69
            hex 10 22 15 69 8a cd 72 76 ; 1A595:  10 22 15 69 8a cd 72 76
            hex 7f df 6a 5f f5 f6 ed 40 ; 1A59D:  7f df 6a 5f f5 f6 ed 40
            hex b3 24 00 06 3f 9f 0c bc ; 1A5A5:  b3 24 00 06 3f 9f 0c bc
            hex ef c3 03 87 ff df 8c 53 ; 1A5AD:  ef c3 03 87 ff df 8c 53
            hex a8 12 d8 c8 e6 00 00 bd ; 1A5B5:  a8 12 d8 c8 e6 00 00 bd
            hex ff 6f ff d7 eb 0f 07 08 ; 1A5BD:  ff 6f ff d7 eb 0f 07 08
            hex 1b 9f 9e 6c 0c 97 c7 88 ; 1A5C5:  1b 9f 9e 6c 0c 97 c7 88
            hex 9b 5f de 8c ec 67 4f 14 ; 1A5CD:  9b 5f de 8c ec 67 4f 14
            hex c8 04 d1 28 64 04 02 1f ; 1A5D5:  c8 04 d1 28 64 04 02 1f
            hex f7 ff 2e d7 9b 7b 2d be ; 1A5DD:  f7 ff 2e d7 9b 7b 2d be
            hex 05 59 2a a2 e8 08 e2 d1 ; 1A5E5:  05 59 2a a2 e8 08 e2 d1
            hex fb ae d7 7d 9f f7 3d 03 ; 1A5ED:  fb ae d7 7d 9f f7 3d 03
            hex 31 c0 04 1b 09 f6 2c 3a ; 1A5F5:  31 c0 04 1b 09 f6 2c 3a
            hex de ff 3b 0d 76 c9 13 3a ; 1A5FD:  de ff 3b 0d 76 c9 13 3a
            hex 89 43 24 8d 61 09 52 c7 ; 1A605:  89 43 24 8d 61 09 52 c7
            hex fe bd fa 7a de f7 bc a0 ; 1A60D:  fe bd fa 7a de f7 bc a0
            hex 22 7a 2c 04 a6 ae 40 21 ; 1A615:  22 7a 2c 04 a6 ae 40 21
            hex e2 bd cf e5 d6 7e bc 00 ; 1A61D:  e2 bd cf e5 d6 7e bc 00
            hex 12 00 00 08 20 80 00 00 ; 1A625:  12 00 00 08 20 80 00 00
            hex c2 80 00 40 02 00 40 56 ; 1A62D:  c2 80 00 40 02 00 40 56
            hex 89 04 00 00 7c 1c 30 ae ; 1A635:  89 04 00 00 7c 1c 30 ae
            hex 64 e0 00 00 7c 1c 30 3f ; 1A63D:  64 e0 00 00 7c 1c 30 3f
            hex 3f 3e 0c 00 00 00 00 3f ; 1A645:  3f 3e 0c 00 00 00 00 3f
            hex 3f 3e 0c 00 00 00 00 41 ; 1A64D:  3f 3e 0c 00 00 00 00 41
            hex 33 1f 1f 1f 0f 00 00 41 ; 1A655:  33 1f 1f 1f 0f 00 00 41
            hex 33 1f 1f 1f 0f 00 00 00 ; 1A65D:  33 1f 1f 1f 0f 00 00 00
            hex 80 10 80 08 00 40 00 00 ; 1A665:  80 10 80 08 00 40 00 00
            hex 00 00 00 00 00 00 08 e0 ; 1A66D:  00 00 00 00 00 00 08 e0
            hex c1 c0 c4 81 80 14 00 e0 ; 1A675:  c1 c0 c4 81 80 14 00 e0
            hex c0 c0 c0 80 82 00 00 04 ; 1A67D:  c0 c0 c0 80 82 00 00 04
            hex 68 70 41 21 72 c0 f9 00 ; 1A685:  68 70 41 21 72 c0 f9 00
            hex 60 78 01 01 00 21 01 03 ; 1A68D:  60 78 01 01 00 21 01 03
            hex 11 00 02 00 10 42 04 08 ; 1A695:  11 00 02 00 10 42 04 08
            hex 00 00 00 00 00 00 00 11 ; 1A69D:  00 00 00 00 00 00 00 11
            hex 49 69 41 01 0b 4a ca e1 ; 1A6A5:  49 69 41 01 0b 4a ca e1
            hex b1 81 01 01 0b 0a 0a cc ; 1A6AD:  b1 81 01 01 0b 0a 0a cc
            hex ef e7 e0 c0 00 00 00 cc ; 1A6B5:  ef e7 e0 c0 00 00 00 cc
            hex ef e7 e0 c0 00 00 00 04 ; 1A6BD:  ef e7 e0 c0 00 00 00 04
            hex 09 82 0b 05 02 08 05 1b ; 1A6C5:  09 82 0b 05 02 08 05 1b
            hex 07 99 06 1e 0d 1f 0b 00 ; 1A6CD:  07 99 06 1e 0d 1f 0b 00
            hex 00 00 1c 2c 4c 18 18 00 ; 1A6D5:  00 00 1c 2c 4c 18 18 00
            hex 00 00 1c 2c 4c 18 18 0c ; 1A6DD:  00 00 1c 2c 4c 18 18 0c
            hex 09 0d 0c 02 01 00 00 1e ; 1A6E5:  09 0d 0c 02 01 00 00 1e
            hex 0e 1f 07 05 00 00 00 80 ; 1A6ED:  0e 1f 07 05 00 00 00 80
            hex 01 41 2e 82 20 8e 03 60 ; 1A6F5:  01 41 2e 82 20 8e 03 60
            hex f1 3d d3 45 c0 6e 83 c0 ; 1A6FD:  f1 3d d3 45 c0 6e 83 c0
            hex 81 82 08 04 04 11 f0 cd ; 1A705:  81 82 08 04 04 11 f0 cd
            hex 88 8d 11 1a 29 04 fb 07 ; 1A70D:  88 8d 11 1a 29 04 fb 07
            hex 3f 67 26 27 21 33 17 47 ; 1A715:  3f 67 26 27 21 33 17 47
            hex 1f 67 26 27 a1 33 57 fc ; 1A71D:  1f 67 26 27 a1 33 57 fc
            hex 38 39 30 31 bb ba 38 f8 ; 1A725:  38 39 30 31 bb ba 38 f8
            hex 3b 38 30 30 b8 b8 39 61 ; 1A72D:  3b 38 30 30 b8 b8 39 61
            hex 88 20 40 af c7 24 48 00 ; 1A735:  88 20 40 af c7 24 48 00
            hex 00 00 00 07 03 00 00 18 ; 1A73D:  00 00 00 07 03 00 00 18
            hex 08 0f 1f fc cc 0c 0c 18 ; 1A745:  08 0f 1f fc cc 0c 0c 18
            hex 08 0f 1f fc cc 0c 0c a2 ; 1A74D:  08 0f 1f fc cc 0c 0c a2
            hex a5 28 d1 14 28 c0 28 00 ; 1A755:  a5 28 d1 14 28 c0 28 00
            hex 00 00 00 00 40 00 00 0c ; 1A75D:  00 00 00 00 40 00 00 0c
            hex 08 08 08 08 08 08 08 0c ; 1A765:  08 08 08 08 08 08 08 0c
            hex 08 08 08 08 08 08 08 00 ; 1A76D:  08 08 08 08 08 08 08 00
            hex e0 e0 e0 00 00 00 00 00 ; 1A775:  e0 e0 e0 00 00 00 00 00
            hex e0 e0 e0 00 00 00 00 53 ; 1A77D:  e0 e0 e0 00 00 00 00 53
            hex 8d 22 1d 20 54 0a 14 00 ; 1A785:  8d 22 1d 20 54 0a 14 00
            hex 00 00 00 00 00 00 00 4a ; 1A78D:  00 00 00 00 00 00 00 4a
            hex 10 09 24 91 48 00 28 00 ; 1A795:  10 09 24 91 48 00 28 00
            hex 00 02 00 00 00 00 00 a7 ; 1A79D:  00 02 00 00 00 00 00 a7
            hex 13 43 11 01 00 df 77 16 ; 1A7A5:  13 43 11 01 00 df 77 16
            hex 4b 3b ad 0b 07 de 77 e0 ; 1A7AD:  4b 3b ad 0b 07 de 77 e0
            hex 81 55 83 e8 ca 04 48 18 ; 1A7B5:  81 55 83 e8 ca 04 48 18
            hex 79 29 bf d7 dc 88 80 32 ; 1A7BD:  79 29 bf d7 dc 88 80 32
            hex 76 5c f8 08 0e 0e fe 32 ; 1A7C5:  76 5c f8 08 0e 0e fe 32
            hex 76 5c 78 c8 0f 0e fe 10 ; 1A7CD:  76 5c 78 c8 0f 0e fe 10
            hex 01 43 07 c6 2c b8 48 f0 ; 1A7D5:  01 43 07 c6 2c b8 48 f0
            hex 61 23 47 06 cc 08 00 3e ; 1A7DD:  61 23 47 06 cc 08 00 3e
            hex f1 e3 87 0f 1b 33 63 3e ; 1A7E5:  f1 e3 87 0f 1b 33 63 3e
            hex f1 e3 87 0f 1b 33 63 c0 ; 1A7ED:  f1 e3 87 0f 1b 33 63 c0
            hex 86 31 f8 b9 98 f9 79 c0 ; 1A7F5:  86 31 f8 b9 98 f9 79 c0
            hex 81 3f ff bb 99 f9 78 c3 ; 1A7FD:  81 3f ff bb 99 f9 78 c3
            hex 83 85 02 10 17 2e 15 c3 ; 1A805:  83 85 02 10 17 2e 15 c3
            hex 87 89 1c 0f 20 10 40 18 ; 1A80D:  87 89 1c 0f 20 10 40 18
            hex 99 dc fd fc 78 f8 a0 19 ; 1A815:  99 dc fd fc 78 f8 a0 19
            hex 99 dd fd fc f8 38 41 d7 ; 1A81D:  99 dd fd fc f8 38 41 d7
            hex 05 52 83 58 00 4a 06 6c ; 1A825:  05 52 83 58 00 4a 06 6c
            hex fa ed 7c ee fc b4 89 42 ; 1A82D:  fa ed 7c ee fc b4 89 42
            hex 8c c8 5e 2f 0c 45 ec 86 ; 1A835:  8c c8 5e 2f 0c 45 ec 86
            hex 0e 08 1e cf 4c 65 fc 31 ; 1A83D:  0e 08 1e cf 4c 65 fc 31
            hex 88 98 f0 41 13 53 92 d4 ; 1A845:  88 98 f0 41 13 53 92 d4
            hex f0 e0 e0 f1 e3 ab 7e 40 ; 1A84D:  f0 e0 e0 f1 e3 ab 7e 40
            hex 08 31 60 c7 9e 18 31 48 ; 1A855:  08 31 60 c7 9e 18 31 48
            hex 08 30 60 c7 9e 18 31 1d ; 1A85D:  08 30 60 c7 9e 18 31 1d
            hex 20 12 68 c0 f1 c9 7a 06 ; 1A865:  20 12 68 c0 f1 c9 7a 06
            hex 1f 6d 1f ff ef c6 7d a8 ; 1A86D:  1f 6d 1f ff ef c6 7d a8
            hex b8 00 61 21 0b 90 25 dc ; 1A875:  b8 00 61 21 0b 90 25 dc
            hex 60 f8 91 f9 f7 6e da 98 ; 1A87D:  60 f8 91 f9 f7 6e da 98
            hex 39 60 00 85 92 81 84 9b ; 1A885:  39 60 00 85 92 81 84 9b
            hex 38 e0 c1 e2 ad 9e 8b c0 ; 1A88D:  38 e0 c1 e2 ad 9e 8b c0
            hex 54 c4 b2 d0 4c 02 25 3f ; 1A895:  54 c4 b2 d0 4c 02 25 3f
            hex ef 39 5c 68 b1 fc da 30 ; 1A89D:  ef 39 5c 68 b1 fc da 30
            hex 67 c3 82 0c 04 04 04 30 ; 1A8A5:  67 c3 82 0c 04 04 04 30
            hex 67 c3 84 0f 05 24 04 00 ; 1A8AD:  67 c3 84 0f 05 24 04 00
            hex c0 c0 00 00 00 50 a2 00 ; 1A8B5:  c0 c0 00 00 00 50 a2 00
            hex c0 c0 00 08 31 c0 b0 04 ; 1A8BD:  c0 c0 00 08 31 c0 b0 04
            hex 8c 7e a2 02 06 04 0c 04 ; 1A8C5:  8c 7e a2 02 06 04 0c 04
            hex 0c be 02 42 06 04 8c c4 ; 1A8CD:  0c be 02 42 06 04 8c c4
            hex 51 80 00 00 00 00 00 84 ; 1A8D5:  51 80 00 00 00 00 00 84
            hex f0 80 00 00 00 00 00 08 ; 1A8DD:  f0 80 00 00 00 00 00 08
            hex 80 00 01 12 22 03 a3 00 ; 1A8E5:  80 00 01 12 22 03 a3 00
            hex 00 00 21 02 02 0b 1f c0 ; 1A8ED:  00 00 21 02 02 0b 1f c0
            hex 60 f0 4c cc 84 84 0c c0 ; 1A8F5:  60 f0 4c cc 84 84 0c c0
            hex 60 f0 4c cc 84 84 0c 09 ; 1A8FD:  60 f0 4c cc 84 84 0c 09
            hex 21 10 02 00 00 00 00 0d ; 1A905:  21 10 02 00 00 00 00 0d
            hex 00 04 00 00 00 00 00 0c ; 1A90D:  00 04 00 00 00 00 00 0c
            hex 1c 38 30 00 00 00 00 0c ; 1A915:  1c 38 30 00 00 00 00 0c
            hex 1c 38 30 00 00 00 00 09 ; 1A91D:  1c 38 30 00 00 00 00 09
            hex 1f 5e 1d ba 7c 24 01 80 ; 1A925:  1f 5e 1d ba 7c 24 01 80
            hex 00 00 02 04 00 98 30 4a ; 1A92D:  00 00 02 04 00 98 30 4a
            hex ca ce 86 06 26 06 02 8a ; 1A935:  ca ce 86 06 26 06 02 8a
            hex 0a 0e 06 06 86 06 02 40 ; 1A93D:  0a 0e 06 06 86 06 02 40
            hex 10 44 00 00 00 00 00 04 ; 1A945:  10 44 00 00 00 00 00 04
            hex 00 10 00 00 00 00 00 10 ; 1A94D:  00 10 00 00 00 00 00 10
            hex 10 18 1c 0c 07 01 00 10 ; 1A955:  10 18 1c 0c 07 01 00 10
            hex 10 18 1c 0c 07 01 00 00 ; 1A95D:  10 18 1c 0c 07 01 00 00
            hex 00 09 02 00 00 80 00 00 ; 1A965:  00 09 02 00 00 80 00 00
            hex 03 1e 2d 00 10 80 00 00 ; 1A96D:  03 1e 2d 00 10 80 00 00
            hex 00 00 00 00 00 04 1e 00 ; 1A975:  00 00 00 00 00 04 1e 00
            hex 00 00 00 00 00 04 1e 00 ; 1A97D:  00 00 00 00 00 04 1e 00
            hex 00 00 00 00 00 20 90 00 ; 1A985:  00 00 00 00 00 20 90 00
            hex 00 00 00 00 00 20 90 de ; 1A98D:  00 00 00 00 00 20 90 de
            hex 6b 81 10 00 00 00 00 3e ; 1A995:  6b 81 10 00 00 00 00 3e
            hex db 79 e8 00 00 00 00 30 ; 1A99D:  db 79 e8 00 00 00 00 30
            hex b0 f3 f0 60 00 00 00 30 ; 1A9A5:  b0 f3 f0 60 00 00 00 30
            hex b1 f0 f2 60 00 00 00 00 ; 1A9AD:  b1 f0 f2 60 00 00 00 00
            hex 00 09 0f 03 03 06 07 00 ; 1A9B5:  00 09 0f 03 03 06 07 00
            hex 00 09 0f 03 03 06 07 00 ; 1A9BD:  00 09 0f 03 03 06 07 00
            hex 00 00 80 80 00 00 80 00 ; 1A9C5:  00 00 80 80 00 00 80 00
            hex 00 00 80 80 00 00 80 40 ; 1A9CD:  00 00 80 80 00 00 80 40
            hex c1 23 03 63             ; 1A9D5:  c1 23 03 63

            ora $51                     ; 1A9D9:  05 51
            rts                         ; 1A9DB:  60

            hex 00 01 03 03 03 01 01 00 ; 1A9DC:  00 01 03 03 03 01 01 00
            hex 70 90 00 08 0e fe fc 18 ; 1A9E4:  70 90 00 08 0e fe fc 18
            hex 70 90 00 08 0e fe fc 18 ; 1A9EC:  70 90 00 08 0e fe fc 18
            hex 28 7c 7a 39 69 79 39 6f ; 1A9F4:  28 7c 7a 39 69 79 39 6f
            hex 28 7c 7a 39 69 79 39 6f ; 1A9FC:  28 7c 7a 39 69 79 39 6f
            hex 00 00 01 03 02 03 03 02 ; 1AA04:  00 00 01 03 02 03 03 02
            hex 00 00 00 00 00 00 00 00 ; 1AA0C:  00 00 00 00 00 00 00 00
            hex 00 00 ff ed 2d fb ab eb ; 1AA14:  00 00 ff ed 2d fb ab eb
            hex 00 00 00 00 00 00 00 00 ; 1AA1C:  00 00 00 00 00 00 00 00
            hex 03 03 02 02 03 03 01 00 ; 1AA24:  03 03 02 02 03 03 01 00
            hex 00 00 00 00 00 00 00 00 ; 1AA2C:  00 00 00 00 00 00 00 00
            hex af fb da db             ; 1AA34:  af fb da db

            dec $ff0b,x                 ; 1AA38:  de 0b ff
            brk                         ; 1AA3B:  00
            hex 00                      ; 1AA3C:  00
            brk                         ; 1AA3D:  00
            hex 00                      ; 1AA3E:  00
            brk                         ; 1AA3F:  00
            hex 00                      ; 1AA40:  00
            brk                         ; 1AA41:  00
            hex 00                      ; 1AA42:  00
            brk                         ; 1AA43:  00
            hex 00                      ; 1AA44:  00
            brk                         ; 1AA45:  00
            hex c0                      ; 1AA46:  c0
            rts                         ; 1AA47:  60

            hex e0 20 e0 20 00 00 00 00 ; 1AA48:  e0 20 e0 20 00 00 00 00
            hex 00 00 00 00 11 45 15 00 ; 1AA50:  00 00 00 00 11 45 15 00
            hex 25 09 01 03 01 01 01 00 ; 1AA58:  25 09 01 03 01 01 01 00
            hex 00 00 00 00 20 a0 a0 a0 ; 1AA60:  00 00 00 00 20 a0 a0 a0
            hex e0 e0 40 00 00 00 00 00 ; 1AA68:  e0 e0 40 00 00 00 00 00
            hex 00 00 00 00 f8 80 c0 f4 ; 1AA70:  00 00 00 00 f8 80 c0 f4
            hex 18 5e a7 10 f8 80 c0 f2 ; 1AA78:  18 5e a7 10 f8 80 c0 f2
            hex 18 1e 07 00 2d 62 5c 28 ; 1AA80:  18 1e 07 00 2d 62 5c 28
            hex 72 a4 52 45 10 0c 02 14 ; 1AA88:  72 a4 52 45 10 0c 02 14
            hex 00 01 00 00 ea 44 5c 42 ; 1AA90:  00 01 00 00 ea 44 5c 42
            hex c2 8d dd f8 04 13 03 09 ; 1AA98:  c2 8d dd f8 04 13 03 09
            hex c5 8e dc f8 02          ; 1AAA0:  c5 8e dc f8 02

            bit $22                     ; 1AAA5:  24 22
            ora ($21,x)                 ; 1AAA7:  01 21
            php                         ; 1AAA9:  08
            jsr $0120                   ; 1AAAA:  20 20 01
            sta ($41,x)                 ; 1AAAD:  81 41
            inc $c2                     ; 1AAAF:  e6 c2
            rti                         ; 1AAB1:  40

            hex 00 20 13 23 b3 60 84 41 ; 1AAB2:  00 20 13 23 b3 60 84 41
            hex 80                      ; 1AABA:  80

            brk                         ; 1AABB:  00
            hex 00                      ; 1AABC:  00
            rti                         ; 1AABD:  40

            hex 00 01 00 01 00 00 b0 4b ; 1AABE:  00 01 00 01 00 00 b0 4b
            hex 0c a1 08 85 f8 dd 51 b4 ; 1AAC6:  0c a1 08 85 f8 dd 51 b4
            hex 30 18 10 80 f8 dc 03 05 ; 1AACE:  30 18 10 80 f8 dc 03 05
            hex 09 0b 0e 0e 0c 00 03 05 ; 1AAD6:  09 0b 0e 0e 0c 00 03 05
            hex 09 0b                   ; 1AADE:  09 0b

            asl $0c0e                   ; 1AAE0:  0e 0e 0c
            brk                         ; 1AAE3:  00
            hex 8e                      ; 1AAE4:  8e
            stx ptr3_lo                     ; 1AAE5:  86 06
            asl $0e                     ; 1AAE7:  06 0e
            asl $0e                     ; 1AAE9:  06 0e
            asl tab_b6_8574+282         ; 1AAEB:  0e 8e 86
            asl ptr3_lo                     ; 1AAEE:  06 06
            asl $0e06                   ; 1AAF0:  0e 06 0e
            asl $c8a0                   ; 1AAF3:  0e a0 c8
            sbc #$ab                    ; 1AAF6:  e9 ab
            cmp ($1b),y                 ; 1AAF8:  d1 1b
            lda $0a,x                   ; 1AAFA:  b5 0a
            dec $143e,x                 ; 1AAFC:  de 3e 14
            bpl tab_b6_ab02+3           ; 1AAFF:  10 04
            rti                         ; 1AB01:  40

tab_b6_ab02: ; 359 bytes
            hex 00 a0 3f 27 07 47 bc 38 ; 1AB02:  00 a0 3f 27 07 47 bc 38
            hex 20 81 3f 47 07 47 3c 38 ; 1AB0A:  20 81 3f 47 07 47 3c 38
            hex 00 10 19 05 5a 4e 38 08 ; 1AB12:  00 10 19 05 5a 4e 38 08
            hex 39 0c c0 10 00 11 42 20 ; 1AB1A:  39 0c c0 10 00 11 42 20
            hex 05 02 05 1a 2c 00 00 20 ; 1AB22:  05 02 05 1a 2c 00 00 20
            hex 27 3c 00 00 00 00 00 20 ; 1AB2A:  27 3c 00 00 00 00 00 20
            hex 27 3c 9a 0d df fe 7c 7c ; 1AB32:  27 3c 9a 0d df fe 7c 7c
            hex 5e a6 85 1b c0 f5 7b 7d ; 1AB3A:  5e a6 85 1b c0 f5 7b 7d
            hex 9f 46 55 04 20 48 6e 54 ; 1AB42:  9f 46 55 04 20 48 6e 54
            hex e4 b8 e8 f8 d8 b6 0f ae ; 1AB4A:  e4 b8 e8 f8 d8 b6 0f ae
            hex 1a 67 c8 92 42 64 c3 f4 ; 1AB52:  1a 67 c8 92 42 64 c3 f4
            hex e4 c2 b8 2c 6d 4b cc f3 ; 1AB5A:  e4 c2 b8 2c 6d 4b cc f3
            hex e2 c1 00 00 00 80 20 00 ; 1AB62:  e2 c1 00 00 00 80 20 00
            hex 90 02 1c 40 80 40 e0 b0 ; 1AB6A:  90 02 1c 40 80 40 e0 b0
            hex ac 9d 1c 18 10 30 a8 2c ; 1AB72:  ac 9d 1c 18 10 30 a8 2c
            hex 0c 0c 9c 18 10 31 28 2c ; 1AB7A:  0c 0c 9c 18 10 31 28 2c
            hex 0c 0c 00 00 00 02 80 00 ; 1AB82:  0c 0c 00 00 00 02 80 00
            hex 10 00 00 04 00 40 10 00 ; 1AB8A:  10 00 00 04 00 40 10 00
            hex 01 00 08 08 08 08 08 08 ; 1AB92:  01 00 08 08 08 08 08 08
            hex 18 18 08 08 08 08 08 08 ; 1AB9A:  18 18 08 08 08 08 08 08
            hex 18 18 04 04 07 04 04 04 ; 1ABA2:  18 18 04 04 07 04 04 04
            hex 0c 0c 04 04 07 04 04 04 ; 1ABAA:  0c 0c 04 04 07 04 04 04
            hex 0c 0c 0c 0c 0c 04 00 00 ; 1ABB2:  0c 0c 0c 0c 0c 04 00 00
            hex 00 00 0c 0c 0c 04 00 00 ; 1ABBA:  00 00 0c 0c 0c 04 00 00
            hex 00 00 fe 8c 0c 0c 0c 0c ; 1ABC2:  00 00 fe 8c 0c 0c 0c 0c
            hex 7c 7c fe 8c 0c 0c 0c 0c ; 1ABCA:  7c 7c fe 8c 0c 0c 0c 0c
            hex 7c 7c 40 00 00 00 00 00 ; 1ABD2:  7c 7c 40 00 00 00 00 00
            hex 00 00 40 00 00 00 00 00 ; 1ABDA:  00 00 40 00 00 00 00 00
            hex 00 00 6e 3f 00 00 00 00 ; 1ABE2:  00 00 6e 3f 00 00 00 00
            hex 00 00 6e 3f 00 00 00 00 ; 1ABEA:  00 00 6e 3f 00 00 00 00
            hex 00 00 00 80 c0 40 00 00 ; 1ABF2:  00 00 00 80 c0 40 00 00
            hex 00 00 00 80 c0 40 00 00 ; 1ABFA:  00 00 00 80 c0 40 00 00
            hex 00 00 07 03 02 02 02 03 ; 1AC02:  00 00 07 03 02 02 02 03
            hex 01 00 07 03 02 02 02 03 ; 1AC0A:  01 00 07 03 02 02 02 03
            hex 01 00 c0 00 00 00 30 e0 ; 1AC12:  01 00 c0 00 00 00 30 e0
            hex c0 00 c0 00 00 00 30 e0 ; 1AC1A:  c0 00 c0 00 00 00 30 e0
            hex c0 00 ce f8 f8 08 08 08 ; 1AC22:  c0 00 ce f8 f8 08 08 08
            hex 08 08 ce f8 f8 08 08 08 ; 1AC2A:  08 08 ce f8 f8 08 08 08
            hex 08 08 08 08 00 00 00 00 ; 1AC32:  08 08 08 08 00 00 00 00
            hex 00 00 08 08 00 00 00 00 ; 1AC3A:  00 00 08 08 00 00 00 00
            hex 00 00 00 00 00 00 01 07 ; 1AC42:  00 00 00 00 00 00 01 07
            hex 0c 00 00 00 00 00 01 07 ; 1AC4A:  0c 00 00 00 00 00 01 07
            hex 0c 00 38 78 58 d8 f8 78 ; 1AC52:  0c 00 38 78 58 d8 f8 78
            hex 10 00 38 78 58 d8 f8 78 ; 1AC5A:  10 00 38 78 58 d8 f8 78
            hex 10 00 20 38 38 38 3c    ; 1AC62:  10 00 20 38 38 38 3c

            sec                         ; 1AC69:  38
            sei                         ; 1AC6A:  78
            rts                         ; 1AC6B:  60

            hex 20 38 38 38 3c          ; 1AC6C:  20 38 38 38 3c

            sec                         ; 1AC71:  38
            sei                         ; 1AC72:  78
            rts                         ; 1AC73:  60

            hex 1c                      ; 1AC74:  1c

            clc                         ; 1AC75:  18
            bmi b6_acd7+1               ; 1AC76:  30 60
            rti                         ; 1AC78:  40

            brk                         ; 1AC79:  00
            hex 00                      ; 1AC7A:  00
            brk                         ; 1AC7B:  00
            hex 1c                      ; 1AC7C:  1c
            clc                         ; 1AC7D:  18
            bmi b6_acdf+1               ; 1AC7E:  30 60
            rti                         ; 1AC80:  40

            brk                         ; 1AC81:  00
            hex 00                      ; 1AC82:  00
            brk                         ; 1AC83:  00
            hex 30                      ; 1AC84:  30
            rts                         ; 1AC85:  60

            hex 60 60 60                ; 1AC86:  60 60 60

            brk                         ; 1AC89:  00
            hex 00                      ; 1AC8A:  00
            ora ($30,x)                 ; 1AC8B:  01 30
            rts                         ; 1AC8D:  60

            hex 60 60 60 00 00 01 03 03 ; 1AC8E:  60 60 60 00 00 01 03 03
            hex 02 00 00 00 00 00 03 03 ; 1AC96:  02 00 00 00 00 00 03 03
            hex 02 00 00 00 00 00 c1 c2 ; 1AC9E:  02 00 00 00 00 00 c1 c2
            hex c4 c0 c4 c0 c0 80 c2 cd ; 1ACA6:  c4 c0 c4 c0 c0 80 c2 cd
            hex c3 c1 c0 c0 c0 80 08 0c ; 1ACAE:  c3 c1 c0 c0 c0 80 08 0c
            hex 06 7a 84 0c 00 00 37 92 ; 1ACB6:  06 7a 84 0c 00 00 37 92

            hex 1d 04 00 ; ora ptr2_lo,x  ; 1ACBE:  1d 04 00
            clc                         ; 1ACC1:  18
            asl tab_b6_8000+7           ; 1ACC2:  0e 07 80
            brk                         ; 1ACC5:  00
            hex 00                      ; 1ACC6:  00
            brk                         ; 1ACC7:  00
            hex 00                      ; 1ACC8:  00
            brk                         ; 1ACC9:  00
            hex 00                      ; 1ACCA:  00
            brk                         ; 1ACCB:  00
            hex 80                      ; 1ACCC:  80
            brk                         ; 1ACCD:  00
            hex 00                      ; 1ACCE:  00
            brk                         ; 1ACCF:  00
            hex 00                      ; 1ACD0:  00
            brk                         ; 1ACD1:  00
            hex 00                      ; 1ACD2:  00
            brk                         ; 1ACD3:  00
            hex 18                      ; 1ACD4:  18
            bpl tab_b6_ace2+37          ; 1ACD5:  10 30
b6_acd7:    bmi tab_b6_ace2+39          ; 1ACD7:  30 30
            rts                         ; 1ACD9:  60

            cpx #$e0                    ; 1ACDA:  e0 e0
            clc                         ; 1ACDC:  18
            bpl tab_b6_ace2+45          ; 1ACDD:  10 30
b6_acdf:    bmi tab_b6_ace2+47          ; 1ACDF:  30 30
            rts                         ; 1ACE1:  60

tab_b6_ace2: ; 122 bytes
            hex e0 e0 00 00 00 00 00 00 ; 1ACE2:  e0 e0 00 00 00 00 00 00
            hex 00 00 00 00 00 01 02 00 ; 1ACEA:  00 00 00 00 00 01 02 00
            hex 00 00 00 03 04 00 00 00 ; 1ACF2:  00 00 00 03 04 00 00 00
            hex 00 00 00 00 05 00 00 00 ; 1ACFA:  00 00 00 00 05 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AD02:  00 00 00 00 00 00 00 00
            hex 00 00 00 08 0b 00 0e 00 ; 1AD0A:  00 00 00 08 0b 00 0e 00
            hex 00 00 00 12 15 00 00 00 ; 1AD12:  00 00 00 12 15 00 00 00
            hex 18 19 00 1c 1f 00 00 00 ; 1AD1A:  18 19 00 1c 1f 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AD22:  00 00 00 00 00 00 00 00
            hex 06 07 09 0a 0c 0d 0f 00 ; 1AD2A:  06 07 09 0a 0c 0d 0f 00
            hex 10 11 13 14 16 00 17 00 ; 1AD32:  10 11 13 14 16 00 17 00
            hex 1a 1b 1d 1e 20 21 00 00 ; 1AD3A:  1a 1b 1d 1e 20 21 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AD42:  00 00 00 00 00 00 00 00
            hex 23 24 27 28 2a 2b 2e 00 ; 1AD4A:  23 24 27 28 2a 2b 2e 00
            hex 31 32 35 36 38 00 39 00 ; 1AD52:  31 32 35 36 38 00 39 00
            hex 00 3b                   ; 1AD5A:  00 3b

            brk                         ; 1AD5C:  00
            hex 3e                      ; 1AD5D:  3e
            rti                         ; 1AD5E:  40

            hex 00 00 00 00 00 00 00 00 ; 1AD5F:  00 00 00 00 00 00 00 00
            hex 00 00 22 25 26 00 29 2c ; 1AD67:  00 00 22 25 26 00 29 2c
            hex 2d 2f 30 33 34 13 37 00 ; 1AD6F:  2d 2f 30 33 34 13 37 00
            hex 00 3a 00 3c 3d 00 3f 41 ; 1AD77:  00 3a 00 3c 3d 00 3f 41
            hex 00 00 00 00 00 00 00 00 ; 1AD7F:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 44 45 00 ; 1AD87:  00 00 00 00 00 44 45 00
            hex 47 4a 00 4c 4d 50 51 00 ; 1AD8F:  47 4a 00 4c 4d 50 51 00
            hex 00 55 56 59 5a 5d 5e 60 ; 1AD97:  00 55 56 59 5a 5d 5e 60
            hex 00 00 00 00 00 00 00 00 ; 1AD9F:  00 00 00 00 00 00 00 00
            hex 00 00 00 42 43 00 46 48 ; 1ADA7:  00 00 00 42 43 00 46 48
            hex 49 4b 00 4e 4f 52 53 54 ; 1ADAF:  49 4b 00 4e 4f 52 53 54
            hex 00 57 58 5b 5c 00 5f 61 ; 1ADB7:  00 57 58 5b 5c 00 5f 61
            hex 00 00 00 00 00 00 00 00 ; 1ADBF:  00 00 00 00 00 00 00 00
            hex 00 00 00 62 63 00 66 68 ; 1ADC7:  00 00 00 62 63 00 66 68
            hex 69 6c 00 6e 6f 72 73 74 ; 1ADCF:  69 6c 00 6e 6f 72 73 74
            hex 75 76 77 00 7a 00 7d 7f ; 1ADD7:  75 76 77 00 7a 00 7d 7f
            hex 00 00 00 00 00 00 00 00 ; 1ADDF:  00 00 00 00 00 00 00 00
            hex 00 00 00 64 65 00 67 6a ; 1ADE7:  00 00 00 64 65 00 67 6a
            hex 6b 6d 00 70 71 00 00 00 ; 1ADEF:  6b 6d 00 70 71 00 00 00
            hex 00 78 79 7b 7c 7e 00 80 ; 1ADF7:  00 78 79 7b 7c 7e 00 80
            hex 00 00 00 00 00 00 00 00 ; 1ADFF:  00 00 00 00 00 00 00 00
            hex 00 00 00 81 82 85 86 89 ; 1AE07:  00 00 00 81 82 85 86 89
            hex 8a 8d 8e 91 92 00 95 97 ; 1AE0F:  8a 8d 8e 91 92 00 95 97
            hex 00 99 9a 9c 9d 00 9f a1 ; 1AE17:  00 99 9a 9c 9d 00 9f a1
            hex 00 00 00 00 00 00 00 00 ; 1AE1F:  00 00 00 00 00 00 00 00
            hex 00 00 00 83 84 87 88 8b ; 1AE27:  00 00 00 83 84 87 88 8b
            hex 8c 8f 90 93 94 00 96 98 ; 1AE2F:  8c 8f 90 93 94 00 96 98
            hex 00 18 9b 00 9e 00 a0 a2 ; 1AE37:  00 18 9b 00 9e 00 a0 a2
            hex 00 00 00 00 00 00 00 00 ; 1AE3F:  00 00 00 00 00 00 00 00
            hex 00 00 00 a3 a4 00 a7 a9 ; 1AE47:  00 00 00 a3 a4 00 a7 a9
            hex aa ad ae b0 b1 00 00 00 ; 1AE4F:  aa ad ae b0 b1 00 00 00
            hex 00 b4 b5 00 b8 00 b9 ba ; 1AE57:  00 b4 b5 00 b8 00 b9 ba
            hex 00 00 00 00 00 00 00 00 ; 1AE5F:  00 00 00 00 00 00 00 00
            hex 00 00 00 a5 a6 00 a8 ab ; 1AE67:  00 00 00 a5 a6 00 a8 ab
            hex ac af 00 b2 b3 00 00 00 ; 1AE6F:  ac af 00 b2 b3 00 00 00
            hex 00 b6 b7 00 00 00 00 90 ; 1AE77:  00 b6 b7 00 00 00 00 90
            hex 00 00 00 00 00 00 00 00 ; 1AE7F:  00 00 00 00 00 00 00 00
            hex 00 00 00 bb bc bd be bf ; 1AE87:  00 00 00 bb bc bd be bf
            hex c0 c1 00 c3 c4 00 00 00 ; 1AE8F:  c0 c1 00 c3 c4 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AE97:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AE9F:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AEA7:  00 00 00 00 00 00 00 00
            hex 00 c2 00 00 00 00 00 00 ; 1AEAF:  00 c2 00 00 00 00 00 00
            hex 00 00 00 00 c5 c6 00 00 ; 1AEB7:  00 00 00 00 c5 c6 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AEBF:  00 00 00 00 00 00 00 00
            hex c7 c9 00 00 00 00 00 00 ; 1AEC7:  c7 c9 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 cc ; 1AECF:  00 00 00 00 00 00 00 cc
            hex cd d0 d1 d4 d5 d8 d9 00 ; 1AED7:  cd d0 d1 d4 d5 d8 d9 00
            hex 00 00 00 00 00 00 00 00 ; 1AEDF:  00 00 00 00 00 00 00 00
            hex c8 ca 00 00 00 00 00 00 ; 1AEE7:  c8 ca 00 00 00 00 00 00
            hex 00 00 00 00 00 00 cb ce ; 1AEEF:  00 00 00 00 00 00 cb ce
            hex cf d2 d3 d6 d7 da db dc ; 1AEF7:  cf d2 d3 d6 d7 da db dc
            hex 00 00 00 00 00 00 00 00 ; 1AEFF:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AF07:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 dd df ; 1AF0F:  00 00 00 00 00 00 dd df
            hex e0 e3 e4 e7 e8 eb ec ef ; 1AF17:  e0 e3 e4 e7 e8 eb ec ef
            hex f0 00 00 00 00 00 00 00 ; 1AF1F:  f0 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AF27:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 de e1 ; 1AF2F:  00 00 00 00 00 00 de e1
            hex e2 e5 e6 e9 ea ed ee f1 ; 1AF37:  e2 e5 e6 e9 ea ed ee f1
            hex 00 00 00 00 00 00 00 00 ; 1AF3F:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AF47:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AF4F:  00 00 00 00 00 00 00 00
            hex f2 f3 f4 f5 f6 f7 00 00 ; 1AF57:  f2 f3 f4 f5 f6 f7 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AF5F:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AF67:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1AF6F:  00 00 00 00 00 00 00 00
            hex 00 01 03 1f 03 00 00 00 ; 1AF77:  00 01 03 1f 03 00 00 00
            hex 00 01 03 1f 03 00 00 00 ; 1AF7F:  00 01 03 1f 03 00 00 00
            hex 0c fe ff fc c0 00 00 00 ; 1AF87:  0c fe ff fc c0 00 00 00
            hex 0c fe ff fc c0 00 03 01 ; 1AF8F:  0c fe ff fc c0 00 03 01
            hex 01 01 e1 71 39 00 03 01 ; 1AF97:  01 01 e1 71 39 00 03 01
            hex 01 01 e1 71 39 00 00 80 ; 1AF9F:  01 01 e1 71 39 00 00 80
            hex c0 c0 c0 fc fc 00 00 80 ; 1AFA7:  c0 c0 c0 fc fc 00 00 80
            hex c0 c0 c0 fc fc 00 00 00 ; 1AFAF:  c0 c0 c0 fc fc 00 00 00
            hex 20 30 f8 78 f8 00 00 00 ; 1AFB7:  20 30 f8 78 f8 00 00 00
            hex 20 30 f8 78 f8 00 00 00 ; 1AFBF:  20 30 f8 78 f8 00 00 00
            hex 0c 0e 0f 0f 1f 00 00 00 ; 1AFC7:  0c 0e 0f 0f 1f 00 00 00
            hex 0c 0e 0f 0f 1f 00 00 00 ; 1AFCF:  0c 0e 0f 0f 1f 00 00 00
            hex 00 f0 f8 f8 e0 00 00 00 ; 1AFD7:  00 f0 f8 f8 e0 00 00 00
            hex 00 f0 f8 f8 e0 00 00 00 ; 1AFDF:  00 f0 f8 f8 e0 00 00 00
            hex 00 04 04 04 06 00 00 00 ; 1AFE7:  00 04 04 04 06 00 00 00
            hex 00 04 04 04 06 00 00 00 ; 1AFEF:  00 04 04 04 06 00 00 00
            hex 00 00 07 03 00 00 00 00 ; 1AFF7:  00 00 07 03 00 00 00 00
            hex 00 00 07 03 00 c3 c7 6f ; 1AFFF:  00 00 07 03 00 c3 c7 6f
            hex 33 07 cf e9 2f c3 c7 6f ; 1B007:  33 07 cf e9 2f c3 c7 6f
            hex 33 07 cf e9 2f 00 00 00 ; 1B00F:  33 07 cf e9 2f 00 00 00
            hex 00 00 00 20 3c 00 00 00 ; 1B017:  00 00 00 20 3c 00 00 00
            hex 00 00 00 20 3c 1c 98 20 ; 1B01F:  00 00 00 20 3c 1c 98 20
            hex 00 00 00 30 b0 1c 98 20 ; 1B027:  00 00 00 30 b0 1c 98 20
            hex 00 00 00 30 b0 01 03 0f ; 1B02F:  00 00 00 30 b0 01 03 0f
            hex 1c 21 03 02 02 01 03 0f ; 1B037:  1c 21 03 02 02 01 03 0f
            hex 1c 21 03 02 02 00 00 00 ; 1B03F:  1c 21 03 02 02 00 00 00
            hex 00 00 c0 e0 ef 00 00 00 ; 1B047:  00 00 c0 e0 ef 00 00 00
            hex 00 00 c0 e0 ef ff f0 00 ; 1B04F:  00 00 c0 e0 ef ff f0 00
            hex 3c f0 b0 30 f8 ff f0 00 ; 1B057:  3c f0 b0 30 f8 ff f0 00
            hex 3c f0 b0 30 f8 00 00 02 ; 1B05F:  3c f0 b0 30 f8 00 00 02
            hex 03 01 01 03 0c 00 00 02 ; 1B067:  03 01 01 03 0c 00 00 02
            hex 03 01 01 03 0c 00 00 00 ; 1B06F:  03 01 01 03 0c 00 00 00
            hex 00 80 ca 82 00 00 00 00 ; 1B077:  00 80 ca 82 00 00 00 00
            hex 00 80 ca 82 00 1f 3f ff ; 1B07F:  00 80 ca 82 00 1f 3f ff
            hex ff 5f 1e 1b fb 1f 3f ff ; 1B087:  ff 5f 1e 1b fb 1f 3f ff
            hex ff 5f 1e 1b fb 00 00 00 ; 1B08F:  ff 5f 1e 1b fb 00 00 00
            hex 00 00 00 01 03 00 00 00 ; 1B097:  00 00 00 01 03 00 00 00
            hex 00 00 00 01 03 cf ef fe ; 1B09F:  00 00 00 01 03 cf ef fe
            hex 21 48 f3 83 07 cf ef fe ; 1B0A7:  21 48 f3 83 07 cf ef fe
            hex 21 48 f3 83 07          ; 1B0AF:  21 48 f3 83 07

            ldy #$80                    ; 1B0B4:  a0 80
            brk                         ; 1B0B6:  00
            hex 00                      ; 1B0B7:  00
            beq tab_b6_b0c3+103         ; 1B0B8:  f0 70
            rts                         ; 1B0BA:  60

            hex e0 a0 80                ; 1B0BB:  e0 a0 80

            brk                         ; 1B0BE:  00
            hex 00                      ; 1B0BF:  00
            beq tab_b6_b0c3+111         ; 1B0C0:  f0 70
            rts                         ; 1B0C2:  60

tab_b6_b0c3: ; 158 bytes
            hex e0 c0 83 7f 07 0e 3c f8 ; 1B0C3:  e0 c0 83 7f 07 0e 3c f8
            hex bc c0 83 7f 07 0e 3c f8 ; 1B0CB:  bc c0 83 7f 07 0e 3c f8
            hex bc 00 00 00 00 00 03 07 ; 1B0D3:  bc 00 00 00 00 00 03 07
            hex 0e 00 00 00 00 00 03 07 ; 1B0DB:  0e 00 00 00 00 00 03 07
            hex 0e 00 00 00 00 00 00 00 ; 1B0E3:  0e 00 00 00 00 00 00 00
            hex 01 00 00 00 00 00 00 00 ; 1B0EB:  01 00 00 00 00 00 00 00
            hex 01 00 00 00 00 00 00 70 ; 1B0F3:  01 00 00 00 00 00 00 70
            hex f8 00 00 00 00 00 00 70 ; 1B0FB:  f8 00 00 00 00 00 00 70
            hex f8 07 4f 3f 00 00 00 00 ; 1B103:  f8 07 4f 3f 00 00 00 00
            hex 00 07 4f 3f 00 00 00 00 ; 1B10B:  00 07 4f 3f 00 00 00 00
            hex 00 f8 f0 f0 70 77 73 70 ; 1B113:  00 f8 f0 f0 70 77 73 70
            hex 70 f8 f0 f0 70 77 73 70 ; 1B11B:  70 f8 f0 f0 70 77 73 70
            hex 70 00 01 03 07 07 0f 1d ; 1B123:  70 00 01 03 07 07 0f 1d
            hex 3c 00 01 03 07 07 0f 1d ; 1B12B:  3c 00 01 03 07 07 0f 1d
            hex 3c 00 00 01 01 07 86 00 ; 1B133:  3c 00 00 01 01 07 86 00
            hex 00 00 00 01 01 07 86 00 ; 1B13B:  00 00 00 01 01 07 86 00
            hex 00 78 70 e0 c0 00 00 04 ; 1B143:  00 78 70 e0 c0 00 00 04
            hex 1e 78 70 e0 c0 00 00 04 ; 1B14B:  1e 78 70 e0 c0 00 00 04
            hex 1e e0 c0 c0 80 80 c0 e0 ; 1B153:  1e e0 c0 c0 80 80 c0 e0
            hex f0 e0 c0 c0 80 80       ; 1B15B:  f0 e0 c0 c0 80 80

            cpy #$e0                    ; 1B161:  c0 e0
            beq tab_b6_b1cd+20          ; 1B163:  f0 7c
            asl $030f,x                 ; 1B165:  1e 0f 03
            brk                         ; 1B168:  00
            hex 00                      ; 1B169:  00
            asl $7c43,x                 ; 1B16A:  1e 43 7c
            asl $030f,x                 ; 1B16D:  1e 0f 03
            brk                         ; 1B170:  00
            hex 00                      ; 1B171:  00
            hex 1e 43 00 ; asl $0043,x  ; 1B172:  1e 43 00
            brk                         ; 1B175:  00
            hex 00                      ; 1B176:  00
            cpy #$c0                    ; 1B177:  c0 c0
            rts                         ; 1B179:  60

            hex 30 08 00 00 00 c0 c0 60 ; 1B17A:  30 08 00 00 00 c0 c0 60
            hex 30 08 00 00 01 01 03 03 ; 1B182:  30 08 00 00 01 01 03 03
            hex 06 0c 00 00 01 01 03 03 ; 1B18A:  06 0c 00 00 01 01 03 03
            hex 06 0c ff 7e 1c 1c 3c 3e ; 1B192:  06 0c ff 7e 1c 1c 3c 3e
            hex 3f 6d ff 7e 1c 1c 3c    ; 1B19A:  3f 6d ff 7e 1c 1c 3c

            rol $6d3f,x                 ; 1B1A1:  3e 3f 6d
            brk                         ; 1B1A4:  00
            hex e0                      ; 1B1A5:  e0
            rts                         ; 1B1A6:  60

tab_b6_b1a7: ; 5 bytes
            hex 60 60 60 60 60          ; 1B1A7:  60 60 60 60 60

            brk                         ; 1B1AC:  00
            hex e0                      ; 1B1AD:  e0
            rts                         ; 1B1AE:  60

            hex 60 60 60 60 60 6b cb db ; 1B1AF:  60 60 60 60 60 6b cb db
            hex 99 99 01 01 00 6b cb db ; 1B1B7:  99 99 01 01 00 6b cb db

            sta $0199,y                 ; 1B1BF:  99 99 01
            ora (ptr0_lo,x)                 ; 1B1C2:  01 00
            rts                         ; 1B1C4:  60

            hex 60                      ; 1B1C5:  60

            bvs tab_b6_b1cd+107         ; 1B1C6:  70 70
            beq tab_b6_b1a7+3           ; 1B1C8:  f0 e0
            cpx #$e0                    ; 1B1CA:  e0 e0
            rts                         ; 1B1CC:  60

tab_b6_b1cd: ; 134 bytes
            hex 60 70 70 f0 e0 e0 e0 00 ; 1B1CD:  60 70 70 f0 e0 e0 e0 00
            hex 01 03 07 06 03 03 07 00 ; 1B1D5:  01 03 07 06 03 03 07 00
            hex 01 03 07 06 03 03 07 bf ; 1B1DD:  01 03 07 06 03 03 07 bf
            hex be 6c 69 dc f0 a0 00 bf ; 1B1E5:  be 6c 69 dc f0 a0 00 bf
            hex be 6c 69 dc f0 a0 00 00 ; 1B1ED:  be 6c 69 dc f0 a0 00 00
            hex 00 00 04 04 04 07 2e 00 ; 1B1F5:  00 00 04 04 04 07 2e 00
            hex 00 00 04 04 04 07 2e f0 ; 1B1FD:  00 00 04 04 04 07 2e f0
            hex e0 e4 e4 26 36 1f 0f f0 ; 1B205:  e0 e4 e4 26 36 1f 0f f0
            hex e0 e4 e4 26 36 1f 0f 05 ; 1B20D:  e0 e4 e4 26 36 1f 0f 05
            hex 0c 09 18 18 10 30 bb 05 ; 1B215:  0c 09 18 18 10 30 bb 05
            hex 0c 09 18 18 10 30 bb 03 ; 1B21D:  0c 09 18 18 10 30 bb 03
            hex 00 00 00 70 f0 80 00 03 ; 1B225:  00 00 00 70 f0 80 00 03
            hex 00 00 00 70 f0 80 00 e0 ; 1B22D:  00 00 00 70 f0 80 00 e0
            hex c0 c0 00 00 00 00 00 e0 ; 1B235:  c0 c0 00 00 00 00 00 e0
            hex c0 c0 00 00 00 00 00 18 ; 1B23D:  c0 c0 00 00 00 00 00 18
            hex e8 88 d8 70 78 fc ce 18 ; 1B245:  e8 88 d8 70 78 fc ce 18
            hex e8 88 d8 70 78 fc       ; 1B24D:  e8 88 d8 70 78 fc

            dec $0103                   ; 1B253:  ce 03 01
            brk                         ; 1B256:  00
            hex 00                      ; 1B257:  00
            rts                         ; 1B258:  60

            hex 70 63 67 03 01 00 00 60 ; 1B259:  70 63 67 03 01 00 00 60
            hex 70 63 67 00 e0 f8 00 00 ; 1B261:  70 63 67 00 e0 f8 00 00
            hex 00 c0 80 00 e0 f8 00 00 ; 1B269:  00 c0 80 00 e0 f8 00 00
            hex 00 c0 80                ; 1B271:  00 c0 80

            bpl tab_b6_b28a+4           ; 1B274:  10 18
            asl $030f                   ; 1B276:  0e 0f 03
            brk                         ; 1B279:  00
            hex 00                      ; 1B27A:  00
            brk                         ; 1B27B:  00
            hex 10                      ; 1B27C:  10
            clc                         ; 1B27D:  18
            asl $030f                   ; 1B27E:  0e 0f 03
            brk                         ; 1B281:  00
            hex 00                      ; 1B282:  00
            brk                         ; 1B283:  00
            hex 00                      ; 1B284:  00
            brk                         ; 1B285:  00
            hex 00                      ; 1B286:  00
            cpy #$e0                    ; 1B287:  c0 e0
            rts                         ; 1B289:  60

tab_b6_b28a: ; 344 bytes
            hex 00 00 00 00 00 c0 e0 60 ; 1B28A:  00 00 00 00 00 c0 e0 60
            hex 00 00 00 00 00 00 04 04 ; 1B292:  00 00 00 00 00 00 04 04
            hex 04 03 00 00 00 00 04 04 ; 1B29A:  04 03 00 00 00 00 04 04
            hex 04 03 00 00 00 00 00 00 ; 1B2A2:  04 03 00 00 00 00 00 00
            hex e0 c0 00 00 00 00 00 00 ; 1B2AA:  e0 c0 00 00 00 00 00 00
            hex e0 c0 0e 1c 18 00 00 00 ; 1B2B2:  e0 c0 0e 1c 18 00 00 00
            hex 00 00 0e 1c 18 00 00 00 ; 1B2BA:  00 00 0e 1c 18 00 00 00
            hex 00 00 0e 04 01 1b 0b 06 ; 1B2C2:  00 00 0e 04 01 1b 0b 06
            hex 0e 0c 0e 04 01 1b 0b 06 ; 1B2CA:  0e 0c 0e 04 01 1b 0b 06
            hex 0e 0c 18 18 30 70 e0 c0 ; 1B2D2:  0e 0c 18 18 30 70 e0 c0
            hex c0 80 18 18 30 70 e0 c0 ; 1B2DA:  c0 80 18 18 30 70 e0 c0
            hex c0 80 70 e0 c0 80 00 00 ; 1B2E2:  c0 80 70 e0 c0 80 00 00
            hex 00 00 70 e0 c0 80 00 00 ; 1B2EA:  00 00 70 e0 c0 80 00 00
            hex 00 00 1c 18 18 1c 0e 06 ; 1B2F2:  00 00 1c 18 18 1c 0e 06
            hex 03 03 1c 18 18 1c 0e 06 ; 1B2FA:  03 03 1c 18 18 1c 0e 06
            hex 03 03 02 20 18 18 18 10 ; 1B302:  03 03 02 20 18 18 18 10
            hex 10 17 02 20 18 18 18 10 ; 1B30A:  10 17 02 20 18 18 18 10
            hex 10 17 70 70 70 70 00 00 ; 1B312:  10 17 70 70 70 70 00 00
            hex 00 00 70 70 70 70 00 00 ; 1B31A:  00 00 70 70 70 70 00 00
            hex 00 00 08 07 03 00 00 00 ; 1B322:  00 00 08 07 03 00 00 00
            hex 03 01 08 07 03 00 00 00 ; 1B32A:  03 01 08 07 03 00 00 00
            hex 03 01 38 fc f8 c0 fc fc ; 1B332:  03 01 38 fc f8 c0 fc fc
            hex e0 e0 38 fc f8 c0 fc fc ; 1B33A:  e0 e0 38 fc f8 c0 fc fc
            hex e0 e0 06 1e 26 26 3e 30 ; 1B342:  e0 e0 06 1e 26 26 3e 30
            hex 23 22 06 1e 26 26 3e 30 ; 1B34A:  23 22 06 1e 26 26 3e 30
            hex 23 22 24 67 63 21 00 00 ; 1B352:  23 22 24 67 63 21 00 00
            hex 00 00 24 67 63 21 00 00 ; 1B35A:  00 00 24 67 63 21 00 00
            hex 00 00 63 7b 63 7b 3b 73 ; 1B362:  00 00 63 7b 63 7b 3b 73
            hex c3 63 63 7b 63 7b 3b 73 ; 1B36A:  c3 63 63 7b 63 7b 3b 73
            hex c3 63 23 a3 23 e3 ff 0f ; 1B372:  c3 63 23 a3 23 e3 ff 0f
            hex 03 00 23 a3 23 e3 ff 0f ; 1B37A:  03 00 23 a3 23 e3 ff 0f
            hex 03 00 04 04 0c 08 1f 1c ; 1B382:  03 00 04 04 0c 08 1f 1c
            hex 38 70 04 04 0c 08 1f 1c ; 1B38A:  38 70 04 04 0c 08 1f 1c
            hex 38 70 00 00 00 00 e0 e0 ; 1B392:  38 70 00 00 00 00 e0 e0
            hex 60 c0 00 00 00 00 e0 e0 ; 1B39A:  60 c0 00 00 00 00 e0 e0
            hex 60 c0 00 00 00 01 07 0e ; 1B3A2:  60 c0 00 00 00 01 07 0e
            hex 18 00 00 00 00 01 07 0e ; 1B3AA:  18 00 00 00 00 01 07 0e
            hex 18 00 3c 7c e0 f0 1f 01 ; 1B3B2:  18 00 3c 7c e0 f0 1f 01
            hex 02 04 3c 7c e0 f0 1f 01 ; 1B3BA:  02 04 3c 7c e0 f0 1f 01
            hex 02 04 08 34 24 2f 3c 68 ; 1B3C2:  02 04 08 34 24 2f 3c 68
            hex 78 b7 08 34 24 2f 3c 68 ; 1B3CA:  78 b7 08 34 24 2f 3c 68
            hex 78 b7 10 10 10 31 3f 1f ; 1B3D2:  78 b7 10 10 10 31 3f 1f
            hex 08 00 10 10 10 31 3f 1f ; 1B3DA:  08 00 10 10 10 31 3f 1f

            php                         ; 1B3E2:  08
            brk                         ; 1B3E3:  00
            hex 00                      ; 1B3E4:  00
            brk                         ; 1B3E5:  00
            hex 00                      ; 1B3E6:  00
            cpy #$20                    ; 1B3E7:  c0 20
            jsr $6060                   ; 1B3E9:  20 60 60
            brk                         ; 1B3EC:  00
            hex 00                      ; 1B3ED:  00
            brk                         ; 1B3EE:  00
            hex c0                      ; 1B3EF:  c0
            jsr $6020                   ; 1B3F0:  20 20 60
            rts                         ; 1B3F3:  60

            hex 03 0f 0f 01 00 00 00 00 ; 1B3F4:  03 0f 0f 01 00 00 00 00
            hex 03 0f 0f                ; 1B3FC:  03 0f 0f

            ora (ptr0_lo,x)                 ; 1B3FF:  01 00
            brk                         ; 1B401:  00
            hex 00                      ; 1B402:  00
            brk                         ; 1B403:  00
            hex 6f                      ; 1B404:  6f
            ror $f07c,x                 ; 1B405:  7e 7c f0
            cpx #$e0                    ; 1B408:  e0 e0
            rti                         ; 1B40A:  40

            hex 78 6f                   ; 1B40B:  78 6f

            ror $f07c,x                 ; 1B40D:  7e 7c f0
            cpx #$e0                    ; 1B410:  e0 e0
            rti                         ; 1B412:  40

            hex 78 f8 70 e0 c3 cf fe f8 ; 1B413:  78 f8 70 e0 c3 cf fe f8
            hex 00 f8 70 e0 c3 cf fe f8 ; 1B41B:  00 f8 70 e0 c3 cf fe f8
            hex 00 03 03 03 03 01 00 00 ; 1B423:  00 03 03 03 03 01 00 00
            hex 00 03 03 03 03 01 00 00 ; 1B42B:  00 03 03 03 03 01 00 00
            hex 00 80 00 00 00 e0 00 00 ; 1B433:  00 80 00 00 00 e0 00 00
            hex 00 80 00 00 00 e0 00 00 ; 1B43B:  00 80 00 00 00 e0 00 00
            hex 00 00 00 00 00 00 01 01 ; 1B443:  00 00 00 00 00 00 01 01
            hex 03                      ; 1B44B:  03

            brk                         ; 1B44C:  00
            hex 00                      ; 1B44D:  00
            brk                         ; 1B44E:  00
            hex 00                      ; 1B44F:  00
            brk                         ; 1B450:  00
            hex 01                      ; 1B451:  01
            ora (ptr1_hi,x)                 ; 1B452:  01 03
            brk                         ; 1B454:  00
            hex 00                      ; 1B455:  00
            rti                         ; 1B456:  40

            hex 60 e0 c0 80             ; 1B457:  60 e0 c0 80

            brk                         ; 1B45B:  00
            hex 00                      ; 1B45C:  00
            brk                         ; 1B45D:  00
            hex 40                      ; 1B45E:  40
            rts                         ; 1B45F:  60

            hex e0 c0 80 00 07 3e 3c 30 ; 1B460:  e0 c0 80 00 07 3e 3c 30
            hex 00 00 00 00 07 3e 3c 30 ; 1B468:  00 00 00 00 07 3e 3c 30
            hex 00 00 00 00 00 00 0e 1e ; 1B470:  00 00 00 00 00 00 0e 1e
            hex 3f 78 e0 c0 00 00 0e 1e ; 1B478:  3f 78 e0 c0 00 00 0e 1e
            hex 3f 78 e0 c0 01 03 03 07 ; 1B480:  3f 78 e0 c0 01 03 03 07
            hex 0f 0f 06 00 01 03 03 07 ; 1B488:  0f 0f 06 00 01 03 03 07
            hex 0f 0f 06 00 c0 83 83 70 ; 1B490:  0f 0f 06 00 c0 83 83 70
            hex fa 76 ec d8 c0 83 83 70 ; 1B498:  fa 76 ec d8 c0 83 83 70
            hex fa 76 ec d8 7e ef 87 0f ; 1B4A0:  fa 76 ec d8 7e ef 87 0f
            hex 0f 0f 0f 0e 7e ef 87 0f ; 1B4A8:  0f 0f 0f 0e 7e ef 87 0f
            hex 0f 0f 0f 0e 1f 19 01 01 ; 1B4B0:  0f 0f 0f 0e 1f 19 01 01
            hex 01 03 03 06 1f 19 01 01 ; 1B4B8:  01 03 03 06 1f 19 01 01
            hex 01 03 03 06 c0 c0 c0 c0 ; 1B4C0:  01 03 03 06 c0 c0 c0 c0
            hex 80 80 00 00 c0 c0 c0 c0 ; 1B4C8:  80 80 00 00 c0 c0 c0 c0
            hex 80 80                   ; 1B4D0:  80 80

            brk                         ; 1B4D2:  00
            hex 00                      ; 1B4D3:  00
            php                         ; 1B4D4:  08
            bpl b6_b4d7                 ; 1B4D5:  10 00
b6_b4d7:    brk                         ; 1B4D7:  00
            hex 3c                      ; 1B4D8:  3c
            asl $080e,x                 ; 1B4D9:  1e 0e 08
            php                         ; 1B4DC:  08
            bpl b6_b4df                 ; 1B4DD:  10 00
b6_b4df:    brk                         ; 1B4DF:  00
            hex 3c                      ; 1B4E0:  3c
            asl $080e,x                 ; 1B4E1:  1e 0e 08
            brk                         ; 1B4E4:  00
            hex 00                      ; 1B4E5:  00
            brk                         ; 1B4E6:  00
            hex 00                      ; 1B4E7:  00
            jmp $004c                   ; 1B4E8:  4c 4c 00

            brk                         ; 1B4EB:  00
            hex 00                      ; 1B4EC:  00
            brk                         ; 1B4ED:  00
            hex 00                      ; 1B4EE:  00
            brk                         ; 1B4EF:  00
            hex 4c                      ; 1B4F0:  4c
            jmp ptr0_lo                   ; 1B4F1:  4c 00 00

            hex 01 01 01 03 06 0c 30 00 ; 1B4F4:  01 01 01 03 06 0c 30 00
            hex 01 01 01 03 06 0c 30 00 ; 1B4FC:  01 01 01 03 06 0c 30 00
            hex b0 90 9c 0e 07 03 01 00 ; 1B504:  b0 90 9c 0e 07 03 01 00
            hex b0 90 9c 0e 07 03 01 00 ; 1B50C:  b0 90 9c 0e 07 03 01 00
            hex 00 00 00 00 00 01 02 03 ; 1B514:  00 00 00 00 00 01 02 03
            hex 00 00 00 00 00 01 02 03 ; 1B51C:  00 00 00 00 00 01 02 03

            brk                         ; 1B524:  00
            hex 00                      ; 1B525:  00
            rti                         ; 1B526:  40

            sei                         ; 1B527:  78
            cpy $cc4c                   ; 1B528:  cc 4c cc
            hex 8c 00 00 ; sty ptr0_lo    ; 1B52B:  8c 00 00
            rti                         ; 1B52E:  40

            hex 78 cc 4c cc 8c 00 00 00 ; 1B52F:  78 cc 4c cc 8c 00 00 00
            hex 00 00 c0 e0 70 00 00 00 ; 1B537:  00 00 c0 e0 70 00 00 00
            hex 00 00 c0 e0 70 02 02 03 ; 1B53F:  00 00 c0 e0 70 02 02 03
            hex 01 01 07 03 02 02 02 03 ; 1B547:  01 01 07 03 02 02 02 03
            hex 01 01 07 03 02 06 0f 07 ; 1B54F:  01 01 07 03 02 06 0f 07
            hex 7e 00 00 00 00 06 0f 07 ; 1B557:  7e 00 00 00 00 06 0f 07

            hex 7e 00 00 ; ror ptr0_lo,x  ; 1B55F:  7e 00 00
            brk                         ; 1B562:  00
            hex 00                      ; 1B563:  00
            brk                         ; 1B564:  00
            hex 00                      ; 1B565:  00
            brk                         ; 1B566:  00
            hex 80                      ; 1B567:  80
            cpx #$e0                    ; 1B568:  e0 e0
            rts                         ; 1B56A:  60

            hex 40                      ; 1B56B:  40

            brk                         ; 1B56C:  00
            hex 00                      ; 1B56D:  00
            brk                         ; 1B56E:  00
            hex 80                      ; 1B56F:  80
            cpx #$e0                    ; 1B570:  e0 e0
            rts                         ; 1B572:  60

            hex 40 40 fc fe 06 00 00 00 ; 1B573:  40 40 fc fe 06 00 00 00
            hex 00 40 fc fe 06 00 00 00 ; 1B57B:  00 40 fc fe 06 00 00 00
            hex 00 07 0b 0f 0f 01 01 02 ; 1B583:  00 07 0b 0f 0f 01 01 02
            hex 04 07 0b 0f 0f 01 01 02 ; 1B58B:  04 07 0b 0f 0f 01 01 02
            hex 04 c0 80 80 00 00 00 00 ; 1B593:  04 c0 80 80 00 00 00 00
            hex 00 c0 80 80 00 00 00 00 ; 1B59B:  00 c0 80 80 00 00 00 00
            hex 00 00 08 10 26 6f 33 01 ; 1B5A3:  00 00 08 10 26 6f 33 01
            hex 00 00 08 10 26 6f 33 01 ; 1B5AB:  00 00 08 10 26 6f 33 01
            hex 00 00 00 78 18 00 80 80 ; 1B5B3:  00 00 00 78 18 00 80 80
            hex c0 00 00 78 18 00 80 80 ; 1B5BB:  c0 00 00 78 18 00 80 80
            hex c0 b4 e7 43 00 00 00 30 ; 1B5C3:  c0 b4 e7 43 00 00 00 30
            hex 3c b4 e7 43 00 00 00 30 ; 1B5CB:  3c b4 e7 43 00 00 00 30
            hex 3c 3c 1f 1f 7e 7d 1f 3f ; 1B5D3:  3c 3c 1f 1f 7e 7d 1f 3f
            hex 7e 3c 1f 1f 7e 7d 1f 3f ; 1B5DB:  7e 3c 1f 1f 7e 7d 1f 3f
            hex 7e c0 e0 20 00 00 00 00 ; 1B5E3:  7e c0 e0 20 00 00 00 00
            hex 00 c0 e0 20 00 00 00 00 ; 1B5EB:  00 c0 e0 20 00 00 00 00
            hex 00 00 00 00 00 00 03    ; 1B5F3:  00 00 00 00 00 00 03

            ora (ptr0_lo,x)                 ; 1B5FA:  01 00
            brk                         ; 1B5FC:  00
            hex 00                      ; 1B5FD:  00
            brk                         ; 1B5FE:  00
            hex 00                      ; 1B5FF:  00
            brk                         ; 1B600:  00
            hex 03                      ; 1B601:  03
            ora (ptr0_lo,x)                 ; 1B602:  01 00
            brk                         ; 1B604:  00
            hex 00                      ; 1B605:  00
            rts                         ; 1B606:  60

            hex fc 9c                   ; 1B607:  fc 9c

            hex fe c0 00 ; inc $00c0,x  ; 1B609:  fe c0 00
            brk                         ; 1B60C:  00
            hex 00                      ; 1B60D:  00
            rts                         ; 1B60E:  60

            hex fc 9c                   ; 1B60F:  fc 9c

            hex fe c0 00 ; inc $00c0,x  ; 1B611:  fe c0 00
            brk                         ; 1B614:  00
            hex 01                      ; 1B615:  01
            ora (ptr0_hi,x)                 ; 1B616:  01 01
            brk                         ; 1B618:  00
            hex 00                      ; 1B619:  00
            brk                         ; 1B61A:  00
            hex 00                      ; 1B61B:  00
            brk                         ; 1B61C:  00
            hex 01                      ; 1B61D:  01
            ora (ptr0_hi,x)                 ; 1B61E:  01 01
            brk                         ; 1B620:  00
            hex 00                      ; 1B621:  00
            brk                         ; 1B622:  00
            hex 00                      ; 1B623:  00
            brk                         ; 1B624:  00
            hex 00                      ; 1B625:  00
            brk                         ; 1B626:  00
            hex 00                      ; 1B627:  00
            rts                         ; 1B628:  60

            hex f0 f0 c0 00 00 00 00 60 ; 1B629:  f0 f0 c0 00 00 00 00 60
            hex f0 f0 c0 80 b0 f8 e0 c0 ; 1B631:  f0 f0 c0 80 b0 f8 e0 c0
            hex c0 78 70 80 b0 f8 e0 c0 ; 1B639:  c0 78 70 80 b0 f8 e0 c0
            hex c0 78 70 02 02 01 00 00 ; 1B641:  c0 78 70 02 02 01 00 00
            hex 00 00 00 02 02 01 00 00 ; 1B649:  00 00 00 02 02 01 00 00
            hex 00 00 00 00 00 80       ; 1B651:  00 00 00 00 00 80

            cpy #$40                    ; 1B657:  c0 40
            rts                         ; 1B659:  60

            hex 60                      ; 1B65A:  60

            brk                         ; 1B65B:  00
            hex 00                      ; 1B65C:  00
            brk                         ; 1B65D:  00
            hex 80                      ; 1B65E:  80
            cpy #$40                    ; 1B65F:  c0 40
            rts                         ; 1B661:  60

            hex 60 00 00 00 00 00 00 07 ; 1B662:  60 00 00 00 00 00 00 07
            hex 01 03 00 00 00 00 00 07 ; 1B66A:  01 03 00 00 00 00 00 07
            hex 01 03 00 00 00 00 00 c0 ; 1B672:  01 03 00 00 00 00 00 c0
            hex c0 00 00 00 00 00 00 c0 ; 1B67A:  c0 00 00 00 00 00 00 c0
            hex c0 00 03 03 03 00 00 00 ; 1B682:  c0 00 03 03 03 00 00 00
            hex 00 00 03 03 03 00 00 00 ; 1B68A:  00 00 03 03 03 00 00 00
            hex 00 00 f4 f3 e1 c1 01 00 ; 1B692:  00 00 f4 f3 e1 c1 01 00
            hex 00 00 f4 f3 e1 c1 01 00 ; 1B69A:  00 00 f4 f3 e1 c1 01 00
            hex 00 00 1e 3c fc fc f8 f8 ; 1B6A2:  00 00 1e 3c fc fc f8 f8
            hex 00 00 1e 3c fc fc f8 f8 ; 1B6AA:  00 00 1e 3c fc fc f8 f8
            hex 00 00 00 06 07 00 00 00 ; 1B6B2:  00 00 00 06 07 00 00 00
            hex 00 00 00 06 07 00 00 00 ; 1B6BA:  00 00 00 06 07 00 00 00
            hex 00 00 0c 0e 0e 1e 1c 00 ; 1B6C2:  00 00 0c 0e 0e 1e 1c 00
            hex 00 10 0c 0e 0e 1e 1c 00 ; 1B6CA:  00 10 0c 0e 0e 1e 1c 00
            hex 00 10 c0 f0 78 00 00 00 ; 1B6D2:  00 10 c0 f0 78 00 00 00
            hex 00 00 c0 f0 78 00 00 00 ; 1B6DA:  00 00 c0 f0 78 00 00 00
            hex 00 00 10 10 10 11 12 b4 ; 1B6E2:  00 00 10 10 10 11 12 b4
            hex a1 a1 10 10 10 11 12 b4 ; 1B6EA:  a1 a1 10 10 10 11 12 b4
            hex a1 a1 00 00 00 c0 c0 c0 ; 1B6F2:  a1 a1 00 00 00 c0 c0 c0
            hex 80 80 00 00 00 c0 c0 c0 ; 1B6FA:  80 80 00 00 00 c0 c0 c0
            hex 80 80 0c 18 18 00 00 00 ; 1B702:  80 80 0c 18 18 00 00 00
            hex e0 3f 0c 18 18 00 00 00 ; 1B70A:  e0 3f 0c 18 18 00 00 00
            hex e0 3f 00 01 06 02 02 02 ; 1B712:  e0 3f 00 01 06 02 02 02
            hex 03 01 00 01 06 02 02 02 ; 1B71A:  03 01 00 01 06 02 02 02
            hex 03 01 7f f3 73 63 73 1b ; 1B722:  03 01 7f f3 73 63 73 1b
            hex 3b 73 7f f3 73 63 73 1b ; 1B72A:  3b 73 7f f3 73 63 73 1b
            hex 3b 73 01 00 00 01 7f 3c ; 1B732:  3b 73 01 00 00 01 7f 3c
            hex 00 00 01 00 00 01 7f 3c ; 1B73A:  00 00 01 00 00 01 7f 3c
            hex 00 00 80 80 80 00 00 80 ; 1B742:  00 00 80 80 80 00 00 80
            hex 80 80 80 80 80 00 00 80 ; 1B74A:  80 80 80 80 80 00 00 80
            hex 80 80 80 8e fe fe c0 c0 ; 1B752:  80 80 80 8e fe fe c0 c0
            hex c0 c0 80 8e fe fe c0 c0 ; 1B75A:  c0 c0 80 8e fe fe c0 c0
            hex c0 c0 c0 80 80 80 80 80 ; 1B762:  c0 c0 c0 80 80 80 80 80
            hex 80 80 c0 80 80 80 80 80 ; 1B76A:  80 80 c0 80 80 80 80 80
            hex 80 80 00 00 00 00 00 00 ; 1B772:  80 80 00 00 00 00 00 00
            hex 0d 07 00 00 00 00 00 00 ; 1B77A:  0d 07 00 00 00 00 00 00
            hex 0d 07 60 30 30 18 1c 0c ; 1B782:  0d 07 60 30 30 18 1c 0c

            cpy #$60                    ; 1B78A:  c0 60
            rts                         ; 1B78C:  60

            hex 30 30 18 1c 0c c0 60 03 ; 1B78D:  30 30 18 1c 0c c0 60 03
            hex 07 05 07 00 00 00 0f 03 ; 1B795:  07 05 07 00 00 00 0f 03
            hex 07 05 07 00 00 00 0f 20 ; 1B79D:  07 05 07 00 00 00 0f 20
            hex 60 c0 80 80             ; 1B7A5:  60 c0 80 80

            cpx #$e0                    ; 1B7A9:  e0 e0
            cpx #$20                    ; 1B7AB:  e0 20
            rts                         ; 1B7AD:  60

            hex c0 80 80 e0 e0 e0 03 1f ; 1B7AE:  c0 80 80 e0 e0 e0 03 1f
            hex 1e 18 00 01 03 06 03 1f ; 1B7B6:  1e 18 00 01 03 06 03 1f
            hex 1e 18 00 01 03 06 ec 18 ; 1B7BE:  1e 18 00 01 03 06 ec 18
            hex 33 7f fb b9 3f 37 ec 18 ; 1B7C6:  33 7f fb b9 3f 37 ec 18
            hex 33 7f fb b9 3f 37 0c 18 ; 1B7CE:  33 7f fb b9 3f 37 0c 18
            hex 38 70 60 c0 80 00 0c 18 ; 1B7D6:  38 70 60 c0 80 00 0c 18
            hex 38 70 60 c0 80 00 31 39 ; 1B7DE:  38 70 60 c0 80 00 31 39
            hex 1d 0f 0f 07 03 00 31 39 ; 1B7E6:  1d 0f 0f 07 03 00 31 39
            hex 1d 0f 0f 07 03 00 00 00 ; 1B7EE:  1d 0f 0f 07 03 00 00 00
            hex 00 80 80 80 80 80 00 00 ; 1B7F6:  00 80 80 80 80 80 00 00
            hex 00 80 80 80 80 80 00 00 ; 1B7FE:  00 80 80 80 80 80 00 00
            hex 00 01 00 00 04 0e 00 00 ; 1B806:  00 01 00 00 04 0e 00 00
            hex 00 01 00 00 04 0e 80 80 ; 1B80E:  00 01 00 00 04 0e 80 80
            hex c0 c0 c0 80 80 00 80 80 ; 1B816:  c0 c0 c0 80 80 00 80 80
            hex c0 c0 c0 80 80 00 04 00 ; 1B81E:  c0 c0 c0 80 80 00 04 00
            hex 03 06 1c 39 31 23 04 00 ; 1B826:  03 06 1c 39 31 23 04 00
            hex 03 06 1c 39 31 23 20 c0 ; 1B82E:  03 06 1c 39 31 23 20 c0
            hex 80 e0 fc ce 5c c7 20 c0 ; 1B836:  80 e0 fc ce 5c c7 20 c0
            hex 80 e0 fc ce 5c c7 00 00 ; 1B83E:  80 e0 fc ce 5c c7 00 00
            hex 00 00 00 00 00 80 00 00 ; 1B846:  00 00 00 00 00 80 00 00
            hex 00 00 00 00 00 80 09 83 ; 1B84E:  00 00 00 00 00 80 09 83
            hex 06 00 78 e8 88 18 09 83 ; 1B856:  06 00 78 e8 88 18 09 83
            hex 06 00 78 e8 88 18 80 80 ; 1B85E:  06 00 78 e8 88 18 80 80
            hex 00 00 00 00 00 00 80 80 ; 1B866:  00 00 00 00 00 00 80 80
            hex 00 00 00 00 00 00 03 06 ; 1B86E:  00 00 00 00 00 00 03 06
            hex 0c 18 10 30 00 00 03 06 ; 1B876:  0c 18 10 30 00 00 03 06
            hex 0c 18 10 30 00 00 00 7c ; 1B87E:  0c 18 10 30 00 00 00 7c
            hex 3c                      ; 1B886:  3c

            brk                         ; 1B887:  00
            hex c0                      ; 1B888:  c0
            rti                         ; 1B889:  40

            hex 40 40 00 7c 3c          ; 1B88A:  40 40 00 7c 3c

            brk                         ; 1B88F:  00
            hex c0                      ; 1B890:  c0
            rti                         ; 1B891:  40

            hex 40 40 00 00 03          ; 1B892:  40 40 00 00 03

            brk                         ; 1B897:  00
            hex 00                      ; 1B898:  00
            brk                         ; 1B899:  00
            hex 00                      ; 1B89A:  00
            brk                         ; 1B89B:  00
            hex 00                      ; 1B89C:  00
            brk                         ; 1B89D:  00
            hex 03                      ; 1B89E:  03
            brk                         ; 1B89F:  00
            hex 00                      ; 1B8A0:  00
            brk                         ; 1B8A1:  00
            hex 00                      ; 1B8A2:  00
            brk                         ; 1B8A3:  00
            hex 40                      ; 1B8A4:  40
            cpy #$e0                    ; 1B8A5:  c0 e0
            jsr $6020                   ; 1B8A7:  20 20 60
            rti                         ; 1B8AA:  40

            cpy #$40                    ; 1B8AB:  c0 40
            cpy #$e0                    ; 1B8AD:  c0 e0
            jsr $6020                   ; 1B8AF:  20 20 60
            rti                         ; 1B8B2:  40

            hex c0 0c 06 0f 14 2c 28 38 ; 1B8B3:  c0 0c 06 0f 14 2c 28 38
            hex 30 0c 06 0f 14 2c 28 38 ; 1B8BB:  30 0c 06 0f 14 2c 28 38
            hex 30 10 01 03 03 00 00 00 ; 1B8C3:  30 10 01 03 03 00 00 00
            hex 00 10 01 03 03          ; 1B8CB:  00 10 01 03 03

            brk                         ; 1B8D0:  00
            hex 00                      ; 1B8D1:  00
            brk                         ; 1B8D2:  00
            hex 00                      ; 1B8D3:  00
            brk                         ; 1B8D4:  00
            hex 00                      ; 1B8D5:  00
            brk                         ; 1B8D6:  00
            hex c0                      ; 1B8D7:  c0
            cpy #$40                    ; 1B8D8:  c0 40
            rti                         ; 1B8DA:  40

            cpy #$00                    ; 1B8DB:  c0 00
            brk                         ; 1B8DD:  00
            hex 00                      ; 1B8DE:  00
            cpy #$c0                    ; 1B8DF:  c0 c0
            rti                         ; 1B8E1:  40

            hex 40                      ; 1B8E2:  40

            cpy #$c0                    ; 1B8E3:  c0 c0
            cpy #$80                    ; 1B8E5:  c0 80
            brk                         ; 1B8E7:  00
            hex 00                      ; 1B8E8:  00
            brk                         ; 1B8E9:  00
            hex 00                      ; 1B8EA:  00
            brk                         ; 1B8EB:  00
            hex c0                      ; 1B8EC:  c0
            cpy #$80                    ; 1B8ED:  c0 80
            brk                         ; 1B8EF:  00
            hex 00                      ; 1B8F0:  00
            brk                         ; 1B8F1:  00
            hex 00                      ; 1B8F2:  00
            brk                         ; 1B8F3:  00
            hex a1                      ; 1B8F4:  a1
            lda ($e1,x)                 ; 1B8F5:  a1 e1
            adc ($60,x)                 ; 1B8F7:  61 60
            rts                         ; 1B8F9:  60

            hex 60                      ; 1B8FA:  60

            jsr b6_a1a1                 ; 1B8FB:  20 a1 a1
            sbc ($61,x)                 ; 1B8FE:  e1 61
            rts                         ; 1B900:  60

            hex 60 60 20 00 00 80 c0 c0 ; 1B901:  60 60 20 00 00 80 c0 c0
            hex 70 18 00 00 00 80 c0 c0 ; 1B909:  70 18 00 00 00 80 c0 c0
            hex 70 18 00 00 00 00 00 00 ; 1B911:  70 18 00 00 00 00 00 00
            hex 00 42 e9 00 00 00 00 00 ; 1B919:  00 42 e9 00 00 00 00 00
            hex 00 42 e9 01 00 00 00 00 ; 1B921:  00 42 e9 01 00 00 00 00
            hex 00 00 00 01 00 00 00 00 ; 1B929:  00 00 00 01 00 00 00 00
            hex 00 00 00 e3 bb 1f 0f 06 ; 1B931:  00 00 00 e3 bb 1f 0f 06
            hex 00 00 00 e3 bb 1f 0f 06 ; 1B939:  00 00 00 e3 bb 1f 0f 06
            hex 00 00 00 00 00 90 f8 38 ; 1B941:  00 00 00 00 00 90 f8 38
            hex 30 60 78 00 00 90 f8 38 ; 1B949:  30 60 78 00 00 90 f8 38
            hex 30 60 78 07 19 30 30 30 ; 1B951:  30 60 78 07 19 30 30 30
            hex 1f 1f 01 07 19 30 30 30 ; 1B959:  1f 1f 01 07 19 30 30 30
            hex 1f 1f 01 02 07 07 03 06 ; 1B961:  1f 1f 01 02 07 07 03 06
            hex 07 03 06 02 07 07 03 06 ; 1B969:  07 03 06 02 07 07 03 06
            hex 07 03 06 00 00 00 80 e0 ; 1B971:  07 03 06 00 00 00 80 e0
            hex e0 c0 80 00 00 00 80 e0 ; 1B979:  e0 c0 80 00 00 00 80 e0
            hex e0 c0 80 80 c0 a0 90 90 ; 1B981:  e0 c0 80 80 c0 a0 90 90
            hex 98 98 f0 80 c0 a0 90 90 ; 1B989:  98 98 f0 80 c0 a0 90 90
            hex 98 98 f0 1f 18 1c 0f 01 ; 1B991:  98 98 f0 1f 18 1c 0f 01
            hex 01 00 00 1f 18 1c 0f 01 ; 1B999:  01 00 00 1f 18 1c 0f 01
            hex 01 00 00 80 00 00 00 80 ; 1B9A1:  01 00 00 80 00 00 00 80
            hex e0 70 00 80 00 00 00 80 ; 1B9A9:  e0 70 00 80 00 00 00 80
            hex e0 70 00 00 00 00 00 0c ; 1B9B1:  e0 70 00 00 00 00 00 0c
            hex 08 0d 0f 00 00 00 00 0c ; 1B9B9:  08 0d 0f 00 00 00 00 0c
            hex 08 0d 0f 00 00 00 00 00 ; 1B9C1:  08 0d 0f 00 00 00 00 00
            hex c0 c0 82 00 00 00 00 00 ; 1B9C9:  c0 c0 82 00 00 00 00 00
            hex c0 c0 82 00 00 00 00 00 ; 1B9D1:  c0 c0 82 00 00 00 00 00
            hex 18 0f 0d 00 00 00 00 00 ; 1B9D9:  18 0f 0d 00 00 00 00 00
            hex 18 0f 0d 38 58 90 b0 e0 ; 1B9E1:  18 0f 0d 38 58 90 b0 e0
            hex e0 c0 00 38 58 90 b0 e0 ; 1B9E9:  e0 c0 00 38 58 90 b0 e0
            hex e0 c0 00 00 00 00 00 00 ; 1B9F1:  e0 c0 00 00 00 00 00 00
            hex 00 80 c0 00 00 00 00 00 ; 1B9F9:  00 80 c0 00 00 00 00 00
            hex 00 80 c0 03 00 00 04 03 ; 1BA01:  00 80 c0 03 00 00 04 03
            hex 03 00 00 03 00 00 04 03 ; 1BA09:  03 00 00 03 00 00 04 03
            hex 03                      ; 1BA11:  03

            brk                         ; 1BA12:  00
            hex 00                      ; 1BA13:  00
            cpx #$60                    ; 1BA14:  e0 60
            rts                         ; 1BA16:  60

            hex 60                      ; 1BA17:  60

            cpx #$60                    ; 1BA18:  e0 60
            cpx #$e0                    ; 1BA1A:  e0 e0
            cpx #$60                    ; 1BA1C:  e0 60
            rts                         ; 1BA1E:  60

            hex 60 e0 60 e0 e0 00 00 00 ; 1BA1F:  60 e0 60 e0 e0 00 00 00
            hex 00 00 02 02 03 00 00 00 ; 1BA27:  00 00 02 02 03 00 00 00
            hex 00 00 02 02 03 f8 70 7c ; 1BA2F:  00 00 02 02 03 f8 70 7c
            hex 7f c7 87 01 00 f8 70 7c ; 1BA37:  7f c7 87 01 00 f8 70 7c
            hex 7f c7 87 01 00 00 00 00 ; 1BA3F:  7f c7 87 01 00 00 00 00
            hex 00 80                   ; 1BA47:  00 80

            cpy #$e0                    ; 1BA49:  c0 e0
            rts                         ; 1BA4B:  60

            hex 00 00 00 00 80          ; 1BA4C:  00 00 00 00 80

            cpy #$e0                    ; 1BA51:  c0 e0
            rts                         ; 1BA53:  60

            hex 00 00 00 04 0c 0f 7e cc ; 1BA54:  00 00 00 04 0c 0f 7e cc
            hex 00 00 00 04 0c 0f 7e cc ; 1BA5C:  00 00 00 04 0c 0f 7e cc
            hex 01 01 01 03 02 02 00 00 ; 1BA64:  01 01 01 03 02 02 00 00
            hex 01 01 01 03 02 02 00 00 ; 1BA6C:  01 01 01 03 02 02 00 00
            hex c0 80 00 00 80 c0 c0 c0 ; 1BA74:  c0 80 00 00 80 c0 c0 c0
            hex c0 80 00 00 80 c0 c0 c0 ; 1BA7C:  c0 80 00 00 80 c0 c0 c0
            hex 00 00 00 00 00 00 01 01 ; 1BA84:  00 00 00 00 00 00 01 01
            hex 00 00 00 00 00 00 01 01 ; 1BA8C:  00 00 00 00 00 00 01 01
            hex 80 80 80 80 80 80 80 80 ; 1BA94:  80 80 80 80 80 80 80 80
            hex 80 80 80 80 80 80 80 80 ; 1BA9C:  80 80 80 80 80 80 80 80
            hex 4f                      ; 1BAA4:  4f

            pha                         ; 1BAA5:  48
            bvs tab_b6_bab1+55          ; 1BAA6:  70 40
            rti                         ; 1BAA8:  40

            hex 40 c7 c7 4f             ; 1BAA9:  40 c7 c7 4f

            pha                         ; 1BAAD:  48
            bvs tab_b6_bab1+63          ; 1BAAE:  70 40
            rti                         ; 1BAB0:  40

tab_b6_bab1: ; 556 bytes
            hex 40 c7 c7 e4 c0 c0 c0 c0 ; 1BAB1:  40 c7 c7 e4 c0 c0 c0 c0
            hex c0 c0 c0 e4 c0 c0 c0 c0 ; 1BAB9:  c0 c0 c0 e4 c0 c0 c0 c0
            hex c0 c0 c0 c6 c3 c0 40 00 ; 1BAC1:  c0 c0 c0 c6 c3 c0 40 00
            hex 00 00 00 c6 c3 c0 40 00 ; 1BAC9:  00 00 00 c6 c3 c0 40 00
            hex 00 00 00 e0 f8 0c 04 00 ; 1BAD1:  00 00 00 e0 f8 0c 04 00
            hex 00 00 00 e0 f8 0c 04 00 ; 1BAD9:  00 00 00 e0 f8 0c 04 00
            hex 00 00 00 7c 30 20 20 23 ; 1BAE1:  00 00 00 7c 30 20 20 23
            hex 3e 1c 00 7c 30 20 20 23 ; 1BAE9:  3e 1c 00 7c 30 20 20 23
            hex 3e 1c 00 0c 0f 0f 00 00 ; 1BAF1:  3e 1c 00 0c 0f 0f 00 00
            hex 00 00 00 0c 0f 0f 00 00 ; 1BAF9:  00 00 00 0c 0f 0f 00 00
            hex 00 00 00 e0 80 80 80 80 ; 1BB01:  00 00 00 e0 80 80 80 80
            hex 80 80 80 e0 80 80 80 80 ; 1BB09:  80 80 80 e0 80 80 80 80
            hex 80 80 80 03 07 05 0d 1f ; 1BB11:  80 80 80 03 07 05 0d 1f
            hex 77 c1 00 03 07 05 0d 1f ; 1BB19:  77 c1 00 03 07 05 0d 1f
            hex 77 c1 00 82 83 83 83 83 ; 1BB21:  77 c1 00 82 83 83 83 83
            hex 83 07 06 82 83 83 83 83 ; 1BB29:  83 07 06 82 83 83 83 83
            hex 83 07 06 00 80 80 80 c0 ; 1BB31:  83 07 06 00 80 80 80 c0
            hex 80 80 00 00 80 80 80 c0 ; 1BB39:  80 80 00 00 80 80 80 c0
            hex 80 80 00 01 01 03 06 04 ; 1BB41:  80 80 00 01 01 03 06 04
            hex 00 00 00 01 01 03 06 04 ; 1BB49:  00 00 00 01 01 03 06 04
            hex 00 00 00 c0 80 00 00 00 ; 1BB51:  00 00 00 c0 80 00 00 00
            hex 00 00 00 c0 80 00 00 00 ; 1BB59:  00 00 00 c0 80 00 00 00
            hex 00 00 00 03 06 06 06 06 ; 1BB61:  00 00 00 03 06 06 06 06
            hex 00 00 00 03 06 06 06 06 ; 1BB69:  00 00 00 03 06 06 06 06
            hex 00 00 00 0c 0c 0c 0c 0c ; 1BB71:  00 00 00 0c 0c 0c 0c 0c
            hex 0c 0c 18 0c 0c 0c 0c 0c ; 1BB79:  0c 0c 18 0c 0c 0c 0c 0c
            hex 0c 0c 18 38 30 20 00 00 ; 1BB81:  0c 0c 18 38 30 20 00 00
            hex 00 00 00 38 30 20 00 00 ; 1BB89:  00 00 00 38 30 20 00 00
            hex 00 00 00 01 01 03 03 03 ; 1BB91:  00 00 00 01 01 03 03 03
            hex 06 0e 0e 01 01 03 03 03 ; 1BB99:  06 0e 0e 01 01 03 03 03
            hex 06 0e 0e 80 00 00 00 00 ; 1BBA1:  06 0e 0e 80 00 00 00 00
            hex 00 00 00 80 00 00 00 00 ; 1BBA9:  00 00 00 80 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1BBB1:  00 00 00 00 00 00 00 00
            hex 00 1f 00 00 00 00 00 00 ; 1BBB9:  00 1f 00 00 00 00 00 00
            hex 00 00 1f 00 00 00 00 00 ; 1BBC1:  00 00 1f 00 00 00 00 00
            hex 00 c0 20 00 00 00 00 00 ; 1BBC9:  00 c0 20 00 00 00 00 00
            hex 00 00 80 00 33 7d 45 7f ; 1BBD1:  00 00 80 00 33 7d 45 7f
            hex 35 5d 6d 00 00 00 00 00 ; 1BBD9:  35 5d 6d 00 00 00 00 00
            hex 00 00 00 3f 5b 5f 3f 61 ; 1BBE1:  00 00 00 3f 5b 5f 3f 61
            hex 3f 00 00 00 00 00 00 00 ; 1BBE9:  3f 00 00 00 00 00 00 00
            hex 00 00 00 00 f8 ac bc 64 ; 1BBF1:  00 00 00 00 f8 ac bc 64
            hex 7c 64 e4 00 00 00 00 00 ; 1BBF9:  7c 64 e4 00 00 00 00 00
            hex 00 00 00 74 54 74 dc 7c ; 1BC01:  00 00 00 74 54 74 dc 7c
            hex e8 00 00 00 00 00 00 00 ; 1BC09:  e8 00 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1BC11:  00 00 00 00 00 00 00 00
            hex 02 06 00 00 00 00 00 00 ; 1BC19:  02 06 00 00 00 00 00 00
            hex 00 00 00 00 00 00 00 00 ; 1BC21:  00 00 00 00 00 00 00 00
            hex 00 00 03 00 00 00 00 00 ; 1BC29:  00 00 03 00 00 00 00 00
            hex 00 00 01 00 00 00 00 01 ; 1BC31:  00 00 01 00 00 00 00 01
            hex 1e c3 c0 00 00 00 00 00 ; 1BC39:  1e c3 c0 00 00 00 00 00
            hex 00 00 be 0d 20 71 c0 8a ; 1BC41:  00 00 be 0d 20 71 c0 8a
            hex 80 85 40 01 0e 11 2f 2f ; 1BC49:  80 85 40 01 0e 11 2f 2f
            hex 2f 37 1b 03 00 0a 00 85 ; 1BC51:  2f 37 1b 03 00 0a 00 85
            hex 00 62 00 61 3e 3f 9f 9f ; 1BC59:  00 62 00 61 3e 3f 9f 9f
            hex cf e7 e7 00 00 00 3e c3 ; 1BC61:  cf e7 e7 00 00 00 3e c3
            hex dc 6d 36 00 00 00 00 00 ; 1BC69:  dc 6d 36 00 00 00 00 00
            hex 00 00 00 00 00 22 da 6c ; 1BC71:  00 00 00 00 00 22 da 6c
            hex 36 c3 dc 00 00 07 03 01 ; 1BC79:  36 c3 dc 00 00 07 03 01
            hex 00 00 00 83 74 2e 1d 7b ; 1BC81:  00 00 00 83 74 2e 1d 7b
            hex 03 ac 17 00 80 40 40 c0 ; 1BC89:  03 ac 17 00 80 40 40 c0
            hex c0 a0 a0 6f 35 c2 d6 ac ; 1BC91:  c0 a0 a0 6f 35 c2 d6 ac
            hex 51 27 3f 00 00 02 06 0f ; 1BC99:  51 27 3f 00 00 02 06 0f
            hex 1f 3f 1e 00 20 aa a8 a8 ; 1BCA1:  1f 3f 1e 00 20 aa a8 a8
            hex a8 28 2a 00 70 f8 fc fe ; 1BCA9:  a8 28 2a 00 70 f8 fc fe
            hex fc 78 7a 40 80 80 a0 80 ; 1BCB1:  fc 78 7a 40 80 80 a0 80
            hex 80 00 2b 29 5f 59 46 5b ; 1BCB9:  80 00 2b 29 5f 59 46 5b
            hex 4a 3f 14 28 29 a9 a8 a8 ; 1BCC1:  4a 3f 14 28 29 a9 a8 a8
            hex 08 88 08 78 79 b9 b8 bc ; 1BCC9:  08 88 08 78 79 b9 b8 bc
            hex 1d 1e 0f 80 09 08 59 10 ; 1BCD1:  1d 1e 0f 80 09 08 59 10
            hex 10 10 01 80             ; 1BCD9:  10 10 01 80

            ora $5918,y                 ; 1BCDD:  19 18 59
            bmi tab_b6_bab1+488         ; 1BCE0:  30 b7
            ldy ptr1_lo,x                   ; 1BCE2:  b4 02
            bpl tab_b6_bced+1           ; 1BCE4:  10 08
            ora #$95                    ; 1BCE6:  09 95
            ora $15,x                   ; 1BCE8:  15 15
            and #$09                    ; 1BCEA:  29 09
            rts                         ; 1BCEC:  60

tab_b6_bced: ; 7 bytes
            hex b0 b1 67 6f 67 8b 8b    ; 1BCED:  b0 b1 67 6f 67 8b 8b

            brk                         ; 1BCF4:  00
            hex 00                      ; 1BCF5:  00
            rti                         ; 1BCF6:  40

tab_b6_bcf7: ; 62 bytes
            hex 50 55 50 50 44 00 00 c0 ; 1BCF7:  50 55 50 50 44 00 00 c0
            hex f8 ff f8 f0 e4 41 25 25 ; 1BCFF:  f8 ff f8 f0 e4 41 25 25
            hex 05 15 14 14 10 43 27 2f ; 1BD07:  05 15 14 14 10 43 27 2f
            hex 0f 1f be 3c d1 52 1a 08 ; 1BD0F:  0f 1f be 3c d1 52 1a 08
            hex 35 72 fb 7b 7c d2 9a 88 ; 1BD17:  35 72 fb 7b 7c d2 9a 88
            hex 04 60 e3 f3 f0 a0 58 2c ; 1BD1F:  04 60 e3 f3 f0 a0 58 2c
            hex 96 c0 28 72 d4 00 00 28 ; 1BD27:  96 c0 28 72 d4 00 00 28
            hex 94 c0 20 70 d0 0b       ; 1BD2F:  94 c0 20 70 d0 0b

            ora $0b06                   ; 1BD35:  0d 06 0b
            ora $0200                   ; 1BD38:  0d 00 02
            ora (ptr0_lo,x)                 ; 1BD3B:  01 00
            brk                         ; 1BD3D:  00
            hex 00                      ; 1BD3E:  00
            brk                         ; 1BD3F:  00
            hex 00                      ; 1BD40:  00
            brk                         ; 1BD41:  00
            hex 00                      ; 1BD42:  00
            brk                         ; 1BD43:  00
            hex 01                      ; 1BD44:  01
            brk                         ; 1BD45:  00
            hex 00                      ; 1BD46:  00
            brk                         ; 1BD47:  00
            hex 00                      ; 1BD48:  00
            brk                         ; 1BD49:  00
            hex 00                      ; 1BD4A:  00
            brk                         ; 1BD4B:  00
            hex 00                      ; 1BD4C:  00
            brk                         ; 1BD4D:  00
            hex 00                      ; 1BD4E:  00
            brk                         ; 1BD4F:  00
            hex 00                      ; 1BD50:  00
            brk                         ; 1BD51:  00
            hex 00                      ; 1BD52:  00
            brk                         ; 1BD53:  00
            hex 80                      ; 1BD54:  80
            bcs tab_b6_bcf7+57          ; 1BD55:  b0 d9
            jmp ($5bb6)                 ; 1BD57:  6c b6 5b

            sta brk_jmp_target_lo                     ; 1BD5A:  85 68
            ora $0306                   ; 1BD5C:  0d 06 03
            brk                         ; 1BD5F:  00
            hex 00                      ; 1BD60:  00
b6_bd61:    brk                         ; 1BD61:  00
            hex 00                      ; 1BD62:  00
            brk                         ; 1BD63:  00
            hex b1                      ; 1BD64:  b1
            brk                         ; 1BD65:  00
            hex 58                      ; 1BD66:  58
            brk                         ; 1BD67:  00
            hex 18                      ; 1BD68:  18
            brk                         ; 1BD69:  00
            hex 94                      ; 1BD6A:  94
            rti                         ; 1BD6B:  40

            hex f3 f9 79 bc 5e 2e 1f 00 ; 1BD6C:  f3 f9 79 bc 5e 2e 1f 00
            hex b7 db 6d 36 0b 03 00 00 ; 1BD74:  b7 db 6d 36 0b 03 00 00
            hex 00 00 00 00 00 00 00 00 ; 1BD7C:  00 00 00 00 00 00 00 00
            hex 84 b8 db ec 04 80 80 00 ; 1BD84:  84 b8 db ec 04 80 80 00
            hex 00 00 00 01 73 0c 77 00 ; 1BD8C:  00 00 00 01 73 0c 77 00
            hex 76 14 84 0c 50 08 98 ac ; 1BD94:  76 14 84 0c 50 08 98 ac
            hex e0 e1 d1 d1 74 60 81 80 ; 1BD9C:  e0 e1 d1 d1 74 60 81 80
            hex 5e 2e 14 08 00 00 00 00 ; 1BDA4:  5e 2e 14 08 00 00 00 00
            hex 0c 80 40 60             ; 1BDAC:  0c 80 40 60

            bne b6_bd61+1               ; 1BDB0:  d0 b0
            rts                         ; 1BDB2:  60

            hex 00 56 4b                ; 1BDB3:  00 56 4b

            lda ptr0_lo                     ; 1BDB6:  a5 00
            ora $0f33                   ; 1BDB8:  0d 33 0f
            sei                         ; 1BDBB:  78
            rti                         ; 1BDBC:  40

            hex 40                      ; 1BDBD:  40

            jsr $20c0                   ; 1BDBE:  20 c0 20
            rti                         ; 1BDC1:  40

tab_b6_bdc2: ; 151 bytes
            hex 80 00 02 0d b6 5b 85 88 ; 1BDC2:  80 00 02 0d b6 5b 85 88
            hex 0f 00 40 00 00 00 00 00 ; 1BDCA:  0f 00 40 00 00 00 00 00
            hex 70 8f 00 60 30 1c 07 01 ; 1BDD2:  70 8f 00 60 30 1c 07 01
            hex 00 20 23 1c 0d 01 00 00 ; 1BDDA:  00 20 23 1c 0d 01 00 00
            hex 00 80 00 00 00 00 8f fc ; 1BDE2:  00 80 00 00 00 00 8f fc
            hex 00 00 b7 fc 02 de 50 00 ; 1BDEA:  00 00 b7 fc 02 de 50 00
            hex 00 50 20 0c 83 43 b1 54 ; 1BDF2:  00 50 20 0c 83 43 b1 54
            hex 00 00 80 40 30 0e 01 0e ; 1BDFA:  00 00 80 40 30 0e 01 0e
            hex 71 87 18 18 f1 c0 80 00 ; 1BE02:  71 87 18 18 f1 c0 80 00
            hex 00 08 08 0c 18 74 c6 19 ; 1BE0A:  00 08 08 0c 18 74 c6 19
            hex f1 02 09 04 0c f8 c0 00 ; 1BE12:  f1 02 09 04 0c f8 c0 00
            hex 00 00 c1 28 f0 00 00 00 ; 1BE1A:  00 00 c1 28 f0 00 00 00
            hex 00 00 bd 9e 9e db 6d 6c ; 1BE22:  00 00 bd 9e 9e db 6d 6c
            hex 30 20 f9 f8 fc e0 40 00 ; 1BE2A:  30 20 f9 f8 fc e0 40 00
            hex 01 06 01 16 db 2c c4 68 ; 1BE32:  01 06 01 16 db 2c c4 68
            hex 23 03 00 00 00 01 02 04 ; 1BE3A:  23 03 00 00 00 01 02 04
            hex 18 e0 80 80 30 30 d8 6e ; 1BE42:  18 e0 80 80 30 30 d8 6e
            hex 80 c0 4b 4c 81 04 00 00 ; 1BE4A:  80 c0 4b 4c 81 04 00 00
            hex 00 00 92 b3 67 2a 14    ; 1BE52:  00 00 92 b3 67 2a 14

            bit $0299                   ; 1BE59:  2c 99 02
            bcc tab_b6_bdc2+76          ; 1BE5C:  90 b0
            rts                         ; 1BE5E:  60

tab_b6_be5f: ; 417 bytes
            hex 28 10 a0 c0 c0 00 00 00 ; 1BE5F:  28 10 a0 c0 c0 00 00 00
            hex 00 80 00 00 00 00 00 00 ; 1BE67:  00 80 00 00 00 00 00 00
            hex 00 00 00 00 00 08 00 00 ; 1BE6F:  00 00 00 00 00 08 00 00
            hex 20 80 00 00 00 28 20 80 ; 1BE77:  20 80 00 00 00 28 20 80
            hex 00 00 00 00 00 03 00 00 ; 1BE7F:  00 00 00 00 00 03 00 00
            hex 00 00 00 00 00 00 00 00 ; 1BE87:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 c4 3c 00 ; 1BE8F:  00 00 00 00 00 c4 3c 00
            hex 00 00 00 00 00 01 01 00 ; 1BE97:  00 00 00 00 00 01 01 00
            hex 00 00 00 00 00 50 6d 36 ; 1BE9F:  00 00 00 00 00 50 6d 36
            hex 00 00 00 00 00 00 00 80 ; 1BEA7:  00 00 00 00 00 00 00 80
            hex 00 00 00 00 00 00 00 f8 ; 1BEAF:  00 00 00 00 00 00 00 f8
            hex 00 00 00 00 00 b8 07 00 ; 1BEB7:  00 00 00 00 00 b8 07 00
            hex 00 00 00 00 00 f0 01 00 ; 1BEBF:  00 00 00 00 00 f0 01 00
            hex 00 00 00 00 00 02 0c f0 ; 1BEC7:  00 00 00 00 00 02 0c f0
            hex 00 00 00 00 00 1c e0 00 ; 1BECF:  00 00 00 00 00 1c e0 00
            hex 00 00 00 00 00 00 00 00 ; 1BED7:  00 00 00 00 00 00 00 00
            hex 00 00 00 00 00 ff ff ff ; 1BEDF:  00 00 00 00 00 ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BEE7:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BEEF:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BEF7:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BEFF:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF07:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF0F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF17:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF1F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF27:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF2F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF37:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF3F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF47:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF4F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF57:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF5F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF67:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF6F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF77:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF7F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF87:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF8F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF97:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BF9F:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFA7:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFAF:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFB7:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFBF:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFC7:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFCF:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFD7:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFDF:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFE7:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFEF:  ff ff ff ff ff ff ff ff
            hex ff ff ff ff ff ff ff ff ; 1BFF7:  ff ff ff ff ff ff ff ff
            hex ff                      ; 1BFFF:  ff

