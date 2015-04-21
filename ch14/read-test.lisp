(let ((in (open "s-expression.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read in nil)
	 while line do (print line))
    (close in)))

