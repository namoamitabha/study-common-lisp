(defun add1 (n) (1+ n))

(disassemble 'add1)

; disassembly for ADD1
; Size: 25 bytes. Origin: #xCB7DFE4
; E4:       BF04000000       MOV EDI, 4                       ; no-arg-parsing entry point
; E9:       8BD3             MOV EDX, EBX
; EB:       E8502148F4       CALL #x1000140                   ; GENERIC-+
; F0:       8B5DFC           MOV EBX, [EBP-4]
; F3:       8BE5             MOV ESP, EBP
; F5:       F8               CLC
; F6:       5D               POP EBP
; F7:       C3               RET
; F8:       CC0A             BREAK 10                         ; error trap
; FA:       02               BYTE #X02
; FB:       18               BYTE #X18                        ; INVALID-ARG-COUNT-ERROR
; FC:       8F               BYTE #X8F                        ; ECX
(defun int-add1 (n)
  (declare (fixnum n)
	   (optimize (speed 3) (safety 0) (debug 0)))
  (1+ n))

(disassemble 'int-add1)
; disassembly for INT-ADD1
; Size: 18 bytes. Origin: #xCB68707
; 07:       40               INC EAX                          ; no-arg-parsing entry point
; 08:       6BD004           IMUL EDX, EAX, 4
; 0B:       7107             JNO L0
; 0D:       8BD0             MOV EDX, EAX
; 0F:       E8A17E49F4       CALL #x10005B5                   ; ALLOC-SIGNED-BIGNUM-IN-EDX
; 14: L0:   8BE5             MOV ESP, EBP
; 16:       F8               CLC
; 17:       5D               POP EBP
; 18:       C3               RET

;;********************
(defun test-break (n)
  (let ((m 0))
    (loop
       (when (> m n) (return))
       ;;(break)
       (print m)
       (incf m))))

(step (test-break 20))

;;********************
(defun factorial (n)
  (if (plusp n)
      (* n (factorial (1- n)))
      1))

(trace factorial)
(factorial 6)
(untrace factorial)
(factorial 6)

(step (factorial 6))
