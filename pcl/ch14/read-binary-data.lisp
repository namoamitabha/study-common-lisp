(let ((in (open "ps.txt" 
		:if-does-not-exist nil 
		:element-type '(unsigned-byte 8))))
  (when in
    (loop for byte = (read-byte in nil)
	 while byte do (print byte))
    (close in)))
