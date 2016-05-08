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

(defparameter *list-1* (list 1 2))
(defparameter *list-2* (list 3 4))
(defparameter *list-3* (append *list-1* *list-2*))
(defparameter *x1* (list 1 2 3))
(defparameter *x2* (list 4 5 6))
(defparameter *x3* ())
(define-test test-Destructive-Operations
    (:tag :unittest)
  (assert-equality #'equalp
                   '(1 2)
                   *list-1*)
  (assert-equality #'equalp
                   '(3 4)
                   *list-2*)
  (assert-equality #'equalp
                   '(1 2 3 4)
                   *list-3*)
  (setf (first *list-2*) 0)
  (assert-equality #'equalp
                   '(0 4)
                   *list-2*)
  (assert-equality #'equalp
                   '(1 2 0 4)
                   *list-3*)
  (setf *x3* (nconc *x1* *x2*))
  (assert-equality #'equalp
                   '(1 2 3 4 5 6)
                   *x3*)
  (setf (first *x1*) 11)
  (assert-equality 'equalp
                   '(11 2 3 4 5 6)
                   *x3*)
  (setf (first *x2*) 44)
  (assert-equality 'equalp
                   '(11 2 3 44 5 6)
                   *x3*))

(defun upto (max)
  (let ((result nil))
    (dotimes (i max)
      (push i result))
    (nreverse result)))

(defparameter *list-11* (list 1 2))
(defparameter *list-21* (list 0 4))
(defparameter *list-31* (append *list-11* *list-21*))
(defparameter *list* (list 4 3 2 1))

(define-test test-Combining-Recycling-with-Shared-Structure
    (:tag :unittest)
  (assert-equality #'equalp
                   '(0 1 2 3 4 5 6 7 8 9)
                   (upto 10))

  (assert-equality #'equalp
                   '(1 2 0 4)
                   *list-3*)
  (assert-equality #'equalp
                   '(0 4)
                   *list-2*)
  (setf *list-3* (delete 4 *list-3*))
  (assert-equality #'equalp
                   '(1 2 0)
                   *list-3*)
  (assert-equality #'equalp
                   '(0)
                   *list-2*)

  (assert-equality #'equalp
                   '(1 2 0 4)
                   *list-31*)
  (assert-equality #'equalp
                   '(0 4)
                   *list-21*)
  (setf *list-31* (remove 4 *list-31*))
  (assert-equality #'equalp
                   '(1 2 0)
                   *list-31*)
  (assert-equality #'equalp
                   '(0 4)
                   *list-21*)
  (assert-equality #'equalp
                   '(1 2 3 4)
                   (sort *list* #'<))
  ;;*list* is not '(1 2 3 4)
  (assert-equality #'equalp
                   '(3 4)
                   *list*))

(define-test test-List-Manipulation-Functions
    (:tag :unittest)
  ;;(assert-error (caar (list 1 2 3)))
  (assert-equal 1
                (caar (list (list 1 2) 3)))
  (assert-equal '(3 4)
                (cadr (list (list 1 2) (list 3 4))))
  (assert-equal 3
                (caadr (list (list 1 2) (list 3 4))))
  ;;last
  (assert-equal '(3)
                (last '(1 2 3)))
  (assert-equal '(2 . 3)
                (last '(1 2 . 3)))
  ;;butlast nbutlast
  (let ((lst '(1 2 3 4 5 6 7 8 9)))
    (assert-equality #'equalp
                     '(1 2 3 4 5 6 7 8)
                     (butlast lst))
    (assert-equality #'equalp
                     '(1 2 3 4)
                     (butlast lst 5))
    (assert-equality #'equalp
                     '(1 2 3 4 5 6 7 8 9)
                     lst)
    (assert-equality #'equalp
                     '(1 2 3 4 5 6)
                     (nbutlast lst 3))
    (assert-equality #'equalp
                     '(1 2 3 4 5 6)
                     lst))
  ;; tailp ldiff
  (let ((lst '(a b c d . e)))
    (assert-true (tailp (cdddr lst) lst))
    (assert-equality #'equalp
                     lst
                     (ldiff lst nil))
    (assert-equality #'equalp
                     nil
                     (ldiff lst lst))
    (assert-equality #'equalp
                     (list (car lst))
                     (ldiff lst (cdr lst))))
  ;; list*
  (assert-equality #'equalp
                   '(1 2 . 3)
                   (list* 1 2 3))
  (assert-equality #'equalp
                   '(a b c d e)
                   (list* 'a 'b 'c '(d e)))
  ;; make-list
  (assert-equality #'equalp
                   '(nil nil nil nil nil)
                   (make-list 5 :initial-element nil))
  (assert-equality #'equalp
                   '(hah hah hah)
                   (make-list 3 :initial-element 'hah))
  ;;revappend nreconc
  (assert-equality #'equalp
                   '(3 2 1 a . b)
                   (revappend '(1 2 3) '(a . b)))
  (assert-equality #'equalp
                   '(3 2 1 a . b)
                   (nreconc '(1 2 3) '(a . b)))
  (let ((list1 '(1 2 3))
        (list2 '(4 5 6)))
    (assert-equality #'equalp
                     '(3 2 1 4 5 6)
                     (nreconc list1 list2))
    (assert-false (equal list1 '(1 2 3)))
    (assert-equality #'equalp
                     '(4 5 6)
                     list2))
  ;;consp
  (assert-true (consp (cons 1 2)))
  (assert-false (consp nil))
  (assert-false (consp #(1 2 3)))
  (assert-true (consp (list 1 2 (list 2 3))))
  (assert-false (consp 'a))
  ;;atom
  (assert-true (atom 'atom))
  (assert-true (atom #(1 2 3)))
  (assert-false (atom '(1 2)))
  (assert-false (atom (cons 1 2)))
  ;;listp
  (assert-true (listp '()))
  (assert-true (listp nil))
  (assert-true (listp (cons 1 2)))
  (assert-false (listp 1))
  (assert-false (listp (make-array 6)))
  ;;null
  (assert-true (null nil))
  (assert-true (null '()))
  (assert-false (null '(1)))
  (assert-false (null t)))
