;;5.1 Common Lisp Evolves
(defun joiner (obj)
  (typecase obj
    (cons #'append)
    (number #'+)))

(defun join (&rest args)
  (apply (joiner (car args)) args))

(assert (equal (join 1 2 3 4 5) 15))
(assert (equal (join '(a) '(b) '(c) '(d) '(e))
               '(a b c d e)))

(defun complement (fn)
  #'(lambda (&rest args) (not (apply fn args))))

(assert (equal (remove-if (complement #'oddp) '(1 2 3 4 5 6))
               '(1 3 5)))

;;5.2 Orthogonality
(defvar *!equive* (make-hash-table))

(defun ! (fn)
  (or (gethash fn *!equive*) fn))

(defun def! (fn fn!)
  (setf (gethash fn *!equive*) fn!))

(def! #'remove-if #'delete-if)

(let ((lst '(1 2 3 4)))
  (equal (delete-if #'oddp lst)
         (funcall (! #'remove-if) #'oddp lst)))
