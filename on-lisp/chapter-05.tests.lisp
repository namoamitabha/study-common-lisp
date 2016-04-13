(defpackage on-lisp-ch05.tests
  (:use :common-lisp :lisp-unit :on-lisp-ch05))

(in-package :on-lisp-ch05.tests)

(define-test test-join
    (:tag :unittest)
  (assert-equal (join 1 2 3 4 5) 15)
  (assert-equal (join '(a) '(b) '(c) '(d) '(e))
                '(a b c d e)))

(define-test test-list-unit
    (:tag :unittest)
  ;;(setq *print-readably* t)
  (assert-prints ":a"(format t "~a" ":a")))

(define-test test-remove-if
    (:tag :unittest)
  (assert-equal (remove-if (complement1 #'oddp) '(1 2 3 4 5 6))
                '(1 3 5)))

(define-test test-!
    (:tag :unittest)
  (let ((lst '(1 2 3 4)))
    (assert-equal (remove-if #'oddp lst)
                  (funcall (! #'remove-if) #'oddp lst))))

(define-test test-memoize
    (:tag :unittest)
  (let ((slowid (memoize #'(lambda (x) (sleep 1) x))))
    (time (funcall slowid 1))
    (time (funcall slowid 1))))

(define-test tes-last-butlast
    (:tag :unittest)
  (assert-equal (last '(1 2 3)) '(3))
  (assert-equal (last '(a b c) 2) '(b c))
  (assert-equal (butlast '(1 2 3 4 5 6)) '(1 2 3 4 5))
  (assert-equal (butlast '(1 2 3 4 5 6) 3) '(1 2 3)))

(define-test test-reduce
    (:tag :unittest)
  (assert-equal (reduce #'* '(1 2 3 4 5)) 120)
  (assert-equal (reduce #'append '((1) (2)) :from-end t
                                            :initial-value '(i n i t))
                '(1 2 I N I T))
  (assert-equal (reduce #'list '(1 2 3 4)) '(((1 2) 3) 4))
  (assert-equal (reduce #'list '(1 2 3 4)
                        :from-end t :initial-value 'foo)
                '(1 (2 (3 (4 foo))))))

(define-test test-compose
    (:tag :unittest)
  (assert-equal (funcall (compose #'list #'1+) 1)
                '(2))
  (assert-equal (funcall #'(lambda (x) (list (1+ x))) 1)
                '(2))
  (assert-equal (funcall (compose #'1+ #'find-if) #'oddp '(2 3 4))
                4)
  (assert-equal (funcall (compose #'list #'*) 1 2 3 4 5 6)
                '(720)))

(define-test test-fif
    (:tag :unittest)
  (assert-equal (mapcar (fif #'numberp #'+ #'list) '(1 a 2 b))
                '(1 (A) 2 (B))))

(define-test test-fint
    (:tag :unittest)
  (assert-equal (find-if (fint #'oddp #'plusp #'integerp)
                         '(2 3 4 5))
                3))

(define-test test-fun
    (:tag :unittest)
  (assert-equal '(2 3 4 5 -1)
                (mapc (fun #'oddp #'plusp #'realp)
                      '(2 3 4 5 -1))))

(defun our-length (lst)
  (if (null lst)
      0
      (1+ (our-length (cdr lst)))))

(defun our-every (fn lst)
  (if (null lst)
      t
      (and (funcall fn (car lst))
           (our-every fn (cdr lst)))))

(define-test test-lrec
    (:tag :unittest)
  ;;lrec to implement our-length
  ;; (assert-equal (funcall (lrec #'(lambda (x f)
  ;;                                  (1+ (funcall f)))
  ;;                              0)
  ;;                        '(1 2 3 4 5 6))
  ;;               6)
  (assert-equal (our-length '(1 2 3 4 5 6)) 6)
  (assert-true (our-every #'evenp '(2 4 6 8 10)))
  (assert-false (our-every #'oddp '(2 4 6 8 10)))
  (assert-true (funcall (lrec #'(lambda (x f) (and (oddp x) (funcall f))) t)
                        '(2 4 6 8 10)))
  ;;copy-list
  ;;(lrec #'(lambda (x f) (cons x (funcall f))))
  ;;remove-duplicates
  ;;(lrec #'(lambda (x f) (adjoin x (funcall f))))
  ;;find-if
  ;;(lrec #'(lambda (x f) (if (fn x) x (funcall f))))
  ;;some
  ;;(lrec #'(lambda (x f) (or (fn x) (funcall f))))
  )
