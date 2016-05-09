(defpackage pcl-ch13-tests
  (:use :common-lisp :pcl-ch13 :lisp-unit))

(in-package :pcl-ch13-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))
