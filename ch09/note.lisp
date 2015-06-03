(defun test-+ ()
  (check
   (= (+ 1 2 ) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))

(defmacro check (&body forms)
  `(progn
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(defun report-result (result form)
  (format t "~:[FAIL~;PASS~] ...~a~%" result form))
