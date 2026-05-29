VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes  (262144 bytes after header)
  mode:         bulk dump of bank 15
  opcode spec:  vm-opcodes.toml (256 of 256 opcodes defined)
  labels:       227 CPU addresses named

  bank 15: found 135 bytecode-subroutine stubs


; ============================================================
; sub $CA03   (frame_off=+0, body @ $CA08)
; ============================================================
  $CA08  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA09  A8 E5 7F                    loadA_mem_word           $7FE5                     ; regA = word read using <word> as address (handler $EA75)
  $CA0C  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $CA0D  E9 B1 CB 02                 host_call                $CBB1 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CA11  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CA12   (frame_off=+0, body @ $CA17)
; ============================================================
  $CA17  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CA18  A0 0D                       op_A0_A3_byte            $0D                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CA1A  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CA1B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CA1C  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA1D  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CA1E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $CA1F  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $CA20  D8 27 CA                    branch_z_abs             $CA27                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CA23  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CA24  D6 2F CA                    jump_abs                 $CA2F                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CA27  A0 0D                       op_A0_A3_byte            $0D                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CA29  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CA2A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CA2B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA2C  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CA2D  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $CA2E  BC                          sub                                                ; regA = regA - regB
 >$CA2F  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $CA30  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CA31   (frame_off=-2, body @ $CA36)
; ============================================================
  $CA36  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA37  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $CA38  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CA39  BC                          sub                                                ; regA = regA - regB
  $CA3A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CA3B  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $CA3C  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $CA3D  D8 42 CA                    branch_z_abs             $CA42                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CA40  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CA41  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$CA42  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CA43  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CA44  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $CA45  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CA46   (frame_off=+0, body @ $CA4B)
; ============================================================
  $CA4B  8D 11                       op_8D_sbyte              +17
  $CA4D  E9 26 F2 02                 host_call                $F226 (syscall_dispatch) {native}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CA51  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CA52 (ui_helper_ca52)   (frame_off=+0, body @ $CA57)
; ============================================================
  $CA57  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA58  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $CA59  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $CA5A  D8 5F CA                    branch_z_abs             $CA5F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CA5D  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CA5E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$CA5F  AC 46 CA                    host_call_simple         $CA46 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $CA62  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CA63  B9                          mod_signed                                         ; regA = regA % regB  (signed remainder)
  $CA64  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CA65   (frame_off=+0, body @ $CA6A)
; ============================================================
  $CA6A  89 30                       loadA_imm_sbyte          +48                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $CA6C  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CA6D  C7                          cmp_ule                                            ; regA = (regA <= regB) ? 1 : 0  (unsigned)
  $CA6E  D8 78 CA                    branch_z_abs             $CA78                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CA71  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA72  8B 39                       loadB_imm_byte           +57                       ; regB = byte literal (handler $EABE)
  $CA74  C7                          cmp_ule                                            ; regA = (regA <= regB) ? 1 : 0  (unsigned)
  $CA75  D7 7C CA                    branch_nz_abs            $CA7C                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$CA78  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CA79  D6 7D CA                    jump_abs                 $CA7D                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CA7C  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$CA7D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CA7E   (frame_off=-2, body @ $CA83)
; ============================================================
  $CA83  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CA84  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CA85  D6 90 CA                    jump_abs                 $CA90                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CA88  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA89  D0                          incA                                               ; regA += 1
  $CA8A  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CA8B  D1                          decA                                               ; regA -= 1
  $CA8C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CA8D  D0                          incA                                               ; regA += 1
  $CA8E  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CA8F  D1                          decA                                               ; regA -= 1
 >$CA90  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CA91  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CA92  D7 88 CA                    branch_nz_abs            $CA88                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CA95  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CA96  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CA97   (frame_off=+0, body @ $CA9C)
; ============================================================
  $CA9C  D6 AB CA                    jump_abs                 $CAAB                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CA9F  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAA0  D0                          incA                                               ; regA += 1
  $CAA1  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CAA2  D1                          decA                                               ; regA -= 1
  $CAA3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CAA4  A0 0F                       op_A0_A3_byte            $0F                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CAA6  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CAA7  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $CAA8  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAA9  D1                          decA                                               ; regA -= 1
  $CAAA  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
 >$CAAB  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAAC  D7 9F CA                    branch_nz_abs            $CA9F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CAAF  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CAB0   (frame_off=+0, body @ $CAB5)
; ============================================================
  $CAB5  D6 C7 CA                    jump_abs                 $CAC7                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CAB8  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAB9  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CABA  D7 BF CA                    branch_nz_abs            $CABF                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CABD  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CABE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$CABF  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAC0  D0                          incA                                               ; regA += 1
  $CAC1  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CAC2  D1                          decA                                               ; regA -= 1
  $CAC3  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAC4  D0                          incA                                               ; regA += 1
  $CAC5  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CAC6  D1                          decA                                               ; regA -= 1
 >$CAC7  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAC8  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CAC9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CACA  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CACB  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CACC  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $CACD  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $CACE  D7 B8 CA                    branch_nz_abs            $CAB8                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CAD1  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAD2  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CAD3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CAD4  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAD5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CAD6  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $CAD7  BC                          sub                                                ; regA = regA - regB
  $CAD8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CAD9   (frame_off=-2, body @ $CADE)
; ============================================================
  $CADE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CADF  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$CAE0  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAE1  D0                          incA                                               ; regA += 1
  $CAE2  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CAE3  D1                          decA                                               ; regA -= 1
  $CAE4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CAE5  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAE6  D0                          incA                                               ; regA += 1
  $CAE7  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CAE8  D1                          decA                                               ; regA -= 1
  $CAE9  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CAEA  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $CAEB  D7 E0 CA                    branch_nz_abs            $CAE0                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CAEE  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CAEF  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CAF0   (frame_off=+0, body @ $CAF5)
; ============================================================
  $CAF5  D6 0B CB                    jump_abs                 $CB0B                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CAF8  A0 0D                       op_A0_A3_byte            $0D                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CAFA  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CAFB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CAFC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CAFD  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CAFE  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $CAFF  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $CB00  D8 05 CB                    branch_z_abs             $CB05                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CB03  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB04  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$CB05  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB06  D0                          incA                                               ; regA += 1
  $CB07  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CB08  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB09  D1                          decA                                               ; regA -= 1
  $CB0A  2E                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
 >$CB0B  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB0C  D7 F8 CA                    branch_nz_abs            $CAF8                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CB0F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CB10  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CB11   (frame_off=+0, body @ $CB16)
; ============================================================
  $CB16  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CB18  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CB19  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CB1A  89 61                       loadA_imm_sbyte          +97                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $CB1C  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $CB1D  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $CB1E  D8 2A CB                    branch_z_abs             $CB2A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CB21  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CB23  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CB24  8B 7A                       loadB_imm_byte           +122                      ; regB = byte literal (handler $EABE)
  $CB26  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $CB27  D7 2E CB                    branch_nz_abs            $CB2E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$CB2A  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CB2B  D6 2F CB                    jump_abs                 $CB2F                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CB2E  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$CB2F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CB30   (frame_off=+0, body @ $CB35)
; ============================================================
  $CB35  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CB37  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CB38  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CB39  E9 11 CB 02                 host_call                $CB11 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CB3D  D8 48 CB                    branch_z_abs             $CB48                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CB40  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CB42  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CB43  8F E0                       addA_imm_sbyte           -32                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $CB45  D6 4B CB                    jump_abs                 $CB4B                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CB48  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CB4A  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
 >$CB4B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CB4C   (frame_off=+0, body @ $CB51)
; ============================================================
  $CB51  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB52  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $CB53  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $CB54  D8 5C CB                    branch_z_abs             $CB5C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CB57  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB58  CB                          op_CB                                              ; handler $EF09 region (TBD — negate-related)
  $CB59  D6 5D CB                    jump_abs                 $CB5D                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CB5C  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
 >$CB5D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CB5E (ui_helper_cb5e)   (frame_off=+0, body @ $CB63)
; ============================================================
  $CB63  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB64  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CB65  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $CB66  D8 6D CB                    branch_z_abs             $CB6D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CB69  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB6A  D6 6E CB                    jump_abs                 $CB6E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CB6D  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
 >$CB6E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CB6F   (frame_off=+0, body @ $CB74)
; ============================================================
  $CB74  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB75  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CB76  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $CB77  D8 7E CB                    branch_z_abs             $CB7E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CB7A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB7B  D6 7F CB                    jump_abs                 $CB7F                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CB7E  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
 >$CB7F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CB80   (frame_off=-1, body @ $CB85)
; ============================================================
  $CB85  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB86  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CB87  A2 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CB89  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CB8A  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CB8B  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB8C  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CB8D  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $CB8E  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CB8F  A0 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CB91  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CB92  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $CB93  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CB94   (frame_off=-2, body @ $CB99)
; ============================================================
  $CB99  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB9A  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $CB9B  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CB9C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CB9D  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CB9E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $CB9F  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $CBA0  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CBA1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CBA2  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $CBA3  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CBA4   (frame_off=+0, body @ $CBA9)
; ============================================================
  $CBA9  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CBAA  8D 15                       op_8D_sbyte              +21
  $CBAC  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CBB0  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CBB1   (frame_off=+0, body @ $CBB6)
; ============================================================
  $CBB6  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CBB7  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $CBB8  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CBBC  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CBBD   (frame_off=+0, body @ $CBC2)
; ============================================================
  $CBC2  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CBC3  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CBC4  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CBC5  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CBC6  8D 10                       op_8D_sbyte              +16
  $CBC8  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CBCC  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

  ; ---- gap $CBCD-$CC34 (104 bytes, not on any traced path) ----

; ============================================================
; sub $CC35 (marry_helper_cc35)   (frame_off=+0, body @ $CC3A)
; ============================================================
  $CC3A  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC3B  8D 12                       op_8D_sbyte              +18
  $CC3D  E9 26 F2 04                 host_call                $F226 (syscall_dispatch) {native}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CC41  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CC42   (frame_off=+0, body @ $CC47)
; ============================================================
  $CC47  87 13                       op_87_byte               $13
  $CC49  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC4A  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC4B  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC4C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC4D  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CC4E  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $CC4F  E9 26 F2 0E                 host_call                $F226 (syscall_dispatch) {native}, $0E ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CC53  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CC54   (frame_off=+0, body @ $CC59)
; ============================================================
  $CC59  87 15                       op_87_byte               $15
  $CC5B  87 13                       op_87_byte               $13
  $CC5D  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC5E  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC5F  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC60  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CC61  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CC62  8D 14                       op_8D_sbyte              +20
  $CC64  E9 26 F2 10                 host_call                $F226 (syscall_dispatch) {native}, $10 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CC68  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CC69 (trade_helper_cc69)   (frame_off=+0, body @ $CC6E)
; ============================================================
  $CC6E  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CC6F  8D 12                       op_8D_sbyte              +18
  $CC71  8D 1D                       op_8D_sbyte              +29
  $CC73  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $CC74  8D 16                       op_8D_sbyte              +22
  $CC76  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CC7A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CC7B (ui_helper_cc7b)   (frame_off=+0, body @ $CC80)
; ============================================================
  $CC80  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CC81  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  $CC84  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CC85  A8 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word read using <word> as address (handler $EA75)
  $CC88  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CC89 (ui_helper_cc89)   (frame_off=+0, body @ $CC8E)
; ============================================================
  $CC8E  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CC8F  8D 19                       op_8D_sbyte              +25
  $CC91  8D 13                       op_8D_sbyte              +19
  $CC93  A4 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CC96  D8 9E CC                    branch_z_abs             $CC9E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CC99  89 14                       loadA_imm_sbyte          +20                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $CC9B  D6 A0 CC                    jump_abs                 $CCA0                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CC9E  89 16                       loadA_imm_sbyte          +22                       ; regA = sign-extended signed byte literal (handler $EAAF)
 >$CCA0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CCA1  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $CCA2  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CCA6  A4 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CCA9  D8 B1 CC                    branch_z_abs             $CCB1                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CCAC  89 14                       loadA_imm_sbyte          +20                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $CCAE  D6 B3 CC                    jump_abs                 $CCB3                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CCB1  89 16                       loadA_imm_sbyte          +22                       ; regA = sign-extended signed byte literal (handler $EAAF)
 >$CCB3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CCB4  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $CCB5  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CCB9  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CCBA   (frame_off=+0, body @ $CCBF)
; ============================================================
  $CCBF  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CCC0  8D 19                       op_8D_sbyte              +25
  $CCC2  8D 1D                       op_8D_sbyte              +29
  $CCC4  8D 14                       op_8D_sbyte              +20
  $CCC6  8D 14                       op_8D_sbyte              +20
  $CCC8  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CCCC  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CCCD  A8 F9 7B                    loadA_mem_word           $7BF9                     ; regA = word read using <word> as address (handler $EA75)
  $CCD0  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CCD1   (frame_off=+0, body @ $CCD6)
; ============================================================
  $CCD6  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CCD7  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $CCD8  8D 1D                       op_8D_sbyte              +29
  $CCDA  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $CCDB  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $CCDC  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CCE0  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CCE1   (frame_off=+0, body @ $CCE6)
; ============================================================
  $CCE6  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CCE7  8D 1A                       op_8D_sbyte              +26
  $CCE9  8D 1D                       op_8D_sbyte              +29
  $CCEB  8D 1A                       op_8D_sbyte              +26
  $CCED  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $CCEE  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CCF2  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $CCF5  A8 DF 7F                    loadA_mem_word           $7FDF                     ; regA = word read using <word> as address (handler $EA75)
  $CCF8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CCF9   (frame_off=+0, body @ $CCFE)
; ============================================================
  $CCFE  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CCFF  8D 13                       op_8D_sbyte              +19
  $CD01  8D 1F                       op_8D_sbyte              +31
  $CD03  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CD04  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CD05  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD09  A4 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CD0C  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $CD0F  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $CD10  D8 1F CD                    branch_z_abs             $CD1F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CD13  A4 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CD16  A8 E6 7B                    loadA_mem_word           $7BE6                     ; regA = word read using <word> as address (handler $EA75)
  $CD19  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $CD1C  A8 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word read using <word> as address (handler $EA75)
 >$CD1F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CD20 (ui_helper_cd20)   (frame_off=-2, body @ $CD25)
; ============================================================
  $CD25  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CD26  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD2A  AC 50 CF                    host_call_simple         $CF50 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $CD2D  AC 5D CF                    host_call_simple         $CF5D {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $CD30  A4 C9 7F                    loadA_mem_word           $7FC9                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CD33  D8 4F CD                    branch_z_abs             $CD4F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CD36  8D 21                       op_8D_sbyte              +33
  $CD38  67                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 7)
  $CD39  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD3D  8D 30                       op_8D_sbyte              +48
  $CD3F  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $CD40  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD44  8D 30                       op_8D_sbyte              +48
  $CD46  6F                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 15)
  $CD47  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD4B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CD4C  A8 C9 7F                    loadA_mem_word           $7FC9                     ; regA = word read using <word> as address (handler $EA75)
 >$CD4F  A4 C7 7F                    loadA_mem_word           $7FC7                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CD52  D8 7E CD                    branch_z_abs             $CD7E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CD55  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CD56  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$CD57  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CD58  D2                          aslA                                               ; regA <<= 1
  $CD59  8C 7A F6                    loadB_imm_word           $F67A                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $CD5C  BB                          add                                                ; regA = regA + regB
  $CD5D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $CD5E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CD5F  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $CD60  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD64  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CD65  D0                          incA                                               ; regA += 1
  $CD66  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CD67  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CD68  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $CD69  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $CD6A  D7 57 CD                    branch_nz_abs            $CD57                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CD6D  8D 24                       op_8D_sbyte              +36
  $CD6F  8E B0 15                    push_imm_word            $15B0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $CD72  8E 5C 84                    push_imm_word            $845C                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $CD75  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CD76  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD7A  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CD7B  A8 C7 7F                    loadA_mem_word           $7FC7                     ; regA = word read using <word> as address (handler $EA75)
 >$CD7E  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CD7F  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CD83  A4 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CD86  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $CD89  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $CD8A  D8 99 CD                    branch_z_abs             $CD99                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CD8D  A4 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CD90  A8 E6 7B                    loadA_mem_word           $7BE6                     ; regA = word read using <word> as address (handler $EA75)
  $CD93  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $CD96  A8 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word read using <word> as address (handler $EA75)
 >$CD99  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $CD9C  A8 DF 7F                    loadA_mem_word           $7FDF                     ; regA = word read using <word> as address (handler $EA75)
  $CD9F  8D 14                       op_8D_sbyte              +20
  $CDA1  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $CDA2  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CDA6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CDA7  A8 F9 7B                    loadA_mem_word           $7BF9                     ; regA = word read using <word> as address (handler $EA75)
  $CDAA  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CDAB  A8 FB 7B                    loadA_mem_word           $7BFB                     ; regA = word read using <word> as address (handler $EA75)
  $CDAE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CDAF   (frame_off=+0, body @ $CDB4)
; ============================================================
  $CDB4  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $CDB5  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  $CDB8  A4 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CDBB  D0                          incA                                               ; regA += 1
  $CDBC  A8 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word read using <word> as address (handler $EA75)
  $CDBF  8B 1B                       loadB_imm_byte           +27                       ; regB = byte literal (handler $EABE)
  $CDC1  C8                          cmp_ugt                                            ; regA = (regA > regB) ? 1 : 0   (unsigned)
  $CDC2  D8 C9 CD                    branch_z_abs             $CDC9                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CDC5  43                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $CDC6  A8 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word read using <word> as address (handler $EA75)
 >$CDC9  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CDCA   (frame_off=+0, body @ $CDCF)
; ============================================================
  $CDCF  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CDD1  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CDD2  8B 5F                       loadB_imm_byte           +95                       ; regB = byte literal (handler $EABE)
  $CDD4  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $CDD5  D8 F4 CD                    branch_z_abs             $CDF4                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CDD8  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CDDA  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CDDB  8B 7A                       loadB_imm_byte           +122                      ; regB = byte literal (handler $EABE)
  $CDDD  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $CDDE  D8 F4 CD                    branch_z_abs             $CDF4                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CDE1  89 2F                       loadA_imm_sbyte          +47                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $CDE3  D6 11 CE                    jump_abs                 $CE11                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CDE6  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CDE8  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CDE9  8B 5A                       loadB_imm_byte           +90                       ; regB = byte literal (handler $EABE)
  $CDEB  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $CDEC  D8 FD CD                    branch_z_abs             $CDFD                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CDEF  89 2B                       loadA_imm_sbyte          +43                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $CDF1  D6 11 CE                    jump_abs                 $CE11                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CDF4  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CDF6  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CDF7  8B 41                       loadB_imm_byte           +65                       ; regB = byte literal (handler $EABE)
  $CDF9  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $CDFA  D7 E6 CD                    branch_nz_abs            $CDE6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$CDFD  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CDFF  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE00  8B 2D                       loadB_imm_byte           +45                       ; regB = byte literal (handler $EABE)
  $CE02  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $CE03  D8 1D CE                    branch_z_abs             $CE1D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CE06  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE08  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE09  8B 3A                       loadB_imm_byte           +58                       ; regB = byte literal (handler $EABE)
  $CE0B  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $CE0C  D8 1D CE                    branch_z_abs             $CE1D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CE0F  89 28                       loadA_imm_sbyte          +40                       ; regA = sign-extended signed byte literal (handler $EAAF)
 >$CE11  CD                          swap_AB                                            ; regA <-> regB
  $CE12  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE14  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE15  BC                          sub                                                ; regA = regA - regB
  $CE16  A2 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE18  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE19  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE1B  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE1C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$CE1D  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE1F  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE20  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $CE21  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CE22  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE23  20                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 0)
  $CE24  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE25  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $CE26  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE27  21                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 1)
  $CE28  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE29  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $CE2A  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE2B  23                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 3)
  $CE2C  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE2D  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $CE2E  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE2F  25                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 5)
  $CE30  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE31  5F                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 15)
  $CE32  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE33  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $CE34  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE35  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CE36  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE37  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $CE38  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE39  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CE3A  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE3B  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $CE3C  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE3D  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $CE3E  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE3F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CE40  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE41  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $CE42  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE43  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CE44  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE45  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $CE46  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE47  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CE48  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE49  73                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 3)
  $CE4A  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE4B  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CE4C  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE4D  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $CE4E  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE4F  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CE50  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE51  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $CE52  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE53  7D                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 13)
  $CE54  CE                          trigger_syscall_CE                                 ; BRK to syscall_dispatch (handler $EF92)
  $CE55  89 1F                       loadA_imm_sbyte          +31                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $CE57  D6 11 CE                    jump_abs                 $CE11                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)

  ; ---- gap $CE5A-$CE80 (39 bytes, not on any traced path) ----

; ============================================================
; sub $CE81   (frame_off=+0, body @ $CE86)
; ============================================================
  $CE86  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE88  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE89  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $CE8A  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $CE8B  D8 92 CE                    branch_z_abs             $CE92                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CE8E  AC AF CD                    host_call_simple         $CDAF {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $CE91  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$CE92  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE94  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE95  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CE96  E9 CA CD 02                 host_call                $CDCA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CE9A  A2 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE9C  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CE9D  A0 0B                       op_A0_A3_byte            $0B                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CE9F  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $CEA0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CEA1  AA CF 7F AA                 op_AA_wb                 $7FCF, $AA
  $CEA5  CD                          swap_AB                                            ; regA <-> regB
  $CEA6  7F                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 15)
  $CEA7  AA CF 7F AA                 op_AA_wb                 $7FCF, $AA
  $CEAB  CD                          swap_AB                                            ; regA <-> regB
  $CEAC  7F                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 15)
  $CEAD  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CEAE  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $CEAF  E9 26 F2 0E                 host_call                $F226 (syscall_dispatch) {native}, $0E ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CEB3  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CEB6  D0                          incA                                               ; regA += 1
  $CEB7  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  $CEBA  8B 1F                       loadB_imm_byte           +31                       ; regB = byte literal (handler $EABE)
  $CEBC  C8                          cmp_ugt                                            ; regA = (regA > regB) ? 1 : 0   (unsigned)
  $CEBD  D8 C3 CE                    branch_z_abs             $CEC3                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CEC0  AC AF CD                    host_call_simple         $CDAF {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$CEC3  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CEC4 (redraw_window)   (frame_off=-37, body @ $CEC9)
; ============================================================
  $CEC9  D6 1E CF                    jump_abs                 $CF1E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CECC  A0 FD                       op_A0_A3_byte            $FD                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CECE  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CECF  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $CED0  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $CED1  D8 EC CE                    branch_z_abs             $CEEC                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CED4  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CED5  A6 CD 7F                    loadB_mem_word           $7FCD                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $CED8  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $CED9  D8 1B CF                    branch_z_abs             $CF1B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CEDC  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CEDD  DE DB                       loadA_frameaddr          $DB                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $CEDF  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CEE0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CEE1  AA CF 7F A4                 op_AA_wb                 $7FCF, $A4
  $CEE5  CD                          swap_AB                                            ; regA <-> regB
  $CEE6  7F                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 15)
  $CEE7  D1                          decA                                               ; regA -= 1
  $CEE8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CEE9  D6 13 CF                    jump_abs                 $CF13                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CEEC  81 FB                       op_81_byte               $FB
  $CEEE  D0                          incA                                               ; regA += 1
  $CEEF  85 FB                       op_85_byte               $FB
  $CEF1  D1                          decA                                               ; regA -= 1
  $CEF2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CEF3  A0 FD                       op_A0_A3_byte            $FD                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CEF5  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CEF6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CEF7  E9 CA CD 02                 host_call                $CDCA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CEFB  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $CEFC  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CEFF  D0                          incA                                               ; regA += 1
  $CF00  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  ; ---- overlap: $CF02 re-entered mid-stream ----
 >$CF02  7F                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 15)
  $CF03  8B 20                       loadB_imm_byte           +32                       ; regB = byte literal (handler $EABE)
  $CF05  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $CF06  D8 27 CF                    branch_z_abs             $CF27                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CF09  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CF0A  DE DB                       loadA_frameaddr          $DB                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $CF0C  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CF0D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CF0E  AA CF 7F 8D                 op_AA_wb                 $7FCF, $8D
  $CF12  1F                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
 >$CF13  AA CF 7F 3B                 op_AA_wb                 $7FCF, $3B
  $CF17  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$CF1B  AC AF CD                    host_call_simple         $CDAF {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$CF1E  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $CF21  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CF22  DE DB                       loadA_frameaddr          $DB                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $CF24  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CF25  85 FB                       op_85_byte               $FB
 >$CF27  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CF28  D0                          incA                                               ; regA += 1
  $CF29  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $CF2A  D1                          decA                                               ; regA -= 1
  $CF2B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CF2C  A2 FD                       op_A0_A3_byte            $FD                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CF2E  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CF2F  D7 CC CE                    branch_nz_abs            $CECC                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CF32  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CF33  A6 CD 7F                    loadB_mem_word           $7FCD                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $CF36  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $CF37  D8 4F CF                    branch_z_abs             $CF4F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CF3A  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CF3B  DE DB                       loadA_frameaddr          $DB                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $CF3D  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CF3E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CF3F  AA CF 7F A4                 op_AA_wb                 $7FCF, $A4
  $CF43  CD                          swap_AB                                            ; regA <-> regB
  $CF44  7F                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 15)
  $CF45  D1                          decA                                               ; regA -= 1
  $CF46  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CF47  AA CF 7F 3B                 op_AA_wb                 $7FCF, $3B
  $CF4B  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$CF4F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CF50   (frame_off=+0, body @ $CF55)
; ============================================================
  $CF55  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CF56  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CF57  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $CF58  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CF5C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CF5D   (frame_off=+0, body @ $CF62)
; ============================================================
  $CF62  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CF63  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CF64  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $CF65  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CF69  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CF6A   (frame_off=+0, body @ $CF6F)
; ============================================================
  $CF6F  87 13                       op_87_byte               $13
  $CF71  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF72  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF73  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF74  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF75  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $CF76  6D                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 13)
  $CF77  E9 26 F2 0E                 host_call                $F226 (syscall_dispatch) {native}, $0E ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CF7B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CF7C   (frame_off=+0, body @ $CF81)
; ============================================================
  $CF81  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF82  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF83  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF84  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF85  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $CF86  E9 26 F2 0A                 host_call                $F226 (syscall_dispatch) {native}, $0A ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CF8A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CF8B   (frame_off=+0, body @ $CF90)
; ============================================================
  $CF90  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF91  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CF92  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $CF93  E9 26 F2 06                 host_call                $F226 (syscall_dispatch) {native}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CF97  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CF98   (frame_off=-2, body @ $CF9D)
; ============================================================
  $CF9D  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CF9E  1E                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CF9F  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $CFA0  D8 BC CF                    branch_z_abs             $CFBC                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CFA3  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFA4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CFA5  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $CFA6  D0                          incA                                               ; regA += 1
  $CFA7  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $CFA8  D1                          decA                                               ; regA -= 1
  $CFA9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CFAA  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFAB  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $CFAC  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $CFAD  D8 B6 CF                    branch_z_abs             $CFB6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $CFB0  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFB1  8F 30                       addA_imm_sbyte           +48                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $CFB3  D6 B9 CF                    jump_abs                 $CFB9                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CFB6  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFB7  8F 37                       addA_imm_sbyte           +55                       ; regA += sign-extended signed byte literal (handler $EAD9)
 >$CFB9  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $CFBA  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $CFBB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$CFBC  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CFBD  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFBE  1E                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CFBF  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $CFC0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CFC1  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CFC2  E9 98 CF 06                 host_call                $CF98 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CFC6  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CFC7  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CFC8  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFC9  1E                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $CFCA  BA                          mod_unsigned                                       ; regA = regA % regB  (unsigned remainder)
  $CFCB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CFCC  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $CFCD  E9 98 CF 06                 host_call                $CF98 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $CFD1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CFD2  D0                          incA                                               ; regA += 1
  $CFD3  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CFD4   (frame_off=-3, body @ $CFD9)
; ============================================================
  $CFD9  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $CFDA  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CFDB  D6 ED CF                    jump_abs                 $CFED                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$CFDE  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CFDF  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $CFE0  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $CFE1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CFE2  A0 FD                       op_A0_A3_byte            $FD                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CFE4  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CFE5  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $CFE6  BB                          add                                                ; regA = regA + regB
  $CFE7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $CFE8  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFE9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $CFEA  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $CFEB  D0                          incA                                               ; regA += 1
  $CFEC  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$CFED  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $CFEE  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $CFEF  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $CFF0  8F D0                       addA_imm_sbyte           -48                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $CFF2  A2 FD                       op_A0_A3_byte            $FD                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $CFF4  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $CFF5  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $CFF6  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $CFF7  D7 DE CF                    branch_nz_abs            $CFDE                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $CFFA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $CFFB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $CFFC   (frame_off=-23, body @ $D001)
; ============================================================
  $D001  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D002  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $D003  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $D004  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $D006  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D007  85 FD                       op_85_byte               $FD
  $D009  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D00A  85 E9                       op_85_byte               $E9
  $D00C  D6 18 D0                    jump_abs                 $D018                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D00F  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D010  D0                          incA                                               ; regA += 1
  $D011  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $D012  D1                          decA                                               ; regA -= 1
  $D013  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D014  A0 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D016  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D017  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$D018  81 FD                       op_81_byte               $FD
  $D01A  D0                          incA                                               ; regA += 1
  $D01B  85 FD                       op_85_byte               $FD
  $D01D  D1                          decA                                               ; regA -= 1
  $D01E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D01F  A2 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D021  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D022  D8 30 D1                    branch_z_abs             $D130                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D025  A0 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D027  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D028  8B 25                       loadB_imm_byte           +37                       ; regB = byte literal (handler $EABE)
  $D02A  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D02B  D8 0F D0                    branch_z_abs             $D00F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D02E  DE F3                       loadA_frameaddr          $F3                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D030  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D031  85 F1                       op_85_byte               $F1
  $D033  46                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D034  85 EB                       op_85_byte               $EB
  $D036  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D037  85 EF                       op_85_byte               $EF
  $D039  81 FD                       op_81_byte               $FD
  $D03B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D03C  A2 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D03E  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D03F  A0 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D041  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D042  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D043  E9 65 CA 02                 host_call                $CA65 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D047  D8 55 D0                    branch_z_abs             $D055                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D04A  DE FD                       loadA_frameaddr          $FD                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D04C  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D04D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D04E  E9 D4 CF 02                 host_call                $CFD4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D052  D6 56 D0                    jump_abs                 $D056                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D055  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$D056  85 ED                       op_85_byte               $ED
  $D058  81 FD                       op_81_byte               $FD
  $D05A  D0                          incA                                               ; regA += 1
  $D05B  85 FD                       op_85_byte               $FD
  $D05D  D1                          decA                                               ; regA -= 1
  $D05E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D05F  A2 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D061  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D062  8B 2E                       loadB_imm_byte           +46                       ; regB = byte literal (handler $EABE)
  $D064  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D065  D8 7F D0                    branch_z_abs             $D07F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D068  DE FD                       loadA_frameaddr          $FD                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D06A  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D06B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D06C  E9 D4 CF 02                 host_call                $CFD4 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D070  85 EB                       op_85_byte               $EB
  $D072  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D073  85 EF                       op_85_byte               $EF
  $D075  81 FD                       op_81_byte               $FD
  $D077  D0                          incA                                               ; regA += 1
  $D078  85 FD                       op_85_byte               $FD
  $D07A  D1                          decA                                               ; regA -= 1
  $D07B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D07C  A2 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D07E  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
 >$D07F  A0 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $D081  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D082  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D083  E9 30 CB 02                 host_call                $CB30 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D087  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $D088  04                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 4)
  $D089  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D08A  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D08B  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D08C  2F                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $D08D  D1                          decA                                               ; regA -= 1
  $D08E  43                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D08F  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D090  D0                          incA                                               ; regA += 1
  $D091  D0                          incA                                               ; regA += 1
  $D092  44                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D093  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D094  9C                          trigger_syscall_9X                                 ; BRK to syscall_dispatch (handler $EF92)
  $D095  D0                          incA                                               ; regA += 1
  $D096  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $D097  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D098  B7 D0                       ext_op                   $D0                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D09A  0F                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D09B  D0                          incA                                               ; regA += 1
  $D09C  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $D09D  81 E9                       op_81_byte               $E9
  $D09F  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $D0A0  85 E9                       op_85_byte               $E9
  $D0A2  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $D0A4  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D0A5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D0A6  DE F1                       loadA_frameaddr          $F1                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D0A8  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D0A9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D0AA  E9 98 CF 06                 host_call                $CF98 {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D0AE  CD                          swap_AB                                            ; regA <-> regB
  $D0AF  81 ED                       op_81_byte               $ED
  $D0B1  BC                          sub                                                ; regA = regA - regB
  $D0B2  85 ED                       op_85_byte               $ED
  $D0B4  D6 E5 D0                    jump_abs                 $D0E5                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
  ; ---- gap $D0B7-$D0E4 (46 bytes, not on any traced path) ----
 >$D0E5  87 F1                       op_87_byte               $F1
  $D0E7  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D0E8  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $D0E9  DE F3                       loadA_frameaddr          $F3                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D0EB  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D0EC  85 F1                       op_85_byte               $F1
  $D0EE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D0EF  85 EF                       op_85_byte               $EF
  $D0F1  D6 FC D0                    jump_abs                 $D0FC                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D0F4  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D0F5  D0                          incA                                               ; regA += 1
  $D0F6  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $D0F7  D1                          decA                                               ; regA -= 1
  $D0F8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D0F9  89 20                       loadA_imm_sbyte          +32                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $D0FB  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$D0FC  81 ED                       op_81_byte               $ED
  $D0FE  D1                          decA                                               ; regA -= 1
  $D0FF  85 ED                       op_85_byte               $ED
  $D101  D0                          incA                                               ; regA += 1
  $D102  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $D103  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D104  D7 F4 D0                    branch_nz_abs            $D0F4                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$D107  81 F1                       op_81_byte               $F1
  $D109  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D10A  D8 18 D0                    branch_z_abs             $D018                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D10D  81 EF                       op_81_byte               $EF
  $D10F  D8 19 D1                    branch_z_abs             $D119                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D112  81 EB                       op_81_byte               $EB
  $D114  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $D115  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D116  D8 27 D1                    branch_z_abs             $D127                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$D119  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D11A  D0                          incA                                               ; regA += 1
  $D11B  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $D11C  D1                          decA                                               ; regA -= 1
  $D11D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D11E  81 F1                       op_81_byte               $F1
  $D120  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D121  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $D122  81 EB                       op_81_byte               $EB
  $D124  D1                          decA                                               ; regA -= 1
  $D125  85 EB                       op_85_byte               $EB
 >$D127  81 F1                       op_81_byte               $F1
  $D129  D0                          incA                                               ; regA += 1
  $D12A  85 F1                       op_85_byte               $F1
  $D12C  D6 07 D1                    jump_abs                 $D107                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
  ; ---- gap $D12F-$D12F (1 bytes, not on any traced path) ----
 >$D130  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D131  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D132  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $D133  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D134 (ui_helper_d134)   (frame_off=-150, body @ $D139)
; ============================================================
  $D139  DE 6A                       loadA_frameaddr          $6A                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D13B  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D13C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D13D  DE 0B                       loadA_frameaddr          $0B                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D13F  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D140  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D141  E9 FC CF 04                 host_call                $CFFC {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D145  DE 6A                       loadA_frameaddr          $6A                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D147  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D148  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D149  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D14D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D14E   (frame_off=-8, body @ $D153)
; ============================================================
  $D153  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D154  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D155  A4 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D158  D5                          switch                                             ; Jump-table dispatch on regA (handler $EC65) — reads inline (value,target) pairs from the bytecode stream, jumps to the matching target. Variable-length; the disassembler stops the fall-through run here.

  ; ---- gap $D159-$D286 (302 bytes, not on any traced path) ----

; ============================================================
; sub $D287   (frame_off=-2, body @ $D28C)
; ============================================================
 >$D28C  AC 4E D1                    host_call_simple         $D14E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D28F  D7 8C D2                    branch_nz_abs            $D28C                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D292  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D293  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$D294  AC 4E D1                    host_call_simple         $D14E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D297  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D298  D8 94 D2                    branch_z_abs             $D294                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D29B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D29C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D29D   (frame_off=+0, body @ $D2A2)
; ============================================================
  $D2A2  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D2A3  D8 AB D2                    branch_z_abs             $D2AB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D2A6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D2A7  D1                          decA                                               ; regA -= 1
  $D2A8  D6 AC D2                    jump_abs                 $D2AC                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D2AB  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$D2AC  A8 E7 7F                    loadA_mem_word           $7FE7                     ; regA = word read using <word> as address (handler $EA75)
  $D2AF  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D2B0  D7 CA D2                    branch_nz_abs            $D2CA                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D2B3  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $D2B4  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $D2B5  8E F8 00                    push_imm_word            $00F8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D2B8  8E F8 00                    push_imm_word            $00F8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D2BB  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $D2BC  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $D2BD  E9 26 F2 0C                 host_call                $F226 (syscall_dispatch) {native}, $0C ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D2C1  8D 13                       op_8D_sbyte              +19
  $D2C3  E9 26 F2 02                 host_call                $F226 (syscall_dispatch) {native}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D2C7  D6 F8 D2                    jump_abs                 $D2F8                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D2CA  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D2CB  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $D2CC  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D2CD  D8 DB D2                    branch_z_abs             $D2DB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D2D0  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $D2D1  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $D2D2  8E F8 00                    push_imm_word            $00F8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D2D5  8E F8 00                    push_imm_word            $00F8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D2D8  D6 EC D2                    jump_abs                 $D2EC                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D2DB  AA E7 7F 60                 op_AA_wb                 $7FE7, $60
  $D2DF  A4 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D2E2  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $D2E3  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $D2E4  D1                          decA                                               ; regA -= 1
  $D2E5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D2E6  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D2E9  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $D2EA  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $D2EB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
 >$D2EC  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $D2ED  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $D2EE  E9 26 F2 0C                 host_call                $F226 (syscall_dispatch) {native}, $0C ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D2F2  8A C8 00                    loadA_imm_word           $00C8                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $D2F5  A8 E9 7F                    loadA_mem_word           $7FE9 (frame_counter)     ; regA = word read using <word> as address (handler $EA75)
 >$D2F8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D2F9   (frame_off=+0, body @ $D2FE)
; ============================================================
  $D2FE  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $D2FF  8D 13                       op_8D_sbyte              +19
  $D301  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $D302  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $D303  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $D304  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D308  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D309   (frame_off=+0, body @ $D30E)
; ============================================================
  $D30E  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $D30F  8D 1A                       op_8D_sbyte              +26
  $D311  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $D312  8D 14                       op_8D_sbyte              +20
  $D314  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $D315  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D319  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D31A   (frame_off=+0, body @ $D31F)
; ============================================================
  $D31F  AC 59 D7                    host_call_simple         $D759 (ui_helper_d759) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D322  AC 09 D3                    host_call_simple         $D309 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D325  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D326 (message_display)   (frame_off=+0, body @ $D32B)
; ============================================================
  $D32B  A4 C5 7F                    loadA_mem_word           $7FC5                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D32E  D8 38 D3                    branch_z_abs             $D338                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D331  AC 09 D3                    host_call_simple         $D309 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D334  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D335  A8 C5 7F                    loadA_mem_word           $7FC5                     ; regA = word read using <word> as address (handler $EA75)
 >$D338  A4 D1 7F                    loadA_mem_word           $7FD1                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D33B  D8 43 D3                    branch_z_abs             $D343                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D33E  89 14                       loadA_imm_sbyte          +20                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $D340  D6 45 D3                    jump_abs                 $D345                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D343  89 16                       loadA_imm_sbyte          +22                       ; regA = sign-extended signed byte literal (handler $EAAF)
 >$D345  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D346  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $D347  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D34B  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D34C  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D350  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D351 (ui_helper_d351)   (frame_off=-2, body @ $D356)
; ============================================================
  $D356  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D357  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D35B  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $D35C  E9 9D D2 02                 host_call                $D29D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$D360  AC 87 D2                    host_call_simple         $D287 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D363  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D364  8B 40                       loadB_imm_byte           +64                       ; regB = byte literal (handler $EABE)
  $D366  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $D367  D8 78 D3                    branch_z_abs             $D378                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D36A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D36B  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D36E  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $D36F  D8 78 D3                    branch_z_abs             $D378                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D372  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D373  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $D374  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $D375  D7 60 D3                    branch_nz_abs            $D360                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$D378  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $D379  E9 9D D2 02                 host_call                $D29D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D37D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D37E  8B 40                       loadB_imm_byte           +64                       ; regB = byte literal (handler $EABE)
  $D380  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D381  D8 8E D3                    branch_z_abs             $D38E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D384  8D 3C                       op_8D_sbyte              +60
  $D386  E9 81 CE 02                 host_call                $CE81 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D38A  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D38B  D6 A1 D3                    jump_abs                 $D3A1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D38E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D38F  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D392  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D393  D8 A0 D3                    branch_z_abs             $D3A0                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D396  8D 3E                       op_8D_sbyte              +62
  $D398  E9 81 CE 02                 host_call                $CE81 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D39C  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D39D  D6 A1 D3                    jump_abs                 $D3A1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D3A0  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$D3A1  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D3A2  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D3A5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D3A6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D3A7 (ui_helper_d3a7)   (frame_off=-2, body @ $D3AC)
; ============================================================
  $D3AC  8E 95 F6                    push_imm_word            $F695                     ; "\n(Y/N)? "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D3AF  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D3B3  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $D3B4  E9 9D D2 02                 host_call                $D29D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$D3B8  AC 87 D2                    host_call_simple         $D287 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D3BB  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D3BC  8B 40                       loadB_imm_byte           +64                       ; regB = byte literal (handler $EABE)
  $D3BE  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $D3BF  D8 CA D3                    branch_z_abs             $D3CA                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D3C2  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D3C3  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D3C6  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $D3C7  D7 B8 D3                    branch_nz_abs            $D3B8                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$D3CA  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $D3CB  E9 9D D2 02                 host_call                $D29D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D3CF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D3D0  8B 40                       loadB_imm_byte           +64                       ; regB = byte literal (handler $EABE)
  $D3D2  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D3D3  D8 E0 D3                    branch_z_abs             $D3E0                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D3D6  8D 59                       op_8D_sbyte              +89
  $D3D8  E9 81 CE 02                 host_call                $CE81 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D3DC  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D3DD  D6 E7 D3                    jump_abs                 $D3E7                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D3E0  8D 4E                       op_8D_sbyte              +78
  $D3E2  E9 81 CE 02                 host_call                $CE81 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D3E6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$D3E7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D3E8  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D3EB  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D3EC  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D3ED   (frame_off=-20, body @ $D3F2)
; ============================================================
  $D3F2  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D3F3  24                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 4)
  $D3F4  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D3F5  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $D3F6  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D3F7  25                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 5)
 >$D3F8  DE F4                       loadA_frameaddr          $F4                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $D3FA  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $D3FB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D3FC  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $D3FD  D2                          aslA                                               ; regA <<= 1
  $D3FE  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D3FF  BB                          add                                                ; regA = regA + regB
  $D400  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D401  8A FF 00                    loadA_imm_word           $00FF                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $D404  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D405  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $D406  D0                          incA                                               ; regA += 1
  $D407  25                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 5)
  $D408  05                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 5)
  $D409  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $D40A  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $D40B  D7 F8 D3                    branch_nz_abs            $D3F8                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D40E  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $D40F  8E 9E F6                    push_imm_word            $F69E                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D412  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D416  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D419  D1                          decA                                               ; regA -= 1
  $D41A  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  $D41D  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $D41E  E9 9D D2 02                 host_call                $D29D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D422  AC 87 D2                    host_call_simple         $D287 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D425  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D426  22                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 2)
  $D427  AC 4E D1                    host_call_simple         $D14E {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D42A  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $D42B  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $D42C  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D42D  01                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 1)
  $D42E  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D42F  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $D430  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $D431  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $D432  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D433  47                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D434  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $D435  10                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 0)
  $D436  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D437  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $D438  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $D439  20                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 0)
  $D43A  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D43B  AF D4                       op_AF_byte               $D4
  $D43D  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D43E  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D43F  DB                          bitor                                              ; regA = regA | regB
  $D440  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $D441  80                          trigger_syscall_80                                 ; BRK to syscall_dispatch (handler $EF92, shared with 36 other opcodes)
  $D442  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D443  11                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 1)
  $D444  D5                          switch                                             ; Jump-table dispatch on regA (handler $EC65) — reads inline (value,target) pairs from the bytecode stream, jumps to the matching target. Variable-length; the disassembler stops the fall-through run here.

  ; ---- gap $D445-$D585 (321 bytes, not on any traced path) ----

; ============================================================
; sub $D586   (frame_off=-2, body @ $D58B)
; ============================================================
  $D58B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D58C  D6 96 D5                    jump_abs                 $D596                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D58F  4A                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D590  CD                          swap_AB                                            ; regA <-> regB
  $D591  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D592  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $D593  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $D594  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D595  D0                          incA                                               ; regA += 1
 >$D596  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D597  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D598  D7 8F D5                    branch_nz_abs            $D58F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D59B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D59C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D59D   (frame_off=-10, body @ $D5A2)
; ============================================================
  $D5A2  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D5A3  E9 86 D5 02                 host_call                $D586 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D5A7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D5A8  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D5AB  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $D5AC  A4 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D5AF  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
 >$D5B0  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $D5B1  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $D5B2  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D5B6  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D5B7  D6 C2 D5                    jump_abs                 $D5C2                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D5BA  8D 20                       op_8D_sbyte              +32
  $D5BC  E9 81 CE 02                 host_call                $CE81 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D5C0  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D5C1  D0                          incA                                               ; regA += 1
 >$D5C2  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $D5C3  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D5C4  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $D5C5  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $D5C6  D7 BA D5                    branch_nz_abs            $D5BA                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D5C9  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $D5CA  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $D5CB  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D5CF  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $D5D0  E9 ED D3 02                 host_call                $D3ED {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D5D4  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $D5D5  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D5D6  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $D5D7  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $D5D8  D7 E7 D5                    branch_nz_abs            $D5E7                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D5DB  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D5DC  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $D5DD  C5                          cmp_sle                                            ; regA = (regA <= regB) ? 1 : 0  (signed)
  $D5DE  D8 B0 D5                    branch_z_abs             $D5B0                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D5E1  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D5E2  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $D5E3  C3                          cmp_sge                                            ; regA = (regA >= regB) ? 1 : 0  (signed)
  $D5E4  D8 B0 D5                    branch_z_abs             $D5B0                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$D5E7  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D5E8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D5E9 (number_input)   (frame_off=-2, body @ $D5EE)
; ============================================================
  $D5EE  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D5EF  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D5F0  8E AC F6                    push_imm_word            $F6AC                     ; "\n(%d-%d)? "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D5F3  E9 34 D1 06                 host_call                $D134 (ui_helper_d134) {bytecode}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D5F7  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D5F8  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D5F9  E9 9D D5 04                 host_call                $D59D {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D5FD  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D5FE  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D5FF  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $D600  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D601  D8 07 D6                    branch_z_abs             $D607                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D604  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$D607  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D608  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D609   (frame_off=-2, body @ $D60E)
; ============================================================
  $D60E  8D 1A                       op_8D_sbyte              +26
  $D610  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $D611  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D615  8E B7 F6                    push_imm_word            $F6B7                     ; "Hit any key"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D618  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D61C  AC 87 D2                    host_call_simple         $D287 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D61F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D620  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D623  AC E1 CC                    host_call_simple         $CCE1 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D626  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D627  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D628   (frame_off=-4, body @ $D62D)
; ============================================================
  $D62D  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D62E  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $D62F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D630  D6 4E D6                    jump_abs                 $D64E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D633  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D634  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D637  BB                          add                                                ; regA = regA + regB
  $D638  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D639  D7 48 D6                    branch_nz_abs            $D648                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D63C  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $D63D  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D641  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D644  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D645  D8 4B D6                    branch_z_abs             $D64B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
 >$D648  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D649  D0                          incA                                               ; regA += 1
  $D64A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$D64B  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D64C  D0                          incA                                               ; regA += 1
  $D64D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$D64E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D64F  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $D652  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $D653  D7 33 D6                    branch_nz_abs            $D633                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D656  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D657  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $D658  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D659  D8 6B D6                    branch_z_abs             $D66B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D65C  AC 82 D9                    host_call_simple         $D982 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D65F  D8 66 D6                    branch_z_abs             $D666                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D662  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D663  D6 67 D6                    jump_abs                 $D667                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D666  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$D667  CD                          swap_AB                                            ; regA <-> regB
  $D668  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D669  DA                          bitand                                             ; regA = regA & regB
  $D66A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$D66B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D66C  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $D66D  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $D66E  D8 75 D6                    branch_z_abs             $D675                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D671  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D672  D6 76 D6                    jump_abs                 $D676                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D675  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$D676  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D677   (frame_off=+0, body @ $D67C)
; ============================================================
  $D67C  AA 9F 6D 8E                 op_AA_wb                 $6D9F, $8E
  $D680  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D681  F6                          trigger_syscall_EB_FE                              ; BRK to syscall_dispatch (handler $EF92)
  $D682  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D686  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D687   (frame_off=+0, body @ $D68C)
; ============================================================
  $D68C  A4 5F 6D                    loadA_mem_word           $6D5F (config_block)      ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D68F  D5                          switch                                             ; Jump-table dispatch on regA (handler $EC65) — reads inline (value,target) pairs from the bytecode stream, jumps to the matching target. Variable-length; the disassembler stops the fall-through run here.

  ; ---- gap $D690-$D6B7 (40 bytes, not on any traced path) ----

; ============================================================
; sub $D6B8 (math32_3arg)   (frame_off=+0, body @ $D6BD)
; ============================================================
  $D6BD  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6BE  D8 DB D6                    branch_z_abs             $D6DB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D6C1  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6C2  B7 25                       ext_op                   $25                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6C4  B7 14                       ext_op                   $14                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6C6  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6C7  B7 25                       ext_op                   $25                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6C9  B7 14                       ext_op                   $14                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6CB  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6CC  B7 25                       ext_op                   $25                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6CE  B7 15                       ext_op                   $15                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6D0  B7 01                       ext_op                   $01                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6D2  B7 15                       ext_op                   $15                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6D4  B7 02                       ext_op                   $02                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6D6  B7 27                       ext_op                   $27                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6D8  D6 DD D6                    jump_abs                 $D6DD                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D6DB  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
 >$D6DD  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D6DE (math32_2arg)   (frame_off=+0, body @ $D6E3)
; ============================================================
  $D6E3  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6E4  D7 ED D6                    branch_nz_abs            $D6ED                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D6E7  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6E8  D7 ED D6                    branch_nz_abs            $D6ED                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D6EB  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D6EC  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$D6ED  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6EE  B7 26                       ext_op                   $26                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6F0  B7 14                       ext_op                   $14                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6F2  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6F3  B7 26                       ext_op                   $26                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6F5  B7 15                       ext_op                   $15                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6F7  B7 03                       ext_op                   $03                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6F9  B7 14                       ext_op                   $14                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6FB  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D6FC  B7 26                       ext_op                   $26                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D6FE  B7 19                       ext_op                   $19                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D700  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $D701  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D702  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D703  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $D704  B7 01                       ext_op                   $01                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D706  B7 15                       ext_op                   $15                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D708  B7 02                       ext_op                   $02                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D70A  B7 27                       ext_op                   $27                       ; EXTENDED-OPCODE PREFIX. Handler $F246 reads the next byte as a sub-opcode index and dispatches through a ~47-entry secondary handler table at $F263. So `B7 xx` is a 2-byte instruction = extended opcode xx. The extended set appears to hold the VM's wide/32-bit arithmetic — the first handler ($F2C1) zeroes $10-$13 and runs a 32-iteration loop. Decoding the extended table is a future session; for now the disassembler stays byte-aligned by consuming the 1 sub-opcode byte.
  $D70C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D70D (pct_op)   (frame_off=+0, body @ $D712)
; ============================================================
  $D712  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D713  8B 64                       loadB_imm_byte           +100                      ; regB = byte literal (handler $EABE)
  $D715  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D716  D8 1B D7                    branch_z_abs             $D71B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D719  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D71A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$D71B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D71C  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $D71D  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $D71E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D71F  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D720  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $D721  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $D722  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D723  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D724  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D725  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D726  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $D727  B9                          mod_signed                                         ; regA = regA % regB  (signed remainder)
  $D728  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $D729  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D72A  8B 64                       loadB_imm_byte           +100                      ; regB = byte literal (handler $EABE)
  $D72C  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $D72D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D72E  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D72F  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $D730  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $D731  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D732  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D733  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $D734  B9                          mod_signed                                         ; regA = regA % regB  (signed remainder)
  $D735  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D736  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D737  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $D738  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $D739  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D73A  BB                          add                                                ; regA = regA + regB
  $D73B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D73C  BB                          add                                                ; regA = regA + regB
  $D73D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D73E   (frame_off=-2, body @ $D743)
; ============================================================
  $D743  D6 51 D7                    jump_abs                 $D751                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D746  8A F0 00                    loadA_imm_word           $00F0                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $D749  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$D74A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D74B  D1                          decA                                               ; regA -= 1
  $D74C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D74D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D74E  D7 4A D7                    branch_nz_abs            $D74A                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$D751  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D752  D1                          decA                                               ; regA -= 1
  $D753  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $D754  D0                          incA                                               ; regA += 1
  $D755  D7 46 D7                    branch_nz_abs            $D746                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D758  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D759 (ui_helper_d759)   (frame_off=+0, body @ $D75E)
; ============================================================
  $D75E  AA 65 6D E9                 op_AA_wb                 $6D65, $E9
  $D762  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D763  D7 02 CF                    branch_nz_abs            $CF02                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.

; ============================================================
; sub $D766 (confirm_prompt)   (frame_off=+0, body @ $D76B)
; ============================================================
  $D76B  AC 59 D7                    host_call_simple         $D759 (ui_helper_d759) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D76E  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D771  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D772 (ui_helper_d772)   (frame_off=+0, body @ $D777)
; ============================================================
  $D777  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D778  8C 15 6E                    loadB_imm_word           $6E15                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D77B  BB                          add                                                ; regA = regA + regB
  $D77C  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D77D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D77E (ui_helper_d77e)   (frame_off=+0, body @ $D783)
; ============================================================
  $D783  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $D787  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $D788  D7 02 CF                    branch_nz_abs            $CF02                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.

; ============================================================
; sub $D78B   (frame_off=-2, body @ $D790)
; ============================================================
  $D790  8E E1 F6                    push_imm_word            $F6E1                     ; "Lord "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D793  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D797  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D798  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D79C  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $D79D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D79E  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D7A1  BB                          add                                                ; regA = regA + regB
  $D7A2  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D7A3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D7A4  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D7A8  8D 2C                       op_8D_sbyte              +44
  $D7AA  E9 81 CE 02                 host_call                $CE81 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D7AE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D7AF   (frame_off=-2, body @ $D7B4)
; ============================================================
  $D7B4  8E E7 F6                    push_imm_word            $F6E7                     ; "Lord\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $D7B7  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D7BB  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D7BC  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D7C0  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $D7C1  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D7C2  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D7C5  BB                          add                                                ; regA = regA + regB
  $D7C6  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D7C7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D7C8  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D7CC  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D7CD   (frame_off=+0, body @ $D7D2)
; ============================================================
  $D7D2  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D7D3  57                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 7)
  $D7D4  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D7D5  8C 2F 75                    loadB_imm_word           $752F (daimyo_table_17)   ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D7D8  BB                          add                                                ; regA = regA + regB
  $D7D9  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D7DA   (frame_off=+0, body @ $D7DF)
; ============================================================
  $D7DF  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D7E0  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D7E4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D7E5  E9 CD D7 02                 host_call                $D7CD {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D7E9  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D7EA (ui_helper_d7ea)   (frame_off=+0, body @ $D7EF)
; ============================================================
  $D7EF  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $D7F3  DA                          bitand                                             ; regA = regA & regB
  $D7F4  D7 02 CF                    branch_nz_abs            $CF02                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.

; ============================================================
; sub $D7F7   (frame_off=-2, body @ $D7FC)
; ============================================================
  $D7FC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D7FD  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $D7FF  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D800  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D803  BB                          add                                                ; regA = regA + regB
  $D804  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D805  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D806  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $D807  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D808  D7 14 D8                    branch_nz_abs            $D814                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D80B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D80C  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $D80D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D80E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D80F  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $D810  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D811  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D812  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D813  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$D814  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D815   (frame_off=-4, body @ $D81A)
; ============================================================
  $D81A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D81B  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $D81D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D81E  8C 11 70                    loadB_imm_word           $7011                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D821  BB                          add                                                ; regA = regA + regB
  $D822  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D823  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D824  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D825  D7 35 D8                    branch_nz_abs            $D835                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D828  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D829  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $D82A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D82B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D82C  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $D82D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D82E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D82F  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $D830  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D831  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D832  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D833  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D834  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$D835  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D836   (frame_off=-12, body @ $D83B)
; ============================================================
  $D83B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D83C  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $D83E  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D83F  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D842  BB                          add                                                ; regA = regA + regB
  $D843  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $D844  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D845  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $D846  D6 63 D8                    jump_abs                 $D863                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D849  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $D84A  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D84B  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $D84D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D84E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D84F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D850  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D851  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D852  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D856  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D857  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D858  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D859  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $D85A  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $D85B  D8 61 D8                    branch_z_abs             $D861                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D85E  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $D85F  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D860  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$D861  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D862  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
 >$D863  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D864  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D865  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $D867  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D868  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D869  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D86A  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $D86B  D7 49 D8                    branch_nz_abs            $D849                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D86E  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D86F  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $D870  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D871  8D 64                       op_8D_sbyte              +100
  $D873  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $D874  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $D875  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D876  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D877  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D87B  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D87C  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D87D  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $D87E  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D87F  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D883  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $D884  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $D885  D6 A9 D8                    jump_abs                 $D8A9                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$D888  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $D889  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D88A  8C EB 00                    loadB_imm_word           $00EB                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D88D  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D88E  D8 94 D8                    branch_z_abs             $D894                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D891  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $D892  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D893  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$D894  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $D895  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D896  8C D2 00                    loadB_imm_word           $00D2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D899  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D89A  D8 A1 D8                    branch_z_abs             $D8A1                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D89D  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $D89E  89 D2                       loadA_imm_sbyte          -46                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $D8A0  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$D8A1  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $D8A2  D0                          incA                                               ; regA += 1
  $D8A3  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $D8A4  D1                          decA                                               ; regA -= 1
  $D8A5  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $D8A6  D0                          incA                                               ; regA += 1
  $D8A7  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $D8A8  D1                          decA                                               ; regA -= 1
 >$D8A9  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $D8AA  56                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 6)
  $D8AB  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $D8AC  D7 88 D8                    branch_nz_abs            $D888                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D8AF  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D8B0  E9 15 D8 02                 host_call                $D815 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D8B4  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D8B5  E9 F7 D7 02                 host_call                $D7F7 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D8B9  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D8BA   (frame_off=-4, body @ $D8BF)
; ============================================================
  $D8BF  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D8C0  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $D8C1  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $D8C2  D8 C7 D8                    branch_z_abs             $D8C7                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D8C5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $D8C6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$D8C7  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D8C8  E9 CD CB 02                 host_call                $CBCD (sqrt_int) {native}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D8CC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D8CD  0E                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D8CE  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D8CF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D8D0  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D8D1  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D8D2  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D8D3  BB                          add                                                ; regA = regA + regB
  $D8D4  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $D8D5  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $D8D6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D8D7  E9 CD CB 02                 host_call                $CBCD (sqrt_int) {native}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D8DB  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D8DC  BB                          add                                                ; regA = regA + regB
  $D8DD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D8DE  46                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D8DF  A6 63 6D                    loadB_mem_word           $6D63 (const_two)         ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $D8E2  BC                          sub                                                ; regA = regA - regB
  $D8E3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D8E4  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D8E5  E9 B8 D6 06                 host_call                $D6B8 (math32_3arg) {bytecode}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D8E9  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D8EA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D8EB  D7 F0 D8                    branch_nz_abs            $D8F0                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $D8EE  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $D8EF  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$D8F0  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D8F1  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D8F2   (frame_off=-4, body @ $D8F7)
; ============================================================
  $D8F7  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D8F8  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $D8F9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D8FA  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D8FB  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $D8FC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D8FD  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D8FE  E9 BA D8 06                 host_call                $D8BA {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D902  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D903  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D904  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $D905  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D906  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D907  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D908  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $D90A  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D90B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D90C  BC                          sub                                                ; regA = regA - regB
  $D90D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $D90E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D90F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D910  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D911  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D912  D8 17 D9                    branch_z_abs             $D917                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D915  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D916  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$D917  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D918  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D919   (frame_off=-4, body @ $D91E)
; ============================================================
  $D91E  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D91F  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $D920  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D921  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D922  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $D923  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D924  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D925  E9 BA D8 06                 host_call                $D8BA {bytecode}, $06     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D929  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $D92A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D92B  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $D92C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D92D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D92E  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D92F  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $D931  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D932  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D933  BC                          sub                                                ; regA = regA - regB
  $D934  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $D935  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D936  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D937  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D938  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $D939  D8 3E D9                    branch_z_abs             $D93E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $D93C  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $D93D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$D93E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $D93F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D940   (frame_off=+0, body @ $D945)
; ============================================================
  $D945  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D946  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D947  E9 F2 D8 04                 host_call                $D8F2 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D94B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D94C  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D94D  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $D94E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D94F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D950  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D951  BB                          add                                                ; regA = regA + regB
  $D952  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D953  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D954  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D955  E9 19 D9 04                 host_call                $D919 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D959  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D95A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D95B  7E                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 14)
  $D95C  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D95D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D95E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $D95F  BB                          add                                                ; regA = regA + regB
  $D960  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $D961  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D962   (frame_off=+0, body @ $D967)
; ============================================================
  $D967  89 80                       loadA_imm_sbyte          -128                      ; regA = sign-extended signed byte literal (handler $EAAF)
  $D969  CD                          swap_AB                                            ; regA <-> regB
  $D96A  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $D96D  DB                          bitor                                              ; regA = regA | regB
  $D96E  A9 A1 6D                    storeA_mem_byte          $6DA1                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $D971  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D972 (war_helper_d972)   (frame_off=+0, body @ $D977)
; ============================================================
  $D977  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D978  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D97C  8C D4 6D                    loadB_imm_word           $6DD4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D97F  BB                          add                                                ; regA = regA + regB
  $D980  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D981  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D982   (frame_off=+0, body @ $D987)
; ============================================================
  $D987  A4 09 6E                    loadA_mem_word           $6E09                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D98A  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $D98B  C9                          cmp_ult                                            ; regA = (regA < regB) ? 1 : 0   (unsigned)
  $D98C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D98D   (frame_off=+0, body @ $D992)
; ============================================================
  $D992  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D993  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D996  BB                          add                                                ; regA = regA + regB
  $D997  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D998  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D999   (frame_off=+0, body @ $D99E)
; ============================================================
  $D99E  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D99F  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D9A2  BB                          add                                                ; regA = regA + regB
  $D9A3  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D9A4  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D9A7  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D9A8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D9A9   (frame_off=+0, body @ $D9AE)
; ============================================================
  $D9AE  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $D9B1  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D9B4  BB                          add                                                ; regA = regA + regB
  $D9B5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D9B6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D9B7   (frame_off=+0, body @ $D9BC)
; ============================================================
  $D9BC  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $D9BF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D9C0  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $D9C1  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D9C5  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $D9C6  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $D9C7  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D9C8   (frame_off=+0, body @ $D9CD)
; ============================================================
  $D9CD  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D9CE  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D9D1  BB                          add                                                ; regA = regA + regB
  $D9D2  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D9D3   (frame_off=+0, body @ $D9D8)
; ============================================================
  $D9D8  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D9D9  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $D9DA  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $D9DB  8C 85 79                    loadB_imm_word           $7985                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D9DE  BB                          add                                                ; regA = regA + regB
  $D9DF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $D9E0  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $D9E4  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D9E5   (frame_off=+0, body @ $D9EA)
; ============================================================
  $D9EA  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D9EB  8C 65 6F                    loadB_imm_word           $6F65                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D9EE  BB                          add                                                ; regA = regA + regB
  $D9EF  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $D9F0  8C 80 00                    loadB_imm_word           $0080 (skip_vblank_wait)  ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $D9F3  DA                          bitand                                             ; regA = regA & regB
  $D9F4  50                          setB_imm4_50                                       ; regB = 0 (variant handler $EA11)
  $D9F5  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $D9F6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $D9F7   (frame_off=-2, body @ $D9FC)
; ============================================================
  $D9FC  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $D9FD  8C 79 7B                    loadB_imm_word           $7B79                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DA00  BB                          add                                                ; regA = regA + regB
  $DA01  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DA02  56                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 6)
  $DA03  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DA04  D8 0D DA                    branch_z_abs             $DA0D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DA07  8A ED F6                    loadA_imm_word           $F6ED                     ; "Pirates"  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $DA0A  D6 21 DA                    jump_abs                 $DA21                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DA0D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DA0E  8C 79 7B                    loadB_imm_word           $7B79                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DA11  BB                          add                                                ; regA = regA + regB
  $DA12  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DA13  57                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 7)
  $DA14  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DA15  D8 1E DA                    branch_z_abs             $DA1E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DA18  8A F5 F6                    loadA_imm_word           $F6F5                     ; "Christns"  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $DA1B  D6 21 DA                    jump_abs                 $DA21                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DA1E  8A FE F6                    loadA_imm_word           $F6FE                     ; "Rioters"  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
 >$DA21  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DA22  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DA23  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DA24   (frame_off=+0, body @ $DA29)
; ============================================================
  $DA29  87 13                       op_87_byte               $13
  $DA2B  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DA2C  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DA2D  E9 DE D6 04                 host_call                $D6DE (math32_2arg) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DA31  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DA32  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DA33  51                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 1)
  $DA34  DB                          bitor                                              ; regA = regA | regB
  $DA35  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DA36  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DA3A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DA3B  3E                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DA3C  3F                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DA3D  E9 DE D6 04                 host_call                $D6DE (math32_2arg) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DA41  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DA42  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DA43  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DA47  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DA48  BB                          add                                                ; regA = regA + regB
  $DA49  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DA4A  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DA4E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DA4F (diplomacy_helper2)   (frame_off=+0, body @ $DA54)
; ============================================================
  $DA54  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DA57  A6 63 6F                    loadB_mem_word           $6F63                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $DA5A  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DA5B  D8 6A DA                    branch_z_abs             $DA6A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DA5E  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DA61  8B 36                       loadB_imm_byte           +54                       ; regB = byte literal (handler $EABE)
  $DA63  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DA64  A6 63 6F                    loadB_mem_word           $6F63                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $DA67  D6 73 DA                    jump_abs                 $DA73                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DA6A  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DA6D  8B 36                       loadB_imm_byte           +54                       ; regB = byte literal (handler $EABE)
  $DA6F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DA70  A6 5F 6F                    loadB_mem_word           $6F5F (selected_province_idx) ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
 >$DA73  BB                          add                                                ; regA = regA + regB
  $DA74  8C 93 61                    loadB_imm_word           $6193                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DA77  BB                          add                                                ; regA = regA + regB
  $DA78  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DA79  89 46                       loadA_imm_sbyte          +70                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $DA7B  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DA7C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DA7D (diplomacy_helper3)   (frame_off=-4, body @ $DA82)
; ============================================================
  $DA82  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $DA85  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DA86  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $DA8A  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DA8B  D7 02 2A                    branch_nz_abs            $2A02                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DA8E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DA8F  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
  $DA90  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DA91  D8 9C DA                    branch_z_abs             $DA9C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DA94  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DA95  8B 36                       loadB_imm_byte           +54                       ; regB = byte literal (handler $EABE)
  $DA97  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DA98  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $DA99  D6 A1 DA                    jump_abs                 $DAA1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DA9C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DA9D  8B 36                       loadB_imm_byte           +54                       ; regB = byte literal (handler $EABE)
  $DA9F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DAA0  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
 >$DAA1  BB                          add                                                ; regA = regA + regB
  $DAA2  8C 93 61                    loadB_imm_word           $6193                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DAA5  BB                          add                                                ; regA = regA + regB
  $DAA6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DAA7  89 5A                       loadA_imm_sbyte          +90                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $DAA9  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DAAA  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DAAB   (frame_off=+0, body @ $DAB0)
; ============================================================
  $DAB0  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $DAB1  8E 4F 6F                    push_imm_word            $6F4F                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $DAB4  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DAB7  8B 11                       loadB_imm_byte           +17                       ; regB = byte literal (handler $EABE)
  $DAB9  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DABA  D8 C6 DA                    branch_z_abs             $DAC6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DABD  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DABE  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $DABF  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $DAC0  8C 00 83                    loadB_imm_word           $8300                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DAC3  D6 CC DA                    jump_abs                 $DACC                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DAC6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DAC7  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $DAC8  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $DAC9  8C 04 80                    loadB_imm_word           $8004                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
 >$DACC  BB                          add                                                ; regA = regA + regB
  $DACD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DACE  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $DACF  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DAD3  8A 4F 6F                    loadA_imm_word           $6F4F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $DAD6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DAD7 (combat_helper_dad7)   (frame_off=-4, body @ $DADC)
; ============================================================
  $DADC  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $DAE0  AB DA 02                    op_AB_word               $02DA
  $DAE3  8A 4F 6F                    loadA_imm_word           $6F4F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $DAE6  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DAE7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DAE8  D6 04 DB                    jump_abs                 $DB04                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DAEB  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DAEC  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DAED  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DAEE  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DAF2  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DAF5  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $DAF6  D8 01 DB                    branch_z_abs             $DB01                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DAF9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DAFA  D0                          incA                                               ; regA += 1
  $DAFB  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DAFC  D1                          decA                                               ; regA -= 1
  $DAFD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DAFE  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DAFF  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DB00  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$DB01  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DB02  D0                          incA                                               ; regA += 1
  $DB03  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$DB04  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DB05  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DB06  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DB09  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $DB0A  D7 EB DA                    branch_nz_abs            $DAEB                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DB0D  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $DB0E  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $DB10  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DB11  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DB12 (tax_helper_db12)   (frame_off=+0, body @ $DB17)
; ============================================================
  $DB17  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DB1A  8B 11                       loadB_imm_byte           +17                       ; regB = byte literal (handler $EABE)
  $DB1C  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DB1D  D8 2A DB                    branch_z_abs             $DB2A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DB20  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $DB24  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DB25  D7 02 53                    branch_nz_abs            $5302                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DB28  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DB29  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$DB2A  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $DB2E  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DB2F  D7 02 8B                    branch_nz_abs            $8B02                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DB32  14                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 4)
  $DB33  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DB34  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DB35 (ui_helper_db35)   (frame_off=+0, body @ $DB3A)
; ============================================================
  $DB3A  A4 09 6E                    loadA_mem_word           $6E09                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DB3D  D0                          incA                                               ; regA += 1
  $DB3E  A8 09 6E                    loadA_mem_word           $6E09                     ; regA = word read using <word> as address (handler $EA75)
  $DB41  AC 82 D9                    host_call_simple         $D982 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $DB44  D8 4A DB                    branch_z_abs             $DB4A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DB47  AC 62 D9                    host_call_simple         $D962 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$DB4A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DB4B   (frame_off=+0, body @ $DB50)
; ============================================================
  $DB50  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DB51  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DB54  BB                          add                                                ; regA = regA + regB
  $DB55  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DB56  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DB59  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $DB5A  D8 6D DB                    branch_z_abs             $DB6D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DB5D  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DB5E  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DB62  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $DB63  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DB64  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DB67  BB                          add                                                ; regA = regA + regB
  $DB68  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DB69  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$DB6D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DB6E   (frame_off=+0, body @ $DB73)
; ============================================================
  $DB73  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DB74  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DB77  BB                          add                                                ; regA = regA + regB
  $DB78  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DB79  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DB7C  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $DB7D  D8 8F DB                    branch_z_abs             $DB8F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DB80  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DB81  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DB85  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $DB86  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DB87  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DB8A  BB                          add                                                ; regA = regA + regB
  $DB8B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DB8C  D6 92 DB                    jump_abs                 $DB92                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DB8F  8E 06 F7                    push_imm_word            $F706                     ; "no lord"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
 >$DB92  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DB96  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DB97   (frame_off=-8, body @ $DB9C)
; ============================================================
  $DB9C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DB9D  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DBA1  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $DBA2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DBA3  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $DBA4  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DBA5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DBA6  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
 >$DBA7  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $DBA8  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DBAC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DBAD  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $DBAE  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DBB2  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $DBB3  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DBB4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DBB5  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $DBB6  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DBBA  8B 19                       loadB_imm_byte           +25                       ; regB = byte literal (handler $EABE)
  $DBBC  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DBBD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DBBE  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $DBBF  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DBC3  8B 7D                       loadB_imm_byte           +125                      ; regB = byte literal (handler $EABE)
  $DBC5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DBC6  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DBC7  BB                          add                                                ; regA = regA + regB
  $DBC8  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DBC9  BB                          add                                                ; regA = regA + regB
  $DBCA  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DBCB  BB                          add                                                ; regA = regA + regB
  $DBCC  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DBCD  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DBD0  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $DBD2  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DBD3  D8 DB DB                    branch_z_abs             $DBDB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DBD6  89 35                       loadA_imm_sbyte          +53                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $DBD8  D6 DD DB                    jump_abs                 $DBDD                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DBDB  89 11                       loadA_imm_sbyte          +17                       ; regA = sign-extended signed byte literal (handler $EAAF)
 >$DBDD  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DBDE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DBDF  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DBE0  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $DBE1  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $DBE2  D6 F6 DB                    jump_abs                 $DBF6                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DBE5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DBE6  D2                          aslA                                               ; regA <<= 1
  $DBE7  8C B1 6E                    loadB_imm_word           $6EB1                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DBEA  BB                          add                                                ; regA = regA + regB
  $DBEB  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DBEC  1A                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 10)
  $DBED  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DBEE  D8 F3 DB                    branch_z_abs             $DBF3                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DBF1  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DBF2  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
 >$DBF3  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DBF4  D0                          incA                                               ; regA += 1
  $DBF5  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$DBF6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DBF7  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $DBF8  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DBF9  D7 E5 DB                    branch_nz_abs            $DBE5                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DBFC  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $DBFD  D8 A7 DB                    branch_z_abs             $DBA7                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DC00  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DC01  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DC05  D2                          aslA                                               ; regA <<= 1
  $DC06  8C B1 6E                    loadB_imm_word           $6EB1                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DC09  BB                          add                                                ; regA = regA + regB
  $DC0A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DC0B  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DC0C  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $DC0D  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DC0E   (frame_off=+0, body @ $DC13)
; ============================================================
  $DC13  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DC14  8B 31                       loadB_imm_byte           +49                       ; regB = byte literal (handler $EABE)
  $DC16  C8                          cmp_ugt                                            ; regA = (regA > regB) ? 1 : 0   (unsigned)
  $DC17  D8 2A DC                    branch_z_abs             $DC2A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DC1A  A5 4A 6E                    loadA_mem_byte           $6E4A                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $DC1D  D1                          decA                                               ; regA -= 1
  $DC1E  A9 4A 6E                    storeA_mem_byte          $6E4A                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $DC21  A5 4A 6E                    loadA_mem_byte           $6E4A                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $DC24  8C 4B 6E                    loadB_imm_word           $6E4B                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DC27  BB                          add                                                ; regA = regA + regB
  $DC28  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DC29  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$DC2A  A5 4A 6E                    loadA_mem_byte           $6E4A                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $DC2D  D0                          incA                                               ; regA += 1
  $DC2E  A9 4A 6E                    storeA_mem_byte          $6E4A                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $DC31  A5 4A 6E                    loadA_mem_byte           $6E4A                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $DC34  8C 4A 6E                    loadB_imm_word           $6E4A                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DC37  BB                          add                                                ; regA = regA + regB
  $DC38  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DC39  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DC3A  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DC3B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DC3C   (frame_off=-4, body @ $DC41)
; ============================================================
  $DC41  8A 7F 6E                    loadA_imm_word           $6E7F                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $DC44  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DC45  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DC46  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DC47  D6 5D DC                    jump_abs                 $DC5D                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DC4A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DC4B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DC4C  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $DC4D  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DC4E  D8 55 DC                    branch_z_abs             $DC55                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DC51  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $DC52  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $DC54  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$DC55  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DC56  D0                          incA                                               ; regA += 1
  $DC57  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DC58  D1                          decA                                               ; regA -= 1
  $DC59  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DC5A  D0                          incA                                               ; regA += 1
  $DC5B  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DC5C  D1                          decA                                               ; regA -= 1
 >$DC5D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DC5E  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $DC61  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DC62  D7 4A DC                    branch_nz_abs            $DC4A                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DC65  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DC66   (frame_off=+0, body @ $DC6B)
; ============================================================
  $DC6B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DC6C  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $DC6E  C8                          cmp_ugt                                            ; regA = (regA > regB) ? 1 : 0   (unsigned)
  $DC6F  D8 74 DC                    branch_z_abs             $DC74                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DC72  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DC73  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$DC74  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DC77  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $DC79  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DC7A  D8 81 DC                    branch_z_abs             $DC81                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DC7D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DC7E  D6 87 DC                    jump_abs                 $DC87                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DC81  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DC82  8C 0E F7                    loadB_imm_word           $F70E                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DC85  BB                          add                                                ; regA = regA + regB
  $DC86  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
 >$DC87  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DC88   (frame_off=-1, body @ $DC8D)
; ============================================================
  $DC8D  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $DC8E  DE FF                       loadA_frameaddr          $FF                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DC90  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $DC91  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DC92  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DC93  5B                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 11)
  $DC94  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DC95  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DC96  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $DC9A  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $DC9B  DC                          bitxor                                             ; regA = regA ^ regB
  $DC9C  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $DC9D  8B 37                       loadB_imm_byte           +55                       ; regB = byte literal (handler $EABE)
  $DC9F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DCA0  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DCA1  BB                          add                                                ; regA = regA + regB
  $DCA2  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $DCA3  BB                          add                                                ; regA = regA + regB
  $DCA4  8C 7E A5                    loadB_imm_word           $A57E                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DCA7  BB                          add                                                ; regA = regA + regB
  $DCA8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DCA9  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $DCAA  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DCAE  A0 FF                       op_A0_A3_byte            $FF                       ; 1-byte operand; indexed load/store via ptr0 (handlers $EAED-$EB1E)
  $DCB0  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $DCB1  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DCB2   (frame_off=-13, body @ $DCB7)
; ============================================================
 >$DCB7  DE F3                       loadA_frameaddr          $F3                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DCB9  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $DCBA  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DCBB  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $DCBC  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DCC0  D2                          aslA                                               ; regA <<= 1
  $DCC1  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DCC2  6B                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 11)
  $DCC3  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DCC7  D2                          aslA                                               ; regA <<= 1
  $DCC8  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DCC9  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $DCCA  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DCCB  8C 30 F9                    loadB_imm_word           $F930                     ; "AiAoIeUeOiKaKiKuSaSiSuSoTaTuToNaNoHaHiHuYuYo"  | regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DCCE  BB                          add                                                ; regA = regA + regB
  $DCCF  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DCD0  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DCD1  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DCD2  D0                          incA                                               ; regA += 1
  $DCD3  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DCD4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DCD5  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DCD6  D0                          incA                                               ; regA += 1
  $DCD7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DCD8  8C 30 F9                    loadB_imm_word           $F930                     ; "AiAoIeUeOiKaKiKuSaSiSuSoTaTuToNaNoHaHiHuYuYo"  | regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DCDB  BB                          add                                                ; regA = regA + regB
  $DCDC  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DCDD  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DCDE  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DCDF  D0                          incA                                               ; regA += 1
  $DCE0  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DCE1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DCE2  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DCE3  8C 5D F9                    loadB_imm_word           $F95D                     ; "setenohomamimemoyarawagagizazedadubabibvbejo"  | regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DCE6  BB                          add                                                ; regA = regA + regB
  $DCE7  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DCE8  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DCE9  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DCEA  D0                          incA                                               ; regA += 1
  $DCEB  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DCEC  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DCED  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DCEE  D0                          incA                                               ; regA += 1
  $DCEF  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DCF0  8C 5D F9                    loadB_imm_word           $F95D                     ; "setenohomamimemoyarawagagizazedadubabibvbejo"  | regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DCF3  BB                          add                                                ; regA = regA + regB
  $DCF4  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DCF5  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DCF6  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DCF7  D0                          incA                                               ; regA += 1
  $DCF8  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DCF9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DCFA  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DCFB  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DCFC  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DCFD  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $DCFE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DCFF  D6 1C DD                    jump_abs                 $DD1C                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DD02  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DD03  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $DD04  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DD05  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DD08  BB                          add                                                ; regA = regA + regB
  $DD09  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD0A  DE F3                       loadA_frameaddr          $F3                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DD0C  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $DD0D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD0E  E9 B0 CA 04                 host_call                $CAB0 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD12  D7 1A DD                    branch_nz_abs            $DD1A                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DD15  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $DD16  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $DD17  D6 25 DD                    jump_abs                 $DD25                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DD1A  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DD1B  D0                          incA                                               ; regA += 1
 >$DD1C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DD1D  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DD1E  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $DD21  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DD22  D7 02 DD                    branch_nz_abs            $DD02                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$DD25  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $DD26  D7 B7 DC                    branch_nz_abs            $DCB7                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DD29  DE F3                       loadA_frameaddr          $F3                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DD2B  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $DD2C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD2D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DD2E  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $DD2F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DD30  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DD33  BB                          add                                                ; regA = regA + regB
  $DD34  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD35  E9 D9 CA 04                 host_call                $CAD9 {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD39  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DD3A (combat_helper_dd3a)   (frame_off=-12, body @ $DD3F)
; ============================================================
  $DD3F  DE F8                       loadA_frameaddr          $F8                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DD41  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $DD42  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $DD43  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DD44  D6 67 DD                    jump_abs                 $DD67                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DD47  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $DD48  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DD49  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD4A  E9 B7 D9 02                 host_call                $D9B7 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD4E  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $DD4F  DC                          bitxor                                             ; regA = regA ^ regB
  $DD50  D7 65 DD                    branch_nz_abs            $DD65                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DD53  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $DD54  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DD55  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD56  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD5A  D7 65 DD                    branch_nz_abs            $DD65                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DD5D  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $DD5E  D0                          incA                                               ; regA += 1
  $DD5F  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $DD60  D1                          decA                                               ; regA -= 1
  $DD61  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD62  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $DD63  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DD64  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$DD65  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $DD66  D0                          incA                                               ; regA += 1
 >$DD67  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $DD68  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $DD69  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DD6A  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DD6D  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $DD6E  D7 47 DD                    branch_nz_abs            $DD47                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DD71  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $DD72  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $DD74  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DD75  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $DD76  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DD77  DE F8                       loadA_frameaddr          $F8                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DD79  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $DD7A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD7B  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $DD7C  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD80  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DD81   (frame_off=-8, body @ $DD86)
; ============================================================
  $DD86  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DD87  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD8B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DD8C  8D 14                       op_8D_sbyte              +20
  $DD8E  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD92  8F 14                       addA_imm_sbyte           +20                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $DD94  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DD95  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DD96  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DD9A  D0                          incA                                               ; regA += 1
  $DD9B  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DD9C  D6 C8 DD                    jump_abs                 $DDC8                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DD9F  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $DDA0  8D 14                       op_8D_sbyte              +20
  $DDA2  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DDA6  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $DDA8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DDA9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DDAA  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DDAB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DDAC  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DDB0  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DDB1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DDB2  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DDB3  8B 1E                       loadB_imm_byte           +30                       ; regB = byte literal (handler $EABE)
  $DDB5  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $DDB6  D8 BE DD                    branch_z_abs             $DDBE                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DDB9  89 1E                       loadA_imm_sbyte          +30                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $DDBB  D6 BF DD                    jump_abs                 $DDBF                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DDBE  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$DDBF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DDC0  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DDC1  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DDC2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DDC3  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DDC4  BB                          add                                                ; regA = regA + regB
  $DDC5  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DDC6  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DDC7  D0                          incA                                               ; regA += 1
 >$DDC8  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DDC9  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DDCA  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $DDCB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DDCC  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DDCD  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DDCE  C7                          cmp_ule                                            ; regA = (regA <= regB) ? 1 : 0  (unsigned)
  $DDCF  D7 9F DD                    branch_nz_abs            $DD9F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DDD2  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DDD3  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $DDD5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DDD6  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DDD9  BB                          add                                                ; regA = regA + regB
  $DDDA  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $DDDB  D6 45 DE                    jump_abs                 $DE45                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DDDE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DDDF  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $DDE1  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DDE2  8C 17 70                    loadB_imm_word           $7017                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DDE5  BB                          add                                                ; regA = regA + regB
  $DDE6  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $DDE7  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DDE8  D8 0A DE                    branch_z_abs             $DE0A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DDEB  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $DDEC  8D 1F                       op_8D_sbyte              +31
  $DDEE  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DDF2  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $DDF4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DDF5  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DDF6  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DDF7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DDF8  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DDFC  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $DDFD  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DDFE  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DDFF  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $DE01  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $DE02  D8 3B DE                    branch_z_abs             $DE3B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DE05  89 32                       loadA_imm_sbyte          +50                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $DE07  D6 3C DE                    jump_abs                 $DE3C                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DE0A  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $DE0B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DE0C  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DE0F  BB                          add                                                ; regA = regA + regB
  $DE10  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DE11  D8 1F DE                    branch_z_abs             $DE1F                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DE14  8D 14                       op_8D_sbyte              +20
  $DE16  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DE1A  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $DE1C  D6 27 DE                    jump_abs                 $DE27                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DE1F  8D 1E                       op_8D_sbyte              +30
  $DE21  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DE25  8F 1E                       addA_imm_sbyte           +30                       ; regA += sign-extended signed byte literal (handler $EAD9)
 >$DE27  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE28  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DE29  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DE2A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE2B  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DE2F  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $DE30  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DE31  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DE32  5A                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 10)
  $DE33  C2                          cmp_slt                                            ; regA = (regA < regB) ? 1 : 0   (signed)
  $DE34  D8 3B DE                    branch_z_abs             $DE3B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DE37  4A                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $DE38  D6 3C DE                    jump_abs                 $DE3C                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DE3B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$DE3C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE3D  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DE3E  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DE3F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE40  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DE41  BB                          add                                                ; regA = regA + regB
  $DE42  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $DE43  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DE44  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
 >$DE45  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DE46  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $DE47  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $DE49  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE4A  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DE4B  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DE4C  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DE4D  D7 DE DD                    branch_nz_abs            $DDDE                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DE50  8D 32                       op_8D_sbyte              +50
  $DE52  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DE53  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $DE55  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DE56  8C 0D 70                    loadB_imm_word           $700D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DE59  BB                          add                                                ; regA = regA + regB
  $DE5A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DE5B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE5C  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DE5D  BB                          add                                                ; regA = regA + regB
  $DE5E  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $DE5F  8D 32                       op_8D_sbyte              +50
  $DE61  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DE62  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $DE64  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DE65  8C 13 70                    loadB_imm_word           $7013                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DE68  BB                          add                                                ; regA = regA + regB
  $DE69  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $DE6A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE6B  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DE6C  BB                          add                                                ; regA = regA + regB
  $DE6D  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $DE6E  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DE6F  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DE72  BB                          add                                                ; regA = regA + regB
  $DE73  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DE74  89 14                       loadA_imm_sbyte          +20                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $DE76  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DE77  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DE78   (frame_off=-2, body @ $DE7D)
; ============================================================
  $DE7D  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $DE80  8B 20                       loadB_imm_byte           +32                       ; regB = byte literal (handler $EABE)
  $DE82  DA                          bitand                                             ; regA = regA & regB
  $DE83  D8 8A DE                    branch_z_abs             $DE8A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DE86  8A 2E F7                    loadA_imm_word           $F72E                     ; "Rebels"  | regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $DE89  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$DE8A  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $DE8D  8B 10                       loadB_imm_byte           +16                       ; regB = byte literal (handler $EABE)
  $DE8F  DA                          bitand                                             ; regA = regA & regB
  $DE90  D8 97 DE                    branch_z_abs             $DE97                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DE93  8A 6A 79                    loadA_imm_word           $796A                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $DE96  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$DE97  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DE98  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $DE99  04                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 4)
  $DE9A  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $DE9B  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $DE9C  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $DE9D  AD DE                       op_AD_byte               $DE
  $DE9F  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $DEA0  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $DEA1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DEA2  DE 17                       loadA_frameaddr          $17                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DEA4  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $DEA5  AD DE                       op_AD_byte               $DE
  $DEA7  1E                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $DEA8  00                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 0)
  $DEA9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DEAA  DE B9                       loadA_frameaddr          $B9                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DEAC  DE 8A                       loadA_frameaddr          $8A                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $DEAE  20                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 0)
  $DEAF  F7                          trigger_syscall_EB_FE                              ; BRK to syscall_dispatch (handler $EF92)
  $DEB0  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DEB1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DEB2  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

  ; ---- gap $DEB3-$DEC0 (14 bytes, not on any traced path) ----

; ============================================================
; sub $DEC1   (frame_off=-8, body @ $DEC6)
; ============================================================
  $DEC6  A4 57 6F                    loadA_mem_word           $6F57                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DEC9  A6 63 6F                    loadB_mem_word           $6F63                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $DECC  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DECD  D8 D6 DE                    branch_z_abs             $DED6                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DED0  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DED3  D6 D9 DE                    jump_abs                 $DED9                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DED6  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
 >$DED9  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $DEDA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DEDB  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DEDF  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DEE0  AA 57 6F E9                 op_AA_wb                 $6F57, $E9
  $DEE4  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DEE5  D7 02 29                    branch_nz_abs            $2902                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DEE8  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DEE9  E9 0E DC 02                 host_call                $DC0E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DEED  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $DEEE  E9 3C DC 02                 host_call                $DC3C {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DEF2  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DEF3  D6 33 DF                    jump_abs                 $DF33                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DEF6  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $DEF7  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DEFB  19                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 9)
  $DEFC  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $DEFD  D8 31 DF                    branch_z_abs             $DF31                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DF00  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $DF01  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DF05  D7 31 DF                    branch_nz_abs            $DF31                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DF08  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF09  8C 15 6E                    loadB_imm_word           $6E15                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DF0C  BB                          add                                                ; regA = regA + regB
  $DF0D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF0E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DF0F  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF10  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF11  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DF14  BB                          add                                                ; regA = regA + regB
  $DF15  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF16  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DF17  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF18  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF19  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DF1C  BB                          add                                                ; regA = regA + regB
  $DF1D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF1E  38                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 8)
  $DF1F  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DF23  D8 2A DF                    branch_z_abs             $DF2A                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DF26  45                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $DF27  D6 2B DF                    jump_abs                 $DF2B                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DF2A  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$DF2B  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF2C  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $DF2D  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$DF31  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF32  D0                          incA                                               ; regA += 1
 >$DF33  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DF34  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF35  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $DF38  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DF39  D7 F6 DE                    branch_nz_abs            $DEF6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DF3C  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DF3D   (frame_off=-2, body @ $DF42)
; ============================================================
  $DF42  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DF43  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DF47  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DF48  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF49  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DF4A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF4B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DF4C  D0                          incA                                               ; regA += 1
  $DF4D  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF4E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF4F  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $DF50  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF51  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DF52  D0                          incA                                               ; regA += 1
  $DF53  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF54  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF55  75                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 5)
  $DF56  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF57  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DF58  D0                          incA                                               ; regA += 1
  $DF59  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF5A  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $DF5B  E9 DA D7 02                 host_call                $D7DA {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DF5F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DF60  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF61  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DF62  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF63  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DF64  D1                          decA                                               ; regA -= 1
  $DF65  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF66  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF67  74                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 4)
  $DF68  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF69  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DF6A  D1                          decA                                               ; regA -= 1
  $DF6B  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF6C  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DF6D  75                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 5)
  $DF6E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF6F  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DF70  D1                          decA                                               ; regA -= 1
  $DF71  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $DF72  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DF73   (frame_off=-8, body @ $DF78)
; ============================================================
  $DF78  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DF7B  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $DF7D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DF7E  8C 13 70                    loadB_imm_word           $7013                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DF81  BB                          add                                                ; regA = regA + regB
  $DF82  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DF83  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DF86  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $DF88  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $DF89  8C 13 70                    loadB_imm_word           $7013                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DF8C  BB                          add                                                ; regA = regA + regB
  $DF8D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DF8E  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DF8F  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $DF90  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DF91  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DF92  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DF93  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
 >$DF94  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $DF95  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $DF96  AA 87 6F AA                 op_AA_wb                 $6F87, $AA
  $DF9A  81 6F                       op_81_byte               $6F
  $DF9C  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DF9D  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DF9E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DF9F  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DFA0  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $DFA1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DFA2  E9 24 DA 0A                 host_call                $DA24 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $DFA6  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $DFA7  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $DFA8  D0                          incA                                               ; regA += 1
  $DFA9  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $DFAA  D1                          decA                                               ; regA -= 1
  $DFAB  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $DFAC  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DFAD  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $DFAE  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $DFB0  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $DFB1  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $DFB2  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $DFB3  8F FE                       addA_imm_sbyte           -2                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $DFB5  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $DFB6  53                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 3)
  $DFB7  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DFB8  D7 94 DF                    branch_nz_abs            $DF94                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DFBB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DFBC   (frame_off=-2, body @ $DFC1)
; ============================================================
  $DFC1  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DFC4  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $DFC5  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $DFC6  D6 EC DF                    jump_abs                 $DFEC                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$DFC9  AC 12 DB                    host_call_simple         $DB12 (tax_helper_db12) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $DFCC  D8 E8 DF                    branch_z_abs             $DFE8                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DFCF  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DFD2  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DFD5  BB                          add                                                ; regA = regA + regB
  $DFD6  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $DFD7  8B 1E                       loadB_imm_byte           +30                       ; regB = byte literal (handler $EABE)
  $DFD9  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $DFDA  D8 E8 DF                    branch_z_abs             $DFE8                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $DFDD  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DFE0  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $DFE3  BB                          add                                                ; regA = regA + regB
  $DFE4  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $DFE5  89 1E                       loadA_imm_sbyte          +30                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $DFE7  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$DFE8  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DFEB  D0                          incA                                               ; regA += 1
 >$DFEC  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $DFEF  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $DFF2  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $DFF5  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $DFF6  D7 C9 DF                    branch_nz_abs            $DFC9                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $DFF9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $DFFA  A8 63 6F                    loadA_mem_word           $6F63                     ; regA = word read using <word> as address (handler $EA75)
  $DFFD  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $DFFE   (frame_off=-2, body @ $E003)
; ============================================================
  $E003  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E004  8F 16                       addA_imm_sbyte           +22                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $E006  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E007  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $E009  B6                          div_signed                                         ; regA = regA / regB  (signed quotient)
  $E00A  8F 14                       addA_imm_sbyte           +20                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $E00C  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E00D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E00E  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E00F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E010  8C AB 76                    loadB_imm_word           $76AB                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E013  BB                          add                                                ; regA = regA + regB
  $E014  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E015  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $E016  C8                          cmp_ugt                                            ; regA = (regA > regB) ? 1 : 0   (unsigned)
  $E017  D8 3B E0                    branch_z_abs             $E03B                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E01A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E01B  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E01C  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E01D  8C AB 76                    loadB_imm_word           $76AB                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E020  BB                          add                                                ; regA = regA + regB
  $E021  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E022  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $E023  BC                          sub                                                ; regA = regA - regB
  $E024  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E025  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E026  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E027  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E028  8C A9 76                    loadB_imm_word           $76A9                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E02B  BB                          add                                                ; regA = regA + regB
  $E02C  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $E02D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E02E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E02F  BB                          add                                                ; regA = regA + regB
  $E030  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E031  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E032  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E033  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E034  8C AB 76                    loadB_imm_word           $76AB                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E037  BB                          add                                                ; regA = regA + regB
  $E038  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E039  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E03A  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$E03B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E03C   (frame_off=-12, body @ $E041)
; ============================================================
  $E041  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E045  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $E046  D8 02 A4                    branch_z_abs             $A402                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E049  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $E04A  6F                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 15)
  $E04B  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $E04D  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E04E  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E051  BB                          add                                                ; regA = regA + regB
  $E052  26                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 6)
  $E053  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E056  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $E058  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $E059  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $E05A  A4 57 6F                    loadA_mem_word           $6F57                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E05D  A6 63 6F                    loadB_mem_word           $6F63                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E060  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $E061  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $E062  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E063  D8 80 E0                    branch_z_abs             $E080                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E066  65                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 5)
  $E067  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E06A  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E06B  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E06C  8C A9 76                    loadB_imm_word           $76A9                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E06F  BB                          add                                                ; regA = regA + regB
  $E070  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E071  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E074  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E075  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E076  8C A9 76                    loadB_imm_word           $76A9                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E079  BB                          add                                                ; regA = regA + regB
  $E07A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E07B  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E07C  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E080  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E081  D7 A6 E0                    branch_nz_abs            $E0A6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E084  AC 73 DF                    host_call_simple         $DF73 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E087  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $E088  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E08C  FE                          trigger_syscall_EB_FE                              ; BRK to syscall_dispatch (handler $EF92)
  $E08D  DF 04                       loadB_frameaddr          $04                       ; regB = ptr2 + byte  (address of a frame local; handler $EAA0)
  $E08F  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E090  D8 9C E0                    branch_z_abs             $E09C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E093  AA 63 6F AA                 op_AA_wb                 $6F63, $AA
  $E097  5F                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 15)
  $E098  6F                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 15)
  $E099  D6 A2 E0                    jump_abs                 $E0A2                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E09C  AA 5F 6F AA                 op_AA_wb                 $6F5F (selected_province_idx), $AA
  $E0A0  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $E0A1  6F                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 15)
 >$E0A2  E9 3D DF 04                 host_call                $DF3D {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E0A6  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $E0A9  8B 20                       loadB_imm_byte           +32                       ; regB = byte literal (handler $EABE)
  $E0AB  DA                          bitand                                             ; regA = regA & regB
  $E0AC  D7 B3 E0                    branch_nz_abs            $E0B3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E0AF  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E0B0  D7 B7 E0                    branch_nz_abs            $E0B7                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$E0B3  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E0B4  D6 B8 E0                    jump_abs                 $E0B8                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E0B7  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
 >$E0B8  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $E0B9  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $E0BA  D8 CB E0                    branch_z_abs             $E0CB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E0BD  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E0BE  D7 CB E0                    branch_nz_abs            $E0CB                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E0C1  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E0C2  A8 81 6F                    loadA_mem_word           $6F81                     ; regA = word read using <word> as address (handler $EA75)
  $E0C5  A8 7F 6F                    loadA_mem_word           $6F7F                     ; regA = word read using <word> as address (handler $EA75)
  $E0C8  A8 7D 6F                    loadA_mem_word           $6F7D                     ; regA = word read using <word> as address (handler $EA75)
 >$E0CB  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $E0CC  A4 7D 6F                    loadA_mem_word           $6F7D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E0CF  A6 83 6F                    loadB_mem_word           $6F83                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E0D2  BB                          add                                                ; regA = regA + regB
  $E0D3  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $E0D4  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $E0D5  76                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 6)
  $E0D6  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E0D7  A4 7F 6F                    loadA_mem_word           $6F7F                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E0DA  A6 85 6F                    loadB_mem_word           $6F85                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E0DD  BB                          add                                                ; regA = regA + regB
  $E0DE  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $E0DF  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $E0E0  8F 10                       addA_imm_sbyte           +16                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $E0E2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E0E3  A4 81 6F                    loadA_mem_word           $6F81                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E0E6  A6 87 6F                    loadB_mem_word           $6F87                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E0E9  BB                          add                                                ; regA = regA + regB
  $E0EA  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
  $E0EB  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $E0EC  D8 06 E1                    branch_z_abs             $E106                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E0EF  6A                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 10)
  $E0F0  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E0F4  7A                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 10)
  $E0F5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E0F6  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $E0F7  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $E0F8  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E0F9  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E0FA  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E0FE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E0FF  06                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 6)
  $E100  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $E101  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $E102  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E103  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E104  BC                          sub                                                ; regA = regA - regB
  $E105  B1                          storeA_ind_word                                    ; word at [regB] = regA; regB is popped from the VM data stack
 >$E106  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E109  8C 15 6E                    loadB_imm_word           $6E15                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E10C  BB                          add                                                ; regA = regA + regB
  $E10D  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E10E  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E10F  D7 20 E1                    branch_nz_abs            $E120                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E112  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $E113  E9 E5 D9 02                 host_call                $D9E5 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E117  D8 20 E1                    branch_z_abs             $E120                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E11A  AC C1 DE                    host_call_simple         $DEC1 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E11D  D6 9C E1                    jump_abs                 $E19C                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E120  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E121  D8 9C E1                    branch_z_abs             $E19C                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E124  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E125  D8 78 E1                    branch_z_abs             $E178                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E128  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E12B  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E12E  BB                          add                                                ; regA = regA + regB
  $E12F  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E130  D8 6E E1                    branch_z_abs             $E16E                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E133  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E134  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E135  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E136  E9 0E DC 02                 host_call                $DC0E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E13A  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E13B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E13C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E13D  E9 3C DC 02                 host_call                $DC3C {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E141  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E142  D6 65 E1                    jump_abs                 $E165                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E145  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E146  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E147  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E148  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E149  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E14D  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $E14E  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $E14F  D8 63 E1                    branch_z_abs             $E163                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E152  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E153  A6 63 6F                    loadB_mem_word           $6F63                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E156  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E157  D8 63 E1                    branch_z_abs             $E163                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E15A  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E15B  E9 C8 D9 02                 host_call                $D9C8 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E15F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E160  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $E162  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$E163  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E164  D0                          incA                                               ; regA += 1
 >$E165  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E166  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E167  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E16A  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $E16B  D7 45 E1                    branch_nz_abs            $E145                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$E16E  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E172  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $E173  E2 02                       op_E2_byte               $02                       ; fetch byte, jsr $F62C with Y=0x0C (handler $EF6A)
  $E175  D6 9C E1                    jump_abs                 $E19C                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E178  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $E179  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E17C  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E17D  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E181  C8                          cmp_ugt                                            ; regA = (regA > regB) ? 1 : 0   (unsigned)
  $E182  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $E183  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E184  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E185  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $E189  8D D9                       op_8D_sbyte              -39
  $E18B  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E18C  D8 93 E1                    branch_z_abs             $E193                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E18F  45                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $E190  D6 94 E1                    jump_abs                 $E194                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E193  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$E194  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E195  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E199  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $E19A  E5 02                       branch_z_rel             +2                        ; if regA == 0: ptr3 += signed byte (handler $EBF3)
 >$E19C  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E19D  D7 C7 E1                    branch_nz_abs            $E1C7                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  ; ---- overlap: $E19E re-entered mid-stream ----
 >$E19E  C7                          cmp_ule                                            ; regA = (regA <= regB) ? 1 : 0  (unsigned)
  $E19F  E1 09                       op_E1_byte               $09                       ; fetch byte, jsr $F5CD with Y=8 (handler $EF5F)
  ; ---- overlap: $E1A0 re-entered mid-stream ----
  $E1A0  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E1A1  D8 C7 E1                    branch_z_abs             $E1C7                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E1A4  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E1A7  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E1AA  BB                          add                                                ; regA = regA + regB
  $E1AB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E1AC  A5 65 6F                    loadA_mem_byte           $6F65                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $E1AF  57                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 7)
  $E1B0  BF                          ashr_by_regB                                       ; regA >>= regB  (arithmetic shift right by regB count)
  $E1B1  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E1B2  A4 63 6F                    loadA_mem_word           $6F63                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E1B5  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E1B8  BB                          add                                                ; regA = regA + regB
  $E1B9  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E1BA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E1BB  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E1BE  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E1C1  BB                          add                                                ; regA = regA + regB
  $E1C2  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $E1C3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E1C4  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E1C5  DC                          bitxor                                             ; regA = regA ^ regB
  $E1C6  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$E1C7  89 8F                       loadA_imm_sbyte          -113                      ; regA = sign-extended signed byte literal (handler $EAAF)
  $E1C9  CD                          swap_AB                                            ; regA <-> regB
  $E1CA  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $E1CD  DA                          bitand                                             ; regA = regA & regB
  $E1CE  A9 A1 6D                    storeA_mem_byte          $6DA1                     ; byte at absolute address <word> = regA low byte (handler $EB19, normal path $EB12). Word operand, NOT word+byte.
  $E1D1  AC BC DF                    host_call_simple         $DFBC {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E1D4  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E1D8  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $E1D9  D8 02 08                    branch_z_abs             $0802                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E1DC  D7 E6 E1                    branch_nz_abs            $E1E6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E1DF  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $E1E3  36                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 6)
  $E1E4  D8 02 CF                    branch_z_abs             $CF02                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  ; ---- overlap: $E1E6 re-entered mid-stream ----
 >$E1E6  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E1E7   (frame_off=-2, body @ $E1EC)
; ============================================================
  $E1EC  8D 1D                       op_8D_sbyte              +29
  $E1EE  E9 03 CA 02                 host_call                $CA03 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E1F2  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E1F3  D6 11 E2                    jump_abs                 $E211                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E1F6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E1F7  8B 36                       loadB_imm_byte           +54                       ; regB = byte literal (handler $EABE)
  $E1F9  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E1FA  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $E1FB  BB                          add                                                ; regA = regA + regB
  $E1FC  8C 93 61                    loadB_imm_word           $6193                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E1FF  BB                          add                                                ; regA = regA + regB
  $E200  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E201  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E202  8B 36                       loadB_imm_byte           +54                       ; regB = byte literal (handler $EABE)
  $E204  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E205  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $E206  BB                          add                                                ; regA = regA + regB
  $E207  8C 93 61                    loadB_imm_word           $6193                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E20A  BB                          add                                                ; regA = regA + regB
  $E20B  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E20C  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E20D  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E20E  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E20F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E210  D0                          incA                                               ; regA += 1
 >$E211  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E212  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E213  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E216  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $E217  D7 F6 E1                    branch_nz_abs            $E1F6                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E21A  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E21B   (frame_off=+0, body @ $E220)
; ============================================================
  $E220  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E221  8C 15 6E                    loadB_imm_word           $6E15                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E224  BB                          add                                                ; regA = regA + regB
  $E225  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E226  8E FF 00                    push_imm_word            $00FF                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E229  E9 0E DC 02                 host_call                $DC0E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E22D  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E22E  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E22F  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E233  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E234  E9 B2 DC 02                 host_call                $DCB2 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E238  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E239  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E23D  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $E23E  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E23F  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E242  BB                          add                                                ; regA = regA + regB
  $E243  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E244  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E248  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E249  D0                          incA                                               ; regA += 1
  $E24A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E24B  8E 35 F7                    push_imm_word            $F735                     ; " is now\nfief %2d`s daimyo"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E24E  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E252  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E253  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E256  BB                          add                                                ; regA = regA + regB
  $E257  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E258  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E259  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E25A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E25B  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E25E  BB                          add                                                ; regA = regA + regB
  $E25F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E260  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $E261  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E262  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E263  E9 81 DD 02                 host_call                $DD81 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E267  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E268  E9 97 DB 02                 host_call                $DB97 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E26C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E26D  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E271  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E274  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E275   (frame_off=+0, body @ $E27A)
; ============================================================
  $E27A  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E27B  E9 E7 E1 02                 host_call                $E1E7 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E27F  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E280  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E284  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $E285  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E286  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E289  BB                          add                                                ; regA = regA + regB
  $E28A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E28B  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E28F  8E 4F F7                    push_imm_word            $F74F                     ; " was\nkilled"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E292  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E296  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E297  E9 8D D9 02                 host_call                $D98D {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E29B  D8 AB E2                    branch_z_abs             $E2AB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E29E  AA 9F 6D 0C                 op_AA_wb                 $6D9F, $0C
  $E2A2  D0                          incA                                               ; regA += 1
  $E2A3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E2A4  8E 5B F7                    push_imm_word            $F75B                     ; " in fief %2d\nin the year %d"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E2A7  E9 34 D1 06                 host_call                $D134 (ui_helper_d134) {bytecode}, $06 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E2AB  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E2AE  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E2AF   (frame_off=-4, body @ $E2B4)
; ============================================================
  $E2B4  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E2B5  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E2B6  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E2B7  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E2B8  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E2B9  8C A9 76                    loadB_imm_word           $76A9                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E2BC  BB                          add                                                ; regA = regA + regB
  $E2BD  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E2BE  D6 CF E2                    jump_abs                 $E2CF                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E2C1  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E2C2  D0                          incA                                               ; regA += 1
  $E2C3  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E2C4  D1                          decA                                               ; regA -= 1
  $E2C5  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E2C6  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E2C7  D0                          incA                                               ; regA += 1
  $E2C8  2D                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $E2C9  D1                          decA                                               ; regA -= 1
  $E2CA  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E2CB  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E2CC  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E2CD  D0                          incA                                               ; regA += 1
  $E2CE  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$E2CF  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E2D0  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E2D1  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $E2D2  D7 C1 E2                    branch_nz_abs            $E2C1                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E2D5  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E2D6   (frame_off=+0, body @ $E2DB)
; ============================================================
  $E2DB  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E2DE  8E 77 F7                    push_imm_word            $F777                     ; "Lord "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E2E1  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E2E5  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E2E9  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $E2EA  D7 02 59                    branch_nz_abs            $5902                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E2ED  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E2EE  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E2F1  BB                          add                                                ; regA = regA + regB
  $E2F2  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E2F3  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E2F7  8E 7D F7                    push_imm_word            $F77D                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E2FA  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E2FE  AC 7E D7                    host_call_simple         $D77E (ui_helper_d77e) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E301  59                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 9)
  $E302  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E303  8C A8 77                    loadB_imm_word           $77A8 (daimyo_name_table) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E306  BB                          add                                                ; regA = regA + regB
  $E307  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E308  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E30C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E30D  8E 7F F7                    push_imm_word            $F77F                     ; " wants a\n%s\n"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E310  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E314  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E315 (marry_helper_e315)   (frame_off=-6, body @ $E31A)
; ============================================================
  $E31A  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E31E  8D D9                       op_8D_sbyte              -39
  $E320  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E321  D8 61 E3                    branch_z_abs             $E361                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E324  A4 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E327  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $E328  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $E329  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $E32C  8E 98 F7                    push_imm_word            $F798                     ; "marriage pact"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E32F  E9 D6 E2 02                 host_call                $E2D6 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E333  8E A6 F7                    push_imm_word            $F7A6                     ; "accept"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E336  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E33A  AC A7 D3                    host_call_simple         $D3A7 (ui_helper_d3a7) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E33D  D8 59 E3                    branch_z_abs             $E359                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E340  8E 8C F7                    push_imm_word            $F78C                     ; "Demand gold"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E343  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E347  8E 0F 27                    push_imm_word            $270F                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E34A  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $E34B  E9 E9 D5 04                 host_call                $D5E9 (number_input) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E34F  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E350  D7 5B E3                    branch_nz_abs            $E35B                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E353  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E356  D6 5B E3                    jump_abs                 $E35B                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E359  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E35A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
 >$E35B  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E35C  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $E35F  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E360  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$E361  AA 63 6D E9                 op_AA_wb                 $6D63 (const_two), $E9
  $E365  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $E366  CA                          is_zero                                            ; regA = (regA == 0) ? 1 : 0   (logical NOT)
  $E367  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E368  D7 A2 E3                    branch_nz_abs            $E3A2                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E36B  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $E36F  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $E370  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $E371  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E372  D8 7D E3                    branch_z_abs             $E37D                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E375  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $E376  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E37A  D7 A2 E3                    branch_nz_abs            $E3A2                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$E37D  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E380  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $E382  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E383  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E386  BB                          add                                                ; regA = regA + regB
  $E387  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E388  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E389  8C C8 00                    loadB_imm_word           $00C8                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E38C  C4                          cmp_sgt                                            ; regA = (regA > regB) ? 1 : 0   (signed)
  $E38D  D8 A2 E3                    branch_z_abs             $E3A2                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E390  8D 1E                       op_8D_sbyte              +30
  $E392  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E396  8F 32                       addA_imm_sbyte           +50                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $E398  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E399  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $E39A  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E39E  90 C8 00                    op_90_bb                 $C8, $00
  $E3A1  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$E3A2  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E3A3  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E3A4 (diplomacy_helper)   (frame_off=-6, body @ $E3A9)
; ============================================================
  $E3A9  AA 63 6F E9                 op_AA_wb                 $6F63, $E9
  $E3AD  8D D9                       op_8D_sbyte              -39
  $E3AF  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E3B0  D8 DE E3                    branch_z_abs             $E3DE                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E3B3  A4 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E3B6  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $E3B7  42                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $E3B8  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $E3BB  8E AD F7                    push_imm_word            $F7AD                     ; "pact"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E3BE  E9 D6 E2 02                 host_call                $E2D6 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E3C2  8E 8C F7                    push_imm_word            $F78C                     ; "Demand gold"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E3C5  E9 C4 CE 02                 host_call                $CEC4 (redraw_window) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E3C9  8E 0F 27                    push_imm_word            $270F                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E3CC  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $E3CD  E9 E9 D5 04                 host_call                $D5E9 (number_input) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E3D1  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E3D2  D7 D8 E3                    branch_nz_abs            $E3D8                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E3D5  AC 89 CC                    host_call_simple         $CC89 (ui_helper_cc89) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
 >$E3D8  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E3D9  A8 D3 7F                    loadA_mem_word           $7FD3                     ; regA = word read using <word> as address (handler $EA75)
  $E3DC  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E3DD  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$E3DE  AA 5F 6F E9                 op_AA_wb                 $6F5F (selected_province_idx), $E9
  $E3E2  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $E3E3  D9                          op_D9                                              ; handler $EC1D (TBD — reads via ptr3)
  $E3E4  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E3E5  D8 F0 E3                    branch_z_abs             $E3F0                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E3E8  63                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 3)
  $E3E9  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E3ED  D7 23 E4                    branch_nz_abs            $E423                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$E3F0  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E3F3  8B 1A                       loadB_imm_byte           +26                       ; regB = byte literal (handler $EABE)
  $E3F5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E3F6  8C 01 70                    loadB_imm_word           $7001 (province_table_live) ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E3F9  BB                          add                                                ; regA = regA + regB
  $E3FA  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E3FB  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E3FC  AA 63 6D E9                 op_AA_wb                 $6D63 (const_two), $E9
  $E400  52                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 2)
  $E401  CA                          is_zero                                            ; regA = (regA == 0) ? 1 : 0   (logical NOT)
  $E402  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E403  D7 21 E4                    branch_nz_abs            $E421                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E406  8D 32                       op_8D_sbyte              +50
  $E408  E9 52 CA 02                 host_call                $CA52 (ui_helper_ca52) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E40C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E40D  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $E40E  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E412  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E413  8D 32                       op_8D_sbyte              +50
  $E415  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $E416  E9 0D D7 04                 host_call                $D70D (pct_op) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E41A  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $E41B  BB                          add                                                ; regA = regA + regB
  $E41C  8F 14                       addA_imm_sbyte           +20                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $E41E  D6 22 E4                    jump_abs                 $E422                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E421  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
 >$E422  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$E423  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E424  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E425   (frame_off=-2, body @ $E42A)
; ============================================================
  $E42A  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E42B  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E42F  2C                          storeA_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regA
  $E430  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E431  E9 3C DC 02                 host_call                $DC3C {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E435  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E436  D6 4A E4                    jump_abs                 $E44A                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E439  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E43A  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E43E  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $E43F  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $E440  D8 48 E4                    branch_z_abs             $E448                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E443  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E444  E9 54 E4 02                 host_call                $E454 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E448  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E449  D0                          incA                                               ; regA += 1
 >$E44A  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E44B  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E44C  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E44F  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $E450  D7 39 E4                    branch_nz_abs            $E439                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E453  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E454   (frame_off=+0, body @ $E459)
; ============================================================
  $E459  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E45A  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E45D  BB                          add                                                ; regA = regA + regB
  $E45E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E45F  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E462  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E463  D8 A1 E4                    branch_z_abs             $E4A1                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E466  8E B2 F7                    push_imm_word            $F7B2                     ; "Fief "  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E469  E9 26 D3 02                 host_call                $D326 (message_display) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E46D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E46E  D0                          incA                                               ; regA += 1
  $E46F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E470  8E B8 F7                    push_imm_word            $F7B8                     ; "%d lost its\nleader"  | Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E473  E9 34 D1 04                 host_call                $D134 (ui_helper_d134) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E477  AC 66 D7                    host_call_simple         $D766 (confirm_prompt) {bytecode} ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E47A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E47B  8C F7 6C                    loadB_imm_word           $6CF7                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E47E  BB                          add                                                ; regA = regA + regB
  $E47F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E480  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $E482  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E483  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E484  8C A2 6D                    loadB_imm_word           $6DA2                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E487  BB                          add                                                ; regA = regA + regB
  $E488  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E489  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E48A  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E48B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E48C  8C 2D 6D                    loadB_imm_word           $6D2D                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E48F  BB                          add                                                ; regA = regA + regB
  $E490  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E491  89 14                       loadA_imm_sbyte          +20                       ; regA = sign-extended signed byte literal (handler $EAAF)
  $E493  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E494  8E A3 77                    push_imm_word            $77A3                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E497  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E498  E9 AF E2 04                 host_call                $E2AF {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E49C  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E49D  E9 54 E5 02                 host_call                $E554 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E4A1  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E4A2   (frame_off=-4, body @ $E4A7)
; ============================================================
  $E4A7  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E4AA  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E4AB  8A 89 6F                    loadA_imm_word           $6F89                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $E4AE  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E4AF  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E4B0  D6 C6 E4                    jump_abs                 $E4C6                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E4B3  AC A9 D9                    host_call_simple         $D9A9 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E4B6  D8 C2 E4                    branch_z_abs             $E4C2                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E4B9  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E4BA  D0                          incA                                               ; regA += 1
  $E4BB  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E4BC  D1                          decA                                               ; regA -= 1
  $E4BD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E4BE  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E4C1  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$E4C2  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E4C5  D0                          incA                                               ; regA += 1
 >$E4C6  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $E4C9  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E4CC  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E4CF  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $E4D0  D7 B3 E4                    branch_nz_abs            $E4B3                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E4D3  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E4D4  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $E4D6  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E4D7  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E4D8  A8 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word read using <word> as address (handler $EA75)
  $E4DB  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E4DC (marry_helper_e4dc)   (frame_off=-4, body @ $E4E1)
; ============================================================
  $E4E1  AC A2 E4                    host_call_simple         $E4A2 {bytecode}          ; JSR to native function / bytecode subroutine at <word>; no ptr1 adjust
  $E4E4  8A 89 6F                    loadA_imm_word           $6F89                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $E4E7  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E4E8  D6 01 E5                    jump_abs                 $E501                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E4EB  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E4EC  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E4ED  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E4EE  E9 72 D7 02                 host_call                $D772 (ui_helper_d772) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E4F2  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $E4F3  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E4F4  D8 FF E4                    branch_z_abs             $E4FF                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E4F7  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E4F8  D0                          incA                                               ; regA += 1
  $E4F9  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E4FA  D1                          decA                                               ; regA -= 1
  $E4FB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E4FC  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E4FD  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E4FE  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
 >$E4FF  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E500  D0                          incA                                               ; regA += 1
 >$E501  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E502  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E503  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E504  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E507  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E508  D7 EB E4                    branch_nz_abs            $E4EB                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E50B  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $E50C  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $E50E  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E50F  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E510 (ui_helper_e510)   (frame_off=-6, body @ $E515)
; ============================================================
  $E515  8A 89 6F                    loadA_imm_word           $6F89                     ; regA = 16-bit word literal (handler $EAB9). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB55).
  $E518  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $E519  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E51A  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E51B  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E51C  D6 45 E5                    jump_abs                 $E545                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E51F  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E520  E9 99 D9 02                 host_call                $D999 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E524  D7 43 E5                    branch_nz_abs            $E543                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E527  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E528  E9 B7 D9 02                 host_call                $D9B7 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E52C  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $E52D  DC                          bitxor                                             ; regA = regA ^ regB
  $E52E  D7 43 E5                    branch_nz_abs            $E543                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E531  A4 5F 6F                    loadA_mem_word           $6F5F (selected_province_idx) ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E534  1B                          loadB_local_neg                                    ; regB = word at frame[-24 + 2*(n-0x10)]  (inline operand = 11)
  $E535  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E536  D8 43 E5                    branch_z_abs             $E543                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E539  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E53A  D0                          incA                                               ; regA += 1
  $E53B  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $E53C  D1                          decA                                               ; regA -= 1
  $E53D  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E53E  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E53F  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E540  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E541  D0                          incA                                               ; regA += 1
  $E542  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
 >$E543  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E544  D0                          incA                                               ; regA += 1
 >$E545  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E546  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E547  A6 9D 6D                    loadB_mem_word           $6D9D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E54A  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $E54B  D7 1F E5                    branch_nz_abs            $E51F                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E54E  39                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 9)
  $E54F  89 FF                       loadA_imm_sbyte          -1                        ; regA = sign-extended signed byte literal (handler $EAAF)
  $E551  D4                          storeA_ind_byte                                    ; byte at [regB] = regA low byte; regB popped from VM data stack
  $E552  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E553  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E554   (frame_off=-40, body @ $E559)
; ============================================================
  $E559  A4 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E55C  58                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 8)
  $E55D  C7                          cmp_ule                                            ; regA = (regA <= regB) ? 1 : 0  (unsigned)
  $E55E  D8 94 E5                    branch_z_abs             $E594                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E561  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E564  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E565  A4 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E568  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E569  8D 22                       op_8D_sbyte              +34
  $E56B  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E56D  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $E56E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E56F  A4 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E572  8B 22                       loadB_imm_byte           +34                       ; regB = byte literal (handler $EABE)
  $E574  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E575  8C 3C 9E                    loadB_imm_word           $9E3C                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E578  BB                          add                                                ; regA = regA + regB
  $E579  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E57A  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E57B  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E57F  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E581  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $E582  85 D8                       op_85_byte               $D8
 >$E584  81 D8                       op_81_byte               $D8
  $E586  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E587  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E58A  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E58B  D7 95 E5                    branch_nz_abs            $E595                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$E58E  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $E58F  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E590  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E594  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return
 >$E595  81 D8                       op_81_byte               $D8
  $E597  D0                          incA                                               ; regA += 1
  $E598  85 D8                       op_85_byte               $D8
  $E59A  D1                          decA                                               ; regA -= 1
  $E59B  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E59C  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  $E59F  81 D8                       op_81_byte               $D8
  $E5A1  D0                          incA                                               ; regA += 1
  $E5A2  85 D8                       op_85_byte               $D8
  $E5A4  D1                          decA                                               ; regA -= 1
  $E5A5  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E5A6  A8 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word read using <word> as address (handler $EA75)
  $E5A9  81 D8                       op_81_byte               $D8
  $E5AB  D0                          incA                                               ; regA += 1
  $E5AC  85 D8                       op_85_byte               $D8
  $E5AE  D1                          decA                                               ; regA -= 1
  $E5AF  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E5B0  1C                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $E5B1  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $E5B2  D8 84 E5                    branch_z_abs             $E584                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E5B5  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E5B6  A4 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E5B9  8F FC                       addA_imm_sbyte           -4                        ; regA += sign-extended signed byte literal (handler $EAD9)
  $E5BB  8B 1C                       loadB_imm_byte           +28                       ; regB = byte literal (handler $EABE)
  $E5BD  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E5BE  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E5BF  A4 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E5C2  8C C0 01                    loadB_imm_word           $01C0                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E5C5  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E5C6  B4                          popB                                               ; regB = pop from VM data stack (handler $ECD5 -> $ECDB)
  $E5C7  BB                          add                                                ; regA = regA + regB
  $E5C8  A6 CD 7F                    loadB_mem_word           $7FCD                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E5CB  BB                          add                                                ; regA = regA + regB
  $E5CC  8C 5A 8D                    loadB_imm_word           $8D5A                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E5CF  BB                          add                                                ; regA = regA + regB
  $E5D0  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E5D1  AA CF 7F 8D                 op_AA_wb                 $7FCF, $8D
  $E5D5  1D                          loadB_local_pos                                    ; regB = word at frame[+0x0B/0x0D/0x0F/0x11]
  $E5D6  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E5D9  78                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 8)
  $E5DA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E5DB  E9 5E CB 04                 host_call                $CB5E (ui_helper_cb5e) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E5DF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E5E0  AA CF 7F AA                 op_AA_wb                 $7FCF, $AA
  $E5E4  CD                          swap_AB                                            ; regA <-> regB
  $E5E5  7F                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 15)
  $E5E6  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E5EA  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E5EB  E9 6E DB 02                 host_call                $DB6E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E5EF  D6 8E E5                    jump_abs                 $E58E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)

; ============================================================
; sub $E5F2 (map_helper_e5f2)   (frame_off=-40, body @ $E5F7)
; ============================================================
  $E5F7  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E5F8  A6 5D 6F                    loadB_mem_word           $6F5D                     ; regB = word at absolute address <word> (handler $EA5C, normal path $EA4B). Word operand, NOT word+byte.
  $E5FB  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E5FC  D8 93 E6                    branch_z_abs             $E693                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E5FF  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $E600  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E604  61                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 1)
  $E605  8D 13                       op_8D_sbyte              +19
  $E607  8D 1F                       op_8D_sbyte              +31
  $E609  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E60A  8D 1E                       op_8D_sbyte              +30
  $E60C  E9 42 CC 0A                 host_call                $CC42 {bytecode}, $0A     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E610  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E611  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E612  8C C0 01                    loadB_imm_word           $01C0                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E615  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E616  8C 5C 8D                    loadB_imm_word           $8D5C                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E619  BB                          add                                                ; regA = regA + regB
  $E61A  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E61B  8D 13                       op_8D_sbyte              +19
  $E61D  8D 1D                       op_8D_sbyte              +29
  $E61F  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E620  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $E621  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E625  62                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 2)
  $E626  8E C8 23                    push_imm_word            $23C8                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E629  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E62A  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E62B  BD                          shl_by_regB                                        ; regA <<= regB  (shift left by regB count)
  $E62C  8C 1C 9D                    loadB_imm_word           $9D1C                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E62F  BB                          add                                                ; regA = regA + regB
  $E630  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E631  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E632  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E636  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E637  A8 5D 6F                    loadA_mem_word           $6F5D                     ; regA = word read using <word> as address (handler $EA75)
  $E63A  A4 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E63D  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E63E  A4 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E641  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E642  8D 22                       op_8D_sbyte              +34
  $E644  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E646  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $E647  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E648  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E649  8B 22                       loadB_imm_byte           +34                       ; regB = byte literal (handler $EABE)
  $E64B  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E64C  8C 3C 9E                    loadB_imm_word           $9E3C                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E64F  BB                          add                                                ; regA = regA + regB
  $E650  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E651  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E652  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E656  DE DA                       loadA_frameaddr          $DA                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E658  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $E659  85 D8                       op_85_byte               $D8
  $E65B  D6 7E E6                    jump_abs                 $E67E                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E65E  81 D8                       op_81_byte               $D8
  $E660  D0                          incA                                               ; regA += 1
  $E661  85 D8                       op_85_byte               $D8
  $E663  D1                          decA                                               ; regA -= 1
  $E664  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E665  A8 CD 7F                    loadA_mem_word           $7FCD                     ; regA = word read using <word> as address (handler $EA75)
  $E668  81 D8                       op_81_byte               $D8
  $E66A  D0                          incA                                               ; regA += 1
  $E66B  85 D8                       op_85_byte               $D8
  $E66D  D1                          decA                                               ; regA -= 1
  $E66E  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E66F  A8 CF 7F                    loadA_mem_word           $7FCF                     ; regA = word read using <word> as address (handler $EA75)
  $E672  81 D8                       op_81_byte               $D8
  $E674  D0                          incA                                               ; regA += 1
  $E675  85 D8                       op_85_byte               $D8
  $E677  D1                          decA                                               ; regA -= 1
  $E678  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E679  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E67A  E9 6E DB 02                 host_call                $DB6E {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E67E  81 D8                       op_81_byte               $D8
  $E680  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E681  8C FF 00                    loadB_imm_word           $00FF                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E684  C1                          cmp_ne                                             ; regA = (regA != regB) ? 1 : 0
  $E685  D7 5E E6                    branch_nz_abs            $E65E                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E688  3A                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 10)
  $E689  3B                          storeB_local_neg                                   ; word at frame[-24 + 2*(n-0x30)] = regB  (inline operand = 11)
  $E68A  E9 7B CC 04                 host_call                $CC7B (ui_helper_cc7b) {bytecode}, $04 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E68E  60                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 0)
  $E68F  E9 35 CC 02                 host_call                $CC35 (marry_helper_cc35) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E693  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E694   (frame_off=+0, body @ $E699)
; ============================================================
  $E699  A4 9D 6D                    loadA_mem_word           $6D9D                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E69C  8B 32                       loadB_imm_byte           +50                       ; regB = byte literal (handler $EABE)
  $E69E  C0                          cmp_eq                                             ; regA = (regA == regB) ? 1 : 0
  $E69F  D8 AB E6                    branch_z_abs             $E6AB                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E6A2  A4 DD 7F                    loadA_mem_word           $7FDD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E6A5  8C A6 FE                    loadB_imm_word           $FEA6                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E6A8  D6 B1 E6                    jump_abs                 $E6B1                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E6AB  A4 DD 7F                    loadA_mem_word           $7FDD                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E6AE  8C D8 FE                    loadB_imm_word           $FED8                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
 >$E6B1  BB                          add                                                ; regA = regA + regB
  $E6B2  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E6B3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E6B4  E9 F2 E5 02                 host_call                $E5F2 (map_helper_e5f2) {bytecode}, $02 ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E6B8  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E6B9   (frame_off=-10, body @ $E6BE)
; ============================================================
  $E6BE  A4 5B 6F                    loadA_mem_word           $6F5B                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E6C1  D2                          aslA                                               ; regA <<= 1
  $E6C2  8C B1 6E                    loadB_imm_word           $6EB1                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E6C5  BB                          add                                                ; regA = regA + regB
  $E6C6  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E6C7  2B                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 11)
  $E6C8  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E6C9  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E6CA  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $E6CB  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $E6CC  0B                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 11)
  $E6CD  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E6CE  BA                          mod_unsigned                                       ; regA = regA % regB  (unsigned remainder)
  $E6CF  2A                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 10)
  $E6D0  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E6D1  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E6D2  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $E6D3  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $E6D4  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E6D5  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E6D6  BA                          mod_unsigned                                       ; regA = regA % regB  (unsigned remainder)
  $E6D7  29                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 9)
  $E6D8  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E6D9  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E6DA  B8                          div_unsigned                                       ; regA = regA / regB  (unsigned quotient)
  $E6DB  27                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 7)
  $E6DC  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E6DD  55                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 5)
  $E6DE  BA                          mod_unsigned                                       ; regA = regA % regB  (unsigned remainder)
  $E6DF  28                          storeA_local_neg                                   ; word at frame[-24 + 2*(n-0x20)] = regA  (inline operand = 8)
  $E6E0  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $E6E1  8E B0 15                    push_imm_word            $15B0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E6E4  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E6E5  8C C0 00                    loadB_imm_word           $00C0                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E6E8  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E6E9  8C 04 A6                    loadB_imm_word           $A604                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E6EC  BB                          add                                                ; regA = regA + regB
  $E6ED  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E6EE  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $E6EF  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E6F3  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $E6F4  8E 70 16                    push_imm_word            $1670                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E6F7  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E6F8  8B 60                       loadB_imm_byte           +96                       ; regB = byte literal (handler $EABE)
  $E6FA  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E6FB  8C C4 A9                    loadB_imm_word           $A9C4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E6FE  BB                          add                                                ; regA = regA + regB
  $E6FF  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E700  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $E701  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E705  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $E706  8E D0 16                    push_imm_word            $16D0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E709  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E70A  8B 60                       loadB_imm_byte           +96                       ; regB = byte literal (handler $EABE)
  $E70C  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E70D  8C A4 AB                    loadB_imm_word           $ABA4                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E710  BB                          add                                                ; regA = regA + regB
  $E711  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E712  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $E713  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E717  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $E718  8E 30 17                    push_imm_word            $1730                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E71B  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $E71C  8C C0 00                    loadB_imm_word           $00C0                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E71F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E720  8C 84 AD                    loadB_imm_word           $AD84                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E723  BB                          add                                                ; regA = regA + regB
  $E724  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E725  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $E726  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E72A  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $E72B  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E72C  0A                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 10)
  $E72D  5C                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 12)
  $E72E  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E72F  8C 34 AE                    loadB_imm_word           $AE34                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E732  BB                          add                                                ; regA = regA + regB
  $E733  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E734  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $E735  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E739  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $E73A  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E73B  7C                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 12)
  $E73C  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E73D  09                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 9)
  $E73E  56                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 6)
  $E73F  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E740  8C 70 AE                    loadB_imm_word           $AE70                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E743  BB                          add                                                ; regA = regA + regB
  $E744  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E745  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $E746  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E74A  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $E74B  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E74C  8F 12                       addA_imm_sbyte           +18                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $E74E  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E74F  08                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 8)
  $E750  56                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 6)
  $E751  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E752  8C 8E AE                    loadB_imm_word           $AE8E                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E755  BB                          add                                                ; regA = regA + regB
  $E756  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E757  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $E758  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E75C  6C                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 12)
  $E75D  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E75E  8F 18                       addA_imm_sbyte           +24                       ; regA += sign-extended signed byte literal (handler $EAD9)
  $E760  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E761  07                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 7)
  $E762  5C                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 12)
  $E763  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E764  8C AC AE                    loadB_imm_word           $AEAC                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E767  BB                          add                                                ; regA = regA + regB
  $E768  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E769  69                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 9)
  $E76A  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E76E  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E76F (marry_helper_e76f)   (frame_off=-44, body @ $E774)
; ============================================================
  $E774  40                          clearA_40                                          ; regA = 0 (own handler $EA00, same effect as $41-$4F)
  $E775  85 DA                       op_85_byte               $DA
 >$E777  81 DA                       op_81_byte               $DA
  $E779  D2                          aslA                                               ; regA <<= 1
  $E77A  8C CC F7                    loadB_imm_word           $F7CC                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E77D  BB                          add                                                ; regA = regA + regB
  $E77E  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E77F  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E780  87 DA                       op_87_byte               $DA
  $E782  E9 8B CF 04                 host_call                $CF8B {bytecode}, $04     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E786  81 DA                       op_81_byte               $DA
  $E788  D0                          incA                                               ; regA += 1
  $E789  85 DA                       op_85_byte               $DA
  $E78B  81 DA                       op_81_byte               $DA
  $E78D  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $E78E  C6                          cmp_uge                                            ; regA = (regA >= regB) ? 1 : 0  (unsigned)
  $E78F  D7 77 E7                    branch_nz_abs            $E777                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E792  A4 5B 6F                    loadA_mem_word           $6F5B                     ; regA = word at absolute address <word> (handler $EA43, normal path $EA37). Classifier mis-sized as word+byte — the $EFD5 fetch is word-only; the extra byte is a not-taken conditional path. Same fix as $A7/$A8.
  $E795  8B 35                       loadB_imm_byte           +53                       ; regB = byte literal (handler $EABE)
  $E797  C9                          cmp_ult                                            ; regA = (regA < regB) ? 1 : 0   (unsigned)
  $E798  D7 A7 E7                    branch_nz_abs            $E7A7                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E79B  AA 5B 6F E9                 op_AA_wb                 $6F5B, $E9
  $E79F  CD                          swap_AB                                            ; regA <-> regB
  $E7A0  D7 02 76                    branch_nz_abs            $7602                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
  $E7A3  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E7A4  D7 EE E7                    branch_nz_abs            $E7EE                     ; if regA != 0: ptr3 = word operand (handler $EBC5). Word operand, NOT sbyte — the classifier mis-sized this; $EFBF fetches 16 bits.
 >$E7A7  AA 5B 6F E9                 op_AA_wb                 $6F5B, $E9
  $E7AB  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $E7AC  DC                          bitxor                                             ; regA = regA ^ regB
  $E7AD  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E7AE  D2                          aslA                                               ; regA <<= 1
  $E7AF  D2                          aslA                                               ; regA <<= 1
  $E7B0  8C D0 BB                    loadB_imm_word           $BBD0                     ; "ng to pieces!"  | regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E7B3  BB                          add                                                ; regA = regA + regB
  $E7B4  85 D8                       op_85_byte               $D8
  $E7B6  64                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 4)
  $E7B7  DE D4                       loadA_frameaddr          $D4                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E7B9  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $E7BA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E7BB  87 D8                       op_87_byte               $D8
  $E7BD  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $E7BE  E9 BD CB 08                 host_call                $CBBD {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E7C2  DE D4                       loadA_frameaddr          $D4                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E7C4  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $E7C5  85 D8                       op_85_byte               $D8
  $E7C7  81 D8                       op_81_byte               $D8
  $E7C9  D0                          incA                                               ; regA += 1
  $E7CA  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E7CB  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E7CC  8E B0 15                    push_imm_word            $15B0                     ; Push a 16-bit word literal from the bytecode stream onto the VM data stack (handler $EAD3: jsr $EFBF 16-bit fetch, jmp $F008 push). Classifier mis-sized this as a 1-byte operand — $EFBF fetches a word, same mis-sizing as $D6/$D7/$D8/$8A/$8C.
  $E7CF  81 D8                       op_81_byte               $D8
  $E7D1  72                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 2)
  $E7D2  B0                          loadA_ind_word                                     ; regA = word at [regA]  (dereference regA as pointer)
  $E7D3  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E7D4  81 D8                       op_81_byte               $D8
  $E7D6  D3                          loadA_ind_byte                                     ; regA = byte at [regA], zero-extended
  $E7D7  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E7D8  E9 7C CF 08                 host_call                $CF7C {bytecode}, $08     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E7DC  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $E7DD  AA 5B 6F E9                 op_AA_wb                 $6F5B, $E9
  $E7E1  66                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 6)
  $E7E2  DC                          bitxor                                             ; regA = regA ^ regB
  $E7E3  02                          loadA_local_neg                                    ; regA = word at frame[-24 + 2*n]  (n = opcode & 0x0F)  (inline operand = 2)
  $E7E4  8B 24                       loadB_imm_byte           +36                       ; regB = byte literal (handler $EABE)
  $E7E6  B5                          mul                                                ; regA = regA * regB  (16-bit shift-add multiply)
  $E7E7  8C 44 B1                    loadB_imm_word           $B144                     ; regB = 16-bit word literal (handler $EAC8). Classifier mis-tagged as byte+sbyte; confirmed word by the 9999-clamp sites (e.g. bank 1 $AB49 'loadB_imm_word 9999').
  $E7EA  BB                          add                                                ; regA = regA + regB
  $E7EB  D6 FA E7                    jump_abs                 $E7FA                     ; ptr3 = word operand — unconditional absolute jump (handler $EBBB; fetches a word via $EFBF)
 >$E7EE  DE DC                       loadA_frameaddr          $DC                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E7F0  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
  $E7F1  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E7F2  E9 B9 E6 02                 host_call                $E6B9 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E7F6  68                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 8)
  $E7F7  DE DC                       loadA_frameaddr          $DC                       ; regA = ptr2 + byte  (address of a frame local; handler $EA91)
  $E7F9  FF                          op_FF                                              ; No operand; handler $EF93 (BRK signature byte region)
 >$E7FA  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E7FB  0D                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E7FC  75                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 5)
  $E7FD  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E7FE  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E7FF  75                          addA_imm4                                          ; regA += (opcode & 0x0F)  (16-bit add with carry)  (inline operand = 5)
  $E800  B3                          pushA                                              ; Push regA to VM data stack (handler $ECCE)
  $E801  3D                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E802  3C                          storeB_local_pos                                   ; word at frame[+0x0B/0x0D/0x0F/0x11] = regB
  $E803  E9 54 CC 0C                 host_call                $CC54 {bytecode}, $0C     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
  $E807  41                          clearA                                             ; regA = 0 (shared handler $E9F6)
  $E808  A8 C7 7F                    loadA_mem_word           $7FC7                     ; regA = word read using <word> as address (handler $EA75)
  $E80B  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ============================================================
; sub $E80C (ui_helper_e80c)   (frame_off=+0, body @ $E811)
; ============================================================
  $E811  A5 A1 6D                    loadA_mem_byte           $6DA1                     ; regA = byte at absolute address <word>, zero-extended (handler $EAF9, normal path $EAF0). Word operand (address), NOT word+byte.
  $E814  54                          setB_imm4                                          ; regB = (opcode & 0x0F), high byte 0  (inline operand = 4)
  $E815  DA                          bitand                                             ; regA = regA & regB
  $E816  D8 22 E8                    branch_z_abs             $E822                     ; if regA == 0: ptr3 = word operand (handler $EBD1). The dominant conditional branch — pairs with a cmp_* opcode that leaves 0/1 in regA. Word operand, NOT sbyte.
  $E819  0C                          loadA_local_pos                                    ; regA = word at frame[+0x0B/0x0D/0x0F/0x11]  (handlers $E8C4-$E8D0)
  $E81A  A8 CB 7F                    loadA_mem_word           $7FCB                     ; regA = word read using <word> as address (handler $EA75)
  $E81D  6E                          push_imm4                                          ; Push 16-bit (high=0, low=opcode&0x0F) to VM data stack at ptr1  (inline operand = 14)
  $E81E  E9 B1 CB 02                 host_call                $CBB1 {bytecode}, $02     ; JSR to native function / bytecode subroutine at <word>; ptr1 += <byte> after return
 >$E822  CF                          vm_return                                          ; Restore caller frame from frame[0..7], JMP (ptr0) — VM subroutine return

; ==== summary ====
; 135 subroutines scanned; 3686 instructions decoded (3686 known + 0 unknown opcodes)
; 255 branch targets, 83 unique host_call targets
