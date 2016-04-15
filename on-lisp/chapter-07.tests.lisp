(defpackage on-lisp.ch07.tests
  (:use
   :common-lisp
   :lisp-unit
   :on-lisp.ch07))

(in-package :on-lisp.ch07.tests)

(define-test test-backquote
    (:tag :unittest)
  (assert-equal '(1 2 3) `(1 2 3))
  (assert-equal (list 'a 'b 'c) `(a b c))
  ;;(assert-equal (list 'a b 'c d) `(a ,b c ,d))
  )

;; >> (setq a 1 b 2 c 3)
;; >> `(a ,b c)
;; (A 2 C)
;; >> `(a (,b c))
;; (A (2 C))
;; >> `(a b ,c (',(+ a b c)) (+ a b) 'c '((,a ,b)))
;; (A B 3 ('6) (+ A B) 'C '((1 2)))

;; | Execution error:
;; | The function ON-LISP.CH07:NIL! is undefined.

(define-test test-nil!
    (:tag :unittest)
  (let ((a 2) (b 3))
    (nil! a)
    (assert-false a)
    (nil!1 b)
    (assert-false b)))

(define-test test-nif
    (:tag :unittest)
  (assert-equal '(Z P N) (mapcar #'(lambda (x)
                                     (nif x 'p 'z 'n))
                                 '(0 2.5 -8)))
  (assert-equal '(Z P N) (mapcar #'(lambda (x)
                                     (nif1 x 'p 'z 'n))
                                 '(0 2.5 -8))))

(define-test test-our-when
    (:tag :unittest)
  (let ((a 1) (result))
    (assert-equal (+ 1 a) (our-when (numberp a)
                                    (+ 1 a)))))

(define-test test-greet
    (:tag :unittest)
  (assert-equal `(ON-LISP.CH07::HELLO ON-LISP.CH07.TESTS::NIKE)
                (greet 'nike)))
