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

(defparameter *plist* ())

(define-test test-Lookup-Tables-Alists-and-Plists
    (:tag :unittest)
  (let ((alst '((a . 1) (b . 2) (c . 3))))
    (assert-equality #'equalp
                     '(a . 1)
                     (assoc 'a alst))
    (assert-equality #'equalp
                     '(c . 3)
                     (assoc 'c alst))
    (assert-equality #'equalp
                     nil
                     (assoc 'd alst))
    (assert-equal 1
                  (cdr (assoc 'a alst))))
  (let ((alst '(("a" . 1) ("b" . 2) ("c" . 3))))
    (assert-equality #'equalp
                     '("a" . 1)
                     (assoc "a" alst :test #'string=))
    (assert-false (assoc "a" alst)))
  (assert-equality #'equalp
                   '(a . 10)
                   (assoc 'a '((a . 10) (a . 1) (b . 2) (c . 3))))
  (let ((alst))
    (setf alst (acons 'a 1 alst))
    (assert-equality #'equalp
                     '(a . 1)
                     (assoc 'a alst))
    (push (cons 'b 2) alst)
    (assert-equality #'equalp
                     '(b . 2)
                     (assoc 'b alst))
    (assert-equality #'equalp
                     '((b . 2) (a . 1))
                     alst))
  (assert-equality #'equalp
                   '((c . 3) (b . 2) (a . 1))
                   (pairlis '(a b c) '(1 2 3)))
  (assert-false *plist*)
  (setf (getf *plist* :a) 1)
  (assert-equality #'equalp
                   '(:a 1)
                   *plist*)
  (setf (getf *plist* :a) 2)
  (assert-equality #'equalp
                   '(:a 2)
                   *plist*)
  (setf (getf *plist* :b) 2)
  (assert-equality #'equalp
                   '(:b 2 :a 2)
                   *plist*)
  (remf *plist* :a)
  (assert-equality #'equalp
                   '(:b 2)
                   *plist*)
  (setf (get :a "a-key") "a-value")
  (assert-equality #'equalp
                   '("a-key" "a-value")
                   (symbol-plist :a)))
