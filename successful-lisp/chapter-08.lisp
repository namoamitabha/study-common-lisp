(defparameter *my-special-variable* 17)

(defun show-my-special ()
  (declare (special *my-special-variable*))
  (print *my-special-variable*)
  nil)

(defun do-something-else ()
  (show-my-special))

(defun dynamically-shadow-my-special ()
  (let ((*my-special-variable* 8))
    (do-something-else))
  (show-my-special))

(dynamically-shadow-my-special)
