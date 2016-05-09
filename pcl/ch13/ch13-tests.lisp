(defpackage pcl-ch13-tests
  (:use :common-lisp :pcl-ch13 :lisp-unit))

(in-package :pcl-ch13-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))

(define-test test-Trees
    (:tag :unittest)
  (assert-equality #'equalp
                   '(10 2 (3 2 10) ((10 10) (2 2)))
                   (subst 10 1 '(1 2 (3 2 1) ((1 1) (2 2))))))

(defparameter *set* ())
(define-test test-Sets
    (:tag :unittest)
  (adjoin 1 *set*)
  (assert-false *set*)
  (setf *set* (adjoin 1 *set*))
  (assert-equality #'equalp
                   '(1)
                   *set*)
  (pushnew 2 *set*)
  (pushnew 2 *set*)
  (assert-equality #'equalp
                   '(2 1)
                   *set*)
  (assert-true (subsetp '(3 2 1) '(1 2 3 4)))
  (assert-false (subsetp '(1 2 3 4) '(3 2 1))))
