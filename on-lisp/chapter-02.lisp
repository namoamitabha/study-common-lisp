(defun double (x) (* x 2))

(double 1)

#'double

(eq #'double (car (list #'double)))

(lambda (x) (* x 2))

#'(lambda (x) (* x 2))

(double 3)

((lambda (x) (* x 2)) 3)

(setq double 2)
(double double)

(symbol-value 'double)

(symbol-function 'double)

(setq x #'append)
(eq (symbol-value 'x) (symbol-function 'append))

(defun double (x) (* x 2))
(setf (symbol-function 'double) #'(lambda (x) (* x 2)))
