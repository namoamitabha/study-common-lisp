(let ((out (open "tmp-write-char.txt~" 
		 :direction :output 
		 :if-exists :supersede)))
      (when out
	(dotimes (i 256)
	  (write-char (code-char i) out))
	(close out)))
