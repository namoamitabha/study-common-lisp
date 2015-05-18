(defun verbose-sum (x y)
  "Sum any two numbers after printing a message."
  (format t "Summing ~d and ~d.~%" x y)
  (+ x y))


VERBOSE-SUM
* (verbose-sum 2 3)
Summing 2 and 3.
5
* (documentation 'verbose-sum 'function)

"Sum any two numbers after printing a message."
* call-arguments-limit

4611686018427387903
* (defun foo (a b &optional c d)
  (list a b c d))


FOO
* (foo 1 2)

(1 2 NIL NIL)
* (foo 1 2 3)

(1 2 3 NIL)
* (foo 1 2 3 4)

(1 2 3 4)
* (defun foo (a &optional (b 10))
  (list a b))

STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo 1 2)

(1 2)
* (foo 1)

(1 10)
* (defun make-rectangle (width &optional (height widtch))
  (list widtch height))

; in: DEFUN MAKE-RECTANGLE
;     (SB-INT:NAMED-LAMBDA MAKE-RECTANGLE
;         (WIDTH &OPTIONAL (HEIGHT WIDTCH))
;       (BLOCK MAKE-RECTANGLE (LIST WIDTCH HEIGHT)))
; 
; caught STYLE-WARNING:
;   The variable WIDTH is defined but never used.
; in: DEFUN MAKE-RECTANGLE
;     (LIST WIDTCH HEIGHT)
; 
; caught WARNING:
;   undefined variable: WIDTCH
; 
; compilation unit finished
;   Undefined variable:
;     WIDTCH
;   caught 1 WARNING condition
;   caught 1 STYLE-WARNING condition

MAKE-RECTANGLE
* (defun make-rectangle (width &optional (height width))
  (list width height))

STYLE-WARNING: redefining COMMON-LISP-USER::MAKE-RECTANGLE in DEFUN

MAKE-RECTANGLE
* (make-rectangle 10)

(10 10)
* (make-rectangle 2 5)

(2 5)
* (defun foo (a b &optional (c 3 c-supplied-p))
  (list a b c c-supplied-p))

STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo 1 2)

(1 2 3 NIL)
* (foo 1 2 3)

(1 2 3 T)
* (foo 1 2 4)

(1 2 4 T)
* (defun foo (a &rest values)
  values)

; in: DEFUN FOO
;     (SB-INT:NAMED-LAMBDA FOO
;         (A &REST VALUES)
;       (BLOCK FOO VALUES))
; 
; caught STYLE-WARNING:
;   The variable A is defined but never used.
; 
; compilation unit finished
;   caught 1 STYLE-WARNING condition
STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo 1)

NIL
* (foo 1 2 3 4)

(2 3 4)
* (foo 2 3 4)

(3 4)
* (defun foo (a &rest values)
  (list a)
  values)

STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo 1 2 3 4)

(2 3 4)
* (defun foo (&key a b c)
  (list a b c))

STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo)

(NIL NIL NIL)
* (foo :a 1)

(1 NIL NIL)
* (foo :b 1)

(NIL 1 NIL)
* (foo :c 1)

(NIL NIL 1)
* (foo :a 1 :c 3)

(1 NIL 3)
* (foo :a 1 :b 2 :c 3)

(1 2 3)
* (foo :a 1 :c 3 :b 2)

(1 2 3)
* (defun foo (&key (a 0) (b 0 b-supplied-p) (c (+ a b)))
  (list a b c b-supplied-p))

STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo :a 1)

(1 0 1 NIL)
* (foo :b 1)

(0 1 1 T)
* (foo :b 1 :c 4)

(0 1 4 T)
* (foo :a 2 :b 1 :c 4)

(2 1 4 T)
* (defun foo (&key ((:apple a )) ((:box b) 0) ((:charlie c) 0 c-cupplied-p))
  (list a b c c-cupplied-p))

STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo :apple 10 :box 20 :charlie 30)

(10 20 30 T)
* (defun foo (x &optional y &key z)
  (list x y z)))

; in: DEFUN FOO
;     (SB-INT:NAMED-LAMBDA FOO
;         (X &OPTIONAL Y &KEY Z)
;       (BLOCK FOO (LIST X Y Z)))
; 
; caught STYLE-WARNING:
;   &OPTIONAL and &KEY found in the same lambda list: (X &OPTIONAL Y &KEY Z)
; 
; caught STYLE-WARNING:
;   &OPTIONAL and &KEY found in the same lambda list: (X &OPTIONAL Y &KEY Z)
; 
; compilation unit finished
;   caught 2 STYLE-WARNING conditions
STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* 
debugger invoked on a SB-INT:SIMPLE-READER-ERROR in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  unmatched close parenthesis

    Stream: #<SYNONYM-STREAM :SYMBOL SB-SYS:*STDIN* {10001C21C3}>

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-READER-ERROR #<SYNONYM-STREAM :SYMBOL SB-SYS:*STDIN* {10001C21C3}> "unmatched close parenthesis")
0] 0

* (defun foo (x &optional y &key z)
  (list x y z))

; in: DEFUN FOO
;     (SB-INT:NAMED-LAMBDA FOO
;         (X &OPTIONAL Y &KEY Z)
;       (BLOCK FOO (LIST X Y Z)))
; 
; caught STYLE-WARNING:
;   &OPTIONAL and &KEY found in the same lambda list: (X &OPTIONAL Y &KEY Z)
; 
; caught STYLE-WARNING:
;   &OPTIONAL and &KEY found in the same lambda list: (X &OPTIONAL Y &KEY Z)
; 
; compilation unit finished
;   caught 2 STYLE-WARNING conditions
STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo 1 2 :z 3)

(1 2 3)
* (foo 1)

(1 NIL NIL)
* (foo 1 :z 3)

debugger invoked on a SB-INT:SIMPLE-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  odd number of &KEY arguments

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(FOO 1 :Z 3) [more,optional]
0] 0

* (defun foo (&rest rest &key a b c)
  (list rest a b c))

STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo :a 1 :b 2 :c 3)

((:A 1 :B 2 :C 3) 1 2 3)
* (defun foo (n)
  (dotimes (i 10)
    (dotimes (j 10)
      (when (> (* i j) n)
	(return-from foo (list i j))))))
STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo 5)

(1 6)
* (foo 100)

NIL
* (foo 20)

(3 7)
* (foo 90)

NIL
* (foo 80)

(9 9)
* 
