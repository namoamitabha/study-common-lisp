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
