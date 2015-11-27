(defun divide (numerator denominator)
  (when (zerop denominator)
    (error "Sorry, you can't divide by zero"))
  (/ numerator denominator))

(divide 4 3)
(divide 4 0)

;;********************
(define-condition whats-wrong (error)
  ((what :initarg :what :initform "something" :reader what))
  (:report (lambda (condition stream)
	     (format stream "Foo! ~@(~A~) is wrong."
		     (what condition))))
  (:documentation "Tell the user that something is wrong"))

(define-condition whats-wrong-and-why (whats-wrong)
  ((why :initarg :why :initform "no clue" :reader why))
  (:report (lambda (condition stream)
	     (format stream "Uh oh! ~@(~A~) is wrong. Why? ~@(~A~)."
		     (what condition)
		     (why condition)))))

(error 'whats-wrong-and-why)

(error 'whats-wrong-and-why
       :what "the phase variance"
       :why "insufficient tachyon flux")

(define-condition whats-wrong-is-unfathomable (whats-wrong-and-why) ()
  (:report (lambda (condition stream)
	     (format stream "Gack! ~@(~A~) is wrong for some inexplicable reason."
		     (what condition)))))

(error 'whats-wrong-is-unfathomable)

(let ((my-condition (make-condition 'simple-error
				    :format-control "Can't do ~A."
				    :format-arguments '(undefined-operation))))
  (error my-condition))
