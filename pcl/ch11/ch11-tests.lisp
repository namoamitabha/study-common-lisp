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

(define-test test-Sequence-Iterating-Functions
    (:tag :unittest)
  (let ((vec #(1 2 1 2 3 1 2 3 4))
        (lst '(1 2 1 2 3 1 2 3 4))
        (str "foobarbaz"))
    (assert-equal 3 (count 1 vec))
    (assert-equality #'equalp
                     #(2 2 3 2 3 4)
                     (remove 1 vec))
    (assert-equality #'equalp
                     '(2 2 3 2 3 4)
                     (remove 1 lst))
    (assert-equal "foobrbz"
                  (remove #\a str))
    (assert-equality #'equalp
                     #(10 2 10 2 3 10 2 3 4)
                     (substitute 10 1 vec))
    (assert-equality #'equalp
                     '(10 2 10 2 3 10 2 3 4)
                     (substitute 10 1 lst))
    (assert-equal "fooxarxaz"
                  (substitute #\x #\b str))
    (assert-equal 1
                  (find 1 vec))
    (assert-false (find 10 vec))
    (assert-equal 0
                  (position 1 vec))
    (assert-equal 1
                  (count "foo" #("foo" "bar" "baz") :test #'string=))
    (assert-equal '(C 30)
                    (find 'c #((a 10) (b 20) (c 30) (d 40)) :key #'first))
    (let ((vec2 #((a 10) (b 20) (a 30) (d 40))))
      (assert-equal '(A 10)
                    (find 'a vec2 :key #'first))
      (assert-equal '(A 30)
                    (find 'a vec2 :key #'first :from-end t)))
    (let ((str2 "foobarbaz"))
      (assert-equal "foobrbaz"
                    (remove #\a str2 :count 1))
      (assert-equal "foobarbz"
                    (remove #\a str2 :count 1 :from-end t)))
    ))

(defparameter *v* #((a 10) (b 20) (a 30) (d 40)))
(defun verbose-first (x)
  (format t "Looking at ~s~%" x)
  (first x))

(count 'a *v* :key #'verbose-first)
;; Looking at (A 10)
;; Looking at (B 20)
;; Looking at (A 30)
;; Looking at (D 40)
;; 2
(count 'a *v* :key #'verbose-first :from-end t)
;; Looking at (D 40)
;; Looking at (A 30)
;; Looking at (B 20)
;; Looking at (A 10)
;; 2
