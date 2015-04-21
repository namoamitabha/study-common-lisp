(let ((out (open "tmp-write-string.txt~" 
		 :direction :output 
		 :if-exists :supersede)))
      (when out
	(dotimes (i 256)
	  (write-string (write-to-string i) out))
	(close out)))
