This is SBCL 1.2.4.debian, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
* 10

10
* 20/2

10
* #xa

10
* *read-base*

10
* 123

123
* +123

123
* -123

-123
* 123.

123
* 2/3

2/3
* -2/3

-2/3
* 4/6

2/3
* 6/3

2
* b#10101

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The variable |B#10101| is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV |B#10101| #<NULL-LEXENV>)
0] #b10101

21
0] 0

* #b10101

21
* #b1010/1011

10/11
* #o777

511
* #xDADA

56026
* #36rABCDEFGHIJKLMNOPQRSTUVWXYZ

8337503854730415241050377135811259267835
* #36r1

1
* #32r01

1
* #32r10

32
* 1.0

1.0
* 1e0

1.0
* 1d0

1.0d0
* 123.0

123.0
* 123e0

123.0
* 0.123

0.123
* .123

0.123
* 123e-3

0.123
* 123E-3

0.123
* 0.123e20

1.23e19
* 123d23

1.23d25
* +123d23

1.23d25
* #c(2 1)

#C(2 1)
* #c(2/3 3/5)

#C(2/3 3/5)
* #c(2/3 3/4)

#C(2/3 3/4)
* #c(2 1.0)

#C(2.0 1.0)
* #c(2.0 1.0d0)

#C(2.0d0 1.0d0)
* #c(1/2 1.0)

#C(0.5 1.0)
* #c(3 0)

3
* #c(3.0 0.0)

#C(3.0 0.0)
* #c(1/2 0)

1/2
* #c(-6/3 0)

-2
* (+ 1 2)

3
* (+ 1 2 3)

6
* (+ 10.0 3.0)

13.0
* (+ #c(1 2) #c(3 4))

#C(4 6)
* (- 5 4)

1
* (- 2)

-2
* (- 10 3 5)

2
* (* 2 3)

6
* (* 2 3 4)

24
* (/ 10 5)

2
* (/ 10 5 2)

1
* (/ 2 3)

2/3
* (/ 4)

1/4
* (+ 1 2.0)

3.0
* (/ 2 3.0)

0.6666667
* (+ #c(1 2) 3)

#C(4 2)
* (+ #c(1 2) 3/2)

#C(5/2 2)
* (+ #c(1 1) #c(2 -1))

3
* 4

4
* (mod 4 3)

1
* (rem 4 3)

1
* (mod 5 2.5)

0.0
* (rem 5 2.5)

0.0
* (mod 6 2.5)

1.0
* (rem 6 2.5)

1.0
* (mod -6 2.5)

1.5
* (rem -6 2.5)

-1.0
* (= 1 1)

T
* (= 10 20/2)

T
* (= 1 1.0 #c(1.0 0.0) #c(1 0))

T
* (/= 1 1)

NIL
* (/= 1 2)

T
* (/= 1 2 3)

T
* (/= 1 2 3 1)

NIL
* (/= 1 2 3 1.0)

NIL
* (< 2 3)

T
* (> 2 3)

NIL
* (> 3 3)

NIL
* (> 3 2)

T
* (< 2 3 4)

T
* (< 2 3 3)

NIL
* (<= 2 3 3)

T
* (<= 2 3 3 4)

T
* (<= 2 3 4 3)

NIL
* (max 10 11 3)

11
* (min -12 -10)

-12
* (max -1 2 -3)

2
* (zerop 3)

NIL
* (zerop 0)

T
* (minup 3 5)
; in: MINUP 3
;     (MINUP 3 5)
; 
; caught STYLE-WARNING:
;   undefined function: MINUP
; 
; compilation unit finished
;   Undefined function:
;     MINUP
;   caught 1 STYLE-WARNING condition

debugger invoked on a UNDEFINED-FUNCTION in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The function COMMON-LISP-USER::MINUP is undefined.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

("undefined function")
0] 0

* (minusp 3 5)

debugger invoked on a SB-INT:SIMPLE-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  invalid number of arguments: 2

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(MINUSP 3 #<unknown>) [tl,external]
0] 0

* (minusp 5)

NIL
* (minusp -1)

T
* (plusp 5)

T
* (plusp -1)

NIL
* (evenp 2)

T
* (evenp 3)

NIL
* (oddp 3)

T
* (oddp 2)

NIL
* (log 2)

0.6931472
* (log 1)

0.0
* (exp 2)

7.389056
* (expt 2)

debugger invoked on a SB-INT:SIMPLE-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  invalid number of arguments: 1

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(EXPT 2) [tl,external]
0] 0

* (sin 2)

0.9092974
* (cons 2)

debugger invoked on a SB-INT:SIMPLE-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  invalid number of arguments: 1

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(CONS 2) [tl,external]
0] 0

* (cons 0.8)

debugger invoked on a SB-INT:SIMPLE-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  invalid number of arguments: 1

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(CONS 0.8) [tl,external]
0] 0

* sin(45)

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The variable SIN is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV SIN #<NULL-LEXENV>)
0] 0

* ; in: 45
;     (45)
; 
; caught ERROR:
;   illegal function call
; 
; compilation unit finished
;   caught 1 ERROR condition

debugger invoked on a SB-INT:COMPILED-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  Execution of a form compiled with errors.
Form:
  (45)
Compile-time error:
  illegal function call

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

((LAMBDA ()))
0] (sin 2)

0.9092974
0] tan(2)

; in: LAMBDA (#:G751)
;     (SYMBOL-MACROLET ()
;       TAN)
; 
; caught WARNING:
;   undefined variable: TAN
; 
; compilation unit finished
;   Undefined variable:
;     TAN
;   caught 1 WARNING condition

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The variable TAN is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Reduce debugger level (to debug level 1).
  1:         Exit debugger, returning to top level.

((LAMBDA (#:G751)) #<unavailable argument>)
0[2] 0

0] 0

* #\a

#\a
* #\ 

#\ 
* #\space

#\ 
* #\newline

#\Newline
* #\newline

#\Newline
* #\tab

#\Tab
* #\page

#\Page
* #\rubout

#\Rubout
* #\linefeed

#\Newline
* #\return

#\Return
* #\backspace

#\Backspace
* (char= #\a #\b)

NIL
* (char= #\a #\a)

T
* (char= #\a #\A)

NIL
* (char-equal #\a #\A)

T
* (char/= #\a #\b)

T
* (char< #\a #\b)

T
* (char> #\a #\b)

NIL
* (char<= #\a #\b)

T
* (char>= #\a #\b)

NIL
* "abc"

"abc"
* 'abc'

ABC
* 'abcd'

'ABCD
* 'abc'

'ABC
* 'abc'

'ABC
* "abcd"

"abcd"
* 'abc

ABC
* ""

""
* 

"ab"

"ab"
* "ABC"

"ABC"
* "ab\c"

"abc"
* "abc\\"

"abc\\"
* "abc\d"

"abcd"
* "abc\""

"abc\""
* "abc\\"

"abc\\"
* (format t "foo\"bar")
foo"bar
NIL
* (string= "ab" "ab")

T
* (string= "ab" "abc")

NIL
* (string/= "ab" "abc")

2
* tring< "ab" "abc")

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The variable TRING< is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV TRING< #<NULL-LEXENV>)
0] 0

* 
"ab"
* 
"abc"
* 
debugger invoked on a SB-INT:SIMPLE-READER-ERROR in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  unmatched close parenthesis

    Stream: #<SYNONYM-STREAM :SYMBOL SB-SYS:*STDIN* {91230E9}>

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-READER-ERROR #<SYNONYM-STREAM :SYMBOL SB-SYS:*STDIN* {91230E9}> "unmatched close parenthesis")
0] 0

* (string< "ab" "abc")

2
* \"

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {B3E23E9}>:
  The variable |"| is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV |"| #<NULL-LEXENV>)
0] 0

* 
