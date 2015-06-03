(defun report-result (result form)
  (format t "~:[FAIL~;PASS~] ...~a~%" result form)
  result)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check (&body forms)
  `(combine-results
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(defun test-+ ()
  (check
   (= (+ 1 2 ) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))


(defun test-+ ()
  (check
   (= (+ 1 2 ) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))


