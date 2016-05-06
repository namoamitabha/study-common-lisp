(defpackage pcl-ch12-tests
  (:use :common-lisp :pcl-ch12 :lisp-unit))

(in-package :pcl-ch12-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))
