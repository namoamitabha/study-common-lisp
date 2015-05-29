This is SBCL 1.2.4.debian, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
* (defmacro do-primes-1 ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
       ((> ,var ,end))
     ,@body))


DO-PRIMES-1
* (do-primes (p 0 19)
  (format t "~d " p))

; in: DO-PRIMES (P 0 19)
;     (DO-PRIMES (P 0 19) (FORMAT T "~d " P))
; 
; caught STYLE-WARNING:
;   undefined function: DO-PRIMES

;     (FORMAT T "~d " P)
; 
; caught WARNING:
;   undefined variable: P

;     (P 0 19)
; 
; caught STYLE-WARNING:
;   undefined function: P
; 
; compilation unit finished
;   Undefined functions:
;     DO-PRIMES P
;   Undefined variable:
;     P
;   caught 1 WARNING condition
;   caught 2 STYLE-WARNING conditions

debugger invoked on a UNDEFINED-FUNCTION in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The function COMMON-LISP-USER::P is undefined.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

("undefined function")
0] 0

* (do-primes-1 (p 0 19)
  (format t "~d " p))

; in: DO-PRIMES-1 (P 0 19)
;     (NEXT-PRIME (1+ P))
; 
; caught STYLE-WARNING:
;   undefined function: NEXT-PRIME
; 
; compilation unit finished
;   Undefined function:
;     NEXT-PRIME
;   caught 1 STYLE-WARNING condition

debugger invoked on a UNDEFINED-FUNCTION in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The function COMMON-LISP-USER::NEXT-PRIME is undefined.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

("undefined function")
0] 0

* (defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))


PRIMEP
* 
NEXT-PRIME
* (do-primes-1 (p 0 19)
  (format t "~d " p))

2 3 5 7 11 13 17 19 
NIL
* (macroexpand-1 '(do-primes-a (p 0 19) (format t "~d " p)))

(DO-PRIMES-A (P 0 19) (FORMAT T "~d " P))
NIL
* *print-pretty*

T
* (setf *print-pretty* nil)

NIL
* (macroexpand-1 '(do-primes-a (p 0 19) (format t "~d " p)))

(DO-PRIMES-A (P 0 19) (FORMAT T "~d " P))
NIL
* (setf *print-pretty* t)

T
* (macroexpand-1 '(do-primes-a (p 0 19) (format t "~d " p)))

(DO-PRIMES-A (P 0 19) (FORMAT T "~d " P))
NIL
* (macroexpand-1 '(do-primes-1 (p 0 19) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))) ((> P 19)) (FORMAT T "~d " P))
T
* (setf *print-pretty* t)

T
* (macroexpand-1 '(do-primes-1 (p 0 19) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))) ((> P 19)) (FORMAT T "~d " P))
T
* (setf *print-pretty* nil)

NIL
* (macroexpand-1 '(do-primes-1 (p 0 19) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))) ((> P 19)) (FORMAT T "~d " P))
T
* (macroexpand '(do-primes-1 (p 0 19) (format t "~d " p)))

(BLOCK NIL (LET ((P (NEXT-PRIME 0))) (TAGBODY (GO #:G760) #:G759 (TAGBODY (FORMAT T "~d " P)) (PSETQ P (NEXT-PRIME (1+ P))) #:G760 (UNLESS (> P 19) (GO #:G759)) (RETURN-FROM NIL (PROGN)))))
T
* (setf *print-pretty* t)

T
* (macroexpand '(do-primes-1 (p 0 19) (format t "~d " p)))

(BLOCK NIL
  (LET ((P (NEXT-PRIME 0)))
    (TAGBODY
      (GO #:G762)
     #:G761
      (TAGBODY (FORMAT T "~d " P))
      (PSETQ P (NEXT-PRIME (1+ P)))
     #:G762
      (UNLESS (> P 19) (GO #:G761))
      (RETURN-FROM NIL (PROGN)))))
T
* (macroexpand-1 '(do-primes-1 (p 0 19) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))) ((> P 19)) (FORMAT T "~d " P))
T
* (macroexpand '(do-primes-1 (p 0 (random 100)) (format t "~d " p)))

(BLOCK NIL
  (LET ((P (NEXT-PRIME 0)))
    (TAGBODY
      (GO #:G764)
     #:G763
      (TAGBODY (FORMAT T "~d " P))
      (PSETQ P (NEXT-PRIME (1+ P)))
     #:G764
      (UNLESS (> P (RANDOM 100)) (GO #:G763))
      (RETURN-FROM NIL (PROGN)))))
T
* (macroexpand-1 '(do-primes-1 (p 0 (random 100)) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P))))
    ((> P (RANDOM 100)))
  (FORMAT T "~d " P))
T
* (macroexpand-1 '(do-primes-1 (p 0 (random 100)) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P))))
    ((> P (RANDOM 100)))
  (FORMAT T "~d " P))
T
* (macroexpand-1 '(do-primes-1 (p 0 29) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))) ((> P 29)) (FORMAT T "~d " P))
T
* (macroexpand-1 '(do-primes-1 (p 0 (29)) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))) ((> P (29))) (FORMAT T "~d " P))
T
* (macroexpand-1 '(do-primes-1 (p 0 (29000000)) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P))))
    ((> P (29000000)))
  (FORMAT T "~d " P))
T
* (setf *print-pretty* nil)

NIL
* (macroexpand-1 '(do-primes-1 (p 0 (29000000)) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P)))) ((> P (29000000))) (FORMAT T "~d " P))
T
* (setf *print-pretty* t)

T
* (macroexpand-1 '(do-primes-1 (p 0 (29000000)) (format t "~d " p)))

(DO ((P (NEXT-PRIME 0) (NEXT-PRIME (1+ P))))
    ((> P (29000000)))
  (FORMAT T "~d " P))
T
* (defmacro do-primes ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	(ending-value ,end))
       ((> ,var ending-value))
     ,@body))

STYLE-WARNING:
   DO-PRIMES is being redefined as a macro when it was previously assumed to be a function.

DO-PRIMES
* (macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))

(DO ((ENDING-VALUE (NEXT-PRIME 0) (NEXT-PRIME (1+ ENDING-VALUE)))
     (ENDING-VALUE 10))
    ((> ENDING-VALUE ENDING-VALUE))
  (PRINT ENDING-VALUE))
T
* (macroexpand-1 '(let ((ending-value 0)) (do-primes (p 0 10) (incf ending-value p)) ending-value))

(LET ((ENDING-VALUE 0))
  (DO-PRIMES (P 0 10)
    (INCF ENDING-VALUE P))
  ENDING-VALUE)
NIL
* (defmacro do-primes ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	(ending-value ,end))
       ((> ,var ending-value))
     ,@body))

STYLE-WARNING: redefining COMMON-LISP-USER::DO-PRIMES in DEFMACRO

DO-PRIMES
* (macroexpand-1 '(let ((ending-value 0)) (do-primes (p 0 10) (incf ending-value p)) ending-value))

(LET ((ENDING-VALUE 0))
  (DO-PRIMES (P 0 10)
    (INCF ENDING-VALUE P))
  ENDING-VALUE)
NIL
* (defmacro do-primes ((var start end) &body body)
  (let ((ending-value-name (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
       ,@body)))

STYLE-WARNING: redefining COMMON-LISP-USER::DO-PRIMES in DEFMACRO

DO-PRIMES
* (macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))

(DO ((ENDING-VALUE (NEXT-PRIME 0) (NEXT-PRIME (1+ ENDING-VALUE)))
     (#:G783 10))
    ((> ENDING-VALUE #:G783))
  (PRINT ENDING-VALUE))
T
* (macroexpand-1 '(let ((ending-value 0)) (do-primes (p 0 10) (incf ending-value p)) ending-value))

(LET ((ENDING-VALUE 0))
  (DO-PRIMES (P 0 10)
    (INCF ENDING-VALUE P))
  ENDING-VALUE)
NIL
* (macroexpand-1 (let ((ending-value 0)) (do-primes (p 0 10) (incf ending-value p)) ending-value))

17
NIL
* (loop for n in '(a b c) collect `(,n (gensym)))

((A (GENSYM)) (B (GENSYM)) (C (GENSYM)))
* (defmacro do-primes ((var start end) &body body)
  (with-gensyms (ending-value-name)
    `(do ((,var (next-prime, start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
       ,@body)))



; in: DEFMACRO DO-PRIMES
;     `(DO ((,VAR (NEXT-PRIME ,START) (NEXT-PRIME (1+ ,VAR)))
;           (,ENDING-VALUE-NAME ,END))
;          ((> ,VAR ,ENDING-VALUE-NAME))
;       ,@BODY)
; --> SB-IMPL::|List*| SB-IMPL::|List| 
; ==>
;   (SB-IMPL::|List| ENDING-VALUE-NAME END)
; 
; caught WARNING:
;   undefined variable: ENDING-VALUE-NAME

;     (ENDING-VALUE-NAME)
; 
; caught STYLE-WARNING:
;   undefined function: ENDING-VALUE-NAME

;     (WITH-GENSYMS (ENDING-VALUE-NAME)
;      `(DO ((,VAR (NEXT-PRIME ,START) (NEXT-PRIME #))
;            (,ENDING-VALUE-NAME ,END))
;           ((> ,VAR ,ENDING-VALUE-NAME))
;        ,@BODY))
; 
; caught STYLE-WARNING:
;   undefined function: WITH-GENSYMS
; 
; compilation unit finished
;   Undefined functions:
;     ENDING-VALUE-NAME WITH-GENSYMS
;   Undefined variable:
;     ENDING-VALUE-NAME
;   caught 1 WARNING condition
;   caught 2 STYLE-WARNING conditions
STYLE-WARNING: redefining COMMON-LISP-USER::DO-PRIMES in DEFMACRO

DO-PRIMES
* (defmacro with-gensyms ((&rest names) &body body)
  `(let ,(looop for n in names collect `(,n (gensym)))
     ,@body))


; in: DEFMACRO WITH-GENSYMS
;     `(LET ,(LOOOP FOR N IN NAMES COLLECT `(,N (GENSYM)))
;        ,@BODY)
; --> SB-IMPL::|List*| 
; ==>
;   (LOOOP FOR N IN NAMES COLLECT `(,N (GENSYM)))
; 
; caught WARNING:
;   undefined variable: COLLECT
; 
; caught WARNING:
;   undefined variable: FOR
; 
; caught WARNING:
;   undefined variable: IN
; 
; caught STYLE-WARNING:
;   undefined function: LOOOP
; 
; caught WARNING:
;   undefined variable: N
; 
; compilation unit finished
;   Undefined function:
;     LOOOP
;   Undefined variables:
;     COLLECT FOR IN N
;   caught 4 WARNING conditions
;   caught 1 STYLE-WARNING condition
STYLE-WARNING:
   WITH-GENSYMS is being redefined as a macro when it was previously assumed to be a function.

WITH-GENSYMS
* (macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))


debugger invoked on a UNDEFINED-FUNCTION in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The function COMMON-LISP-USER::ENDING-VALUE-NAME is undefined.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

("undefined function")
0] 0

* (defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

STYLE-WARNING: redefining COMMON-LISP-USER::WITH-GENSYMS in DEFMACRO

WITH-GENSYMS
* (macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))


debugger invoked on a UNDEFINED-FUNCTION in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The function COMMON-LISP-USER::ENDING-VALUE-NAME is undefined.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

("undefined function")
0] (macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))

; No debug variables for current frame: using EVAL instead of EVAL-IN-FRAME.

debugger invoked on a UNDEFINED-FUNCTION in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The function COMMON-LISP-USER::ENDING-VALUE-NAME is undefined.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Reduce debugger level (to debug level 1).
  1:         Exit debugger, returning to top level.

("undefined function")
0[2] 0

0] 0

* (macroexpand-1 '(with-gensyms '(a b c)))

(LET ((QUOTE (GENSYM)) ((A B C) (GENSYM)))
  )
T
* (macroexpand-1 '(with-gensyms (list a b c)))

(LET ((LIST (GENSYM)) (A (GENSYM)) (B (GENSYM)) (C (GENSYM)))
  )
T
* (macroexpand-1 '(with-gensyms (a b c)))

(LET ((A (GENSYM)) (B (GENSYM)) (C (GENSYM)))
  )
T
* (defmacro do-primes ((var start end) &body body)
  (with-gensyms (ending-value-name)
    `(do ((,var (next-prime, start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
       ,@body)))

STYLE-WARNING: redefining COMMON-LISP-USER::DO-PRIMES in DEFMACRO

DO-PRIMES
* (macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))

(DO ((ENDING-VALUE (NEXT-PRIME 0) (NEXT-PRIME (1+ ENDING-VALUE)))
     (#:G809 10))
    ((> ENDING-VALUE #:G809))
  (PRINT ENDING-VALUE))
T
* (macroexpand-1 '(let ((ending-value 0))
		 (do-primes (p 0 10)
		   (incf ending-value p))
		 ending-value))


(LET ((ENDING-VALUE 0))
  (DO-PRIMES (P 0 10)
    (INCF ENDING-VALUE P))
  ENDING-VALUE)
NIL
* (defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
	  ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
		,@body)))))


ONCE-ONLY
* (defmacro do-primes ((var start end) &body body)
  (once-only (start end)
	     `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
		  ((> ,var ,end))
		,@body)))

STYLE-WARNING: redefining COMMON-LISP-USER::DO-PRIMES in DEFMACRO

DO-PRIMES
* (macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))


(LET ((#:G821 0) (#:G822 10))
  (DO ((ENDING-VALUE (NEXT-PRIME #:G821) (NEXT-PRIME (1+ ENDING-VALUE))))
      ((> ENDING-VALUE #:G822))
    (PRINT ENDING-VALUE)))
T
* 
