;;2.2
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

;;2.3
(+ 1 2)
(apply #'+ '(1 2))
(apply (symbol-function '+) '(1 2))
(apply #'(lambda (x y) (+ x y)) '(1 2))

(apply #'+ 1 '(2))

(funcall #'+ 1 2)

(mapcar #'(lambda (x) (+ x 10))
	'(1 2 3))

(mapcar #'+
	'(1 2 3)
	'(10 100 1000))

(sort '(1 4 2 5 6 7 3) #'<)

(remove-if #'evenp '(1 2 3 4 5 6 7))

(defun our-remove-if (fn lst)
  (if (null lst)
      nil
      (if (funcall fn (car lst))
	  (our-remove-if fn (cdr lst))
	  (cons (car lst) (our-remove-if fn (cdr lst))))))

(our-remove-if #'evenp '(1 2 3 4 5 6 7))

;;2.4

;;(defun behave (animal)
;;  (funcall (get animal 'behavior)))
;;(setf (get 'dog 'behavior)
;;      #'(lambda ()
;;	  (wag-tail)
;;	  (bark)))
