(define-test test-join
    (:tag :unittest)
  (assert-equal (join 1 2 3 4 5) 15)
  (assert-equal (join '(a) '(b) '(c) '(d) '(e))
                '(a b c d e)))
