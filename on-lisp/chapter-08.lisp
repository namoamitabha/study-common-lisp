;;8.1 When Nothing Else Will Do
(defun 1+ (x) (+ 1 x))

(defmacro 1+ (x) `(+ 1 ,x))

(defmacro while (test &body body)
  `(do ()
       ((not ,test))
     ,@body))

;;8.2 Macro or Function?
(defun avg (&rest args)
  (/ (apply #'+ args) (length args)))

(defmacro avg (&rest args)
  `(/ (+ ,@args) ,(length args)))
