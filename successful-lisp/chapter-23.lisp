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

;;Recover from conditions using restarts
(progn (cerror "Go ahead, make my day."
	       "Do you fell lucky?")
       "Just kidding")

(defun expect-type (object type default-value)
  (if (typep object type)
      object
      (progn (cerror "Substitue the default value ~2*~S."
		     "~S is not of the expected type ~S"
		     object type default-value)
	     default-value)))

(expect-type "Nifty" 'string "Bear")
(expect-type 7 'string "Bear")

(define-condition expect-type-error (error)
  ((object :initarg :object :reader object)
   (type :initarg :object :reader type))
  (:report (lambda (condition stream)
	     (format stream "~S is not of the expected type ~S."
		     (object condition)
		     (type condition)))))

(defun expect-type (object type default-value)
  (if (typep object type)
      object
      (progn (cerror "Substitue the default value ~5*~S."
		     'expect-type-error
		     :object object
		     :type type
		     :ignore default-value
		     :allow-other-keys t)
	     default-value)))

(expect-type "Nifty" 'string "Bear")
(expect-type 7 'string "Bear")

(defun my-divide (numerator denominator)
  (assert (not (zerop denominator)))
  (/ numerator denominator))

(my-divide 3 0)

(defun my-divide (numertator denominator)
  (assert (not (zerop denominator)) (numertator denominator))
  (/ numertator denominator))

(my-divide 3 0)

(defun my-divide (numerator denominator)
  (assert (not (zerop denominator)) (numerator denominator)
	  "You can't divide ~D by ~D." numerator denominator)
  (/ numerator denominator))

(my-divide 3 0)

(define-condition high-disk-utilization ()
  ((disk-name :initarg :disk-name :reader disk-name)
   (current :initarg :current :reader current-utilization)
   (threshold :initarg :threshold :reader threshold))
  (:report (lambda (condition stream)
	     (format stream "Disk ~A is ~D% full; threshold is ~D%."
		     (disk-name condition)
		     (current-utilization condition)
		     (threshold condition)))))

(defun get-disk-utilization (disk-name)
  93)

(defun check-disk-utilization (name threshold)
  (let ((utilization (get-disk-utilization name)))
    (when (>= utilization threshold)
      (signal 'high-disk-utilization
	      :disk-name name
	      :current utilization
	      :threshold threshold))))

(defun log-to-disk (record name)
  (handler-bind ((high-disk-utilization
		  #'(lambda (c)
		      (when (y-or-n-p "~&~A Panic?" c)
			(return-from log-to-disk nil)))))
    (check-disk-utilization name 90)
    (print record))
  t)

(log-to-disk "Hello" 'disk1)
(log-to-disk "Goodbye" 'disk1)
(check-disk-utilization 'disk1 90)


(define-condition device-unresponsive ()
  ((device :initarg :device :reader device))
  (:report (lambda (condition stream)
	     (format stream "Device ~A is unreponsive."
		     (device condition)))))

(defun send-query (device query)
  (format t "~&Sending ~S ~S~%" device query))

(defun accept-response (device)
  nil)

(defun reset-device (device)
  (format t "~&Resetting ~S~%" device))

(defun query-device (device)
  (restart-bind
      ((nil #'(lambda () (reset-device device))
	 :report-function
	 #'(lambda (stream)
	     (format stream "Reset device.")))
       (nil #'(lambda () (format t "~&New device:")
		      (finish-output)
		      (setq device (read)))
	 :report-function
	 #'(lambda (stream)
	     (format stream "Try a different device.")))
       (nil #'(lambda () (return-from query-device :gave-up))
	 :report-function
	 #'(lambda (stream)
	     (format stream "Give up."))))
    (loop
       (send-query device 'query)
       (let ((answer (accept-response device)))
	 (if answer
	     (return answer)
	     (cerror "Try again."
		     'device-unresponsive :device device))))))

(query-device 'foo)


(ignore-errors
  (error "Something bad has happened")
  (print "Didn't get here."))

(ignore-errors
  (* 7 9))

(ignore-errors
  (/ 7 0))

(defmacro report-error (&body body)
  (let
      ((results (gensym))
       (condition (gensym)))
    `(let
	 ((,results (multiple-value-list
		     (ignore-errors ,@body))))
       (if (and (null (first ,results))
		(typep (second ,results) 'condition)
		(null (nthcdr 2 ,results)))
	   (let ((,condition (second ,results)))
	     (typecase ,condition
	       (simple-condition
		(apply #'format t
		       (simple-condition-format-control ,condition)
		       (simple-condition-format-arguments ,condition)))
	       (otherwise
		(format t "~A error." (type-of ,condition))))
	     (values))
	   (values-list ,results)))))

(report-error (error "I feel like I'm losing my mind, Dave."))

(report-error (+ 1 no-variable-by-this-name))

(report-error (+ 7 'f))

(report-error (let ((n 1)) (/ 8 (decf n))))

(report-error (* 2 pi))

(report-error (values 1 2 3 4))
