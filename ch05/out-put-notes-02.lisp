This is SBCL 1.2.4.debian, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.

SBCL is free software, provided as is, with absolutely no warranty.
It is mostly in the public domain; some portions are provided under
BSD-style licenses.  See the CREDITS and COPYING files in the
distribution for more information.
* (defun foo (x) (* 2 x))

FOO
* (function foo)

#<FUNCTION FOO>
* #'foo

#<FUNCTION FOO>
* (foo 1 2 3)

debugger invoked on a SB-INT:SIMPLE-PROGRAM-ERROR in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  invalid number of arguments: 3

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(FOO 1 #<unknown> #<unknown>) [tl,external]
0] 0

* (foo 1)

2
* (funcall #'foo 1)

2
* (defun plot (fn min max step)
  (loop for i from min to max by step do
       (loop repeat (funcall fn i) do (format t "*"))
       (format t "~%")))


PLOT
* (plot #'exp 0 4 1/2)
*
**
***
*****
********
*************
*********************
**********************************
*******************************************************
NIL
* (setq plot-data (list #'exp 0 4 1/2))
; in: SETQ PLOT-DATA
;     (SETQ PLOT-DATA (LIST #'EXP 0 4 1/2))
; 
; caught WARNING:
;   undefined variable: PLOT-DATA
; 
; compilation unit finished
;   Undefined variable:
;     PLOT-DATA
;   caught 1 WARNING condition

(#<FUNCTION EXP> 0 4 1/2)
* plot-data

(#<FUNCTION EXP> 0 4 1/2)
* (plot (first plot-data) (second plot-data) (third plot-data) (fourth plot-data))
*
**
***
*****
********
*************
*********************
**********************************
*******************************************************
NIL
* (apply #'plot plot-data)
*
**
***
*****
********
*************
*********************
**********************************
*******************************************************
NIL
* (pop plot-data)

; in: POP PLOT-DATA
;     (SETQ PLOT-DATA #:NEW772)
; 
; caught WARNING:
;   undefined variable: PLOT-DATA
; 
; compilation unit finished
;   Undefined variable:
;     PLOT-DATA
;   caught 1 WARNING condition

#<FUNCTION EXP>
* plot-d

debugger invoked on a UNBOUND-VARIABLE in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  The variable PLOT-D is unbound.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV PLOT-D #<NULL-LEXENV>)
0] 0

* plot-data

(0 4 1/2)
* (apply #'plot #'exp plot-data)
*
**
***
*****
********
*************
*********************
**********************************
*******************************************************
NIL
* (funcall #'(lambda (x y) (+ x y)) 2 3)

5
* ((lambda (x y) (+ x y)) 2 3)

5
* (defun double (x) (* 2 x))

debugger invoked on a SYMBOL-PACKAGE-LOCKED-ERROR in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  Lock on package SB-ALIEN violated when proclaiming DOUBLE as a function while
  in package COMMON-LISP-USER.
See also:
  The SBCL Manual, Node "Package Locks"

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [CONTINUE      ] Ignore the package lock.
  1: [IGNORE-ALL    ] Ignore all package locks in the context of this operation.
  2: [UNLOCK-PACKAGE] Unlock the package.
  3: [ABORT         ] Exit debugger, returning to top level.

(PACKAGE-LOCK-VIOLATION #<PACKAGE "SB-ALIEN"> :SYMBOL DOUBLE :FORMAT-CONTROL "proclaiming ~S as a function" :FORMAT-ARGUMENTS (DOUBLE))
0] 0

debugger invoked on a SYMBOL-PACKAGE-LOCKED-ERROR in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  Lock on package SB-ALIEN violated when setting fdefinition of DOUBLE while in
  package COMMON-LISP-USER.
See also:
  The SBCL Manual, Node "Package Locks"

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [CONTINUE      ] Ignore the package lock.
  1: [IGNORE-ALL    ] Ignore all package locks in the context of this operation.
  2: [UNLOCK-PACKAGE] Unlock the package.
  3: [ABORT         ] Exit debugger, returning to top level.

(PACKAGE-LOCK-VIOLATION #<PACKAGE "SB-ALIEN"> :SYMBOL DOUBLE :FORMAT-CONTROL "setting fdefinition of ~A" :FORMAT-ARGUMENTS (DOUBLE))
0] 0

DOUBLE
* (doulbe 2)

; in: DOULBE 2
;     (DOULBE 2)
; 
; caught STYLE-WARNING:
;   undefined function: DOULBE
; 
; compilation unit finished
;   Undefined function:
;     DOULBE
;   caught 1 STYLE-WARNING condition

debugger invoked on a UNDEFINED-FUNCTION in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  The function COMMON-LISP-USER::DOULBE is undefined.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [ABORT] Exit debugger, returning to top level.

("undefined function")
0] 0

* (defun double (x) (* 2 x))
STYLE-WARNING: redefining SB-ALIEN:DOUBLE in DEFUN

debugger invoked on a SYMBOL-PACKAGE-LOCKED-ERROR in thread
#<THREAD "main thread" RUNNING {10039CE8B3}>:
  Lock on package SB-ALIEN violated when setting fdefinition of DOUBLE while in
  package COMMON-LISP-USER.
See also:
  The SBCL Manual, Node "Package Locks"

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [CONTINUE      ] Ignore the package lock.
  1: [IGNORE-ALL    ] Ignore all package locks in the context of this operation.
  2: [UNLOCK-PACKAGE] Unlock the package.
  3: [ABORT         ] Exit debugger, returning to top level.

(PACKAGE-LOCK-VIOLATION #<PACKAGE "SB-ALIEN"> :SYMBOL DOUBLE :FORMAT-CONTROL "setting fdefinition of ~A" :FORMAT-ARGUMENTS (DOUBLE))
0] 0

DOUBLE
* (defun double-2 (x) (* 2 x))

DOUBLE-2
* (double-2 2)

4
* (plot #'double-2 0 10 1)

**
****
******
********
**********
************
**************
****************
******************
********************
NIL
* (plot #'(lambda (x) (* 2 x)) 0 10 1)

**
****
******
********
**********
************
**************
****************
******************
********************
NIL
* 
