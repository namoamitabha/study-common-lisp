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

(define-test test-memq
    (:tag :unittest)
  (assert-equal nil
                (memq 'ON-LISP.CH07.TESTS::B '("a" 'b 'c "d"))))

(define-test test-while
    (:tag :unittest)
  (let ((x 0) (result 0))
    (while (<= x 100)
           (setq result (+ result x)
                 x (1+ x)))
    (assert-equal 5050 result)))

(define-test test-our-dolist
    (:tag :unittest)
  (let ((result 0))
    (our-dolist (x '(1 2 3) result)
      (setq result (+ result x)))
    (assert-equal 6 result)))

(define-test test-when-bind
    (:tag :unittest)
  (let ((x))
    (pprint (macroexpand-1 '(when-bind (x '(1 2 3)) (pprint 'x))))))

(define-test test-psetq
    (:tag :unittest)
  (let ((a 1) b)
    (setq a 2 b a)
    (assert-equal (list a b)
                  '(2 2)))
  (let ((a 1) b)
    (psetq a 2 b a)
    (assert-equal (list a b)
                  '(2 1))))

(define-test test-cadr
    (:tag :unittest)
  (let ((lst '(1 2 3 4 5 6 7 8)))
    ;;(second lst)
    (assert-equal (car (cdr lst))
                  (cadr lst))
    ;;(third lst)
    (assert-equal (car (cdr (cdr lst)))
                  (caddr lst))
    ;;(fourth lst)
    (assert-equal (car (cdr (cdr (cdr lst))))
                  (cadddr lst))))

(define-test test-our-and
    (:tag :unittest)
  ;;(assert-true (our-and 1 2 3 4 5 6 7))
  (assert-equal (our-and 1 2 3 4 5 6 7)
                7)
  (assert-equal (our-and 1 2 3 4 5 6 7 nil)
                nil)
  (assert-equal (our-andb 1 2 3 4 5 6 7)
                7)
  (assert-equal (our-andb 1 2 3 4 5 6 7 nil)
                nil))
