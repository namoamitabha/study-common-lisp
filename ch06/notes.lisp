(defun foo (x)
  (format t "Parameter: ~a~%" x)
  (let ((x 2))
    (format t "Outer LET: ~a~%" x)
    (let ((x 3))
      (format t "Inner LET: ~a~%" x))
    (format t "Outer LET: ~a~%" x))
  (format t "Parameter: ~a~%" x))


(let* ((x 10)
       (y (+ x 10)))
  (list x y))


(let ((x 10))
  (let ((y (+ x 10)))
    (list x y)))

(defparameter *fn* (let ((count 0))
		     #'(lambda ()
			 (setf count (1+ count)))))

(let ((count 0))
  (list
   #'(lambda () (incf count))
   #'(lambda () (decf count))
   #'(lambda () count)))


(defvar *x* 10)
(defun foo ()
  (format t "X: ~d~%" *x*))

(let ((*x* 20))
  (foo))


(defun bar ()
  (foo)
  (let ((*x* 20))
    (foo))
  (foo))

(defun foo ()
  (format t "Before assignment~18tX: ~d~%" *x*)
  (setf *x* (+ 1 *x*))
  (format t "After assignment~18tX: ~d~%" *x*))

(defconstant +test+ "TEST" "test defconstant")

(setf x 10)

(defun foo (x)
  (setf x 20))

(let ((y 20))
  (foo y)
  (print y))

(setf x 1 y 2)

(setf x (setf y (random 10)))

(incf x)

(decf x)

(incf x 10)

(setf a (make-array 5))

(incf (aref a (random (length a))))


(setf b 1 c 2)

(rotatef b c)

(shiftf b c)
