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

;;3.2 Imperative Outside-in
(defun fun (x)
  (list 'a (expt (car x) 2)))

(defun imp (x)
  (let (y sqr)
    (setq y (car x))
    (setq sqr (expt y 2))
    (list 'a sqr)))

;;3.3 Funtional Interfaces
(defun qualify (expr)
  (nconc (copy-list expr) (list 'maybe)))

(setq lst '(a b c))
(qualify lst)
lst

(defun ok (x)
  (nconc (list 'a x) (list 'c)))
(ok lst)
lst

(defun not-ok (x)
  (nconc (list 'a) x (list 'c)))
(not-ok lst)
lst

(defun anything (x)
  (+ x *anything*))

(defun exclaim (expression)
  (append expression '(oh my)))

(exclaim '(lions and tigers and bears))
(nconc * '(goodness))
(exclaim '(fixnums and bignums and floats))

(defun exclaim (expression)
  (append expression (list 'oh 'my)))
(exclaim '(lions and tigers and bears))
(nconc * '(goodness))
(exclaim '(fixnums and bignums and floats))

;;3.4 Interactive Programming
