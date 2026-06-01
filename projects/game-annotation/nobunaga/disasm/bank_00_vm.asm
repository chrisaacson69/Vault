VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes
  mode:         bulk dump of bank 0
  opcode spec:  vm-opcodes-v2.toml via nobunaga_vm.OPCODE_INFO (execution-validated lengths)
  labels:       646 CPU addresses named

  bank 0: found 98 bytecode-subroutine stubs

; ============================================================
; sub $8003   (frame_off=-6, body @ $8008)
; ============================================================
  $8008  60                         PUSH_qimm   ; inline operand = 0
  $8009  60                         PUSH_qimm   ; inline operand = 0
  $800A  6A                         PUSH_qimm   ; inline operand = 10
  $800B  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $800F  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $8012  AC 28 D6                   CALL_abs               $D628 (count_6da2_set) {bytecode}
  $8015  D8 1C 81                   JUMPF_abs              $811C
  $8018  61                         PUSH_qimm   ; inline operand = 1
  $8019  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $801D  8E AE 00                   PUSH_imm2              $00AE
  $8020  8E 10 15                   PUSH_imm2              $1510
  $8023  8E 54 90                   PUSH_imm2              $9054
  $8026  66                         PUSH_qimm   ; inline operand = 6
  $8027  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $802B  66                         PUSH_qimm   ; inline operand = 6
  $802C  8E 74 8D                   PUSH_imm2              $8D74
  $802F  8D 16                      BYTE_PUSH_imm1         +22
  $8031  8D 1F                      BYTE_PUSH_imm1         +31
  $8033  60                         PUSH_qimm   ; inline operand = 0
  $8034  60                         PUSH_qimm   ; inline operand = 0
  $8035  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $8039  61                         PUSH_qimm   ; inline operand = 1
  $803A  6D                         PUSH_qimm   ; inline operand = 13
  $803B  8D 11                      BYTE_PUSH_imm1         +17
  $803D  68                         PUSH_qimm   ; inline operand = 8
  $803E  8D 10                      BYTE_PUSH_imm1         +16
  $8040  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8044  61                         PUSH_qimm   ; inline operand = 1
  $8045  8D 1A                      BYTE_PUSH_imm1         +26
  $8047  8D 1F                      BYTE_PUSH_imm1         +31
  $8049  8D 18                      BYTE_PUSH_imm1         +24
  $804B  62                         PUSH_qimm   ; inline operand = 2
  $804C  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8050  40                         LOADL_qimm   ; inline operand = 0
  $8051  2B                         STORE_quick   ; inline operand = 11
 >$8052  0B                         LOADL_quick   ; inline operand = 11
  $8053  8C CA B7                   LOADR_imm2             $B7CA
  $8056  BB                         ADD
  $8057  D3                         BYTE_DEREF
  $8058  B3                         PUSHL
  $8059  3B                         PUSH_quick   ; inline operand = 11
  $805A  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $805E  0B                         LOADL_quick   ; inline operand = 11
  $805F  D0                         INC
  $8060  2B                         STORE_quick   ; inline operand = 11
  $8061  0B                         LOADL_quick   ; inline operand = 11
  $8062  58                         LOADR_qimm   ; inline operand = 8
  $8063  C6                         UCMPLT
  $8064  D7 52 80                   JUMPT_abs              $8052
  $8067  60                         PUSH_qimm   ; inline operand = 0
  $8068  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $806C  8D 18                      BYTE_PUSH_imm1         +24
  $806E  62                         PUSH_qimm   ; inline operand = 2
  $806F  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $8073  8E DA B7                   PUSH_imm2              $B7DA
  $8076  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $807A  AA 9F 6D                   PUSH_abs               $6D9F
  $807D  8E F4 B7                   PUSH_imm2              $B7F4
  $8080  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8084  8E 05 B8                   PUSH_imm2              $B805
  $8087  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $808B  65                         PUSH_qimm   ; inline operand = 5
  $808C  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $8090  A4 4D 6F                   LOADL_abs              $6F4D
  $8093  D7 B8 80                   JUMPT_abs              $80B8
  $8096  AC 59 D7                   CALL_abs               $D759 (ui_helper_d759) {bytecode}
 >$8099  40                         LOADL_qimm   ; inline operand = 0
  $809A  A8 D3 7F                   STORE_abs              $7FD3
  $809D  8A FF 00                   LOADL_imm2             $00FF
  $80A0  A8 DF 7F                   STORE_abs              $7FDF
 >$80A3  60                         PUSH_qimm   ; inline operand = 0
  $80A4  66                         PUSH_qimm   ; inline operand = 6
  $80A5  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $80A9  D7 A3 80                   JUMPT_abs              $80A3
  $80AC  61                         PUSH_qimm   ; inline operand = 1
  $80AD  66                         PUSH_qimm   ; inline operand = 6
  $80AE  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $80B2  D8 C5 80                   JUMPF_abs              $80C5
  $80B5  D6 A3 80                   JUMP_abs               $80A3
 >$80B8  62                         PUSH_qimm   ; inline operand = 2
  $80B9  61                         PUSH_qimm   ; inline operand = 1
  $80BA  6A                         PUSH_qimm   ; inline operand = 10
  $80BB  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $80BF  D8 99 80                   JUMPF_abs              $8099
  $80C2  D6 B8 80                   JUMP_abs               $80B8
 >$80C5  60                         PUSH_qimm   ; inline operand = 0
  $80C6  66                         PUSH_qimm   ; inline operand = 6
  $80C7  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $80CB  D7 D7 80                   JUMPT_abs              $80D7
  $80CE  61                         PUSH_qimm   ; inline operand = 1
  $80CF  66                         PUSH_qimm   ; inline operand = 6
  $80D0  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $80D4  D8 C5 80                   JUMPF_abs              $80C5
 >$80D7  61                         PUSH_qimm   ; inline operand = 1
  $80D8  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $80DC  8E FE 00                   PUSH_imm2              $00FE
  $80DF  8E 00 10                   PUSH_imm2              $1000
  $80E2  8E 04 9D                   PUSH_imm2              $9D04
  $80E5  66                         PUSH_qimm   ; inline operand = 6
  $80E6  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $80EA  60                         PUSH_qimm   ; inline operand = 0
  $80EB  60                         PUSH_qimm   ; inline operand = 0
  $80EC  65                         PUSH_qimm   ; inline operand = 5
  $80ED  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $80F1  AC 5D CF                   CALL_abs               $CF5D (fill_attr_wrap) {bytecode}
  $80F4  66                         PUSH_qimm   ; inline operand = 6
  $80F5  8E 24 9B                   PUSH_imm2              $9B24
  $80F8  8D 13                      BYTE_PUSH_imm1         +19
  $80FA  8D 1F                      BYTE_PUSH_imm1         +31
  $80FC  65                         PUSH_qimm   ; inline operand = 5
  $80FD  60                         PUSH_qimm   ; inline operand = 0
  $80FE  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $8102  40                         LOADL_qimm   ; inline operand = 0
  $8103  2B                         STORE_quick   ; inline operand = 11
 >$8104  0B                         LOADL_quick   ; inline operand = 11
  $8105  8C D2 B7                   LOADR_imm2             $B7D2
  $8108  BB                         ADD
  $8109  D3                         BYTE_DEREF
  $810A  B3                         PUSHL
  $810B  3B                         PUSH_quick   ; inline operand = 11
  $810C  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8110  0B                         LOADL_quick   ; inline operand = 11
  $8111  D0                         INC
  $8112  2B                         STORE_quick   ; inline operand = 11
  $8113  0B                         LOADL_quick   ; inline operand = 11
  $8114  54                         LOADR_qimm   ; inline operand = 4
  $8115  C6                         UCMPLT
  $8116  D7 04 81                   JUMPT_abs              $8104
  $8119  D6 B1 81                   JUMP_abs               $81B1
 >$811C  66                         PUSH_qimm   ; inline operand = 6
  $811D  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $8121  8D 1A                      BYTE_PUSH_imm1         +26
  $8123  6B                         PUSH_qimm   ; inline operand = 11
  $8124  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $8128  8E 17 B8                   PUSH_imm2              $B817
  $812B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $812F  40                         LOADL_qimm   ; inline operand = 0
  $8130  29                         STORE_quick   ; inline operand = 9
 >$8131  40                         LOADL_qimm   ; inline operand = 0
  $8132  2B                         STORE_quick   ; inline operand = 11
 >$8133  3B                         PUSH_quick   ; inline operand = 11
  $8134  63                         PUSH_qimm   ; inline operand = 3
  $8135  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8139  8D 13                      BYTE_PUSH_imm1         +19
  $813B  E9 26 F2 02                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $02
  $813F  0B                         LOADL_quick   ; inline operand = 11
  $8140  5F                         LOADR_qimm   ; inline operand = 15
  $8141  DA                         AND
  $8142  5C                         LOADR_qimm   ; inline operand = 12
  $8143  C0                         CMPEQ
  $8144  D8 4C 81                   JUMPF_abs              $814C
  $8147  43                         LOADL_qimm   ; inline operand = 3
  $8148  CD                         SWAP
  $8149  0B                         LOADL_quick   ; inline operand = 11
  $814A  BB                         ADD
  $814B  2B                         STORE_quick   ; inline operand = 11
 >$814C  0B                         LOADL_quick   ; inline operand = 11
  $814D  D0                         INC
  $814E  2B                         STORE_quick   ; inline operand = 11
  $814F  0B                         LOADL_quick   ; inline operand = 11
  $8150  8B 40                      BYTE_LOADR_imm1        +64
  $8152  C6                         UCMPLT
  $8153  D7 33 81                   JUMPT_abs              $8133
  $8156  09                         LOADL_quick   ; inline operand = 9
  $8157  D0                         INC
  $8158  29                         STORE_quick   ; inline operand = 9
  $8159  09                         LOADL_quick   ; inline operand = 9
  $815A  56                         LOADR_qimm   ; inline operand = 6
  $815B  C6                         UCMPLT
  $815C  D7 31 81                   JUMPT_abs              $8131
  $815F  A4 4D 6F                   LOADL_abs              $6F4D
  $8162  D8 6F 81                   JUMPF_abs              $816F
 >$8165  62                         PUSH_qimm   ; inline operand = 2
  $8166  61                         PUSH_qimm   ; inline operand = 1
  $8167  6A                         PUSH_qimm   ; inline operand = 10
  $8168  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $816C  D7 65 81                   JUMPT_abs              $8165
 >$816F  61                         PUSH_qimm   ; inline operand = 1
  $8170  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8174  8E F8 00                   PUSH_imm2              $00F8
  $8177  8E 00 10                   PUSH_imm2              $1000
  $817A  8E 64 AF                   PUSH_imm2              $AF64
  $817D  66                         PUSH_qimm   ; inline operand = 6
  $817E  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $8182  60                         PUSH_qimm   ; inline operand = 0
  $8183  60                         PUSH_qimm   ; inline operand = 0
  $8184  65                         PUSH_qimm   ; inline operand = 5
  $8185  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $8189  AC 5D CF                   CALL_abs               $CF5D (fill_attr_wrap) {bytecode}
  $818C  66                         PUSH_qimm   ; inline operand = 6
  $818D  8E E4 AC                   PUSH_imm2              $ACE4
  $8190  8D 18                      BYTE_PUSH_imm1         +24
  $8192  8D 1F                      BYTE_PUSH_imm1         +31
  $8194  65                         PUSH_qimm   ; inline operand = 5
  $8195  60                         PUSH_qimm   ; inline operand = 0
  $8196  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $819A  40                         LOADL_qimm   ; inline operand = 0
  $819B  2B                         STORE_quick   ; inline operand = 11
 >$819C  0B                         LOADL_quick   ; inline operand = 11
  $819D  8C D6 B7                   LOADR_imm2             $B7D6
  $81A0  BB                         ADD
  $81A1  D3                         BYTE_DEREF
  $81A2  B3                         PUSHL
  $81A3  3B                         PUSH_quick   ; inline operand = 11
  $81A4  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $81A8  0B                         LOADL_quick   ; inline operand = 11
  $81A9  D0                         INC
  $81AA  2B                         STORE_quick   ; inline operand = 11
  $81AB  0B                         LOADL_quick   ; inline operand = 11
  $81AC  54                         LOADR_qimm   ; inline operand = 4
  $81AD  C6                         UCMPLT
  $81AE  D7 9C 81                   JUMPT_abs              $819C
 >$81B1  60                         PUSH_qimm   ; inline operand = 0
  $81B2  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $81B6  60                         PUSH_qimm   ; inline operand = 0
  $81B7  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $81BB  40                         LOADL_qimm   ; inline operand = 0
  $81BC  A8 D3 7F                   STORE_abs              $7FD3
  $81BF  8A FF 00                   LOADL_imm2             $00FF
  $81C2  A8 DF 7F                   STORE_abs              $7FDF
 >$81C5  60                         PUSH_qimm   ; inline operand = 0
  $81C6  66                         PUSH_qimm   ; inline operand = 6
  $81C7  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $81CB  D7 C5 81                   JUMPT_abs              $81C5
  $81CE  61                         PUSH_qimm   ; inline operand = 1
  $81CF  66                         PUSH_qimm   ; inline operand = 6
  $81D0  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $81D4  D7 C5 81                   JUMPT_abs              $81C5
 >$81D7  60                         PUSH_qimm   ; inline operand = 0
  $81D8  66                         PUSH_qimm   ; inline operand = 6
  $81D9  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $81DD  D7 E9 81                   JUMPT_abs              $81E9
  $81E0  61                         PUSH_qimm   ; inline operand = 1
  $81E1  66                         PUSH_qimm   ; inline operand = 6
  $81E2  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $81E6  D8 D7 81                   JUMPF_abs              $81D7
 >$81E9  61                         PUSH_qimm   ; inline operand = 1
  $81EA  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $81EE  8D 51                      BYTE_PUSH_imm1         +81
  $81F0  8E 00 10                   PUSH_imm2              $1000
  $81F3  8E BA B2                   PUSH_imm2              $B2BA
  $81F6  60                         PUSH_qimm   ; inline operand = 0
  $81F7  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $81FB  AC 50 CF                   CALL_abs               $CF50 (fill_nametable_wrap) {bytecode}
  $81FE  AC 5D CF                   CALL_abs               $CF5D (fill_attr_wrap) {bytecode}
  $8201  60                         PUSH_qimm   ; inline operand = 0
  $8202  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8206  8E 21 B8                   PUSH_imm2              $B821
  $8209  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $820D  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $8210  D7 1D 82                   JUMPT_abs              $821D
  $8213  8E 3E B8                   PUSH_imm2              $B83E
  $8216  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$821A  D6 1A 82                   JUMP_abs               $821A
 >$821D  CF                         RETURN

; ============================================================
; sub $821E   (frame_off=-8, body @ $8223)
; ============================================================
  $8223  D6 35 82                   JUMP_abs               $8235
 >$8226  60                         PUSH_qimm   ; inline operand = 0
  $8227  E9 A4 CB 02                CALL_abs_imm1          $CBA4 (chr_bank0_set_wrap) {bytecode}, $02
  $822B  8E 90 B8                   PUSH_imm2              $B890
  $822E  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8232  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$8235  8E 82 B8                   PUSH_imm2              $B882
  $8238  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $823C  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $823F  D8 44 82                   JUMPF_abs              $8244
  $8242  40                         LOADL_qimm   ; inline operand = 0
  $8243  CF                         RETURN
 >$8244  61                         PUSH_qimm   ; inline operand = 1
  $8245  E9 A4 CB 02                CALL_abs_imm1          $CBA4 (chr_bank0_set_wrap) {bytecode}, $02
  $8249  8E 8B B8                   PUSH_imm2              $B88B
  $824C  8E ED 7F                   PUSH_imm2              $7FED
  $824F  E9 B0 CA 04                CALL_abs_imm1          $CAB0 (strcmp) {bytecode}, $04
  $8253  D7 26 82                   JUMPT_abs              $8226
  $8256  60                         PUSH_qimm   ; inline operand = 0
  $8257  E9 A4 CB 02                CALL_abs_imm1          $CBA4 (chr_bank0_set_wrap) {bytecode}, $02
  $825B  8E FF 00                   PUSH_imm2              $00FF
  $825E  8E 01 60                   PUSH_imm2              $6001
  $8261  60                         PUSH_qimm   ; inline operand = 0
  $8262  61                         PUSH_qimm   ; inline operand = 1
  $8263  8D 16                      BYTE_PUSH_imm1         +22
  $8265  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $8269  28                         STORE_quick   ; inline operand = 8
  $826A  8A 00 61                   LOADL_imm2             $6100
  $826D  2B                         STORE_quick   ; inline operand = 11
 >$826E  8E 00 01                   PUSH_imm2              $0100
  $8271  3B                         PUSH_quick   ; inline operand = 11
  $8272  60                         PUSH_qimm   ; inline operand = 0
  $8273  61                         PUSH_qimm   ; inline operand = 1
  $8274  8D 16                      BYTE_PUSH_imm1         +22
  $8276  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $827A  CD                         SWAP
  $827B  08                         LOADL_quick   ; inline operand = 8
  $827C  BB                         ADD
  $827D  28                         STORE_quick   ; inline operand = 8
  $827E  8A 00 01                   LOADL_imm2             $0100
  $8281  CD                         SWAP
  $8282  0B                         LOADL_quick   ; inline operand = 11
  $8283  BB                         ADD
  $8284  2B                         STORE_quick   ; inline operand = 11
  $8285  0B                         LOADL_quick   ; inline operand = 11
  $8286  8C 00 70                   LOADR_imm2             $7000
  $8289  C6                         UCMPLT
  $828A  D7 6E 82                   JUMPT_abs              $826E
  $828D  8E FF 00                   PUSH_imm2              $00FF
  $8290  8E 01 70                   PUSH_imm2              $7001 (province_table_live)
  $8293  60                         PUSH_qimm   ; inline operand = 0
  $8294  61                         PUSH_qimm   ; inline operand = 1
  $8295  8D 16                      BYTE_PUSH_imm1         +22
  $8297  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $829B  CD                         SWAP
  $829C  08                         LOADL_quick   ; inline operand = 8
  $829D  BB                         ADD
  $829E  28                         STORE_quick   ; inline operand = 8
  $829F  8A 00 71                   LOADL_imm2             $7100
  $82A2  2B                         STORE_quick   ; inline operand = 11
 >$82A3  8E 00 01                   PUSH_imm2              $0100
  $82A6  3B                         PUSH_quick   ; inline operand = 11
  $82A7  60                         PUSH_qimm   ; inline operand = 0
  $82A8  61                         PUSH_qimm   ; inline operand = 1
  $82A9  8D 16                      BYTE_PUSH_imm1         +22
  $82AB  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $82AF  CD                         SWAP
  $82B0  08                         LOADL_quick   ; inline operand = 8
  $82B1  BB                         ADD
  $82B2  28                         STORE_quick   ; inline operand = 8
  $82B3  8A 00 01                   LOADL_imm2             $0100
  $82B6  CD                         SWAP
  $82B7  0B                         LOADL_quick   ; inline operand = 11
  $82B8  BB                         ADD
  $82B9  2B                         STORE_quick   ; inline operand = 11
  $82BA  0B                         LOADL_quick   ; inline operand = 11
  $82BB  8C 00 7F                   LOADR_imm2             $7F00 (ui_transient_state)
  $82BE  C6                         UCMPLT
  $82BF  D7 A3 82                   JUMPT_abs              $82A3
  $82C2  8E EB 81                   PUSH_imm2              $81EB
  $82C5  8E 00 7F                   PUSH_imm2              $7F00 (ui_transient_state)
  $82C8  60                         PUSH_qimm   ; inline operand = 0
  $82C9  61                         PUSH_qimm   ; inline operand = 1
  $82CA  8D 16                      BYTE_PUSH_imm1         +22
  $82CC  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $82D0  CD                         SWAP
  $82D1  08                         LOADL_quick   ; inline operand = 8
  $82D2  BB                         ADD
  $82D3  28                         STORE_quick   ; inline operand = 8
  $82D4  61                         PUSH_qimm   ; inline operand = 1
  $82D5  E9 A4 CB 02                CALL_abs_imm1          $CBA4 (chr_bank0_set_wrap) {bytecode}, $02
  $82D9  A4 EB 7F                   LOADL_abs              $7FEB
  $82DC  18                         LOADR_quick   ; inline operand = 8
  $82DD  C0                         CMPEQ
  $82DE  D8 43 83                   JUMPF_abs              $8343
  $82E1  60                         PUSH_qimm   ; inline operand = 0
  $82E2  E9 A4 CB 02                CALL_abs_imm1          $CBA4 (chr_bank0_set_wrap) {bytecode}, $02
  $82E6  40                         LOADL_qimm   ; inline operand = 0
  $82E7  A8 D1 7F                   STORE_abs              $7FD1
  $82EA  40                         LOADL_qimm   ; inline operand = 0
  $82EB  A8 61 6F                   STORE_abs              $6F61
  $82EE  8E 9E B8                   PUSH_imm2              $B89E
  $82F1  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $82F5  8E 9F B8                   PUSH_imm2              $B89F
  $82F8  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $82FC  AC 59 D7                   CALL_abs               $D759 (ui_helper_d759) {bytecode}
  $82FF  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $8302  61                         PUSH_qimm   ; inline operand = 1
  $8303  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8307  64                         PUSH_qimm   ; inline operand = 4
  $8308  8E D0 14                   PUSH_imm2              $14D0
  $830B  8E 8A B7                   PUSH_imm2              $B78A
  $830E  60                         PUSH_qimm   ; inline operand = 0
  $830F  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $8313  8E 9A 00                   PUSH_imm2              $009A
  $8316  8E 10 15                   PUSH_imm2              $1510
  $8319  8E BC 83                   PUSH_imm2              $83BC
  $831C  64                         PUSH_qimm   ; inline operand = 4
  $831D  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $8321  40                         LOADL_qimm   ; inline operand = 0
  $8322  29                         STORE_quick   ; inline operand = 9
 >$8323  09                         LOADL_quick   ; inline operand = 9
  $8324  8C 52 B8                   LOADR_imm2             $B852
  $8327  BB                         ADD
  $8328  D3                         BYTE_DEREF
  $8329  B3                         PUSHL
  $832A  39                         PUSH_quick   ; inline operand = 9
  $832B  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $832F  09                         LOADL_quick   ; inline operand = 9
  $8330  D0                         INC
  $8331  29                         STORE_quick   ; inline operand = 9
  $8332  09                         LOADL_quick   ; inline operand = 9
  $8333  58                         LOADR_qimm   ; inline operand = 8
  $8334  C6                         UCMPLT
  $8335  D7 23 83                   JUMPT_abs              $8323
  $8338  60                         PUSH_qimm   ; inline operand = 0
  $8339  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $833D  41                         LOADL_qimm   ; inline operand = 1
  $833E  A8 D1 7F                   STORE_abs              $7FD1
  $8341  41                         LOADL_qimm   ; inline operand = 1
  $8342  CF                         RETURN
 >$8343  8E AB B8                   PUSH_imm2              $B8AB
  $8346  8E ED 7F                   PUSH_imm2              $7FED
  $8349  E9 D9 CA 04                CALL_abs_imm1          $CAD9 (strcpy) {bytecode}, $04
  $834D  60                         PUSH_qimm   ; inline operand = 0
  $834E  E9 A4 CB 02                CALL_abs_imm1          $CBA4 (chr_bank0_set_wrap) {bytecode}, $02
  $8352  89 32                      BYTE_LOADL_imm1        +50
  $8354  A8 65 6D                   STORE_abs              $6D65
  $8357  41                         LOADL_qimm   ; inline operand = 1
  $8358  A8 4D 6F                   STORE_abs              $6F4D
  $835B  40                         LOADL_qimm   ; inline operand = 0
  $835C  A8 C7 7F                   STORE_abs              $7FC7
  $835F  40                         LOADL_qimm   ; inline operand = 0
  $8360  A8 D3 7F                   STORE_abs              $7FD3
  $8363  40                         LOADL_qimm   ; inline operand = 0
  $8364  A8 D1 7F                   STORE_abs              $7FD1
  $8367  AC 89 CC                   CALL_abs               $CC89 (ui_helper_cc89) {bytecode}
  $836A  8E B0 B8                   PUSH_imm2              $B8B0
  $836D  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8371  AC 09 D6                   CALL_abs               $D609 (ui_prompt_redraw) {bytecode}
  $8374  D6 35 82                   JUMP_abs               $8235

; ============================================================
; sub $8377   (frame_off=-1, body @ $837C)
; ============================================================
  $837C  3E                         PUSH_quick   ; inline operand = 14
  $837D  0D                         LOADL_quick   ; inline operand = 13
  $837E  D3                         BYTE_DEREF
  $837F  B3                         PUSHL
  $8380  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8384  A2 FF FF                   BYTE_STORE_far         $FFFF
  $8387  A3 FF FF                   BYTE_PUSH_far          $FFFF
  $838A  0C                         LOADL_quick   ; inline operand = 12
  $838B  B4                         POPR
  $838C  B3                         PUSHL
  $838D  D3                         BYTE_DEREF
  $838E  BB                         ADD
  $838F  D4                         BYTE_POPSTORE
  $8390  A3 FF FF                   BYTE_PUSH_far          $FFFF
  $8393  0D                         LOADL_quick   ; inline operand = 13
  $8394  B4                         POPR
  $8395  B3                         PUSHL
  $8396  D3                         BYTE_DEREF
  $8397  BC                         SUB
  $8398  D4                         BYTE_POPSTORE
  $8399  CF                         RETURN

; ============================================================
; sub $839A   (frame_off=-2, body @ $839F)
; ============================================================
  $839F  0C                         LOADL_quick   ; inline operand = 12
  $83A0  55                         LOADR_qimm   ; inline operand = 5
  $83A1  B5                         MULT
  $83A2  8C A9 76                   LOADR_imm2             $76A9
  $83A5  BB                         ADD
  $83A6  2B                         STORE_quick   ; inline operand = 11
  $83A7  8D 1E                      BYTE_PUSH_imm1         +30
  $83A9  0B                         LOADL_quick   ; inline operand = 11
  $83AA  73                         ADD_qimm   ; inline operand = 3
  $83AB  B3                         PUSHL
  $83AC  3B                         PUSH_quick   ; inline operand = 11
  $83AD  E9 77 83 06                CALL_abs_imm1          $8377 {bytecode}, $06
  $83B1  8D 14                      BYTE_PUSH_imm1         +20
  $83B3  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $83B7  8F 14                      BYTE_ADD_imm1          +20
  $83B9  B3                         PUSHL
  $83BA  0B                         LOADL_quick   ; inline operand = 11
  $83BB  74                         ADD_qimm   ; inline operand = 4
  $83BC  B3                         PUSHL
  $83BD  3B                         PUSH_quick   ; inline operand = 11
  $83BE  E9 77 83 06                CALL_abs_imm1          $8377 {bytecode}, $06
  $83C2  8D 1E                      BYTE_PUSH_imm1         +30
  $83C4  0B                         LOADL_quick   ; inline operand = 11
  $83C5  74                         ADD_qimm   ; inline operand = 4
  $83C6  B3                         PUSHL
  $83C7  0B                         LOADL_quick   ; inline operand = 11
  $83C8  D0                         INC
  $83C9  B3                         PUSHL
  $83CA  E9 77 83 06                CALL_abs_imm1          $8377 {bytecode}, $06
  $83CE  8D 14                      BYTE_PUSH_imm1         +20
  $83D0  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $83D4  8F 14                      BYTE_ADD_imm1          +20
  $83D6  B3                         PUSHL
  $83D7  0B                         LOADL_quick   ; inline operand = 11
  $83D8  73                         ADD_qimm   ; inline operand = 3
  $83D9  B3                         PUSHL
  $83DA  0B                         LOADL_quick   ; inline operand = 11
  $83DB  D0                         INC
  $83DC  B3                         PUSHL
  $83DD  E9 77 83 06                CALL_abs_imm1          $8377 {bytecode}, $06
  $83E1  CF                         RETURN

; ============================================================
; sub $83E2   (frame_off=-40, body @ $83E7)
; ============================================================
  $83E7  66                         PUSH_qimm   ; inline operand = 6
  $83E8  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $83EC  8F 14                      BYTE_ADD_imm1          +20
  $83EE  A8 0D 6E                   STORE_abs              $6E0D
  $83F1  40                         LOADL_qimm   ; inline operand = 0
  $83F2  2B                         STORE_quick   ; inline operand = 11
  $83F3  29                         STORE_quick   ; inline operand = 9
  $83F4  D6 B4 85                   JUMP_abs               $85B4 (view_window_redraw_by_6da2_flag)
 >$83F7  3B                         PUSH_quick   ; inline operand = 11
  $83F8  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $83FC  D7 93 85                   JUMPT_abs              $8593
  $83FF  3B                         PUSH_quick   ; inline operand = 11
  $8400  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $8404  57                         LOADR_qimm   ; inline operand = 7
  $8405  B5                         MULT
  $8406  8C 30 75                   LOADR_imm2             $7530
  $8409  BB                         ADD
  $840A  85 D8                      STORE_near             $D8
  $840C  40                         LOADL_qimm   ; inline operand = 0
  $840D  D6 23 84                   JUMP_abs               $8423
 >$8410  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $8413  55                         LOADR_qimm   ; inline operand = 5
  $8414  B5                         MULT
  $8415  B3                         PUSHL
  $8416  81 D8                      LOADL_near             $D8
  $8418  D0                         INC
  $8419  85 D8                      STORE_near             $D8
  $841B  D1                         DEC
  $841C  B4                         POPR
  $841D  B3                         PUSHL
  $841E  D3                         BYTE_DEREF
  $841F  BB                         ADD
  $8420  D4                         BYTE_POPSTORE
  $8421  0A                         LOADL_quick   ; inline operand = 10
  $8422  D0                         INC
 >$8423  2A                         STORE_quick   ; inline operand = 10
  $8424  0A                         LOADL_quick   ; inline operand = 10
  $8425  55                         LOADR_qimm   ; inline operand = 5
  $8426  C6                         UCMPLT
  $8427  D7 10 84                   JUMPT_abs              $8410
  $842A  0B                         LOADL_quick   ; inline operand = 11
  $842B  8B 1A                      BYTE_LOADR_imm1        +26
  $842D  B5                         MULT
  $842E  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8431  BB                         ADD
  $8432  28                         STORE_quick   ; inline operand = 8
  $8433  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $8436  5A                         LOADR_qimm   ; inline operand = 10
  $8437  B5                         MULT
  $8438  B3                         PUSHL
  $8439  08                         LOADL_quick   ; inline operand = 8
  $843A  72                         ADD_qimm   ; inline operand = 2
  $843B  28                         STORE_quick   ; inline operand = 8
  $843C  8F FE                      BYTE_ADD_imm1          -2
  $843E  B4                         POPR
  $843F  B3                         PUSHL
  $8440  B0                         DEREF
  $8441  BB                         ADD
  $8442  B1                         POPSTORE
  $8443  40                         LOADL_qimm   ; inline operand = 0
  $8444  2A                         STORE_quick   ; inline operand = 10
 >$8445  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $8448  55                         LOADR_qimm   ; inline operand = 5
  $8449  B5                         MULT
  $844A  B3                         PUSHL
  $844B  08                         LOADL_quick   ; inline operand = 8
  $844C  72                         ADD_qimm   ; inline operand = 2
  $844D  28                         STORE_quick   ; inline operand = 8
  $844E  B4                         POPR
  $844F  B3                         PUSHL
  $8450  B0                         DEREF
  $8451  BB                         ADD
  $8452  B1                         POPSTORE
  $8453  0A                         LOADL_quick   ; inline operand = 10
  $8454  D0                         INC
  $8455  2A                         STORE_quick   ; inline operand = 10
  $8456  0A                         LOADL_quick   ; inline operand = 10
  $8457  5A                         LOADR_qimm   ; inline operand = 10
  $8458  C6                         UCMPLT
  $8459  D7 45 84                   JUMPT_abs              $8445
  $845C  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $845F  8B 32                      BYTE_LOADR_imm1        +50
  $8461  C0                         CMPEQ
  $8462  D8 07 85                   JUMPF_abs              $8507
  $8465  0B                         LOADL_quick   ; inline operand = 11
  $8466  55                         LOADR_qimm   ; inline operand = 5
  $8467  C0                         CMPEQ
  $8468  D7 B5 84                   JUMPT_abs              $84B5
  $846B  0B                         LOADL_quick   ; inline operand = 11
  $846C  59                         LOADR_qimm   ; inline operand = 9
  $846D  C0                         CMPEQ
  $846E  D7 B5 84                   JUMPT_abs              $84B5
  $8471  0B                         LOADL_quick   ; inline operand = 11
  $8472  5D                         LOADR_qimm   ; inline operand = 13
  $8473  C0                         CMPEQ
  $8474  D7 B5 84                   JUMPT_abs              $84B5
  $8477  0B                         LOADL_quick   ; inline operand = 11
  $8478  5E                         LOADR_qimm   ; inline operand = 14
  $8479  C0                         CMPEQ
  $847A  D7 B5 84                   JUMPT_abs              $84B5
  $847D  0B                         LOADL_quick   ; inline operand = 11
  $847E  8B 13                      BYTE_LOADR_imm1        +19
  $8480  C0                         CMPEQ
  $8481  D7 B5 84                   JUMPT_abs              $84B5
  $8484  0B                         LOADL_quick   ; inline operand = 11
  $8485  8B 17                      BYTE_LOADR_imm1        +23
  $8487  C0                         CMPEQ
  $8488  D7 B5 84                   JUMPT_abs              $84B5
  $848B  0B                         LOADL_quick   ; inline operand = 11
  $848C  8B 1A                      BYTE_LOADR_imm1        +26
  $848E  C0                         CMPEQ
  $848F  D7 B5 84                   JUMPT_abs              $84B5
  $8492  0B                         LOADL_quick   ; inline operand = 11
  $8493  8B 15                      BYTE_LOADR_imm1        +21
  $8495  C0                         CMPEQ
  $8496  D7 B5 84                   JUMPT_abs              $84B5
  $8499  0B                         LOADL_quick   ; inline operand = 11
  $849A  8B 26                      BYTE_LOADR_imm1        +38
  $849C  C0                         CMPEQ
  $849D  D7 B5 84                   JUMPT_abs              $84B5
  $84A0  0B                         LOADL_quick   ; inline operand = 11
  $84A1  8B 2A                      BYTE_LOADR_imm1        +42
  $84A3  C0                         CMPEQ
  $84A4  D7 B5 84                   JUMPT_abs              $84B5
  $84A7  0B                         LOADL_quick   ; inline operand = 11
  $84A8  8B 31                      BYTE_LOADR_imm1        +49
  $84AA  C0                         CMPEQ
  $84AB  D7 B5 84                   JUMPT_abs              $84B5
  $84AE  0B                         LOADL_quick   ; inline operand = 11
  $84AF  8B 18                      BYTE_LOADR_imm1        +24
  $84B1  C0                         CMPEQ
  $84B2  D8 8E 85                   JUMPF_abs              $858E
 >$84B5  62                         PUSH_qimm   ; inline operand = 2
  $84B6  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $84BA  D8 8E 85                   JUMPF_abs              $858E
  $84BD  DE DA FF                   LEAL_far               $FFDA
  $84C0  B3                         PUSHL
  $84C1  09                         LOADL_quick   ; inline operand = 9
  $84C2  D2                         LSHIFT1
  $84C3  B4                         POPR
  $84C4  BB                         ADD
  $84C5  B3                         PUSHL
  $84C6  0B                         LOADL_quick   ; inline operand = 11
  $84C7  B1                         POPSTORE
  $84C8  09                         LOADL_quick   ; inline operand = 9
  $84C9  D0                         INC
  $84CA  29                         STORE_quick   ; inline operand = 9
  $84CB  62                         PUSH_qimm   ; inline operand = 2
  $84CC  0B                         LOADL_quick   ; inline operand = 11
  $84CD  8B 1A                      BYTE_LOADR_imm1        +26
  $84CF  B5                         MULT
  $84D0  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $84D3  BB                         ADD
  $84D4  B4                         POPR
  $84D5  B3                         PUSHL
  $84D6  B0                         DEREF
  $84D7  B5                         MULT
  $84D8  B1                         POPSTORE
  $84D9  64                         PUSH_qimm   ; inline operand = 4
  $84DA  0B                         LOADL_quick   ; inline operand = 11
  $84DB  8B 1A                      BYTE_LOADR_imm1        +26
  $84DD  B5                         MULT
  $84DE  8C 07 70                   LOADR_imm2             $7007
  $84E1  BB                         ADD
  $84E2  B4                         POPR
  $84E3  B3                         PUSHL
  $84E4  B0                         DEREF
  $84E5  B5                         MULT
  $84E6  B1                         POPSTORE
  $84E7  62                         PUSH_qimm   ; inline operand = 2
  $84E8  0B                         LOADL_quick   ; inline operand = 11
  $84E9  8B 1A                      BYTE_LOADR_imm1        +26
  $84EB  B5                         MULT
  $84EC  8C 0D 70                   LOADR_imm2             $700D
  $84EF  BB                         ADD
  $84F0  B4                         POPR
  $84F1  B3                         PUSHL
  $84F2  B0                         DEREF
  $84F3  B5                         MULT
  $84F4  B1                         POPSTORE
  $84F5  62                         PUSH_qimm   ; inline operand = 2
  $84F6  0B                         LOADL_quick   ; inline operand = 11
  $84F7  8B 1A                      BYTE_LOADR_imm1        +26
  $84F9  B5                         MULT
  $84FA  8C 13 70                   LOADR_imm2             $7013
  $84FD  BB                         ADD
  $84FE  B4                         POPR
  $84FF  B3                         PUSHL
  $8500  B0                         DEREF
  $8501  B5                         MULT
  $8502  B1                         POPSTORE
  $8503  63                         PUSH_qimm   ; inline operand = 3
  $8504  D6 81 85                   JUMP_abs               $8581
 >$8507  0B                         LOADL_quick   ; inline operand = 11
  $8508  51                         LOADR_qimm   ; inline operand = 1
  $8509  C0                         CMPEQ
  $850A  D7 32 85                   JUMPT_abs              $8532
  $850D  0B                         LOADL_quick   ; inline operand = 11
  $850E  52                         LOADR_qimm   ; inline operand = 2
  $850F  C0                         CMPEQ
  $8510  D7 32 85                   JUMPT_abs              $8532
  $8513  0B                         LOADL_quick   ; inline operand = 11
  $8514  54                         LOADR_qimm   ; inline operand = 4
  $8515  C0                         CMPEQ
  $8516  D7 32 85                   JUMPT_abs              $8532
  $8519  0B                         LOADL_quick   ; inline operand = 11
  $851A  57                         LOADR_qimm   ; inline operand = 7
  $851B  C0                         CMPEQ
  $851C  D7 32 85                   JUMPT_abs              $8532
  $851F  0B                         LOADL_quick   ; inline operand = 11
  $8520  5A                         LOADR_qimm   ; inline operand = 10
  $8521  C0                         CMPEQ
  $8522  D7 32 85                   JUMPT_abs              $8532
  $8525  0B                         LOADL_quick   ; inline operand = 11
  $8526  5F                         LOADR_qimm   ; inline operand = 15
  $8527  C0                         CMPEQ
  $8528  D7 32 85                   JUMPT_abs              $8532
  $852B  0B                         LOADL_quick   ; inline operand = 11
  $852C  8B 10                      BYTE_LOADR_imm1        +16
  $852E  C0                         CMPEQ
  $852F  D8 8E 85                   JUMPF_abs              $858E
 >$8532  62                         PUSH_qimm   ; inline operand = 2
  $8533  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8537  D8 8E 85                   JUMPF_abs              $858E
  $853A  DE DA FF                   LEAL_far               $FFDA
  $853D  B3                         PUSHL
  $853E  09                         LOADL_quick   ; inline operand = 9
  $853F  D2                         LSHIFT1
  $8540  B4                         POPR
  $8541  BB                         ADD
  $8542  B3                         PUSHL
  $8543  0B                         LOADL_quick   ; inline operand = 11
  $8544  B1                         POPSTORE
  $8545  09                         LOADL_quick   ; inline operand = 9
  $8546  D0                         INC
  $8547  29                         STORE_quick   ; inline operand = 9
  $8548  62                         PUSH_qimm   ; inline operand = 2
  $8549  0B                         LOADL_quick   ; inline operand = 11
  $854A  8B 1A                      BYTE_LOADR_imm1        +26
  $854C  B5                         MULT
  $854D  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8550  BB                         ADD
  $8551  B4                         POPR
  $8552  B3                         PUSHL
  $8553  B0                         DEREF
  $8554  B5                         MULT
  $8555  B1                         POPSTORE
  $8556  63                         PUSH_qimm   ; inline operand = 3
  $8557  0B                         LOADL_quick   ; inline operand = 11
  $8558  8B 1A                      BYTE_LOADR_imm1        +26
  $855A  B5                         MULT
  $855B  8C 07 70                   LOADR_imm2             $7007
  $855E  BB                         ADD
  $855F  B4                         POPR
  $8560  B3                         PUSHL
  $8561  B0                         DEREF
  $8562  B5                         MULT
  $8563  B1                         POPSTORE
  $8564  62                         PUSH_qimm   ; inline operand = 2
  $8565  0B                         LOADL_quick   ; inline operand = 11
  $8566  8B 1A                      BYTE_LOADR_imm1        +26
  $8568  B5                         MULT
  $8569  8C 0D 70                   LOADR_imm2             $700D
  $856C  BB                         ADD
  $856D  B4                         POPR
  $856E  B3                         PUSHL
  $856F  B0                         DEREF
  $8570  B5                         MULT
  $8571  B1                         POPSTORE
  $8572  62                         PUSH_qimm   ; inline operand = 2
  $8573  0B                         LOADL_quick   ; inline operand = 11
  $8574  8B 1A                      BYTE_LOADR_imm1        +26
  $8576  B5                         MULT
  $8577  8C 13 70                   LOADR_imm2             $7013
  $857A  BB                         ADD
  $857B  B4                         POPR
  $857C  B3                         PUSHL
  $857D  B0                         DEREF
  $857E  B5                         MULT
  $857F  B1                         POPSTORE
  $8580  62                         PUSH_qimm   ; inline operand = 2
 >$8581  0B                         LOADL_quick   ; inline operand = 11
  $8582  8B 1A                      BYTE_LOADR_imm1        +26
  $8584  B5                         MULT
  $8585  8C 11 70                   LOADR_imm2             $7011
  $8588  BB                         ADD
  $8589  B4                         POPR
  $858A  B3                         PUSHL
  $858B  B0                         DEREF
  $858C  B5                         MULT
  $858D  B1                         POPSTORE
 >$858E  3B                         PUSH_quick   ; inline operand = 11
  $858F  E9 9A 83 02                CALL_abs_imm1          $839A {bytecode}, $02
 >$8593  0B                         LOADL_quick   ; inline operand = 11
  $8594  8B 1A                      BYTE_LOADR_imm1        +26
  $8596  B5                         MULT
  $8597  8C 19 70                   LOADR_imm2             $7019
  $859A  BB                         ADD
  $859B  28                         STORE_quick   ; inline operand = 8
  $859C  38                         PUSH_quick   ; inline operand = 8
  $859D  8D 14                      BYTE_PUSH_imm1         +20
  $859F  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $85A3  8F 50                      BYTE_ADD_imm1          +80
  $85A5  B3                         PUSHL
  $85A6  08                         LOADL_quick   ; inline operand = 8
  $85A7  B0                         DEREF
  $85A8  90 E8 03                   ADD_imm2               $03E8
  $85AB  B3                         PUSHL
  $85AC  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $85B0  B1                         POPSTORE
  $85B1  0B                         LOADL_quick   ; inline operand = 11
  $85B2  D0                         INC
  $85B3  2B                         STORE_quick   ; inline operand = 11
 >$85B4  0B                         LOADL_quick   ; inline operand = 11
  $85B5  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $85B8  C6                         UCMPLT
  $85B9  D7 F7 83                   JUMPT_abs              $83F7
  $85BC  40                         LOADL_qimm   ; inline operand = 0
  $85BD  D6 F4 85                   JUMP_abs               $85F4
 >$85C0  40                         LOADL_qimm   ; inline operand = 0
  $85C1  D6 EB 85                   JUMP_abs               $85EB
 >$85C4  DE DA FF                   LEAL_far               $FFDA
  $85C7  B3                         PUSHL
  $85C8  0B                         LOADL_quick   ; inline operand = 11
  $85C9  D2                         LSHIFT1
  $85CA  B4                         POPR
  $85CB  BB                         ADD
  $85CC  B0                         DEREF
  $85CD  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $85D0  DE DA FF                   LEAL_far               $FFDA
  $85D3  B3                         PUSHL
  $85D4  0A                         LOADL_quick   ; inline operand = 10
  $85D5  D2                         LSHIFT1
  $85D6  B4                         POPR
  $85D7  BB                         ADD
  $85D8  B0                         DEREF
  $85D9  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $85DC  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $85DF  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $85E2  C1                         CMPNE
  $85E3  D8 E9 85                   JUMPF_abs              $85E9
  $85E6  AC 7D DA                   CALL_abs               $DA7D (diplomacy_helper3) {bytecode}
 >$85E9  0A                         LOADL_quick   ; inline operand = 10
  $85EA  D0                         INC
 >$85EB  2A                         STORE_quick   ; inline operand = 10
  $85EC  0A                         LOADL_quick   ; inline operand = 10
  $85ED  19                         LOADR_quick   ; inline operand = 9
  $85EE  C6                         UCMPLT
  $85EF  D7 C4 85                   JUMPT_abs              $85C4
  $85F2  0B                         LOADL_quick   ; inline operand = 11
  $85F3  D0                         INC
 >$85F4  2B                         STORE_quick   ; inline operand = 11
  $85F5  0B                         LOADL_quick   ; inline operand = 11
  $85F6  19                         LOADR_quick   ; inline operand = 9
  $85F7  C6                         UCMPLT
  $85F8  D7 C0 85                   JUMPT_abs              $85C0
  $85FB  CF                         RETURN

; ============================================================
; sub $85FC   (frame_off=-4, body @ $8601)
; ============================================================
  $8601  A4 CD 7F                   LOADL_abs              $7FCD
  $8604  2B                         STORE_quick   ; inline operand = 11
 >$8605  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $8608  D7 05 86                   JUMPT_abs              $8605
  $860B  D6 12 86                   JUMP_abs               $8612
 >$860E  0B                         LOADL_quick   ; inline operand = 11
  $860F  A8 CD 7F                   STORE_abs              $7FCD
 >$8612  8D 32                      BYTE_PUSH_imm1         +50
  $8614  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8618  8F 3C                      BYTE_ADD_imm1          +60
  $861A  2A                         STORE_quick   ; inline operand = 10
  $861B  B3                         PUSHL
  $861C  8E C3 B8                   PUSH_imm2              $B8C3
  $861F  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8623  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $8626  D8 0E 86                   JUMPF_abs              $860E
  $8629  0A                         LOADL_quick   ; inline operand = 10
  $862A  CF                         RETURN

; ============================================================
; sub $862B   (frame_off=-4, body @ $8630)
; ============================================================
 >$8630  8E C7 B8                   PUSH_imm2              $B8C7
  $8633  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8637  8E C8 B8                   PUSH_imm2              $B8C8
  $863A  E9 51 D3 02                CALL_abs_imm1          $D351 (ui_helper_d351) {bytecode}, $02
  $863E  2A                         STORE_quick   ; inline operand = 10
  $863F  0A                         LOADL_quick   ; inline operand = 10
  $8640  52                         LOADR_qimm   ; inline operand = 2
  $8641  C0                         CMPEQ
  $8642  D7 30 86                   JUMPT_abs              $8630
  $8645  0A                         LOADL_quick   ; inline operand = 10
  $8646  51                         LOADR_qimm   ; inline operand = 1
  $8647  C0                         CMPEQ
  $8648  D8 56 86                   JUMPF_abs              $8656
  $864B  89 11                      BYTE_LOADL_imm1        +17
  $864D  A8 9D 6D                   STORE_abs              $6D9D (scenario_fief_count)
  $8650  8A 04 A0                   LOADL_imm2             $A004
  $8653  D6 5E 86                   JUMP_abs               $865E
 >$8656  89 32                      BYTE_LOADL_imm1        +50
  $8658  A8 9D 6D                   STORE_abs              $6D9D (scenario_fief_count)
  $865B  8A 04 80                   LOADL_imm2             $8004
 >$865E  2B                         STORE_quick   ; inline operand = 11
  $865F  8A CF 7F                   LOADL_imm2             $7FCF
  $8662  8C 01 60                   LOADR_imm2             $6001
  $8665  BC                         SUB
  $8666  72                         ADD_qimm   ; inline operand = 2
  $8667  B3                         PUSHL
  $8668  8E 01 60                   PUSH_imm2              $6001
  $866B  3B                         PUSH_quick   ; inline operand = 11
  $866C  63                         PUSH_qimm   ; inline operand = 3
  $866D  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8671  8E DD B8                   PUSH_imm2              $B8DD
  $8674  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8678  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $867B  A8 7D 6E                   STORE_abs              $6E7D
  $867E  CF                         RETURN

; ============================================================
; sub $867F   (frame_off=+0, body @ $8684)
; ============================================================
  $8684  8E F8 B8                   PUSH_imm2              $B8F8
  $8687  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $868B  3C                         PUSH_quick   ; inline operand = 12
  $868C  8E 00 B9                   PUSH_imm2              $B900
  $868F  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8693  CF                         RETURN

; ============================================================
; sub $8694   (frame_off=-4, body @ $8699)
; ============================================================
  $8699  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $869C  8B 32                      BYTE_LOADR_imm1        +50
  $869E  C0                         CMPEQ
  $869F  D8 A6 86                   JUMPF_abs              $86A6
  $86A2  42                         LOADL_qimm   ; inline operand = 2
  $86A3  D6 A7 86                   JUMP_abs               $86A7
 >$86A6  40                         LOADL_qimm   ; inline operand = 0
 >$86A7  B3                         PUSHL
  $86A8  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (map_helper_e5f2) {bytecode}, $02
  $86AC  41                         LOADL_qimm   ; inline operand = 1
  $86AD  A8 E0 7B                   STORE_abs              $7BE0
  $86B0  42                         LOADL_qimm   ; inline operand = 2
  $86B1  2B                         STORE_quick   ; inline operand = 11
 >$86B2  3C                         PUSH_quick   ; inline operand = 12
  $86B3  E9 7F 86 02                CALL_abs_imm1          $867F {bytecode}, $02
  $86B7  D6 F1 86                   JUMP_abs               $86F1
 >$86BA  A4 CF 7F                   LOADL_abs              $7FCF
  $86BD  D1                         DEC
  $86BE  A8 CF 7F                   STORE_abs              $7FCF
  $86C1  0A                         LOADL_quick   ; inline operand = 10
  $86C2  8B FF                      BYTE_LOADR_imm1        -1
  $86C4  C0                         CMPEQ
  $86C5  D8 F1 86                   JUMPF_abs              $86F1
  $86C8  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $86CB  8B 32                      BYTE_LOADR_imm1        +50
  $86CD  C0                         CMPEQ
  $86CE  D8 DF 86                   JUMPF_abs              $86DF
  $86D1  0B                         LOADL_quick   ; inline operand = 11
  $86D2  D0                         INC
  $86D3  2B                         STORE_quick   ; inline operand = 11
  $86D4  59                         LOADR_qimm   ; inline operand = 9
  $86D5  C9                         UCMPGE
  $86D6  D8 DB 86                   JUMPF_abs              $86DB
  $86D9  42                         LOADL_qimm   ; inline operand = 2
  $86DA  2B                         STORE_quick   ; inline operand = 11
 >$86DB  3B                         PUSH_quick   ; inline operand = 11
  $86DC  D6 ED 86                   JUMP_abs               $86ED
 >$86DF  0B                         LOADL_quick   ; inline operand = 11
  $86E0  D0                         INC
  $86E1  2B                         STORE_quick   ; inline operand = 11
  $86E2  54                         LOADR_qimm   ; inline operand = 4
  $86E3  C9                         UCMPGE
  $86E4  D8 E9 86                   JUMPF_abs              $86E9
  $86E7  42                         LOADL_qimm   ; inline operand = 2
  $86E8  2B                         STORE_quick   ; inline operand = 11
 >$86E9  0B                         LOADL_quick   ; inline operand = 11
  $86EA  8F FE                      BYTE_ADD_imm1          -2
  $86EC  B3                         PUSHL
 >$86ED  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (map_helper_e5f2) {bytecode}, $02
 >$86F1  AA 9D 6D                   PUSH_abs               $6D9D (scenario_fief_count)
  $86F4  61                         PUSH_qimm   ; inline operand = 1
  $86F5  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $86F9  2A                         STORE_quick   ; inline operand = 10
  $86FA  50                         LOADR_qimm   ; inline operand = 0
  $86FB  C3                         SCMPLE
  $86FC  D7 BA 86                   JUMPT_abs              $86BA
  $86FF  0A                         LOADL_quick   ; inline operand = 10
  $8700  D1                         DEC
  $8701  2A                         STORE_quick   ; inline operand = 10
  $8702  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $8705  BB                         ADD
  $8706  D3                         BYTE_DEREF
  $8707  55                         LOADR_qimm   ; inline operand = 5
  $8708  C1                         CMPNE
  $8709  D8 34 87                   JUMPF_abs              $8734
  $870C  8E 26 B9                   PUSH_imm2              $B926
  $870F  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8713  0A                         LOADL_quick   ; inline operand = 10
  $8714  59                         LOADR_qimm   ; inline operand = 9
  $8715  B5                         MULT
  $8716  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8719  BB                         ADD
  $871A  B3                         PUSHL
  $871B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $871F  0A                         LOADL_quick   ; inline operand = 10
  $8720  D0                         INC
  $8721  B3                         PUSHL
  $8722  8E 2A B9                   PUSH_imm2              $B92A
  $8725  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8729  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $872C  D8 3E 87                   JUMPF_abs              $873E
  $872F  49                         LOADL_qimm   ; inline operand = 9
  $8730  2B                         STORE_quick   ; inline operand = 11
  $8731  D6 3E 87                   JUMP_abs               $873E
 >$8734  8E 3A B9                   PUSH_imm2              $B93A
  $8737  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $873B  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$873E  0B                         LOADL_quick   ; inline operand = 11
  $873F  59                         LOADR_qimm   ; inline operand = 9
  $8740  C1                         CMPNE
  $8741  D7 B2 86                   JUMPT_abs              $86B2
  $8744  40                         LOADL_qimm   ; inline operand = 0
  $8745  A8 E0 7B                   STORE_abs              $7BE0
  $8748  0A                         LOADL_quick   ; inline operand = 10
  $8749  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $874C  BB                         ADD
  $874D  B3                         PUSHL
  $874E  45                         LOADL_qimm   ; inline operand = 5
  $874F  D4                         BYTE_POPSTORE
  $8750  0A                         LOADL_quick   ; inline operand = 10
  $8751  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $8754  0A                         LOADL_quick   ; inline operand = 10
  $8755  A8 DD 7F                   STORE_abs              $7FDD
  $8758  0C                         LOADL_quick   ; inline operand = 12
  $8759  8C D4 7F                   LOADR_imm2             $7FD4
  $875C  BB                         ADD
  $875D  B3                         PUSHL
  $875E  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $8761  D4                         BYTE_POPSTORE
  $8762  CF                         RETURN

; ============================================================
; sub $8763   (frame_off=-6, body @ $8768)
; ============================================================
  $8768  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $876B  61                         PUSH_qimm   ; inline operand = 1
  $876C  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8770  8D 2B                      BYTE_PUSH_imm1         +43
  $8772  67                         PUSH_qimm   ; inline operand = 7
  $8773  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8777  8D 25                      BYTE_PUSH_imm1         +37
  $8779  6B                         PUSH_qimm   ; inline operand = 11
  $877A  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $877E  61                         PUSH_qimm   ; inline operand = 1
  $877F  6A                         PUSH_qimm   ; inline operand = 10
  $8780  6A                         PUSH_qimm   ; inline operand = 10
  $8781  66                         PUSH_qimm   ; inline operand = 6
  $8782  62                         PUSH_qimm   ; inline operand = 2
  $8783  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8787  61                         PUSH_qimm   ; inline operand = 1
  $8788  8D 10                      BYTE_PUSH_imm1         +16
  $878A  8D 1A                      BYTE_PUSH_imm1         +26
  $878C  6C                         PUSH_qimm   ; inline operand = 12
  $878D  8D 10                      BYTE_PUSH_imm1         +16
  $878F  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8793  62                         PUSH_qimm   ; inline operand = 2
  $8794  8D 12                      BYTE_PUSH_imm1         +18
  $8796  8D 1A                      BYTE_PUSH_imm1         +26
  $8798  8D 12                      BYTE_PUSH_imm1         +18
  $879A  6E                         PUSH_qimm   ; inline operand = 14
  $879B  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $879F  64                         PUSH_qimm   ; inline operand = 4
  $87A0  63                         PUSH_qimm   ; inline operand = 3
  $87A1  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $87A5  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $87A8  D0                         INC
  $87A9  B3                         PUSHL
  $87AA  8E 57 B9                   PUSH_imm2              $B957
  $87AD  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $87B1  66                         PUSH_qimm   ; inline operand = 6
  $87B2  63                         PUSH_qimm   ; inline operand = 3
  $87B3  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $87B7  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $87BA  5A                         LOADR_qimm   ; inline operand = 10
  $87BB  B5                         MULT
  $87BC  8C 85 79                   LOADR_imm2             $7985
  $87BF  BB                         ADD
  $87C0  B3                         PUSHL
  $87C1  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $87C5  68                         PUSH_qimm   ; inline operand = 8
  $87C6  63                         PUSH_qimm   ; inline operand = 3
  $87C7  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $87CB  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $87CE  59                         LOADR_qimm   ; inline operand = 9
  $87CF  B5                         MULT
  $87D0  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $87D3  BB                         ADD
  $87D4  B3                         PUSHL
  $87D5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $87D9  6A                         PUSH_qimm   ; inline operand = 10
  $87DA  63                         PUSH_qimm   ; inline operand = 3
  $87DB  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $87DF  AC EA D7                   CALL_abs               $D7EA (ui_helper_d7ea) {bytecode}
  $87E2  2B                         STORE_quick   ; inline operand = 11
  $87E3  0B                         LOADL_quick   ; inline operand = 11
  $87E4  D0                         INC
  $87E5  2B                         STORE_quick   ; inline operand = 11
  $87E6  D1                         DEC
  $87E7  D3                         BYTE_DEREF
  $87E8  B3                         PUSHL
  $87E9  8E 60 B9                   PUSH_imm2              $B960
  $87EC  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $87F0  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $87F3  A8 5B 6F                   STORE_abs              $6F5B
  $87F6  6C                         PUSH_qimm   ; inline operand = 12
  $87F7  64                         PUSH_qimm   ; inline operand = 4
  $87F8  E9 6F E7 04                CALL_abs_imm1          $E76F (marry_helper_e76f) {bytecode}, $04
  $87FC  66                         PUSH_qimm   ; inline operand = 6
  $87FD  6D                         PUSH_qimm   ; inline operand = 13
  $87FE  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $8802  8E 69 B9                   PUSH_imm2              $B969
  $8805  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8809  67                         PUSH_qimm   ; inline operand = 7
  $880A  6D                         PUSH_qimm   ; inline operand = 13
  $880B  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $880F  8E 74 B9                   PUSH_imm2              $B974
  $8812  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8816  69                         PUSH_qimm   ; inline operand = 9
  $8817  6D                         PUSH_qimm   ; inline operand = 13
  $8818  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $881C  8E 85 B9                   PUSH_imm2              $B985
  $881F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8823  6A                         PUSH_qimm   ; inline operand = 10
  $8824  6D                         PUSH_qimm   ; inline operand = 13
  $8825  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $8829  8E 96 B9                   PUSH_imm2              $B996
  $882C  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8830  41                         LOADL_qimm   ; inline operand = 1
  $8831  29                         STORE_quick   ; inline operand = 9
 >$8832  09                         LOADL_quick   ; inline operand = 9
  $8833  7B                         ADD_qimm   ; inline operand = 11
  $8834  B3                         PUSHL
  $8835  8D 10                      BYTE_PUSH_imm1         +16
  $8837  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $883B  09                         LOADL_quick   ; inline operand = 9
  $883C  D2                         LSHIFT1
  $883D  8C AE F8                   LOADR_imm2             $F8AE
  $8840  BB                         ADD
  $8841  B0                         DEREF
  $8842  B3                         PUSHL
  $8843  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8847  89 16                      BYTE_LOADL_imm1        +22
  $8849  A8 CD 7F                   STORE_abs              $7FCD
  $884C  8E A7 B9                   PUSH_imm2              $B9A7
  $884F  E9 34 D1 02                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $02
  $8853  09                         LOADL_quick   ; inline operand = 9
  $8854  D0                         INC
  $8855  29                         STORE_quick   ; inline operand = 9
  $8856  09                         LOADL_quick   ; inline operand = 9
  $8857  56                         LOADR_qimm   ; inline operand = 6
  $8858  C2                         SCMPLT
  $8859  D7 32 88                   JUMPT_abs              $8832
  $885C  60                         PUSH_qimm   ; inline operand = 0
  $885D  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
 >$8861  40                         LOADL_qimm   ; inline operand = 0
  $8862  29                         STORE_quick   ; inline operand = 9
  $8863  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8866  57                         LOADR_qimm   ; inline operand = 7
  $8867  B5                         MULT
  $8868  8C 30 75                   LOADR_imm2             $7530
  $886B  BB                         ADD
  $886C  2B                         STORE_quick   ; inline operand = 11
  $886D  41                         LOADL_qimm   ; inline operand = 1
  $886E  2A                         STORE_quick   ; inline operand = 10
 >$886F  0A                         LOADL_quick   ; inline operand = 10
  $8870  7B                         ADD_qimm   ; inline operand = 11
  $8871  B3                         PUSHL
  $8872  8D 17                      BYTE_PUSH_imm1         +23
  $8874  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $8878  3B                         PUSH_quick   ; inline operand = 11
  $8879  AC FC 85                   CALL_abs               $85FC {bytecode}
  $887C  D4                         BYTE_POPSTORE
  $887D  0B                         LOADL_quick   ; inline operand = 11
  $887E  D0                         INC
  $887F  2B                         STORE_quick   ; inline operand = 11
  $8880  D1                         DEC
  $8881  D3                         BYTE_DEREF
  $8882  CD                         SWAP
  $8883  09                         LOADL_quick   ; inline operand = 9
  $8884  BB                         ADD
  $8885  29                         STORE_quick   ; inline operand = 9
  $8886  0A                         LOADL_quick   ; inline operand = 10
  $8887  D0                         INC
  $8888  2A                         STORE_quick   ; inline operand = 10
  $8889  0A                         LOADL_quick   ; inline operand = 10
  $888A  55                         LOADR_qimm   ; inline operand = 5
  $888B  C7                         UCMPLE
  $888C  D7 6F 88                   JUMPT_abs              $886F
  $888F  8D 12                      BYTE_PUSH_imm1         +18
  $8891  6F                         PUSH_qimm   ; inline operand = 15
  $8892  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $8896  39                         PUSH_quick   ; inline operand = 9
  $8897  8E AD B9                   PUSH_imm2              $B9AD
  $889A  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $889E  8E B8 B9                   PUSH_imm2              $B9B8
  $88A1  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $88A5  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $88A8  D8 61 88                   JUMPF_abs              $8861
  $88AB  CF                         RETURN

; ============================================================
; sub $88AC   (frame_off=-2, body @ $88B1)
; ============================================================
  $88B1  40                         LOADL_qimm   ; inline operand = 0
  $88B2  A8 C5 7F                   STORE_abs              $7FC5
  $88B5  61                         PUSH_qimm   ; inline operand = 1
  $88B6  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $88BA  8D 66                      BYTE_PUSH_imm1         +102
  $88BC  8E 00 10                   PUSH_imm2              $1000
  $88BF  8E 4A AC                   PUSH_imm2              $AC4A
  $88C2  60                         PUSH_qimm   ; inline operand = 0
  $88C3  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $88C7  64                         PUSH_qimm   ; inline operand = 4
  $88C8  8E C0 23                   PUSH_imm2              $23C0
  $88CB  8E 4A A8                   PUSH_imm2              $A84A
  $88CE  60                         PUSH_qimm   ; inline operand = 0
  $88CF  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $88D3  60                         PUSH_qimm   ; inline operand = 0
  $88D4  8E 8A A8                   PUSH_imm2              $A88A
  $88D7  8D 1D                      BYTE_PUSH_imm1         +29
  $88D9  8D 1F                      BYTE_PUSH_imm1         +31
  $88DB  60                         PUSH_qimm   ; inline operand = 0
  $88DC  60                         PUSH_qimm   ; inline operand = 0
  $88DD  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $88E1  40                         LOADL_qimm   ; inline operand = 0
  $88E2  2B                         STORE_quick   ; inline operand = 11
 >$88E3  0B                         LOADL_quick   ; inline operand = 11
  $88E4  8C 62 B8                   LOADR_imm2             $B862
  $88E7  BB                         ADD
  $88E8  D3                         BYTE_DEREF
  $88E9  B3                         PUSHL
  $88EA  3B                         PUSH_quick   ; inline operand = 11
  $88EB  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $88EF  0B                         LOADL_quick   ; inline operand = 11
  $88F0  D0                         INC
  $88F1  2B                         STORE_quick   ; inline operand = 11
  $88F2  0B                         LOADL_quick   ; inline operand = 11
  $88F3  8B 20                      BYTE_LOADR_imm1        +32
  $88F5  C6                         UCMPLT
  $88F6  D7 E3 88                   JUMPT_abs              $88E3
  $88F9  60                         PUSH_qimm   ; inline operand = 0
  $88FA  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $88FE  8A FF 00                   LOADL_imm2             $00FF
  $8901  A8 DF 7F                   STORE_abs              $7FDF
  $8904  40                         LOADL_qimm   ; inline operand = 0
  $8905  A8 D3 7F                   STORE_abs              $7FD3
 >$8908  60                         PUSH_qimm   ; inline operand = 0
  $8909  66                         PUSH_qimm   ; inline operand = 6
  $890A  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $890E  D7 08 89                   JUMPT_abs              $8908
  $8911  61                         PUSH_qimm   ; inline operand = 1
  $8912  66                         PUSH_qimm   ; inline operand = 6
  $8913  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $8917  D7 08 89                   JUMPT_abs              $8908
 >$891A  60                         PUSH_qimm   ; inline operand = 0
  $891B  66                         PUSH_qimm   ; inline operand = 6
  $891C  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $8920  D7 2C 89                   JUMPT_abs              $892C
  $8923  61                         PUSH_qimm   ; inline operand = 1
  $8924  66                         PUSH_qimm   ; inline operand = 6
  $8925  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $8929  D8 1A 89                   JUMPF_abs              $891A
 >$892C  61                         PUSH_qimm   ; inline operand = 1
  $892D  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8931  8D 51                      BYTE_PUSH_imm1         +81
  $8933  8E 00 10                   PUSH_imm2              $1000
  $8936  8E BA B2                   PUSH_imm2              $B2BA
  $8939  60                         PUSH_qimm   ; inline operand = 0
  $893A  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $893E  8E B1 00                   PUSH_imm2              $00B1
  $8941  8E D0 14                   PUSH_imm2              $14D0
  $8944  8E 64 82                   PUSH_imm2              $8264
  $8947  66                         PUSH_qimm   ; inline operand = 6
  $8948  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $894C  AC 50 CF                   CALL_abs               $CF50 (fill_nametable_wrap) {bytecode}
  $894F  AC 5D CF                   CALL_abs               $CF5D (fill_attr_wrap) {bytecode}
  $8952  66                         PUSH_qimm   ; inline operand = 6
  $8953  8E 04 80                   PUSH_imm2              $8004
  $8956  8D 15                      BYTE_PUSH_imm1         +21
  $8958  8D 1F                      BYTE_PUSH_imm1         +31
  $895A  63                         PUSH_qimm   ; inline operand = 3
  $895B  60                         PUSH_qimm   ; inline operand = 0
  $895C  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $8960  61                         PUSH_qimm   ; inline operand = 1
  $8961  67                         PUSH_qimm   ; inline operand = 7
  $8962  8D 11                      BYTE_PUSH_imm1         +17
  $8964  63                         PUSH_qimm   ; inline operand = 3
  $8965  60                         PUSH_qimm   ; inline operand = 0
  $8966  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $896A  61                         PUSH_qimm   ; inline operand = 1
  $896B  8D 1A                      BYTE_PUSH_imm1         +26
  $896D  8D 1D                      BYTE_PUSH_imm1         +29
  $896F  8D 1A                      BYTE_PUSH_imm1         +26
  $8971  8D 14                      BYTE_PUSH_imm1         +20
  $8973  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8977  8D 1A                      BYTE_PUSH_imm1         +26
  $8979  8D 15                      BYTE_PUSH_imm1         +21
  $897B  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $897F  8E C3 B9                   PUSH_imm2              $B9C3
  $8982  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8986  40                         LOADL_qimm   ; inline operand = 0
  $8987  2B                         STORE_quick   ; inline operand = 11
 >$8988  0B                         LOADL_quick   ; inline operand = 11
  $8989  8C 5A B8                   LOADR_imm2             $B85A
  $898C  BB                         ADD
  $898D  D3                         BYTE_DEREF
  $898E  B3                         PUSHL
  $898F  3B                         PUSH_quick   ; inline operand = 11
  $8990  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8994  0B                         LOADL_quick   ; inline operand = 11
  $8995  D0                         INC
  $8996  2B                         STORE_quick   ; inline operand = 11
  $8997  0B                         LOADL_quick   ; inline operand = 11
  $8998  58                         LOADR_qimm   ; inline operand = 8
  $8999  C6                         UCMPLT
  $899A  D7 88 89                   JUMPT_abs              $8988
  $899D  60                         PUSH_qimm   ; inline operand = 0
  $899E  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $89A2  CF                         RETURN

; ============================================================
; sub $89A3   (frame_off=-2, body @ $89A8)
; ============================================================
  $89A8  41                         LOADL_qimm   ; inline operand = 1
  $89A9  A8 4D 6F                   STORE_abs              $6F4D
  $89AC  60                         PUSH_qimm   ; inline operand = 0
  $89AD  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $89B1  AC AC 88                   CALL_abs               $88AC {bytecode}
  $89B4  40                         LOADL_qimm   ; inline operand = 0
  $89B5  A8 E7 7F                   STORE_abs              $7FE7
  $89B8  89 32                      BYTE_LOADL_imm1        +50
  $89BA  A8 65 6D                   STORE_abs              $6D65
  $89BD  40                         LOADL_qimm   ; inline operand = 0
  $89BE  A8 C7 7F                   STORE_abs              $7FC7
 >$89C1  40                         LOADL_qimm   ; inline operand = 0
  $89C2  A8 D3 7F                   STORE_abs              $7FD3
  $89C5  40                         LOADL_qimm   ; inline operand = 0
  $89C6  A8 D1 7F                   STORE_abs              $7FD1
  $89C9  AC 1E 82                   CALL_abs               $821E {bytecode}
  $89CC  D8 D7 89                   JUMPF_abs              $89D7
  $89CF  60                         PUSH_qimm   ; inline operand = 0
  $89D0  60                         PUSH_qimm   ; inline operand = 0
  $89D1  6A                         PUSH_qimm   ; inline operand = 10
  $89D2  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $89D6  CF                         RETURN
 >$89D7  40                         LOADL_qimm   ; inline operand = 0
  $89D8  2B                         STORE_quick   ; inline operand = 11
 >$89D9  0B                         LOADL_quick   ; inline operand = 11
  $89DA  8C D5 7F                   LOADR_imm2             $7FD5
  $89DD  BB                         ADD
  $89DE  B3                         PUSHL
  $89DF  89 FF                      BYTE_LOADL_imm1        -1
  $89E1  D4                         BYTE_POPSTORE
  $89E2  0B                         LOADL_quick   ; inline operand = 11
  $89E3  D0                         INC
  $89E4  2B                         STORE_quick   ; inline operand = 11
  $89E5  0B                         LOADL_quick   ; inline operand = 11
  $89E6  58                         LOADR_qimm   ; inline operand = 8
  $89E7  C6                         UCMPLT
  $89E8  D7 D9 89                   JUMPT_abs              $89D9
  $89EB  AC 2B 86                   CALL_abs               $862B {bytecode}
  $89EE  40                         LOADL_qimm   ; inline operand = 0
  $89EF  D6 FC 89                   JUMP_abs               $89FC
 >$89F2  0B                         LOADL_quick   ; inline operand = 11
  $89F3  8C 1B 6F                   LOADR_imm2             $6F1B
  $89F6  BB                         ADD
  $89F7  B3                         PUSHL
  $89F8  0B                         LOADL_quick   ; inline operand = 11
  $89F9  D4                         BYTE_POPSTORE
  $89FA  0B                         LOADL_quick   ; inline operand = 11
  $89FB  D0                         INC
 >$89FC  2B                         STORE_quick   ; inline operand = 11
  $89FD  0B                         LOADL_quick   ; inline operand = 11
  $89FE  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $8A01  C6                         UCMPLT
  $8A02  D7 F2 89                   JUMPT_abs              $89F2
  $8A05  40                         LOADL_qimm   ; inline operand = 0
  $8A06  D6 13 8A                   JUMP_abs               $8A13
 >$8A09  0B                         LOADL_quick   ; inline operand = 11
  $8A0A  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $8A0D  BB                         ADD
  $8A0E  B3                         PUSHL
  $8A0F  40                         LOADL_qimm   ; inline operand = 0
  $8A10  D4                         BYTE_POPSTORE
  $8A11  0B                         LOADL_quick   ; inline operand = 11
  $8A12  D0                         INC
 >$8A13  2B                         STORE_quick   ; inline operand = 11
  $8A14  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $8A17  74                         ADD_qimm   ; inline operand = 4
  $8A18  B3                         PUSHL
  $8A19  0B                         LOADL_quick   ; inline operand = 11
  $8A1A  B4                         POPR
  $8A1B  C6                         UCMPLT
  $8A1C  D7 09 8A                   JUMPT_abs              $8A09
 >$8A1F  8E CD B9                   PUSH_imm2              $B9CD
  $8A22  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8A26  68                         PUSH_qimm   ; inline operand = 8
  $8A27  61                         PUSH_qimm   ; inline operand = 1
  $8A28  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $8A2C  A8 61 6D                   STORE_abs              $6D61
  $8A2F  D8 1F 8A                   JUMPF_abs              $8A1F
  $8A32  40                         LOADL_qimm   ; inline operand = 0
  $8A33  2B                         STORE_quick   ; inline operand = 11
 >$8A34  0B                         LOADL_quick   ; inline operand = 11
  $8A35  D2                         LSHIFT1
  $8A36  8C 0B 6E                   LOADR_imm2             $6E0B
  $8A39  BB                         ADD
  $8A3A  B3                         PUSHL
  $8A3B  6A                         PUSH_qimm   ; inline operand = 10
  $8A3C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8A40  78                         ADD_qimm   ; inline operand = 8
  $8A41  B1                         POPSTORE
  $8A42  0B                         LOADL_quick   ; inline operand = 11
  $8A43  D0                         INC
  $8A44  2B                         STORE_quick   ; inline operand = 11
  $8A45  0B                         LOADL_quick   ; inline operand = 11
  $8A46  55                         LOADR_qimm   ; inline operand = 5
  $8A47  C6                         UCMPLT
  $8A48  D7 34 8A                   JUMPT_abs              $8A34
  $8A4B  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $8A4E  41                         LOADL_qimm   ; inline operand = 1
  $8A4F  A8 D1 7F                   STORE_abs              $7FD1
  $8A52  61                         PUSH_qimm   ; inline operand = 1
  $8A53  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8A57  64                         PUSH_qimm   ; inline operand = 4
  $8A58  8E D0 14                   PUSH_imm2              $14D0
  $8A5B  8E 8A B7                   PUSH_imm2              $B78A
  $8A5E  60                         PUSH_qimm   ; inline operand = 0
  $8A5F  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $8A63  8E 9A 00                   PUSH_imm2              $009A
  $8A66  8E 10 15                   PUSH_imm2              $1510
  $8A69  8E BC 83                   PUSH_imm2              $83BC
  $8A6C  64                         PUSH_qimm   ; inline operand = 4
  $8A6D  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $8A71  40                         LOADL_qimm   ; inline operand = 0
  $8A72  2B                         STORE_quick   ; inline operand = 11
 >$8A73  0B                         LOADL_quick   ; inline operand = 11
  $8A74  8C 52 B8                   LOADR_imm2             $B852
  $8A77  BB                         ADD
  $8A78  D3                         BYTE_DEREF
  $8A79  B3                         PUSHL
  $8A7A  3B                         PUSH_quick   ; inline operand = 11
  $8A7B  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8A7F  0B                         LOADL_quick   ; inline operand = 11
  $8A80  D0                         INC
  $8A81  2B                         STORE_quick   ; inline operand = 11
  $8A82  0B                         LOADL_quick   ; inline operand = 11
  $8A83  58                         LOADR_qimm   ; inline operand = 8
  $8A84  C6                         UCMPLT
  $8A85  D7 73 8A                   JUMPT_abs              $8A73
  $8A88  60                         PUSH_qimm   ; inline operand = 0
  $8A89  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8A8D  41                         LOADL_qimm   ; inline operand = 1
  $8A8E  D6 BC 8A                   JUMP_abs               $8ABC
 >$8A91  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $8A94  8D 21                      BYTE_PUSH_imm1         +33
  $8A96  67                         PUSH_qimm   ; inline operand = 7
  $8A97  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8A9B  8D 30                      BYTE_PUSH_imm1         +48
  $8A9D  6B                         PUSH_qimm   ; inline operand = 11
  $8A9E  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8AA2  0B                         LOADL_quick   ; inline operand = 11
  $8AA3  51                         LOADR_qimm   ; inline operand = 1
  $8AA4  DA                         AND
  $8AA5  51                         LOADR_qimm   ; inline operand = 1
  $8AA6  C0                         CMPEQ
  $8AA7  D8 AE 8A                   JUMPF_abs              $8AAE
  $8AAA  40                         LOADL_qimm   ; inline operand = 0
  $8AAB  D6 AF 8A                   JUMP_abs               $8AAF
 >$8AAE  44                         LOADL_qimm   ; inline operand = 4
 >$8AAF  A8 D3 7F                   STORE_abs              $7FD3
  $8AB2  3B                         PUSH_quick   ; inline operand = 11
  $8AB3  E9 94 86 02                CALL_abs_imm1          $8694 {bytecode}, $02
  $8AB7  AC 63 87                   CALL_abs               $8763 {bytecode}
  $8ABA  0B                         LOADL_quick   ; inline operand = 11
  $8ABB  D0                         INC
 >$8ABC  2B                         STORE_quick   ; inline operand = 11
  $8ABD  0B                         LOADL_quick   ; inline operand = 11
  $8ABE  A6 61 6D                   LOADR_abs              $6D61
  $8AC1  C7                         UCMPLE
  $8AC2  D7 91 8A                   JUMPT_abs              $8A91
  $8AC5  40                         LOADL_qimm   ; inline operand = 0
  $8AC6  A8 D3 7F                   STORE_abs              $7FD3
 >$8AC9  8E DE B9                   PUSH_imm2              $B9DE
  $8ACC  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8AD0  65                         PUSH_qimm   ; inline operand = 5
  $8AD1  61                         PUSH_qimm   ; inline operand = 1
  $8AD2  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $8AD6  A8 63 6D                   STORE_abs              $6D63 (const_two)
  $8AD9  D8 C9 8A                   JUMPF_abs              $8AC9
  $8ADC  8E F8 B9                   PUSH_imm2              $B9F8
  $8ADF  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8AE3  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $8AE6  D7 44 8B                   JUMPT_abs              $8B44
  $8AE9  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $8AEC  61                         PUSH_qimm   ; inline operand = 1
  $8AED  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8AF1  8E B1 00                   PUSH_imm2              $00B1
  $8AF4  8E D0 14                   PUSH_imm2              $14D0
  $8AF7  8E 64 82                   PUSH_imm2              $8264
  $8AFA  66                         PUSH_qimm   ; inline operand = 6
  $8AFB  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $8AFF  66                         PUSH_qimm   ; inline operand = 6
  $8B00  8E 04 80                   PUSH_imm2              $8004
  $8B03  8D 15                      BYTE_PUSH_imm1         +21
  $8B05  8D 1F                      BYTE_PUSH_imm1         +31
  $8B07  63                         PUSH_qimm   ; inline operand = 3
  $8B08  60                         PUSH_qimm   ; inline operand = 0
  $8B09  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $8B0D  61                         PUSH_qimm   ; inline operand = 1
  $8B0E  67                         PUSH_qimm   ; inline operand = 7
  $8B0F  8D 11                      BYTE_PUSH_imm1         +17
  $8B11  63                         PUSH_qimm   ; inline operand = 3
  $8B12  60                         PUSH_qimm   ; inline operand = 0
  $8B13  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8B17  40                         LOADL_qimm   ; inline operand = 0
  $8B18  2B                         STORE_quick   ; inline operand = 11
 >$8B19  0B                         LOADL_quick   ; inline operand = 11
  $8B1A  58                         LOADR_qimm   ; inline operand = 8
  $8B1B  C6                         UCMPLT
  $8B1C  D8 26 8B                   JUMPF_abs              $8B26
  $8B1F  0B                         LOADL_quick   ; inline operand = 11
  $8B20  8C 5A B8                   LOADR_imm2             $B85A
  $8B23  D6 2A 8B                   JUMP_abs               $8B2A
 >$8B26  0B                         LOADL_quick   ; inline operand = 11
  $8B27  8C 62 B8                   LOADR_imm2             $B862
 >$8B2A  BB                         ADD
  $8B2B  D3                         BYTE_DEREF
  $8B2C  B3                         PUSHL
  $8B2D  3B                         PUSH_quick   ; inline operand = 11
  $8B2E  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8B32  0B                         LOADL_quick   ; inline operand = 11
  $8B33  D0                         INC
  $8B34  2B                         STORE_quick   ; inline operand = 11
  $8B35  0B                         LOADL_quick   ; inline operand = 11
  $8B36  8B 20                      BYTE_LOADR_imm1        +32
  $8B38  C6                         UCMPLT
  $8B39  D7 19 8B                   JUMPT_abs              $8B19
  $8B3C  60                         PUSH_qimm   ; inline operand = 0
  $8B3D  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $8B41  D6 C1 89                   JUMP_abs               $89C1 (develop_morale)
 >$8B44  8E 10 BA                   PUSH_imm2              $BA10
  $8B47  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8B4B  48                         LOADL_qimm   ; inline operand = 8
  $8B4C  A6 61 6D                   LOADR_abs              $6D61
  $8B4F  BC                         SUB
  $8B50  A8 09 6E                   STORE_abs              $6E09
  $8B53  AC E2 83                   CALL_abs               $83E2 {bytecode}
  $8B56  41                         LOADL_qimm   ; inline operand = 1
  $8B57  A8 C7 7F                   STORE_abs              $7FC7
  $8B5A  60                         PUSH_qimm   ; inline operand = 0
  $8B5B  60                         PUSH_qimm   ; inline operand = 0
  $8B5C  6A                         PUSH_qimm   ; inline operand = 10
  $8B5D  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $8B61  8D 21                      BYTE_PUSH_imm1         +33
  $8B63  67                         PUSH_qimm   ; inline operand = 7
  $8B64  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8B68  8D 30                      BYTE_PUSH_imm1         +48
  $8B6A  6B                         PUSH_qimm   ; inline operand = 11
  $8B6B  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8B6F  CF                         RETURN

; ============================================================
; sub $8B70   (frame_off=-2, body @ $8B75)
; ============================================================
  $8B75  0C                         LOADL_quick   ; inline operand = 12
  $8B76  8C 79 7B                   LOADR_imm2             $7B79
  $8B79  BB                         ADD
  $8B7A  D3                         BYTE_DEREF
  $8B7B  56                         LOADR_qimm   ; inline operand = 6
  $8B7C  C0                         CMPEQ
  $8B7D  D8 86 8B                   JUMPF_abs              $8B86
  $8B80  8A 28 BA                   LOADL_imm2             $BA28
  $8B83  D6 9A 8B                   JUMP_abs               $8B9A
 >$8B86  0C                         LOADL_quick   ; inline operand = 12
  $8B87  8C 79 7B                   LOADR_imm2             $7B79
  $8B8A  BB                         ADD
  $8B8B  D3                         BYTE_DEREF
  $8B8C  57                         LOADR_qimm   ; inline operand = 7
  $8B8D  C0                         CMPEQ
  $8B8E  D8 97 8B                   JUMPF_abs              $8B97
  $8B91  8A 31 BA                   LOADL_imm2             $BA31
  $8B94  D6 9A 8B                   JUMP_abs               $8B9A
 >$8B97  8A 3A BA                   LOADL_imm2             $BA3A
 >$8B9A  2B                         STORE_quick   ; inline operand = 11
  $8B9B  0B                         LOADL_quick   ; inline operand = 11
  $8B9C  CF                         RETURN

; ============================================================
; sub $8B9D   (frame_off=-2, body @ $8BA2)
; ============================================================
  $8BA2  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $8BA5  8B 20                      BYTE_LOADR_imm1        +32
  $8BA7  DA                         AND
  $8BA8  D8 AF 8B                   JUMPF_abs              $8BAF
  $8BAB  8A 55 BA                   LOADL_imm2             $BA55
  $8BAE  CF                         RETURN
 >$8BAF  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $8BB2  8B 10                      BYTE_LOADR_imm1        +16
  $8BB4  DA                         AND
  $8BB5  D8 BC 8B                   JUMPF_abs              $8BBC
  $8BB8  8A 6A 79                   LOADL_imm2             $796A
  $8BBB  CF                         RETURN
 >$8BBC  0C                         LOADL_quick   ; inline operand = 12
  $8BBD  D9 04 00 07 00 D2 8B 0D 00 D8 8B 17 ... SWITCH_noncontig       count=4   ; .table 4 (key,target) + default (noncontiguous); SWITCH 7=>$8BD2 13=>$8BD8 23=>$8BD2 30=>$8BD8 default=>$8BDE
 >$8BD2  8A 43 BA                   LOADL_imm2             $BA43
 >$8BD5  2B                         STORE_quick   ; inline operand = 11
  $8BD6  0B                         LOADL_quick   ; inline operand = 11
  $8BD7  CF                         RETURN
 >$8BD8  8A 4C BA                   LOADL_imm2             $BA4C
  $8BDB  D6 D5 8B                   JUMP_abs               $8BD5
 >$8BDE  3C                         PUSH_quick   ; inline operand = 12
  $8BDF  E9 70 8B 02                CALL_abs_imm1          $8B70 {bytecode}, $02
  $8BE3  D6 D5 8B                   JUMP_abs               $8BD5

; ============================================================
; sub $8BE6   (frame_off=-2, body @ $8BEB)
; ============================================================
  $8BEB  AC A2 E4                   CALL_abs               $E4A2 (build_owned_fief_list_6f89) {bytecode}
  $8BEE  8A 89 6F                   LOADL_imm2             $6F89
  $8BF1  D6 03 8C                   JUMP_abs               $8C03
 >$8BF4  0B                         LOADL_quick   ; inline operand = 11
  $8BF5  D3                         BYTE_DEREF
  $8BF6  B3                         PUSHL
  $8BF7  E9 B7 D9 02                CALL_abs_imm1          $D9B7 (is_enemy_owned) {bytecode}, $02
  $8BFB  D8 01 8C                   JUMPF_abs              $8C01
  $8BFE  0B                         LOADL_quick   ; inline operand = 11
  $8BFF  D3                         BYTE_DEREF
  $8C00  CF                         RETURN
 >$8C01  0B                         LOADL_quick   ; inline operand = 11
  $8C02  D0                         INC
 >$8C03  2B                         STORE_quick   ; inline operand = 11
  $8C04  0B                         LOADL_quick   ; inline operand = 11
  $8C05  D3                         BYTE_DEREF
  $8C06  8C FF 00                   LOADR_imm2             $00FF
  $8C09  C1                         CMPNE
  $8C0A  D7 F4 8B                   JUMPT_abs              $8BF4 (apply_hire_unit_stats)
  $8C0D  CF                         RETURN

; ============================================================
; sub $8C0E   (frame_off=+0, body @ $8C13)
; ============================================================
  $8C13  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8C16  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $8C19  BB                         ADD
  $8C1A  D3                         BYTE_DEREF
  $8C1B  55                         LOADR_qimm   ; inline operand = 5
  $8C1C  C0                         CMPEQ
  $8C1D  CF                         RETURN

; ============================================================
; sub $8C1E   (frame_off=+0, body @ $8C23)
; ============================================================
  $8C23  AC A9 D9                   CALL_abs               $D9A9 (get_6da2_cur) {bytecode}
  $8C26  D8 2F 8C                   JUMPF_abs              $8C2F
  $8C29  AC 0E 8C                   CALL_abs               $8C0E {bytecode}
  $8C2C  D7 33 8C                   JUMPT_abs              $8C33
 >$8C2F  40                         LOADL_qimm   ; inline operand = 0
  $8C30  D6 34 8C                   JUMP_abs               $8C34
 >$8C33  41                         LOADL_qimm   ; inline operand = 1
 >$8C34  CF                         RETURN

; ============================================================
; sub $8C35   (frame_off=+0, body @ $8C3A)
; ============================================================
  $8C3A  0C                         LOADL_quick   ; inline operand = 12
  $8C3B  8B 36                      BYTE_LOADR_imm1        +54
  $8C3D  B5                         MULT
  $8C3E  1D                         LOADR_quick   ; inline operand = 13
  $8C3F  BB                         ADD
  $8C40  8C 93 61                   LOADR_imm2             $6193
  $8C43  BB                         ADD
  $8C44  CF                         RETURN

; ============================================================
; sub $8C45   (frame_off=-4, body @ $8C4A)
; ============================================================
  $8C4A  40                         LOADL_qimm   ; inline operand = 0
  $8C4B  2B                         STORE_quick   ; inline operand = 11
  $8C4C  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $8C4F  D6 68 8C                   JUMP_abs               $8C68 (random_daimyo_stat_increment)
 >$8C52  0A                         LOADL_quick   ; inline operand = 10
  $8C53  8C 1A 6F                   LOADR_imm2             $6F1A
  $8C56  BB                         ADD
  $8C57  D3                         BYTE_DEREF
  $8C58  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $8C5B  AC 1E 8C                   CALL_abs               $8C1E {bytecode}
  $8C5E  D8 66 8C                   JUMPF_abs              $8C66
  $8C61  41                         LOADL_qimm   ; inline operand = 1
  $8C62  2B                         STORE_quick   ; inline operand = 11
  $8C63  D6 6D 8C                   JUMP_abs               $8C6D
 >$8C66  0A                         LOADL_quick   ; inline operand = 10
  $8C67  D1                         DEC
 >$8C68  2A                         STORE_quick   ; inline operand = 10
  $8C69  0A                         LOADL_quick   ; inline operand = 10
  $8C6A  D7 52 8C                   JUMPT_abs              $8C52
 >$8C6D  0B                         LOADL_quick   ; inline operand = 11
  $8C6E  D7 74 8C                   JUMPT_abs              $8C74
  $8C71  AC 62 D9                   CALL_abs               $D962 (set_6da1_bit7) {bytecode}
 >$8C74  CF                         RETURN

; ============================================================
; sub $8C75   (frame_off=-12, body @ $8C7A)
; ============================================================
  $8C7A  40                         LOADL_qimm   ; inline operand = 0
  $8C7B  27                         STORE_quick   ; inline operand = 7
  $8C7C  40                         LOADL_qimm   ; inline operand = 0
  $8C7D  28                         STORE_quick   ; inline operand = 8
  $8C7E  0C                         LOADL_quick   ; inline operand = 12
  $8C7F  52                         LOADR_qimm   ; inline operand = 2
  $8C80  C6                         UCMPLT
  $8C81  D8 8C 8C                   JUMPF_abs              $8C8C
  $8C84  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8C87  E9 1B E2 02                CALL_abs_imm1          $E21B (install_new_daimyo) {bytecode}, $02
  $8C8B  CF                         RETURN
 >$8C8C  40                         LOADL_qimm   ; inline operand = 0
  $8C8D  2B                         STORE_quick   ; inline operand = 11
  $8C8E  8A 4F 6F                   LOADL_imm2             $6F4F
  $8C91  29                         STORE_quick   ; inline operand = 9
  $8C92  D6 36 8D                   JUMP_abs               $8D36
 >$8C95  09                         LOADL_quick   ; inline operand = 9
  $8C96  D3                         BYTE_DEREF
  $8C97  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $8C9A  AC E6 8B                   CALL_abs               $8BE6 {bytecode}
  $8C9D  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $8CA0  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $8CA3  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $8CA7  D8 0A 8D                   JUMPF_abs              $8D0A
  $8CAA  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $8CAD  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $8CB0  BB                         ADD
  $8CB1  D3                         BYTE_DEREF
  $8CB2  D7 22 8D                   JUMPT_abs              $8D22
  $8CB5  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8CB8  8B 1A                      BYTE_LOADR_imm1        +26
  $8CBA  B5                         MULT
  $8CBB  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8CBE  BB                         ADD
  $8CBF  B0                         DEREF
  $8CC0  50                         LOADR_qimm   ; inline operand = 0
  $8CC1  C4                         SCMPGT
  $8CC2  D8 22 8D                   JUMPF_abs              $8D22
  $8CC5  8D 1C                      BYTE_PUSH_imm1         +28
  $8CC7  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $8CCB  8E 5E BA                   PUSH_imm2              $BA5E
  $8CCE  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8CD2  09                         LOADL_quick   ; inline operand = 9
  $8CD3  D3                         BYTE_DEREF
  $8CD4  B3                         PUSHL
  $8CD5  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $8CD9  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8CDC  D0                         INC
  $8CDD  B3                         PUSHL
  $8CDE  8E 5F BA                   PUSH_imm2              $BA5F
  $8CE1  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8CE5  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $8CE8  D8 22 8D                   JUMPF_abs              $8D22
  $8CEB  8E 83 BA                   PUSH_imm2              $BA83
  $8CEE  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8CF2  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8CF5  8B 1A                      BYTE_LOADR_imm1        +26
  $8CF7  B5                         MULT
  $8CF8  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8CFB  BB                         ADD
  $8CFC  B0                         DEREF
  $8CFD  B3                         PUSHL
  $8CFE  61                         PUSH_qimm   ; inline operand = 1
  $8CFF  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $8D03  28                         STORE_quick   ; inline operand = 8
  $8D04  AC 89 CC                   CALL_abs               $CC89 (ui_helper_cc89) {bytecode}
  $8D07  D6 22 8D                   JUMP_abs               $8D22
 >$8D0A  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8D0D  8B 1A                      BYTE_LOADR_imm1        +26
  $8D0F  B5                         MULT
  $8D10  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8D13  BB                         ADD
  $8D14  B0                         DEREF
  $8D15  26                         STORE_quick   ; inline operand = 6
  $8D16  06                         LOADL_quick   ; inline operand = 6
  $8D17  18                         LOADR_quick   ; inline operand = 8
  $8D18  C4                         SCMPGT
  $8D19  D8 22 8D                   JUMPF_abs              $8D22
  $8D1C  36                         PUSH_quick   ; inline operand = 6
  $8D1D  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8D21  28                         STORE_quick   ; inline operand = 8
 >$8D22  07                         LOADL_quick   ; inline operand = 7
  $8D23  18                         LOADR_quick   ; inline operand = 8
  $8D24  C2                         SCMPLT
  $8D25  D8 2E 8D                   JUMPF_abs              $8D2E
  $8D28  08                         LOADL_quick   ; inline operand = 8
  $8D29  27                         STORE_quick   ; inline operand = 7
  $8D2A  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8D2D  2A                         STORE_quick   ; inline operand = 10
 >$8D2E  09                         LOADL_quick   ; inline operand = 9
  $8D2F  D0                         INC
  $8D30  29                         STORE_quick   ; inline operand = 9
  $8D31  D1                         DEC
  $8D32  0B                         LOADL_quick   ; inline operand = 11
  $8D33  D0                         INC
  $8D34  2B                         STORE_quick   ; inline operand = 11
  $8D35  D1                         DEC
 >$8D36  09                         LOADL_quick   ; inline operand = 9
  $8D37  D3                         BYTE_DEREF
  $8D38  8C FF 00                   LOADR_imm2             $00FF
  $8D3B  C1                         CMPNE
  $8D3C  D7 95 8C                   JUMPT_abs              $8C95
  $8D3F  07                         LOADL_quick   ; inline operand = 7
  $8D40  D7 4D 8D                   JUMPT_abs              $8D4D (effect_bribe)
  $8D43  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8D46  E9 1B E2 02                CALL_abs_imm1          $E21B (install_new_daimyo) {bytecode}, $02
  $8D4A  D6 E0 8D                   JUMP_abs               $8DE0
 >$8D4D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8D50  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $8D53  BB                         ADD
  $8D54  B3                         PUSHL
  $8D55  3A                         PUSH_quick   ; inline operand = 10
  $8D56  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $8D5A  D8 61 8D                   JUMPF_abs              $8D61
  $8D5D  45                         LOADL_qimm   ; inline operand = 5
  $8D5E  D6 62 8D                   JUMP_abs               $8D62
 >$8D61  40                         LOADL_qimm   ; inline operand = 0
 >$8D62  D4                         BYTE_POPSTORE
  $8D63  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8D66  8C A2 6D                   LOADR_imm2             $6DA2
  $8D69  BB                         ADD
  $8D6A  B3                         PUSHL
  $8D6B  40                         LOADL_qimm   ; inline operand = 0
  $8D6C  D4                         BYTE_POPSTORE
  $8D6D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8D70  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $8D73  BB                         ADD
  $8D74  B3                         PUSHL
  $8D75  3A                         PUSH_quick   ; inline operand = 10
  $8D76  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $8D7A  D4                         BYTE_POPSTORE
  $8D7B  38                         PUSH_quick   ; inline operand = 8
  $8D7C  0A                         LOADL_quick   ; inline operand = 10
  $8D7D  8B 1A                      BYTE_LOADR_imm1        +26
  $8D7F  B5                         MULT
  $8D80  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8D83  BB                         ADD
  $8D84  B4                         POPR
  $8D85  B3                         PUSHL
  $8D86  B0                         DEREF
  $8D87  BC                         SUB
  $8D88  B1                         POPSTORE
  $8D89  3A                         PUSH_quick   ; inline operand = 10
  $8D8A  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $8D8E  D8 AC 8D                   JUMPF_abs              $8DAC
  $8D91  8E 8C BA                   PUSH_imm2              $BA8C
  $8D94  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8D98  3A                         PUSH_quick   ; inline operand = 10
  $8D99  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $8D9D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8DA0  D0                         INC
  $8DA1  B3                         PUSHL
  $8DA2  8E 8D BA                   PUSH_imm2              $BA8D
  $8DA5  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8DA9  D6 D6 8D                   JUMP_abs               $8DD6
 >$8DAC  8E A1 BA                   PUSH_imm2              $BAA1
  $8DAF  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8DB3  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8DB6  D0                         INC
  $8DB7  B3                         PUSHL
  $8DB8  8E A7 BA                   PUSH_imm2              $BAA7
  $8DBB  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8DBF  3A                         PUSH_quick   ; inline operand = 10
  $8DC0  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $8DC4  59                         LOADR_qimm   ; inline operand = 9
  $8DC5  B5                         MULT
  $8DC6  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8DC9  BB                         ADD
  $8DCA  B3                         PUSHL
  $8DCB  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8DCF  8E B3 BA                   PUSH_imm2              $BAB3
  $8DD2  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$8DD6  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8DD9  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
  $8DDD  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$8DE0  CF                         RETURN

; ============================================================
; sub $8DE1   (frame_off=-14, body @ $8DE6)
; ============================================================
  $8DE6  0C                         LOADL_quick   ; inline operand = 12
  $8DE7  D0                         INC
  $8DE8  2C                         STORE_quick   ; inline operand = 12
  $8DE9  D1                         DEC
  $8DEA  D3                         BYTE_DEREF
  $8DEB  A2 F2 FF                   BYTE_STORE_far         $FFF2
  $8DEE  41                         LOADL_qimm   ; inline operand = 1
  $8DEF  2A                         STORE_quick   ; inline operand = 10
  $8DF0  D6 33 8E                   JUMP_abs               $8E33
 >$8DF3  40                         LOADL_qimm   ; inline operand = 0
  $8DF4  29                         STORE_quick   ; inline operand = 9
  $8DF5  40                         LOADL_qimm   ; inline operand = 0
  $8DF6  D6 17 8E                   JUMP_abs               $8E17
 >$8DF9  0C                         LOADL_quick   ; inline operand = 12
  $8DFA  D3                         BYTE_DEREF
  $8DFB  B3                         PUSHL
  $8DFC  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $8E00  B3                         PUSHL
  $8E01  DE F2 FF                   LEAL_far               $FFF2
  $8E04  B3                         PUSHL
  $8E05  0B                         LOADL_quick   ; inline operand = 11
  $8E06  B4                         POPR
  $8E07  BB                         ADD
  $8E08  D3                         BYTE_DEREF
  $8E09  B3                         PUSHL
  $8E0A  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $8E0E  B4                         POPR
  $8E0F  C0                         CMPEQ
  $8E10  D8 15 8E                   JUMPF_abs              $8E15
  $8E13  41                         LOADL_qimm   ; inline operand = 1
  $8E14  29                         STORE_quick   ; inline operand = 9
 >$8E15  0B                         LOADL_quick   ; inline operand = 11
  $8E16  D0                         INC
 >$8E17  2B                         STORE_quick   ; inline operand = 11
  $8E18  0B                         LOADL_quick   ; inline operand = 11
  $8E19  1A                         LOADR_quick   ; inline operand = 10
  $8E1A  C6                         UCMPLT
  $8E1B  D7 F9 8D                   JUMPT_abs              $8DF9
  $8E1E  09                         LOADL_quick   ; inline operand = 9
  $8E1F  D7 30 8E                   JUMPT_abs              $8E30
  $8E22  DE F2 FF                   LEAL_far               $FFF2
  $8E25  B3                         PUSHL
  $8E26  0A                         LOADL_quick   ; inline operand = 10
  $8E27  D0                         INC
  $8E28  2A                         STORE_quick   ; inline operand = 10
  $8E29  D1                         DEC
  $8E2A  B4                         POPR
  $8E2B  BB                         ADD
  $8E2C  B3                         PUSHL
  $8E2D  0C                         LOADL_quick   ; inline operand = 12
  $8E2E  D3                         BYTE_DEREF
  $8E2F  D4                         BYTE_POPSTORE
 >$8E30  0C                         LOADL_quick   ; inline operand = 12
  $8E31  D0                         INC
  $8E32  2C                         STORE_quick   ; inline operand = 12
 >$8E33  0C                         LOADL_quick   ; inline operand = 12
  $8E34  D3                         BYTE_DEREF
  $8E35  8C FF 00                   LOADR_imm2             $00FF
  $8E38  C1                         CMPNE
  $8E39  D7 F3 8D                   JUMPT_abs              $8DF3
  $8E3C  40                         LOADL_qimm   ; inline operand = 0
  $8E3D  D6 51 8E                   JUMP_abs               $8E51
 >$8E40  0B                         LOADL_quick   ; inline operand = 11
  $8E41  8C 4F 6F                   LOADR_imm2             $6F4F
  $8E44  BB                         ADD
  $8E45  B3                         PUSHL
  $8E46  DE F2 FF                   LEAL_far               $FFF2
  $8E49  B3                         PUSHL
  $8E4A  0B                         LOADL_quick   ; inline operand = 11
  $8E4B  B4                         POPR
  $8E4C  BB                         ADD
  $8E4D  D3                         BYTE_DEREF
  $8E4E  D4                         BYTE_POPSTORE
  $8E4F  0B                         LOADL_quick   ; inline operand = 11
  $8E50  D0                         INC
 >$8E51  2B                         STORE_quick   ; inline operand = 11
  $8E52  0B                         LOADL_quick   ; inline operand = 11
  $8E53  1A                         LOADR_quick   ; inline operand = 10
  $8E54  C6                         UCMPLT
  $8E55  D7 40 8E                   JUMPT_abs              $8E40
  $8E58  0B                         LOADL_quick   ; inline operand = 11
  $8E59  8C 4F 6F                   LOADR_imm2             $6F4F
  $8E5C  BB                         ADD
  $8E5D  B3                         PUSHL
  $8E5E  89 FF                      BYTE_LOADL_imm1        -1
  $8E60  D4                         BYTE_POPSTORE
  $8E61  0A                         LOADL_quick   ; inline operand = 10
  $8E62  CF                         RETURN

; ============================================================
; sub $8E63   (frame_off=-2, body @ $8E68)
; ============================================================
  $8E68  40                         LOADL_qimm   ; inline operand = 0
  $8E69  D6 8F 8E                   JUMP_abs               $8E8F
 >$8E6C  3B                         PUSH_quick   ; inline operand = 11
  $8E6D  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $8E71  D8 8D 8E                   JUMPF_abs              $8E8D
  $8E74  0B                         LOADL_quick   ; inline operand = 11
  $8E75  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $8E78  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8E7B  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $8E7E  AC D7 DA                   CALL_abs               $DAD7 (combat_helper_dad7) {bytecode}
  $8E81  8E 4F 6F                   PUSH_imm2              $6F4F
  $8E84  E9 E1 8D 02                CALL_abs_imm1          $8DE1 (dedup_owners_to_6F4F) {bytecode}, $02
  $8E88  B3                         PUSHL
  $8E89  E9 75 8C 02                CALL_abs_imm1          $8C75 {bytecode}, $02
 >$8E8D  0B                         LOADL_quick   ; inline operand = 11
  $8E8E  D0                         INC
 >$8E8F  2B                         STORE_quick   ; inline operand = 11
  $8E90  0B                         LOADL_quick   ; inline operand = 11
  $8E91  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $8E94  C6                         UCMPLT
  $8E95  D7 6C 8E                   JUMPT_abs              $8E6C
  $8E98  CF                         RETURN

; ============================================================
; sub $8E99   (frame_off=+0, body @ $8E9E)
; ============================================================
  $8E9E  0D                         LOADL_quick   ; inline operand = 13
  $8E9F  D2                         LSHIFT1
  $8EA0  8C 67 6F                   LOADR_imm2             $6F67
  $8EA3  BB                         ADD
  $8EA4  B3                         PUSHL
  $8EA5  0C                         LOADL_quick   ; inline operand = 12
  $8EA6  D4                         BYTE_POPSTORE
  $8EA7  0D                         LOADL_quick   ; inline operand = 13
  $8EA8  D2                         LSHIFT1
  $8EA9  8C 68 6F                   LOADR_imm2             $6F68
  $8EAC  BB                         ADD
  $8EAD  B3                         PUSHL
  $8EAE  0E                         LOADL_quick   ; inline operand = 14
  $8EAF  D4                         BYTE_POPSTORE
  $8EB0  0D                         LOADL_quick   ; inline operand = 13
  $8EB1  D0                         INC
  $8EB2  D2                         LSHIFT1
  $8EB3  8C 67 6F                   LOADR_imm2             $6F67
  $8EB6  BB                         ADD
  $8EB7  B3                         PUSHL
  $8EB8  89 FF                      BYTE_LOADL_imm1        -1
  $8EBA  D4                         BYTE_POPSTORE
  $8EBB  CF                         RETURN

; ============================================================
; sub $8EBC   (frame_off=+0, body @ $8EC1)
; ============================================================
  $8EC1  0C                         LOADL_quick   ; inline operand = 12
  $8EC2  1D                         LOADR_quick   ; inline operand = 13
  $8EC3  C0                         CMPEQ
  $8EC4  D8 CF 8E                   JUMPF_abs              $8ECF
  $8EC7  62                         PUSH_qimm   ; inline operand = 2
  $8EC8  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8ECC  50                         LOADR_qimm   ; inline operand = 0
  $8ECD  C0                         CMPEQ
  $8ECE  CF                         RETURN
 >$8ECF  0D                         LOADL_quick   ; inline operand = 13
  $8ED0  1C                         LOADR_quick   ; inline operand = 12
  $8ED1  C2                         SCMPLT
  $8ED2  CF                         RETURN

; ============================================================
; sub $8ED3   (frame_off=-6, body @ $8ED8)
; ============================================================
  $8ED8  3E                         PUSH_quick   ; inline operand = 14
  $8ED9  E9 78 DE 02                CALL_abs_imm1          $DE78 (select_message_string_de78) {bytecode}, $02
  $8EDD  2B                         STORE_quick   ; inline operand = 11
  $8EDE  3E                         PUSH_quick   ; inline operand = 14
  $8EDF  E9 9D 8B 02                CALL_abs_imm1          $8B9D {bytecode}, $02
  $8EE3  2A                         STORE_quick   ; inline operand = 10
  $8EE4  8E C0 BA                   PUSH_imm2              $BAC0
  $8EE7  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8EEB  3B                         PUSH_quick   ; inline operand = 11
  $8EEC  0E                         LOADL_quick   ; inline operand = 14
  $8EED  D0                         INC
  $8EEE  B3                         PUSHL
  $8EEF  8E C9 BA                   PUSH_imm2              $BAC9
  $8EF2  E9 34 D1 06                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $06
  $8EF6  3C                         PUSH_quick   ; inline operand = 12
  $8EF7  3A                         PUSH_quick   ; inline operand = 10
  $8EF8  3D                         PUSH_quick   ; inline operand = 13
  $8EF9  8E CF BA                   PUSH_imm2              $BACF
  $8EFC  E9 34 D1 08                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $08
  $8F00  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $8F03  3D                         PUSH_quick   ; inline operand = 13
  $8F04  3C                         PUSH_quick   ; inline operand = 12
  $8F05  E9 BC 8E 04                CALL_abs_imm1          $8EBC {bytecode}, $04
  $8F09  CF                         RETURN

; ============================================================
; sub $8F0A   (frame_off=-14, body @ $8F0F)
; ============================================================
  $8F0F  3C                         PUSH_quick   ; inline operand = 12
  $8F10  E9 78 DE 02                CALL_abs_imm1          $DE78 (select_message_string_de78) {bytecode}, $02
  $8F14  2A                         STORE_quick   ; inline operand = 10
  $8F15  8D 1E                      BYTE_PUSH_imm1         +30
  $8F17  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $8F1B  0C                         LOADL_quick   ; inline operand = 12
  $8F1C  8B 1A                      BYTE_LOADR_imm1        +26
  $8F1E  B5                         MULT
  $8F1F  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8F22  BB                         ADD
  $8F23  2B                         STORE_quick   ; inline operand = 11
  $8F24  8D 14                      BYTE_PUSH_imm1         +20
  $8F26  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8F2A  B3                         PUSHL
  $8F2B  0B                         LOADL_quick   ; inline operand = 11
  $8F2C  7E                         ADD_qimm   ; inline operand = 14
  $8F2D  B0                         DEREF
  $8F2E  B3                         PUSHL
  $8F2F  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $8F33  B3                         PUSHL
  $8F34  0B                         LOADL_quick   ; inline operand = 11
  $8F35  78                         ADD_qimm   ; inline operand = 8
  $8F36  B0                         DEREF
  $8F37  B3                         PUSHL
  $8F38  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $8F3C  B4                         POPR
  $8F3D  BB                         ADD
  $8F3E  B4                         POPR
  $8F3F  BB                         ADD
  $8F40  7A                         ADD_qimm   ; inline operand = 10
  $8F41  29                         STORE_quick   ; inline operand = 9
  $8F42  0B                         LOADL_quick   ; inline operand = 11
  $8F43  8F 10                      BYTE_ADD_imm1          +16
  $8F45  B0                         DEREF
  $8F46  28                         STORE_quick   ; inline operand = 8
  $8F47  3C                         PUSH_quick   ; inline operand = 12
  $8F48  38                         PUSH_quick   ; inline operand = 8
  $8F49  39                         PUSH_quick   ; inline operand = 9
  $8F4A  E9 D3 8E 06                CALL_abs_imm1          $8ED3 {bytecode}, $06
  $8F4E  D8 96 8F                   JUMPF_abs              $8F96
  $8F51  8E FD BA                   PUSH_imm2              $BAFD
  $8F54  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8F58  3A                         PUSH_quick   ; inline operand = 10
  $8F59  8E FE BA                   PUSH_imm2              $BAFE
  $8F5C  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $8F60  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $8F63  0C                         LOADL_quick   ; inline operand = 12
  $8F64  8C A2 6D                   LOADR_imm2             $6DA2
  $8F67  BB                         ADD
  $8F68  D3                         BYTE_DEREF
  $8F69  D8 8E 8F                   JUMPF_abs              $8F8E
  $8F6C  3C                         PUSH_quick   ; inline operand = 12
  $8F6D  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $8F71  25                         STORE_quick   ; inline operand = 5
  $8F72  3C                         PUSH_quick   ; inline operand = 12
  $8F73  E9 75 E2 02                CALL_abs_imm1          $E275 (prompt_helper_e275) {bytecode}, $02
  $8F77  35                         PUSH_quick   ; inline operand = 5
  $8F78  E9 0E DC 02                CALL_abs_imm1          $DC0E (list_op_6e4a) {bytecode}, $02
  $8F7C  35                         PUSH_quick   ; inline operand = 5
  $8F7D  E9 3C DC 02                CALL_abs_imm1          $DC3C (list_remove_6e7f) {bytecode}, $02
  $8F81  3C                         PUSH_quick   ; inline operand = 12
  $8F82  E9 25 E4 02                CALL_abs_imm1          $E425 (find_fiefs_of_owner) {bytecode}, $02
  $8F86  3C                         PUSH_quick   ; inline operand = 12
  $8F87  E9 1B E2 02                CALL_abs_imm1          $E21B (install_new_daimyo) {bytecode}, $02
  $8F8B  D6 D2 8F                   JUMP_abs               $8FD2
 >$8F8E  3C                         PUSH_quick   ; inline operand = 12
  $8F8F  E9 54 E4 02                CALL_abs_imm1          $E454 (neutralize_fief) {bytecode}, $02
  $8F93  D6 D2 8F                   JUMP_abs               $8FD2
 >$8F96  8E 0B BB                   PUSH_imm2              $BB0B
  $8F99  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8F9D  8D 32                      BYTE_PUSH_imm1         +50
  $8F9F  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8FA3  7A                         ADD_qimm   ; inline operand = 10
  $8FA4  B3                         PUSHL
  $8FA5  0B                         LOADL_quick   ; inline operand = 11
  $8FA6  8F 10                      BYTE_ADD_imm1          +16
  $8FA8  B0                         DEREF
  $8FA9  B3                         PUSHL
  $8FAA  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8FAE  B3                         PUSHL
  $8FAF  0B                         LOADL_quick   ; inline operand = 11
  $8FB0  8F 10                      BYTE_ADD_imm1          +16
  $8FB2  B4                         POPR
  $8FB3  B3                         PUSHL
  $8FB4  B0                         DEREF
  $8FB5  BC                         SUB
  $8FB6  B1                         POPSTORE
  $8FB7  8D 32                      BYTE_PUSH_imm1         +50
  $8FB9  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8FBD  7A                         ADD_qimm   ; inline operand = 10
  $8FBE  B3                         PUSHL
  $8FBF  0B                         LOADL_quick   ; inline operand = 11
  $8FC0  78                         ADD_qimm   ; inline operand = 8
  $8FC1  B0                         DEREF
  $8FC2  B3                         PUSHL
  $8FC3  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8FC7  B3                         PUSHL
  $8FC8  0B                         LOADL_quick   ; inline operand = 11
  $8FC9  78                         ADD_qimm   ; inline operand = 8
  $8FCA  B4                         POPR
  $8FCB  B3                         PUSHL
  $8FCC  B0                         DEREF
  $8FCD  BC                         SUB
  $8FCE  B1                         POPSTORE
  $8FCF  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$8FD2  CF                         RETURN

; ============================================================
; sub $8FD3   (frame_off=+0, body @ $8FD8)
; ============================================================
  $8FD8  60                         PUSH_qimm   ; inline operand = 0
  $8FD9  3D                         PUSH_quick   ; inline operand = 13
  $8FDA  3C                         PUSH_quick   ; inline operand = 12
  $8FDB  E9 99 8E 06                CALL_abs_imm1          $8E99 {bytecode}, $06
  $8FDF  CF                         RETURN

; ============================================================
; sub $8FE0   (frame_off=+0, body @ $8FE5)
; ============================================================
  $8FE5  0D                         LOADL_quick   ; inline operand = 13
  $8FE6  8B 19                      BYTE_LOADR_imm1        +25
  $8FE8  C4                         SCMPGT
  $8FE9  D8 F6 8F                   JUMPF_abs              $8FF6
  $8FEC  0D                         LOADL_quick   ; inline operand = 13
  $8FED  1C                         LOADR_quick   ; inline operand = 12
  $8FEE  BC                         SUB
  $8FEF  55                         LOADR_qimm   ; inline operand = 5
  $8FF0  C4                         SCMPGT
  $8FF1  D8 F6 8F                   JUMPF_abs              $8FF6
  $8FF4  41                         LOADL_qimm   ; inline operand = 1
  $8FF5  CF                         RETURN
 >$8FF6  40                         LOADL_qimm   ; inline operand = 0
  $8FF7  CF                         RETURN

; ============================================================
; sub $8FF8   (frame_off=-14, body @ $8FFD)
; ============================================================
  $8FFD  8A AD 7B                   LOADL_imm2             $7BAD
  $9000  2B                         STORE_quick   ; inline operand = 11
  $9001  40                         LOADL_qimm   ; inline operand = 0
  $9002  29                         STORE_quick   ; inline operand = 9
  $9003  D6 B6 90                   JUMP_abs               $90B6
 >$9006  AC 1E 8C                   CALL_abs               $8C1E {bytecode}
  $9009  D8 97 90                   JUMPF_abs              $9097
  $900C  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $900F  8B 1A                      BYTE_LOADR_imm1        +26
  $9011  B5                         MULT
  $9012  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9015  BB                         ADD
  $9016  25                         STORE_quick   ; inline operand = 5
  $9017  28                         STORE_quick   ; inline operand = 8
  $9018  05                         LOADL_quick   ; inline operand = 5
  $9019  7C                         ADD_qimm   ; inline operand = 12
  $901A  27                         STORE_quick   ; inline operand = 7
  $901B  07                         LOADL_quick   ; inline operand = 7
  $901C  B0                         DEREF
  $901D  26                         STORE_quick   ; inline operand = 6
  $901E  08                         LOADL_quick   ; inline operand = 8
  $901F  B0                         DEREF
  $9020  D8 8A 90                   JUMPF_abs              $908A
  $9023  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $9026  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $9029  BB                         ADD
  $902A  D3                         BYTE_DEREF
  $902B  D7 8A 90                   JUMPT_abs              $908A
  $902E  8E 26 BB                   PUSH_imm2              $BB26
  $9031  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9035  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9038  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $903C  8E 27 BB                   PUSH_imm2              $BB27
  $903F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9043  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $9046  D8 8A 90                   JUMPF_abs              $908A
  $9049  05                         LOADL_quick   ; inline operand = 5
  $904A  B0                         DEREF
  $904B  B3                         PUSHL
  $904C  35                         PUSH_quick   ; inline operand = 5
  $904D  E9 40 D9 04                CALL_abs_imm1          $D940 (record_apply_two_grows) {bytecode}, $04
  $9051  35                         PUSH_quick   ; inline operand = 5
  $9052  40                         LOADL_qimm   ; inline operand = 0
  $9053  B1                         POPSTORE
  $9054  8E 62 BB                   PUSH_imm2              $BB62
  $9057  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $905B  07                         LOADL_quick   ; inline operand = 7
  $905C  B0                         DEREF
  $905D  B3                         PUSHL
  $905E  36                         PUSH_quick   ; inline operand = 6
  $905F  E9 E0 8F 04                CALL_abs_imm1          $8FE0 {bytecode}, $04
  $9063  D7 7D 90                   JUMPT_abs              $907D
  $9066  8E 74 BB                   PUSH_imm2              $BB74
  $9069  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $906D  AC 59 D7                   CALL_abs               $D759 (ui_helper_d759) {bytecode}
  $9070  09                         LOADL_quick   ; inline operand = 9
  $9071  D0                         INC
  $9072  29                         STORE_quick   ; inline operand = 9
  $9073  D1                         DEC
  $9074  B3                         PUSHL
  $9075  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9078  E9 D3 8F 04                CALL_abs_imm1          $8FD3 {bytecode}, $04
  $907C  CF                         RETURN
 >$907D  8E 84 BB                   PUSH_imm2              $BB84
  $9080  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9084  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9087  D6 B6 90                   JUMP_abs               $90B6
 >$908A  09                         LOADL_quick   ; inline operand = 9
  $908B  D0                         INC
  $908C  29                         STORE_quick   ; inline operand = 9
  $908D  D1                         DEC
  $908E  B3                         PUSHL
  $908F  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9092  E9 D3 8F 04                CALL_abs_imm1          $8FD3 {bytecode}, $04
  $9096  CF                         RETURN
 >$9097  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $909A  E9 0A 8F 02                CALL_abs_imm1          $8F0A {bytecode}, $02
  $909E  8D 1E                      BYTE_PUSH_imm1         +30
  $90A0  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $90A4  8F 32                      BYTE_ADD_imm1          +50
  $90A6  B3                         PUSHL
  $90A7  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $90AA  8B 1A                      BYTE_LOADR_imm1        +26
  $90AC  B5                         MULT
  $90AD  8C 0D 70                   LOADR_imm2             $700D
  $90B0  BB                         ADD
  $90B1  B4                         POPR
  $90B2  B3                         PUSHL
  $90B3  B0                         DEREF
  $90B4  BB                         ADD
  $90B5  B1                         POPSTORE
 >$90B6  0B                         LOADL_quick   ; inline operand = 11
  $90B7  D0                         INC
  $90B8  2B                         STORE_quick   ; inline operand = 11
  $90B9  D1                         DEC
  $90BA  D3                         BYTE_DEREF
  $90BB  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $90BE  8C FF 00                   LOADR_imm2             $00FF
  $90C1  C1                         CMPNE
  $90C2  D7 06 90                   JUMPT_abs              $9006
  $90C5  CF                         RETURN

; ============================================================
; sub $90C6   (frame_off=+0, body @ $90CB)
; ============================================================
  $90CB  0C                         LOADL_quick   ; inline operand = 12
  $90CC  D3                         BYTE_DEREF
  $90CD  8B 64                      BYTE_LOADR_imm1        +100
  $90CF  C5                         SCMPGE
  $90D0  D8 D6 90                   JUMPF_abs              $90D6
  $90D3  3C                         PUSH_quick   ; inline operand = 12
  $90D4  40                         LOADL_qimm   ; inline operand = 0
  $90D5  D4                         BYTE_POPSTORE
 >$90D6  CF                         RETURN

; ============================================================
; sub $90D7   (frame_off=+0, body @ $90DC)
; ============================================================
  $90DC  3D                         PUSH_quick   ; inline operand = 13
  $90DD  3C                         PUSH_quick   ; inline operand = 12
  $90DE  E9 12 CA 04                CALL_abs_imm1          $CA12 (byte_helper_ca12) {bytecode}, $04
  $90E2  3C                         PUSH_quick   ; inline operand = 12
  $90E3  E9 C6 90 02                CALL_abs_imm1          $90C6 {bytecode}, $02
  $90E7  CF                         RETURN

; ============================================================
; sub $90E8   (frame_off=-4, body @ $90ED)
; ============================================================
  $90ED  40                         LOADL_qimm   ; inline operand = 0
  $90EE  D6 14 91                   JUMP_abs               $9114
 >$90F1  40                         LOADL_qimm   ; inline operand = 0
  $90F2  D6 09 91                   JUMP_abs               $9109
 >$90F5  0B                         LOADL_quick   ; inline operand = 11
  $90F6  1A                         LOADR_quick   ; inline operand = 10
  $90F7  C6                         UCMPLT
  $90F8  D8 07 91                   JUMPF_abs              $9107
  $90FB  3C                         PUSH_quick   ; inline operand = 12
  $90FC  3A                         PUSH_quick   ; inline operand = 10
  $90FD  3B                         PUSH_quick   ; inline operand = 11
  $90FE  E9 35 8C 04                CALL_abs_imm1          $8C35 {bytecode}, $04
  $9102  B3                         PUSHL
  $9103  E9 D7 90 04                CALL_abs_imm1          $90D7 {bytecode}, $04
 >$9107  0A                         LOADL_quick   ; inline operand = 10
  $9108  D0                         INC
 >$9109  2A                         STORE_quick   ; inline operand = 10
  $910A  0A                         LOADL_quick   ; inline operand = 10
  $910B  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $910E  C6                         UCMPLT
  $910F  D7 F5 90                   JUMPT_abs              $90F5
  $9112  0B                         LOADL_quick   ; inline operand = 11
  $9113  D0                         INC
 >$9114  2B                         STORE_quick   ; inline operand = 11
  $9115  0B                         LOADL_quick   ; inline operand = 11
  $9116  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9119  C6                         UCMPLT
  $911A  D7 F1 90                   JUMPT_abs              $90F1
  $911D  CF                         RETURN

; ============================================================
; sub $911E   (frame_off=-4, body @ $9123)
; ============================================================
  $9123  40                         LOADL_qimm   ; inline operand = 0
  $9124  D6 4A 91                   JUMP_abs               $914A
 >$9127  40                         LOADL_qimm   ; inline operand = 0
  $9128  D6 3F 91                   JUMP_abs               $913F
 >$912B  0B                         LOADL_quick   ; inline operand = 11
  $912C  1A                         LOADR_quick   ; inline operand = 10
  $912D  C6                         UCMPLT
  $912E  D8 3D 91                   JUMPF_abs              $913D
  $9131  3C                         PUSH_quick   ; inline operand = 12
  $9132  3B                         PUSH_quick   ; inline operand = 11
  $9133  3A                         PUSH_quick   ; inline operand = 10
  $9134  E9 35 8C 04                CALL_abs_imm1          $8C35 {bytecode}, $04
  $9138  B3                         PUSHL
  $9139  E9 D7 90 04                CALL_abs_imm1          $90D7 {bytecode}, $04
 >$913D  0A                         LOADL_quick   ; inline operand = 10
  $913E  D0                         INC
 >$913F  2A                         STORE_quick   ; inline operand = 10
  $9140  0A                         LOADL_quick   ; inline operand = 10
  $9141  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9144  C6                         UCMPLT
  $9145  D7 2B 91                   JUMPT_abs              $912B
  $9148  0B                         LOADL_quick   ; inline operand = 11
  $9149  D0                         INC
 >$914A  2B                         STORE_quick   ; inline operand = 11
  $914B  0B                         LOADL_quick   ; inline operand = 11
  $914C  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $914F  C6                         UCMPLT
  $9150  D7 27 91                   JUMPT_abs              $9127
  $9153  CF                         RETURN

; ============================================================
; sub $9154   (frame_off=-2, body @ $9159)
; ============================================================
  $9159  3C                         PUSH_quick   ; inline operand = 12
  $915A  E9 CD D7 02                CALL_abs_imm1          $D7CD (daimyo_record_addr) {bytecode}, $02
  $915E  2B                         STORE_quick   ; inline operand = 11
  $915F  0B                         LOADL_quick   ; inline operand = 11
  $9160  D0                         INC
  $9161  D3                         BYTE_DEREF
  $9162  D7 67 91                   JUMPT_abs              $9167
  $9165  42                         LOADL_qimm   ; inline operand = 2
  $9166  CF                         RETURN
 >$9167  0B                         LOADL_quick   ; inline operand = 11
  $9168  D3                         BYTE_DEREF
  $9169  8B 46                      BYTE_LOADR_imm1        +70
  $916B  C2                         SCMPLT
  $916C  D8 71 91                   JUMPF_abs              $9171
  $916F  40                         LOADL_qimm   ; inline operand = 0
  $9170  CF                         RETURN
 >$9171  0B                         LOADL_quick   ; inline operand = 11
  $9172  D0                         INC
  $9173  D3                         BYTE_DEREF
  $9174  54                         LOADR_qimm   ; inline operand = 4
  $9175  B6                         SDIV
  $9176  B3                         PUSHL
  $9177  0B                         LOADL_quick   ; inline operand = 11
  $9178  D3                         BYTE_DEREF
  $9179  8F F6                      BYTE_ADD_imm1          -10
  $917B  B4                         POPR
  $917C  BC                         SUB
  $917D  B3                         PUSHL
  $917E  8E 2C 01                   PUSH_imm2              $012C
  $9181  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9185  B4                         POPR
  $9186  C2                         SCMPLT
  $9187  D8 92 91                   JUMPF_abs              $9192
  $918A  0C                         LOADL_quick   ; inline operand = 12
  $918B  8C D4 6D                   LOADR_imm2             $6DD4 (daimyo_weakness_flag)
  $918E  BB                         ADD
  $918F  D3                         BYTE_DEREF
  $9190  D0                         INC
  $9191  CF                         RETURN
 >$9192  40                         LOADL_qimm   ; inline operand = 0
  $9193  CF                         RETURN

; ============================================================
; sub $9194   (frame_off=-4, body @ $9199)
; ============================================================
  $9199  0C                         LOADL_quick   ; inline operand = 12
  $919A  8C A2 6D                   LOADR_imm2             $6DA2
  $919D  BB                         ADD
  $919E  D3                         BYTE_DEREF
  $919F  D8 FC 91                   JUMPF_abs              $91FC
  $91A2  3C                         PUSH_quick   ; inline operand = 12
  $91A3  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $91A7  2B                         STORE_quick   ; inline operand = 11
  $91A8  3B                         PUSH_quick   ; inline operand = 11
  $91A9  E9 54 91 02                CALL_abs_imm1          $9154 {bytecode}, $02
  $91AD  2A                         STORE_quick   ; inline operand = 10
  $91AE  D8 FC 91                   JUMPF_abs              $91FC
  $91B1  0A                         LOADL_quick   ; inline operand = 10
  $91B2  51                         LOADR_qimm   ; inline operand = 1
  $91B3  C0                         CMPEQ
  $91B4  D8 BE 91                   JUMPF_abs              $91BE
  $91B7  A4 5F 6D                   LOADL_abs              $6D5F (config_block)
  $91BA  D8 BE 91                   JUMPF_abs              $91BE
  $91BD  CF                         RETURN
 >$91BE  3B                         PUSH_quick   ; inline operand = 11
  $91BF  E9 0E DC 02                CALL_abs_imm1          $DC0E (list_op_6e4a) {bytecode}, $02
  $91C3  3B                         PUSH_quick   ; inline operand = 11
  $91C4  E9 3C DC 02                CALL_abs_imm1          $DC3C (list_remove_6e7f) {bytecode}, $02
  $91C8  3C                         PUSH_quick   ; inline operand = 12
  $91C9  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $91CD  D8 D3 91                   JUMPF_abs              $91D3
  $91D0  AC 35 DB                   CALL_abs               $DB35 (ui_helper_db35) {bytecode}
 >$91D3  0B                         LOADL_quick   ; inline operand = 11
  $91D4  59                         LOADR_qimm   ; inline operand = 9
  $91D5  B5                         MULT
  $91D6  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $91D9  BB                         ADD
  $91DA  B3                         PUSHL
  $91DB  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $91DF  0A                         LOADL_quick   ; inline operand = 10
  $91E0  D1                         DEC
  $91E1  D2                         LSHIFT1
  $91E2  8C A5 BB                   LOADR_imm2             $BBA5
  $91E5  BB                         ADD
  $91E6  B0                         DEREF
  $91E7  B3                         PUSHL
  $91E8  8E BA BB                   PUSH_imm2              $BBBA
  $91EB  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $91EF  3C                         PUSH_quick   ; inline operand = 12
  $91F0  E9 E7 E1 02                CALL_abs_imm1          $E1E7 (clear_fief_pair_6193) {bytecode}, $02
  $91F4  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $91F7  3C                         PUSH_quick   ; inline operand = 12
  $91F8  E9 25 E4 02                CALL_abs_imm1          $E425 (find_fiefs_of_owner) {bytecode}, $02
 >$91FC  CF                         RETURN

; ============================================================
; sub $91FD   (frame_off=+0, body @ $9202)
; ============================================================
  $9202  0C                         LOADL_quick   ; inline operand = 12
  $9203  1D                         LOADR_quick   ; inline operand = 13
  $9204  C4                         SCMPGT
  $9205  D8 0A 92                   JUMPF_abs              $920A
  $9208  0C                         LOADL_quick   ; inline operand = 12
  $9209  CF                         RETURN
 >$920A  0D                         LOADL_quick   ; inline operand = 13
  $920B  1E                         LOADR_quick   ; inline operand = 14
  $920C  C4                         SCMPGT
  $920D  D8 12 92                   JUMPF_abs              $9212
  $9210  0E                         LOADL_quick   ; inline operand = 14
  $9211  CF                         RETURN
 >$9212  0D                         LOADL_quick   ; inline operand = 13
  $9213  CF                         RETURN

; ============================================================
; sub $9214   (frame_off=+0, body @ $9219)
; ============================================================
  $9219  8D 33                      BYTE_PUSH_imm1         +51
  $921B  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $921F  B3                         PUSHL
  $9220  A4 9F 6D                   LOADL_abs              $6D9F
  $9223  90 E8 F9                   ADD_imm2               $F9E8
  $9226  52                         LOADR_qimm   ; inline operand = 2
  $9227  B6                         SDIV
  $9228  72                         ADD_qimm   ; inline operand = 2
  $9229  5A                         LOADR_qimm   ; inline operand = 10
  $922A  B5                         MULT
  $922B  B4                         POPR
  $922C  BB                         ADD
  $922D  CF                         RETURN

; ============================================================
; sub $922E   (frame_off=+0, body @ $9233)
; ============================================================
  $9233  62                         PUSH_qimm   ; inline operand = 2
  $9234  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9238  D8 42 92                   JUMPF_abs              $9242
  $923B  66                         PUSH_qimm   ; inline operand = 6
  $923C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9240  75                         ADD_qimm   ; inline operand = 5
  $9241  CF                         RETURN
 >$9242  6A                         PUSH_qimm   ; inline operand = 10
  $9243  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9247  8F 1E                      BYTE_ADD_imm1          +30
  $9249  CF                         RETURN

; ============================================================
; sub $924A   (frame_off=-4, body @ $924F)
; ============================================================
  $924F  6A                         PUSH_qimm   ; inline operand = 10
  $9250  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9254  D0                         INC
  $9255  A8 0B 6E                   STORE_abs              $6E0B
  $9258  65                         PUSH_qimm   ; inline operand = 5
  $9259  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $925D  D8 76 92                   JUMPF_abs              $9276
  $9260  8D 1E                      BYTE_PUSH_imm1         +30
  $9262  6B                         PUSH_qimm   ; inline operand = 11
  $9263  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9267  A6 0D 6E                   LOADR_abs              $6E0D
  $926A  BB                         ADD
  $926B  8F FB                      BYTE_ADD_imm1          -5
  $926D  B3                         PUSHL
  $926E  6A                         PUSH_qimm   ; inline operand = 10
  $926F  E9 FD 91 06                CALL_abs_imm1          $91FD {bytecode}, $06
  $9273  D6 79 92                   JUMP_abs               $9279
 >$9276  AC 2E 92                   CALL_abs               $922E {bytecode}
 >$9279  A8 0D 6E                   STORE_abs              $6E0D
  $927C  AC 14 92                   CALL_abs               $9214 {bytecode}
  $927F  52                         LOADR_qimm   ; inline operand = 2
  $9280  B6                         SDIV
  $9281  A8 0F 6E                   STORE_abs              $6E0F
  $9284  8D 46                      BYTE_PUSH_imm1         +70
  $9286  AC 14 92                   CALL_abs               $9214 {bytecode}
  $9289  B3                         PUSHL
  $928A  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $928E  A8 11 6E                   STORE_abs              $6E11
  $9291  A4 9F 6D                   LOADL_abs              $6D9F
  $9294  90 E8 F9                   ADD_imm2               $F9E8
  $9297  5A                         LOADR_qimm   ; inline operand = 10
  $9298  B5                         MULT
  $9299  B3                         PUSHL
  $929A  8D 65                      BYTE_PUSH_imm1         +101
  $929C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $92A0  B4                         POPR
  $92A1  BB                         ADD
  $92A2  74                         ADD_qimm   ; inline operand = 4
  $92A3  54                         LOADR_qimm   ; inline operand = 4
  $92A4  B6                         SDIV
  $92A5  A8 13 6E                   STORE_abs              $6E13
  $92A8  CF                         RETURN

; ============================================================
; sub $92A9   (frame_off=+0, body @ $92AE)
; ============================================================
  $92AE  0C                         LOADL_quick   ; inline operand = 12
  $92AF  72                         ADD_qimm   ; inline operand = 2
  $92B0  B0                         DEREF
  $92B1  D7 B6 92                   JUMPT_abs              $92B6
  $92B4  41                         LOADL_qimm   ; inline operand = 1
  $92B5  CF                         RETURN
 >$92B6  0C                         LOADL_quick   ; inline operand = 12
  $92B7  72                         ADD_qimm   ; inline operand = 2
  $92B8  B0                         DEREF
  $92B9  B3                         PUSHL
  $92BA  0C                         LOADL_quick   ; inline operand = 12
  $92BB  B0                         DEREF
  $92BC  B3                         PUSHL
  $92BD  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $92C1  B3                         PUSHL
  $92C2  3D                         PUSH_quick   ; inline operand = 13
  $92C3  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $92C7  2D                         STORE_quick   ; inline operand = 13
  $92C8  3D                         PUSH_quick   ; inline operand = 13
  $92C9  0C                         LOADL_quick   ; inline operand = 12
  $92CA  B4                         POPR
  $92CB  B3                         PUSHL
  $92CC  B0                         DEREF
  $92CD  BC                         SUB
  $92CE  B1                         POPSTORE
  $92CF  3D                         PUSH_quick   ; inline operand = 13
  $92D0  0C                         LOADL_quick   ; inline operand = 12
  $92D1  72                         ADD_qimm   ; inline operand = 2
  $92D2  B4                         POPR
  $92D3  B3                         PUSHL
  $92D4  B0                         DEREF
  $92D5  BC                         SUB
  $92D6  B1                         POPSTORE
  $92D7  40                         LOADL_qimm   ; inline operand = 0
  $92D8  CF                         RETURN

; ============================================================
; sub $92D9   (frame_off=+0, body @ $92DE)
; ============================================================
  $92DE  0C                         LOADL_quick   ; inline operand = 12
  $92DF  B0                         DEREF
  $92E0  50                         LOADR_qimm   ; inline operand = 0
  $92E1  C3                         SCMPLE
  $92E2  D7 F5 92                   JUMPT_abs              $92F5
  $92E5  0D                         LOADL_quick   ; inline operand = 13
  $92E6  B0                         DEREF
  $92E7  B3                         PUSHL
  $92E8  0C                         LOADL_quick   ; inline operand = 12
  $92E9  B4                         POPR
  $92EA  B3                         PUSHL
  $92EB  B0                         DEREF
  $92EC  BC                         SUB
  $92ED  B1                         POPSTORE
  $92EE  0C                         LOADL_quick   ; inline operand = 12
  $92EF  B0                         DEREF
  $92F0  50                         LOADR_qimm   ; inline operand = 0
  $92F1  C2                         SCMPLT
  $92F2  D8 F8 92                   JUMPF_abs              $92F8
 >$92F5  3D                         PUSH_quick   ; inline operand = 13
  $92F6  40                         LOADL_qimm   ; inline operand = 0
  $92F7  B1                         POPSTORE
 >$92F8  CF                         RETURN

; ============================================================
; sub $92F9   (frame_off=+0, body @ $92FE)
; ============================================================
  $92FE  62                         PUSH_qimm   ; inline operand = 2
  $92FF  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9303  D7 0D 93                   JUMPT_abs              $930D
  $9306  0C                         LOADL_quick   ; inline operand = 12
  $9307  B0                         DEREF
  $9308  50                         LOADR_qimm   ; inline operand = 0
  $9309  C3                         SCMPLE
  $930A  D8 0F 93                   JUMPF_abs              $930F
 >$930D  40                         LOADL_qimm   ; inline operand = 0
  $930E  CF                         RETURN
 >$930F  3C                         PUSH_quick   ; inline operand = 12
  $9310  8D 1E                      BYTE_PUSH_imm1         +30
  $9312  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9316  8F 28                      BYTE_ADD_imm1          +40
  $9318  B3                         PUSHL
  $9319  0C                         LOADL_quick   ; inline operand = 12
  $931A  B0                         DEREF
  $931B  B3                         PUSHL
  $931C  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9320  B1                         POPSTORE
  $9321  41                         LOADL_qimm   ; inline operand = 1
  $9322  CF                         RETURN

; ============================================================
; sub $9323   (frame_off=+0, body @ $9328)
; ============================================================
  $9328  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $932B  8B 1A                      BYTE_LOADR_imm1        +26
  $932D  B5                         MULT
  $932E  8C 0B 70                   LOADR_imm2             $700B
  $9331  BB                         ADD
  $9332  B3                         PUSHL
  $9333  E9 F9 92 02                CALL_abs_imm1          $92F9 {bytecode}, $02
  $9337  CF                         RETURN

; ============================================================
; sub $9338   (frame_off=+0, body @ $933D)
; ============================================================
  $933D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9340  8B 1A                      BYTE_LOADR_imm1        +26
  $9342  B5                         MULT
  $9343  8C 09 70                   LOADR_imm2             $7009
  $9346  BB                         ADD
  $9347  B3                         PUSHL
  $9348  E9 F9 92 02                CALL_abs_imm1          $92F9 {bytecode}, $02
  $934C  D8 69 93                   JUMPF_abs              $9369
  $934F  8D 64                      BYTE_PUSH_imm1         +100
  $9351  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9355  8F 64                      BYTE_ADD_imm1          +100
  $9357  B3                         PUSHL
  $9358  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $935B  8B 1A                      BYTE_LOADR_imm1        +26
  $935D  B5                         MULT
  $935E  8C 0F 70                   LOADR_imm2             $700F
  $9361  BB                         ADD
  $9362  B4                         POPR
  $9363  B3                         PUSHL
  $9364  B0                         DEREF
  $9365  BB                         ADD
  $9366  B1                         POPSTORE
  $9367  41                         LOADL_qimm   ; inline operand = 1
  $9368  CF                         RETURN
 >$9369  40                         LOADL_qimm   ; inline operand = 0
  $936A  CF                         RETURN

; ============================================================
; sub $936B   (frame_off=+0, body @ $9370)
; ============================================================
  $9370  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9373  8B 1A                      BYTE_LOADR_imm1        +26
  $9375  B5                         MULT
  $9376  8C 05 70                   LOADR_imm2             $7005
  $9379  BB                         ADD
  $937A  B3                         PUSHL
  $937B  E9 F9 92 02                CALL_abs_imm1          $92F9 {bytecode}, $02
  $937F  CF                         RETURN

; ============================================================
; sub $9380   (frame_off=+0, body @ $9385)
; ============================================================
  $9385  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9388  8B 1A                      BYTE_LOADR_imm1        +26
  $938A  B5                         MULT
  $938B  8C 0F 70                   LOADR_imm2             $700F
  $938E  BB                         ADD
  $938F  B3                         PUSHL
  $9390  E9 F9 92 02                CALL_abs_imm1          $92F9 {bytecode}, $02
  $9394  CF                         RETURN

; ============================================================
; sub $9395   (frame_off=+0, body @ $939A)
; ============================================================
  $939A  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $939D  8B 1A                      BYTE_LOADR_imm1        +26
  $939F  B5                         MULT
  $93A0  8C 13 70                   LOADR_imm2             $7013
  $93A3  BB                         ADD
  $93A4  B3                         PUSHL
  $93A5  E9 F9 92 02                CALL_abs_imm1          $92F9 {bytecode}, $02
  $93A9  CF                         RETURN

; ============================================================
; sub $93AA   (frame_off=+0, body @ $93AF)
; ============================================================
  $93AF  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $93B2  8B 1A                      BYTE_LOADR_imm1        +26
  $93B4  B5                         MULT
  $93B5  8C 0D 70                   LOADR_imm2             $700D
  $93B8  BB                         ADD
  $93B9  B3                         PUSHL
  $93BA  E9 F9 92 02                CALL_abs_imm1          $92F9 {bytecode}, $02
  $93BE  CF                         RETURN

; ============================================================
; sub $93BF   (frame_off=-4, body @ $93C4)
; ============================================================
  $93C4  8E C6 BB                   PUSH_imm2              $BBC6
  $93C7  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $93CB  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $93CE  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $93D2  8E C7 BB                   PUSH_imm2              $BBC7
  $93D5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $93D9  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $93DC  D0                         INC
  $93DD  B3                         PUSHL
  $93DE  8E EC BB                   PUSH_imm2              $BBEC
  $93E1  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $93E5  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $93E8  6F                         PUSH_qimm   ; inline operand = 15
  $93E9  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $93ED  AC 23 93                   CALL_abs               $9323 (effect_war_combat_prep_a) {bytecode}
  $93F0  D7 4E 94                   JUMPT_abs              $944E
  $93F3  AC 6B 93                   CALL_abs               $936B {bytecode}
  $93F6  D7 4E 94                   JUMPT_abs              $944E
  $93F9  AC AA 93                   CALL_abs               $93AA {bytecode}
  $93FC  D7 4E 94                   JUMPT_abs              $944E
  $93FF  AC 95 93                   CALL_abs               $9395 {bytecode}
  $9402  D7 4E 94                   JUMPT_abs              $944E
  $9405  AC 80 93                   CALL_abs               $9380 {bytecode}
  $9408  D7 4E 94                   JUMPT_abs              $944E
  $940B  AC 38 93                   CALL_abs               $9338 {bytecode}
  $940E  D7 4E 94                   JUMPT_abs              $944E
  $9411  62                         PUSH_qimm   ; inline operand = 2
  $9412  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9416  D8 6B 94                   JUMPF_abs              $946B
  $9419  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $941C  8B 1A                      BYTE_LOADR_imm1        +26
  $941E  B5                         MULT
  $941F  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9422  BB                         ADD
  $9423  2B                         STORE_quick   ; inline operand = 11
  $9424  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $9427  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $942B  2A                         STORE_quick   ; inline operand = 10
  $942C  0B                         LOADL_quick   ; inline operand = 11
  $942D  7A                         ADD_qimm   ; inline operand = 10
  $942E  B0                         DEREF
  $942F  50                         LOADR_qimm   ; inline operand = 0
  $9430  C3                         SCMPLE
  $9431  D8 53 94                   JUMPF_abs              $9453
  $9434  65                         PUSH_qimm   ; inline operand = 5
  $9435  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9439  B3                         PUSHL
  $943A  0A                         LOADL_quick   ; inline operand = 10
  $943B  74                         ADD_qimm   ; inline operand = 4
  $943C  B3                         PUSHL
  $943D  E9 12 CA 04                CALL_abs_imm1          $CA12 (byte_helper_ca12) {bytecode}, $04
  $9441  65                         PUSH_qimm   ; inline operand = 5
  $9442  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9446  B3                         PUSHL
  $9447  0A                         LOADL_quick   ; inline operand = 10
  $9448  D0                         INC
  $9449  B3                         PUSHL
  $944A  E9 12 CA 04                CALL_abs_imm1          $CA12 (byte_helper_ca12) {bytecode}, $04
 >$944E  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9451  41                         LOADL_qimm   ; inline operand = 1
  $9452  CF                         RETURN
 >$9453  0B                         LOADL_quick   ; inline operand = 11
  $9454  7A                         ADD_qimm   ; inline operand = 10
  $9455  B3                         PUSHL
  $9456  8D 1E                      BYTE_PUSH_imm1         +30
  $9458  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $945C  8F 3C                      BYTE_ADD_imm1          +60
  $945E  B3                         PUSHL
  $945F  0B                         LOADL_quick   ; inline operand = 11
  $9460  7A                         ADD_qimm   ; inline operand = 10
  $9461  B0                         DEREF
  $9462  B3                         PUSHL
  $9463  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9467  B1                         POPSTORE
  $9468  D6 4E 94                   JUMP_abs               $944E
 >$946B  40                         LOADL_qimm   ; inline operand = 0
  $946C  CF                         RETURN

; ============================================================
; sub $946D   (frame_off=+0, body @ $9472)
; ============================================================
  $9472  3C                         PUSH_quick   ; inline operand = 12
  $9473  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $9477  74                         ADD_qimm   ; inline operand = 4
  $9478  D3                         BYTE_DEREF
  $9479  CF                         RETURN

; ============================================================
; sub $947A   (frame_off=-6, body @ $947F)
; ============================================================
  $947F  8E FF 00                   PUSH_imm2              $00FF
  $9482  E9 DC E4 02                CALL_abs_imm1          $E4DC (marry_helper_e4dc) {bytecode}, $02
  $9486  40                         LOADL_qimm   ; inline operand = 0
  $9487  29                         STORE_quick   ; inline operand = 9
  $9488  40                         LOADL_qimm   ; inline operand = 0
  $9489  2A                         STORE_quick   ; inline operand = 10
  $948A  8A 89 6F                   LOADL_imm2             $6F89
  $948D  2B                         STORE_quick   ; inline operand = 11
  $948E  D6 A4 94                   JUMP_abs               $94A4
 >$9491  0B                         LOADL_quick   ; inline operand = 11
  $9492  D3                         BYTE_DEREF
  $9493  B3                         PUSHL
  $9494  E9 6D 94 02                CALL_abs_imm1          $946D {bytecode}, $02
  $9498  CD                         SWAP
  $9499  0A                         LOADL_quick   ; inline operand = 10
  $949A  BB                         ADD
  $949B  2A                         STORE_quick   ; inline operand = 10
  $949C  0B                         LOADL_quick   ; inline operand = 11
  $949D  D0                         INC
  $949E  2B                         STORE_quick   ; inline operand = 11
  $949F  D1                         DEC
  $94A0  09                         LOADL_quick   ; inline operand = 9
  $94A1  D0                         INC
  $94A2  29                         STORE_quick   ; inline operand = 9
  $94A3  D1                         DEC
 >$94A4  0B                         LOADL_quick   ; inline operand = 11
  $94A5  D3                         BYTE_DEREF
  $94A6  8C FF 00                   LOADR_imm2             $00FF
  $94A9  C1                         CMPNE
  $94AA  D7 91 94                   JUMPT_abs              $9491
  $94AD  0A                         LOADL_quick   ; inline operand = 10
  $94AE  19                         LOADR_quick   ; inline operand = 9
  $94AF  B8                         UDIV
  $94B0  CF                         RETURN

; ============================================================
; sub $94B1   (frame_off=-4, body @ $94B6)
; ============================================================
  $94B6  0C                         LOADL_quick   ; inline operand = 12
  $94B7  D9 02 00 01 00 C4 94 02 00 E9 94 CE ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 1=>$94C4 2=>$94E9 default=>$94CE
 >$94C4  8E F1 BB                   PUSH_imm2              $BBF1
 >$94C7  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $94CB  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$94CE  40                         LOADL_qimm   ; inline operand = 0
  $94CF  2B                         STORE_quick   ; inline operand = 11
  $94D0  D6 1D 95                   JUMP_abs               $951D
 >$94D3  3A                         PUSH_quick   ; inline operand = 10
  $94D4  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $94D8  D8 1D 95                   JUMPF_abs              $951D
  $94DB  0C                         LOADL_quick   ; inline operand = 12
  $94DC  D9 02 00 01 00 EF 94 02 00 04 95 1D ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 1=>$94EF 2=>$9504 default=>$951D
 >$94E9  8E 13 BC                   PUSH_imm2              $BC13
  $94EC  D6 C7 94                   JUMP_abs               $94C7
 >$94EF  8E 2A BC                   PUSH_imm2              $BC2A
  $94F2  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $94F6  3A                         PUSH_quick   ; inline operand = 10
  $94F7  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $94FB  0A                         LOADL_quick   ; inline operand = 10
  $94FC  D0                         INC
  $94FD  B3                         PUSHL
  $94FE  8E 2B BC                   PUSH_imm2              $BC2B
  $9501  D6 16 95                   JUMP_abs               $9516
 >$9504  8E 4B BC                   PUSH_imm2              $BC4B
  $9507  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $950B  3A                         PUSH_quick   ; inline operand = 10
  $950C  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $9510  0A                         LOADL_quick   ; inline operand = 10
  $9511  D0                         INC
  $9512  B3                         PUSHL
  $9513  8E 4C BC                   PUSH_imm2              $BC4C
 >$9516  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $951A  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$951D  0B                         LOADL_quick   ; inline operand = 11
  $951E  D0                         INC
  $951F  2B                         STORE_quick   ; inline operand = 11
  $9520  D1                         DEC
  $9521  8C AD 7B                   LOADR_imm2             $7BAD
  $9524  BB                         ADD
  $9525  D3                         BYTE_DEREF
  $9526  2A                         STORE_quick   ; inline operand = 10
  $9527  8C FF 00                   LOADR_imm2             $00FF
  $952A  C1                         CMPNE
  $952B  D7 D3 94                   JUMPT_abs              $94D3
  $952E  CF                         RETURN

; ============================================================
; sub $952F   (frame_off=-4, body @ $9534)
; ============================================================
  $9534  40                         LOADL_qimm   ; inline operand = 0
  $9535  2B                         STORE_quick   ; inline operand = 11
  $9536  40                         LOADL_qimm   ; inline operand = 0
  $9537  D6 46 95                   JUMP_abs               $9546
 >$953A  0A                         LOADL_quick   ; inline operand = 10
  $953B  8C 2D 6D                   LOADR_imm2             $6D2D
  $953E  BB                         ADD
  $953F  D3                         BYTE_DEREF
  $9540  CD                         SWAP
  $9541  0B                         LOADL_quick   ; inline operand = 11
  $9542  BB                         ADD
  $9543  2B                         STORE_quick   ; inline operand = 11
  $9544  0A                         LOADL_quick   ; inline operand = 10
  $9545  D0                         INC
 >$9546  2A                         STORE_quick   ; inline operand = 10
  $9547  0A                         LOADL_quick   ; inline operand = 10
  $9548  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $954B  C6                         UCMPLT
  $954C  D7 3A 95                   JUMPT_abs              $953A
  $954F  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $9552  CD                         SWAP
  $9553  0B                         LOADL_quick   ; inline operand = 11
  $9554  B8                         UDIV
  $9555  2B                         STORE_quick   ; inline operand = 11
  $9556  0B                         LOADL_quick   ; inline operand = 11
  $9557  CF                         RETURN

; ============================================================
; sub $9558   (frame_off=-8, body @ $955D)
; ============================================================
  $955D  40                         LOADL_qimm   ; inline operand = 0
  $955E  28                         STORE_quick   ; inline operand = 8
  $955F  40                         LOADL_qimm   ; inline operand = 0
  $9560  2B                         STORE_quick   ; inline operand = 11
  $9561  40                         LOADL_qimm   ; inline operand = 0
  $9562  2A                         STORE_quick   ; inline operand = 10
  $9563  D6 85 95                   JUMP_abs               $9585
 >$9566  08                         LOADL_quick   ; inline operand = 8
  $9567  8B 1A                      BYTE_LOADR_imm1        +26
  $9569  B5                         MULT
  $956A  8C 0F 70                   LOADR_imm2             $700F
  $956D  BB                         ADD
  $956E  B0                         DEREF
  $956F  29                         STORE_quick   ; inline operand = 9
  $9570  09                         LOADL_quick   ; inline operand = 9
  $9571  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9574  B8                         UDIV
  $9575  CD                         SWAP
  $9576  0B                         LOADL_quick   ; inline operand = 11
  $9577  BB                         ADD
  $9578  2B                         STORE_quick   ; inline operand = 11
  $9579  09                         LOADL_quick   ; inline operand = 9
  $957A  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $957D  BA                         UMOD
  $957E  CD                         SWAP
  $957F  0A                         LOADL_quick   ; inline operand = 10
  $9580  BB                         ADD
  $9581  2A                         STORE_quick   ; inline operand = 10
  $9582  08                         LOADL_quick   ; inline operand = 8
  $9583  D0                         INC
  $9584  28                         STORE_quick   ; inline operand = 8
 >$9585  08                         LOADL_quick   ; inline operand = 8
  $9586  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9589  C6                         UCMPLT
  $958A  D7 66 95                   JUMPT_abs              $9566
  $958D  0A                         LOADL_quick   ; inline operand = 10
  $958E  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9591  B8                         UDIV
  $9592  1B                         LOADR_quick   ; inline operand = 11
  $9593  BB                         ADD
  $9594  CF                         RETURN

; ============================================================
; sub $9595   (frame_off=-6, body @ $959A)
; ============================================================
  $959A  8E 6A BC                   PUSH_imm2              $BC6A
  $959D  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $95A1  0C                         LOADL_quick   ; inline operand = 12
  $95A2  D0                         INC
  $95A3  B3                         PUSHL
  $95A4  8E 73 BC                   PUSH_imm2              $BC73
  $95A7  E9 34 D1 04                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $04
  $95AB  0C                         LOADL_quick   ; inline operand = 12
  $95AC  8B 1A                      BYTE_LOADR_imm1        +26
  $95AE  B5                         MULT
  $95AF  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $95B2  BB                         ADD
  $95B3  2B                         STORE_quick   ; inline operand = 11
  $95B4  8D 1F                      BYTE_PUSH_imm1         +31
  $95B6  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $95BA  B3                         PUSHL
  $95BB  3C                         PUSH_quick   ; inline operand = 12
  $95BC  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $95C0  74                         ADD_qimm   ; inline operand = 4
  $95C1  D3                         BYTE_DEREF
  $95C2  B3                         PUSHL
  $95C3  8E C8 00                   PUSH_imm2              $00C8
  $95C6  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $95CA  53                         LOADR_qimm   ; inline operand = 3
  $95CB  B5                         MULT
  $95CC  8B 14                      BYTE_LOADR_imm1        +20
  $95CE  B6                         SDIV
  $95CF  B3                         PUSHL
  $95D0  0B                         LOADL_quick   ; inline operand = 11
  $95D1  8F 12                      BYTE_ADD_imm1          +18
  $95D3  B0                         DEREF
  $95D4  B3                         PUSHL
  $95D5  8D 64                      BYTE_PUSH_imm1         +100
  $95D7  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $95DB  53                         LOADR_qimm   ; inline operand = 3
  $95DC  B5                         MULT
  $95DD  5A                         LOADR_qimm   ; inline operand = 10
  $95DE  B6                         SDIV
  $95DF  B4                         POPR
  $95E0  BB                         ADD
  $95E1  B4                         POPR
  $95E2  BB                         ADD
  $95E3  7A                         ADD_qimm   ; inline operand = 10
  $95E4  B3                         PUSHL
  $95E5  0B                         LOADL_quick   ; inline operand = 11
  $95E6  8F 10                      BYTE_ADD_imm1          +16
  $95E8  B0                         DEREF
  $95E9  B3                         PUSHL
  $95EA  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $95EE  2A                         STORE_quick   ; inline operand = 10
  $95EF  0B                         LOADL_quick   ; inline operand = 11
  $95F0  8F 10                      BYTE_ADD_imm1          +16
  $95F2  B0                         DEREF
  $95F3  1A                         LOADR_quick   ; inline operand = 10
  $95F4  BC                         SUB
  $95F5  29                         STORE_quick   ; inline operand = 9
  $95F6  39                         PUSH_quick   ; inline operand = 9
  $95F7  3A                         PUSH_quick   ; inline operand = 10
  $95F8  8E 78 BC                   PUSH_imm2              $BC78
  $95FB  E9 34 D1 06                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $06
  $95FF  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9602  0A                         LOADL_quick   ; inline operand = 10
  $9603  19                         LOADR_quick   ; inline operand = 9
  $9604  C0                         CMPEQ
  $9605  D8 10 96                   JUMPF_abs              $9610
  $9608  62                         PUSH_qimm   ; inline operand = 2
  $9609  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $960D  50                         LOADR_qimm   ; inline operand = 0
  $960E  C0                         CMPEQ
  $960F  CF                         RETURN
 >$9610  0A                         LOADL_quick   ; inline operand = 10
  $9611  19                         LOADR_quick   ; inline operand = 9
  $9612  C2                         SCMPLT
  $9613  CF                         RETURN

; ============================================================
; sub $9614   (frame_off=+0, body @ $9619)
; ============================================================
  $9619  61                         PUSH_qimm   ; inline operand = 1
  $961A  3D                         PUSH_quick   ; inline operand = 13
  $961B  3C                         PUSH_quick   ; inline operand = 12
  $961C  E9 99 8E 06                CALL_abs_imm1          $8E99 {bytecode}, $06
  $9620  CF                         RETURN

; ============================================================
; sub $9621   (frame_off=-5, body @ $9626)
; ============================================================
  $9626  A4 AB 7B                   LOADL_abs              $7BAB
  $9629  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $962C  89 1E                      BYTE_LOADL_imm1        +30
  $962E  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9631  40                         LOADL_qimm   ; inline operand = 0
  $9632  D6 59 96                   JUMP_abs               $9659
 >$9635  3B                         PUSH_quick   ; inline operand = 11
  $9636  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $963A  8B 18                      BYTE_LOADR_imm1        +24
  $963C  C0                         CMPEQ
  $963D  D8 57 96                   JUMPF_abs              $9657
  $9640  0B                         LOADL_quick   ; inline operand = 11
  $9641  8C A2 6D                   LOADR_imm2             $6DA2
  $9644  BB                         ADD
  $9645  D3                         BYTE_DEREF
  $9646  D7 57 96                   JUMPT_abs              $9657
  $9649  0B                         LOADL_quick   ; inline operand = 11
  $964A  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $964D  BB                         ADD
  $964E  B3                         PUSHL
  $964F  89 32                      BYTE_LOADL_imm1        +50
  $9651  D4                         BYTE_POPSTORE
  $9652  3B                         PUSH_quick   ; inline operand = 11
  $9653  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
 >$9657  0B                         LOADL_quick   ; inline operand = 11
  $9658  D0                         INC
 >$9659  2B                         STORE_quick   ; inline operand = 11
  $965A  0B                         LOADL_quick   ; inline operand = 11
  $965B  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $965E  C6                         UCMPLT
  $965F  D7 35 96                   JUMPT_abs              $9635
  $9662  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9665  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $9668  BB                         ADD
  $9669  B3                         PUSHL
  $966A  40                         LOADL_qimm   ; inline operand = 0
  $966B  D4                         BYTE_POPSTORE
  $966C  A4 4D 6F                   LOADL_abs              $6F4D
  $966F  2A                         STORE_quick   ; inline operand = 10
  $9670  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $9673  A2 FB FF                   BYTE_STORE_far         $FFFB
  $9676  41                         LOADL_qimm   ; inline operand = 1
  $9677  A8 4D 6F                   STORE_abs              $6F4D
  $967A  44                         LOADL_qimm   ; inline operand = 4
  $967B  CD                         SWAP
  $967C  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $967F  DB                         OR
  $9680  A9 A1 6D                   BYTE_STORE_abs         $6DA1
  $9683  8E AC BC                   PUSH_imm2              $BCAC
  $9686  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $968A  8D 62                      BYTE_PUSH_imm1         +98
  $968C  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $9690  AC 89 CC                   CALL_abs               $CC89 (ui_helper_cc89) {bytecode}
  $9693  65                         PUSH_qimm   ; inline operand = 5
  $9694  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $9698  0A                         LOADL_quick   ; inline operand = 10
  $9699  A8 4D 6F                   STORE_abs              $6F4D
  $969C  A0 FB FF                   BYTE_LOADL_far         $FFFB
  $969F  A9 A1 6D                   BYTE_STORE_abs         $6DA1
  $96A2  40                         LOADL_qimm   ; inline operand = 0
  $96A3  A9 65 6F                   BYTE_STORE_abs         $6F65
  $96A6  A4 81 6F                   LOADL_abs              $6F81
  $96A9  A8 7F 6F                   STORE_abs              $6F7F
  $96AC  A8 7D 6F                   STORE_abs              $6F7D
  $96AF  CF                         RETURN

; ============================================================
; sub $96B0   (frame_off=-10, body @ $96B5)
; ============================================================
  $96B5  40                         LOADL_qimm   ; inline operand = 0
  $96B6  2A                         STORE_quick   ; inline operand = 10
  $96B7  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $96BA  8B 32                      BYTE_LOADR_imm1        +50
  $96BC  C0                         CMPEQ
  $96BD  D8 76 97                   JUMPF_abs              $9776
  $96C0  0C                         LOADL_quick   ; inline operand = 12
  $96C1  8B 1E                      BYTE_LOADR_imm1        +30
  $96C3  C0                         CMPEQ
  $96C4  D8 76 97                   JUMPF_abs              $9776
  $96C7  3C                         PUSH_quick   ; inline operand = 12
  $96C8  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $96CC  8B 18                      BYTE_LOADR_imm1        +24
  $96CE  C0                         CMPEQ
  $96CF  D8 76 97                   JUMPF_abs              $9776
  $96D2  8D 1E                      BYTE_PUSH_imm1         +30
  $96D4  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $96D8  D3                         BYTE_DEREF
  $96D9  8B 28                      BYTE_LOADR_imm1        +40
  $96DB  C5                         SCMPGE
  $96DC  D8 76 97                   JUMPF_abs              $9776
  $96DF  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $96E2  28                         STORE_quick   ; inline operand = 8
  $96E3  89 1E                      BYTE_LOADL_imm1        +30
  $96E5  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $96E8  AC 1E 8C                   CALL_abs               $8C1E {bytecode}
  $96EB  D8 6E 97                   JUMPF_abs              $976E
  $96EE  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $96F1  52                         LOADR_qimm   ; inline operand = 2
  $96F2  DA                         AND
  $96F3  D7 6E 97                   JUMPT_abs              $976E
  $96F6  AC D7 DA                   CALL_abs               $DAD7 (combat_helper_dad7) {bytecode}
  $96F9  8E 4F 6F                   PUSH_imm2              $6F4F
  $96FC  61                         PUSH_qimm   ; inline operand = 1
  $96FD  E9 3A DD 04                CALL_abs_imm1          $DD3A (combat_helper_dd3a) {bytecode}, $04
  $9701  40                         LOADL_qimm   ; inline operand = 0
  $9702  A8 81 6F                   STORE_abs              $6F81
  $9705  8A 4F 6F                   LOADL_imm2             $6F4F
  $9708  D6 34 97                   JUMP_abs               $9734
 >$970B  0B                         LOADL_quick   ; inline operand = 11
  $970C  D3                         BYTE_DEREF
  $970D  A8 AB 7B                   STORE_abs              $7BAB
  $9710  0B                         LOADL_quick   ; inline operand = 11
  $9711  D3                         BYTE_DEREF
  $9712  8B 1A                      BYTE_LOADR_imm1        +26
  $9714  B5                         MULT
  $9715  8C 11 70                   LOADR_imm2             $7011
  $9718  BB                         ADD
  $9719  B0                         DEREF
  $971A  CD                         SWAP
  $971B  A4 81 6F                   LOADL_abs              $6F81
  $971E  BB                         ADD
  $971F  A8 81 6F                   STORE_abs              $6F81
  $9722  A4 81 6F                   LOADL_abs              $6F81
  $9725  8C 0F 27                   LOADR_imm2             $270F
  $9728  C4                         SCMPGT
  $9729  D8 32 97                   JUMPF_abs              $9732
  $972C  8A 0F 27                   LOADL_imm2             $270F
  $972F  A8 81 6F                   STORE_abs              $6F81
 >$9732  0B                         LOADL_quick   ; inline operand = 11
  $9733  D0                         INC
 >$9734  2B                         STORE_quick   ; inline operand = 11
  $9735  0B                         LOADL_quick   ; inline operand = 11
  $9736  D3                         BYTE_DEREF
  $9737  8C FF 00                   LOADR_imm2             $00FF
  $973A  C1                         CMPNE
  $973B  D7 0B 97                   JUMPT_abs              $970B
  $973E  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9741  8B 1A                      BYTE_LOADR_imm1        +26
  $9743  B5                         MULT
  $9744  8C 11 70                   LOADR_imm2             $7011
  $9747  BB                         ADD
  $9748  B0                         DEREF
  $9749  B3                         PUSHL
  $974A  A4 81 6F                   LOADL_abs              $6F81
  $974D  B4                         POPR
  $974E  C4                         SCMPGT
  $974F  D8 6E 97                   JUMPF_abs              $976E
  $9752  61                         PUSH_qimm   ; inline operand = 1
  $9753  E9 10 E5 02                CALL_abs_imm1          $E510 (ui_helper_e510) {bytecode}, $02
  $9757  53                         LOADR_qimm   ; inline operand = 3
  $9758  C9                         UCMPGE
  $9759  D8 6E 97                   JUMPF_abs              $976E
  $975C  42                         LOADL_qimm   ; inline operand = 2
  $975D  CD                         SWAP
  $975E  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $9761  DB                         OR
  $9762  A9 A1 6D                   BYTE_STORE_abs         $6DA1
  $9765  AC 21 96                   CALL_abs               $9621 {bytecode}
  $9768  41                         LOADL_qimm   ; inline operand = 1
  $9769  A8 48 6E                   STORE_abs              $6E48
  $976C  41                         LOADL_qimm   ; inline operand = 1
  $976D  2A                         STORE_quick   ; inline operand = 10
 >$976E  0A                         LOADL_quick   ; inline operand = 10
  $976F  D7 76 97                   JUMPT_abs              $9776
  $9772  08                         LOADL_quick   ; inline operand = 8
  $9773  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
 >$9776  0A                         LOADL_quick   ; inline operand = 10
  $9777  CF                         RETURN

; ============================================================
; sub $9778   (frame_off=-14, body @ $977D)
; ============================================================
  $977D  40                         LOADL_qimm   ; inline operand = 0
  $977E  27                         STORE_quick   ; inline operand = 7
  $977F  8A AD 7B                   LOADL_imm2             $7BAD
  $9782  D6 6E 98                   JUMP_abs               $986E
 >$9785  0B                         LOADL_quick   ; inline operand = 11
  $9786  D3                         BYTE_DEREF
  $9787  B3                         PUSHL
  $9788  E9 B0 96 02                CALL_abs_imm1          $96B0 {bytecode}, $02
  $978C  D7 78 98                   JUMPT_abs              $9878
  $978F  0B                         LOADL_quick   ; inline operand = 11
  $9790  D3                         BYTE_DEREF
  $9791  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $9794  8D 1E                      BYTE_PUSH_imm1         +30
  $9796  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $979A  AC 1E 8C                   CALL_abs               $8C1E {bytecode}
  $979D  D8 AF 97                   JUMPF_abs              $97AF
  $97A0  07                         LOADL_quick   ; inline operand = 7
  $97A1  D0                         INC
  $97A2  27                         STORE_quick   ; inline operand = 7
  $97A3  D1                         DEC
  $97A4  B3                         PUSHL
  $97A5  0B                         LOADL_quick   ; inline operand = 11
  $97A6  D3                         BYTE_DEREF
  $97A7  B3                         PUSHL
  $97A8  E9 14 96 04                CALL_abs_imm1          $9614 {bytecode}, $04
  $97AC  D6 6C 98                   JUMP_abs               $986C
 >$97AF  0B                         LOADL_quick   ; inline operand = 11
  $97B0  D3                         BYTE_DEREF
  $97B1  B3                         PUSHL
  $97B2  E9 95 95 02                CALL_abs_imm1          $9595 {bytecode}, $02
  $97B6  D8 19 98                   JUMPF_abs              $9819
  $97B9  8E F1 BC                   PUSH_imm2              $BCF1
  $97BC  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $97C0  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $97C3  0B                         LOADL_quick   ; inline operand = 11
  $97C4  D3                         BYTE_DEREF
  $97C5  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $97C8  BB                         ADD
  $97C9  2A                         STORE_quick   ; inline operand = 10
  $97CA  0B                         LOADL_quick   ; inline operand = 11
  $97CB  D3                         BYTE_DEREF
  $97CC  8C A2 6D                   LOADR_imm2             $6DA2
  $97CF  BB                         ADD
  $97D0  D3                         BYTE_DEREF
  $97D1  D8 FC 97                   JUMPF_abs              $97FC
  $97D4  0B                         LOADL_quick   ; inline operand = 11
  $97D5  D3                         BYTE_DEREF
  $97D6  B3                         PUSHL
  $97D7  E9 75 E2 02                CALL_abs_imm1          $E275 (prompt_helper_e275) {bytecode}, $02
  $97DB  0A                         LOADL_quick   ; inline operand = 10
  $97DC  D3                         BYTE_DEREF
  $97DD  B3                         PUSHL
  $97DE  E9 0E DC 02                CALL_abs_imm1          $DC0E (list_op_6e4a) {bytecode}, $02
  $97E2  0A                         LOADL_quick   ; inline operand = 10
  $97E3  D3                         BYTE_DEREF
  $97E4  B3                         PUSHL
  $97E5  E9 3C DC 02                CALL_abs_imm1          $DC3C (list_remove_6e7f) {bytecode}, $02
  $97E9  0B                         LOADL_quick   ; inline operand = 11
  $97EA  D3                         BYTE_DEREF
  $97EB  8C A2 6D                   LOADR_imm2             $6DA2
  $97EE  BB                         ADD
  $97EF  B3                         PUSHL
  $97F0  40                         LOADL_qimm   ; inline operand = 0
  $97F1  D4                         BYTE_POPSTORE
  $97F2  0B                         LOADL_quick   ; inline operand = 11
  $97F3  D3                         BYTE_DEREF
  $97F4  B3                         PUSHL
  $97F5  E9 25 E4 02                CALL_abs_imm1          $E425 (find_fiefs_of_owner) {bytecode}, $02
  $97F9  D6 06 98                   JUMP_abs               $9806
 >$97FC  0B                         LOADL_quick   ; inline operand = 11
  $97FD  D3                         BYTE_DEREF
  $97FE  8C 7F 6E                   LOADR_imm2             $6E7F
  $9801  BB                         ADD
  $9802  B3                         PUSHL
  $9803  0A                         LOADL_quick   ; inline operand = 10
  $9804  D3                         BYTE_DEREF
  $9805  D4                         BYTE_POPSTORE
 >$9806  0B                         LOADL_quick   ; inline operand = 11
  $9807  D3                         BYTE_DEREF
  $9808  B3                         PUSHL
  $9809  E9 1B E2 02                CALL_abs_imm1          $E21B (install_new_daimyo) {bytecode}, $02
  $980D  0B                         LOADL_quick   ; inline operand = 11
  $980E  D3                         BYTE_DEREF
  $980F  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $9812  BB                         ADD
  $9813  B3                         PUSHL
  $9814  40                         LOADL_qimm   ; inline operand = 0
  $9815  D4                         BYTE_POPSTORE
  $9816  D6 69 98                   JUMP_abs               $9869
 >$9819  8E 06 BD                   PUSH_imm2              $BD06
  $981C  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9820  0B                         LOADL_quick   ; inline operand = 11
  $9821  D3                         BYTE_DEREF
  $9822  8B 1A                      BYTE_LOADR_imm1        +26
  $9824  B5                         MULT
  $9825  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9828  BB                         ADD
  $9829  25                         STORE_quick   ; inline operand = 5
  $982A  8D 1E                      BYTE_PUSH_imm1         +30
  $982C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9830  B3                         PUSHL
  $9831  6A                         PUSH_qimm   ; inline operand = 10
  $9832  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9836  8F 1E                      BYTE_ADD_imm1          +30
  $9838  B3                         PUSHL
  $9839  05                         LOADL_quick   ; inline operand = 5
  $983A  8F 12                      BYTE_ADD_imm1          +18
  $983C  B0                         DEREF
  $983D  B3                         PUSHL
  $983E  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9842  B4                         POPR
  $9843  BB                         ADD
  $9844  8F 1E                      BYTE_ADD_imm1          +30
  $9846  B3                         PUSHL
  $9847  05                         LOADL_quick   ; inline operand = 5
  $9848  8F 12                      BYTE_ADD_imm1          +18
  $984A  B4                         POPR
  $984B  B3                         PUSHL
  $984C  B0                         DEREF
  $984D  BB                         ADD
  $984E  B1                         POPSTORE
  $984F  8D 14                      BYTE_PUSH_imm1         +20
  $9851  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9855  7A                         ADD_qimm   ; inline operand = 10
  $9856  B3                         PUSHL
  $9857  05                         LOADL_quick   ; inline operand = 5
  $9858  8F 10                      BYTE_ADD_imm1          +16
  $985A  B0                         DEREF
  $985B  B3                         PUSHL
  $985C  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9860  B3                         PUSHL
  $9861  05                         LOADL_quick   ; inline operand = 5
  $9862  8F 10                      BYTE_ADD_imm1          +16
  $9864  B4                         POPR
  $9865  B3                         PUSHL
  $9866  B0                         DEREF
  $9867  BC                         SUB
  $9868  B1                         POPSTORE
 >$9869  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$986C  0B                         LOADL_quick   ; inline operand = 11
  $986D  D0                         INC
 >$986E  2B                         STORE_quick   ; inline operand = 11
  $986F  0B                         LOADL_quick   ; inline operand = 11
  $9870  D3                         BYTE_DEREF
  $9871  8C FF 00                   LOADR_imm2             $00FF
  $9874  C1                         CMPNE
  $9875  D7 85 97                   JUMPT_abs              $9785
 >$9878  CF                         RETURN

; ============================================================
; sub $9879   (frame_off=-2, body @ $987E)
; ============================================================
  $987E  8A 89 6F                   LOADL_imm2             $6F89
  $9881  D6 98 98                   JUMP_abs               $9898
 >$9884  A0 0B 00                   BYTE_LOADL_far         $000B
  $9887  B3                         PUSHL
  $9888  0B                         LOADL_quick   ; inline operand = 11
  $9889  D3                         BYTE_DEREF
  $988A  B4                         POPR
  $988B  C0                         CMPEQ
  $988C  D8 96 98                   JUMPF_abs              $9896
  $988F  3B                         PUSH_quick   ; inline operand = 11
  $9890  89 C8                      BYTE_LOADL_imm1        -56
  $9892  D4                         BYTE_POPSTORE
  $9893  D6 A2 98                   JUMP_abs               $98A2
 >$9896  0B                         LOADL_quick   ; inline operand = 11
  $9897  D0                         INC
 >$9898  2B                         STORE_quick   ; inline operand = 11
  $9899  0B                         LOADL_quick   ; inline operand = 11
  $989A  D3                         BYTE_DEREF
  $989B  8C FF 00                   LOADR_imm2             $00FF
  $989E  C1                         CMPNE
  $989F  D7 84 98                   JUMPT_abs              $9884
 >$98A2  CF                         RETURN

; ============================================================
; sub $98A3   (frame_off=-2, body @ $98A8)
; ============================================================
  $98A8  0F                         LOADL_quick   ; inline operand = 15
  $98A9  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $98AC  BB                         ADD
  $98AD  B3                         PUSHL
  $98AE  0C                         LOADL_quick   ; inline operand = 12
  $98AF  D4                         BYTE_POPSTORE
  $98B0  0F                         LOADL_quick   ; inline operand = 15
  $98B1  8C A2 6D                   LOADR_imm2             $6DA2
  $98B4  BB                         ADD
  $98B5  B3                         PUSHL
  $98B6  0D                         LOADL_quick   ; inline operand = 13
  $98B7  D4                         BYTE_POPSTORE
  $98B8  0F                         LOADL_quick   ; inline operand = 15
  $98B9  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $98BC  BB                         ADD
  $98BD  B3                         PUSHL
  $98BE  0E                         LOADL_quick   ; inline operand = 14
  $98BF  D4                         BYTE_POPSTORE
  $98C0  3F                         PUSH_quick   ; inline operand = 15
  $98C1  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
  $98C5  CF                         RETURN

; ============================================================
; sub $98C6   (frame_off=-58, body @ $98CB)
; ============================================================
  $98CB  AC D7 DA                   CALL_abs               $DAD7 (combat_helper_dad7) {bytecode}
  $98CE  8E 4F 6F                   PUSH_imm2              $6F4F
  $98D1  61                         PUSH_qimm   ; inline operand = 1
  $98D2  E9 3A DD 04                CALL_abs_imm1          $DD3A (combat_helper_dd3a) {bytecode}, $04
  $98D6  DE CA FF                   LEAL_far               $FFCA
  $98D9  2A                         STORE_quick   ; inline operand = 10
  $98DA  8A 4F 6F                   LOADL_imm2             $6F4F
  $98DD  2B                         STORE_quick   ; inline operand = 11
  $98DE  40                         LOADL_qimm   ; inline operand = 0
  $98DF  85 C8                      STORE_near             $C8
  $98E1  D6 06 99                   JUMP_abs               $9906
 >$98E4  0B                         LOADL_quick   ; inline operand = 11
  $98E5  D3                         BYTE_DEREF
  $98E6  8C FF 00                   LOADR_imm2             $00FF
  $98E9  C0                         CMPEQ
  $98EA  D7 0D 99                   JUMPT_abs              $990D
  $98ED  0A                         LOADL_quick   ; inline operand = 10
  $98EE  D0                         INC
  $98EF  2A                         STORE_quick   ; inline operand = 10
  $98F0  D1                         DEC
  $98F1  B3                         PUSHL
  $98F2  0B                         LOADL_quick   ; inline operand = 11
  $98F3  D3                         BYTE_DEREF
  $98F4  D4                         BYTE_POPSTORE
  $98F5  0B                         LOADL_quick   ; inline operand = 11
  $98F6  D3                         BYTE_DEREF
  $98F7  B3                         PUSHL
  $98F8  E9 79 98 02                CALL_abs_imm1          $9879 {bytecode}, $02
  $98FC  0B                         LOADL_quick   ; inline operand = 11
  $98FD  D0                         INC
  $98FE  2B                         STORE_quick   ; inline operand = 11
  $98FF  D1                         DEC
  $9900  81 C8                      LOADL_near             $C8
  $9902  D0                         INC
  $9903  85 C8                      STORE_near             $C8
  $9905  D1                         DEC
 >$9906  81 C8                      LOADL_near             $C8
  $9908  1C                         LOADR_quick   ; inline operand = 12
  $9909  C6                         UCMPLT
  $990A  D7 E4 98                   JUMPT_abs              $98E4
 >$990D  81 C8                      LOADL_near             $C8
  $990F  1C                         LOADR_quick   ; inline operand = 12
  $9910  C6                         UCMPLT
  $9911  D8 4B 99                   JUMPF_abs              $994B
  $9914  0C                         LOADL_quick   ; inline operand = 12
  $9915  83 C8                      LOADR_near             $C8
  $9917  BC                         SUB
  $9918  D6 2A 99                   JUMP_abs               $992A
 >$991B  0A                         LOADL_quick   ; inline operand = 10
  $991C  D0                         INC
  $991D  2A                         STORE_quick   ; inline operand = 10
  $991E  D1                         DEC
  $991F  B3                         PUSHL
  $9920  0D                         LOADL_quick   ; inline operand = 13
  $9921  D3                         BYTE_DEREF
  $9922  D4                         BYTE_POPSTORE
  $9923  3D                         PUSH_quick   ; inline operand = 13
  $9924  89 C8                      BYTE_LOADL_imm1        -56
  $9926  D4                         BYTE_POPSTORE
  $9927  81 C6                      LOADL_near             $C6
  $9929  D1                         DEC
 >$992A  85 C6                      STORE_near             $C6
  $992C  D6 44 99                   JUMP_abs               $9944
 >$992F  0D                         LOADL_quick   ; inline operand = 13
  $9930  D3                         BYTE_DEREF
  $9931  8C C8 00                   LOADR_imm2             $00C8
  $9934  C1                         CMPNE
  $9935  D7 1B 99                   JUMPT_abs              $991B
  $9938  0D                         LOADL_quick   ; inline operand = 13
  $9939  D0                         INC
  $993A  2D                         STORE_quick   ; inline operand = 13
 >$993B  0D                         LOADL_quick   ; inline operand = 13
  $993C  D3                         BYTE_DEREF
  $993D  8C FF 00                   LOADR_imm2             $00FF
  $9940  C1                         CMPNE
  $9941  D7 2F 99                   JUMPT_abs              $992F
 >$9944  81 C6                      LOADL_near             $C6
  $9946  50                         LOADR_qimm   ; inline operand = 0
  $9947  C8                         UCMPGT
  $9948  D7 3B 99                   JUMPT_abs              $993B
 >$994B  3A                         PUSH_quick   ; inline operand = 10
  $994C  89 FF                      BYTE_LOADL_imm1        -1
  $994E  D4                         BYTE_POPSTORE
  $994F  DE CA FF                   LEAL_far               $FFCA
  $9952  D6 69 99                   JUMP_abs               $9969
 >$9955  0A                         LOADL_quick   ; inline operand = 10
  $9956  D3                         BYTE_DEREF
  $9957  B3                         PUSHL
  $9958  0A                         LOADL_quick   ; inline operand = 10
  $9959  D3                         BYTE_DEREF
  $995A  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $995D  BB                         ADD
  $995E  D3                         BYTE_DEREF
  $995F  B3                         PUSHL
  $9960  60                         PUSH_qimm   ; inline operand = 0
  $9961  8D 33                      BYTE_PUSH_imm1         +51
  $9963  E9 A3 98 08                CALL_abs_imm1          $98A3 {bytecode}, $08
  $9967  0A                         LOADL_quick   ; inline operand = 10
  $9968  D0                         INC
 >$9969  2A                         STORE_quick   ; inline operand = 10
  $996A  0A                         LOADL_quick   ; inline operand = 10
  $996B  D3                         BYTE_DEREF
  $996C  8C FF 00                   LOADR_imm2             $00FF
  $996F  C1                         CMPNE
  $9970  D7 55 99                   JUMPT_abs              $9955
  $9973  CF                         RETURN

; ============================================================
; sub $9974   (frame_off=-2, body @ $9979)
; ============================================================
  $9979  41                         LOADL_qimm   ; inline operand = 1
  $997A  2B                         STORE_quick   ; inline operand = 11
  $997B  D6 A6 99                   JUMP_abs               $99A6
 >$997E  0D                         LOADL_quick   ; inline operand = 13
  $997F  D3                         BYTE_DEREF
  $9980  8C FF 00                   LOADR_imm2             $00FF
  $9983  C0                         CMPEQ
  $9984  D7 AA 99                   JUMPT_abs              $99AA
  $9987  0D                         LOADL_quick   ; inline operand = 13
  $9988  D3                         BYTE_DEREF
  $9989  8C C8 00                   LOADR_imm2             $00C8
  $998C  C1                         CMPNE
  $998D  D8 A3 99                   JUMPF_abs              $99A3
  $9990  0D                         LOADL_quick   ; inline operand = 13
  $9991  D3                         BYTE_DEREF
  $9992  B3                         PUSHL
  $9993  60                         PUSH_qimm   ; inline operand = 0
  $9994  3B                         PUSH_quick   ; inline operand = 11
  $9995  3E                         PUSH_quick   ; inline operand = 14
  $9996  E9 A3 98 08                CALL_abs_imm1          $98A3 {bytecode}, $08
  $999A  3D                         PUSH_quick   ; inline operand = 13
  $999B  89 C8                      BYTE_LOADL_imm1        -56
  $999D  D4                         BYTE_POPSTORE
  $999E  40                         LOADL_qimm   ; inline operand = 0
  $999F  2B                         STORE_quick   ; inline operand = 11
  $99A0  0C                         LOADL_quick   ; inline operand = 12
  $99A1  D1                         DEC
  $99A2  2C                         STORE_quick   ; inline operand = 12
 >$99A3  0D                         LOADL_quick   ; inline operand = 13
  $99A4  D0                         INC
  $99A5  2D                         STORE_quick   ; inline operand = 13
 >$99A6  0C                         LOADL_quick   ; inline operand = 12
  $99A7  D7 7E 99                   JUMPT_abs              $997E
 >$99AA  CF                         RETURN

; ============================================================
; sub $99AB   (frame_off=-8, body @ $99B0)
; ============================================================
  $99B0  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $99B3  61                         PUSH_qimm   ; inline operand = 1
  $99B4  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $99B8  A4 57 6F                   LOADL_abs              $6F57
  $99BB  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $99BE  C0                         CMPEQ
  $99BF  D8 04 9A                   JUMPF_abs              $9A04
  $99C2  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $99C5  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $99C8  BB                         ADD
  $99C9  B3                         PUSHL
  $99CA  45                         LOADL_qimm   ; inline operand = 5
  $99CB  D4                         BYTE_POPSTORE
  $99CC  65                         PUSH_qimm   ; inline operand = 5
  $99CD  62                         PUSH_qimm   ; inline operand = 2
  $99CE  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $99D2  8E 1E BD                   PUSH_imm2              $BD1E
  $99D5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $99D9  40                         LOADL_qimm   ; inline operand = 0
  $99DA  D6 F8 99                   JUMP_abs               $99F8
 >$99DD  3B                         PUSH_quick   ; inline operand = 11
  $99DE  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $99E2  8B 32                      BYTE_LOADR_imm1        +50
  $99E4  C0                         CMPEQ
  $99E5  D8 F6 99                   JUMPF_abs              $99F6
  $99E8  0B                         LOADL_quick   ; inline operand = 11
  $99E9  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $99EC  BB                         ADD
  $99ED  B3                         PUSHL
  $99EE  89 18                      BYTE_LOADL_imm1        +24
  $99F0  D4                         BYTE_POPSTORE
  $99F1  3B                         PUSH_quick   ; inline operand = 11
  $99F2  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
 >$99F6  0B                         LOADL_quick   ; inline operand = 11
  $99F7  D0                         INC
 >$99F8  2B                         STORE_quick   ; inline operand = 11
  $99F9  0B                         LOADL_quick   ; inline operand = 11
  $99FA  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $99FD  C6                         UCMPLT
  $99FE  D7 DD 99                   JUMPT_abs              $99DD
  $9A01  D6 9E 9A                   JUMP_abs               $9A9E
 >$9A04  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9A07  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $9A0A  BB                         ADD
  $9A0B  B3                         PUSHL
  $9A0C  45                         LOADL_qimm   ; inline operand = 5
  $9A0D  D4                         BYTE_POPSTORE
  $9A0E  89 1E                      BYTE_LOADL_imm1        +30
  $9A10  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $9A13  61                         PUSH_qimm   ; inline operand = 1
  $9A14  E9 10 E5 02                CALL_abs_imm1          $E510 (ui_helper_e510) {bytecode}, $02
  $9A18  D0                         INC
  $9A19  2A                         STORE_quick   ; inline operand = 10
  $9A1A  0A                         LOADL_quick   ; inline operand = 10
  $9A1B  53                         LOADR_qimm   ; inline operand = 3
  $9A1C  B8                         UDIV
  $9A1D  2B                         STORE_quick   ; inline operand = 11
  $9A1E  8E 89 6F                   PUSH_imm2              $6F89
  $9A21  0B                         LOADL_quick   ; inline operand = 11
  $9A22  D1                         DEC
  $9A23  B3                         PUSHL
  $9A24  E9 C6 98 04                CALL_abs_imm1          $98C6 {bytecode}, $04
  $9A28  8D 34                      BYTE_PUSH_imm1         +52
  $9A2A  8E 89 6F                   PUSH_imm2              $6F89
  $9A2D  3B                         PUSH_quick   ; inline operand = 11
  $9A2E  E9 74 99 06                CALL_abs_imm1          $9974 {bytecode}, $06
  $9A32  8D 32                      BYTE_PUSH_imm1         +50
  $9A34  8E 89 6F                   PUSH_imm2              $6F89
  $9A37  0B                         LOADL_quick   ; inline operand = 11
  $9A38  D2                         LSHIFT1
  $9A39  B3                         PUSHL
  $9A3A  0A                         LOADL_quick   ; inline operand = 10
  $9A3B  B4                         POPR
  $9A3C  BC                         SUB
  $9A3D  B3                         PUSHL
  $9A3E  E9 74 99 06                CALL_abs_imm1          $9974 {bytecode}, $06
  $9A42  89 33                      BYTE_LOADL_imm1        +51
  $9A44  A9 33 6E                   BYTE_STORE_abs         $6E33
  $9A47  41                         LOADL_qimm   ; inline operand = 1
  $9A48  A9 C0 6D                   BYTE_STORE_abs         $6DC0
  $9A4B  45                         LOADL_qimm   ; inline operand = 5
  $9A4C  A9 15 6D                   BYTE_STORE_abs         $6D15
  $9A4F  8D 1E                      BYTE_PUSH_imm1         +30
  $9A51  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
  $9A55  40                         LOADL_qimm   ; inline operand = 0
  $9A56  28                         STORE_quick   ; inline operand = 8
 >$9A57  08                         LOADL_quick   ; inline operand = 8
  $9A58  8C D5 7F                   LOADR_imm2             $7FD5
  $9A5B  BB                         ADD
  $9A5C  D3                         BYTE_DEREF
  $9A5D  8B 18                      BYTE_LOADR_imm1        +24
  $9A5F  C0                         CMPEQ
  $9A60  D8 6C 9A                   JUMPF_abs              $9A6C
  $9A63  08                         LOADL_quick   ; inline operand = 8
  $9A64  8C D5 7F                   LOADR_imm2             $7FD5
  $9A67  BB                         ADD
  $9A68  B3                         PUSHL
  $9A69  89 33                      BYTE_LOADL_imm1        +51
  $9A6B  D4                         BYTE_POPSTORE
 >$9A6C  08                         LOADL_quick   ; inline operand = 8
  $9A6D  D0                         INC
  $9A6E  28                         STORE_quick   ; inline operand = 8
  $9A6F  08                         LOADL_quick   ; inline operand = 8
  $9A70  58                         LOADR_qimm   ; inline operand = 8
  $9A71  C6                         UCMPLT
  $9A72  D7 57 9A                   JUMPT_abs              $9A57
  $9A75  65                         PUSH_qimm   ; inline operand = 5
  $9A76  62                         PUSH_qimm   ; inline operand = 2
  $9A77  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $9A7B  8E 56 BD                   PUSH_imm2              $BD56
  $9A7E  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9A82  8E 60 BD                   PUSH_imm2              $BD60
  $9A85  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9A89  8E 88 BD                   PUSH_imm2              $BD88
  $9A8C  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9A90  8E 9C BD                   PUSH_imm2              $BD9C
  $9A93  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9A97  8E D8 BD                   PUSH_imm2              $BDD8
  $9A9A  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$9A9E  60                         PUSH_qimm   ; inline operand = 0
  $9A9F  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $9AA3  AC 09 D6                   CALL_abs               $D609 (ui_prompt_redraw) {bytecode}
  $9AA6  66                         PUSH_qimm   ; inline operand = 6
  $9AA7  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (map_helper_e5f2) {bytecode}, $02
  $9AAB  CF                         RETURN

; ============================================================
; sub $9AAC   (frame_off=-2, body @ $9AB1)
; ============================================================
  $9AB1  AC A4 E3                   CALL_abs               $E3A4 (diplomacy_helper) {bytecode}
  $9AB4  2B                         STORE_quick   ; inline operand = 11
  $9AB5  D8 11 9B                   JUMPF_abs              $9B11
  $9AB8  AC 89 CC                   CALL_abs               $CC89 (ui_helper_cc89) {bytecode}
  $9ABB  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9ABE  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $9AC2  3B                         PUSH_quick   ; inline operand = 11
  $9AC3  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9AC6  D0                         INC
  $9AC7  B3                         PUSHL
  $9AC8  8E FE BD                   PUSH_imm2              $BDFE
  $9ACB  E9 34 D1 06                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $06
  $9ACF  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $9AD2  D8 07 9B                   JUMPF_abs              $9B07
  $9AD5  67                         PUSH_qimm   ; inline operand = 7
  $9AD6  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $9ADA  3B                         PUSH_quick   ; inline operand = 11
  $9ADB  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9ADE  8B 1A                      BYTE_LOADR_imm1        +26
  $9AE0  B5                         MULT
  $9AE1  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9AE4  BB                         ADD
  $9AE5  B4                         POPR
  $9AE6  B3                         PUSHL
  $9AE7  B0                         DEREF
  $9AE8  BB                         ADD
  $9AE9  B1                         POPSTORE
  $9AEA  8E 31 BE                   PUSH_imm2              $BE31
  $9AED  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9AF1  AC 4F DA                   CALL_abs               $DA4F (diplomacy_helper2) {bytecode}
  $9AF4  3B                         PUSH_quick   ; inline operand = 11
  $9AF5  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9AF8  8B 1A                      BYTE_LOADR_imm1        +26
  $9AFA  B5                         MULT
  $9AFB  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9AFE  BB                         ADD
  $9AFF  B4                         POPR
  $9B00  B3                         PUSHL
  $9B01  B0                         DEREF
  $9B02  BC                         SUB
  $9B03  B1                         POPSTORE
  $9B04  D6 0E 9B                   JUMP_abs               $9B0E
 >$9B07  8E 57 BE                   PUSH_imm2              $BE57
  $9B0A  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$9B0E  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$9B11  CF                         RETURN

; ============================================================
; sub $9B12   (frame_off=-2, body @ $9B17)
; ============================================================
  $9B17  40                         LOADL_qimm   ; inline operand = 0
  $9B18  D6 71 9B                   JUMP_abs               $9B71
 >$9B1B  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9B1E  8C A2 6D                   LOADR_imm2             $6DA2
  $9B21  BB                         ADD
  $9B22  D3                         BYTE_DEREF
  $9B23  D8 6D 9B                   JUMPF_abs              $9B6D
  $9B26  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9B29  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9B2D  D7 6D 9B                   JUMPT_abs              $9B6D
  $9B30  AC D7 DA                   CALL_abs               $DAD7 (combat_helper_dad7) {bytecode}
  $9B33  8A 4F 6F                   LOADL_imm2             $6F4F
  $9B36  D6 63 9B                   JUMP_abs               $9B63
 >$9B39  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9B3C  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9B3F  0B                         LOADL_quick   ; inline operand = 11
  $9B40  D3                         BYTE_DEREF
  $9B41  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $9B44  AC 1E 8C                   CALL_abs               $8C1E {bytecode}
  $9B47  D8 5B 9B                   JUMPF_abs              $9B5B
  $9B4A  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $9B4D  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $9B50  BB                         ADD
  $9B51  D3                         BYTE_DEREF
  $9B52  D7 5B 9B                   JUMPT_abs              $9B5B
  $9B55  AC AC 9A                   CALL_abs               $9AAC {bytecode}
  $9B58  D6 7E 9B                   JUMP_abs               $9B7E (driver_dam)
 >$9B5B  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9B5E  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $9B61  0B                         LOADL_quick   ; inline operand = 11
  $9B62  D0                         INC
 >$9B63  2B                         STORE_quick   ; inline operand = 11
  $9B64  0B                         LOADL_quick   ; inline operand = 11
  $9B65  D3                         BYTE_DEREF
  $9B66  8C FF 00                   LOADR_imm2             $00FF
  $9B69  C1                         CMPNE
  $9B6A  D7 39 9B                   JUMPT_abs              $9B39
 >$9B6D  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9B70  D0                         INC
 >$9B71  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $9B74  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9B77  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9B7A  C6                         UCMPLT
  $9B7B  D7 1B 9B                   JUMPT_abs              $9B1B
 >$9B7E  CF                         RETURN

; ============================================================
; sub $9B7F   (frame_off=-2, body @ $9B84)
; ============================================================
  $9B84  AC 15 E3                   CALL_abs               $E315 (marry_helper_e315) {bytecode}
  $9B87  2B                         STORE_quick   ; inline operand = 11
  $9B88  D8 E4 9B                   JUMPF_abs              $9BE4
  $9B8B  AC 89 CC                   CALL_abs               $CC89 (ui_helper_cc89) {bytecode}
  $9B8E  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9B91  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $9B95  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9B98  D0                         INC
  $9B99  B3                         PUSHL
  $9B9A  3B                         PUSH_quick   ; inline operand = 11
  $9B9B  8E 78 BE                   PUSH_imm2              $BE78
  $9B9E  E9 34 D1 06                CALL_abs_imm1          $D134 (ui_helper_d134) {bytecode}, $06
  $9BA2  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $9BA5  D8 DA 9B                   JUMPF_abs              $9BDA
  $9BA8  64                         PUSH_qimm   ; inline operand = 4
  $9BA9  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $9BAD  3B                         PUSH_quick   ; inline operand = 11
  $9BAE  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9BB1  8B 1A                      BYTE_LOADR_imm1        +26
  $9BB3  B5                         MULT
  $9BB4  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9BB7  BB                         ADD
  $9BB8  B4                         POPR
  $9BB9  B3                         PUSHL
  $9BBA  B0                         DEREF
  $9BBB  BB                         ADD
  $9BBC  B1                         POPSTORE
  $9BBD  8E BA BE                   PUSH_imm2              $BEBA
  $9BC0  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9BC4  AC 7D DA                   CALL_abs               $DA7D (diplomacy_helper3) {bytecode}
  $9BC7  3B                         PUSH_quick   ; inline operand = 11
  $9BC8  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9BCB  8B 1A                      BYTE_LOADR_imm1        +26
  $9BCD  B5                         MULT
  $9BCE  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9BD1  BB                         ADD
  $9BD2  B4                         POPR
  $9BD3  B3                         PUSHL
  $9BD4  B0                         DEREF
  $9BD5  BC                         SUB
  $9BD6  B1                         POPSTORE
  $9BD7  D6 E1 9B                   JUMP_abs               $9BE1
 >$9BDA  8E E9 BE                   PUSH_imm2              $BEE9
  $9BDD  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$9BE1  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$9BE4  CF                         RETURN

; ============================================================
; sub $9BE5   (frame_off=-4, body @ $9BEA)
; ============================================================
  $9BEA  40                         LOADL_qimm   ; inline operand = 0
  $9BEB  D6 18 9C                   JUMP_abs               $9C18
 >$9BEE  AA 9D 6D                   PUSH_abs               $6D9D (scenario_fief_count)
  $9BF1  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9BF5  2A                         STORE_quick   ; inline operand = 10
  $9BF6  3A                         PUSH_quick   ; inline operand = 10
  $9BF7  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9BFB  D7 16 9C                   JUMPT_abs              $9C16
  $9BFE  AC 45 8C                   CALL_abs               $8C45 {bytecode}
  $9C01  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $9C04  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $9C07  BB                         ADD
  $9C08  D3                         BYTE_DEREF
  $9C09  D7 16 9C                   JUMPT_abs              $9C16
  $9C0C  0A                         LOADL_quick   ; inline operand = 10
  $9C0D  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9C10  AC 7F 9B                   CALL_abs               $9B7F {bytecode}
  $9C13  D6 21 9C                   JUMP_abs               $9C21
 >$9C16  0B                         LOADL_quick   ; inline operand = 11
  $9C17  D0                         INC
 >$9C18  2B                         STORE_quick   ; inline operand = 11
  $9C19  0B                         LOADL_quick   ; inline operand = 11
  $9C1A  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9C1D  C6                         UCMPLT
  $9C1E  D7 EE 9B                   JUMPT_abs              $9BEE
 >$9C21  CF                         RETURN

; ============================================================
; sub $9C22   (frame_off=-4, body @ $9C27)
; ============================================================
  $9C27  40                         LOADL_qimm   ; inline operand = 0
  $9C28  2A                         STORE_quick   ; inline operand = 10
  $9C29  62                         PUSH_qimm   ; inline operand = 2
  $9C2A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9C2E  D8 83 9C                   JUMPF_abs              $9C83
  $9C31  40                         LOADL_qimm   ; inline operand = 0
  $9C32  D6 7A 9C                   JUMP_abs               $9C7A
 >$9C35  8D 14                      BYTE_PUSH_imm1         +20
  $9C37  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9C3B  53                         LOADR_qimm   ; inline operand = 3
  $9C3C  C2                         SCMPLT
  $9C3D  D8 78 9C                   JUMPF_abs              $9C78
  $9C40  3B                         PUSH_quick   ; inline operand = 11
  $9C41  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9C45  D7 78 9C                   JUMPT_abs              $9C78
  $9C48  48                         LOADL_qimm   ; inline operand = 8
  $9C49  A6 09 6E                   LOADR_abs              $6E09
  $9C4C  BC                         SUB
  $9C4D  B3                         PUSHL
  $9C4E  0A                         LOADL_quick   ; inline operand = 10
  $9C4F  D0                         INC
  $9C50  2A                         STORE_quick   ; inline operand = 10
  $9C51  D1                         DEC
  $9C52  B4                         POPR
  $9C53  C6                         UCMPLT
  $9C54  D8 78 9C                   JUMPF_abs              $9C78
  $9C57  AC 45 8C                   CALL_abs               $8C45 {bytecode}
  $9C5A  0B                         LOADL_quick   ; inline operand = 11
  $9C5B  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9C5E  8E 5F 6F                   PUSH_imm2              $6F5F (selected_province_idx)
  $9C61  8E 63 6F                   PUSH_imm2              $6F63 (battle_defending_province)
  $9C64  E9 94 CB 04                CALL_abs_imm1          $CB94 (swap_word) {bytecode}, $04
  $9C68  AC BF 93                   CALL_abs               $93BF {bytecode}
  $9C6B  8E 5F 6F                   PUSH_imm2              $6F5F (selected_province_idx)
  $9C6E  8E 63 6F                   PUSH_imm2              $6F63 (battle_defending_province)
  $9C71  E9 94 CB 04                CALL_abs_imm1          $CB94 (swap_word) {bytecode}, $04
  $9C75  D6 83 9C                   JUMP_abs               $9C83
 >$9C78  0B                         LOADL_quick   ; inline operand = 11
  $9C79  D0                         INC
 >$9C7A  2B                         STORE_quick   ; inline operand = 11
  $9C7B  0B                         LOADL_quick   ; inline operand = 11
  $9C7C  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9C7F  C6                         UCMPLT
  $9C80  D7 35 9C                   JUMPT_abs              $9C35
 >$9C83  CF                         RETURN

; ============================================================
; sub $9C84   (frame_off=+0, body @ $9C89)
; ============================================================
  $9C89  62                         PUSH_qimm   ; inline operand = 2
  $9C8A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9C8E  D8 A6 9C                   JUMPF_abs              $9CA6
  $9C91  64                         PUSH_qimm   ; inline operand = 4
  $9C92  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9C96  D9 02 00 00 00 A3 9C 01 00 A7 9C AD ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 0=>$9CA3 1=>$9CA7 default=>$9CAD
 >$9CA3  AC E5 9B                   CALL_abs               $9BE5 {bytecode}
 >$9CA6  CF                         RETURN
 >$9CA7  AC 12 9B                   CALL_abs               $9B12 {bytecode}
  $9CAA  D6 A6 9C                   JUMP_abs               $9CA6
 >$9CAD  AC 22 9C                   CALL_abs               $9C22 {bytecode}
  $9CB0  D6 A6 9C                   JUMP_abs               $9CA6

; ============================================================
; sub $9CB3   (frame_off=-4, body @ $9CB8)
; ============================================================
  $9CB8  8D 14                      BYTE_PUSH_imm1         +20
  $9CBA  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $9CBE  8A AD 7B                   LOADL_imm2             $7BAD
  $9CC1  D6 F5 9C                   JUMP_abs               $9CF5
 >$9CC4  0B                         LOADL_quick   ; inline operand = 11
  $9CC5  D3                         BYTE_DEREF
  $9CC6  8B 1A                      BYTE_LOADR_imm1        +26
  $9CC8  B5                         MULT
  $9CC9  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9CCC  BB                         ADD
  $9CCD  2A                         STORE_quick   ; inline operand = 10
  $9CCE  64                         PUSH_qimm   ; inline operand = 4
  $9CCF  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9CD3  D0                         INC
  $9CD4  B3                         PUSHL
  $9CD5  0A                         LOADL_quick   ; inline operand = 10
  $9CD6  7E                         ADD_qimm   ; inline operand = 14
  $9CD7  B4                         POPR
  $9CD8  B3                         PUSHL
  $9CD9  B0                         DEREF
  $9CDA  BC                         SUB
  $9CDB  B1                         POPSTORE
  $9CDC  0A                         LOADL_quick   ; inline operand = 10
  $9CDD  78                         ADD_qimm   ; inline operand = 8
  $9CDE  B3                         PUSHL
  $9CDF  8D 5A                      BYTE_PUSH_imm1         +90
  $9CE1  0A                         LOADL_quick   ; inline operand = 10
  $9CE2  7A                         ADD_qimm   ; inline operand = 10
  $9CE3  B0                         DEREF
  $9CE4  B3                         PUSHL
  $9CE5  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9CE9  B3                         PUSHL
  $9CEA  0A                         LOADL_quick   ; inline operand = 10
  $9CEB  78                         ADD_qimm   ; inline operand = 8
  $9CEC  B0                         DEREF
  $9CED  B3                         PUSHL
  $9CEE  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9CF2  B1                         POPSTORE
  $9CF3  0B                         LOADL_quick   ; inline operand = 11
  $9CF4  D0                         INC
 >$9CF5  2B                         STORE_quick   ; inline operand = 11
  $9CF6  0B                         LOADL_quick   ; inline operand = 11
  $9CF7  D3                         BYTE_DEREF
  $9CF8  8C FF 00                   LOADR_imm2             $00FF
  $9CFB  C1                         CMPNE
  $9CFC  D7 C4 9C                   JUMPT_abs              $9CC4
  $9CFF  CF                         RETURN

; ============================================================
; sub $9D00   (frame_off=-6, body @ $9D05)
; ============================================================
  $9D05  8D 1F                      BYTE_PUSH_imm1         +31
  $9D07  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $9D0B  8A AD 7B                   LOADL_imm2             $7BAD
  $9D0E  D6 7B 9D                   JUMP_abs               $9D7B
 >$9D11  0B                         LOADL_quick   ; inline operand = 11
  $9D12  D3                         BYTE_DEREF
  $9D13  8B 1A                      BYTE_LOADR_imm1        +26
  $9D15  B5                         MULT
  $9D16  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9D19  BB                         ADD
  $9D1A  2A                         STORE_quick   ; inline operand = 10
  $9D1B  0A                         LOADL_quick   ; inline operand = 10
  $9D1C  8F 10                      BYTE_ADD_imm1          +16
  $9D1E  B3                         PUSHL
  $9D1F  8D 32                      BYTE_PUSH_imm1         +50
  $9D21  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9D25  8F 32                      BYTE_ADD_imm1          +50
  $9D27  B3                         PUSHL
  $9D28  0A                         LOADL_quick   ; inline operand = 10
  $9D29  8F 10                      BYTE_ADD_imm1          +16
  $9D2B  B0                         DEREF
  $9D2C  B3                         PUSHL
  $9D2D  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9D31  B1                         POPSTORE
  $9D32  0A                         LOADL_quick   ; inline operand = 10
  $9D33  78                         ADD_qimm   ; inline operand = 8
  $9D34  B3                         PUSHL
  $9D35  8D 32                      BYTE_PUSH_imm1         +50
  $9D37  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9D3B  8F 32                      BYTE_ADD_imm1          +50
  $9D3D  B3                         PUSHL
  $9D3E  0A                         LOADL_quick   ; inline operand = 10
  $9D3F  78                         ADD_qimm   ; inline operand = 8
  $9D40  B0                         DEREF
  $9D41  B3                         PUSHL
  $9D42  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9D46  B1                         POPSTORE
  $9D47  0B                         LOADL_quick   ; inline operand = 11
  $9D48  D3                         BYTE_DEREF
  $9D49  8C A2 6D                   LOADR_imm2             $6DA2
  $9D4C  BB                         ADD
  $9D4D  D3                         BYTE_DEREF
  $9D4E  D8 79 9D                   JUMPF_abs              $9D79
  $9D51  69                         PUSH_qimm   ; inline operand = 9
  $9D52  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9D56  D0                         INC
  $9D57  B3                         PUSHL
  $9D58  0B                         LOADL_quick   ; inline operand = 11
  $9D59  D3                         BYTE_DEREF
  $9D5A  B3                         PUSHL
  $9D5B  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $9D5F  29                         STORE_quick   ; inline operand = 9
  $9D60  D0                         INC
  $9D61  B3                         PUSHL
  $9D62  E9 12 CA 04                CALL_abs_imm1          $CA12 (byte_helper_ca12) {bytecode}, $04
  $9D66  0B                         LOADL_quick   ; inline operand = 11
  $9D67  D3                         BYTE_DEREF
  $9D68  B3                         PUSHL
  $9D69  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $9D6D  8C D4 6D                   LOADR_imm2             $6DD4 (daimyo_weakness_flag)
  $9D70  BB                         ADD
  $9D71  B3                         PUSHL
  $9D72  09                         LOADL_quick   ; inline operand = 9
  $9D73  D0                         INC
  $9D74  D3                         BYTE_DEREF
  $9D75  8B 32                      BYTE_LOADR_imm1        +50
  $9D77  C3                         SCMPLE
  $9D78  D4                         BYTE_POPSTORE
 >$9D79  0B                         LOADL_quick   ; inline operand = 11
  $9D7A  D0                         INC
 >$9D7B  2B                         STORE_quick   ; inline operand = 11
  $9D7C  0B                         LOADL_quick   ; inline operand = 11
  $9D7D  D3                         BYTE_DEREF
  $9D7E  8C FF 00                   LOADR_imm2             $00FF
  $9D81  C1                         CMPNE
  $9D82  D7 11 9D                   JUMPT_abs              $9D11
  $9D85  CF                         RETURN

; ============================================================
; sub $9D86   (frame_off=+0, body @ $9D8B)
; ============================================================
  $9D8B  0C                         LOADL_quick   ; inline operand = 12
  $9D8C  8B 32                      BYTE_LOADR_imm1        +50
  $9D8E  C4                         SCMPGT
  $9D8F  D8 95 9D                   JUMPF_abs              $9D95
  $9D92  89 32                      BYTE_LOADL_imm1        +50
  $9D94  2C                         STORE_quick   ; inline operand = 12
 >$9D95  8E E9 07                   PUSH_imm2              $07E9
  $9D98  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9D9C  B3                         PUSHL
  $9D9D  0C                         LOADL_quick   ; inline operand = 12
  $9D9E  1C                         LOADR_quick   ; inline operand = 12
  $9D9F  B5                         MULT
  $9DA0  B4                         POPR
  $9DA1  C2                         SCMPLT
  $9DA2  CF                         RETURN

; ============================================================
; sub $9DA3   (frame_off=+0, body @ $9DA8)
; ============================================================
  $9DA8  0C                         LOADL_quick   ; inline operand = 12
  $9DA9  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9DAC  0C                         LOADL_quick   ; inline operand = 12
  $9DAD  8B 1A                      BYTE_LOADR_imm1        +26
  $9DAF  B5                         MULT
  $9DB0  8C 0D 70                   LOADR_imm2             $700D
  $9DB3  BB                         ADD
  $9DB4  B0                         DEREF
  $9DB5  B3                         PUSHL
  $9DB6  E9 86 9D 02                CALL_abs_imm1          $9D86 {bytecode}, $02
  $9DBA  D7 E9 9D                   JUMPT_abs              $9DE9
  $9DBD  0C                         LOADL_quick   ; inline operand = 12
  $9DBE  8C 2D 6D                   LOADR_imm2             $6D2D
  $9DC1  BB                         ADD
  $9DC2  D3                         BYTE_DEREF
  $9DC3  B3                         PUSHL
  $9DC4  89 64                      BYTE_LOADL_imm1        +100
  $9DC6  B4                         POPR
  $9DC7  BC                         SUB
  $9DC8  B3                         PUSHL
  $9DC9  E9 86 9D 02                CALL_abs_imm1          $9D86 {bytecode}, $02
  $9DCD  D7 E9 9D                   JUMPT_abs              $9DE9
  $9DD0  3C                         PUSH_quick   ; inline operand = 12
  $9DD1  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $9DD5  74                         ADD_qimm   ; inline operand = 4
  $9DD6  D3                         BYTE_DEREF
  $9DD7  B3                         PUSHL
  $9DD8  E9 86 9D 02                CALL_abs_imm1          $9D86 {bytecode}, $02
  $9DDC  D7 E9 9D                   JUMPT_abs              $9DE9
  $9DDF  8E E8 03                   PUSH_imm2              $03E8
  $9DE2  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9DE6  D7 1B 9E                   JUMPT_abs              $9E1B
 >$9DE9  0C                         LOADL_quick   ; inline operand = 12
  $9DEA  8B 1A                      BYTE_LOADR_imm1        +26
  $9DEC  B5                         MULT
  $9DED  8C 09 70                   LOADR_imm2             $7009
  $9DF0  BB                         ADD
  $9DF1  B0                         DEREF
  $9DF2  50                         LOADR_qimm   ; inline operand = 0
  $9DF3  C4                         SCMPGT
  $9DF4  D8 1B 9E                   JUMPF_abs              $9E1B
  $9DF7  0C                         LOADL_quick   ; inline operand = 12
  $9DF8  8B 1A                      BYTE_LOADR_imm1        +26
  $9DFA  B5                         MULT
  $9DFB  8C 11 70                   LOADR_imm2             $7011
  $9DFE  BB                         ADD
  $9DFF  B0                         DEREF
  $9E00  52                         LOADR_qimm   ; inline operand = 2
  $9E01  C4                         SCMPGT
  $9E02  D8 1B 9E                   JUMPF_abs              $9E1B
  $9E05  AC 12 DB                   CALL_abs               $DB12 (tax_helper_db12) {bytecode}
  $9E08  D7 1B 9E                   JUMPT_abs              $9E1B
  $9E0B  3C                         PUSH_quick   ; inline operand = 12
  $9E0C  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $9E10  D7 1B 9E                   JUMPT_abs              $9E1B
  $9E13  64                         PUSH_qimm   ; inline operand = 4
  $9E14  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9E18  D8 1F 9E                   JUMPF_abs              $9E1F
 >$9E1B  40                         LOADL_qimm   ; inline operand = 0
  $9E1C  D6 20 9E                   JUMP_abs               $9E20
 >$9E1F  41                         LOADL_qimm   ; inline operand = 1
 >$9E20  CF                         RETURN

; ============================================================
; sub $9E21   (frame_off=+0, body @ $9E26)
; ============================================================
  $9E26  0C                         LOADL_quick   ; inline operand = 12
  $9E27  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9E2A  0C                         LOADL_quick   ; inline operand = 12
  $9E2B  8B 1A                      BYTE_LOADR_imm1        +26
  $9E2D  B5                         MULT
  $9E2E  8C 13 70                   LOADR_imm2             $7013
  $9E31  BB                         ADD
  $9E32  B0                         DEREF
  $9E33  B3                         PUSHL
  $9E34  E9 86 9D 02                CALL_abs_imm1          $9D86 {bytecode}, $02
  $9E38  D7 60 9E                   JUMPT_abs              $9E60
  $9E3B  3C                         PUSH_quick   ; inline operand = 12
  $9E3C  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $9E40  74                         ADD_qimm   ; inline operand = 4
  $9E41  D3                         BYTE_DEREF
  $9E42  B3                         PUSHL
  $9E43  E9 86 9D 02                CALL_abs_imm1          $9D86 {bytecode}, $02
  $9E47  D7 60 9E                   JUMPT_abs              $9E60
  $9E4A  AC 12 DB                   CALL_abs               $DB12 (tax_helper_db12) {bytecode}
  $9E4D  D8 55 9E                   JUMPF_abs              $9E55
  $9E50  89 14                      BYTE_LOADL_imm1        +20
  $9E52  D6 58 9E                   JUMP_abs               $9E58
 >$9E55  8A E8 03                   LOADL_imm2             $03E8
 >$9E58  B3                         PUSHL
  $9E59  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9E5D  D7 76 9E                   JUMPT_abs              $9E76
 >$9E60  0C                         LOADL_quick   ; inline operand = 12
  $9E61  8B 1A                      BYTE_LOADR_imm1        +26
  $9E63  B5                         MULT
  $9E64  8C 11 70                   LOADR_imm2             $7011
  $9E67  BB                         ADD
  $9E68  B0                         DEREF
  $9E69  52                         LOADR_qimm   ; inline operand = 2
  $9E6A  C4                         SCMPGT
  $9E6B  D8 76 9E                   JUMPF_abs              $9E76
  $9E6E  3C                         PUSH_quick   ; inline operand = 12
  $9E6F  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $9E73  D8 7A 9E                   JUMPF_abs              $9E7A
 >$9E76  40                         LOADL_qimm   ; inline operand = 0
  $9E77  D6 7B 9E                   JUMP_abs               $9E7B
 >$9E7A  41                         LOADL_qimm   ; inline operand = 1
 >$9E7B  CF                         RETURN

; ============================================================
; sub $9E7C   (frame_off=+0, body @ $9E81)
; ============================================================
  $9E81  3D                         PUSH_quick   ; inline operand = 13
  $9E82  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $9E86  D8 8B 9E                   JUMPF_abs              $9E8B
  $9E89  40                         LOADL_qimm   ; inline operand = 0
  $9E8A  CF                         RETURN
 >$9E8B  0C                         LOADL_quick   ; inline operand = 12
  $9E8C  51                         LOADR_qimm   ; inline operand = 1
  $9E8D  C0                         CMPEQ
  $9E8E  D8 97 9E                   JUMPF_abs              $9E97
  $9E91  3D                         PUSH_quick   ; inline operand = 13
  $9E92  E9 A3 9D 02                CALL_abs_imm1          $9DA3 {bytecode}, $02
  $9E96  CF                         RETURN
 >$9E97  3D                         PUSH_quick   ; inline operand = 13
  $9E98  E9 21 9E 02                CALL_abs_imm1          $9E21 {bytecode}, $02
  $9E9C  CF                         RETURN

; ============================================================
; sub $9E9D   (frame_off=-6, body @ $9EA2)
; ============================================================
  $9EA2  40                         LOADL_qimm   ; inline operand = 0
  $9EA3  29                         STORE_quick   ; inline operand = 9
  $9EA4  8A AD 7B                   LOADL_imm2             $7BAD
  $9EA7  2B                         STORE_quick   ; inline operand = 11
  $9EA8  40                         LOADL_qimm   ; inline operand = 0
  $9EA9  D6 CA 9E                   JUMP_abs               $9ECA
 >$9EAC  0A                         LOADL_quick   ; inline operand = 10
  $9EAD  8C 1B 6F                   LOADR_imm2             $6F1B
  $9EB0  BB                         ADD
  $9EB1  D3                         BYTE_DEREF
  $9EB2  B3                         PUSHL
  $9EB3  3C                         PUSH_quick   ; inline operand = 12
  $9EB4  E9 7C 9E 04                CALL_abs_imm1          $9E7C {bytecode}, $04
  $9EB8  D8 C8 9E                   JUMPF_abs              $9EC8
  $9EBB  3B                         PUSH_quick   ; inline operand = 11
  $9EBC  0A                         LOADL_quick   ; inline operand = 10
  $9EBD  8C 1B 6F                   LOADR_imm2             $6F1B
  $9EC0  BB                         ADD
  $9EC1  D3                         BYTE_DEREF
  $9EC2  D4                         BYTE_POPSTORE
  $9EC3  0B                         LOADL_quick   ; inline operand = 11
  $9EC4  D0                         INC
  $9EC5  2B                         STORE_quick   ; inline operand = 11
  $9EC6  41                         LOADL_qimm   ; inline operand = 1
  $9EC7  29                         STORE_quick   ; inline operand = 9
 >$9EC8  0A                         LOADL_quick   ; inline operand = 10
  $9EC9  D0                         INC
 >$9ECA  2A                         STORE_quick   ; inline operand = 10
  $9ECB  0A                         LOADL_quick   ; inline operand = 10
  $9ECC  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $9ECF  C6                         UCMPLT
  $9ED0  D7 AC 9E                   JUMPT_abs              $9EAC
  $9ED3  3B                         PUSH_quick   ; inline operand = 11
  $9ED4  89 FF                      BYTE_LOADL_imm1        -1
  $9ED6  D4                         BYTE_POPSTORE
  $9ED7  09                         LOADL_quick   ; inline operand = 9
  $9ED8  CF                         RETURN

; ============================================================
; sub $9ED9   (frame_off=-6, body @ $9EDE)
; ============================================================
  $9EDE  41                         LOADL_qimm   ; inline operand = 1
  $9EDF  2B                         STORE_quick   ; inline operand = 11
  $9EE0  62                         PUSH_qimm   ; inline operand = 2
  $9EE1  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9EE5  2A                         STORE_quick   ; inline operand = 10
  $9EE6  40                         LOADL_qimm   ; inline operand = 0
  $9EE7  D6 00 9F                   JUMP_abs               $9F00
 >$9EEA  0A                         LOADL_quick   ; inline operand = 10
  $9EEB  D0                         INC
  $9EEC  B3                         PUSHL
  $9EED  E9 9D 9E 02                CALL_abs_imm1          $9E9D {bytecode}, $02
  $9EF1  D8 F9 9E                   JUMPF_abs              $9EF9
  $9EF4  40                         LOADL_qimm   ; inline operand = 0
  $9EF5  2B                         STORE_quick   ; inline operand = 11
  $9EF6  D6 07 9F                   JUMP_abs               $9F07
 >$9EF9  41                         LOADL_qimm   ; inline operand = 1
  $9EFA  CD                         SWAP
  $9EFB  0A                         LOADL_quick   ; inline operand = 10
  $9EFC  DC                         XOR
  $9EFD  2A                         STORE_quick   ; inline operand = 10
  $9EFE  09                         LOADL_quick   ; inline operand = 9
  $9EFF  D0                         INC
 >$9F00  29                         STORE_quick   ; inline operand = 9
  $9F01  09                         LOADL_quick   ; inline operand = 9
  $9F02  52                         LOADR_qimm   ; inline operand = 2
  $9F03  C6                         UCMPLT
  $9F04  D7 EA 9E                   JUMPT_abs              $9EEA
 >$9F07  0B                         LOADL_quick   ; inline operand = 11
  $9F08  51                         LOADR_qimm   ; inline operand = 1
  $9F09  C0                         CMPEQ
  $9F0A  D8 11 9F                   JUMPF_abs              $9F11
  $9F0D  AC 84 9C                   CALL_abs               $9C84 {bytecode}
 >$9F10  CF                         RETURN
 >$9F11  0A                         LOADL_quick   ; inline operand = 10
  $9F12  D9 02 00 00 00 1F 9F 01 00 3B 9F 10 ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 0=>$9F1F 1=>$9F3B default=>$9F10
 >$9F1F  8D 1E                      BYTE_PUSH_imm1         +30
  $9F21  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $9F25  8E 0B BF                   PUSH_imm2              $BF0B
  $9F28  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9F2C  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9F2F  8D 17                      BYTE_PUSH_imm1         +23
  $9F31  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $9F35  AC F8 8F                   CALL_abs               $8FF8 {bytecode}
  $9F38  D6 10 9F                   JUMP_abs               $9F10
 >$9F3B  8D 1E                      BYTE_PUSH_imm1         +30
  $9F3D  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $9F41  8E 10 BF                   PUSH_imm2              $BF10
  $9F44  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9F48  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9F4B  8D 19                      BYTE_PUSH_imm1         +25
  $9F4D  E9 0C E8 02                CALL_abs_imm1          $E80C (ui_helper_e80c) {bytecode}, $02
  $9F51  AC 78 97                   CALL_abs               $9778 {bytecode}
  $9F54  D6 10 9F                   JUMP_abs               $9F10

; ============================================================
; sub $9F57   (frame_off=-2, body @ $9F5C)
; ============================================================
  $9F5C  3C                         PUSH_quick   ; inline operand = 12
  $9F5D  E9 6D 94 02                CALL_abs_imm1          $946D {bytecode}, $02
  $9F61  5A                         LOADR_qimm   ; inline operand = 10
  $9F62  B6                         SDIV
  $9F63  2B                         STORE_quick   ; inline operand = 11
  $9F64  62                         PUSH_qimm   ; inline operand = 2
  $9F65  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9F69  D8 8B 9F                   JUMPF_abs              $9F8B
  $9F6C  6A                         PUSH_qimm   ; inline operand = 10
  $9F6D  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9F71  1B                         LOADR_quick   ; inline operand = 11
  $9F72  BB                         ADD
  $9F73  B3                         PUSHL
  $9F74  0D                         LOADL_quick   ; inline operand = 13
  $9F75  7E                         ADD_qimm   ; inline operand = 14
  $9F76  B4                         POPR
  $9F77  B3                         PUSHL
  $9F78  B0                         DEREF
  $9F79  BB                         ADD
  $9F7A  B1                         POPSTORE
  $9F7B  8D 28                      BYTE_PUSH_imm1         +40
  $9F7D  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9F81  1B                         LOADR_quick   ; inline operand = 11
  $9F82  BB                         ADD
  $9F83  B3                         PUSHL
  $9F84  0D                         LOADL_quick   ; inline operand = 13
  $9F85  7C                         ADD_qimm   ; inline operand = 12
  $9F86  B4                         POPR
  $9F87  B3                         PUSHL
  $9F88  B0                         DEREF
  $9F89  BB                         ADD
  $9F8A  B1                         POPSTORE
 >$9F8B  CF                         RETURN

; ============================================================
; sub $9F8C   (frame_off=-8, body @ $9F91)
; ============================================================
  $9F91  A4 9F 6D                   LOADL_abs              $6D9F
  $9F94  8C 18 06                   LOADR_imm2             $0618
  $9F97  C1                         CMPNE
  $9F98  D8 37 A0                   JUMPF_abs              $A037
  $9F9B  64                         PUSH_qimm   ; inline operand = 4
  $9F9C  E9 E8 90 02                CALL_abs_imm1          $90E8 {bytecode}, $02
  $9FA0  62                         PUSH_qimm   ; inline operand = 2
  $9FA1  E9 1E 91 02                CALL_abs_imm1          $911E {bytecode}, $02
  $9FA5  40                         LOADL_qimm   ; inline operand = 0
  $9FA6  2B                         STORE_quick   ; inline operand = 11
  $9FA7  60                         PUSH_qimm   ; inline operand = 0
  $9FA8  E9 CD D7 02                CALL_abs_imm1          $D7CD (daimyo_record_addr) {bytecode}, $02
  $9FAC  29                         STORE_quick   ; inline operand = 9
  $9FAD  D6 C4 9F                   JUMP_abs               $9FC4
 >$9FB0  09                         LOADL_quick   ; inline operand = 9
  $9FB1  B3                         PUSHL
  $9FB2  D3                         BYTE_DEREF
  $9FB3  D0                         INC
  $9FB4  D4                         BYTE_POPSTORE
  $9FB5  09                         LOADL_quick   ; inline operand = 9
  $9FB6  D0                         INC
  $9FB7  B3                         PUSHL
  $9FB8  D3                         BYTE_DEREF
  $9FB9  D1                         DEC
  $9FBA  D4                         BYTE_POPSTORE
  $9FBB  0B                         LOADL_quick   ; inline operand = 11
  $9FBC  D0                         INC
  $9FBD  2B                         STORE_quick   ; inline operand = 11
  $9FBE  D1                         DEC
  $9FBF  09                         LOADL_quick   ; inline operand = 9
  $9FC0  77                         ADD_qimm   ; inline operand = 7
  $9FC1  29                         STORE_quick   ; inline operand = 9
  $9FC2  8F F9                      BYTE_ADD_imm1          -7
 >$9FC4  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $9FC7  73                         ADD_qimm   ; inline operand = 3
  $9FC8  B3                         PUSHL
  $9FC9  0B                         LOADL_quick   ; inline operand = 11
  $9FCA  B4                         POPR
  $9FCB  C6                         UCMPLT
  $9FCC  D7 B0 9F                   JUMPT_abs              $9FB0
  $9FCF  40                         LOADL_qimm   ; inline operand = 0
  $9FD0  D6 2B A0                   JUMP_abs               $A02B
 >$9FD3  3B                         PUSH_quick   ; inline operand = 11
  $9FD4  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9FD8  D7 E9 9F                   JUMPT_abs              $9FE9
  $9FDB  0B                         LOADL_quick   ; inline operand = 11
  $9FDC  8B 1A                      BYTE_LOADR_imm1        +26
  $9FDE  B5                         MULT
  $9FDF  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9FE2  BB                         ADD
  $9FE3  B3                         PUSHL
  $9FE4  3B                         PUSH_quick   ; inline operand = 11
  $9FE5  E9 57 9F 04                CALL_abs_imm1          $9F57 {bytecode}, $04
 >$9FE9  0B                         LOADL_quick   ; inline operand = 11
  $9FEA  8B 1A                      BYTE_LOADR_imm1        +26
  $9FEC  B5                         MULT
  $9FED  8C 0D 70                   LOADR_imm2             $700D
  $9FF0  BB                         ADD
  $9FF1  2A                         STORE_quick   ; inline operand = 10
  $9FF2  3B                         PUSH_quick   ; inline operand = 11
  $9FF3  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9FF7  D8 29 A0                   JUMPF_abs              $A029
  $9FFA  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $9FFD  51                         LOADR_qimm   ; inline operand = 1
  $9FFE  C1                         CMPNE
  $9FFF  D8 29 A0                   JUMPF_abs              $A029
  $A002  AA 63 6D                   PUSH_abs               $6D63 (const_two)
  $A005  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A009  28                         STORE_quick   ; inline operand = 8
  $A00A  38                         PUSH_quick   ; inline operand = 8
  $A00B  0A                         LOADL_quick   ; inline operand = 10
  $A00C  72                         ADD_qimm   ; inline operand = 2
  $A00D  2A                         STORE_quick   ; inline operand = 10
  $A00E  8F FE                      BYTE_ADD_imm1          -2
  $A010  B4                         POPR
  $A011  B3                         PUSHL
  $A012  B0                         DEREF
  $A013  BC                         SUB
  $A014  B1                         POPSTORE
  $A015  38                         PUSH_quick   ; inline operand = 8
  $A016  0A                         LOADL_quick   ; inline operand = 10
  $A017  72                         ADD_qimm   ; inline operand = 2
  $A018  2A                         STORE_quick   ; inline operand = 10
  $A019  8F FE                      BYTE_ADD_imm1          -2
  $A01B  B4                         POPR
  $A01C  B3                         PUSHL
  $A01D  B0                         DEREF
  $A01E  BC                         SUB
  $A01F  B1                         POPSTORE
  $A020  38                         PUSH_quick   ; inline operand = 8
  $A021  0A                         LOADL_quick   ; inline operand = 10
  $A022  72                         ADD_qimm   ; inline operand = 2
  $A023  2A                         STORE_quick   ; inline operand = 10
  $A024  B4                         POPR
  $A025  B3                         PUSHL
  $A026  B0                         DEREF
  $A027  BC                         SUB
  $A028  B1                         POPSTORE
 >$A029  0B                         LOADL_quick   ; inline operand = 11
  $A02A  D0                         INC
 >$A02B  2B                         STORE_quick   ; inline operand = 11
  $A02C  0B                         LOADL_quick   ; inline operand = 11
  $A02D  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A030  C6                         UCMPLT
  $A031  D7 D3 9F                   JUMPT_abs              $9FD3
  $A034  D6 65 A0                   JUMP_abs               $A065
 >$A037  8D 18                      BYTE_PUSH_imm1         +24
  $A039  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $A03D  D8 4E A0                   JUMPF_abs              $A04E
  $A040  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $A043  8B 32                      BYTE_LOADR_imm1        +50
  $A045  C0                         CMPEQ
  $A046  D8 4E A0                   JUMPF_abs              $A04E
  $A049  89 64                      BYTE_LOADL_imm1        +100
  $A04B  A8 71 72                   STORE_abs              $7271
 >$A04E  8D 10                      BYTE_PUSH_imm1         +16
  $A050  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $A054  D8 65 A0                   JUMPF_abs              $A065
  $A057  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $A05A  8B 11                      BYTE_LOADR_imm1        +17
  $A05C  C0                         CMPEQ
  $A05D  D8 65 A0                   JUMPF_abs              $A065
  $A060  89 64                      BYTE_LOADL_imm1        +100
  $A062  A8 A1 71                   STORE_abs              $71A1
 >$A065  CF                         RETURN

; ============================================================
; sub $A066   (frame_off=-8, body @ $A06B)
; ============================================================
  $A06B  62                         PUSH_qimm   ; inline operand = 2
  $A06C  E9 E8 90 02                CALL_abs_imm1          $90E8 {bytecode}, $02
  $A070  40                         LOADL_qimm   ; inline operand = 0
  $A071  D6 9F A0                   JUMP_abs               $A09F
 >$A074  0B                         LOADL_quick   ; inline operand = 11
  $A075  53                         LOADR_qimm   ; inline operand = 3
  $A076  BD                         LSHIFT
  $A077  8C 03 60                   LOADR_imm2             $6003 (fief_history_table)
  $A07A  BB                         ADD
  $A07B  29                         STORE_quick   ; inline operand = 9
  $A07C  0B                         LOADL_quick   ; inline operand = 11
  $A07D  8B 1A                      BYTE_LOADR_imm1        +26
  $A07F  B5                         MULT
  $A080  8C 09 70                   LOADR_imm2             $7009
  $A083  BB                         ADD
  $A084  28                         STORE_quick   ; inline operand = 8
  $A085  40                         LOADL_qimm   ; inline operand = 0
  $A086  2A                         STORE_quick   ; inline operand = 10
 >$A087  09                         LOADL_quick   ; inline operand = 9
  $A088  72                         ADD_qimm   ; inline operand = 2
  $A089  29                         STORE_quick   ; inline operand = 9
  $A08A  8F FE                      BYTE_ADD_imm1          -2
  $A08C  B3                         PUSHL
  $A08D  08                         LOADL_quick   ; inline operand = 8
  $A08E  72                         ADD_qimm   ; inline operand = 2
  $A08F  28                         STORE_quick   ; inline operand = 8
  $A090  8F FE                      BYTE_ADD_imm1          -2
  $A092  B0                         DEREF
  $A093  B1                         POPSTORE
  $A094  0A                         LOADL_quick   ; inline operand = 10
  $A095  D0                         INC
  $A096  2A                         STORE_quick   ; inline operand = 10
  $A097  0A                         LOADL_quick   ; inline operand = 10
  $A098  54                         LOADR_qimm   ; inline operand = 4
  $A099  C6                         UCMPLT
  $A09A  D7 87 A0                   JUMPT_abs              $A087
  $A09D  0B                         LOADL_quick   ; inline operand = 11
  $A09E  D0                         INC
 >$A09F  2B                         STORE_quick   ; inline operand = 11
  $A0A0  0B                         LOADL_quick   ; inline operand = 11
  $A0A1  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A0A4  C6                         UCMPLT
  $A0A5  D7 74 A0                   JUMPT_abs              $A074
  $A0A8  CF                         RETURN

; ============================================================
; sub $A0A9   (frame_off=-4, body @ $A0AE)
; ============================================================
  $A0AE  0C                         LOADL_quick   ; inline operand = 12
  $A0AF  8B 1A                      BYTE_LOADR_imm1        +26
  $A0B1  B5                         MULT
  $A0B2  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A0B5  BB                         ADD
  $A0B6  2B                         STORE_quick   ; inline operand = 11
  $A0B7  0B                         LOADL_quick   ; inline operand = 11
  $A0B8  78                         ADD_qimm   ; inline operand = 8
  $A0B9  B0                         DEREF
  $A0BA  2A                         STORE_quick   ; inline operand = 10
  $A0BB  B3                         PUSHL
  $A0BC  0C                         LOADL_quick   ; inline operand = 12
  $A0BD  53                         LOADR_qimm   ; inline operand = 3
  $A0BE  BD                         LSHIFT
  $A0BF  8C 03 60                   LOADR_imm2             $6003 (fief_history_table)
  $A0C2  BB                         ADD
  $A0C3  B0                         DEREF
  $A0C4  B4                         POPR
  $A0C5  C5                         SCMPGE
  $A0C6  D8 D3 A0                   JUMPF_abs              $A0D3
  $A0C9  0C                         LOADL_quick   ; inline operand = 12
  $A0CA  53                         LOADR_qimm   ; inline operand = 3
  $A0CB  BD                         LSHIFT
  $A0CC  8C 03 60                   LOADR_imm2             $6003 (fief_history_table)
  $A0CF  BB                         ADD
  $A0D0  B3                         PUSHL
  $A0D1  0A                         LOADL_quick   ; inline operand = 10
  $A0D2  B1                         POPSTORE
 >$A0D3  0B                         LOADL_quick   ; inline operand = 11
  $A0D4  7A                         ADD_qimm   ; inline operand = 10
  $A0D5  B0                         DEREF
  $A0D6  2A                         STORE_quick   ; inline operand = 10
  $A0D7  B3                         PUSHL
  $A0D8  0C                         LOADL_quick   ; inline operand = 12
  $A0D9  53                         LOADR_qimm   ; inline operand = 3
  $A0DA  BD                         LSHIFT
  $A0DB  8C 05 60                   LOADR_imm2             $6005
  $A0DE  BB                         ADD
  $A0DF  B0                         DEREF
  $A0E0  B4                         POPR
  $A0E1  C5                         SCMPGE
  $A0E2  D8 EF A0                   JUMPF_abs              $A0EF
  $A0E5  0C                         LOADL_quick   ; inline operand = 12
  $A0E6  53                         LOADR_qimm   ; inline operand = 3
  $A0E7  BD                         LSHIFT
  $A0E8  8C 05 60                   LOADR_imm2             $6005
  $A0EB  BB                         ADD
  $A0EC  B3                         PUSHL
  $A0ED  0A                         LOADL_quick   ; inline operand = 10
  $A0EE  B1                         POPSTORE
 >$A0EF  0B                         LOADL_quick   ; inline operand = 11
  $A0F0  7C                         ADD_qimm   ; inline operand = 12
  $A0F1  B0                         DEREF
  $A0F2  2A                         STORE_quick   ; inline operand = 10
  $A0F3  B3                         PUSHL
  $A0F4  0C                         LOADL_quick   ; inline operand = 12
  $A0F5  53                         LOADR_qimm   ; inline operand = 3
  $A0F6  BD                         LSHIFT
  $A0F7  8C 07 60                   LOADR_imm2             $6007
  $A0FA  BB                         ADD
  $A0FB  B0                         DEREF
  $A0FC  B4                         POPR
  $A0FD  C5                         SCMPGE
  $A0FE  D8 0B A1                   JUMPF_abs              $A10B
  $A101  0C                         LOADL_quick   ; inline operand = 12
  $A102  53                         LOADR_qimm   ; inline operand = 3
  $A103  BD                         LSHIFT
  $A104  8C 07 60                   LOADR_imm2             $6007
  $A107  BB                         ADD
  $A108  B3                         PUSHL
  $A109  0A                         LOADL_quick   ; inline operand = 10
  $A10A  B1                         POPSTORE
 >$A10B  0B                         LOADL_quick   ; inline operand = 11
  $A10C  7E                         ADD_qimm   ; inline operand = 14
  $A10D  B0                         DEREF
  $A10E  2A                         STORE_quick   ; inline operand = 10
  $A10F  B3                         PUSHL
  $A110  0C                         LOADL_quick   ; inline operand = 12
  $A111  53                         LOADR_qimm   ; inline operand = 3
  $A112  BD                         LSHIFT
  $A113  8C 09 60                   LOADR_imm2             $6009
  $A116  BB                         ADD
  $A117  B0                         DEREF
  $A118  B4                         POPR
  $A119  C5                         SCMPGE
  $A11A  D8 27 A1                   JUMPF_abs              $A127
  $A11D  0C                         LOADL_quick   ; inline operand = 12
  $A11E  53                         LOADR_qimm   ; inline operand = 3
  $A11F  BD                         LSHIFT
  $A120  8C 09 60                   LOADR_imm2             $6009
  $A123  BB                         ADD
  $A124  B3                         PUSHL
  $A125  0A                         LOADL_quick   ; inline operand = 10
  $A126  B1                         POPSTORE
 >$A127  CF                         RETURN

; ============================================================
; sub $A128   (frame_off=-2, body @ $A12D)
; ============================================================
  $A12D  3C                         PUSH_quick   ; inline operand = 12
  $A12E  E9 6D 94 02                CALL_abs_imm1          $946D {bytecode}, $02
  $A132  5A                         LOADR_qimm   ; inline operand = 10
  $A133  B6                         SDIV
  $A134  2B                         STORE_quick   ; inline operand = 11
  $A135  6A                         PUSH_qimm   ; inline operand = 10
  $A136  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A13A  1B                         LOADR_quick   ; inline operand = 11
  $A13B  BB                         ADD
  $A13C  B3                         PUSHL
  $A13D  0D                         LOADL_quick   ; inline operand = 13
  $A13E  B4                         POPR
  $A13F  B3                         PUSHL
  $A140  B0                         DEREF
  $A141  BB                         ADD
  $A142  B1                         POPSTORE
  $A143  62                         PUSH_qimm   ; inline operand = 2
  $A144  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A148  D8 5A A1                   JUMPF_abs              $A15A
  $A14B  6A                         PUSH_qimm   ; inline operand = 10
  $A14C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A150  1B                         LOADR_quick   ; inline operand = 11
  $A151  BB                         ADD
  $A152  B3                         PUSHL
  $A153  0D                         LOADL_quick   ; inline operand = 13
  $A154  78                         ADD_qimm   ; inline operand = 8
  $A155  B4                         POPR
  $A156  B3                         PUSHL
  $A157  B0                         DEREF
  $A158  BB                         ADD
  $A159  B1                         POPSTORE
 >$A15A  CF                         RETURN

; ============================================================
; sub $A15B   (frame_off=-4, body @ $A160)
; ============================================================
  $A160  0C                         LOADL_quick   ; inline operand = 12
  $A161  8F 10                      BYTE_ADD_imm1          +16
  $A163  B0                         DEREF
  $A164  52                         LOADR_qimm   ; inline operand = 2
  $A165  B6                         SDIV
  $A166  2B                         STORE_quick   ; inline operand = 11
  $A167  0C                         LOADL_quick   ; inline operand = 12
  $A168  76                         ADD_qimm   ; inline operand = 6
  $A169  B0                         DEREF
  $A16A  B3                         PUSHL
  $A16B  0C                         LOADL_quick   ; inline operand = 12
  $A16C  B0                         DEREF
  $A16D  B3                         PUSHL
  $A16E  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $A172  2A                         STORE_quick   ; inline operand = 10
  $A173  1B                         LOADR_quick   ; inline operand = 11
  $A174  C2                         SCMPLT
  $A175  D8 81 A1                   JUMPF_abs              $A181
  $A178  0A                         LOADL_quick   ; inline operand = 10
  $A179  2B                         STORE_quick   ; inline operand = 11
  $A17A  0C                         LOADL_quick   ; inline operand = 12
  $A17B  8F 10                      BYTE_ADD_imm1          +16
  $A17D  B3                         PUSHL
  $A17E  0A                         LOADL_quick   ; inline operand = 10
  $A17F  D2                         LSHIFT1
  $A180  B1                         POPSTORE
 >$A181  3B                         PUSH_quick   ; inline operand = 11
  $A182  0C                         LOADL_quick   ; inline operand = 12
  $A183  B4                         POPR
  $A184  B3                         PUSHL
  $A185  B0                         DEREF
  $A186  BC                         SUB
  $A187  B1                         POPSTORE
  $A188  3B                         PUSH_quick   ; inline operand = 11
  $A189  0C                         LOADL_quick   ; inline operand = 12
  $A18A  76                         ADD_qimm   ; inline operand = 6
  $A18B  B4                         POPR
  $A18C  B3                         PUSHL
  $A18D  B0                         DEREF
  $A18E  BC                         SUB
  $A18F  B1                         POPSTORE
  $A190  CF                         RETURN

; ============================================================
; sub $A191   (frame_off=+0, body @ $A196)
; ============================================================
  $A196  0C                         LOADL_quick   ; inline operand = 12
  $A197  8C 2D 6D                   LOADR_imm2             $6D2D
  $A19A  BB                         ADD
  $A19B  D3                         BYTE_DEREF
  $A19C  B3                         PUSHL
  $A19D  3C                         PUSH_quick   ; inline operand = 12
  $A19E  E9 6D 94 02                CALL_abs_imm1          $946D {bytecode}, $02
  $A1A2  52                         LOADR_qimm   ; inline operand = 2
  $A1A3  B6                         SDIV
  $A1A4  B3                         PUSHL
  $A1A5  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A1A9  CF                         RETURN

; ============================================================
; sub $A1AA   (frame_off=+0, body @ $A1AF)
; ============================================================
  $A1AF  0C                         LOADL_quick   ; inline operand = 12
  $A1B0  8C 2D 6D                   LOADR_imm2             $6D2D
  $A1B3  BB                         ADD
  $A1B4  D3                         BYTE_DEREF
  $A1B5  B3                         PUSHL
  $A1B6  8D 28                      BYTE_PUSH_imm1         +40
  $A1B8  0C                         LOADL_quick   ; inline operand = 12
  $A1B9  53                         LOADR_qimm   ; inline operand = 3
  $A1BA  BD                         LSHIFT
  $A1BB  8C 07 60                   LOADR_imm2             $6007
  $A1BE  BB                         ADD
  $A1BF  B0                         DEREF
  $A1C0  B3                         PUSHL
  $A1C1  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A1C5  B3                         PUSHL
  $A1C6  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A1CA  B3                         PUSHL
  $A1CB  0C                         LOADL_quick   ; inline operand = 12
  $A1CC  8C 2D 6D                   LOADR_imm2             $6D2D
  $A1CF  BB                         ADD
  $A1D0  D3                         BYTE_DEREF
  $A1D1  B3                         PUSHL
  $A1D2  0C                         LOADL_quick   ; inline operand = 12
  $A1D3  53                         LOADR_qimm   ; inline operand = 3
  $A1D4  BD                         LSHIFT
  $A1D5  8C 09 60                   LOADR_imm2             $6009
  $A1D8  BB                         ADD
  $A1D9  B0                         DEREF
  $A1DA  B3                         PUSHL
  $A1DB  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A1DF  B4                         POPR
  $A1E0  BB                         ADD
  $A1E1  CF                         RETURN

; ============================================================
; sub $A1E2   (frame_off=-2, body @ $A1E7)
; ============================================================
  $A1E7  3C                         PUSH_quick   ; inline operand = 12
  $A1E8  E9 91 A1 02                CALL_abs_imm1          $A191 {bytecode}, $02
  $A1EC  D0                         INC
  $A1ED  B3                         PUSHL
  $A1EE  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A1F2  B3                         PUSHL
  $A1F3  0C                         LOADL_quick   ; inline operand = 12
  $A1F4  8C 2D 6D                   LOADR_imm2             $6D2D
  $A1F7  BB                         ADD
  $A1F8  D3                         BYTE_DEREF
  $A1F9  B3                         PUSHL
  $A1FA  0D                         LOADL_quick   ; inline operand = 13
  $A1FB  74                         ADD_qimm   ; inline operand = 4
  $A1FC  B0                         DEREF
  $A1FD  B3                         PUSHL
  $A1FE  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A202  B3                         PUSHL
  $A203  3C                         PUSH_quick   ; inline operand = 12
  $A204  E9 AA A1 02                CALL_abs_imm1          $A1AA {bytecode}, $02
  $A208  B4                         POPR
  $A209  BB                         ADD
  $A20A  B4                         POPR
  $A20B  BB                         ADD
  $A20C  2B                         STORE_quick   ; inline operand = 11
  $A20D  0D                         LOADL_quick   ; inline operand = 13
  $A20E  8F 18                      BYTE_ADD_imm1          +24
  $A210  B0                         DEREF
  $A211  B3                         PUSHL
  $A212  0B                         LOADL_quick   ; inline operand = 11
  $A213  B4                         POPR
  $A214  C4                         SCMPGT
  $A215  D8 1D A2                   JUMPF_abs              $A21D
  $A218  0D                         LOADL_quick   ; inline operand = 13
  $A219  8F 18                      BYTE_ADD_imm1          +24
  $A21B  B0                         DEREF
  $A21C  2B                         STORE_quick   ; inline operand = 11
 >$A21D  0B                         LOADL_quick   ; inline operand = 11
  $A21E  CF                         RETURN

; ============================================================
; sub $A21F   (frame_off=-2, body @ $A224)
; ============================================================
  $A224  3C                         PUSH_quick   ; inline operand = 12
  $A225  E9 91 A1 02                CALL_abs_imm1          $A191 {bytecode}, $02
  $A229  D0                         INC
  $A22A  B3                         PUSHL
  $A22B  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A22F  B3                         PUSHL
  $A230  0C                         LOADL_quick   ; inline operand = 12
  $A231  8C 2D 6D                   LOADR_imm2             $6D2D
  $A234  BB                         ADD
  $A235  D3                         BYTE_DEREF
  $A236  B3                         PUSHL
  $A237  0C                         LOADL_quick   ; inline operand = 12
  $A238  53                         LOADR_qimm   ; inline operand = 3
  $A239  BD                         LSHIFT
  $A23A  8C 05 60                   LOADR_imm2             $6005
  $A23D  BB                         ADD
  $A23E  B0                         DEREF
  $A23F  B3                         PUSHL
  $A240  0C                         LOADL_quick   ; inline operand = 12
  $A241  53                         LOADR_qimm   ; inline operand = 3
  $A242  BD                         LSHIFT
  $A243  8C 03 60                   LOADR_imm2             $6003 (fief_history_table)
  $A246  BB                         ADD
  $A247  B0                         DEREF
  $A248  B3                         PUSHL
  $A249  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A24D  B3                         PUSHL
  $A24E  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A252  B3                         PUSHL
  $A253  3C                         PUSH_quick   ; inline operand = 12
  $A254  E9 AA A1 02                CALL_abs_imm1          $A1AA {bytecode}, $02
  $A258  B4                         POPR
  $A259  BB                         ADD
  $A25A  B4                         POPR
  $A25B  BB                         ADD
  $A25C  2B                         STORE_quick   ; inline operand = 11
  $A25D  0D                         LOADL_quick   ; inline operand = 13
  $A25E  8F 18                      BYTE_ADD_imm1          +24
  $A260  B0                         DEREF
  $A261  B3                         PUSHL
  $A262  0B                         LOADL_quick   ; inline operand = 11
  $A263  B4                         POPR
  $A264  C4                         SCMPGT
  $A265  D8 6D A2                   JUMPF_abs              $A26D
  $A268  0D                         LOADL_quick   ; inline operand = 13
  $A269  8F 18                      BYTE_ADD_imm1          +24
  $A26B  B0                         DEREF
  $A26C  2B                         STORE_quick   ; inline operand = 11
 >$A26D  0B                         LOADL_quick   ; inline operand = 11
  $A26E  CF                         RETURN

; ============================================================
; sub $A26F   (frame_off=-6, body @ $A274)
; ============================================================
  $A274  62                         PUSH_qimm   ; inline operand = 2
  $A275  E9 E8 90 02                CALL_abs_imm1          $90E8 {bytecode}, $02
  $A279  40                         LOADL_qimm   ; inline operand = 0
  $A27A  D6 D5 A2                   JUMP_abs               $A2D5
 >$A27D  3A                         PUSH_quick   ; inline operand = 10
  $A27E  E9 A9 A0 02                CALL_abs_imm1          $A0A9 {bytecode}, $02
  $A282  0A                         LOADL_quick   ; inline operand = 10
  $A283  8B 1A                      BYTE_LOADR_imm1        +26
  $A285  B5                         MULT
  $A286  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A289  BB                         ADD
  $A28A  2B                         STORE_quick   ; inline operand = 11
  $A28B  3A                         PUSH_quick   ; inline operand = 10
  $A28C  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $A290  D7 99 A2                   JUMPT_abs              $A299
  $A293  3B                         PUSH_quick   ; inline operand = 11
  $A294  3A                         PUSH_quick   ; inline operand = 10
  $A295  E9 28 A1 04                CALL_abs_imm1          $A128 {bytecode}, $04
 >$A299  0B                         LOADL_quick   ; inline operand = 11
  $A29A  7C                         ADD_qimm   ; inline operand = 12
  $A29B  B0                         DEREF
  $A29C  D8 C1 A2                   JUMPF_abs              $A2C1
  $A29F  0A                         LOADL_quick   ; inline operand = 10
  $A2A0  8C 2D 6D                   LOADR_imm2             $6D2D
  $A2A3  BB                         ADD
  $A2A4  D3                         BYTE_DEREF
  $A2A5  29                         STORE_quick   ; inline operand = 9
  $A2A6  3B                         PUSH_quick   ; inline operand = 11
  $A2A7  3A                         PUSH_quick   ; inline operand = 10
  $A2A8  E9 E2 A1 04                CALL_abs_imm1          $A1E2 {bytecode}, $04
  $A2AC  B3                         PUSHL
  $A2AD  0B                         LOADL_quick   ; inline operand = 11
  $A2AE  B4                         POPR
  $A2AF  B3                         PUSHL
  $A2B0  B0                         DEREF
  $A2B1  BB                         ADD
  $A2B2  B1                         POPSTORE
  $A2B3  3B                         PUSH_quick   ; inline operand = 11
  $A2B4  3A                         PUSH_quick   ; inline operand = 10
  $A2B5  E9 1F A2 04                CALL_abs_imm1          $A21F {bytecode}, $04
  $A2B9  B3                         PUSHL
  $A2BA  0B                         LOADL_quick   ; inline operand = 11
  $A2BB  76                         ADD_qimm   ; inline operand = 6
  $A2BC  B4                         POPR
  $A2BD  B3                         PUSHL
  $A2BE  B0                         DEREF
  $A2BF  BB                         ADD
  $A2C0  B1                         POPSTORE
 >$A2C1  0B                         LOADL_quick   ; inline operand = 11
  $A2C2  B0                         DEREF
  $A2C3  B3                         PUSHL
  $A2C4  3B                         PUSH_quick   ; inline operand = 11
  $A2C5  E9 A9 92 04                CALL_abs_imm1          $92A9 {bytecode}, $04
  $A2C9  3B                         PUSH_quick   ; inline operand = 11
  $A2CA  E9 5B A1 02                CALL_abs_imm1          $A15B {bytecode}, $02
  $A2CE  3A                         PUSH_quick   ; inline operand = 10
  $A2CF  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $A2D3  0A                         LOADL_quick   ; inline operand = 10
  $A2D4  D0                         INC
 >$A2D5  2A                         STORE_quick   ; inline operand = 10
  $A2D6  0A                         LOADL_quick   ; inline operand = 10
  $A2D7  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A2DA  C6                         UCMPLT
  $A2DB  D7 7D A2                   JUMPT_abs              $A27D
  $A2DE  CF                         RETURN

; ============================================================
; sub $A2DF   (frame_off=+0, body @ $A2E4)
; ============================================================
  $A2E4  8D 64                      BYTE_PUSH_imm1         +100
  $A2E6  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A2EA  53                         LOADR_qimm   ; inline operand = 3
  $A2EB  C2                         SCMPLT
  $A2EC  CF                         RETURN

; ============================================================
; sub $A2ED   (frame_off=-2, body @ $A2F2)
; ============================================================
  $A2F2  3C                         PUSH_quick   ; inline operand = 12
  $A2F3  E9 CD D7 02                CALL_abs_imm1          $D7CD (daimyo_record_addr) {bytecode}, $02
  $A2F7  73                         ADD_qimm   ; inline operand = 3
  $A2F8  2B                         STORE_quick   ; inline operand = 11
  $A2F9  6B                         PUSH_qimm   ; inline operand = 11
  $A2FA  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A2FE  B3                         PUSHL
  $A2FF  0B                         LOADL_quick   ; inline operand = 11
  $A300  B4                         POPR
  $A301  B3                         PUSHL
  $A302  D3                         BYTE_DEREF
  $A303  BB                         ADD
  $A304  D4                         BYTE_POPSTORE
  $A305  65                         PUSH_qimm   ; inline operand = 5
  $A306  0B                         LOADL_quick   ; inline operand = 11
  $A307  B4                         POPR
  $A308  B3                         PUSHL
  $A309  D3                         BYTE_DEREF
  $A30A  BC                         SUB
  $A30B  D4                         BYTE_POPSTORE
  $A30C  CF                         RETURN

; ============================================================
; sub $A30D   (frame_off=-2, body @ $A312)
; ============================================================
  $A312  40                         LOADL_qimm   ; inline operand = 0
  $A313  D6 49 A3                   JUMP_abs               $A349
 >$A316  3B                         PUSH_quick   ; inline operand = 11
  $A317  E9 ED A2 02                CALL_abs_imm1          $A2ED {bytecode}, $02
  $A31B  89 5A                      BYTE_LOADL_imm1        +90
  $A31D  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $A320  BC                         SUB
  $A321  B3                         PUSHL
  $A322  0B                         LOADL_quick   ; inline operand = 11
  $A323  8C 2D 6D                   LOADR_imm2             $6D2D
  $A326  BB                         ADD
  $A327  D3                         BYTE_DEREF
  $A328  B4                         POPR
  $A329  C9                         UCMPGE
  $A32A  D8 47 A3                   JUMPF_abs              $A347
  $A32D  0B                         LOADL_quick   ; inline operand = 11
  $A32E  8B 1A                      BYTE_LOADR_imm1        +26
  $A330  B5                         MULT
  $A331  8C 0D 70                   LOADR_imm2             $700D
  $A334  BB                         ADD
  $A335  B3                         PUSHL
  $A336  8D 5A                      BYTE_PUSH_imm1         +90
  $A338  0B                         LOADL_quick   ; inline operand = 11
  $A339  8B 1A                      BYTE_LOADR_imm1        +26
  $A33B  B5                         MULT
  $A33C  8C 0D 70                   LOADR_imm2             $700D
  $A33F  BB                         ADD
  $A340  B0                         DEREF
  $A341  B3                         PUSHL
  $A342  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A346  B1                         POPSTORE
 >$A347  0B                         LOADL_quick   ; inline operand = 11
  $A348  D0                         INC
 >$A349  2B                         STORE_quick   ; inline operand = 11
  $A34A  0B                         LOADL_quick   ; inline operand = 11
  $A34B  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A34E  C6                         UCMPLT
  $A34F  D7 16 A3                   JUMPT_abs              $A316
  $A352  63                         PUSH_qimm   ; inline operand = 3
  $A353  62                         PUSH_qimm   ; inline operand = 2
  $A354  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $A358  AC 77 D6                   CALL_abs               $D677 (draw_window_f6c4) {bytecode}
  $A35B  63                         PUSH_qimm   ; inline operand = 3
  $A35C  67                         PUSH_qimm   ; inline operand = 7
  $A35D  E9 7B CC 04                CALL_abs_imm1          $CC7B (ui_helper_cc7b) {bytecode}, $04
  $A361  AC 87 D6                   CALL_abs               $D687 (redraw_window_f6c7) {bytecode}
  $A364  AC 63 8E                   CALL_abs               $8E63 {bytecode}
  $A367  89 FF                      BYTE_LOADL_imm1        -1
  $A369  A9 67 6F                   BYTE_STORE_abs         $6F67
  $A36C  A4 5F 6D                   LOADL_abs              $6D5F (config_block)
  $A36F  D5 00 00 04 00 81 A3 7E A3 85 A3 8B ... SWITCH_contig          limit=4   ; .table 4 word targets (contiguous); SWITCH 0=>$A37E 1=>$A385 2=>$A38B 3=>$A391 default=>$A381
 >$A37E  AC 8C 9F                   CALL_abs               $9F8C {bytecode}
 >$A381  40                         LOADL_qimm   ; inline operand = 0
  $A382  D6 A0 A3                   JUMP_abs               $A3A0
 >$A385  AC 66 A0                   CALL_abs               $A066 {bytecode}
  $A388  D6 81 A3                   JUMP_abs               $A381
 >$A38B  AC 6F A2                   CALL_abs               $A26F {bytecode}
  $A38E  D6 81 A3                   JUMP_abs               $A381
 >$A391  62                         PUSH_qimm   ; inline operand = 2
  $A392  E9 E8 90 02                CALL_abs_imm1          $90E8 {bytecode}, $02
  $A396  D6 81 A3                   JUMP_abs               $A381
 >$A399  3B                         PUSH_quick   ; inline operand = 11
  $A39A  E9 94 91 02                CALL_abs_imm1          $9194 {bytecode}, $02
  $A39E  0B                         LOADL_quick   ; inline operand = 11
  $A39F  D0                         INC
 >$A3A0  2B                         STORE_quick   ; inline operand = 11
  $A3A1  0B                         LOADL_quick   ; inline operand = 11
  $A3A2  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A3A5  C6                         UCMPLT
  $A3A6  D7 99 A3                   JUMPT_abs              $A399
  $A3A9  CF                         RETURN

; ============================================================
; sub $A3AA   (frame_off=-6, body @ $A3AF)
; ============================================================
  $A3AF  A4 61 6F                   LOADL_abs              $6F61
  $A3B2  29                         STORE_quick   ; inline operand = 9
  $A3B3  8E FF 00                   PUSH_imm2              $00FF
  $A3B6  8E 01 60                   PUSH_imm2              $6001
  $A3B9  39                         PUSH_quick   ; inline operand = 9
  $A3BA  60                         PUSH_qimm   ; inline operand = 0
  $A3BB  8D 16                      BYTE_PUSH_imm1         +22
  $A3BD  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $A3C1  2A                         STORE_quick   ; inline operand = 10
  $A3C2  8A 00 61                   LOADL_imm2             $6100
  $A3C5  2B                         STORE_quick   ; inline operand = 11
 >$A3C6  8E 00 01                   PUSH_imm2              $0100
  $A3C9  3B                         PUSH_quick   ; inline operand = 11
  $A3CA  39                         PUSH_quick   ; inline operand = 9
  $A3CB  60                         PUSH_qimm   ; inline operand = 0
  $A3CC  8D 16                      BYTE_PUSH_imm1         +22
  $A3CE  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $A3D2  CD                         SWAP
  $A3D3  0A                         LOADL_quick   ; inline operand = 10
  $A3D4  BB                         ADD
  $A3D5  2A                         STORE_quick   ; inline operand = 10
  $A3D6  8A 00 01                   LOADL_imm2             $0100
  $A3D9  CD                         SWAP
  $A3DA  0B                         LOADL_quick   ; inline operand = 11
  $A3DB  BB                         ADD
  $A3DC  2B                         STORE_quick   ; inline operand = 11
  $A3DD  0B                         LOADL_quick   ; inline operand = 11
  $A3DE  8C 00 70                   LOADR_imm2             $7000
  $A3E1  C6                         UCMPLT
  $A3E2  D7 C6 A3                   JUMPT_abs              $A3C6
  $A3E5  8E FF 00                   PUSH_imm2              $00FF
  $A3E8  8E 01 70                   PUSH_imm2              $7001 (province_table_live)
  $A3EB  39                         PUSH_quick   ; inline operand = 9
  $A3EC  60                         PUSH_qimm   ; inline operand = 0
  $A3ED  8D 16                      BYTE_PUSH_imm1         +22
  $A3EF  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $A3F3  CD                         SWAP
  $A3F4  0A                         LOADL_quick   ; inline operand = 10
  $A3F5  BB                         ADD
  $A3F6  2A                         STORE_quick   ; inline operand = 10
  $A3F7  8A 00 71                   LOADL_imm2             $7100
  $A3FA  2B                         STORE_quick   ; inline operand = 11
 >$A3FB  8E 00 01                   PUSH_imm2              $0100
  $A3FE  3B                         PUSH_quick   ; inline operand = 11
  $A3FF  39                         PUSH_quick   ; inline operand = 9
  $A400  60                         PUSH_qimm   ; inline operand = 0
  $A401  8D 16                      BYTE_PUSH_imm1         +22
  $A403  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $A407  CD                         SWAP
  $A408  0A                         LOADL_quick   ; inline operand = 10
  $A409  BB                         ADD
  $A40A  2A                         STORE_quick   ; inline operand = 10
  $A40B  8A 00 01                   LOADL_imm2             $0100
  $A40E  CD                         SWAP
  $A40F  0B                         LOADL_quick   ; inline operand = 11
  $A410  BB                         ADD
  $A411  2B                         STORE_quick   ; inline operand = 11
  $A412  0B                         LOADL_quick   ; inline operand = 11
  $A413  8C 00 7F                   LOADR_imm2             $7F00 (ui_transient_state)
  $A416  C6                         UCMPLT
  $A417  D7 FB A3                   JUMPT_abs              $A3FB
  $A41A  8E EB 81                   PUSH_imm2              $81EB
  $A41D  8E 00 7F                   PUSH_imm2              $7F00 (ui_transient_state)
  $A420  39                         PUSH_quick   ; inline operand = 9
  $A421  60                         PUSH_qimm   ; inline operand = 0
  $A422  8D 16                      BYTE_PUSH_imm1         +22
  $A424  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $A428  CD                         SWAP
  $A429  0A                         LOADL_quick   ; inline operand = 10
  $A42A  BB                         ADD
  $A42B  2A                         STORE_quick   ; inline operand = 10
  $A42C  0A                         LOADL_quick   ; inline operand = 10
  $A42D  A8 EB 7F                   STORE_abs              $7FEB
  $A430  8E 17 BF                   PUSH_imm2              $BF17
  $A433  8E ED 7F                   PUSH_imm2              $7FED
  $A436  E9 D9 CA 04                CALL_abs_imm1          $CAD9 (strcpy) {bytecode}, $04
  $A43A  60                         PUSH_qimm   ; inline operand = 0
  $A43B  E9 A4 CB 02                CALL_abs_imm1          $CBA4 (chr_bank0_set_wrap) {bytecode}, $02
  $A43F  40                         LOADL_qimm   ; inline operand = 0
  $A440  A8 61 6F                   STORE_abs              $6F61
  $A443  8E 1C BF                   PUSH_imm2              $BF1C
  $A446  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A44A  8E 1D BF                   PUSH_imm2              $BF1D
  $A44D  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A451  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A454  CF                         RETURN

; ============================================================
; sub $A455   (frame_off=-8, body @ $A45A)
; ============================================================
  $A45A  41                         LOADL_qimm   ; inline operand = 1
  $A45B  A8 D3 7F                   STORE_abs              $7FD3
  $A45E  AC 20 CD                   CALL_abs               $CD20 (ui_helper_cd20) {bytecode}
  $A461  A4 48 6E                   LOADL_abs              $6E48
  $A464  51                         LOADR_qimm   ; inline operand = 1
  $A465  C0                         CMPEQ
  $A466  D8 73 A4                   JUMPF_abs              $A473
  $A469  AC AB 99                   CALL_abs               $99AB {bytecode}
  $A46C  42                         LOADL_qimm   ; inline operand = 2
  $A46D  A8 48 6E                   STORE_abs              $6E48
  $A470  D6 D4 A5                   JUMP_abs               $A5D4
 >$A473  AC 94 E6                   CALL_abs               $E694 (dispatch_map_helper_e694) {bytecode}
  $A476  A4 61 6F                   LOADL_abs              $6F61
  $A479  D8 7F A4                   JUMPF_abs              $A47F
  $A47C  AC AA A3                   CALL_abs               $A3AA {bytecode}
 >$A47F  A4 5F 6D                   LOADL_abs              $6D5F (config_block)
  $A482  D0                         INC
  $A483  A8 5F 6D                   STORE_abs              $6D5F (config_block)
  $A486  53                         LOADR_qimm   ; inline operand = 3
  $A487  DA                         AND
  $A488  A8 5F 6D                   STORE_abs              $6D5F (config_block)
  $A48B  D7 98 A4                   JUMPT_abs              $A498
  $A48E  A4 9F 6D                   LOADL_abs              $6D9F
  $A491  D0                         INC
  $A492  A8 9F 6D                   STORE_abs              $6D9F
  $A495  AC 4A 92                   CALL_abs               $924A {bytecode}
 >$A498  AC 0D A3                   CALL_abs               $A30D {bytecode}
  $A49B  40                         LOADL_qimm   ; inline operand = 0
  $A49C  D6 AE A4                   JUMP_abs               $A4AE
 >$A49F  39                         PUSH_quick   ; inline operand = 9
  $A4A0  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $A4A4  09                         LOADL_quick   ; inline operand = 9
  $A4A5  8C D4 6D                   LOADR_imm2             $6DD4 (daimyo_weakness_flag)
  $A4A8  BB                         ADD
  $A4A9  B3                         PUSHL
  $A4AA  40                         LOADL_qimm   ; inline operand = 0
  $A4AB  D4                         BYTE_POPSTORE
  $A4AC  09                         LOADL_quick   ; inline operand = 9
  $A4AD  D0                         INC
 >$A4AE  29                         STORE_quick   ; inline operand = 9
  $A4AF  09                         LOADL_quick   ; inline operand = 9
  $A4B0  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A4B3  C6                         UCMPLT
  $A4B4  D7 9F A4                   JUMPT_abs              $A49F
  $A4B7  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A4BA  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $A4BD  DA                         AND
  $A4BE  D8 C2 A4                   JUMPF_abs              $A4C2
  $A4C1  CF                         RETURN
 >$A4C2  40                         LOADL_qimm   ; inline operand = 0
  $A4C3  A8 7B 6F                   STORE_abs              $6F7B
  $A4C6  A4 5F 6D                   LOADL_abs              $6D5F (config_block)
  $A4C9  51                         LOADR_qimm   ; inline operand = 1
  $A4CA  C0                         CMPEQ
  $A4CB  D8 DE A4                   JUMPF_abs              $A4DE
  $A4CE  62                         PUSH_qimm   ; inline operand = 2
  $A4CF  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A4D3  D8 DE A4                   JUMPF_abs              $A4DE
  $A4D6  41                         LOADL_qimm   ; inline operand = 1
  $A4D7  A8 7B 6F                   STORE_abs              $6F7B
  $A4DA  8A B3 9C                   LOADL_imm2             $9CB3
  $A4DD  2B                         STORE_quick   ; inline operand = 11
 >$A4DE  A4 7B 6F                   LOADL_abs              $6F7B
  $A4E1  D7 FE A4                   JUMPT_abs              $A4FE
  $A4E4  64                         PUSH_qimm   ; inline operand = 4
  $A4E5  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A4E9  D7 F6 A4                   JUMPT_abs              $A4F6
  $A4EC  42                         LOADL_qimm   ; inline operand = 2
  $A4ED  A8 7B 6F                   STORE_abs              $6F7B
  $A4F0  8A 00 9D                   LOADL_imm2             $9D00
  $A4F3  D6 FD A4                   JUMP_abs               $A4FD
 >$A4F6  43                         LOADL_qimm   ; inline operand = 3
  $A4F7  A8 7B 6F                   STORE_abs              $6F7B
  $A4FA  8A D9 9E                   LOADL_imm2             $9ED9
 >$A4FD  2B                         STORE_quick   ; inline operand = 11
 >$A4FE  40                         LOADL_qimm   ; inline operand = 0
  $A4FF  29                         STORE_quick   ; inline operand = 9
  $A500  40                         LOADL_qimm   ; inline operand = 0
  $A501  28                         STORE_quick   ; inline operand = 8
  $A502  D6 34 A5                   JUMP_abs               $A534
 >$A505  39                         PUSH_quick   ; inline operand = 9
  $A506  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $A50A  D7 31 A5                   JUMPT_abs              $A531
  $A50D  A4 7B 6F                   LOADL_abs              $6F7B
  $A510  53                         LOADR_qimm   ; inline operand = 3
  $A511  C1                         CMPNE
  $A512  D8 20 A5                   JUMPF_abs              $A520
  $A515  8D 28                      BYTE_PUSH_imm1         +40
  $A517  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A51B  53                         LOADR_qimm   ; inline operand = 3
  $A51C  C2                         SCMPLT
  $A51D  D6 23 A5                   JUMP_abs               $A523
 >$A520  AC DF A2                   CALL_abs               $A2DF {bytecode}
 >$A523  D8 31 A5                   JUMPF_abs              $A531
  $A526  08                         LOADL_quick   ; inline operand = 8
  $A527  D0                         INC
  $A528  28                         STORE_quick   ; inline operand = 8
  $A529  D1                         DEC
  $A52A  8C AD 7B                   LOADR_imm2             $7BAD
  $A52D  BB                         ADD
  $A52E  B3                         PUSHL
  $A52F  09                         LOADL_quick   ; inline operand = 9
  $A530  D4                         BYTE_POPSTORE
 >$A531  09                         LOADL_quick   ; inline operand = 9
  $A532  D0                         INC
  $A533  29                         STORE_quick   ; inline operand = 9
 >$A534  09                         LOADL_quick   ; inline operand = 9
  $A535  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A538  C6                         UCMPLT
  $A539  D7 05 A5                   JUMPT_abs              $A505
  $A53C  08                         LOADL_quick   ; inline operand = 8
  $A53D  8C AD 7B                   LOADR_imm2             $7BAD
  $A540  BB                         ADD
  $A541  B3                         PUSHL
  $A542  89 FF                      BYTE_LOADL_imm1        -1
  $A544  D4                         BYTE_POPSTORE
  $A545  08                         LOADL_quick   ; inline operand = 8
  $A546  D8 5B A5                   JUMPF_abs              $A55B
  $A549  AA 7B 6F                   PUSH_abs               $6F7B
  $A54C  E9 B1 94 02                CALL_abs_imm1          $94B1 {bytecode}, $02
  $A550  0B                         LOADL_quick   ; inline operand = 11
  $A551  DD                         CALLPTR
  $A552  A4 48 6E                   LOADL_abs              $6E48
  $A555  51                         LOADR_qimm   ; inline operand = 1
  $A556  C0                         CMPEQ
  $A557  D8 5B A5                   JUMPF_abs              $A55B
  $A55A  CF                         RETURN
 >$A55B  40                         LOADL_qimm   ; inline operand = 0
  $A55C  D6 CB A5                   JUMP_abs               $A5CB
 >$A55F  39                         PUSH_quick   ; inline operand = 9
  $A560  E9 CD D7 02                CALL_abs_imm1          $D7CD (daimyo_record_addr) {bytecode}, $02
  $A564  2A                         STORE_quick   ; inline operand = 10
  $A565  0A                         LOADL_quick   ; inline operand = 10
  $A566  D0                         INC
  $A567  D3                         BYTE_DEREF
  $A568  8B 63                      BYTE_LOADR_imm1        +99
  $A56A  C4                         SCMPGT
  $A56B  D7 C9 A5                   JUMPT_abs              $A5C9
  $A56E  39                         PUSH_quick   ; inline operand = 9
  $A56F  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $A573  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $A576  BB                         ADD
  $A577  D3                         BYTE_DEREF
  $A578  D7 C9 A5                   JUMPT_abs              $A5C9
  $A57B  09                         LOADL_quick   ; inline operand = 9
  $A57C  8C D4 6D                   LOADR_imm2             $6DD4 (daimyo_weakness_flag)
  $A57F  BB                         ADD
  $A580  B3                         PUSHL
  $A581  09                         LOADL_quick   ; inline operand = 9
  $A582  8C D4 6D                   LOADR_imm2             $6DD4 (daimyo_weakness_flag)
  $A585  BB                         ADD
  $A586  D3                         BYTE_DEREF
  $A587  B3                         PUSHL
  $A588  0A                         LOADL_quick   ; inline operand = 10
  $A589  D0                         INC
  $A58A  D3                         BYTE_DEREF
  $A58B  B3                         PUSHL
  $A58C  89 64                      BYTE_LOADL_imm1        +100
  $A58E  B4                         POPR
  $A58F  BC                         SUB
  $A590  B3                         PUSHL
  $A591  8E 90 01                   PUSH_imm2              $0190
  $A594  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A598  B4                         POPR
  $A599  C2                         SCMPLT
  $A59A  B4                         POPR
  $A59B  DB                         OR
  $A59C  D4                         BYTE_POPSTORE
  $A59D  09                         LOADL_quick   ; inline operand = 9
  $A59E  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $A5A1  39                         PUSH_quick   ; inline operand = 9
  $A5A2  E9 72 D9 02                CALL_abs_imm1          $D972 (war_helper_d972) {bytecode}, $02
  $A5A6  D8 C9 A5                   JUMPF_abs              $A5C9
  $A5A9  AC 1E 8C                   CALL_abs               $8C1E {bytecode}
  $A5AC  D8 C9 A5                   JUMPF_abs              $A5C9
  $A5AF  39                         PUSH_quick   ; inline operand = 9
  $A5B0  E9 72 D7 02                CALL_abs_imm1          $D772 (ui_helper_d772) {bytecode}, $02
  $A5B4  59                         LOADR_qimm   ; inline operand = 9
  $A5B5  B5                         MULT
  $A5B6  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $A5B9  BB                         ADD
  $A5BA  B3                         PUSHL
  $A5BB  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A5BF  8E 31 BF                   PUSH_imm2              $BF31
  $A5C2  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A5C6  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$A5C9  09                         LOADL_quick   ; inline operand = 9
  $A5CA  D0                         INC
 >$A5CB  29                         STORE_quick   ; inline operand = 9
  $A5CC  09                         LOADL_quick   ; inline operand = 9
  $A5CD  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A5D0  C6                         UCMPLT
  $A5D1  D7 5F A5                   JUMPT_abs              $A55F
 >$A5D4  CF                         RETURN

; ============================================================
; sub $A5D5   (frame_off=+0, body @ $A5DA)
; ============================================================
  $A5DA  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $A5DD  D0                         INC
  $A5DE  5A                         LOADR_qimm   ; inline operand = 10
  $A5DF  B5                         MULT
  $A5E0  B3                         PUSHL
  $A5E1  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A5E5  CF                         RETURN

; ============================================================
; sub $A5E6   (frame_off=-14, body @ $A5EB)
; ============================================================
  $A5EB  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $A5EE  8B 1A                      BYTE_LOADR_imm1        +26
  $A5F0  B5                         MULT
  $A5F1  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A5F4  BB                         ADD
  $A5F5  25                         STORE_quick   ; inline operand = 5
  $A5F6  78                         ADD_qimm   ; inline operand = 8
  $A5F7  2A                         STORE_quick   ; inline operand = 10
  $A5F8  05                         LOADL_quick   ; inline operand = 5
  $A5F9  8F 10                      BYTE_ADD_imm1          +16
  $A5FB  29                         STORE_quick   ; inline operand = 9
  $A5FC  0C                         LOADL_quick   ; inline operand = 12
  $A5FD  D8 86 A6                   JUMPF_abs              $A686
  $A600  0A                         LOADL_quick   ; inline operand = 10
  $A601  B0                         DEREF
  $A602  50                         LOADR_qimm   ; inline operand = 0
  $A603  C3                         SCMPLE
  $A604  D8 16 A6                   JUMPF_abs              $A616
  $A607  3A                         PUSH_quick   ; inline operand = 10
  $A608  09                         LOADL_quick   ; inline operand = 9
  $A609  B0                         DEREF
  $A60A  52                         LOADR_qimm   ; inline operand = 2
  $A60B  B6                         SDIV
  $A60C  B1                         POPSTORE
  $A60D  0A                         LOADL_quick   ; inline operand = 10
  $A60E  B0                         DEREF
  $A60F  B3                         PUSHL
  $A610  09                         LOADL_quick   ; inline operand = 9
  $A611  B4                         POPR
  $A612  B3                         PUSHL
  $A613  B0                         DEREF
  $A614  BC                         SUB
  $A615  B1                         POPSTORE
 >$A616  09                         LOADL_quick   ; inline operand = 9
  $A617  B0                         DEREF
  $A618  50                         LOADR_qimm   ; inline operand = 0
  $A619  C3                         SCMPLE
  $A61A  D8 2C A6                   JUMPF_abs              $A62C
  $A61D  39                         PUSH_quick   ; inline operand = 9
  $A61E  0A                         LOADL_quick   ; inline operand = 10
  $A61F  B0                         DEREF
  $A620  52                         LOADR_qimm   ; inline operand = 2
  $A621  B6                         SDIV
  $A622  B1                         POPSTORE
  $A623  09                         LOADL_quick   ; inline operand = 9
  $A624  B0                         DEREF
  $A625  B3                         PUSHL
  $A626  0A                         LOADL_quick   ; inline operand = 10
  $A627  B4                         POPR
  $A628  B3                         PUSHL
  $A629  B0                         DEREF
  $A62A  BC                         SUB
  $A62B  B1                         POPSTORE
 >$A62C  AA 63 6D                   PUSH_abs               $6D63 (const_two)
  $A62F  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A633  8F 46                      BYTE_ADD_imm1          +70
  $A635  B3                         PUSHL
  $A636  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $A639  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $A63D  74                         ADD_qimm   ; inline operand = 4
  $A63E  D3                         BYTE_DEREF
  $A63F  B4                         POPR
  $A640  C2                         SCMPLT
  $A641  D8 61 A6                   JUMPF_abs              $A661
  $A644  8D 32                      BYTE_PUSH_imm1         +50
  $A646  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A64A  B3                         PUSHL
  $A64B  09                         LOADL_quick   ; inline operand = 9
  $A64C  B0                         DEREF
  $A64D  B3                         PUSHL
  $A64E  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A652  2B                         STORE_quick   ; inline operand = 11
  $A653  B3                         PUSHL
  $A654  0A                         LOADL_quick   ; inline operand = 10
  $A655  B4                         POPR
  $A656  B3                         PUSHL
  $A657  B0                         DEREF
  $A658  BB                         ADD
  $A659  B1                         POPSTORE
  $A65A  3B                         PUSH_quick   ; inline operand = 11
  $A65B  09                         LOADL_quick   ; inline operand = 9
  $A65C  B4                         POPR
  $A65D  B3                         PUSHL
  $A65E  B0                         DEREF
  $A65F  BC                         SUB
  $A660  B1                         POPSTORE
 >$A661  0A                         LOADL_quick   ; inline operand = 10
  $A662  B0                         DEREF
  $A663  A8 81 6F                   STORE_abs              $6F81
 >$A666  05                         LOADL_quick   ; inline operand = 5
  $A667  76                         ADD_qimm   ; inline operand = 6
  $A668  29                         STORE_quick   ; inline operand = 9
  $A669  8D 1F                      BYTE_PUSH_imm1         +31
  $A66B  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A66F  8F 32                      BYTE_ADD_imm1          +50
  $A671  B3                         PUSHL
  $A672  09                         LOADL_quick   ; inline operand = 9
  $A673  B0                         DEREF
  $A674  B3                         PUSHL
  $A675  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A679  A8 7F 6F                   STORE_abs              $6F7F
  $A67C  B3                         PUSHL
  $A67D  09                         LOADL_quick   ; inline operand = 9
  $A67E  B4                         POPR
  $A67F  B3                         PUSHL
  $A680  B0                         DEREF
  $A681  BC                         SUB
  $A682  B1                         POPSTORE
  $A683  D6 B8 A6                   JUMP_abs               $A6B8
 >$A686  09                         LOADL_quick   ; inline operand = 9
  $A687  B0                         DEREF
  $A688  8B 14                      BYTE_LOADR_imm1        +20
  $A68A  C4                         SCMPGT
  $A68B  D8 AB A6                   JUMPF_abs              $A6AB
  $A68E  8D 46                      BYTE_PUSH_imm1         +70
  $A690  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A694  8F 14                      BYTE_ADD_imm1          +20
  $A696  B3                         PUSHL
  $A697  09                         LOADL_quick   ; inline operand = 9
  $A698  B0                         DEREF
  $A699  B3                         PUSHL
  $A69A  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A69E  A8 81 6F                   STORE_abs              $6F81
  $A6A1  B3                         PUSHL
  $A6A2  09                         LOADL_quick   ; inline operand = 9
  $A6A3  B4                         POPR
  $A6A4  B3                         PUSHL
  $A6A5  B0                         DEREF
  $A6A6  BC                         SUB
  $A6A7  B1                         POPSTORE
  $A6A8  D6 66 A6                   JUMP_abs               $A666
 >$A6AB  6A                         PUSH_qimm   ; inline operand = 10
  $A6AC  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A6B0  8F 19                      BYTE_ADD_imm1          +25
  $A6B2  A8 81 6F                   STORE_abs              $6F81
  $A6B5  A8 7F 6F                   STORE_abs              $6F7F
 >$A6B8  40                         LOADL_qimm   ; inline operand = 0
  $A6B9  A8 7D 6F                   STORE_abs              $6F7D
  $A6BC  0C                         LOADL_quick   ; inline operand = 12
  $A6BD  D8 C5 A6                   JUMPF_abs              $A6C5
  $A6C0  89 40                      BYTE_LOADL_imm1        +64
  $A6C2  D6 C7 A6                   JUMP_abs               $A6C7 (driver_view)
 >$A6C5  89 20                      BYTE_LOADL_imm1        +32
 >$A6C7  CD                         SWAP
  $A6C8  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A6CB  DB                         OR
  $A6CC  A9 A1 6D                   BYTE_STORE_abs         $6DA1
  $A6CF  40                         LOADL_qimm   ; inline operand = 0
  $A6D0  A9 65 6F                   BYTE_STORE_abs         $6F65
  $A6D3  8A 15 75                   LOADL_imm2             $7515 (zealot_uprising_slot)
  $A6D6  28                         STORE_quick   ; inline operand = 8
  $A6D7  05                         LOADL_quick   ; inline operand = 5
  $A6D8  27                         STORE_quick   ; inline operand = 7
  $A6D9  40                         LOADL_qimm   ; inline operand = 0
  $A6DA  26                         STORE_quick   ; inline operand = 6
  $A6DB  D6 FE A6                   JUMP_abs               $A6FE
 >$A6DE  38                         PUSH_quick   ; inline operand = 8
  $A6DF  8D 14                      BYTE_PUSH_imm1         +20
  $A6E1  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A6E5  8F 28                      BYTE_ADD_imm1          +40
  $A6E7  B3                         PUSHL
  $A6E8  07                         LOADL_quick   ; inline operand = 7
  $A6E9  B0                         DEREF
  $A6EA  B3                         PUSHL
  $A6EB  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A6EF  B1                         POPSTORE
  $A6F0  08                         LOADL_quick   ; inline operand = 8
  $A6F1  72                         ADD_qimm   ; inline operand = 2
  $A6F2  28                         STORE_quick   ; inline operand = 8
  $A6F3  8F FE                      BYTE_ADD_imm1          -2
  $A6F5  07                         LOADL_quick   ; inline operand = 7
  $A6F6  72                         ADD_qimm   ; inline operand = 2
  $A6F7  27                         STORE_quick   ; inline operand = 7
  $A6F8  8F FE                      BYTE_ADD_imm1          -2
  $A6FA  06                         LOADL_quick   ; inline operand = 6
  $A6FB  D0                         INC
  $A6FC  26                         STORE_quick   ; inline operand = 6
  $A6FD  D1                         DEC
 >$A6FE  06                         LOADL_quick   ; inline operand = 6
  $A6FF  58                         LOADR_qimm   ; inline operand = 8
  $A700  C6                         UCMPLT
  $A701  D7 DE A6                   JUMPT_abs              $A6DE
  $A704  08                         LOADL_quick   ; inline operand = 8
  $A705  72                         ADD_qimm   ; inline operand = 2
  $A706  28                         STORE_quick   ; inline operand = 8
  $A707  8F FE                      BYTE_ADD_imm1          -2
  $A709  B3                         PUSHL
  $A70A  A4 81 6F                   LOADL_abs              $6F81
  $A70D  B1                         POPSTORE
  $A70E  08                         LOADL_quick   ; inline operand = 8
  $A70F  72                         ADD_qimm   ; inline operand = 2
  $A710  28                         STORE_quick   ; inline operand = 8
  $A711  8F FE                      BYTE_ADD_imm1          -2
  $A713  B3                         PUSHL
  $A714  05                         LOADL_quick   ; inline operand = 5
  $A715  8F 12                      BYTE_ADD_imm1          +18
  $A717  B0                         DEREF
  $A718  B3                         PUSHL
  $A719  05                         LOADL_quick   ; inline operand = 5
  $A71A  8F 18                      BYTE_ADD_imm1          +24
  $A71C  B0                         DEREF
  $A71D  B4                         POPR
  $A71E  BC                         SUB
  $A71F  B1                         POPSTORE
  $A720  08                         LOADL_quick   ; inline operand = 8
  $A721  72                         ADD_qimm   ; inline operand = 2
  $A722  28                         STORE_quick   ; inline operand = 8
  $A723  8F FE                      BYTE_ADD_imm1          -2
  $A725  B3                         PUSHL
  $A726  AC D5 A5                   CALL_abs               $A5D5 {bytecode}
  $A729  B1                         POPSTORE
  $A72A  38                         PUSH_quick   ; inline operand = 8
  $A72B  AC D5 A5                   CALL_abs               $A5D5 {bytecode}
  $A72E  B1                         POPSTORE
  $A72F  05                         LOADL_quick   ; inline operand = 5
  $A730  7C                         ADD_qimm   ; inline operand = 12
  $A731  B0                         DEREF
  $A732  B3                         PUSHL
  $A733  05                         LOADL_quick   ; inline operand = 5
  $A734  8F 18                      BYTE_ADD_imm1          +24
  $A736  B0                         DEREF
  $A737  B4                         POPR
  $A738  BC                         SUB
  $A739  A8 21 75                   STORE_abs              $7521
  $A73C  89 32                      BYTE_LOADL_imm1        +50
  $A73E  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $A741  CF                         RETURN

; ============================================================
; sub $A742   (frame_off=-2, body @ $A747)
; ============================================================
  $A747  40                         LOADL_qimm   ; inline operand = 0
  $A748  D6 6E A7                   JUMP_abs               $A76E
 >$A74B  3B                         PUSH_quick   ; inline operand = 11
  $A74C  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $A750  AA 9D 6D                   PUSH_abs               $6D9D (scenario_fief_count)
  $A753  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A757  8C 1B 6F                   LOADR_imm2             $6F1B
  $A75A  BB                         ADD
  $A75B  B3                         PUSHL
  $A75C  AA 9D 6D                   PUSH_abs               $6D9D (scenario_fief_count)
  $A75F  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A763  8C 1B 6F                   LOADR_imm2             $6F1B
  $A766  BB                         ADD
  $A767  B3                         PUSHL
  $A768  E9 80 CB 04                CALL_abs_imm1          $CB80 (swap_byte) {bytecode}, $04
  $A76C  0B                         LOADL_quick   ; inline operand = 11
  $A76D  D0                         INC
 >$A76E  2B                         STORE_quick   ; inline operand = 11
  $A76F  0B                         LOADL_quick   ; inline operand = 11
  $A770  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A773  C6                         UCMPLT
  $A774  D7 4B A7                   JUMPT_abs              $A74B
  $A777  CF                         RETURN

; ============================================================
; sub $A778   (frame_off=+0, body @ $A77D)
; ============================================================
 >$A77D  AC A3 89                   CALL_abs               $89A3 {bytecode}
  $A780  61                         PUSH_qimm   ; inline operand = 1
  $A781  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
 >$A785  40                         LOADL_qimm   ; inline operand = 0
  $A786  A8 79 6F                   STORE_abs              $6F79
  $A789  AC 55 A4                   CALL_abs               $A455 {bytecode}
  $A78C  A4 48 6E                   LOADL_abs              $6E48
  $A78F  51                         LOADR_qimm   ; inline operand = 1
  $A790  C0                         CMPEQ
  $A791  D8 B0 A7                   JUMPF_abs              $A7B0
  $A794  89 FF                      BYTE_LOADL_imm1        -1
  $A796  A9 67 6F                   BYTE_STORE_abs         $6F67
  $A799  62                         PUSH_qimm   ; inline operand = 2
  $A79A  E9 B1 CB 02                CALL_abs_imm1          $CBB1 (call_bank_wrap) {bytecode}, $02
  $A79E  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A7A1  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $A7A4  DA                         AND
  $A7A5  D7 AD A7                   JUMPT_abs              $A7AD
  $A7A8  61                         PUSH_qimm   ; inline operand = 1
  $A7A9  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
 >$A7AD  AC 55 A4                   CALL_abs               $A455 {bytecode}
 >$A7B0  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A7B3  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $A7B6  DA                         AND
  $A7B7  D7 43 A8                   JUMPT_abs              $A843
  $A7BA  A5 67 6F                   BYTE_LOADL_abs         $6F67
  $A7BD  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $A7C0  8C FF 00                   LOADR_imm2             $00FF
  $A7C3  C1                         CMPNE
  $A7C4  D8 FD A7                   JUMPF_abs              $A7FD
  $A7C7  A5 68 6F                   BYTE_LOADL_abs         $6F68
  $A7CA  51                         LOADR_qimm   ; inline operand = 1
  $A7CB  C0                         CMPEQ
  $A7CC  D8 D9 A7                   JUMPF_abs              $A7D9
  $A7CF  8E 40 BF                   PUSH_imm2              $BF40
  $A7D2  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A7D6  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$A7D9  A5 68 6F                   BYTE_LOADL_abs         $6F68
  $A7DC  D8 E3 A7                   JUMPF_abs              $A7E3
  $A7DF  40                         LOADL_qimm   ; inline operand = 0
  $A7E0  D6 E4 A7                   JUMP_abs               $A7E4
 >$A7E3  41                         LOADL_qimm   ; inline operand = 1
 >$A7E4  B3                         PUSHL
  $A7E5  E9 E6 A5 02                CALL_abs_imm1          $A5E6 {bytecode}, $02
  $A7E9  62                         PUSH_qimm   ; inline operand = 2
  $A7EA  E9 B1 CB 02                CALL_abs_imm1          $CBB1 (call_bank_wrap) {bytecode}, $02
  $A7EE  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A7F1  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $A7F4  DA                         AND
  $A7F5  D7 FD A7                   JUMPT_abs              $A7FD
  $A7F8  61                         PUSH_qimm   ; inline operand = 1
  $A7F9  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
 >$A7FD  A4 79 6F                   LOADL_abs              $6F79
  $A800  D7 85 A7                   JUMPT_abs              $A785
  $A803  AC 42 A7                   CALL_abs               $A742 {bytecode}
 >$A806  61                         PUSH_qimm   ; inline operand = 1
  $A807  E9 B1 CB 02                CALL_abs_imm1          $CBB1 (call_bank_wrap) {bytecode}, $02
  $A80B  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A80E  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $A811  DA                         AND
  $A812  D7 43 A8                   JUMPT_abs              $A843
  $A815  A4 79 6F                   LOADL_abs              $6F79
  $A818  D8 39 A8                   JUMPF_abs              $A839
  $A81B  62                         PUSH_qimm   ; inline operand = 2
  $A81C  E9 B1 CB 02                CALL_abs_imm1          $CBB1 (call_bank_wrap) {bytecode}, $02
  $A820  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A823  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $A826  DA                         AND
  $A827  D7 2F A8                   JUMPT_abs              $A82F
  $A82A  61                         PUSH_qimm   ; inline operand = 1
  $A82B  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
 >$A82F  40                         LOADL_qimm   ; inline operand = 0
  $A830  A8 79 6F                   STORE_abs              $6F79
  $A833  D6 06 A8                   JUMP_abs               $A806
  $A836  D6 06 A8                   JUMP_abs               $A806
 >$A839  A5 A1 6D                   BYTE_LOADL_abs         $6DA1
  $A83C  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $A83F  DA                         AND
  $A840  D8 85 A7                   JUMPF_abs              $A785
 >$A843  AC 03 80                   CALL_abs               $8003 (prompt_message_and_redraw) {bytecode}
  $A846  D6 7D A7                   JUMP_abs               $A77D

