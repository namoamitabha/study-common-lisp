(defun test-+ ()
   (report-result (= (+ 1 2 ) 3) '(= (+ 1 2 ) 3))
   (report-result (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
   (report-result (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))


(defun report-result (result form)
  (format t "~:[FAIL~;PASS~] ...~a~%" result form))
