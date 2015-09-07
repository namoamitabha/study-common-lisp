(loop
     (print "Look, I'm looping"))

(loop
   (print (eval (read))))

(loop
   (print "Here I am.")
   (return 17)
   (print "I never got here."))

(let ((n 0))
  (loop
     (when (> n 10) (return))
     (print n) (prin1 (* n n))
     (incf n)))

(dotimes (n 11 r)
  (print n) (prin1 (* n n))
  (setf r (* n N)))

;;dolist
;;failed example
(dolist (item '(1 2 4 5 9 17 25))
  (format t "~&~D is~:[n't~;~] a perfect square.~%"
	  item (integerp (sqrt item))))

(dolist (item `(1 foo "hello" 79.9 2/9 ,#'abs))
  (format t "~&~S is a ~A~%" item (type-of item)))

;;do
(do
 ((which 1 (1+ which))
  (list '(foo bar baz qux) (rest list)))
 ((null list) 'done)
  (format t "~&Item ~D is ~S.~%" which (first list)))
