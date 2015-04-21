(with-open-file (stream "ps.txt" 
			:if-does-not-exist nil)
  (when stream
    (loop for line = (read-line stream nil)
	 while line do
	 (print line))))

