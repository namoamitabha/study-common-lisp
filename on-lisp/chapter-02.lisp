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

;;2.5
(let ((y 7))
  (defun scope-test (x)
    (list x y)))

(let ((y 5))
  (scope-test 3))

;;2.6
(defun list+ (lst n)
  (mapcar #'(lambda (x) (+ x n))
	  lst))

(list+ '(1 2 3) 10)

(let ((counter 0))
  (defun new-id () (incf counter))
  (defun reset-id () (setq counter 0)))

(new-id)
(reset-id)

(defun make-adder (n)
  #'(lambda (x) (+ x n)))

(setq add2 (make-adder 2)
      add10 (make-adder 10))
(funcall add2 5)
(funcall add10 3)

(defun make-adderb(n)
  #'(lambda (x &optional change)
      (if change
	  (setq n x)
	  (+ x n))))

(setq addx (make-adderb 1))
(funcall addx 3)
(funcall addx 100 t)
(funcall addx 3)

(defun make-dbms (db)
  (list
   #'(lambda (key)
       (cdr (assoc key db)))
   #'(lambda (key val)
       (push (cons key val) db)
       key)
   #'(lambda (key)
       (setf db (delete key db :key #'car))
       key)))

(setq cities (make-dbms '((boston . us) (paris . france))))

(funcall (car cities) 'boston)
(funcall (second cities) 'london 'england)
(funcall (car cities) 'london)

(defun lookup (key db)
  (funcall (car db) key))

(lookup 'london cities)
(lookup 'boston cities)
(lookup 'paris cities)
cities


;;2.7
