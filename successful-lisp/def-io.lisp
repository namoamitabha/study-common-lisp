(defmacro def-i/o (writer-name reader-name (&rest vars))
  (let ((file-name (gensym))
	(var (gensym))
	(stream (gensym)))
    `(progn
       (defun ,writer-name (,file-name)
	 (let ((*print-readably* t))
	   (with-open-file (,stream ,file-name
				    :direction :output
				    :if-exists :supersede)
	     (dolist (,var (list ,@vars))
	       (declare (special ,@vars))
	       (print ,var ,stream)))))
       (defun ,reader-name (,file-name)
	 (with-open-file (,stream ,file-name
				  :direction :input
				  :if-does-not-exist :error)
	   (dolist (,var ',vars)
	     (set ,var (read ,stream)))))
       t)))

;;test def-i/o
(def-i/o save-checks load-checks (*checks* *next-check-number* *payees*))

;;(macroexpand '(def-i/o save-checks load-checks (*checks* *next-check-number* *payees*)))

;;(pprint (macroexpand '(def-i/o save-checks load-checks (*checks* *next-check-number* *payees*))))

(save-checks "checks.dat")

(makunbound '*checks*)
(makunbound '*next-check-number*)
(makunbound '*payees*)

(load-checks "checks.dat")
