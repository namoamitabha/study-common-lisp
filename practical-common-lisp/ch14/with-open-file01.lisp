(with-open-file (stream "tmp-with-open-file01.txt~" 
			:direction :output
			:if-exists :supersede)
  (when stream
    (dotimes (i 256)
      (write-string (write-to-string i) stream))))
