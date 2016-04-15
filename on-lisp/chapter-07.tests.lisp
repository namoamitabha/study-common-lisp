(defpackage on-lisp.ch07.tests
  (:use
   :common-lisp
   :lisp-unit
   :on-lisp.ch07))

(in-package :on-lisp.ch07.tests)

(define-test test-backquote
    (:tag :unittest)
  (assert-equal '(1 2 3) `(1 2 3)))

