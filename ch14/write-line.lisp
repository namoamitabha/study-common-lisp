(let ((out (open "tmp-write-line.txt~" 
		 :direction :output 
		 :if-exists :supersede)))
      (when out
	(dotimes (i 256)
	  (write-line (write-to-string i) out))
	(close out)))
