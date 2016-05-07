(defpackage pcl-ch12-tests
  (:use :common-lisp :pcl-ch12 :lisp-unit))

(in-package :pcl-ch12-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))

(define-test test-There-Is-No-List
    (:tag :unittest)
  (assert-equal '(1 . 2)
                (cons 1 2))
  (assert-equal 1
                (car (cons 1 2)))
  (assert-equal 2
                (cdr (cons 1 2)))
  (let ((cons (cons 1 2)))
    (setf (car cons) 10)
    (assert-equal '(10 . 2) cons)
    (setf (cdr cons) 20)
    (assert-equal '(10 . 20) cons))
  (assert-equal '(1)
                (cons 1 nil))
  (assert-equal '(1 2)
                (cons 1 (cons 2 nil)))
  (assert-equal '(1 2 3)
                (cons 1 (cons 2 (cons 3 nil))))
  (let ((list (list 1 2 3 4)))
    (assert-equal 1
                  (first list))
    (assert-equal '(2 3 4)
                  (rest list))
    (assert-equal 2
                  (first (rest list))))
  (assert-equal '("foo" (1 2) 10)
                (list "foo" (list 1 2) 10)))

(define-test test-Functional-Programming-and-Lists
    (:tag :unittest)
  (assert-equality #'equalp
                   '(1 2 3 4)
                   (append (list 1 2) (list 3 4))))
