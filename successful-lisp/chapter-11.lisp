(let ((e 1))
  (defun closure-1 () e))

(closure-1)

(let ((e 1))
  (defun closure-1 () e)
  (setq e 7)
  (defun closure-2 () e))

(let ((counter 0))
  (defun counter-next ()
    (incf counter))
  (defun counter-reset ()
    (setq counter 0)))


(let ((fns ()))
  (dotimes (i 3)
    (push #'(lambda () i) fns))
  (mapcar #'funcall fns))

(let ((fns ()))
  (dotimes (i 3)
    (let ((i i))
      (push #'(lambda () i) fns)))
  (mapcar #'funcall fns))


(defun nil-nth (n l)
  (setf (nth n l) nil)
  1)
(defparameter *my-list* (list 1 2 3 4))

(nil-nth 1 *my-list*)
*my-list*

(defun nil-nth (n l)
  (let ((tmp))
    (if (zerop n)
	(setq tmp (cons nil (rest l)))
	(setq tmp (cons (car l) (nil-nth (1- n) (rest l))))))
  (print tmp)
  tmp)

(defparameter *my-list* (list 1 2 3 4))
(nil-nth 1 *my-list*)
*my-list*
;;********************

