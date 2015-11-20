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
	(setq tmp (cons (car l) (nil-nth (1- n) (rest l)))))
    (print tmp)
    tmp))

(defparameter *my-list* (list 1 2 3 4))
(nil-nth 1 *my-list*)
*my-list*
;;********************
(defparameter list1 (list 1 2 3))
(defparameter list2 (list 4 5 6))
(append list1 list2)
(nconc list1 list2)

;;********************
(defparameter *my-list* (list 1 2 3 4))
(rplacd *my-list* (cdr (cdr *my-list*)))

(let ((l (list 1)))
  (rplacd l l)
  l)

(let ((l (list 2)))
  (rplaca l l)
  l)

;;********************
(defparameter *my-list* (list 1 2 3 4))
(delete 3 *my-list*)
(delete 1 *my-list*)

(defparameter *stack* ())
(push 3 *stack*)
(push 2 *stack*)
(push 1 *stack*)
(pop *stack*)
*stack*

;;********************
(defun stomp-a-constant ()
  (let ((l '(1 2 3)))
    (print l)
    (setf (second l) nil)
    l))

(stomp-a-constant)
(stomp-a-constant)
