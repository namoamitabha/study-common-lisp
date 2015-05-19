;;;required parameter
(defun verbose-sum (x y)
  "Sum any two numbers after printing a message."
  (format t "Summing ~d and ~d.~%" x y)
  (+ x y))

;;;optional parameter
(defun foo (a b &optional c d)
  (list a b c d))


(defun foo (a &optional (b 10))
  (list a b))


(defun make-rectangle (width &optional (height width))
  (list width height))


(defun foo (a b &optional (c 3 c-supplied-p))
  (list a b c c-supplied-p))


;;;rest parameter

(defun foo (a &rest values)
  (list a)
  values)


;;;keyword parameter
(defun foo (&key a b c)
  (list a b c))


(defun foo (&key (a 0) (b 0 b-supplied-p) (c (+ a b)))
  (list a b c b-supplied-p))


(defun foo (&key ((:apple a )) ((:box b) 0) ((:charlie c) 0 c-cupplied-p))
  (list a b c c-cupplied-p))

;;;mixing different parameter types
(defun foo (x &optional y &key z)
  (list x y z))

(defun foo (&rest rest &key a b c)
  (list rest a b c))

;;;function return values

(defun foo (n)
  (dotimes (i 10)
    (dotimes (j 10)
      (when (> (* i j) n)
	(return-from foo (list i j))))))

;;; functions as data, a.k.a higher-order functions

(defun foo (x) (* 2 x))

(defun plot (fn min max step)
  (loop for i from min to max by step do
       (loop repeat (funcall fn i) do (format t "*"))
       (format t "~%")))

(funcall #'(lambda (x y) (+ x y)) 2 3)

((lambda (x y) (+ x y)) 2 3)

(defun double-2 (x) (* 2 x))
