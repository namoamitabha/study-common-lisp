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
  (let ((array-adjustable (make-array 2 :fill-pointer 0 :adjustable t)))
    (dotimes (x 6 t)
      (print (length array-adjustable))
      (if (> 2 (length array-adjustable))
          (vector-push 'a array-adjustable)
          (vector-push-extend 'a array-adjustable)))
    (assert-equal 6 (length array-adjustable))))
