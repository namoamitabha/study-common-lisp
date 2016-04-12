;;5.1 Common Lisp Evolves
(defun joiner (obj)
  (typecase obj
    (cons #'append)
    (number #'+)))

(defun join (&rest args)
  (apply (joiner (car args)) args))

(assert (equal (join 1 2 3 4 5) 15))
(assert (equal (join '(a) '(b) '(c) '(d) '(e))
               '(a b c d e)))

(defun complement (fn)
  #'(lambda (&rest args) (not (apply fn args))))

(assert (equal (remove-if (complement #'oddp) '(1 2 3 4 5 6))
               '(1 3 5)))

