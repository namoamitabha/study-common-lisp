(let ((out (open "tmp-write.txt~" 
		 :direction :output 
		 :if-exists :supersede)))
      (when out
	(dotimes (i 256)
	  (write i :stream out))
	(close out))
      )
