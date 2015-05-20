This is SBCL 1.2.4.debian, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
* (defun foo (x)
  (format t "Parameter: ~a~%" x)
  (let ((x 2))
    (format t "Outer LET: ~a~%" x)
    (let ((x 3))
      (format t "Inner LET: ~a~%" x))
    (format t "Outer LET: ~a~%" x))
  (format t "Parameter: ~a~%" x))


FOO
* (foo 1)
Parameter: 1
Outer LET: 2
Inner LET: 3
Outer LET: 2
Parameter: 1
NIL
* (let* ((x 10)
       (y (+ x 10)))
  (list x y))

(10 20)
* (let ((x 10))
  (let ((y (+ x 10)))
    (list x y)))


(10 20)
* (let ((count 0))
  #'(lambda ()
      (setf count (1+ count))))

#<CLOSURE (LAMBDA ()) {1005377E0B}>
* (defparameter *fn* (let ((count 0))
		     #'(lambda ()
			 (setf count (1+ count)))))


*FN*
* (funcall *fn*)

1
* (funcall *fn*)

2
* (funcall *fn*)

3
* (funcall *fn*)

4
* (funcall *fn*)

5
* (funcall *fn*)

6
* (let ((count 0))
  (list
   #'(lambda () (incf count))
   #'(lambda () (decf count))
   #'(lambda () count)))

(#<CLOSURE (LAMBDA ()) {10053E186B}> #<CLOSURE (LAMBDA ()) {10053E188B}>
 #<CLOSURE (LAMBDA ()) {10053E18AB}>)
* (defvar *x* 10)
(defun foo ()
  (format t "X: ~d~%" *x*))

*X*
* STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo)
X: 10
NIL
* (let ((*x* 20))
  (foo))
X: 20
NIL
* (defun bar ()
  (foo)
  (let ((*x* 20))
    (foo))
  (foo))


BAR
* (bar)
X: 10
X: 20
X: 10
NIL
* (defun foo ()
  (format t "Before assignment~18tX: ~d~%" *x*)
  (setf *x* (+ 1 *x*))
  (format t "After assignment~18tX: ~d~%" *x*))
STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo)
Before assignment X: 10
After assignment  X: 11
NIL
* (bar)
Before assignment X: 11
After assignment  X: 12
Before assignment X: 20
After assignment  X: 21
Before assignment X: 12
After assignment  X: 13
NIL
* (defconstant +test+ "TEST" "test defconstant")

+TEST+
* +test+

"TEST"
* (documentation +test+)

debugger invoked on a SB-INT:SIMPLE-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  invalid number of arguments: 1

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

((LAMBDA (SB-PCL::.ARG0. SB-PCL::.ARG1.) :IN "/build/sbcl-xybIfV/sbcl-1.2.4/src/pcl/dlisp3.fasl") "TEST") [external]
0] 0

* (documentation +test+ constant)

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  The variable CONSTANT is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV CONSTANT #<NULL-LEXENV>)
0] 0

* (setf x 10)
; in: SETF X
;     (SETF X 10)
; ==>
;   (SETQ X 10)
; 
; caught WARNING:
;   undefined variable: X
; 
; compilation unit finished
;   Undefined variable:
;     X
;   caught 1 WARNING condition

10
* x

10
* (defun foo (x)
  (setf x 20))
STYLE-WARNING: redefining COMMON-LISP-USER::FOO in DEFUN

FOO
* (foo x)

20
* (foo b)

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  The variable B is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV B #<NULL-LEXENV>)
0] 0

* (setf b 2)

; in: SETF B
;     (SETF B 2)
; ==>
;   (SETQ B 2)
; 
; caught WARNING:
;   undefined variable: B
; 
; compilation unit finished
;   Undefined variable:
;     B
;   caught 1 WARNING condition

2
* (foo b)

20
* b

2
* x

10
* (foo x)

20
* (let ((y 20))
  (foo y)
  (print y))


20 
20
* (let ((y 30))
  (foo y)
  (print y))


30 
30
* (setf x 1 y 2)

; in: SETF X
;     (SETF X 1)
; ==>
;   (SETQ X 1)
; 
; caught WARNING:
;   undefined variable: X
; 
; compilation unit finished
;   Undefined variable:
;     X
;   caught 1 WARNING condition

;     (SETF Y 2)
; ==>
;   (SETQ Y 2)
; 
; caught WARNING:
;   undefined variable: Y
; 
; compilation unit finished
;   Undefined variable:
;     Y
;   caught 1 WARNING condition

2
* x

1
* y

2
* (setf x 1 y 2)

;     (SETF X 1)
; ==>
;   (SETQ X 1)
; 
; caught WARNING:
;   undefined variable: X
; 
; compilation unit finished
;   Undefined variable:
;     X
;   caught 1 WARNING condition

;     (SETF Y 2)
; ==>
;   (SETQ Y 2)
; 
; caught WARNING:
;   undefined variable: Y
; 
; compilation unit finished
;   Undefined variable:
;     Y
;   caught 1 WARNING condition

2
* (setf x (setf y (random 10)))

;     (SETF X (SETF Y (RANDOM 10)))
; ==>
;   (SETQ X (SETF Y (RANDOM 10)))
; 
; caught WARNING:
;   undefined variable: X

;     (SETF Y (RANDOM 10))
; ==>
;   (SETQ Y (RANDOM 10))
; 
; caught WARNING:
;   undefined variable: Y
; 
; compilation unit finished
;   Undefined variables:
;     X Y
;   caught 2 WARNING conditions

6
* x

6
* y

6
* (setf x (setf y (random 10)))

;     (SETF X (SETF Y (RANDOM 10)))
; ==>
;   (SETQ X (SETF Y (RANDOM 10)))
; 
; caught WARNING:
;   undefined variable: X

;     (SETF Y (RANDOM 10))
; ==>
;   (SETQ Y (RANDOM 10))
; 
; caught WARNING:
;   undefined variable: Y
; 
; compilation unit finished
;   Undefined variables:
;     X Y
;   caught 2 WARNING conditions

9
* x

9
* y

9
* (incf x)

; in: INCF X
;     (SETQ X #:NEW772)
; 
; caught WARNING:
;   undefined variable: X
; 
; compilation unit finished
;   Undefined variable:
;     X
;   caught 1 WARNING condition

10
* 
(decf x)

; in: DECF X
;     (SETQ X #:NEW774)
; 
; caught WARNING:
;   undefined variable: X
; 
; compilation unit finished
;   Undefined variable:
;     X
;   caught 1 WARNING condition

9
* (incf x 10)

; in: INCF X
;     (SETQ X #:NEW776)
; 
; caught WARNING:
;   undefined variable: X
; 
; compilation unit finished
;   Undefined variable:
;     X
;   caught 1 WARNING condition

19
* x

19
* (make-array 5)

#(0 0 0 0 0)
* ()

NIL
* (setf a (make-array 5))

; in: SETF A
;     (SETF A (MAKE-ARRAY 5))
; ==>
;   (SETQ A (MAKE-ARRAY 5))
; 
; caught WARNING:
;   undefined variable: A
; 
; compilation unit finished
;   Undefined variable:
;     A
;   caught 1 WARNING condition

#(0 0 0 0 0)
* a

#(0 0 0 0 0)
* (incf (aref a (random (length a))))

; in: INCF (AREF A (RANDOM (LENGTH A)))
;     (LENGTH A)
; 
; caught WARNING:
;   undefined variable: A
; 
; compilation unit finished
;   Undefined variable:
;     A
;   caught 1 WARNING condition

1
* a

#(0 0 0 0 1)
* (incf (aref a (random (length a))))
; 
; caught WARNING:
;   undefined variable: A
; 
; compilation unit finished
;   Undefined variable:
;     A
;   caught 1 WARNING condition

1
* a

#(0 1 0 0 1)
* (setf b 1 c 2)

; in: SETF B
;     (SETF B 1)
; ==>
;   (SETQ B 1)
; 
; caught WARNING:
;   undefined variable: B
; 
; compilation unit finished
;   Undefined variable:
;     B
;   caught 1 WARNING condition

;     (SETF C 2)
; ==>
;   (SETQ C 2)
; 
; caught WARNING:
;   undefined variable: C
; 
; compilation unit finished
;   Undefined variable:
;     C
;   caught 1 WARNING condition

2
* b

1
* c

2
* (rotatef b c)

; in: ROTATEF B
;     (SETQ B #:NEW786)
; 
; caught WARNING:
;   undefined variable: B

;     (SETQ C #:NEW787)
; 
; caught WARNING:
;   undefined variable: C
; 
; compilation unit finished
;   Undefined variables:
;     B C
;   caught 2 WARNING conditions

NIL
* b

2
* c

1
* (shiftf b c)

; in: SHIFTF B
;     (SETQ B #:NEW788)
; 
; caught WARNING:
;   undefined variable: B

;     (MULTIPLE-VALUE-BIND (#:NEW788) C (SETQ B #:NEW788))
; ==>
;   (LET ((#:NEW788 C))
;     (SETQ B #:NEW788))
; 
; caught WARNING:
;   undefined variable: C
; 
; compilation unit finished
;   Undefined variables:
;     B C
;   caught 2 WARNING conditions

2
* b

1
* c

1
* (shiftf b c)

;     (SETQ B #:NEW789)
; 
; caught WARNING:
;   undefined variable: B

;     (MULTIPLE-VALUE-BIND (#:NEW789) C (SETQ B #:NEW789))
; ==>
;   (LET ((#:NEW789 C))
;     (SETQ B #:NEW789))
; 
; caught WARNING:
;   undefined variable: C
; 
; compilation unit finished
;   Undefined variables:
;     B C
;   caught 2 WARNING conditions

1
* b

1
* c

1
* (shiftf b c)

;     (SETQ B #:NEW790)
; 
; caught WARNING:
;   undefined variable: B

;     (MULTIPLE-VALUE-BIND (#:NEW790) C (SETQ B #:NEW790))
; ==>
;   (LET ((#:NEW790 C))
;     (SETQ B #:NEW790))
; 
; caught WARNING:
;   undefined variable: C
; 
; compilation unit finished
;   Undefined variables:
;     B C
;   caught 2 WARNING conditions

1
* b

1
* c

1
* (setf tmp 2)

; in: SETF TMP
;     (SETF TMP 2)
; ==>
;   (SETQ TMP 2)
; 
; caught WARNING:
;   undefined variable: TMP
; 
; compilation unit finished
;   Undefined variable:
;     TMP
;   caught 1 WARNING condition

2
* (shiftf b c tmp)

; in: SHIFTF B
;     (SETQ B #:NEW791)
; 
; caught WARNING:
;   undefined variable: B

;     (SETQ C #:NEW792)
; 
; caught WARNING:
;   undefined variable: C

;     (MULTIPLE-VALUE-BIND (#:NEW792) TMP (SETQ B #:NEW791) (SETQ C #:NEW792))
; ==>
;   (LET ((#:NEW792 TMP))
;     (SETQ B #:NEW791)
;     (SETQ C #:NEW792))
; 
; caught WARNING:
;   undefined variable: TMP
; 
; compilation unit finished
;   Undefined variables:
;     B C TMP
;   caught 3 WARNING conditions

1
* b

1
* c

2
* tmp

2
* 
