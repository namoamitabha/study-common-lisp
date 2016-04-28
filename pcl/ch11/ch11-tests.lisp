(defpackage pcl-ch11-tests
  (:use :common-lisp :pcl-ch11 :lisp-unit))

(in-package :pcl-ch11-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))

(define-test test-vector
    (:tag :unittest)
  (assert-equality #'equalp
                   #(1 2 3 4 5)
                   (vector 1 2 3 4 5))
  (assert-equality #'equalp
                   #(nil nil nil nil nil)
                   (make-array 5 :initial-element nil))
  ;; (make-array 5 :fill-pointer 0) not real resizable
  (let ((array (make-array 5 :fill-pointer 0)))
    (dotimes (x 6 t)
      (vector-push 'a array))
    (assert-equal 5 (length array)))
  ;; :adjustable
  ;; to use vector-push-extend
  (let ((array-adjustable (make-array 2
                                      :fill-pointer 0
                                      :adjustable t)))
    (dotimes (x 6 t)
      ;;(print (length array-adjustable))
      (if (> 2 (length array-adjustable))
          (vector-push 'a array-adjustable)
          (vector-push-extend 'a array-adjustable)))
    (assert-equal 6 (length array-adjustable)))
  (let ((str (make-array 5 :fill-pointer 0
                           :adjustable t
                           :element-type 'character)))
    (dotimes (x 6 t)
      (if (> 2 (length str))
          (vector-push #\a str)
          (vector-push-extend #\b str)))
    (assert-equal 6 (length str))))

(defparameter *x* #(1 2 3))
(define-test test-Vectors-as-Sequences
    (:tag :unittest)
  (let ((x #(1 2 3)))
    (assert-equal 3 (length x))
    (assert-equal 1 (elt x 0))
    (assert-equal 3 (elt x 2))
    (setf (elt *x* 1) 10)
    (assert-equal 10 (elt *x* 1))))
