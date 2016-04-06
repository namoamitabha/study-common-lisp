(let ((in (open "ps.txt")))
  (format t "~a~%" (read-line in))
  (close in))
