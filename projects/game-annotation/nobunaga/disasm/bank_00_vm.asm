VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes  (262144 bytes after header)
  mode:         bulk dump of bank 0
  opcode spec:  vm-opcodes.toml (256 of 256 opcodes defined)
  labels:       230 CPU addresses named

  bank 0: found 98 bytecode-subroutine stubs


; ============================================================
; sub $8003   (frame_off=-6, body @ $8008)
; ============================================================
  $8008  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8009  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $800A  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $800B  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $800F  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8012  AC 28 D6                    host_call_simple         $D628 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8015  D8 1C 81                    branch_z_abs             $811C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8018  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8019  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $801D  8E AE 00                    push_imm_word            $00AE                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8020  8E 10 15                    push_imm_word            $1510                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8023  8E 54 90                    push_imm_word            $9054                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8026  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8027  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $802B  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $802C  8E 74 8D                    push_imm_word            $8D74                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $802F  8D 16                       op_8D_sbyte              +22
  $8031  8D 1F                       op_8D_sbyte              +31
  $8033  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8034  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8035  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8039  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $803A  6D                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 13)
  $803B  8D 11                       op_8D_sbyte              +17
  $803D  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $803E  8D 10                       op_8D_sbyte              +16
  $8040  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8044  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8045  8D 1A                       op_8D_sbyte              +26
  $8047  8D 1F                       op_8D_sbyte              +31
  $8049  8D 18                       op_8D_sbyte              +24
  $804B  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $804C  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8050  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8051  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8052  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8053  8C CA B7                    loadB_imm_word           $B7CA                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8056  BB                          add                                                ; regA = regA + regB
  $8057  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8058  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8059  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $805A  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $805E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $805F  D0                          incA                                               ; regA += 1
  $8060  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8061  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8062  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $8063  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8064  D7 52 80                    branch_nz_abs            $8052                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8067  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8068  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $806C  8D 18                       op_8D_sbyte              +24
  $806E  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $806F  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8073  8E DA B7                    push_imm_word            $B7DA                     ; "Congratulations my Lord!\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8076  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $807A  AA 9F 6D 8E                 op_AA_wb                 $6D9F, $8E
  $807E  F4                          trigger_syscall_EB_FE                              ; BRK to syscall_dispatch (handler $EF92)
  $807F  B7 E9                       ext_op                   $E9                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $8081  34                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 4)
  $8082  D1                          decA                                               ; regA -= 1
  $8083  04                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 4)
  $8084  8E 05 B8                    push_imm_word            $B805                     ; "you united Japan!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8087  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $808B  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $808C  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8090  A4 4D 6F                    loadA_mem_word           $6F4D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8093  D7 B8 80                    branch_nz_abs            $80B8                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8096  AC 59 D7                    host_call_simple         $D759 (ui_helper_d759) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$8099  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $809A  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $809D  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $80A0  A8 DF 7F                    loadA_mem_word           $7FDF                     ; regA = word read using <word> as address (handler $EA75)
 >$80A3  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $80A4  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $80A5  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80A9  D7 A3 80                    branch_nz_abs            $80A3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $80AC  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $80AD  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $80AE  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80B2  D8 C5 80                    branch_z_abs             $80C5                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $80B5  D6 A3 80                    jump_abs                 $80A3                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$80B8  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $80B9  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $80BA  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $80BB  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80BF  D8 99 80                    branch_z_abs             $8099                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $80C2  D6 B8 80                    jump_abs                 $80B8                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$80C5  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $80C6  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $80C7  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80CB  D7 D7 80                    branch_nz_abs            $80D7                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $80CE  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $80CF  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $80D0  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80D4  D8 C5 80                    branch_z_abs             $80C5                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$80D7  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $80D8  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80DC  8E FE 00                    push_imm_word            $00FE                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $80DF  8E 00 10                    push_imm_word            $1000                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $80E2  8E 04 9D                    push_imm_word            $9D04                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $80E5  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $80E6  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80EA  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $80EB  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $80EC  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $80ED  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $80F1  AC 5D CF                    host_call_simple         $CF5D {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $80F4  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $80F5  8E 24 9B                    push_imm_word            $9B24                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $80F8  8D 13                       op_8D_sbyte              +19
  $80FA  8D 1F                       op_8D_sbyte              +31
  $80FC  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $80FD  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $80FE  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8102  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8103  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8104  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8105  8C D2 B7                    loadB_imm_word           $B7D2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8108  BB                          add                                                ; regA = regA + regB
  $8109  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $810A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $810B  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $810C  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8110  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8111  D0                          incA                                               ; regA += 1
  $8112  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8113  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8114  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $8115  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8116  D7 04 81                    branch_nz_abs            $8104                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8119  D6 B1 81                    jump_abs                 $81B1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$811C  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $811D  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8121  8D 1A                       op_8D_sbyte              +26
  $8123  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $8124  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8128  8E 17 B8                    push_imm_word            $B817                     ; "Game over"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $812B  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $812F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8130  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
 >$8131  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8132  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8133  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8134  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $8135  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8139  8D 13                       op_8D_sbyte              +19
  $813B  E9 26 F2 02                 host_call                $F226 (syscall_dispatch) {native}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $813F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8140  5F                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 15)
  $8141  DA                          bitand                                             ; regA = regA & regB
  $8142  5C                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 12)
  $8143  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8144  D8 4C 81                    branch_z_abs             $814C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8147  43                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8148  CD                          swap_AB                                            ; regA <-> regB
  $8149  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $814A  BB                          add                                                ; regA = regA + regB
  $814B  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$814C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $814D  D0                          incA                                               ; regA += 1
  $814E  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $814F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8150  8B 40                       loadB_imm_byte           +64                       ; regB = byte literal (handler $EABE)
  $8152  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8153  D7 33 81                    branch_nz_abs            $8133                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8156  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8157  D0                          incA                                               ; regA += 1
  $8158  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8159  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $815A  56                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 6)
  $815B  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $815C  D7 31 81                    branch_nz_abs            $8131                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $815F  A4 4D 6F                    loadA_mem_word           $6F4D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8162  D8 6F 81                    branch_z_abs             $816F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$8165  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8166  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8167  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $8168  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $816C  D7 65 81                    branch_nz_abs            $8165                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$816F  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8170  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8174  8E F8 00                    push_imm_word            $00F8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8177  8E 00 10                    push_imm_word            $1000                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $817A  8E 64 AF                    push_imm_word            $AF64                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $817D  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $817E  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8182  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8183  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8184  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $8185  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8189  AC 5D CF                    host_call_simple         $CF5D {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $818C  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $818D  8E E4 AC                    push_imm_word            $ACE4                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8190  8D 18                       op_8D_sbyte              +24
  $8192  8D 1F                       op_8D_sbyte              +31
  $8194  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $8195  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8196  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $819A  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $819B  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$819C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $819D  8C D6 B7                    loadB_imm_word           $B7D6                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $81A0  BB                          add                                                ; regA = regA + regB
  $81A1  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $81A2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $81A3  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $81A4  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81A8  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $81A9  D0                          incA                                               ; regA += 1
  $81AA  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $81AB  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $81AC  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $81AD  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $81AE  D7 9C 81                    branch_nz_abs            $819C                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$81B1  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $81B2  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81B6  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $81B7  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81BB  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $81BC  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $81BF  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $81C2  A8 DF 7F                    loadA_mem_word           $7FDF                     ; regA = word read using <word> as address (handler $EA75)
 >$81C5  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $81C6  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $81C7  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81CB  D7 C5 81                    branch_nz_abs            $81C5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $81CE  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $81CF  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $81D0  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81D4  D7 C5 81                    branch_nz_abs            $81C5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$81D7  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $81D8  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $81D9  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81DD  D7 E9 81                    branch_nz_abs            $81E9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $81E0  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $81E1  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $81E2  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81E6  D8 D7 81                    branch_z_abs             $81D7                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$81E9  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $81EA  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81EE  8D 51                       op_8D_sbyte              +81
  $81F0  8E 00 10                    push_imm_word            $1000                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $81F3  8E BA B2                    push_imm_word            $B2BA                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $81F6  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $81F7  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $81FB  AC 50 CF                    host_call_simple         $CF50 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $81FE  AC 5D CF                    host_call_simple         $CF5D {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8201  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8202  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8206  8E 21 B8                    push_imm_word            $B821                     ; "Would you like to\nplay again"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8209  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $820D  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8210  D7 1D 82                    branch_nz_abs            $821D                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8213  8E 3E B8                    push_imm_word            $B83E                     ; "Thanks for\nplaying"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8216  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$821A  D6 1A 82                    jump_abs                 $821A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$821D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $821E   (frame_off=-8, body @ $8223)
; ============================================================
  $8223  D6 35 82                    jump_abs                 $8235                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8226  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8227  E9 A4 CB 02                 host_call                $CBA4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $822B  8E 90 B8                    push_imm_word            $B890                     ; "No saved data"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $822E  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8232  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$8235  8E 82 B8                    push_imm_word            $B882                     ; "New game"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8238  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $823C  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $823F  D8 44 82                    branch_z_abs             $8244                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8242  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8243  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8244  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8245  E9 A4 CB 02                 host_call                $CBA4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8249  8E 8B B8                    push_imm_word            $B88B                     ; "KOEI"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $824C  8E ED 7F                    push_imm_word            $7FED                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $824F  E9 B0 CA 04                 host_call                $CAB0 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8253  D7 26 82                    branch_nz_abs            $8226                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8256  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8257  E9 A4 CB 02                 host_call                $CBA4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $825B  8E FF 00                    push_imm_word            $00FF                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $825E  8E 01 60                    push_imm_word            $6001                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8261  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8262  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8263  8D 16                       op_8D_sbyte              +22
  $8265  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8269  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $826A  8A 00 61                    loadA_imm_word           $6100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $826D  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$826E  8E 00 01                    push_imm_word            $0100                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8271  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8272  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8273  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8274  8D 16                       op_8D_sbyte              +22
  $8276  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $827A  CD                          swap_AB                                            ; regA <-> regB
  $827B  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $827C  BB                          add                                                ; regA = regA + regB
  $827D  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $827E  8A 00 01                    loadA_imm_word           $0100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8281  CD                          swap_AB                                            ; regA <-> regB
  $8282  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8283  BB                          add                                                ; regA = regA + regB
  $8284  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8285  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8286  8C 00 70                    loadB_imm_word           $7000                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8289  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $828A  D7 6E 82                    branch_nz_abs            $826E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $828D  8E FF 00                    push_imm_word            $00FF                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8290  8E 01 70                    push_imm_word            $7001 (province_table_live) ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8293  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8294  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8295  8D 16                       op_8D_sbyte              +22
  $8297  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $829B  CD                          swap_AB                                            ; regA <-> regB
  $829C  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $829D  BB                          add                                                ; regA = regA + regB
  $829E  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $829F  8A 00 71                    loadA_imm_word           $7100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $82A2  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$82A3  8E 00 01                    push_imm_word            $0100                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $82A6  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $82A7  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $82A8  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $82A9  8D 16                       op_8D_sbyte              +22
  $82AB  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $82AF  CD                          swap_AB                                            ; regA <-> regB
  $82B0  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $82B1  BB                          add                                                ; regA = regA + regB
  $82B2  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $82B3  8A 00 01                    loadA_imm_word           $0100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $82B6  CD                          swap_AB                                            ; regA <-> regB
  $82B7  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $82B8  BB                          add                                                ; regA = regA + regB
  $82B9  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $82BA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $82BB  8C 00 7F                    loadB_imm_word           $7F00 (ui_transient_state) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $82BE  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $82BF  D7 A3 82                    branch_nz_abs            $82A3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $82C2  8E EB 81                    push_imm_word            $81EB                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $82C5  8E 00 7F                    push_imm_word            $7F00 (ui_transient_state) ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $82C8  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $82C9  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $82CA  8D 16                       op_8D_sbyte              +22
  $82CC  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $82D0  CD                          swap_AB                                            ; regA <-> regB
  $82D1  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $82D2  BB                          add                                                ; regA = regA + regB
  $82D3  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $82D4  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $82D5  E9 A4 CB 02                 host_call                $CBA4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $82D9  A4 EB 7F                    loadA_mem_word           $7FEB                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $82DC  18                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 8)
  $82DD  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $82DE  D8 43 83                    branch_z_abs             $8343                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $82E1  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $82E2  E9 A4 CB 02                 host_call                $CBA4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $82E6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $82E7  A8 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word read using <word> as address (handler $EA75)
  $82EA  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $82EB  A8 61 6F                    loadA_mem_word           $6F61                     ; regA = word read using <word> as address (handler $EA75)
  $82EE  8E 9E B8                    push_imm_word            $B89E                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $82F1  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $82F5  8E 9F B8                    push_imm_word            $B89F                     ; "Data loaded"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $82F8  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $82FC  AC 59 D7                    host_call_simple         $D759 (ui_helper_d759) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $82FF  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8302  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8303  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8307  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $8308  8E D0 14                    push_imm_word            $14D0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $830B  8E 8A B7                    push_imm_word            $B78A                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $830E  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $830F  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8313  8E 9A 00                    push_imm_word            $009A                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8316  8E 10 15                    push_imm_word            $1510                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8319  8E BC 83                    push_imm_word            $83BC                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $831C  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $831D  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8321  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8322  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
 >$8323  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8324  8C 52 B8                    loadB_imm_word           $B852                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8327  BB                          add                                                ; regA = regA + regB
  $8328  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8329  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $832A  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $832B  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $832F  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8330  D0                          incA                                               ; regA += 1
  $8331  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8332  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8333  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $8334  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8335  D7 23 83                    branch_nz_abs            $8323                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8338  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8339  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $833D  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $833E  A8 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word read using <word> as address (handler $EA75)
  $8341  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8342  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8343  8E AB B8                    push_imm_word            $B8AB                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8346  8E ED 7F                    push_imm_word            $7FED                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8349  E9 D9 CA 04                 host_call                $CAD9 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $834D  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $834E  E9 A4 CB 02                 host_call                $CBA4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8352  89 32                       loadA_imm_sbyte          +50                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $8354  A8 65 6D                    loadA_mem_word           $6D65                     ; regA = word read using <word> as address (handler $EA75)
  $8357  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8358  A8 4D 6F                    loadA_mem_word           $6F4D                     ; regA = word read using <word> as address (handler $EA75)
  $835B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $835C  A8 C7 7F                    loadA_mem_word           $7FC7                     ; regA = word read using <word> as address (handler $EA75)
  $835F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8360  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $8363  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8364  A8 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word read using <word> as address (handler $EA75)
  $8367  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $836A  8E B0 B8                    push_imm_word            $B8B0                     ; "Data can`t be\nused"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $836D  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8371  AC 09 D6                    host_call_simple         $D609 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8374  D6 35 82                    jump_abs                 $8235                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)

; ============================================================
; sub $8377   (frame_off=-1, body @ $837C)
; ============================================================
  $837C  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $837D  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $837E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $837F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8380  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8384  A2 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $8386  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $8387  A3 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $8389  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $838A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $838B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $838C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $838D  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $838E  BB                          add                                                ; regA = regA + regB
  $838F  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8390  A3 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $8392  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $8393  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8394  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8395  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8396  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8397  BC                          sub                                                ; regA = regA - regB
  $8398  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8399  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $839A   (frame_off=-2, body @ $839F)
; ============================================================
  $839F  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $83A0  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $83A1  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $83A2  8C A9 76                    loadB_imm_word           $76A9                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $83A5  BB                          add                                                ; regA = regA + regB
  $83A6  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $83A7  8D 1E                       op_8D_sbyte              +30
  $83A9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $83AA  73                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 3)
  $83AB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83AC  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $83AD  E9 77 83 06                 host_call                $8377 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83B1  8D 14                       op_8D_sbyte              +20
  $83B3  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83B7  8F 14                       addA_imm_sbyte           +20                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $83B9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83BA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $83BB  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $83BC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83BD  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $83BE  E9 77 83 06                 host_call                $8377 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83C2  8D 1E                       op_8D_sbyte              +30
  $83C4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $83C5  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $83C6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83C7  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $83C8  D0                          incA                                               ; regA += 1
  $83C9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83CA  E9 77 83 06                 host_call                $8377 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83CE  8D 14                       op_8D_sbyte              +20
  $83D0  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83D4  8F 14                       addA_imm_sbyte           +20                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $83D6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83D7  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $83D8  73                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 3)
  $83D9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83DA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $83DB  D0                          incA                                               ; regA += 1
  $83DC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $83DD  E9 77 83 06                 host_call                $8377 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83E1  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $83E2   (frame_off=-40, body @ $83E7)
; ============================================================
  $83E7  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $83E8  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83EC  8F 14                       addA_imm_sbyte           +20                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $83EE  A8 0D 6E                    loadA_mem_word           $6E0D                     ; regA = word read using <word> as address (handler $EA75)
  $83F1  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $83F2  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $83F3  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $83F4  D6 B4 85                    jump_abs                 $85B4                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$83F7  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $83F8  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $83FC  D7 93 85                    branch_nz_abs            $8593                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $83FF  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8400  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8404  57                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 7)
  $8405  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8406  8C 30 75                    loadB_imm_word           $7530                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8409  BB                          add                                                ; regA = regA + regB
  $840A  85 D8                       op_85_byte               $D8
  $840C  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $840D  D6 23 84                    jump_abs                 $8423                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8410  A4 63 6D                    loadA_mem_word           $6D63 (const_two)         ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8413  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8414  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8415  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8416  81 D8                       op_81_byte               $D8
  $8418  D0                          incA                                               ; regA += 1
  $8419  85 D8                       op_85_byte               $D8
  $841B  D1                          decA                                               ; regA -= 1
  $841C  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $841D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $841E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $841F  BB                          add                                                ; regA = regA + regB
  $8420  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8421  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8422  D0                          incA                                               ; regA += 1
 >$8423  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8424  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8425  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8426  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8427  D7 10 84                    branch_nz_abs            $8410                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $842A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $842B  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $842D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $842E  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8431  BB                          add                                                ; regA = regA + regB
  $8432  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $8433  A4 63 6D                    loadA_mem_word           $6D63 (const_two)         ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8436  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $8437  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8438  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8439  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $843A  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $843B  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $843C  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $843E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $843F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8440  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8441  BB                          add                                                ; regA = regA + regB
  $8442  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8443  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8444  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$8445  A4 63 6D                    loadA_mem_word           $6D63 (const_two)         ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8448  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8449  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $844A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $844B  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $844C  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $844D  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $844E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $844F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8450  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8451  BB                          add                                                ; regA = regA + regB
  $8452  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8453  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8454  D0                          incA                                               ; regA += 1
  $8455  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8456  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8457  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $8458  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8459  D7 45 84                    branch_nz_abs            $8445                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $845C  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $845F  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $8461  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8462  D8 07 85                    branch_z_abs             $8507                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8465  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8466  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8467  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8468  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $846B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $846C  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $846D  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $846E  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8471  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8472  5D                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 13)
  $8473  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8474  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8477  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8478  5E                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 14)
  $8479  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $847A  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $847D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $847E  8B 13                       loadB_imm_byte           +19                       ; regB = byte literal (handler $EABE)
  $8480  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8481  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8484  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8485  8B 17                       loadB_imm_byte           +23                       ; regB = byte literal (handler $EABE)
  $8487  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8488  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $848B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $848C  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $848E  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $848F  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8492  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8493  8B 15                       loadB_imm_byte           +21                       ; regB = byte literal (handler $EABE)
  $8495  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8496  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8499  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $849A  8B 26                       loadB_imm_byte           +38                       ; regB = byte literal (handler $EABE)
  $849C  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $849D  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $84A0  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84A1  8B 2A                       loadB_imm_byte           +42                       ; regB = byte literal (handler $EABE)
  $84A3  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $84A4  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $84A7  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84A8  8B 31                       loadB_imm_byte           +49                       ; regB = byte literal (handler $EABE)
  $84AA  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $84AB  D7 B5 84                    branch_nz_abs            $84B5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $84AE  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84AF  8B 18                       loadB_imm_byte           +24                       ; regB = byte literal (handler $EABE)
  $84B1  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $84B2  D8 8E 85                    branch_z_abs             $858E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$84B5  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $84B6  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $84BA  D8 8E 85                    branch_z_abs             $858E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $84BD  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $84BF  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $84C0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $84C1  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $84C2  D2                          aslA                                               ; regA <<= 1
  $84C3  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $84C4  BB                          add                                                ; regA = regA + regB
  $84C5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $84C6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84C7  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $84C8  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $84C9  D0                          incA                                               ; regA += 1
  $84CA  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $84CB  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $84CC  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84CD  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $84CF  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $84D0  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $84D3  BB                          add                                                ; regA = regA + regB
  $84D4  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $84D5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $84D6  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $84D7  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $84D8  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $84D9  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $84DA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84DB  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $84DD  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $84DE  8C 07 70                    loadB_imm_word           $7007                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $84E1  BB                          add                                                ; regA = regA + regB
  $84E2  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $84E3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $84E4  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $84E5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $84E6  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $84E7  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $84E8  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84E9  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $84EB  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $84EC  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $84EF  BB                          add                                                ; regA = regA + regB
  $84F0  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $84F1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $84F2  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $84F3  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $84F4  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $84F5  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $84F6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $84F7  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $84F9  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $84FA  8C 13 70                    loadB_imm_word           $7013                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $84FD  BB                          add                                                ; regA = regA + regB
  $84FE  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $84FF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8500  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8501  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8502  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8503  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $8504  D6 81 85                    jump_abs                 $8581                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8507  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8508  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $8509  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $850A  D7 32 85                    branch_nz_abs            $8532                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $850D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $850E  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $850F  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8510  D7 32 85                    branch_nz_abs            $8532                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8513  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8514  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $8515  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8516  D7 32 85                    branch_nz_abs            $8532                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8519  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $851A  57                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 7)
  $851B  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $851C  D7 32 85                    branch_nz_abs            $8532                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $851F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8520  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $8521  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8522  D7 32 85                    branch_nz_abs            $8532                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8525  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8526  5F                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 15)
  $8527  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8528  D7 32 85                    branch_nz_abs            $8532                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $852B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $852C  8B 10                       loadB_imm_byte           +16                       ; regB = byte literal (handler $EABE)
  $852E  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $852F  D8 8E 85                    branch_z_abs             $858E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$8532  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8533  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8537  D8 8E 85                    branch_z_abs             $858E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $853A  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $853C  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $853D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $853E  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $853F  D2                          aslA                                               ; regA <<= 1
  $8540  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8541  BB                          add                                                ; regA = regA + regB
  $8542  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8543  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8544  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8545  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8546  D0                          incA                                               ; regA += 1
  $8547  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8548  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8549  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $854A  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $854C  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $854D  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8550  BB                          add                                                ; regA = regA + regB
  $8551  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8552  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8553  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8554  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8555  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8556  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $8557  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8558  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $855A  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $855B  8C 07 70                    loadB_imm_word           $7007                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $855E  BB                          add                                                ; regA = regA + regB
  $855F  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8560  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8561  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8562  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8563  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8564  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8565  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8566  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8568  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8569  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $856C  BB                          add                                                ; regA = regA + regB
  $856D  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $856E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $856F  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8570  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8571  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8572  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8573  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8574  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8576  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8577  8C 13 70                    loadB_imm_word           $7013                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $857A  BB                          add                                                ; regA = regA + regB
  $857B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $857C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $857D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $857E  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $857F  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8580  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
 >$8581  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8582  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8584  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8585  8C 11 70                    loadB_imm_word           $7011                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8588  BB                          add                                                ; regA = regA + regB
  $8589  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $858A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $858B  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $858C  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $858D  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$858E  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $858F  E9 9A 83 02                 host_call                $839A {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$8593  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8594  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8596  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8597  8C 19 70                    loadB_imm_word           $7019                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $859A  BB                          add                                                ; regA = regA + regB
  $859B  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $859C  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $859D  8D 14                       op_8D_sbyte              +20
  $859F  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $85A3  8F 50                       addA_imm_sbyte           +80                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $85A5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $85A6  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $85A7  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $85A8  90 E8 03                    op_90_bb                 $E8, $03
  $85AB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $85AC  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $85B0  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $85B1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $85B2  D0                          incA                                               ; regA += 1
  $85B3  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$85B4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $85B5  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $85B8  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $85B9  D7 F7 83                    branch_nz_abs            $83F7                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $85BC  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $85BD  D6 F4 85                    jump_abs                 $85F4                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$85C0  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $85C1  D6 EB 85                    jump_abs                 $85EB                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$85C4  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $85C6  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $85C7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $85C8  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $85C9  D2                          aslA                                               ; regA <<= 1
  $85CA  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $85CB  BB                          add                                                ; regA = regA + regB
  $85CC  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $85CD  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $85D0  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $85D2  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $85D3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $85D4  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $85D5  D2                          aslA                                               ; regA <<= 1
  $85D6  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $85D7  BB                          add                                                ; regA = regA + regB
  $85D8  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $85D9  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $85DC  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $85DF  A6 63 6F                    loadB_mem_word           $6F63                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $85E2  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $85E3  D8 E9 85                    branch_z_abs             $85E9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $85E6  AC 7D DA                    host_call_simple         $DA7D (diplomacy_helper3) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$85E9  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $85EA  D0                          incA                                               ; regA += 1
 >$85EB  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $85EC  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $85ED  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $85EE  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $85EF  D7 C4 85                    branch_nz_abs            $85C4                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $85F2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $85F3  D0                          incA                                               ; regA += 1
 >$85F4  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $85F5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $85F6  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $85F7  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $85F8  D7 C0 85                    branch_nz_abs            $85C0                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $85FB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $85FC   (frame_off=-4, body @ $8601)
; ============================================================
  $8601  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8604  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8605  AC 4E D1                    host_call_simple         $D14E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8608  D7 05 86                    branch_nz_abs            $8605                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $860B  D6 12 86                    jump_abs                 $8612                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$860E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $860F  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
 >$8612  8D 32                       op_8D_sbyte              +50
  $8614  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8618  8F 3C                       addA_imm_sbyte           +60                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $861A  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $861B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $861C  8E C3 B8                    push_imm_word            $B8C3                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $861F  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8623  AC 4E D1                    host_call_simple         $D14E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8626  D8 0E 86                    branch_z_abs             $860E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8629  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $862A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $862B   (frame_off=-4, body @ $8630)
; ============================================================
 >$8630  8E C7 B8                    push_imm_word            $B8C7                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8633  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8637  8E C8 B8                    push_imm_word            $B8C8                     ; "(17fiefs/50fiefs)\n? "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $863A  E9 51 D3 02                 host_call                $D351 (ui_helper_d351) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $863E  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $863F  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8640  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $8641  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8642  D7 30 86                    branch_nz_abs            $8630                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8645  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8646  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $8647  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8648  D8 56 86                    branch_z_abs             $8656                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $864B  89 11                       loadA_imm_sbyte          +17                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $864D  A8 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word read using <word> as address (handler $EA75)
  $8650  8A 04 A0                    loadA_imm_word           $A004                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8653  D6 5E 86                    jump_abs                 $865E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8656  89 32                       loadA_imm_sbyte          +50                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $8658  A8 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word read using <word> as address (handler $EA75)
  $865B  8A 04 80                    loadA_imm_word           $8004                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
 >$865E  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $865F  8A CF 7F                    loadA_imm_word           $7FCF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8662  8C 01 60                    loadB_imm_word           $6001                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8665  BC                          sub                                                ; regA = regA - regB
  $8666  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $8667  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8668  8E 01 60                    push_imm_word            $6001                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $866B  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $866C  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $866D  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8671  8E DD B8                    push_imm_word            $B8DD                     ; "Watch other\ndaimyos battle"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8674  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8678  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $867B  A8 7D 6E                    loadA_mem_word           $6E7D                     ; regA = word read using <word> as address (handler $EA75)
  $867E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $867F   (frame_off=+0, body @ $8684)
; ============================================================
  $8684  8E F8 B8                    push_imm_word            $B8F8                     ; "Player "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8687  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $868B  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $868C  8E 00 B9                    push_imm_word            $B900                     ; "%d, which\nfief would you\nlike to rule"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $868F  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8693  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8694   (frame_off=-4, body @ $8699)
; ============================================================
  $8699  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $869C  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $869E  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $869F  D8 A6 86                    branch_z_abs             $86A6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $86A2  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $86A3  D6 A7 86                    jump_abs                 $86A7                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$86A6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$86A7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $86A8  E9 F2 E5 02                 host_call                $E5F2 (map_helper_e5f2) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $86AC  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $86AD  A8 E0 7B                    loadA_mem_word           $7BE0                     ; regA = word read using <word> as address (handler $EA75)
  $86B0  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $86B1  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$86B2  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $86B3  E9 7F 86 02                 host_call                $867F {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $86B7  D6 F1 86                    jump_abs                 $86F1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$86BA  A4 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $86BD  D1                          decA                                               ; regA -= 1
  $86BE  A8 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word read using <word> as address (handler $EA75)
  $86C1  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $86C2  8B FF                       loadB_imm_byte           -1                        ; regB = byte literal (handler $EABE)
  $86C4  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $86C5  D8 F1 86                    branch_z_abs             $86F1                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $86C8  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $86CB  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $86CD  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $86CE  D8 DF 86                    branch_z_abs             $86DF                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $86D1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $86D2  D0                          incA                                               ; regA += 1
  $86D3  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $86D4  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $86D5  C9                          cmp_ult                                            ; regA = (regA < regB) ? 1 : 0   (unsigned)
  $86D6  D8 DB 86                    branch_z_abs             $86DB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $86D9  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $86DA  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$86DB  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $86DC  D6 ED 86                    jump_abs                 $86ED                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$86DF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $86E0  D0                          incA                                               ; regA += 1
  $86E1  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $86E2  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $86E3  C9                          cmp_ult                                            ; regA = (regA < regB) ? 1 : 0   (unsigned)
  $86E4  D8 E9 86                    branch_z_abs             $86E9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $86E7  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $86E8  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$86E9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $86EA  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $86EC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
 >$86ED  E9 F2 E5 02                 host_call                $E5F2 (map_helper_e5f2) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$86F1  AA 9D 6D 61                 op_AA_wb                 $6D9D, $61
  $86F5  E9 E9 D5 04                 host_call                $D5E9 (number_input) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $86F9  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $86FA  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $86FB  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $86FC  D7 BA 86                    branch_nz_abs            $86BA                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $86FF  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8700  D1                          decA                                               ; regA -= 1
  $8701  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8702  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8705  BB                          add                                                ; regA = regA + regB
  $8706  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8707  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8708  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $8709  D8 34 87                    branch_z_abs             $8734                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $870C  8E 26 B9                    push_imm_word            $B926                     ; "Is "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $870F  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8713  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8714  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $8715  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8716  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8719  BB                          add                                                ; regA = regA + regB
  $871A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $871B  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $871F  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8720  D0                          incA                                               ; regA += 1
  $8721  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8722  8E 2A B9                    push_imm_word            $B92A                     ; " of\nfief %2d OK"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8725  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8729  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $872C  D8 3E 87                    branch_z_abs             $873E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $872F  49                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8730  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8731  D6 3E 87                    jump_abs                 $873E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8734  8E 3A B9                    push_imm_word            $B93A                     ; "That daimyo is\nalready taken"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8737  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $873B  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$873E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $873F  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $8740  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $8741  D7 B2 86                    branch_nz_abs            $86B2                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8744  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8745  A8 E0 7B                    loadA_mem_word           $7BE0                     ; regA = word read using <word> as address (handler $EA75)
  $8748  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8749  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $874C  BB                          add                                                ; regA = regA + regB
  $874D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $874E  45                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $874F  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8750  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8751  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $8754  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8755  A8 DD 7F                    loadA_mem_word           $7FDD                     ; regA = word read using <word> as address (handler $EA75)
  $8758  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8759  8C D4 7F                    loadB_imm_word           $7FD4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $875C  BB                          add                                                ; regA = regA + regB
  $875D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $875E  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8761  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8762  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8763   (frame_off=-6, body @ $8768)
; ============================================================
  $8768  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $876B  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $876C  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8770  8D 2B                       op_8D_sbyte              +43
  $8772  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $8773  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8777  8D 25                       op_8D_sbyte              +37
  $8779  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $877A  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $877E  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $877F  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $8780  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $8781  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8782  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8783  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8787  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8788  8D 10                       op_8D_sbyte              +16
  $878A  8D 1A                       op_8D_sbyte              +26
  $878C  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $878D  8D 10                       op_8D_sbyte              +16
  $878F  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8793  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8794  8D 12                       op_8D_sbyte              +18
  $8796  8D 1A                       op_8D_sbyte              +26
  $8798  8D 12                       op_8D_sbyte              +18
  $879A  6E                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 14)
  $879B  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $879F  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $87A0  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $87A1  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87A5  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $87A8  D0                          incA                                               ; regA += 1
  $87A9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $87AA  8E 57 B9                    push_imm_word            $B957                     ; "Fief %2d"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $87AD  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87B1  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $87B2  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $87B3  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87B7  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $87BA  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $87BB  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $87BC  8C 85 79                    loadB_imm_word           $7985                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $87BF  BB                          add                                                ; regA = regA + regB
  $87C0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $87C1  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87C5  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $87C6  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $87C7  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87CB  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $87CE  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $87CF  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $87D0  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $87D3  BB                          add                                                ; regA = regA + regB
  $87D4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $87D5  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87D9  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $87DA  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $87DB  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87DF  AC EA D7                    host_call_simple         $D7EA (ui_helper_d7ea) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $87E2  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $87E3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $87E4  D0                          incA                                               ; regA += 1
  $87E5  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $87E6  D1                          decA                                               ; regA -= 1
  $87E7  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $87E8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $87E9  8E 60 B9                    push_imm_word            $B960                     ; "Age-%2d-"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $87EC  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87F0  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $87F3  A8 5B 6F                    loadA_mem_word           $6F5B                     ; regA = word read using <word> as address (handler $EA75)
  $87F6  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $87F7  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $87F8  E9 6F E7 04                 host_call                $E76F (marry_helper_e76f) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $87FC  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $87FD  6D                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 13)
  $87FE  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8802  8E 69 B9                    push_imm_word            $B969                     ; "Please set"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8805  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8809  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $880A  6D                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 13)
  $880B  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $880F  8E 74 B9                    push_imm_word            $B974                     ; "daimyo abilities"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8812  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8816  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $8817  6D                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 13)
  $8818  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $881C  8E 85 B9                    push_imm_word            $B985                     ; "Press any button"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $881F  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8823  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $8824  6D                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 13)
  $8825  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8829  8E 96 B9                    push_imm_word            $B996                     ; "to set abilities"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $882C  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8830  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8831  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
 >$8832  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8833  7B                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 11)
  $8834  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8835  8D 10                       op_8D_sbyte              +16
  $8837  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $883B  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $883C  D2                          aslA                                               ; regA <<= 1
  $883D  8C AE F8                    loadB_imm_word           $F8AE                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8840  BB                          add                                                ; regA = regA + regB
  $8841  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8842  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8843  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8847  89 16                       loadA_imm_sbyte          +22                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $8849  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  $884C  8E A7 B9                    push_imm_word            $B9A7                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $884F  E9 34 D1 02                 host_call                $D134 (ui_helper_d134) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8853  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8854  D0                          incA                                               ; regA += 1
  $8855  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8856  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8857  56                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 6)
  $8858  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $8859  D7 32 88                    branch_nz_abs            $8832                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $885C  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $885D  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$8861  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8862  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8863  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8866  57                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 7)
  $8867  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8868  8C 30 75                    loadB_imm_word           $7530                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $886B  BB                          add                                                ; regA = regA + regB
  $886C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $886D  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $886E  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$886F  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8870  7B                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 11)
  $8871  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8872  8D 17                       op_8D_sbyte              +23
  $8874  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8878  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8879  AC FC 85                    host_call_simple         $85FC {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $887C  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $887D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $887E  D0                          incA                                               ; regA += 1
  $887F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8880  D1                          decA                                               ; regA -= 1
  $8881  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8882  CD                          swap_AB                                            ; regA <-> regB
  $8883  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8884  BB                          add                                                ; regA = regA + regB
  $8885  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8886  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8887  D0                          incA                                               ; regA += 1
  $8888  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8889  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $888A  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $888B  C7                          cmp_ule                                            ; regA = (regA <= regB) ? 1 : 0  (unsigned)
  $888C  D7 6F 88                    branch_nz_abs            $886F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $888F  8D 12                       op_8D_sbyte              +18
  $8891  6F                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 15)
  $8892  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8896  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $8897  8E AD B9                    push_imm_word            $B9AD                     ; "Total  %4d"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $889A  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $889E  8E B8 B9                    push_imm_word            $B9B8                     ; "Is this OK"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $88A1  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $88A5  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $88A8  D8 61 88                    branch_z_abs             $8861                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $88AB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $88AC   (frame_off=-2, body @ $88B1)
; ============================================================
  $88B1  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $88B2  A8 C5 7F                    loadA_mem_word           $7FC5                     ; regA = word read using <word> as address (handler $EA75)
  $88B5  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $88B6  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $88BA  8D 66                       op_8D_sbyte              +102
  $88BC  8E 00 10                    push_imm_word            $1000                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $88BF  8E 4A AC                    push_imm_word            $AC4A                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $88C2  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $88C3  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $88C7  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $88C8  8E C0 23                    push_imm_word            $23C0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $88CB  8E 4A A8                    push_imm_word            $A84A                     ; "UUUUUUUUUUUUUUUUUU"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $88CE  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $88CF  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $88D3  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $88D4  8E 8A A8                    push_imm_word            $A88A                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $88D7  8D 1D                       op_8D_sbyte              +29
  $88D9  8D 1F                       op_8D_sbyte              +31
  $88DB  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $88DC  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $88DD  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $88E1  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $88E2  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$88E3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $88E4  8C 62 B8                    loadB_imm_word           $B862                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $88E7  BB                          add                                                ; regA = regA + regB
  $88E8  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $88E9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $88EA  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $88EB  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $88EF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $88F0  D0                          incA                                               ; regA += 1
  $88F1  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $88F2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $88F3  8B 20                       loadB_imm_byte           +32                       ; regB = byte literal (handler $EABE)
  $88F5  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $88F6  D7 E3 88                    branch_nz_abs            $88E3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $88F9  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $88FA  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $88FE  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8901  A8 DF 7F                    loadA_mem_word           $7FDF                     ; regA = word read using <word> as address (handler $EA75)
  $8904  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8905  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
 >$8908  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8909  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $890A  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $890E  D7 08 89                    branch_nz_abs            $8908                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8911  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8912  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8913  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8917  D7 08 89                    branch_nz_abs            $8908                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$891A  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $891B  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $891C  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8920  D7 2C 89                    branch_nz_abs            $892C                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8923  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8924  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8925  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8929  D8 1A 89                    branch_z_abs             $891A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$892C  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $892D  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8931  8D 51                       op_8D_sbyte              +81
  $8933  8E 00 10                    push_imm_word            $1000                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8936  8E BA B2                    push_imm_word            $B2BA                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8939  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $893A  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $893E  8E B1 00                    push_imm_word            $00B1                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8941  8E D0 14                    push_imm_word            $14D0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8944  8E 64 82                    push_imm_word            $8264                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8947  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8948  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $894C  AC 50 CF                    host_call_simple         $CF50 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $894F  AC 5D CF                    host_call_simple         $CF5D {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8952  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8953  8E 04 80                    push_imm_word            $8004                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8956  8D 15                       op_8D_sbyte              +21
  $8958  8D 1F                       op_8D_sbyte              +31
  $895A  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $895B  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $895C  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8960  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8961  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $8962  8D 11                       op_8D_sbyte              +17
  $8964  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $8965  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8966  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $896A  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $896B  8D 1A                       op_8D_sbyte              +26
  $896D  8D 1D                       op_8D_sbyte              +29
  $896F  8D 1A                       op_8D_sbyte              +26
  $8971  8D 14                       op_8D_sbyte              +20
  $8973  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8977  8D 1A                       op_8D_sbyte              +26
  $8979  8D 15                       op_8D_sbyte              +21
  $897B  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $897F  8E C3 B9                    push_imm_word            $B9C3                     ; "Control 1"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8982  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8986  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8987  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8988  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8989  8C 5A B8                    loadB_imm_word           $B85A                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $898C  BB                          add                                                ; regA = regA + regB
  $898D  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $898E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $898F  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8990  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8994  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8995  D0                          incA                                               ; regA += 1
  $8996  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8997  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8998  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $8999  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $899A  D7 88 89                    branch_nz_abs            $8988                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $899D  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $899E  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $89A2  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $89A3   (frame_off=-2, body @ $89A8)
; ============================================================
  $89A8  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $89A9  A8 4D 6F                    loadA_mem_word           $6F4D                     ; regA = word read using <word> as address (handler $EA75)
  $89AC  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $89AD  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $89B1  AC AC 88                    host_call_simple         $88AC {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $89B4  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $89B5  A8 E7 7F                    loadA_mem_word           $7FE7                     ; regA = word read using <word> as address (handler $EA75)
  $89B8  89 32                       loadA_imm_sbyte          +50                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $89BA  A8 65 6D                    loadA_mem_word           $6D65                     ; regA = word read using <word> as address (handler $EA75)
  $89BD  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $89BE  A8 C7 7F                    loadA_mem_word           $7FC7                     ; regA = word read using <word> as address (handler $EA75)
 >$89C1  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $89C2  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $89C5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $89C6  A8 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word read using <word> as address (handler $EA75)
  $89C9  AC 1E 82                    host_call_simple         $821E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $89CC  D8 D7 89                    branch_z_abs             $89D7                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $89CF  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $89D0  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $89D1  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $89D2  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $89D6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$89D7  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $89D8  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$89D9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $89DA  8C D5 7F                    loadB_imm_word           $7FD5                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $89DD  BB                          add                                                ; regA = regA + regB
  $89DE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $89DF  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $89E1  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $89E2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $89E3  D0                          incA                                               ; regA += 1
  $89E4  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $89E5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $89E6  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $89E7  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $89E8  D7 D9 89                    branch_nz_abs            $89D9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $89EB  AC 2B 86                    host_call_simple         $862B {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $89EE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $89EF  D6 FC 89                    jump_abs                 $89FC                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$89F2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $89F3  8C 1B 6F                    loadB_imm_word           $6F1B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $89F6  BB                          add                                                ; regA = regA + regB
  $89F7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $89F8  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $89F9  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $89FA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $89FB  D0                          incA                                               ; regA += 1
 >$89FC  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $89FD  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $89FE  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $8A01  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8A02  D7 F2 89                    branch_nz_abs            $89F2                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8A05  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8A06  D6 13 8A                    jump_abs                 $8A13                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8A09  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A0A  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8A0D  BB                          add                                                ; regA = regA + regB
  $8A0E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8A0F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8A10  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8A11  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A12  D0                          incA                                               ; regA += 1
 >$8A13  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8A14  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8A17  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $8A18  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8A19  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A1A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8A1B  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8A1C  D7 09 8A                    branch_nz_abs            $8A09                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$8A1F  8E CD B9                    push_imm_word            $B9CD                     ; "How many players"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8A22  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A26  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $8A27  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8A28  E9 E9 D5 04                 host_call                $D5E9 (number_input) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A2C  A8 61 6D                    loadA_mem_word           $6D61                     ; regA = word read using <word> as address (handler $EA75)
  $8A2F  D8 1F 8A                    branch_z_abs             $8A1F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8A32  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8A33  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8A34  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A35  D2                          aslA                                               ; regA <<= 1
  $8A36  8C 0B 6E                    loadB_imm_word           $6E0B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8A39  BB                          add                                                ; regA = regA + regB
  $8A3A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8A3B  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $8A3C  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A40  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $8A41  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8A42  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A43  D0                          incA                                               ; regA += 1
  $8A44  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8A45  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A46  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8A47  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8A48  D7 34 8A                    branch_nz_abs            $8A34                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8A4B  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8A4E  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8A4F  A8 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word read using <word> as address (handler $EA75)
  $8A52  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8A53  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A57  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $8A58  8E D0 14                    push_imm_word            $14D0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8A5B  8E 8A B7                    push_imm_word            $B78A                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8A5E  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8A5F  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A63  8E 9A 00                    push_imm_word            $009A                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8A66  8E 10 15                    push_imm_word            $1510                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8A69  8E BC 83                    push_imm_word            $83BC                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8A6C  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $8A6D  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A71  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8A72  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8A73  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A74  8C 52 B8                    loadB_imm_word           $B852                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8A77  BB                          add                                                ; regA = regA + regB
  $8A78  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8A79  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8A7A  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8A7B  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A7F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A80  D0                          incA                                               ; regA += 1
  $8A81  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8A82  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8A83  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $8A84  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8A85  D7 73 8A                    branch_nz_abs            $8A73                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8A88  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8A89  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A8D  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8A8E  D6 BC 8A                    jump_abs                 $8ABC                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8A91  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8A94  8D 21                       op_8D_sbyte              +33
  $8A96  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $8A97  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8A9B  8D 30                       op_8D_sbyte              +48
  $8A9D  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $8A9E  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8AA2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8AA3  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $8AA4  DA                          bitand                                             ; regA = regA & regB
  $8AA5  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $8AA6  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8AA7  D8 AE 8A                    branch_z_abs             $8AAE                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8AAA  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8AAB  D6 AF 8A                    jump_abs                 $8AAF                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8AAE  44                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$8AAF  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $8AB2  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8AB3  E9 94 86 02                 host_call                $8694 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8AB7  AC 63 87                    host_call_simple         $8763 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8ABA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8ABB  D0                          incA                                               ; regA += 1
 >$8ABC  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8ABD  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8ABE  A6 61 6D                    loadB_mem_word           $6D61                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $8AC1  C7                          cmp_ule                                            ; regA = (regA <= regB) ? 1 : 0  (unsigned)
  $8AC2  D7 91 8A                    branch_nz_abs            $8A91                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8AC5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8AC6  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
 >$8AC9  8E DE B9                    push_imm_word            $B9DE                     ; "Please select\nskill level"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8ACC  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8AD0  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $8AD1  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8AD2  E9 E9 D5 04                 host_call                $D5E9 (number_input) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8AD6  A8 63 6D                    loadA_mem_word           $6D63 (const_two)         ; regA = word read using <word> as address (handler $EA75)
  $8AD9  D8 C9 8A                    branch_z_abs             $8AC9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8ADC  8E F8 B9                    push_imm_word            $B9F8                     ; "Is everything OK\nso far"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8ADF  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8AE3  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8AE6  D7 44 8B                    branch_nz_abs            $8B44                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8AE9  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8AEC  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8AED  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8AF1  8E B1 00                    push_imm_word            $00B1                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8AF4  8E D0 14                    push_imm_word            $14D0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8AF7  8E 64 82                    push_imm_word            $8264                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8AFA  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8AFB  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8AFF  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $8B00  8E 04 80                    push_imm_word            $8004                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8B03  8D 15                       op_8D_sbyte              +21
  $8B05  8D 1F                       op_8D_sbyte              +31
  $8B07  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $8B08  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8B09  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B0D  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8B0E  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $8B0F  8D 11                       op_8D_sbyte              +17
  $8B11  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $8B12  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8B13  E9 6A CF 0A                 host_call                $CF6A {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B17  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8B18  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$8B19  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8B1A  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $8B1B  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8B1C  D8 26 8B                    branch_z_abs             $8B26                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8B1F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8B20  8C 5A B8                    loadB_imm_word           $B85A                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8B23  D6 2A 8B                    jump_abs                 $8B2A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8B26  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8B27  8C 62 B8                    loadB_imm_word           $B862                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
 >$8B2A  BB                          add                                                ; regA = regA + regB
  $8B2B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8B2C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8B2D  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8B2E  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B32  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8B33  D0                          incA                                               ; regA += 1
  $8B34  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8B35  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8B36  8B 20                       loadB_imm_byte           +32                       ; regB = byte literal (handler $EABE)
  $8B38  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8B39  D7 19 8B                    branch_nz_abs            $8B19                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8B3C  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8B3D  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B41  D6 C1 89                    jump_abs                 $89C1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8B44  8E 10 BA                    push_imm_word            $BA10                     ; "Then on with the\ngame!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8B47  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B4B  48                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8B4C  A6 61 6D                    loadB_mem_word           $6D61                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $8B4F  BC                          sub                                                ; regA = regA - regB
  $8B50  A8 09 6E                    loadA_mem_word           $6E09                     ; regA = word read using <word> as address (handler $EA75)
  $8B53  AC E2 83                    host_call_simple         $83E2 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8B56  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8B57  A8 C7 7F                    loadA_mem_word           $7FC7                     ; regA = word read using <word> as address (handler $EA75)
  $8B5A  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8B5B  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8B5C  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $8B5D  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B61  8D 21                       op_8D_sbyte              +33
  $8B63  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $8B64  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B68  8D 30                       op_8D_sbyte              +48
  $8B6A  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $8B6B  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8B6F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8B70   (frame_off=-2, body @ $8B75)
; ============================================================
  $8B75  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8B76  8C 79 7B                    loadB_imm_word           $7B79                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8B79  BB                          add                                                ; regA = regA + regB
  $8B7A  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8B7B  56                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 6)
  $8B7C  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8B7D  D8 86 8B                    branch_z_abs             $8B86                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8B80  8A 28 BA                    loadA_imm_word           $BA28                     ; "Pirates "  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8B83  D6 9A 8B                    jump_abs                 $8B9A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8B86  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8B87  8C 79 7B                    loadB_imm_word           $7B79                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8B8A  BB                          add                                                ; regA = regA + regB
  $8B8B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8B8C  57                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 7)
  $8B8D  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8B8E  D8 97 8B                    branch_z_abs             $8B97                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8B91  8A 31 BA                    loadA_imm_word           $BA31                     ; "Christns"  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8B94  D6 9A 8B                    jump_abs                 $8B9A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8B97  8A 3A BA                    loadA_imm_word           $BA3A                     ; "Rioters "  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
 >$8B9A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8B9B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8B9C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8B9D   (frame_off=-2, body @ $8BA2)
; ============================================================
  $8BA2  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $8BA5  8B 20                       loadB_imm_byte           +32                       ; regB = byte literal (handler $EABE)
  $8BA7  DA                          bitand                                             ; regA = regA & regB
  $8BA8  D8 AF 8B                    branch_z_abs             $8BAF                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8BAB  8A 55 BA                    loadA_imm_word           $BA55                     ; "Rebels  "  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8BAE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8BAF  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $8BB2  8B 10                       loadB_imm_byte           +16                       ; regB = byte literal (handler $EABE)
  $8BB4  DA                          bitand                                             ; regA = regA & regB
  $8BB5  D8 BC 8B                    branch_z_abs             $8BBC                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8BB8  8A 6A 79                    loadA_imm_word           $796A                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8BBB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8BBC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8BBD  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $8BBE  04                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 4)
  $8BBF  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $8BC0  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $8BC1  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $8BC2  D2                          aslA                                               ; regA <<= 1
  $8BC3  8B 0D                       loadB_imm_byte           +13                       ; regB = byte literal (handler $EABE)
  $8BC5  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $8BC6  D8 8B 17                    branch_z_abs             $178B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8BC9  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $8BCA  D2                          aslA                                               ; regA <<= 1
  $8BCB  8B 1E                       loadB_imm_byte           +30                       ; regB = byte literal (handler $EABE)
  $8BCD  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $8BCE  D8 8B DE                    branch_z_abs             $DE8B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8BD1  8B 8A                       loadB_imm_byte           -118                      ; regB = byte literal (handler $EABE)
  $8BD3  43                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8BD4  BA                          mod_unsigned                                       ; regA = regA % regB  (unsigned remainder)
  $8BD5  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8BD6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8BD7  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

  ; ---- gap $8BD8-$8BE5 (14 bytes, not on any traced path) ----

; ============================================================
; sub $8BE6   (frame_off=-2, body @ $8BEB)
; ============================================================
  $8BEB  AC A2 E4                    host_call_simple         $E4A2 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8BEE  8A 89 6F                    loadA_imm_word           $6F89                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8BF1  D6 03 8C                    jump_abs                 $8C03                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8BF4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8BF5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8BF6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8BF7  E9 B7 D9 02                 host_call                $D9B7 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8BFB  D8 01 8C                    branch_z_abs             $8C01                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8BFE  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8BFF  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8C00  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8C01  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8C02  D0                          incA                                               ; regA += 1
 >$8C03  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8C04  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8C05  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8C06  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8C09  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $8C0A  D7 F4 8B                    branch_nz_abs            $8BF4                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8C0D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8C0E   (frame_off=+0, body @ $8C13)
; ============================================================
  $8C13  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8C16  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8C19  BB                          add                                                ; regA = regA + regB
  $8C1A  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8C1B  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8C1C  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8C1D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8C1E   (frame_off=+0, body @ $8C23)
; ============================================================
  $8C23  AC A9 D9                    host_call_simple         $D9A9 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8C26  D8 2F 8C                    branch_z_abs             $8C2F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8C29  AC 0E 8C                    host_call_simple         $8C0E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8C2C  D7 33 8C                    branch_nz_abs            $8C33                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$8C2F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8C30  D6 34 8C                    jump_abs                 $8C34                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8C33  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$8C34  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8C35   (frame_off=+0, body @ $8C3A)
; ============================================================
  $8C3A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8C3B  8B 36                       loadB_imm_byte           +54                       ; regB = byte literal (handler $EABE)
  $8C3D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8C3E  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $8C3F  BB                          add                                                ; regA = regA + regB
  $8C40  8C 93 61                    loadB_imm_word           $6193                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8C43  BB                          add                                                ; regA = regA + regB
  $8C44  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8C45   (frame_off=-4, body @ $8C4A)
; ============================================================
  $8C4A  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8C4B  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8C4C  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8C4F  D6 68 8C                    jump_abs                 $8C68                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8C52  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8C53  8C 1A 6F                    loadB_imm_word           $6F1A                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8C56  BB                          add                                                ; regA = regA + regB
  $8C57  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8C58  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $8C5B  AC 1E 8C                    host_call_simple         $8C1E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8C5E  D8 66 8C                    branch_z_abs             $8C66                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8C61  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8C62  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8C63  D6 6D 8C                    jump_abs                 $8C6D                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8C66  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8C67  D1                          decA                                               ; regA -= 1
 >$8C68  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8C69  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8C6A  D7 52 8C                    branch_nz_abs            $8C52                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$8C6D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8C6E  D7 74 8C                    branch_nz_abs            $8C74                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8C71  AC 62 D9                    host_call_simple         $D962 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$8C74  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8C75   (frame_off=-12, body @ $8C7A)
; ============================================================
  $8C7A  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8C7B  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $8C7C  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8C7D  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $8C7E  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8C7F  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $8C80  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8C81  D8 8C 8C                    branch_z_abs             $8C8C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8C84  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $8C88  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $8C89  E2 02                       op_E2_byte               $02                       ; fetch byte, jsr $F62C with Y=0x0C (handler $EF6A)
  $8C8B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8C8C  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8C8D  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8C8E  8A 4F 6F                    loadA_imm_word           $6F4F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $8C91  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8C92  D6 36 8D                    jump_abs                 $8D36                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8C95  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8C96  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8C97  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $8C9A  AC E6 8B                    host_call_simple         $8BE6 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8C9D  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $8CA0  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $8CA4  8D D9                       op_8D_sbyte              -39
  $8CA6  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $8CA7  D8 0A 8D                    branch_z_abs             $8D0A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8CAA  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8CAD  8C 67 6D                    loadB_imm_word           $6D67                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8CB0  BB                          add                                                ; regA = regA + regB
  $8CB1  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8CB2  D7 22 8D                    branch_nz_abs            $8D22                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8CB5  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8CB8  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8CBA  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8CBB  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8CBE  BB                          add                                                ; regA = regA + regB
  $8CBF  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8CC0  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $8CC1  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $8CC2  D8 22 8D                    branch_z_abs             $8D22                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8CC5  8D 1C                       op_8D_sbyte              +28
  $8CC7  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8CCB  8E 5E BA                    push_imm_word            $BA5E                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8CCE  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8CD2  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8CD3  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8CD4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8CD5  E9 8B D7 02                 host_call                $D78B {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8CD9  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8CDC  D0                          incA                                               ; regA += 1
  $8CDD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8CDE  8E 5F BA                    push_imm_word            $BA5F                     ; "\nWould you like to\nbid for fief %2d"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8CE1  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8CE5  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8CE8  D8 22 8D                    branch_z_abs             $8D22                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8CEB  8E 83 BA                    push_imm_word            $BA83                     ; "How much"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8CEE  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8CF2  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8CF5  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8CF7  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8CF8  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8CFB  BB                          add                                                ; regA = regA + regB
  $8CFC  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8CFD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8CFE  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $8CFF  E9 E9 D5 04                 host_call                $D5E9 (number_input) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8D03  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $8D04  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8D07  D6 22 8D                    jump_abs                 $8D22                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8D0A  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8D0D  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8D0F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8D10  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8D13  BB                          add                                                ; regA = regA + regB
  $8D14  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8D15  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $8D16  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $8D17  18                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 8)
  $8D18  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $8D19  D8 22 8D                    branch_z_abs             $8D22                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8D1C  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $8D1D  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8D21  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
 >$8D22  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $8D23  18                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 8)
  $8D24  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $8D25  D8 2E 8D                    branch_z_abs             $8D2E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8D28  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $8D29  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $8D2A  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8D2D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$8D2E  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8D2F  D0                          incA                                               ; regA += 1
  $8D30  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8D31  D1                          decA                                               ; regA -= 1
  $8D32  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8D33  D0                          incA                                               ; regA += 1
  $8D34  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8D35  D1                          decA                                               ; regA -= 1
 >$8D36  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8D37  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8D38  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8D3B  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $8D3C  D7 95 8C                    branch_nz_abs            $8C95                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8D3F  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $8D40  D7 4D 8D                    branch_nz_abs            $8D4D (effect_bribe)      ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8D43  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $8D47  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $8D48  E2 02                       op_E2_byte               $02                       ; fetch byte, jsr $F62C with Y=0x0C (handler $EF6A)
  $8D4A  D6 E0 8D                    jump_abs                 $8DE0                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8D4D  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8D50  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8D53  BB                          add                                                ; regA = regA + regB
  $8D54  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8D55  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $8D56  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8D5A  D8 61 8D                    branch_z_abs             $8D61                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8D5D  45                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8D5E  D6 62 8D                    jump_abs                 $8D62                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8D61  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$8D62  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8D63  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8D66  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8D69  BB                          add                                                ; regA = regA + regB
  $8D6A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8D6B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8D6C  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8D6D  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8D70  8C 15 6E                    loadB_imm_word           $6E15 (fief_to_daimyo_map) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8D73  BB                          add                                                ; regA = regA + regB
  $8D74  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8D75  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $8D76  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8D7A  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8D7B  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $8D7C  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8D7D  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8D7F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8D80  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8D83  BB                          add                                                ; regA = regA + regB
  $8D84  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8D85  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8D86  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8D87  BC                          sub                                                ; regA = regA - regB
  $8D88  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8D89  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $8D8A  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8D8E  D8 AC 8D                    branch_z_abs             $8DAC                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8D91  8E 8C BA                    push_imm_word            $BA8C                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8D94  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8D98  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $8D99  E9 8B D7 02                 host_call                $D78B {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8D9D  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8DA0  D0                          incA                                               ; regA += 1
  $8DA1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8DA2  8E 8D BA                    push_imm_word            $BA8D                     ; "\nFief %2d is yours!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8DA5  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8DA9  D6 D6 8D                    jump_abs                 $8DD6                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8DAC  8E A1 BA                    push_imm_word            $BAA1                     ; "Fief "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8DAF  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8DB3  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8DB6  D0                          incA                                               ; regA += 1
  $8DB7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8DB8  8E A7 BA                    push_imm_word            $BAA7                     ; "%2d is now\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8DBB  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8DBF  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $8DC0  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8DC4  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $8DC5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8DC6  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8DC9  BB                          add                                                ; regA = regA + regB
  $8DCA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8DCB  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8DCF  8E B3 BA                    push_imm_word            $BAB3                     ; "`s\nterritory"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8DD2  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$8DD6  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  ; ---- overlap: $8DD7 re-entered mid-stream ----
 >$8DD7  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $8DD8  6F                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 15)
  $8DD9  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  ; ---- overlap: $8DDA re-entered mid-stream ----
  $8DDA  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $8DDB  E5 02                       branch_z_rel             +2                        ; if regA == 0: ptr3 += signed byte (handler $EBF3)
  $8DDD  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  ; ---- overlap: $8DDF re-entered mid-stream ----
 >$8DDF  D7 CF 20                    branch_nz_abs            $20CF                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  ; ---- overlap: $8DE0 re-entered mid-stream ----
 >$8DE0  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
  ; ---- gap $8DE1-$8DE1 (1 bytes, not on any traced path) ----
  $8DE2  23                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 3)
  $8DE3  E8 F2                       branch_z_rel_fwd         -14                       ; if regA == 0: ptr3 += signed byte (variant; handler $EC15). Both handler paths call the sbyte fetch, so the operand is always consumed — classifier mis-counted this as 0-operand.
  $8DE5  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)

; ============================================================
; sub $8DE1   (frame_off=-14, body @ $8DE6)
; ============================================================
  $8DE6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8DE7  D0                          incA                                               ; regA += 1
  $8DE8  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $8DE9  D1                          decA                                               ; regA -= 1
  $8DEA  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8DEB  A2 F2                       op_A0_A3_byte            $F2                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $8DED  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $8DEE  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8DEF  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8DF0  D6 33 8E                    jump_abs                 $8E33                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8DF3  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8DF4  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8DF5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8DF6  D6 17 8E                    jump_abs                 $8E17                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8DF9  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8DFA  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8DFB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8DFC  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8E00  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E01  DE F2                       loadA_frameaddr          $F2                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $8E03  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $8E04  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E05  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E06  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8E07  BB                          add                                                ; regA = regA + regB
  $8E08  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8E09  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E0A  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8E0E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8E0F  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8E10  D8 15 8E                    branch_z_abs             $8E15                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8E13  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8E14  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
 >$8E15  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E16  D0                          incA                                               ; regA += 1
 >$8E17  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8E18  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E19  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
  $8E1A  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8E1B  D7 F9 8D                    branch_nz_abs            $8DF9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8E1E  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $8E1F  D7 30 8E                    branch_nz_abs            $8E30                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8E22  DE F2                       loadA_frameaddr          $F2                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $8E24  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $8E25  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E26  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8E27  D0                          incA                                               ; regA += 1
  $8E28  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8E29  D1                          decA                                               ; regA -= 1
  $8E2A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8E2B  BB                          add                                                ; regA = regA + regB
  $8E2C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E2D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8E2E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8E2F  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$8E30  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8E31  D0                          incA                                               ; regA += 1
  $8E32  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
 >$8E33  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8E34  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8E35  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8E38  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $8E39  D7 F3 8D                    branch_nz_abs            $8DF3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8E3C  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8E3D  D6 51 8E                    jump_abs                 $8E51                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8E40  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E41  8C 4F 6F                    loadB_imm_word           $6F4F                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8E44  BB                          add                                                ; regA = regA + regB
  $8E45  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E46  DE F2                       loadA_frameaddr          $F2                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $8E48  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $8E49  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E4A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E4B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8E4C  BB                          add                                                ; regA = regA + regB
  $8E4D  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8E4E  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8E4F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E50  D0                          incA                                               ; regA += 1
 >$8E51  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8E52  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E53  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
  $8E54  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8E55  D7 40 8E                    branch_nz_abs            $8E40                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8E58  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E59  8C 4F 6F                    loadB_imm_word           $6F4F                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8E5C  BB                          add                                                ; regA = regA + regB
  $8E5D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E5E  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $8E60  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8E61  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $8E62  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8E63   (frame_off=-2, body @ $8E68)
; ============================================================
  $8E68  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8E69  D6 8F 8E                    jump_abs                 $8E8F                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8E6C  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8E6D  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8E71  D8 8D 8E                    branch_z_abs             $8E8D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8E74  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E75  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $8E78  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $8E7B  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $8E7E  AC D7 DA                    host_call_simple         $DAD7 (combat_helper_dad7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8E81  8E 4F 6F                    push_imm_word            $6F4F                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8E84  E9 E1 8D 02                 host_call                $8DE1 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8E88  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8E89  E9 75 8C 02                 host_call                $8C75 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$8E8D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E8E  D0                          incA                                               ; regA += 1
 >$8E8F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8E90  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8E91  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $8E94  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $8E95  D7 6C 8E                    branch_nz_abs            $8E6C                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $8E98  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8E99   (frame_off=+0, body @ $8E9E)
; ============================================================
  $8E9E  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8E9F  D2                          aslA                                               ; regA <<= 1
  $8EA0  8C 67 6F                    loadB_imm_word           $6F67                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8EA3  BB                          add                                                ; regA = regA + regB
  $8EA4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8EA5  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8EA6  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8EA7  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8EA8  D2                          aslA                                               ; regA <<= 1
  $8EA9  8C 68 6F                    loadB_imm_word           $6F68                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8EAC  BB                          add                                                ; regA = regA + regB
  $8EAD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8EAE  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8EAF  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8EB0  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8EB1  D0                          incA                                               ; regA += 1
  $8EB2  D2                          aslA                                               ; regA <<= 1
  $8EB3  8C 67 6F                    loadB_imm_word           $6F67                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8EB6  BB                          add                                                ; regA = regA + regB
  $8EB7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8EB8  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $8EBA  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $8EBB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8EBC   (frame_off=+0, body @ $8EC1)
; ============================================================
  $8EC1  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8EC2  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $8EC3  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8EC4  D8 CF 8E                    branch_z_abs             $8ECF                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8EC7  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $8EC8  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8ECC  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $8ECD  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $8ECE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8ECF  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8ED0  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $8ED1  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $8ED2  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8ED3   (frame_off=-6, body @ $8ED8)
; ============================================================
  $8ED8  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8ED9  E9 78 DE 02                 host_call                $DE78 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8EDD  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8EDE  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8EDF  E9 9D 8B 02                 host_call                $8B9D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8EE3  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8EE4  8E C0 BA                    push_imm_word            $BAC0                     ; "In fief "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8EE7  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8EEB  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $8EEC  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8EED  D0                          incA                                               ; regA += 1
  $8EEE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8EEF  8E C9 BA                    push_imm_word            $BAC9                     ; "%d,\n\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8EF2  E9 34 D1 06                 host_call                $D134 (ui_helper_d134) {bytecode}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8EF6  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8EF7  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $8EF8  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8EF9  8E CF BA                    push_imm_word            $BACF                     ; "Loyals\n          %4d men\n%s\n          %4d men"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8EFC  E9 34 D1 08                 host_call                $D134 (ui_helper_d134) {bytecode}, $08 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F00  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8F03  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F04  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F05  E9 BC 8E 04                 host_call                $8EBC {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F09  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8F0A   (frame_off=-14, body @ $8F0F)
; ============================================================
  $8F0F  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F10  E9 78 DE 02                 host_call                $DE78 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F14  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $8F15  8D 1E                       op_8D_sbyte              +30
  $8F17  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F1B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8F1C  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $8F1E  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $8F1F  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8F22  BB                          add                                                ; regA = regA + regB
  $8F23  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $8F24  8D 14                       op_8D_sbyte              +20
  $8F26  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F2A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8F2B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8F2C  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $8F2D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8F2E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8F2F  E9 CD CB 02                 host_call                $CBCD (sqrt_int) {native}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F33  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8F34  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8F35  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $8F36  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8F37  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8F38  E9 CD CB 02                 host_call                $CBCD (sqrt_int) {native}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F3C  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8F3D  BB                          add                                                ; regA = regA + regB
  $8F3E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8F3F  BB                          add                                                ; regA = regA + regB
  $8F40  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $8F41  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $8F42  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8F43  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $8F45  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8F46  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $8F47  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F48  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $8F49  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $8F4A  E9 D3 8E 06                 host_call                $8ED3 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F4E  D8 96 8F                    branch_z_abs             $8F96                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8F51  8E FD BA                    push_imm_word            $BAFD                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8F54  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F58  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $8F59  8E FE BA                    push_imm_word            $BAFE                     ; "%s have won!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8F5C  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F60  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $8F63  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8F64  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $8F67  BB                          add                                                ; regA = regA + regB
  $8F68  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $8F69  D8 8E 8F                    branch_z_abs             $8F8E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8F6C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F6D  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F71  25                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 5)
  $8F72  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F73  E9 75 E2 02                 host_call                $E275 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F77  35                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 5)
  $8F78  E9 0E DC 02                 host_call                $DC0E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F7C  35                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 5)
  $8F7D  E9 3C DC 02                 host_call                $DC3C {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F81  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F82  E9 25 E4 02                 host_call                $E425 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F86  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F87  E9 1B E2 02                 host_call                $E21B {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F8B  D6 D2 8F                    jump_abs                 $8FD2                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8F8E  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8F8F  E9 54 E4 02                 host_call                $E454 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F93  D6 D2 8F                    jump_abs                 $8FD2                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$8F96  8E 0B BB                    push_imm_word            $BB0B                     ; "The loyal forces\nhave won!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $8F99  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8F9D  8D 32                       op_8D_sbyte              +50
  $8F9F  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8FA3  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $8FA4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FA5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8FA6  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $8FA8  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8FA9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FAA  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8FAE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FAF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8FB0  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $8FB2  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8FB3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FB4  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8FB5  BC                          sub                                                ; regA = regA - regB
  $8FB6  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8FB7  8D 32                       op_8D_sbyte              +50
  $8FB9  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8FBD  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $8FBE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FBF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8FC0  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $8FC1  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8FC2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FC3  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8FC7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FC8  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $8FC9  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $8FCA  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $8FCB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $8FCC  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $8FCD  BC                          sub                                                ; regA = regA - regB
  $8FCE  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $8FCF  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$8FD2  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8FD3   (frame_off=+0, body @ $8FD8)
; ============================================================
  $8FD8  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $8FD9  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8FDA  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $8FDB  E9 99 8E 06                 host_call                $8E99 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $8FDF  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8FE0   (frame_off=+0, body @ $8FE5)
; ============================================================
  $8FE5  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8FE6  8B 19                       loadB_imm_byte           +25                       ; regB = byte literal (handler $EABE)
  $8FE8  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $8FE9  D8 F6 8F                    branch_z_abs             $8FF6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8FEC  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $8FED  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $8FEE  BC                          sub                                                ; regA = regA - regB
  $8FEF  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $8FF0  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $8FF1  D8 F6 8F                    branch_z_abs             $8FF6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $8FF4  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $8FF5  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$8FF6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $8FF7  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $8FF8   (frame_off=-14, body @ $8FFD)
; ============================================================
  $8FFD  8A AD 7B                    loadA_imm_word           $7BAD                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9000  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9001  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9002  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9003  D6 B6 90                    jump_abs                 $90B6                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9006  AC 1E 8C                    host_call_simple         $8C1E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9009  D8 97 90                    branch_z_abs             $9097                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $900C  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $900F  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9011  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9012  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9015  BB                          add                                                ; regA = regA + regB
  $9016  25                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 5)
  $9017  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $9018  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $9019  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $901A  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $901B  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $901C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $901D  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $901E  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $901F  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9020  D8 8A 90                    branch_z_abs             $908A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9023  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9026  8C 67 6D                    loadB_imm_word           $6D67                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9029  BB                          add                                                ; regA = regA + regB
  $902A  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $902B  D7 8A 90                    branch_nz_abs            $908A                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $902E  8E 26 BB                    push_imm_word            $BB26                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9031  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9035  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $9039  8B D7                       loadB_imm_byte           -41                       ; regB = byte literal (handler $EABE)
  $903B  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $903C  8E 27 BB                    push_imm_word            $BB27                     ; "\nthe people are\nrebelling! Will\nyou appease them"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $903F  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9043  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9046  D8 8A 90                    branch_z_abs             $908A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9049  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $904A  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $904B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $904C  35                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 5)
  $904D  E9 40 D9 04                 host_call                $D940 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9051  35                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 5)
  $9052  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9053  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9054  8E 62 BB                    push_imm_word            $BB62                     ; "Giving all of it\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9057  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $905B  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $905C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $905D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $905E  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $905F  E9 E0 8F 04                 host_call                $8FE0 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9063  D7 7D 90                    branch_nz_abs            $907D                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9066  8E 74 BB                    push_imm_word            $BB74                     ; "It didn`t work!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9069  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $906D  AC 59 D7                    host_call_simple         $D759 (ui_helper_d759) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9070  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9071  D0                          incA                                               ; regA += 1
  $9072  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9073  D1                          decA                                               ; regA -= 1
  $9074  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9075  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $9079  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $907A  8F 04                       addA_imm_sbyte           +4                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $907C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$907D  8E 84 BB                    push_imm_word            $BB84                     ; "They appear to\nhave settled down"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9080  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9084  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9087  D6 B6 90                    jump_abs                 $90B6                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$908A  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $908B  D0                          incA                                               ; regA += 1
  $908C  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $908D  D1                          decA                                               ; regA -= 1
  $908E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $908F  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $9093  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9094  8F 04                       addA_imm_sbyte           +4                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $9096  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9097  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $909B  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $909C  8F 02                       addA_imm_sbyte           +2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $909E  8D 1E                       op_8D_sbyte              +30
  $90A0  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $90A4  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $90A6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $90A7  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $90AA  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $90AC  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $90AD  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $90B0  BB                          add                                                ; regA = regA + regB
  $90B1  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $90B2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $90B3  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $90B4  BB                          add                                                ; regA = regA + regB
  $90B5  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$90B6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $90B7  D0                          incA                                               ; regA += 1
  $90B8  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $90B9  D1                          decA                                               ; regA -= 1
  $90BA  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $90BB  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $90BE  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $90C1  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $90C2  D7 06 90                    branch_nz_abs            $9006                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $90C5  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $90C6   (frame_off=+0, body @ $90CB)
; ============================================================
  $90CB  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $90CC  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $90CD  8B 64                       loadB_imm_byte           +100                      ; regB = byte literal (handler $EABE)
  $90CF  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $90D0  D8 D6 90                    branch_z_abs             $90D6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $90D3  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $90D4  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $90D5  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$90D6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $90D7   (frame_off=+0, body @ $90DC)
; ============================================================
  $90DC  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $90DD  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $90DE  E9 12 CA 04                 host_call                $CA12 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $90E2  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $90E3  E9 C6 90 02                 host_call                $90C6 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $90E7  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $90E8   (frame_off=-4, body @ $90ED)
; ============================================================
  $90ED  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $90EE  D6 14 91                    jump_abs                 $9114                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$90F1  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $90F2  D6 09 91                    jump_abs                 $9109                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$90F5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $90F6  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
  $90F7  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $90F8  D8 07 91                    branch_z_abs             $9107                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $90FB  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $90FC  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $90FD  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $90FE  E9 35 8C 04                 host_call                $8C35 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9102  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9103  E9 D7 90 04                 host_call                $90D7 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$9107  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9108  D0                          incA                                               ; regA += 1
 >$9109  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $910A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $910B  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $910E  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $910F  D7 F5 90                    branch_nz_abs            $90F5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9112  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9113  D0                          incA                                               ; regA += 1
 >$9114  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9115  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9116  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9119  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $911A  D7 F1 90                    branch_nz_abs            $90F1                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $911D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $911E   (frame_off=-4, body @ $9123)
; ============================================================
  $9123  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9124  D6 4A 91                    jump_abs                 $914A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9127  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9128  D6 3F 91                    jump_abs                 $913F                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$912B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $912C  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
  $912D  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $912E  D8 3D 91                    branch_z_abs             $913D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9131  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9132  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9133  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $9134  E9 35 8C 04                 host_call                $8C35 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9138  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9139  E9 D7 90 04                 host_call                $90D7 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$913D  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $913E  D0                          incA                                               ; regA += 1
 >$913F  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9140  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9141  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9144  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9145  D7 2B 91                    branch_nz_abs            $912B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9148  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9149  D0                          incA                                               ; regA += 1
 >$914A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $914B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $914C  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $914F  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9150  D7 27 91                    branch_nz_abs            $9127                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9153  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9154   (frame_off=-2, body @ $9159)
; ============================================================
  $9159  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $915A  E9 CD D7 02                 host_call                $D7CD {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $915E  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $915F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9160  D0                          incA                                               ; regA += 1
  $9161  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9162  D7 67 91                    branch_nz_abs            $9167                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9165  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9166  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9167  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9168  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9169  8B 46                       loadB_imm_byte           +70                       ; regB = byte literal (handler $EABE)
  $916B  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $916C  D8 71 91                    branch_z_abs             $9171                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $916F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9170  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9171  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9172  D0                          incA                                               ; regA += 1
  $9173  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9174  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $9175  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $9176  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9177  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9178  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9179  8F F6                       addA_imm_sbyte           -10                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $917B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $917C  BC                          sub                                                ; regA = regA - regB
  $917D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $917E  8E 2C 01                    push_imm_word            $012C                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9181  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9185  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9186  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $9187  D8 92 91                    branch_z_abs             $9192                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $918A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $918B  8C D4 6D                    loadB_imm_word           $6DD4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $918E  BB                          add                                                ; regA = regA + regB
  $918F  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9190  D0                          incA                                               ; regA += 1
  $9191  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9192  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9193  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9194   (frame_off=-4, body @ $9199)
; ============================================================
  $9199  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $919A  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $919D  BB                          add                                                ; regA = regA + regB
  $919E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $919F  D8 FC 91                    branch_z_abs             $91FC                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $91A2  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $91A3  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91A7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $91A8  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $91A9  E9 54 91 02                 host_call                $9154 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91AD  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $91AE  D8 FC 91                    branch_z_abs             $91FC                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $91B1  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $91B2  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $91B3  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $91B4  D8 BE 91                    branch_z_abs             $91BE                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $91B7  A4 5F 6D                    loadA_mem_word           $6D5F (config_block)      ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $91BA  D8 BE 91                    branch_z_abs             $91BE                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $91BD  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$91BE  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $91BF  E9 0E DC 02                 host_call                $DC0E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91C3  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $91C4  E9 3C DC 02                 host_call                $DC3C {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91C8  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $91C9  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91CD  D8 D3 91                    branch_z_abs             $91D3                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $91D0  AC 35 DB                    host_call_simple         $DB35 (ui_helper_db35) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$91D3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $91D4  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $91D5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $91D6  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $91D9  BB                          add                                                ; regA = regA + regB
  $91DA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $91DB  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91DF  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $91E0  D1                          decA                                               ; regA -= 1
  $91E1  D2                          aslA                                               ; regA <<= 1
  $91E2  8C A5 BB                    loadB_imm_word           $BBA5                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $91E5  BB                          add                                                ; regA = regA + regB
  $91E6  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $91E7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $91E8  8E BA BB                    push_imm_word            $BBBA                     ; " died of\n%s"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $91EB  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91EF  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $91F0  E9 E7 E1 02                 host_call                $E1E7 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $91F4  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $91F7  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $91F8  E9 25 E4 02                 host_call                $E425 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$91FC  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $91FD   (frame_off=+0, body @ $9202)
; ============================================================
  $9202  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9203  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $9204  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $9205  D8 0A 92                    branch_z_abs             $920A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9208  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9209  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$920A  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $920B  1E                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $920C  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $920D  D8 12 92                    branch_z_abs             $9212                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9210  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9211  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9212  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9213  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9214   (frame_off=+0, body @ $9219)
; ============================================================
  $9219  8D 33                       op_8D_sbyte              +51
  $921B  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $921F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9220  A4 9F 6D                    loadA_mem_word           $6D9F                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9223  90 E8 F9                    op_90_bb                 $E8, $F9
  $9226  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $9227  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $9228  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $9229  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $922A  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $922B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $922C  BB                          add                                                ; regA = regA + regB
  $922D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $922E   (frame_off=+0, body @ $9233)
; ============================================================
  $9233  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9234  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9238  D8 42 92                    branch_z_abs             $9242                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $923B  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $923C  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9240  75                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 5)
  $9241  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9242  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $9243  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9247  8F 1E                       addA_imm_sbyte           +30                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9249  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $924A   (frame_off=-4, body @ $924F)
; ============================================================
  $924F  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $9250  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9254  D0                          incA                                               ; regA += 1
  $9255  A8 0B 6E                    loadA_mem_word           $6E0B                     ; regA = word read using <word> as address (handler $EA75)
  $9258  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $9259  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $925D  D8 76 92                    branch_z_abs             $9276                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9260  8D 1E                       op_8D_sbyte              +30
  $9262  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $9263  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9267  A6 0D 6E                    loadB_mem_word           $6E0D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $926A  BB                          add                                                ; regA = regA + regB
  $926B  8F FB                       addA_imm_sbyte           -5                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $926D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $926E  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $926F  E9 FD 91 06                 host_call                $91FD {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9273  D6 79 92                    jump_abs                 $9279                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9276  AC 2E 92                    host_call_simple         $922E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$9279  A8 0D 6E                    loadA_mem_word           $6E0D                     ; regA = word read using <word> as address (handler $EA75)
  $927C  AC 14 92                    host_call_simple         $9214 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $927F  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $9280  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $9281  A8 0F 6E                    loadA_mem_word           $6E0F                     ; regA = word read using <word> as address (handler $EA75)
  $9284  8D 46                       op_8D_sbyte              +70
  $9286  AC 14 92                    host_call_simple         $9214 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9289  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $928A  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $928E  A8 11 6E                    loadA_mem_word           $6E11                     ; regA = word read using <word> as address (handler $EA75)
  $9291  A4 9F 6D                    loadA_mem_word           $6D9F                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9294  90 E8 F9                    op_90_bb                 $E8, $F9
  $9297  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $9298  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9299  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $929A  8D 65                       op_8D_sbyte              +101
  $929C  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $92A0  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $92A1  BB                          add                                                ; regA = regA + regB
  $92A2  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $92A3  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $92A4  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $92A5  A8 13 6E                    loadA_mem_word           $6E13                     ; regA = word read using <word> as address (handler $EA75)
  $92A8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $92A9   (frame_off=+0, body @ $92AE)
; ============================================================
  $92AE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92AF  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $92B0  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92B1  D7 B6 92                    branch_nz_abs            $92B6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $92B4  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $92B5  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$92B6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92B7  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $92B8  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92B9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $92BA  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92BB  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92BC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $92BD  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $92C1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $92C2  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $92C3  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $92C7  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $92C8  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $92C9  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92CA  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $92CB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $92CC  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92CD  BC                          sub                                                ; regA = regA - regB
  $92CE  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $92CF  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $92D0  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92D1  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $92D2  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $92D3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $92D4  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92D5  BC                          sub                                                ; regA = regA - regB
  $92D6  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $92D7  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $92D8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $92D9   (frame_off=+0, body @ $92DE)
; ============================================================
  $92DE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92DF  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92E0  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $92E1  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $92E2  D7 F5 92                    branch_nz_abs            $92F5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $92E5  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92E6  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92E7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $92E8  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92E9  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $92EA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $92EB  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92EC  BC                          sub                                                ; regA = regA - regB
  $92ED  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $92EE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $92EF  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $92F0  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $92F1  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $92F2  D8 F8 92                    branch_z_abs             $92F8                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$92F5  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $92F6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $92F7  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$92F8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $92F9   (frame_off=+0, body @ $92FE)
; ============================================================
  $92FE  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $92FF  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9303  D7 0D 93                    branch_nz_abs            $930D                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9306  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9307  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9308  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $9309  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $930A  D8 0F 93                    branch_z_abs             $930F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$930D  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $930E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$930F  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9310  8D 1E                       op_8D_sbyte              +30
  $9312  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9316  8F 28                       addA_imm_sbyte           +40                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9318  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9319  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $931A  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $931B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $931C  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9320  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9321  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9322  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9323 (effect_war_combat_prep_a)   (frame_off=+0, body @ $9328)
; ============================================================
  $9328  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $932B  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $932D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $932E  8C 0B 70                    loadB_imm_word           $700B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9331  BB                          add                                                ; regA = regA + regB
  $9332  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9333  E9 F9 92 02                 host_call                $92F9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9337  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9338   (frame_off=+0, body @ $933D)
; ============================================================
  $933D  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9340  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9342  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9343  8C 09 70                    loadB_imm_word           $7009                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9346  BB                          add                                                ; regA = regA + regB
  $9347  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9348  E9 F9 92 02                 host_call                $92F9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $934C  D8 69 93                    branch_z_abs             $9369                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $934F  8D 64                       op_8D_sbyte              +100
  $9351  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9355  8F 64                       addA_imm_sbyte           +100                      ; regA += sign-extended signed byte literal (handler $EAD9)
  $9357  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9358  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $935B  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $935D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $935E  8C 0F 70                    loadB_imm_word           $700F                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9361  BB                          add                                                ; regA = regA + regB
  $9362  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9363  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9364  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9365  BB                          add                                                ; regA = regA + regB
  $9366  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9367  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9368  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9369  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $936A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $936B   (frame_off=+0, body @ $9370)
; ============================================================
  $9370  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9373  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9375  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9376  8C 05 70                    loadB_imm_word           $7005                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9379  BB                          add                                                ; regA = regA + regB
  $937A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $937B  E9 F9 92 02                 host_call                $92F9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $937F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9380   (frame_off=+0, body @ $9385)
; ============================================================
  $9385  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9388  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $938A  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $938B  8C 0F 70                    loadB_imm_word           $700F                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $938E  BB                          add                                                ; regA = regA + regB
  $938F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9390  E9 F9 92 02                 host_call                $92F9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9394  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9395   (frame_off=+0, body @ $939A)
; ============================================================
  $939A  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $939D  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $939F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $93A0  8C 13 70                    loadB_imm_word           $7013                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $93A3  BB                          add                                                ; regA = regA + regB
  $93A4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $93A5  E9 F9 92 02                 host_call                $92F9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $93A9  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $93AA   (frame_off=+0, body @ $93AF)
; ============================================================
  $93AF  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $93B2  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $93B4  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $93B5  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $93B8  BB                          add                                                ; regA = regA + regB
  $93B9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $93BA  E9 F9 92 02                 host_call                $92F9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $93BE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $93BF   (frame_off=-4, body @ $93C4)
; ============================================================
  $93C4  8E C6 BB                    push_imm_word            $BBC6                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $93C7  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $93CB  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $93CF  8B D7                       loadB_imm_byte           -41                       ; regB = byte literal (handler $EABE)
  $93D1  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $93D2  8E C7 BB                    push_imm_word            $BBC7                     ; "\nsomeone has sent\nninja aginst\nfief "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $93D5  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $93D9  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $93DC  D0                          incA                                               ; regA += 1
  $93DD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $93DE  8E EC BB                    push_imm_word            $BBEC                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $93E1  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $93E5  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $93E8  6F                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 15)
  $93E9  E9 0C E8 02                 host_call                $E80C (ui_helper_e80c) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $93ED  AC 23 93                    host_call_simple         $9323 (effect_war_combat_prep_a) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $93F0  D7 4E 94                    branch_nz_abs            $944E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $93F3  AC 6B 93                    host_call_simple         $936B {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $93F6  D7 4E 94                    branch_nz_abs            $944E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $93F9  AC AA 93                    host_call_simple         $93AA {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $93FC  D7 4E 94                    branch_nz_abs            $944E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $93FF  AC 95 93                    host_call_simple         $9395 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9402  D7 4E 94                    branch_nz_abs            $944E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9405  AC 80 93                    host_call_simple         $9380 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9408  D7 4E 94                    branch_nz_abs            $944E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $940B  AC 38 93                    host_call_simple         $9338 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $940E  D7 4E 94                    branch_nz_abs            $944E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9411  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9412  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9416  D8 6B 94                    branch_z_abs             $946B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9419  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $941C  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $941E  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $941F  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9422  BB                          add                                                ; regA = regA + regB
  $9423  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9424  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $9428  DA                          bitand                                             ; regA = regA & regB
  $9429  D7 02 2A                    branch_nz_abs            $2A02                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $942C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $942D  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $942E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $942F  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $9430  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $9431  D8 53 94                    branch_z_abs             $9453                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9434  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $9435  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9439  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $943A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $943B  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $943C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $943D  E9 12 CA 04                 host_call                $CA12 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9441  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $9442  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9446  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9447  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9448  D0                          incA                                               ; regA += 1
  $9449  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $944A  E9 12 CA 04                 host_call                $CA12 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$944E  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9451  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9452  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9453  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9454  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $9455  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9456  8D 1E                       op_8D_sbyte              +30
  $9458  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $945C  8F 3C                       addA_imm_sbyte           +60                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $945E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $945F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9460  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $9461  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9462  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9463  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9467  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9468  D6 4E 94                    jump_abs                 $944E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$946B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $946C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $946D   (frame_off=+0, body @ $9472)
; ============================================================
  $9472  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9473  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9477  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $9478  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9479  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $947A   (frame_off=-6, body @ $947F)
; ============================================================
  $947F  8E FF 00                    push_imm_word            $00FF                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9482  E9 DC E4 02                 host_call                $E4DC (marry_helper_e4dc) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9486  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9487  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9488  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9489  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $948A  8A 89 6F                    loadA_imm_word           $6F89                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $948D  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $948E  D6 A4 94                    jump_abs                 $94A4                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9491  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9492  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9493  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9494  E9 6D 94 02                 host_call                $946D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9498  CD                          swap_AB                                            ; regA <-> regB
  $9499  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $949A  BB                          add                                                ; regA = regA + regB
  $949B  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $949C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $949D  D0                          incA                                               ; regA += 1
  $949E  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $949F  D1                          decA                                               ; regA -= 1
  $94A0  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $94A1  D0                          incA                                               ; regA += 1
  $94A2  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $94A3  D1                          decA                                               ; regA -= 1
 >$94A4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $94A5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $94A6  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $94A9  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $94AA  D7 91 94                    branch_nz_abs            $9491                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $94AD  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $94AE  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $94AF  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $94B0  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $94B1   (frame_off=-4, body @ $94B6)
; ============================================================
  $94B6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $94B7  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $94B8  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $94B9  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $94BA  01                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 1)
  $94BB  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $94BC  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $94BD  94                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $94BE  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $94BF  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $94C0  E9 94 CE 94                 host_call                $CE94 {native}, $94       ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $94C4  8E F1 BB                    push_imm_word            $BBF1                     ; "Summer this year\nbrings typhoons!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
 >$94C7  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $94CB  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $94CE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $94CF  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $94D0  D6 1D 95                    jump_abs                 $951D                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$94D3  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $94D4  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $94D8  D8 1D 95                    branch_z_abs             $951D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $94DB  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $94DC  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $94DD  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $94DE  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $94DF  01                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 1)
  $94E0  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $94E1  EF                          trigger_syscall_EB_FE                              ; BRK to syscall_dispatch (handler $EF92)
  $94E2  94                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $94E3  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $94E4  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $94E5  04                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 4)
  $94E6  95                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $94E7  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $94E8  95                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $94E9  8E 13 BC                    push_imm_word            $BC13                     ; "Lord,\nplague has come!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $94EC  D6 C7 94                    jump_abs                 $94C7                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
  ; ---- gap $94EF-$951C (46 bytes, not on any traced path) ----
 >$951D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $951E  D0                          incA                                               ; regA += 1
  $951F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9520  D1                          decA                                               ; regA -= 1
  $9521  8C AD 7B                    loadB_imm_word           $7BAD                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9524  BB                          add                                                ; regA = regA + regB
  $9525  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9526  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9527  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $952A  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $952B  D7 D3 94                    branch_nz_abs            $94D3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $952E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $952F   (frame_off=-4, body @ $9534)
; ============================================================
  $9534  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9535  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9536  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9537  D6 46 95                    jump_abs                 $9546                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$953A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $953B  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $953E  BB                          add                                                ; regA = regA + regB
  $953F  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9540  CD                          swap_AB                                            ; regA <-> regB
  $9541  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9542  BB                          add                                                ; regA = regA + regB
  $9543  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9544  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9545  D0                          incA                                               ; regA += 1
 >$9546  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9547  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9548  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $954B  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $954C  D7 3A 95                    branch_nz_abs            $953A                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $954F  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9552  CD                          swap_AB                                            ; regA <-> regB
  $9553  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9554  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $9555  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9556  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9557  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9558   (frame_off=-8, body @ $955D)
; ============================================================
  $955D  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $955E  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $955F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9560  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9561  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9562  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9563  D6 85 95                    jump_abs                 $9585                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9566  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9567  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9569  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $956A  8C 0F 70                    loadB_imm_word           $700F                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $956D  BB                          add                                                ; regA = regA + regB
  $956E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $956F  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9570  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9571  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9574  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $9575  CD                          swap_AB                                            ; regA <-> regB
  $9576  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9577  BB                          add                                                ; regA = regA + regB
  $9578  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9579  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $957A  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $957D  BA                          mod_unsigned                                       ; regA = regA % regB  (unsigned remainder)
  $957E  CD                          swap_AB                                            ; regA <-> regB
  $957F  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9580  BB                          add                                                ; regA = regA + regB
  $9581  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9582  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9583  D0                          incA                                               ; regA += 1
  $9584  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
 >$9585  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9586  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9589  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $958A  D7 66 95                    branch_nz_abs            $9566                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $958D  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $958E  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9591  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $9592  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $9593  BB                          add                                                ; regA = regA + regB
  $9594  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9595   (frame_off=-6, body @ $959A)
; ============================================================
  $959A  8E 6A BC                    push_imm_word            $BC6A                     ; "In fief "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $959D  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95A1  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $95A2  D0                          incA                                               ; regA += 1
  $95A3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $95A4  8E 73 BC                    push_imm_word            $BC73                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $95A7  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95AB  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $95AC  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $95AE  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $95AF  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $95B2  BB                          add                                                ; regA = regA + regB
  $95B3  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $95B4  8D 1F                       op_8D_sbyte              +31
  $95B6  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95BA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $95BB  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $95BC  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95C0  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $95C1  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $95C2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $95C3  8E C8 00                    push_imm_word            $00C8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $95C6  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95CA  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $95CB  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $95CC  8B 14                       loadB_imm_byte           +20                       ; regB = byte literal (handler $EABE)
  $95CE  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $95CF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $95D0  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $95D1  8F 12                       addA_imm_sbyte           +18                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $95D3  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $95D4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $95D5  8D 64                       op_8D_sbyte              +100
  $95D7  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95DB  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $95DC  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $95DD  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $95DE  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $95DF  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $95E0  BB                          add                                                ; regA = regA + regB
  $95E1  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $95E2  BB                          add                                                ; regA = regA + regB
  $95E3  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $95E4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $95E5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $95E6  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $95E8  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $95E9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $95EA  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95EE  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $95EF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $95F0  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $95F2  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $95F3  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
  $95F4  BC                          sub                                                ; regA = regA - regB
  $95F5  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $95F6  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $95F7  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $95F8  8E 78 BC                    push_imm_word            $BC78                     ; "\n\nLoyals\n          %4d men\nRebels\n          %4d "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $95FB  E9 34 D1 06                 host_call                $D134 (ui_helper_d134) {bytecode}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $95FF  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9602  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9603  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $9604  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $9605  D8 10 96                    branch_z_abs             $9610                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9608  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9609  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $960D  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $960E  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $960F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9610  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9611  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $9612  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $9613  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9614   (frame_off=+0, body @ $9619)
; ============================================================
  $9619  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $961A  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $961B  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $961C  E9 99 8E 06                 host_call                $8E99 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9620  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9621   (frame_off=-5, body @ $9626)
; ============================================================
  $9626  A4 AB 7B                    loadA_mem_word           $7BAB                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9629  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $962C  89 1E                       loadA_imm_sbyte          +30                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $962E  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $9631  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9632  D6 59 96                    jump_abs                 $9659                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9635  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9636  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $963A  8B 18                       loadB_imm_byte           +24                       ; regB = byte literal (handler $EABE)
  $963C  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $963D  D8 57 96                    branch_z_abs             $9657                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9640  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9641  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9644  BB                          add                                                ; regA = regA + regB
  $9645  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9646  D7 57 96                    branch_nz_abs            $9657                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9649  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $964A  8C 15 6E                    loadB_imm_word           $6E15 (fief_to_daimyo_map) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $964D  BB                          add                                                ; regA = regA + regB
  $964E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $964F  89 32                       loadA_imm_sbyte          +50                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9651  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9652  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9653  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$9657  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9658  D0                          incA                                               ; regA += 1
 >$9659  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $965A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $965B  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $965E  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $965F  D7 35 96                    branch_nz_abs            $9635                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9662  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9665  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9668  BB                          add                                                ; regA = regA + regB
  $9669  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $966A  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $966B  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $966C  A4 4D 6F                    loadA_mem_word           $6F4D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $966F  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9670  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $9673  A2 FB                       op_A0_A3_byte            $FB                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $9675  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $9676  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9677  A8 4D 6F                    loadA_mem_word           $6F4D                     ; regA = word read using <word> as address (handler $EA75)
  $967A  44                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $967B  CD                          swap_AB                                            ; regA <-> regB
  $967C  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $967F  DB                          bitor                                              ; regA = regA | regB
  $9680  A9 A1 6D                    storeA_mem_byte          $6DA1                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $9683  8E AC BC                    push_imm_word            $BCAC                     ; "Beware!\nA treacherous\nsubordinate has\nraised an "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9686  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $968A  8D 62                       op_8D_sbyte              +98
  $968C  E9 3E D7 02                 host_call                $D73E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9690  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9693  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $9694  E9 0C E8 02                 host_call                $E80C (ui_helper_e80c) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9698  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9699  A8 4D 6F                    loadA_mem_word           $6F4D                     ; regA = word read using <word> as address (handler $EA75)
  $969C  A0 FB                       op_A0_A3_byte            $FB                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $969E  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $969F  A9 A1 6D                    storeA_mem_byte          $6DA1                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $96A2  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $96A3  A9 65 6F                    storeA_mem_byte          $6F65                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $96A6  A4 81 6F                    loadA_mem_word           $6F81                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $96A9  A8 7F 6F                    loadA_mem_word           $6F7F                     ; regA = word read using <word> as address (handler $EA75)
  $96AC  A8 7D 6F                    loadA_mem_word           $6F7D                     ; regA = word read using <word> as address (handler $EA75)
  $96AF  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $96B0   (frame_off=-10, body @ $96B5)
; ============================================================
  $96B5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $96B6  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $96B7  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $96BA  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $96BC  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $96BD  D8 76 97                    branch_z_abs             $9776                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $96C0  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $96C1  8B 1E                       loadB_imm_byte           +30                       ; regB = byte literal (handler $EABE)
  $96C3  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $96C4  D8 76 97                    branch_z_abs             $9776                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $96C7  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $96C8  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $96CC  8B 18                       loadB_imm_byte           +24                       ; regB = byte literal (handler $EABE)
  $96CE  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $96CF  D8 76 97                    branch_z_abs             $9776                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $96D2  8D 1E                       op_8D_sbyte              +30
  $96D4  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $96D8  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $96D9  8B 28                       loadB_imm_byte           +40                       ; regB = byte literal (handler $EABE)
  $96DB  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $96DC  D8 76 97                    branch_z_abs             $9776                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $96DF  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $96E2  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $96E3  89 1E                       loadA_imm_sbyte          +30                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $96E5  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $96E8  AC 1E 8C                    host_call_simple         $8C1E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $96EB  D8 6E 97                    branch_z_abs             $976E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $96EE  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $96F1  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $96F2  DA                          bitand                                             ; regA = regA & regB
  $96F3  D7 6E 97                    branch_nz_abs            $976E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $96F6  AC D7 DA                    host_call_simple         $DAD7 (combat_helper_dad7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $96F9  8E 4F 6F                    push_imm_word            $6F4F                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $96FC  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $96FD  E9 3A DD 04                 host_call                $DD3A (combat_helper_dd3a) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9701  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9702  A8 81 6F                    loadA_mem_word           $6F81                     ; regA = word read using <word> as address (handler $EA75)
  $9705  8A 4F 6F                    loadA_imm_word           $6F4F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9708  D6 34 97                    jump_abs                 $9734                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$970B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $970C  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $970D  A8 AB 7B                    loadA_mem_word           $7BAB                     ; regA = word read using <word> as address (handler $EA75)
  $9710  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9711  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9712  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9714  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9715  8C 11 70                    loadB_imm_word           $7011                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9718  BB                          add                                                ; regA = regA + regB
  $9719  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $971A  CD                          swap_AB                                            ; regA <-> regB
  $971B  A4 81 6F                    loadA_mem_word           $6F81                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $971E  BB                          add                                                ; regA = regA + regB
  $971F  A8 81 6F                    loadA_mem_word           $6F81                     ; regA = word read using <word> as address (handler $EA75)
  $9722  A4 81 6F                    loadA_mem_word           $6F81                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9725  8C 0F 27                    loadB_imm_word           $270F                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9728  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $9729  D8 32 97                    branch_z_abs             $9732                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $972C  8A 0F 27                    loadA_imm_word           $270F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $972F  A8 81 6F                    loadA_mem_word           $6F81                     ; regA = word read using <word> as address (handler $EA75)
 >$9732  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9733  D0                          incA                                               ; regA += 1
 >$9734  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9735  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9736  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9737  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $973A  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $973B  D7 0B 97                    branch_nz_abs            $970B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $973E  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9741  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9743  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9744  8C 11 70                    loadB_imm_word           $7011                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9747  BB                          add                                                ; regA = regA + regB
  $9748  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9749  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $974A  A4 81 6F                    loadA_mem_word           $6F81                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $974D  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $974E  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $974F  D8 6E 97                    branch_z_abs             $976E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9752  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $9753  E9 10 E5 02                 host_call                $E510 (ui_helper_e510) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9757  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $9758  C9                          cmp_ult                                            ; regA = (regA < regB) ? 1 : 0   (unsigned)
  $9759  D8 6E 97                    branch_z_abs             $976E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $975C  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $975D  CD                          swap_AB                                            ; regA <-> regB
  $975E  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $9761  DB                          bitor                                              ; regA = regA | regB
  $9762  A9 A1 6D                    storeA_mem_byte          $6DA1                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $9765  AC 21 96                    host_call_simple         $9621 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9768  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9769  A8 48 6E                    loadA_mem_word           $6E48                     ; regA = word read using <word> as address (handler $EA75)
  $976C  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $976D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$976E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $976F  D7 76 97                    branch_nz_abs            $9776                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9772  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9773  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
 >$9776  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9777  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9778   (frame_off=-14, body @ $977D)
; ============================================================
  $977D  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $977E  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $977F  8A AD 7B                    loadA_imm_word           $7BAD                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9782  D6 6E 98                    jump_abs                 $986E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9785  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9786  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9787  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9788  E9 B0 96 02                 host_call                $96B0 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $978C  D7 78 98                    branch_nz_abs            $9878                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $978F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9790  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9791  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $9794  8D 1E                       op_8D_sbyte              +30
  $9796  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $979A  AC 1E 8C                    host_call_simple         $8C1E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $979D  D8 AF 97                    branch_z_abs             $97AF                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $97A0  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $97A1  D0                          incA                                               ; regA += 1
  $97A2  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $97A3  D1                          decA                                               ; regA -= 1
  $97A4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97A5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97A6  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97A7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97A8  E9 14 96 04                 host_call                $9614 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $97AC  D6 6C 98                    jump_abs                 $986C                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$97AF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97B0  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97B1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97B2  E9 95 95 02                 host_call                $9595 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $97B6  D8 19 98                    branch_z_abs             $9819                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $97B9  8E F1 BC                    push_imm_word            $BCF1                     ; "The rebels have\nwon!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $97BC  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $97C0  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $97C3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97C4  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97C5  8C 15 6E                    loadB_imm_word           $6E15 (fief_to_daimyo_map) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $97C8  BB                          add                                                ; regA = regA + regB
  $97C9  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $97CA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97CB  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97CC  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $97CF  BB                          add                                                ; regA = regA + regB
  $97D0  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97D1  D8 FC 97                    branch_z_abs             $97FC                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $97D4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97D5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97D6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97D7  E9 75 E2 02                 host_call                $E275 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $97DB  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $97DC  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97DD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97DE  E9 0E DC 02                 host_call                $DC0E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $97E2  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $97E3  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97E4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97E5  E9 3C DC 02                 host_call                $DC3C {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $97E9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97EA  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97EB  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $97EE  BB                          add                                                ; regA = regA + regB
  $97EF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97F0  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $97F1  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $97F2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97F3  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97F4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $97F5  E9 25 E4 02                 host_call                $E425 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $97F9  D6 06 98                    jump_abs                 $9806                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$97FC  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $97FD  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $97FE  8C 7F 6E                    loadB_imm_word           $6E7F                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9801  BB                          add                                                ; regA = regA + regB
  $9802  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9803  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9804  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9805  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$9806  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9807  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9808  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9809  E9 1B E2 02                 host_call                $E21B {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $980D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $980E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $980F  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9812  BB                          add                                                ; regA = regA + regB
  $9813  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9814  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9815  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9816  D6 69 98                    jump_abs                 $9869                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9819  8E 06 BD                    push_imm_word            $BD06                     ; "The loyal men\nhave won!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $981C  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9820  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9821  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9822  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9824  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9825  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9828  BB                          add                                                ; regA = regA + regB
  $9829  25                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 5)
  $982A  8D 1E                       op_8D_sbyte              +30
  $982C  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9830  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9831  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $9832  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9836  8F 1E                       addA_imm_sbyte           +30                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9838  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9839  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $983A  8F 12                       addA_imm_sbyte           +18                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $983C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $983D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $983E  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9842  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9843  BB                          add                                                ; regA = regA + regB
  $9844  8F 1E                       addA_imm_sbyte           +30                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9846  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9847  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $9848  8F 12                       addA_imm_sbyte           +18                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $984A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $984B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $984C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $984D  BB                          add                                                ; regA = regA + regB
  $984E  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $984F  8D 14                       op_8D_sbyte              +20
  $9851  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9855  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $9856  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9857  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $9858  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $985A  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $985B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $985C  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9860  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9861  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $9862  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9864  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9865  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9866  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9867  BC                          sub                                                ; regA = regA - regB
  $9868  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$9869  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$986C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $986D  D0                          incA                                               ; regA += 1
 >$986E  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $986F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9870  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9871  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9874  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9875  D7 85 97                    branch_nz_abs            $9785                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9878  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9879   (frame_off=-2, body @ $987E)
; ============================================================
  $987E  8A 89 6F                    loadA_imm_word           $6F89                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9881  D6 98 98                    jump_abs                 $9898                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9884  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $9886  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9887  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9888  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9889  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $988A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $988B  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $988C  D8 96 98                    branch_z_abs             $9896                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $988F  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9890  89 C8                       loadA_imm_sbyte          -56                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9892  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9893  D6 A2 98                    jump_abs                 $98A2                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9896  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9897  D0                          incA                                               ; regA += 1
 >$9898  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9899  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $989A  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $989B  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $989E  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $989F  D7 84 98                    branch_nz_abs            $9884                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$98A2  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $98A3   (frame_off=-2, body @ $98A8)
; ============================================================
  $98A8  0F                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $98A9  8C 15 6E                    loadB_imm_word           $6E15 (fief_to_daimyo_map) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $98AC  BB                          add                                                ; regA = regA + regB
  $98AD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $98AE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $98AF  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $98B0  0F                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $98B1  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $98B4  BB                          add                                                ; regA = regA + regB
  $98B5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $98B6  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $98B7  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $98B8  0F                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $98B9  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $98BC  BB                          add                                                ; regA = regA + regB
  $98BD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $98BE  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $98BF  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $98C0  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $98C1  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $98C5  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $98C6   (frame_off=-58, body @ $98CB)
; ============================================================
  $98CB  AC D7 DA                    host_call_simple         $DAD7 (combat_helper_dad7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $98CE  8E 4F 6F                    push_imm_word            $6F4F                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $98D1  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $98D2  E9 3A DD 04                 host_call                $DD3A (combat_helper_dd3a) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $98D6  DE CA                       loadA_frameaddr          $CA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $98D8  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $98D9  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $98DA  8A 4F 6F                    loadA_imm_word           $6F4F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $98DD  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $98DE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $98DF  85 C8                       op_85_byte               $C8
  $98E1  D6 06 99                    jump_abs                 $9906                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$98E4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $98E5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $98E6  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $98E9  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $98EA  D7 0D 99                    branch_nz_abs            $990D                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $98ED  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $98EE  D0                          incA                                               ; regA += 1
  $98EF  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $98F0  D1                          decA                                               ; regA -= 1
  $98F1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $98F2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $98F3  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $98F4  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $98F5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $98F6  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $98F7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $98F8  E9 79 98 02                 host_call                $9879 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $98FC  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $98FD  D0                          incA                                               ; regA += 1
  $98FE  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $98FF  D1                          decA                                               ; regA -= 1
  $9900  81 C8                       op_81_byte               $C8
  $9902  D0                          incA                                               ; regA += 1
  $9903  85 C8                       op_85_byte               $C8
  $9905  D1                          decA                                               ; regA -= 1
 >$9906  81 C8                       op_81_byte               $C8
  $9908  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $9909  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $990A  D7 E4 98                    branch_nz_abs            $98E4                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$990D  81 C8                       op_81_byte               $C8
  $990F  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $9910  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9911  D8 4B 99                    branch_z_abs             $994B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9914  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9915  83 C8                       op_83_byte               $C8
  $9917  BC                          sub                                                ; regA = regA - regB
  $9918  D6 2A 99                    jump_abs                 $992A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$991B  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $991C  D0                          incA                                               ; regA += 1
  $991D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $991E  D1                          decA                                               ; regA -= 1
  $991F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9920  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9921  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9922  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9923  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9924  89 C8                       loadA_imm_sbyte          -56                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9926  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9927  81 C6                       op_81_byte               $C6
  $9929  D1                          decA                                               ; regA -= 1
 >$992A  85 C6                       op_85_byte               $C6
  $992C  D6 44 99                    jump_abs                 $9944                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$992F  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9930  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9931  8C C8 00                    loadB_imm_word           $00C8                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9934  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9935  D7 1B 99                    branch_nz_abs            $991B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9938  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9939  D0                          incA                                               ; regA += 1
  $993A  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
 >$993B  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $993C  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $993D  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9940  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9941  D7 2F 99                    branch_nz_abs            $992F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9944  81 C6                       op_81_byte               $C6
  $9946  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $9947  C8                          cmp_ugt                                            ; regA = (regA > regB) ? 1 : 0   (unsigned)
  $9948  D7 3B 99                    branch_nz_abs            $993B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$994B  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $994C  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $994E  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $994F  DE CA                       loadA_frameaddr          $CA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $9951  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $9952  D6 69 99                    jump_abs                 $9969                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9955  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9956  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9957  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9958  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9959  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $995A  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $995D  BB                          add                                                ; regA = regA + regB
  $995E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $995F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9960  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $9961  8D 33                       op_8D_sbyte              +51
  $9963  E9 A3 98 08                 host_call                $98A3 {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9967  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9968  D0                          incA                                               ; regA += 1
 >$9969  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $996A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $996B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $996C  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $996F  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9970  D7 55 99                    branch_nz_abs            $9955                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9973  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9974   (frame_off=-2, body @ $9979)
; ============================================================
  $9979  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $997A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $997B  D6 A6 99                    jump_abs                 $99A6                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$997E  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $997F  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9980  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9983  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $9984  D7 AA 99                    branch_nz_abs            $99AA                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9987  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9988  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9989  8C C8 00                    loadB_imm_word           $00C8                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $998C  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $998D  D8 A3 99                    branch_z_abs             $99A3                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9990  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9991  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9992  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9993  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $9994  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9995  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9996  E9 A3 98 08                 host_call                $98A3 {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $999A  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $999B  89 C8                       loadA_imm_sbyte          -56                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $999D  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $999E  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $999F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $99A0  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $99A1  D1                          decA                                               ; regA -= 1
  $99A2  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
 >$99A3  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $99A4  D0                          incA                                               ; regA += 1
  $99A5  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
 >$99A6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $99A7  D7 7E 99                    branch_nz_abs            $997E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$99AA  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $99AB   (frame_off=-8, body @ $99B0)
; ============================================================
  $99B0  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $99B3  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $99B4  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $99B8  A4 57 6F                    loadA_mem_word           $6F57                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $99BB  A6 5F 6F                    loadB_mem_word           $6F5F (selected_province_idx) ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $99BE  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $99BF  D8 04 9A                    branch_z_abs             $9A04                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $99C2  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $99C5  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $99C8  BB                          add                                                ; regA = regA + regB
  $99C9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $99CA  45                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $99CB  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $99CC  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $99CD  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $99CE  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $99D2  8E 1E BD                    push_imm_word            $BD1E                     ; "Akechi Mitsuhide failed to\ntake your life and wi"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $99D5  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $99D9  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $99DA  D6 F8 99                    jump_abs                 $99F8                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$99DD  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $99DE  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $99E2  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $99E4  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $99E5  D8 F6 99                    branch_z_abs             $99F6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $99E8  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $99E9  8C 15 6E                    loadB_imm_word           $6E15 (fief_to_daimyo_map) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $99EC  BB                          add                                                ; regA = regA + regB
  $99ED  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $99EE  89 18                       loadA_imm_sbyte          +24                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $99F0  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $99F1  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $99F2  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$99F6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $99F7  D0                          incA                                               ; regA += 1
 >$99F8  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $99F9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $99FA  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $99FD  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $99FE  D7 DD 99                    branch_nz_abs            $99DD                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9A01  D6 9E 9A                    jump_abs                 $9A9E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9A04  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9A07  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9A0A  BB                          add                                                ; regA = regA + regB
  $9A0B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9A0C  45                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9A0D  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9A0E  89 1E                       loadA_imm_sbyte          +30                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9A10  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $9A13  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $9A14  E9 10 E5 02                 host_call                $E510 (ui_helper_e510) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A18  D0                          incA                                               ; regA += 1
  $9A19  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9A1A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9A1B  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $9A1C  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $9A1D  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9A1E  8E 89 6F                    push_imm_word            $6F89                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A21  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9A22  D1                          decA                                               ; regA -= 1
  $9A23  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9A24  E9 C6 98 04                 host_call                $98C6 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A28  8D 34                       op_8D_sbyte              +52
  $9A2A  8E 89 6F                    push_imm_word            $6F89                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A2D  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9A2E  E9 74 99 06                 host_call                $9974 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A32  8D 32                       op_8D_sbyte              +50
  $9A34  8E 89 6F                    push_imm_word            $6F89                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A37  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9A38  D2                          aslA                                               ; regA <<= 1
  $9A39  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9A3A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9A3B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9A3C  BC                          sub                                                ; regA = regA - regB
  $9A3D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9A3E  E9 74 99 06                 host_call                $9974 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A42  89 33                       loadA_imm_sbyte          +51                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9A44  A9 33 6E                    storeA_mem_byte          $6E33                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $9A47  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9A48  A9 C0 6D                    storeA_mem_byte          $6DC0                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $9A4B  45                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9A4C  A9 15 6D                    storeA_mem_byte          $6D15                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $9A4F  8D 1E                       op_8D_sbyte              +30
  $9A51  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A55  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9A56  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
 >$9A57  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9A58  8C D5 7F                    loadB_imm_word           $7FD5                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9A5B  BB                          add                                                ; regA = regA + regB
  $9A5C  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9A5D  8B 18                       loadB_imm_byte           +24                       ; regB = byte literal (handler $EABE)
  $9A5F  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $9A60  D8 6C 9A                    branch_z_abs             $9A6C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9A63  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9A64  8C D5 7F                    loadB_imm_word           $7FD5                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9A67  BB                          add                                                ; regA = regA + regB
  $9A68  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9A69  89 33                       loadA_imm_sbyte          +51                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9A6B  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$9A6C  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9A6D  D0                          incA                                               ; regA += 1
  $9A6E  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $9A6F  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $9A70  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $9A71  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9A72  D7 57 9A                    branch_nz_abs            $9A57                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9A75  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $9A76  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9A77  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A7B  8E 56 BD                    push_imm_word            $BD56                     ; "Nobunaga "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A7E  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A82  8E 60 BD                    push_imm_word            $BD60                     ; "has been destroyed,\nbut in the role of\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A85  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A89  8E 88 BD                    push_imm_word            $BD88                     ; "Hashiba Hideyoshi,\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A8C  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A90  8E 9C BD                    push_imm_word            $BD9C                     ; "Nobunaga`s loyal\nsubordinate, you may\ncontinue t"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A93  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9A97  8E D8 BD                    push_imm_word            $BDD8                     ; "Nobunaga`s ambition of a\nunited Japan"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9A9A  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$9A9E  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $9A9F  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9AA3  AC 09 D6                    host_call_simple         $D609 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9AA6  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $9AA7  E9 F2 E5 02                 host_call                $E5F2 (map_helper_e5f2) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9AAB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9AAC   (frame_off=-2, body @ $9AB1)
; ============================================================
  $9AB1  AC A4 E3                    host_call_simple         $E3A4 (diplomacy_helper) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9AB4  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9AB5  D8 11 9B                    branch_z_abs             $9B11                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9AB8  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9ABB  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $9ABF  8B D7                       loadB_imm_byte           -41                       ; regB = byte literal (handler $EABE)
  $9AC1  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $9AC2  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9AC3  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9AC6  D0                          incA                                               ; regA += 1
  $9AC7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9AC8  8E FE BD                    push_imm_word            $BDFE                     ; "\nwill you ally with\nfief %2d for %4d\nunits of go"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9ACB  E9 34 D1 06                 host_call                $D134 (ui_helper_d134) {bytecode}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9ACF  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9AD2  D8 07 9B                    branch_z_abs             $9B07                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9AD5  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $9AD6  E9 0C E8 02                 host_call                $E80C (ui_helper_e80c) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9ADA  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9ADB  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9ADE  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9AE0  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9AE1  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9AE4  BB                          add                                                ; regA = regA + regB
  $9AE5  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9AE6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9AE7  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9AE8  BB                          add                                                ; regA = regA + regB
  $9AE9  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9AEA  8E 31 BE                    push_imm_word            $BE31                     ; "This pact doesn`t\nmean you can\nrelax!"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9AED  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9AF1  AC 4F DA                    host_call_simple         $DA4F (diplomacy_helper2) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9AF4  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9AF5  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9AF8  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9AFA  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9AFB  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9AFE  BB                          add                                                ; regA = regA + regB
  $9AFF  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9B00  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9B01  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9B02  BC                          sub                                                ; regA = regA - regB
  $9B03  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9B04  D6 0E 9B                    jump_abs                 $9B0E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9B07  8E 57 BE                    push_imm_word            $BE57                     ; "Who needs wimps\nlike him anyway?"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9B0A  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$9B0E  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$9B11  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9B12   (frame_off=-2, body @ $9B17)
; ============================================================
  $9B17  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9B18  D6 71 9B                    jump_abs                 $9B71                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9B1B  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9B1E  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9B21  BB                          add                                                ; regA = regA + regB
  $9B22  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9B23  D8 6D 9B                    branch_z_abs             $9B6D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9B26  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $9B2A  8D D9                       op_8D_sbyte              -39
  $9B2C  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $9B2D  D7 6D 9B                    branch_nz_abs            $9B6D                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9B30  AC D7 DA                    host_call_simple         $DAD7 (combat_helper_dad7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9B33  8A 4F 6F                    loadA_imm_word           $6F4F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9B36  D6 63 9B                    jump_abs                 $9B63                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9B39  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9B3C  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $9B3F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9B40  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9B41  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $9B44  AC 1E 8C                    host_call_simple         $8C1E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9B47  D8 5B 9B                    branch_z_abs             $9B5B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9B4A  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9B4D  8C 67 6D                    loadB_imm_word           $6D67                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9B50  BB                          add                                                ; regA = regA + regB
  $9B51  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9B52  D7 5B 9B                    branch_nz_abs            $9B5B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9B55  AC AC 9A                    host_call_simple         $9AAC {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9B58  D6 7E 9B                    jump_abs                 $9B7E (driver_dam)        ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9B5B  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9B5E  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $9B61  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9B62  D0                          incA                                               ; regA += 1
 >$9B63  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9B64  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9B65  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9B66  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9B69  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9B6A  D7 39 9B                    branch_nz_abs            $9B39                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9B6D  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9B70  D0                          incA                                               ; regA += 1
 >$9B71  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $9B74  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9B77  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9B7A  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9B7B  D7 1B 9B                    branch_nz_abs            $9B1B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9B7E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9B7F   (frame_off=-2, body @ $9B84)
; ============================================================
  $9B84  AC 15 E3                    host_call_simple         $E315 (marry_helper_e315) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9B87  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9B88  D8 E4 9B                    branch_z_abs             $9BE4                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9B8B  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9B8E  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $9B92  8B D7                       loadB_imm_byte           -41                       ; regB = byte literal (handler $EABE)
  $9B94  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $9B95  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9B98  D0                          incA                                               ; regA += 1
  $9B99  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9B9A  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9B9B  8E 78 BE                    push_imm_word            $BE78                     ; "\nWill you accept\n%4d units of gold\nfrom fief %2d"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9B9E  E9 34 D1 06                 host_call                $D134 (ui_helper_d134) {bytecode}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9BA2  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9BA5  D8 DA 9B                    branch_z_abs             $9BDA                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9BA8  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $9BA9  E9 0C E8 02                 host_call                $E80C (ui_helper_e80c) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9BAD  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9BAE  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9BB1  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9BB3  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9BB4  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9BB7  BB                          add                                                ; regA = regA + regB
  $9BB8  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9BB9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9BBA  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9BBB  BB                          add                                                ; regA = regA + regB
  $9BBC  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9BBD  8E BA BE                    push_imm_word            $BEBA                     ; "you`ve lost a\ndaughter but\ngained a\nson-in-law"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9BC0  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9BC4  AC 7D DA                    host_call_simple         $DA7D (diplomacy_helper3) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9BC7  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9BC8  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9BCB  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9BCD  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9BCE  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9BD1  BB                          add                                                ; regA = regA + regB
  $9BD2  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9BD3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9BD4  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9BD5  BC                          sub                                                ; regA = regA - regB
  $9BD6  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9BD7  D6 E1 9B                    jump_abs                 $9BE1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9BDA  8E E9 BE                    push_imm_word            $BEE9                     ; "The princess was\ntoo good for him"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9BDD  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$9BE1  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$9BE4  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9BE5   (frame_off=-4, body @ $9BEA)
; ============================================================
  $9BEA  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9BEB  D6 18 9C                    jump_abs                 $9C18                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9BEE  AA 9D 6D E9                 op_AA_wb                 $6D9D, $E9
  $9BF2  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $9BF3  CA                          is_zero                                            ; regA = (regA == 0) ? 1 : 0   (logical NOT)
  $9BF4  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $9BF5  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9BF6  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $9BF7  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9BFB  D7 16 9C                    branch_nz_abs            $9C16                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9BFE  AC 45 8C                    host_call_simple         $8C45 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9C01  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9C04  8C 67 6D                    loadB_imm_word           $6D67                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9C07  BB                          add                                                ; regA = regA + regB
  $9C08  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9C09  D7 16 9C                    branch_nz_abs            $9C16                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9C0C  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9C0D  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $9C10  AC 7F 9B                    host_call_simple         $9B7F {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9C13  D6 21 9C                    jump_abs                 $9C21                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9C16  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9C17  D0                          incA                                               ; regA += 1
 >$9C18  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9C19  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9C1A  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9C1D  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9C1E  D7 EE 9B                    branch_nz_abs            $9BEE                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9C21  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9C22   (frame_off=-4, body @ $9C27)
; ============================================================
  $9C27  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9C28  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9C29  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9C2A  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9C2E  D8 83 9C                    branch_z_abs             $9C83                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9C31  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9C32  D6 7A 9C                    jump_abs                 $9C7A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9C35  8D 14                       op_8D_sbyte              +20
  $9C37  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9C3B  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $9C3C  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $9C3D  D8 78 9C                    branch_z_abs             $9C78                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9C40  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9C41  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9C45  D7 78 9C                    branch_nz_abs            $9C78                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9C48  48                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9C49  A6 09 6E                    loadB_mem_word           $6E09                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9C4C  BC                          sub                                                ; regA = regA - regB
  $9C4D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9C4E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9C4F  D0                          incA                                               ; regA += 1
  $9C50  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9C51  D1                          decA                                               ; regA -= 1
  $9C52  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9C53  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9C54  D8 78 9C                    branch_z_abs             $9C78                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9C57  AC 45 8C                    host_call_simple         $8C45 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9C5A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9C5B  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $9C5E  8E 5F 6F                    push_imm_word            $6F5F (selected_province_idx) ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9C61  8E 63 6F                    push_imm_word            $6F63                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9C64  E9 94 CB 04                 host_call                $CB94 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9C68  AC BF 93                    host_call_simple         $93BF {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9C6B  8E 5F 6F                    push_imm_word            $6F5F (selected_province_idx) ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9C6E  8E 63 6F                    push_imm_word            $6F63                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9C71  E9 94 CB 04                 host_call                $CB94 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9C75  D6 83 9C                    jump_abs                 $9C83                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9C78  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9C79  D0                          incA                                               ; regA += 1
 >$9C7A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9C7B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9C7C  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9C7F  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9C80  D7 35 9C                    branch_nz_abs            $9C35                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9C83  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9C84   (frame_off=+0, body @ $9C89)
; ============================================================
  $9C89  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9C8A  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9C8E  D8 A6 9C                    branch_z_abs             $9CA6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9C91  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $9C92  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9C96  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $9C97  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $9C98  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9C99  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9C9A  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9C9B  A3 9C                       op_A0_A3_byte            $9C                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $9C9D  01                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 1)
  $9C9E  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9C9F  A7 9C AD                    loadA_addr_word          $AD9C                     ; regA = word at absolute address <word> (handler $EB0A)
  $9CA2  9C                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $9CA3  AC E5 9B                    host_call_simple         $9BE5 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$9CA6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

  ; ---- gap $9CA7-$9CB2 (12 bytes, not on any traced path) ----

; ============================================================
; sub $9CB3   (frame_off=-4, body @ $9CB8)
; ============================================================
  $9CB8  8D 14                       op_8D_sbyte              +20
  $9CBA  E9 0C E8 02                 host_call                $E80C (ui_helper_e80c) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9CBE  8A AD 7B                    loadA_imm_word           $7BAD                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9CC1  D6 F5 9C                    jump_abs                 $9CF5                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9CC4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9CC5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9CC6  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9CC8  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9CC9  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9CCC  BB                          add                                                ; regA = regA + regB
  $9CCD  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9CCE  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $9CCF  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9CD3  D0                          incA                                               ; regA += 1
  $9CD4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9CD5  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9CD6  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $9CD7  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9CD8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9CD9  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9CDA  BC                          sub                                                ; regA = regA - regB
  $9CDB  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9CDC  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9CDD  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $9CDE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9CDF  8D 5A                       op_8D_sbyte              +90
  $9CE1  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9CE2  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $9CE3  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9CE4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9CE5  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9CE9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9CEA  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9CEB  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $9CEC  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9CED  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9CEE  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9CF2  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9CF3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9CF4  D0                          incA                                               ; regA += 1
 >$9CF5  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9CF6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9CF7  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9CF8  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9CFB  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9CFC  D7 C4 9C                    branch_nz_abs            $9CC4                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9CFF  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9D00   (frame_off=-6, body @ $9D05)
; ============================================================
  $9D05  8D 1F                       op_8D_sbyte              +31
  $9D07  E9 0C E8 02                 host_call                $E80C (ui_helper_e80c) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D0B  8A AD 7B                    loadA_imm_word           $7BAD                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9D0E  D6 7B 9D                    jump_abs                 $9D7B                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9D11  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9D12  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9D13  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9D15  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9D16  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9D19  BB                          add                                                ; regA = regA + regB
  $9D1A  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9D1B  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9D1C  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9D1E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D1F  8D 32                       op_8D_sbyte              +50
  $9D21  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D25  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9D27  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D28  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9D29  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9D2B  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9D2C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D2D  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D31  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9D32  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9D33  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $9D34  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D35  8D 32                       op_8D_sbyte              +50
  $9D37  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D3B  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $9D3D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D3E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9D3F  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $9D40  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9D41  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D42  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D46  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9D47  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9D48  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9D49  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9D4C  BB                          add                                                ; regA = regA + regB
  $9D4D  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9D4E  D8 79 9D                    branch_z_abs             $9D79                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9D51  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $9D52  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D56  D0                          incA                                               ; regA += 1
  $9D57  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D58  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9D59  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9D5A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D5B  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D5F  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9D60  D0                          incA                                               ; regA += 1
  $9D61  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D62  E9 12 CA 04                 host_call                $CA12 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D66  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9D67  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9D68  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D69  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D6D  8C D4 6D                    loadB_imm_word           $6DD4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9D70  BB                          add                                                ; regA = regA + regB
  $9D71  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D72  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9D73  D0                          incA                                               ; regA += 1
  $9D74  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9D75  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $9D77  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $9D78  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$9D79  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9D7A  D0                          incA                                               ; regA += 1
 >$9D7B  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9D7C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9D7D  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9D7E  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9D81  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9D82  D7 11 9D                    branch_nz_abs            $9D11                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9D85  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9D86   (frame_off=+0, body @ $9D8B)
; ============================================================
  $9D8B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9D8C  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $9D8E  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $9D8F  D8 95 9D                    branch_z_abs             $9D95                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9D92  89 32                       loadA_imm_sbyte          +50                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9D94  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
 >$9D95  8E E9 07                    push_imm_word            $07E9                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9D98  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9D9C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9D9D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9D9E  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $9D9F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9DA0  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9DA1  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $9DA2  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9DA3   (frame_off=+0, body @ $9DA8)
; ============================================================
  $9DA8  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9DA9  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $9DAC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9DAD  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9DAF  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9DB0  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9DB3  BB                          add                                                ; regA = regA + regB
  $9DB4  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9DB5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9DB6  E9 86 9D 02                 host_call                $9D86 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9DBA  D7 E9 9D                    branch_nz_abs            $9DE9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9DBD  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9DBE  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9DC1  BB                          add                                                ; regA = regA + regB
  $9DC2  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9DC3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9DC4  89 64                       loadA_imm_sbyte          +100                      ; regA = sign-extended signed byte literal (handler $EAAF)
  $9DC6  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9DC7  BC                          sub                                                ; regA = regA - regB
  $9DC8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9DC9  E9 86 9D 02                 host_call                $9D86 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9DCD  D7 E9 9D                    branch_nz_abs            $9DE9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9DD0  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9DD1  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9DD5  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $9DD6  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9DD7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9DD8  E9 86 9D 02                 host_call                $9D86 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9DDC  D7 E9 9D                    branch_nz_abs            $9DE9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9DDF  8E E8 03                    push_imm_word            $03E8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9DE2  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9DE6  D7 1B 9E                    branch_nz_abs            $9E1B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9DE9  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9DEA  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9DEC  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9DED  8C 09 70                    loadB_imm_word           $7009                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9DF0  BB                          add                                                ; regA = regA + regB
  $9DF1  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9DF2  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $9DF3  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $9DF4  D8 1B 9E                    branch_z_abs             $9E1B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9DF7  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9DF8  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9DFA  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9DFB  8C 11 70                    loadB_imm_word           $7011                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9DFE  BB                          add                                                ; regA = regA + regB
  $9DFF  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9E00  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $9E01  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $9E02  D8 1B 9E                    branch_z_abs             $9E1B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9E05  AC 12 DB                    host_call_simple         $DB12 (tax_helper_db12) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9E08  D7 1B 9E                    branch_nz_abs            $9E1B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9E0B  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9E0C  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E10  D7 1B 9E                    branch_nz_abs            $9E1B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9E13  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $9E14  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E18  D8 1F 9E                    branch_z_abs             $9E1F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$9E1B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9E1C  D6 20 9E                    jump_abs                 $9E20                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9E1F  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$9E20  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9E21   (frame_off=+0, body @ $9E26)
; ============================================================
  $9E26  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9E27  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $9E2A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9E2B  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9E2D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9E2E  8C 13 70                    loadB_imm_word           $7013                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9E31  BB                          add                                                ; regA = regA + regB
  $9E32  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9E33  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9E34  E9 86 9D 02                 host_call                $9D86 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E38  D7 60 9E                    branch_nz_abs            $9E60                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9E3B  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9E3C  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E40  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $9E41  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9E42  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9E43  E9 86 9D 02                 host_call                $9D86 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E47  D7 60 9E                    branch_nz_abs            $9E60                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9E4A  AC 12 DB                    host_call_simple         $DB12 (tax_helper_db12) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9E4D  D8 55 9E                    branch_z_abs             $9E55                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9E50  89 14                       loadA_imm_sbyte          +20                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $9E52  D6 58 9E                    jump_abs                 $9E58                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9E55  8A E8 03                    loadA_imm_word           $03E8                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
 >$9E58  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9E59  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E5D  D7 76 9E                    branch_nz_abs            $9E76                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9E60  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9E61  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9E63  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9E64  8C 11 70                    loadB_imm_word           $7011                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9E67  BB                          add                                                ; regA = regA + regB
  $9E68  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9E69  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $9E6A  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $9E6B  D8 76 9E                    branch_z_abs             $9E76                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9E6E  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9E6F  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E73  D8 7A 9E                    branch_z_abs             $9E7A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$9E76  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9E77  D6 7B 9E                    jump_abs                 $9E7B                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9E7A  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$9E7B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9E7C   (frame_off=+0, body @ $9E81)
; ============================================================
  $9E81  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9E82  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E86  D8 8B 9E                    branch_z_abs             $9E8B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9E89  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9E8A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9E8B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9E8C  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $9E8D  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $9E8E  D8 97 9E                    branch_z_abs             $9E97                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9E91  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9E92  E9 A3 9D 02                 host_call                $9DA3 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E96  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9E97  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9E98  E9 21 9E 02                 host_call                $9E21 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9E9C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9E9D   (frame_off=-6, body @ $9EA2)
; ============================================================
  $9EA2  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9EA3  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9EA4  8A AD 7B                    loadA_imm_word           $7BAD                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $9EA7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9EA8  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9EA9  D6 CA 9E                    jump_abs                 $9ECA                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9EAC  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9EAD  8C 1B 6F                    loadB_imm_word           $6F1B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9EB0  BB                          add                                                ; regA = regA + regB
  $9EB1  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9EB2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9EB3  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9EB4  E9 7C 9E 04                 host_call                $9E7C {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9EB8  D8 C8 9E                    branch_z_abs             $9EC8                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9EBB  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9EBC  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9EBD  8C 1B 6F                    loadB_imm_word           $6F1B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9EC0  BB                          add                                                ; regA = regA + regB
  $9EC1  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9EC2  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9EC3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9EC4  D0                          incA                                               ; regA += 1
  $9EC5  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9EC6  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9EC7  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
 >$9EC8  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9EC9  D0                          incA                                               ; regA += 1
 >$9ECA  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9ECB  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9ECC  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $9ECF  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9ED0  D7 AC 9E                    branch_nz_abs            $9EAC                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9ED3  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9ED4  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $9ED6  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9ED7  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9ED8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9ED9   (frame_off=-6, body @ $9EDE)
; ============================================================
  $9EDE  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9EDF  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9EE0  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9EE1  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9EE5  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9EE6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9EE7  D6 00 9F                    jump_abs                 $9F00                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9EEA  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9EEB  D0                          incA                                               ; regA += 1
  $9EEC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9EED  E9 9D 9E 02                 host_call                $9E9D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9EF1  D8 F9 9E                    branch_z_abs             $9EF9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9EF4  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9EF5  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9EF6  D6 07 9F                    jump_abs                 $9F07                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9EF9  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $9EFA  CD                          swap_AB                                            ; regA <-> regB
  $9EFB  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9EFC  DC                          bitxor                                             ; regA = regA ^ regB
  $9EFD  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9EFE  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9EFF  D0                          incA                                               ; regA += 1
 >$9F00  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9F01  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9F02  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $9F03  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9F04  D7 EA 9E                    branch_nz_abs            $9EEA                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$9F07  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9F08  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $9F09  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $9F0A  D8 11 9F                    branch_z_abs             $9F11                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9F0D  AC 84 9C                    host_call_simple         $9C84 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$9F10  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$9F11  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $9F12  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $9F13  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $9F14  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9F15  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9F16  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9F17  1F                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $9F18  9F                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $9F19  01                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 1)
  $9F1A  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $9F1B  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9F1C  9F                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $9F1D  10                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 0)
  $9F1E  9F                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $9F1F  8D 1E                       op_8D_sbyte              +30
  $9F21  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9F25  8E 0B BF                    push_imm_word            $BF0B                     ; "Riot"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $9F28  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9F2C  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9F2F  8D 17                       op_8D_sbyte              +23
  $9F31  E9 0C E8 02                 host_call                $E80C (ui_helper_e80c) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9F35  AC F8 8F                    host_call_simple         $8FF8 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $9F38  D6 10 9F                    jump_abs                 $9F10                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)

  ; ---- gap $9F3B-$9F56 (28 bytes, not on any traced path) ----

; ============================================================
; sub $9F57   (frame_off=-2, body @ $9F5C)
; ============================================================
  $9F5C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $9F5D  E9 6D 94 02                 host_call                $946D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9F61  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $9F62  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $9F63  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9F64  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9F65  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9F69  D8 8B 9F                    branch_z_abs             $9F8B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9F6C  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $9F6D  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9F71  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $9F72  BB                          add                                                ; regA = regA + regB
  $9F73  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9F74  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9F75  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $9F76  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9F77  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9F78  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9F79  BB                          add                                                ; regA = regA + regB
  $9F7A  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $9F7B  8D 28                       op_8D_sbyte              +40
  $9F7D  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9F81  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $9F82  BB                          add                                                ; regA = regA + regB
  $9F83  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9F84  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $9F85  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $9F86  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9F87  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9F88  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $9F89  BB                          add                                                ; regA = regA + regB
  $9F8A  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$9F8B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $9F8C   (frame_off=-8, body @ $9F91)
; ============================================================
  $9F91  A4 9F 6D                    loadA_mem_word           $6D9F                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9F94  8C 18 06                    loadB_imm_word           $0618                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9F97  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9F98  D8 37 A0                    branch_z_abs             $A037                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9F9B  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $9F9C  E9 E8 90 02                 host_call                $90E8 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9FA0  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $9FA1  E9 1E 91 02                 host_call                $911E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9FA5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9FA6  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9FA7  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $9FA8  E9 CD D7 02                 host_call                $D7CD {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9FAC  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9FAD  D6 C4 9F                    jump_abs                 $9FC4                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9FB0  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9FB1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9FB2  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9FB3  D0                          incA                                               ; regA += 1
  $9FB4  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9FB5  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9FB6  D0                          incA                                               ; regA += 1
  $9FB7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9FB8  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $9FB9  D1                          decA                                               ; regA -= 1
  $9FBA  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $9FBB  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9FBC  D0                          incA                                               ; regA += 1
  $9FBD  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $9FBE  D1                          decA                                               ; regA -= 1
  $9FBF  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $9FC0  77                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 7)
  $9FC1  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $9FC2  8F F9                       addA_imm_sbyte           -7                        ; regA += sign-extended signed byte literal (handler $EAD9)
 >$9FC4  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9FC7  73                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 3)
  $9FC8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9FC9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9FCA  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $9FCB  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $9FCC  D7 B0 9F                    branch_nz_abs            $9FB0                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9FCF  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $9FD0  D6 2B A0                    jump_abs                 $A02B                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$9FD3  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9FD4  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9FD8  D7 E9 9F                    branch_nz_abs            $9FE9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $9FDB  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9FDC  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9FDE  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9FDF  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9FE2  BB                          add                                                ; regA = regA + regB
  $9FE3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $9FE4  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9FE5  E9 57 9F 04                 host_call                $9F57 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$9FE9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $9FEA  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $9FEC  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $9FED  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $9FF0  BB                          add                                                ; regA = regA + regB
  $9FF1  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $9FF2  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $9FF3  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $9FF7  D8 29 A0                    branch_z_abs             $A029                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $9FFA  A4 63 6D                    loadA_mem_word           $6D63 (const_two)         ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $9FFD  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $9FFE  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $9FFF  D8 29 A0                    branch_z_abs             $A029                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A002  AA 63 6D E9                 op_AA_wb                 $6D63 (const_two), $E9
  $A006  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A007  CA                          is_zero                                            ; regA = (regA == 0) ? 1 : 0   (logical NOT)
  $A008  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $A009  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A00A  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $A00B  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A00C  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A00D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A00E  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A010  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A011  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A012  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A013  BC                          sub                                                ; regA = regA - regB
  $A014  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A015  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $A016  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A017  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A018  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A019  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A01B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A01C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A01D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A01E  BC                          sub                                                ; regA = regA - regB
  $A01F  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A020  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $A021  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A022  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A023  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A024  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A025  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A026  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A027  BC                          sub                                                ; regA = regA - regB
  $A028  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A029  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A02A  D0                          incA                                               ; regA += 1
 >$A02B  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A02C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A02D  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A030  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A031  D7 D3 9F                    branch_nz_abs            $9FD3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A034  D6 65 A0                    jump_abs                 $A065                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A037  8D 18                       op_8D_sbyte              +24
  $A039  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A03D  D8 4E A0                    branch_z_abs             $A04E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A040  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A043  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $A045  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $A046  D8 4E A0                    branch_z_abs             $A04E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A049  89 64                       loadA_imm_sbyte          +100                      ; regA = sign-extended signed byte literal (handler $EAAF)
  $A04B  A8 71 72                    loadA_mem_word           $7271                     ; regA = word read using <word> as address (handler $EA75)
 >$A04E  8D 10                       op_8D_sbyte              +16
  $A050  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A054  D8 65 A0                    branch_z_abs             $A065                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A057  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A05A  8B 11                       loadB_imm_byte           +17                       ; regB = byte literal (handler $EABE)
  $A05C  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $A05D  D8 65 A0                    branch_z_abs             $A065                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A060  89 64                       loadA_imm_sbyte          +100                      ; regA = sign-extended signed byte literal (handler $EAAF)
  $A062  A8 A1 71                    loadA_mem_word           $71A1                     ; regA = word read using <word> as address (handler $EA75)
 >$A065  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A066   (frame_off=-8, body @ $A06B)
; ============================================================
  $A06B  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A06C  E9 E8 90 02                 host_call                $90E8 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A070  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A071  D6 9F A0                    jump_abs                 $A09F                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A074  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A075  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A076  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A077  8C 03 60                    loadB_imm_word           $6003                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A07A  BB                          add                                                ; regA = regA + regB
  $A07B  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A07C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A07D  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $A07F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A080  8C 09 70                    loadB_imm_word           $7009                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A083  BB                          add                                                ; regA = regA + regB
  $A084  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A085  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A086  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$A087  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A088  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A089  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A08A  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A08C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A08D  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A08E  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A08F  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A090  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A092  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A093  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A094  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A095  D0                          incA                                               ; regA += 1
  $A096  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A097  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A098  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $A099  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A09A  D7 87 A0                    branch_nz_abs            $A087                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A09D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A09E  D0                          incA                                               ; regA += 1
 >$A09F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A0A0  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A0A1  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A0A4  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A0A5  D7 74 A0                    branch_nz_abs            $A074                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A0A8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A0A9   (frame_off=-4, body @ $A0AE)
; ============================================================
  $A0AE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A0AF  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $A0B1  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A0B2  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A0B5  BB                          add                                                ; regA = regA + regB
  $A0B6  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A0B7  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A0B8  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $A0B9  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A0BA  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A0BB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A0BC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A0BD  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A0BE  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A0BF  8C 03 60                    loadB_imm_word           $6003                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A0C2  BB                          add                                                ; regA = regA + regB
  $A0C3  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A0C4  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A0C5  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $A0C6  D8 D3 A0                    branch_z_abs             $A0D3                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A0C9  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A0CA  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A0CB  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A0CC  8C 03 60                    loadB_imm_word           $6003                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A0CF  BB                          add                                                ; regA = regA + regB
  $A0D0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A0D1  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A0D2  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A0D3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A0D4  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $A0D5  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A0D6  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A0D7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A0D8  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A0D9  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A0DA  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A0DB  8C 05 60                    loadB_imm_word           $6005                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A0DE  BB                          add                                                ; regA = regA + regB
  $A0DF  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A0E0  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A0E1  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $A0E2  D8 EF A0                    branch_z_abs             $A0EF                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A0E5  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A0E6  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A0E7  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A0E8  8C 05 60                    loadB_imm_word           $6005                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A0EB  BB                          add                                                ; regA = regA + regB
  $A0EC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A0ED  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A0EE  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A0EF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A0F0  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $A0F1  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A0F2  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A0F3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A0F4  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A0F5  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A0F6  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A0F7  8C 07 60                    loadB_imm_word           $6007                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A0FA  BB                          add                                                ; regA = regA + regB
  $A0FB  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A0FC  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A0FD  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $A0FE  D8 0B A1                    branch_z_abs             $A10B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A101  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A102  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A103  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A104  8C 07 60                    loadB_imm_word           $6007                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A107  BB                          add                                                ; regA = regA + regB
  $A108  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A109  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A10A  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A10B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A10C  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $A10D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A10E  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A10F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A110  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A111  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A112  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A113  8C 09 60                    loadB_imm_word           $6009                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A116  BB                          add                                                ; regA = regA + regB
  $A117  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A118  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A119  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $A11A  D8 27 A1                    branch_z_abs             $A127                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A11D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A11E  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A11F  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A120  8C 09 60                    loadB_imm_word           $6009                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A123  BB                          add                                                ; regA = regA + regB
  $A124  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A125  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A126  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A127  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A128   (frame_off=-2, body @ $A12D)
; ============================================================
  $A12D  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $A12E  E9 6D 94 02                 host_call                $946D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A132  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $A133  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $A134  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A135  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $A136  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A13A  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $A13B  BB                          add                                                ; regA = regA + regB
  $A13C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A13D  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A13E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A13F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A140  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A141  BB                          add                                                ; regA = regA + regB
  $A142  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A143  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A144  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A148  D8 5A A1                    branch_z_abs             $A15A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A14B  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $A14C  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A150  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $A151  BB                          add                                                ; regA = regA + regB
  $A152  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A153  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A154  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $A155  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A156  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A157  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A158  BB                          add                                                ; regA = regA + regB
  $A159  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A15A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A15B   (frame_off=-4, body @ $A160)
; ============================================================
  $A160  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A161  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A163  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A164  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A165  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $A166  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A167  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A168  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $A169  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A16A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A16B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A16C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A16D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A16E  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A172  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A173  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $A174  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $A175  D8 81 A1                    branch_z_abs             $A181                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A178  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A179  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A17A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A17B  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A17D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A17E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A17F  D2                          aslA                                               ; regA <<= 1
  $A180  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A181  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A182  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A183  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A184  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A185  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A186  BC                          sub                                                ; regA = regA - regB
  $A187  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A188  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A189  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A18A  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $A18B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A18C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A18D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A18E  BC                          sub                                                ; regA = regA - regB
  $A18F  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A190  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A191   (frame_off=+0, body @ $A196)
; ============================================================
  $A196  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A197  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A19A  BB                          add                                                ; regA = regA + regB
  $A19B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A19C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A19D  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $A19E  E9 6D 94 02                 host_call                $946D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A1A2  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A1A3  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $A1A4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1A5  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A1A9  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A1AA   (frame_off=+0, body @ $A1AF)
; ============================================================
  $A1AF  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A1B0  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A1B3  BB                          add                                                ; regA = regA + regB
  $A1B4  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A1B5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1B6  8D 28                       op_8D_sbyte              +40
  $A1B8  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A1B9  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A1BA  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A1BB  8C 07 60                    loadB_imm_word           $6007                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A1BE  BB                          add                                                ; regA = regA + regB
  $A1BF  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A1C0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1C1  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A1C5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1C6  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A1CA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1CB  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A1CC  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A1CF  BB                          add                                                ; regA = regA + regB
  $A1D0  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A1D1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1D2  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A1D3  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A1D4  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A1D5  8C 09 60                    loadB_imm_word           $6009                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A1D8  BB                          add                                                ; regA = regA + regB
  $A1D9  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A1DA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1DB  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A1DF  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A1E0  BB                          add                                                ; regA = regA + regB
  $A1E1  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A1E2   (frame_off=-2, body @ $A1E7)
; ============================================================
  $A1E7  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $A1E8  E9 91 A1 02                 host_call                $A191 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A1EC  D0                          incA                                               ; regA += 1
  $A1ED  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1EE  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A1F2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1F3  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A1F4  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A1F7  BB                          add                                                ; regA = regA + regB
  $A1F8  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A1F9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1FA  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A1FB  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $A1FC  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A1FD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A1FE  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A202  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A203  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $A204  E9 AA A1 02                 host_call                $A1AA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A208  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A209  BB                          add                                                ; regA = regA + regB
  $A20A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A20B  BB                          add                                                ; regA = regA + regB
  $A20C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A20D  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A20E  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A210  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A211  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A212  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A213  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A214  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $A215  D8 1D A2                    branch_z_abs             $A21D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A218  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A219  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A21B  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A21C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$A21D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A21E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A21F   (frame_off=-2, body @ $A224)
; ============================================================
  $A224  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $A225  E9 91 A1 02                 host_call                $A191 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A229  D0                          incA                                               ; regA += 1
  $A22A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A22B  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A22F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A230  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A231  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A234  BB                          add                                                ; regA = regA + regB
  $A235  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A236  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A237  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A238  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A239  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A23A  8C 05 60                    loadB_imm_word           $6005                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A23D  BB                          add                                                ; regA = regA + regB
  $A23E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A23F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A240  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A241  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A242  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $A243  8C 03 60                    loadB_imm_word           $6003                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A246  BB                          add                                                ; regA = regA + regB
  $A247  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A248  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A249  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A24D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A24E  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A252  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A253  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $A254  E9 AA A1 02                 host_call                $A1AA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A258  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A259  BB                          add                                                ; regA = regA + regB
  $A25A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A25B  BB                          add                                                ; regA = regA + regB
  $A25C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A25D  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A25E  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A260  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A261  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A262  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A263  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A264  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $A265  D8 6D A2                    branch_z_abs             $A26D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A268  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A269  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A26B  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A26C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$A26D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A26E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A26F   (frame_off=-6, body @ $A274)
; ============================================================
  $A274  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A275  E9 E8 90 02                 host_call                $90E8 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A279  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A27A  D6 D5 A2                    jump_abs                 $A2D5                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A27D  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $A27E  E9 A9 A0 02                 host_call                $A0A9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A282  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A283  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $A285  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A286  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A289  BB                          add                                                ; regA = regA + regB
  $A28A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A28B  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $A28C  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A290  D7 99 A2                    branch_nz_abs            $A299                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A293  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A294  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $A295  E9 28 A1 04                 host_call                $A128 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$A299  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A29A  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $A29B  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A29C  D8 C1 A2                    branch_z_abs             $A2C1                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A29F  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A2A0  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A2A3  BB                          add                                                ; regA = regA + regB
  $A2A4  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A2A5  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A2A6  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A2A7  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $A2A8  E9 E2 A1 04                 host_call                $A1E2 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2AC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A2AD  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A2AE  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A2AF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A2B0  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A2B1  BB                          add                                                ; regA = regA + regB
  $A2B2  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A2B3  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A2B4  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $A2B5  E9 1F A2 04                 host_call                $A21F {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2B9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A2BA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A2BB  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $A2BC  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A2BD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A2BE  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A2BF  BB                          add                                                ; regA = regA + regB
  $A2C0  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A2C1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A2C2  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A2C3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A2C4  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A2C5  E9 A9 92 04                 host_call                $92A9 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2C9  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A2CA  E9 5B A1 02                 host_call                $A15B {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2CE  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $A2CF  E9 36 D8 02                 host_call                $D836 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2D3  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A2D4  D0                          incA                                               ; regA += 1
 >$A2D5  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A2D6  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A2D7  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A2DA  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A2DB  D7 7D A2                    branch_nz_abs            $A27D                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A2DE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A2DF   (frame_off=+0, body @ $A2E4)
; ============================================================
  $A2E4  8D 64                       op_8D_sbyte              +100
  $A2E6  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2EA  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A2EB  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $A2EC  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A2ED   (frame_off=-2, body @ $A2F2)
; ============================================================
  $A2F2  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $A2F3  E9 CD D7 02                 host_call                $D7CD {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2F7  73                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 3)
  $A2F8  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A2F9  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $A2FA  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A2FE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A2FF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A300  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A301  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A302  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A303  BB                          add                                                ; regA = regA + regB
  $A304  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $A305  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $A306  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A307  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A308  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A309  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A30A  BC                          sub                                                ; regA = regA - regB
  $A30B  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $A30C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A30D   (frame_off=-2, body @ $A312)
; ============================================================
  $A312  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A313  D6 49 A3                    jump_abs                 $A349                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A316  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A317  E9 ED A2 02                 host_call                $A2ED {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A31B  89 5A                       loadA_imm_sbyte          +90                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $A31D  A6 63 6D                    loadB_mem_word           $6D63 (const_two)         ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A320  BC                          sub                                                ; regA = regA - regB
  $A321  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A322  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A323  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A326  BB                          add                                                ; regA = regA + regB
  $A327  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A328  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A329  C9                          cmp_ult                                            ; regA = (regA < regB) ? 1 : 0   (unsigned)
  $A32A  D8 47 A3                    branch_z_abs             $A347                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A32D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A32E  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $A330  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A331  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A334  BB                          add                                                ; regA = regA + regB
  $A335  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A336  8D 5A                       op_8D_sbyte              +90
  $A338  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A339  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $A33B  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A33C  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A33F  BB                          add                                                ; regA = regA + regB
  $A340  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A341  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A342  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A346  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A347  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A348  D0                          incA                                               ; regA += 1
 >$A349  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A34A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A34B  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A34E  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A34F  D7 16 A3                    branch_nz_abs            $A316                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A352  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $A353  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A354  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A358  AC 77 D6                    host_call_simple         $D677 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A35B  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $A35C  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $A35D  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A361  AC 87 D6                    host_call_simple         $D687 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A364  AC 63 8E                    host_call_simple         $8E63 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A367  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $A369  A9 67 6F                    storeA_mem_byte          $6F67                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $A36C  A4 5F 6D                    loadA_mem_word           $6D5F (config_block)      ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A36F  D5                          switch                                             ; Jump-table dispatch on regA (handler $EC65) — reads inline (value,target) pairs from the bytecode stream, jumps to the matching target. Variable-length; the disassembler stops the fall-through run here.

  ; ---- gap $A370-$A3A9 (58 bytes, not on any traced path) ----

; ============================================================
; sub $A3AA   (frame_off=-6, body @ $A3AF)
; ============================================================
  $A3AF  A4 61 6F                    loadA_mem_word           $6F61                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A3B2  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A3B3  8E FF 00                    push_imm_word            $00FF                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A3B6  8E 01 60                    push_imm_word            $6001                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A3B9  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A3BA  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $A3BB  8D 16                       op_8D_sbyte              +22
  $A3BD  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A3C1  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A3C2  8A 00 61                    loadA_imm_word           $6100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $A3C5  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$A3C6  8E 00 01                    push_imm_word            $0100                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A3C9  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A3CA  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A3CB  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $A3CC  8D 16                       op_8D_sbyte              +22
  $A3CE  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A3D2  CD                          swap_AB                                            ; regA <-> regB
  $A3D3  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A3D4  BB                          add                                                ; regA = regA + regB
  $A3D5  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A3D6  8A 00 01                    loadA_imm_word           $0100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $A3D9  CD                          swap_AB                                            ; regA <-> regB
  $A3DA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A3DB  BB                          add                                                ; regA = regA + regB
  $A3DC  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A3DD  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A3DE  8C 00 70                    loadB_imm_word           $7000                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A3E1  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A3E2  D7 C6 A3                    branch_nz_abs            $A3C6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A3E5  8E FF 00                    push_imm_word            $00FF                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A3E8  8E 01 70                    push_imm_word            $7001 (province_table_live) ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A3EB  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A3EC  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $A3ED  8D 16                       op_8D_sbyte              +22
  $A3EF  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A3F3  CD                          swap_AB                                            ; regA <-> regB
  $A3F4  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A3F5  BB                          add                                                ; regA = regA + regB
  $A3F6  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A3F7  8A 00 71                    loadA_imm_word           $7100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $A3FA  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$A3FB  8E 00 01                    push_imm_word            $0100                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A3FE  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A3FF  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A400  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $A401  8D 16                       op_8D_sbyte              +22
  $A403  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A407  CD                          swap_AB                                            ; regA <-> regB
  $A408  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A409  BB                          add                                                ; regA = regA + regB
  $A40A  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A40B  8A 00 01                    loadA_imm_word           $0100                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $A40E  CD                          swap_AB                                            ; regA <-> regB
  $A40F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A410  BB                          add                                                ; regA = regA + regB
  $A411  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A412  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A413  8C 00 7F                    loadB_imm_word           $7F00 (ui_transient_state) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A416  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A417  D7 FB A3                    branch_nz_abs            $A3FB                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A41A  8E EB 81                    push_imm_word            $81EB                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A41D  8E 00 7F                    push_imm_word            $7F00 (ui_transient_state) ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A420  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A421  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $A422  8D 16                       op_8D_sbyte              +22
  $A424  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A428  CD                          swap_AB                                            ; regA <-> regB
  $A429  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A42A  BB                          add                                                ; regA = regA + regB
  $A42B  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A42C  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A42D  A8 EB 7F                    loadA_mem_word           $7FEB                     ; regA = word read using <word> as address (handler $EA75)
  $A430  8E 17 BF                    push_imm_word            $BF17                     ; "KOEI"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A433  8E ED 7F                    push_imm_word            $7FED                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A436  E9 D9 CA 04                 host_call                $CAD9 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A43A  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $A43B  E9 A4 CB 02                 host_call                $CBA4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A43F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A440  A8 61 6F                    loadA_mem_word           $6F61                     ; regA = word read using <word> as address (handler $EA75)
  $A443  8E 1C BF                    push_imm_word            $BF1C                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A446  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A44A  8E 1D BF                    push_imm_word            $BF1D                     ; "Data has been\nsaved"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A44D  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A451  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A454  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A455   (frame_off=-8, body @ $A45A)
; ============================================================
  $A45A  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $A45B  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $A45E  AC 20 CD                    host_call_simple         $CD20 (ui_helper_cd20) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A461  A4 48 6E                    loadA_mem_word           $6E48                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A464  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $A465  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $A466  D8 73 A4                    branch_z_abs             $A473                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A469  AC AB 99                    host_call_simple         $99AB {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A46C  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $A46D  A8 48 6E                    loadA_mem_word           $6E48                     ; regA = word read using <word> as address (handler $EA75)
  $A470  D6 D4 A5                    jump_abs                 $A5D4                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A473  AC 94 E6                    host_call_simple         $E694 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A476  A4 61 6F                    loadA_mem_word           $6F61                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A479  D8 7F A4                    branch_z_abs             $A47F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A47C  AC AA A3                    host_call_simple         $A3AA {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$A47F  A4 5F 6D                    loadA_mem_word           $6D5F (config_block)      ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A482  D0                          incA                                               ; regA += 1
  $A483  A8 5F 6D                    loadA_mem_word           $6D5F (config_block)      ; regA = word read using <word> as address (handler $EA75)
  $A486  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A487  DA                          bitand                                             ; regA = regA & regB
  $A488  A8 5F 6D                    loadA_mem_word           $6D5F (config_block)      ; regA = word read using <word> as address (handler $EA75)
  $A48B  D7 98 A4                    branch_nz_abs            $A498                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A48E  A4 9F 6D                    loadA_mem_word           $6D9F                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A491  D0                          incA                                               ; regA += 1
  $A492  A8 9F 6D                    loadA_mem_word           $6D9F                     ; regA = word read using <word> as address (handler $EA75)
  $A495  AC 4A 92                    host_call_simple         $924A {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$A498  AC 0D A3                    host_call_simple         $A30D {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A49B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A49C  D6 AE A4                    jump_abs                 $A4AE                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A49F  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A4A0  E9 36 D8 02                 host_call                $D836 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A4A4  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A4A5  8C D4 6D                    loadB_imm_word           $6DD4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A4A8  BB                          add                                                ; regA = regA + regB
  $A4A9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A4AA  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A4AB  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $A4AC  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A4AD  D0                          incA                                               ; regA += 1
 >$A4AE  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A4AF  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A4B0  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A4B3  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A4B4  D7 9F A4                    branch_nz_abs            $A49F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A4B7  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A4BA  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A4BD  DA                          bitand                                             ; regA = regA & regB
  $A4BE  D8 C2 A4                    branch_z_abs             $A4C2                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A4C1  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$A4C2  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A4C3  A8 7B 6F                    loadA_mem_word           $6F7B                     ; regA = word read using <word> as address (handler $EA75)
  $A4C6  A4 5F 6D                    loadA_mem_word           $6D5F (config_block)      ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A4C9  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $A4CA  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $A4CB  D8 DE A4                    branch_z_abs             $A4DE                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A4CE  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A4CF  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A4D3  D8 DE A4                    branch_z_abs             $A4DE                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A4D6  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $A4D7  A8 7B 6F                    loadA_mem_word           $6F7B                     ; regA = word read using <word> as address (handler $EA75)
  $A4DA  8A B3 9C                    loadA_imm_word           $9CB3                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $A4DD  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$A4DE  A4 7B 6F                    loadA_mem_word           $6F7B                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A4E1  D7 FE A4                    branch_nz_abs            $A4FE                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A4E4  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $A4E5  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A4E9  D7 F6 A4                    branch_nz_abs            $A4F6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A4EC  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $A4ED  A8 7B 6F                    loadA_mem_word           $6F7B                     ; regA = word read using <word> as address (handler $EA75)
  $A4F0  8A 00 9D                    loadA_imm_word           $9D00                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $A4F3  D6 FD A4                    jump_abs                 $A4FD                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A4F6  43                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $A4F7  A8 7B 6F                    loadA_mem_word           $6F7B                     ; regA = word read using <word> as address (handler $EA75)
  $A4FA  8A D9 9E                    loadA_imm_word           $9ED9                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
 >$A4FD  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$A4FE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A4FF  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A500  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A501  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A502  D6 34 A5                    jump_abs                 $A534                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A505  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A506  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A50A  D7 31 A5                    branch_nz_abs            $A531                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A50D  A4 7B 6F                    loadA_mem_word           $6F7B                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A510  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A511  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $A512  D8 20 A5                    branch_z_abs             $A520                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A515  8D 28                       op_8D_sbyte              +40
  $A517  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A51B  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $A51C  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $A51D  D6 23 A5                    jump_abs                 $A523                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A520  AC DF A2                    host_call_simple         $A2DF {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$A523  D8 31 A5                    branch_z_abs             $A531                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A526  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A527  D0                          incA                                               ; regA += 1
  $A528  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A529  D1                          decA                                               ; regA -= 1
  $A52A  8C AD 7B                    loadB_imm_word           $7BAD                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A52D  BB                          add                                                ; regA = regA + regB
  $A52E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A52F  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A530  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$A531  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A532  D0                          incA                                               ; regA += 1
  $A533  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
 >$A534  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A535  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A538  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A539  D7 05 A5                    branch_nz_abs            $A505                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A53C  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A53D  8C AD 7B                    loadB_imm_word           $7BAD                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A540  BB                          add                                                ; regA = regA + regB
  $A541  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A542  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $A544  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $A545  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A546  D8 5B A5                    branch_z_abs             $A55B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A549  AA 7B 6F E9                 op_AA_wb                 $6F7B, $E9
  $A54D  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A54E  94                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $A54F  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $A550  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A551  DD                          host_call_indirect_simple                          ; JSR to native code at address in regA; no ptr1 adjust (handler $EB43)
  $A552  A4 48 6E                    loadA_mem_word           $6E48                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A555  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $A556  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $A557  D8 5B A5                    branch_z_abs             $A55B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A55A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$A55B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A55C  D6 CB A5                    jump_abs                 $A5CB                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A55F  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A560  E9 CD D7 02                 host_call                $D7CD {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A564  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A565  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A566  D0                          incA                                               ; regA += 1
  $A567  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A568  8B 63                       loadB_imm_byte           +99                       ; regB = byte literal (handler $EABE)
  $A56A  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $A56B  D7 C9 A5                    branch_nz_abs            $A5C9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A56E  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A56F  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A573  8C 67 6D                    loadB_imm_word           $6D67                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A576  BB                          add                                                ; regA = regA + regB
  $A577  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A578  D7 C9 A5                    branch_nz_abs            $A5C9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A57B  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A57C  8C D4 6D                    loadB_imm_word           $6DD4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A57F  BB                          add                                                ; regA = regA + regB
  $A580  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A581  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A582  8C D4 6D                    loadB_imm_word           $6DD4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A585  BB                          add                                                ; regA = regA + regB
  $A586  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A587  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A588  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A589  D0                          incA                                               ; regA += 1
  $A58A  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A58B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A58C  89 64                       loadA_imm_sbyte          +100                      ; regA = sign-extended signed byte literal (handler $EAAF)
  $A58E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A58F  BC                          sub                                                ; regA = regA - regB
  $A590  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A591  8E 90 01                    push_imm_word            $0190                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A594  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A598  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A599  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $A59A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A59B  DB                          bitor                                              ; regA = regA | regB
  $A59C  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $A59D  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A59E  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $A5A1  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A5A2  E9 72 D9 02                 host_call                $D972 (war_helper_d972) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A5A6  D8 C9 A5                    branch_z_abs             $A5C9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A5A9  AC 1E 8C                    host_call_simple         $8C1E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A5AC  D8 C9 A5                    branch_z_abs             $A5C9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A5AF  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A5B0  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A5B4  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $A5B5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A5B6  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A5B9  BB                          add                                                ; regA = regA + regB
  $A5BA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A5BB  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A5BF  8E 31 BF                    push_imm_word            $BF31                     ; " has\ntaken ill"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A5C2  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A5C6  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$A5C9  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A5CA  D0                          incA                                               ; regA += 1
 >$A5CB  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A5CC  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A5CD  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A5D0  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A5D1  D7 5F A5                    branch_nz_abs            $A55F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$A5D4  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A5D5   (frame_off=+0, body @ $A5DA)
; ============================================================
  $A5DA  A4 63 6D                    loadA_mem_word           $6D63 (const_two)         ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A5DD  D0                          incA                                               ; regA += 1
  $A5DE  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $A5DF  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A5E0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A5E1  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A5E5  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A5E6   (frame_off=-14, body @ $A5EB)
; ============================================================
  $A5EB  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A5EE  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $A5F0  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $A5F1  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A5F4  BB                          add                                                ; regA = regA + regB
  $A5F5  25                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 5)
  $A5F6  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $A5F7  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $A5F8  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $A5F9  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A5FB  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A5FC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A5FD  D8 86 A6                    branch_z_abs             $A686                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A600  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A601  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A602  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $A603  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $A604  D8 16 A6                    branch_z_abs             $A616                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A607  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $A608  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A609  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A60A  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A60B  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $A60C  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A60D  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A60E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A60F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A610  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A611  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A612  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A613  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A614  BC                          sub                                                ; regA = regA - regB
  $A615  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A616  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A617  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A618  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $A619  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $A61A  D8 2C A6                    branch_z_abs             $A62C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A61D  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $A61E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A61F  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A620  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A621  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $A622  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A623  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A624  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A625  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A626  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A627  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A628  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A629  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A62A  BC                          sub                                                ; regA = regA - regB
  $A62B  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A62C  AA 63 6D E9                 op_AA_wb                 $6D63 (const_two), $E9
  $A630  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A631  CA                          is_zero                                            ; regA = (regA == 0) ? 1 : 0   (logical NOT)
  $A632  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $A633  8F 46                       addA_imm_sbyte           +70                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A635  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A636  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $A63A  DA                          bitand                                             ; regA = regA & regB
  $A63B  D7 02 74                    branch_nz_abs            $7402                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A63E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $A63F  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A640  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $A641  D8 61 A6                    branch_z_abs             $A661                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A644  8D 32                       op_8D_sbyte              +50
  $A646  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A64A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A64B  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A64C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A64D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A64E  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A652  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A653  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A654  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A655  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A656  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A657  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A658  BB                          add                                                ; regA = regA + regB
  $A659  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A65A  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A65B  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A65C  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A65D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A65E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A65F  BC                          sub                                                ; regA = regA - regB
  $A660  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$A661  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $A662  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A663  A8 81 6F                    loadA_mem_word           $6F81                     ; regA = word read using <word> as address (handler $EA75)
 >$A666  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $A667  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $A668  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $A669  8D 1F                       op_8D_sbyte              +31
  $A66B  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A66F  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A671  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A672  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A673  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A674  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A675  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A679  A8 7F 6F                    loadA_mem_word           $6F7F                     ; regA = word read using <word> as address (handler $EA75)
  $A67C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A67D  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A67E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A67F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A680  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A681  BC                          sub                                                ; regA = regA - regB
  $A682  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A683  D6 B8 A6                    jump_abs                 $A6B8                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A686  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A687  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A688  8B 14                       loadB_imm_byte           +20                       ; regB = byte literal (handler $EABE)
  $A68A  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $A68B  D8 AB A6                    branch_z_abs             $A6AB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A68E  8D 46                       op_8D_sbyte              +70
  $A690  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A694  8F 14                       addA_imm_sbyte           +20                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A696  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A697  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A698  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A699  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A69A  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A69E  A8 81 6F                    loadA_mem_word           $6F81                     ; regA = word read using <word> as address (handler $EA75)
  $A6A1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A6A2  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $A6A3  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A6A4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A6A5  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A6A6  BC                          sub                                                ; regA = regA - regB
  $A6A7  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A6A8  D6 66 A6                    jump_abs                 $A666                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A6AB  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $A6AC  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A6B0  8F 19                       addA_imm_sbyte           +25                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A6B2  A8 81 6F                    loadA_mem_word           $6F81                     ; regA = word read using <word> as address (handler $EA75)
  $A6B5  A8 7F 6F                    loadA_mem_word           $6F7F                     ; regA = word read using <word> as address (handler $EA75)
 >$A6B8  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A6B9  A8 7D 6F                    loadA_mem_word           $6F7D                     ; regA = word read using <word> as address (handler $EA75)
  $A6BC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $A6BD  D8 C5 A6                    branch_z_abs             $A6C5                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A6C0  89 40                       loadA_imm_sbyte          +64                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $A6C2  D6 C7 A6                    jump_abs                 $A6C7 (driver_view)       ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A6C5  89 20                       loadA_imm_sbyte          +32                       ; regA = sign-extended signed byte literal (handler $EAAF)
 >$A6C7  CD                          swap_AB                                            ; regA <-> regB
  $A6C8  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A6CB  DB                          bitor                                              ; regA = regA | regB
  $A6CC  A9 A1 6D                    storeA_mem_byte          $6DA1                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $A6CF  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A6D0  A9 65 6F                    storeA_mem_byte          $6F65                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $A6D3  8A 15 75                    loadA_imm_word           $7515 (zealot_uprising_slot) ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $A6D6  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A6D7  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $A6D8  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $A6D9  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A6DA  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $A6DB  D6 FE A6                    jump_abs                 $A6FE                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A6DE  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $A6DF  8D 14                       op_8D_sbyte              +20
  $A6E1  E9 52 CA 02                 host_call                $CA52 (rng_mod) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A6E5  8F 28                       addA_imm_sbyte           +40                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A6E7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A6E8  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $A6E9  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A6EA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A6EB  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A6EF  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A6F0  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A6F1  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A6F2  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A6F3  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A6F5  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $A6F6  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A6F7  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $A6F8  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A6FA  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $A6FB  D0                          incA                                               ; regA += 1
  $A6FC  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $A6FD  D1                          decA                                               ; regA -= 1
 >$A6FE  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $A6FF  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $A700  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A701  D7 DE A6                    branch_nz_abs            $A6DE                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A704  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A705  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A706  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A707  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A709  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A70A  A4 81 6F                    loadA_mem_word           $6F81                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A70D  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A70E  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A70F  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A710  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A711  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A713  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A714  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $A715  8F 12                       addA_imm_sbyte           +18                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A717  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A718  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A719  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $A71A  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A71C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A71D  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A71E  BC                          sub                                                ; regA = regA - regB
  $A71F  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A720  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $A721  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $A722  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $A723  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $A725  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A726  AC D5 A5                    host_call_simple         $A5D5 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A729  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A72A  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $A72B  AC D5 A5                    host_call_simple         $A5D5 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A72E  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $A72F  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $A730  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $A731  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A732  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A733  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $A734  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $A736  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $A737  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $A738  BC                          sub                                                ; regA = regA - regB
  $A739  A8 21 75                    loadA_mem_word           $7521                     ; regA = word read using <word> as address (handler $EA75)
  $A73C  89 32                       loadA_imm_sbyte          +50                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $A73E  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $A741  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A742   (frame_off=-2, body @ $A747)
; ============================================================
  $A747  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A748  D6 6E A7                    jump_abs                 $A76E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A74B  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $A74C  E9 36 D8 02                 host_call                $D836 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A750  AA 9D 6D E9                 op_AA_wb                 $6D9D, $E9
  $A754  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A755  CA                          is_zero                                            ; regA = (regA == 0) ? 1 : 0   (logical NOT)
  $A756  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $A757  8C 1B 6F                    loadB_imm_word           $6F1B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A75A  BB                          add                                                ; regA = regA + regB
  $A75B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A75C  AA 9D 6D E9                 op_AA_wb                 $6D9D, $E9
  $A760  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $A761  CA                          is_zero                                            ; regA = (regA == 0) ? 1 : 0   (logical NOT)
  $A762  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $A763  8C 1B 6F                    loadB_imm_word           $6F1B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A766  BB                          add                                                ; regA = regA + regB
  $A767  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A768  E9 80 CB 04                 host_call                $CB80 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A76C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A76D  D0                          incA                                               ; regA += 1
 >$A76E  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $A76F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $A770  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $A773  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $A774  D7 4B A7                    branch_nz_abs            $A74B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A777  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $A778 (vm_bootstrap)   (frame_off=+0, body @ $A77D)
; ============================================================
 >$A77D  AC A3 89                    host_call_simple         $89A3 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A780  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $A781  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$A785  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A786  A8 79 6F                    loadA_mem_word           $6F79                     ; regA = word read using <word> as address (handler $EA75)
  $A789  AC 55 A4                    host_call_simple         $A455 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A78C  A4 48 6E                    loadA_mem_word           $6E48                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A78F  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $A790  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $A791  D8 B0 A7                    branch_z_abs             $A7B0                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A794  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $A796  A9 67 6F                    storeA_mem_byte          $6F67                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $A799  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A79A  E9 B1 CB 02                 host_call                $CBB1 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A79E  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A7A1  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A7A4  DA                          bitand                                             ; regA = regA & regB
  $A7A5  D7 AD A7                    branch_nz_abs            $A7AD                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A7A8  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $A7A9  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$A7AD  AC 55 A4                    host_call_simple         $A455 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$A7B0  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A7B3  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A7B6  DA                          bitand                                             ; regA = regA & regB
  $A7B7  D7 43 A8                    branch_nz_abs            $A843                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A7BA  A5 67 6F                    loadA_mem_byte           $6F67                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A7BD  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $A7C0  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A7C3  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $A7C4  D8 FD A7                    branch_z_abs             $A7FD                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A7C7  A5 68 6F                    loadA_mem_byte           $6F68                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A7CA  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $A7CB  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $A7CC  D8 D9 A7                    branch_z_abs             $A7D9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A7CF  8E 40 BF                    push_imm_word            $BF40                     ; "Disloyal troops\nhave revolted"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $A7D2  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A7D6  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$A7D9  A5 68 6F                    loadA_mem_byte           $6F68                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A7DC  D8 E3 A7                    branch_z_abs             $A7E3                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A7DF  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A7E0  D6 E4 A7                    jump_abs                 $A7E4                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$A7E3  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$A7E4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $A7E5  E9 E6 A5 02                 host_call                $A5E6 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A7E9  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A7EA  E9 B1 CB 02                 host_call                $CBB1 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A7EE  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A7F1  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A7F4  DA                          bitand                                             ; regA = regA & regB
  $A7F5  D7 FD A7                    branch_nz_abs            $A7FD                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A7F8  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $A7F9  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$A7FD  A4 79 6F                    loadA_mem_word           $6F79                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A800  D7 85 A7                    branch_nz_abs            $A785                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A803  AC 42 A7                    host_call_simple         $A742 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$A806  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $A807  E9 B1 CB 02                 host_call                $CBB1 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A80B  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A80E  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A811  DA                          bitand                                             ; regA = regA & regB
  $A812  D7 43 A8                    branch_nz_abs            $A843                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A815  A4 79 6F                    loadA_mem_word           $6F79                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $A818  D8 39 A8                    branch_z_abs             $A839                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $A81B  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $A81C  E9 B1 CB 02                 host_call                $CBB1 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $A820  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A823  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A826  DA                          bitand                                             ; regA = regA & regB
  $A827  D7 2F A8                    branch_nz_abs            $A82F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $A82A  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $A82B  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$A82F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $A830  A8 79 6F                    loadA_mem_word           $6F79                     ; regA = word read using <word> as address (handler $EA75)
  $A833  D6 06 A8                    jump_abs                 $A806                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
  ; ---- gap $A836-$A838 (3 bytes, not on any traced path) ----
 >$A839  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $A83C  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $A83F  DA                          bitand                                             ; regA = regA & regB
  $A840  D8 85 A7                    branch_z_abs             $A785                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$A843  AC 03 80                    host_call_simple         $8003 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $A846  D6 7D A7                    jump_abs                 $A77D                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)

; ==== summary ====
; 98 subroutines scanned; 5423 instructions decoded (5423 known + 0 unknown opcodes)
; 346 branch targets, 156 unique host_call targets
