;;3.1 Functional Design
(defun good-reverse (lst)
  (labels ((rev (lst acc)
	         (if (null lst)
		     acc
		     (rev (cdr lst) (cons (car lst) acc)))))
    (rev lst nil)))

(setq lst '(a b c))
(good-reverse lst)

(reverse lst)
(setq lst (reverse lst))

(setq lst '(a b c))
(nreverse lst)
lst

(truncate 26.21875)
(= (truncate 26.21875) 26)

(multiple-value-bind (int frac) (truncate 26.21875)
  (list int frac))

(defun powers (x)
  (values x (sqrt x) (expt x 2)))

(multiple-value-bind (base root square) (powers 4)
  (list base root square))
