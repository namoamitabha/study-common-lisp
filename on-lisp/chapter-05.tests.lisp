;;(use-package :on-lisp-ch05)

(define-test test-join
    (:tag :unittest)
  (assert-equal (on-lisp-ch05::join 1 2 3 4 5) 15)
  (assert-equal (on-lisp-ch05::join '(a) '(b) '(c) '(d) '(e))
                '(a b c d e)))

(define-test test-list-unit
    (:tag :unittest)
  ;;(setq *print-readably* t)
  (assert-prints ":a"(format t "~a" ":a")))

(define-test test-remove-if
    (:tag :unittest)
  (assert-equal (remove-if (complement #'oddp) '(1 2 3 4 5 6))
                '(1 3 5)))

(define-test test-!
    (:tag :unittest)
  (let ((lst '(1 2 3 4)))
    (assert-equal (delete-if #'oddp lst)
                  (funcall (on-lisp-ch05::! #'remove-if) #'oddp lst))))

(define-test test-memoize
    (:tag :unittest)
  (let ((slowid (on-lisp-ch05::memoize #'(lambda (x) (sleep 1) x))))
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
  (assert-equal (funcall (on-lisp-ch05::compose #'list #'1+) 1)
                '(2))
  (assert-equal (funcall #'(lambda (x) (list (1+ x))) 1)
                '(2))
  (assert-equal (funcall (on-lisp-ch05::compose #'1+ #'find-if) #'oddp '(2 3 4))
                4)
  (assert-equal (funcall (on-lisp-ch05::compose #'list #'*) 1 2 3 4 5 6)
                '(720)))
