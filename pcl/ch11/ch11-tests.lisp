(defpackage pcl-ch11-tests
  (:use :common-lisp :pcl-ch11 :lisp-unit))

(in-package :pcl-ch11-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))

(vector 1)

(make-array 5 :initial-element nil)

(defparameter *x* (make-array 5 :fill-pointer 0))

(vector-push 'a *x*)

(vector-pop *x*)

(defparameter *y* (make-array 2 :fill-pointer 0 :adjustable t))

(vector-push 'a *y*)

(vector-push 'a *y*)

(vector-push 'a *y*)

(vector-push-extend 'a *y*)

(vector-push-extend 'a *y*)

(vector-push-extend 'a *y*)

(make-array 5 :fill-pointer 0 :adjustable t :element-type 'character)

(defparameter *str* (make-array 5 :fill-pointer 0 :adjustable t :element-type 'character))

(vector-push #\c *str*)


(make-array 5 :fill-pointer 0 :adjustable t :element-type 'bit)

(defparameter *bit* (make-array 5 :fill-pointer 0 :adjustable t :element-type 'bit))

(vector-push '1 *bit*)

(defparameter *x* (vector 1 2 3))
