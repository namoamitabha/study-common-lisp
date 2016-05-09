(defpackage pcl-ch14-tests
  (:use :common-lisp :pcl-ch14 :lisp-unit))

(in-package :pcl-ch14-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))
