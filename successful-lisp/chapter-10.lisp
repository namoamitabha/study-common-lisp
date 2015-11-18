;;********************
(apropos "length")

;;********************
(describe 'length)
(describe "length")
(describe #'length)

;;********************
(inspect 'length)
(inspect #'length)
(inspect "length")

;;********************
(documentation 'length 'function)
(documentation 'fn-a 'function)

(defun a-function-with-doc-string ()
  "This function always return t"
  t)
(documentation 'a-function-with-doc-string 'function)
