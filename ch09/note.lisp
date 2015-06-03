(defvar *test-name* nil)

(defun report-result (result form)
  "Report the results of a single test case. Called by 'check'."
  (format t "~:[FAIL~;PASS~] ...~a: ~a~%" result *test-name* form)
  result)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro combine-results (&body forms)
  "Combine the results (as bolleans) of evaluating 'forms' in order."
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check (&body forms)
  "Run each expression in 'forms' as a  test case"
  `(combine-results
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro deftest (name parameters &body body)
  "Define a test function. Within a test function we can call
  other test functions or use 'check' to ru individual test
  cases."
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

(deftest test-+1 ()
  (check
   (= (+ 1 2 ) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))


(deftest test-+2 ()
  (check
   (= (+ 1 2 ) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -5)))

(deftest test-* ()
  (check
   (= (* 2 2) 4)
   (= (* 3 5) 15)))

(deftest test-arithmetic ()
  (combine-results
   (test-+1)
   (test-+2)
   (test-*)))

(deftest test-match ()
  (test-arithmetic))
