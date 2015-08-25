;; chapter 4

;;top loop
(loop
   (terpri)
   (princ 'ready>)
   (print (eval (read))))

(defun quadratic-roots (a b c)
  "Returns the roots of a quadratic equation aX^2 + bX + c = 1"
  (let ((discriminant (- (* b b ) (* 4 a c))))
    (values
     (/ (+ (- b)  (sqrt discriminant))  (* 2 a))
     (/ (-  (- b)  (sqrt discriminant))  (* 2 a)))))

(documentation 'quadratic-roots 'function)


(defun quadratic-roots-2 (a b c)
  "Returns the roots of a quadratic equation aX^2 + bX + c = 1
Returns only one value if the roots are coincident"
  (let ((discriminant (- (* b b ) (* 4 a c))))
    (cond
      ((zerop discriminant)
       (/ (+ (- b)  (sqrt discriminant))  (* 2 a)))
      ( t
       (values
	(/ (+ (- b)  (sqrt discriminant))  (* 2 a))
	(/ (-  (- b)  (sqrt discriminant))  (* 2 a)))))))

(documentation 'quadratic-roots-2 'function)

;;optional parameter
(defun silly-list-1 (p1 p2 &optional p3 p4)
  (list p1 p2 p3 p4))

;;rest parameter
(defun silly-list-2 (p1 p2 &rest p3)
  (list p1 p2 p3))

(defun silly-list-3 (p1 p2 &optional p3 p4 &rest p5)
  (list p1 p2 p3 p4 p5))

;;global variable
(defvar *var1* 'test "defvar global variable test")

(defparameter *var2* 'defpTEST "defparameter global variable test")

(defconstant +cons1+ 'constant1 "defconstant test")
(documentation '+CONS1+ 'variable)

;;recursive functions
(defun my-length (list)
  (cond
    ((eq nil list) 0)
    (t (+ 1 (my-length (rest list))))))

(defun factorial (n)
  (cond ((= n 0) 1)
	(t (* n (factorial (- n 1))))))

(defun factorial-tr (n)
  (factorial-tr-helper n 1))

(defun factorial-tr-helper (n product)
  (cond ((zerop n) product)
	(t (factorial-tr-helper (- n 1) (* product n)))))

(defun broken-factorial (n)
  (cond ((= n 0) 1)
	((= n 1) (break))
	(t (* n (broken-factorial (- n 1))))))

(defun broken-factorial-tr (n)
  (broken-factorial-tr-helper n 1))

(defun broken-factorial-tr-helper (n product)
  (cond ((zerop n) product)
	((= n 1) (break))
	(t (broken-factorial-tr-helper (- n 1) (* product n)))))

;;exercise in naming
(defun funny (funny)
  "funny. .."
  (if (zerop funny)
      :funny
      (list
       (cons funny
	     (let ((funny funny))
	       (setq funny (1- funny))
	       (funny funny)))
       funny)))

(defun foo () 1)

(defun baz ()
  (flet ((foo () 2)
	(bar () (foo)))
    (values (foo) (bar))))

(defun raz ()
  (labels ((foo () 2)
	   (bar () (foo)))
    (values (foo) (bar))))

;;reading writing and arithmetic
(defun simple-adding-machine-1 ()
  (let ((sum 0)
	(next))
    (loop
       (setq next (read))
       (format t "next=~a, sum=~a~%" next sum)
       (cond
	 ((numberp next)
	  (incf sum next)
	  (format t "next=~a, sum=~a~%" next sum))
	 ((eq '= next)
	  (print sum)
	  (return))
	 (t
	  (format t "~&~A ignored!~%" next))))
    (values)))

(with-open-file (in-stream "infile.dat" :direction :input)
  (with-open-file (out-stream "outfile.dat" :direction :output)
    (let ((*standard-input* in-stream)
	  (*standard-output* out-stream))
     ;; (declare (special *standard-input* *standard-output*))
      (simple-adding-machine-1))))

(defun simple-adding-machine-2 (&optional (in-stream *standard-input*)
				  (out-stream *standard-output*))
  (let ((sum 0)
	(next))
    (loop
       (setq next (read in-stream))
       (cond ((numberp next)
	      (incf sum next))
	     ((eq '= next)
	      (print sum out-stream)
	      (return))
	     (t
	      (format out-stream "~&~A ignored!~%" next))))
    (values)))

(with-open-file (in-stream "infile.dat" :direction :input)
  (with-open-file (out-stream "outfile.dat"
			      :direction :output
			      :if-exists :supersede)
    (simple-adding-machine-2 in-stream out-stream)))
