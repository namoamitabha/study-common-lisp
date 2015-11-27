(defun keyword-sample-1 (a b c &key d e f)
  (list a b c d e f))

(keyword-sample-1 1 2 3)
(keyword-sample-1 1 2 3 :d 4)
(keyword-sample-1 1 2 3 :e 5)
(keyword-sample-1 1 2 3 :f 6 :d 4 :e 5)
;; (1 2 3 NIL NIL NIL)
;; *
;; (1 2 3 4 NIL NIL)
;; *
;; (1 2 3 NIL 5 NIL)
;; *
;; (1 2 3 4 5 6)
;; *

;;********************
(defun keyword-sample-2 (a &key (b 77) (c 88))
  (list a b c))

(keyword-sample-2 1)
(keyword-sample-2 1 :c 3)

;; (1 77 88)
;; *
;; (1 77 3)
;; *

(defun keyword-sample-3 (a &key (b nil b-p) (c 53 c-p))
  (list a b b-p c c-p))

(keyword-sample-3 1)
(keyword-sample-3 1 :b 74)
(keyword-sample-3 1 :b nil)
(keyword-sample-3 1 :c 9)
;; (1 NIL NIL 53 NIL)
;; *
;; (1 74 T 53 NIL)
;; *
;; (1 NIL T 53 NIL)
;; *
;; (1 NIL NIL 9 T)
;; *

(defun optional-sample-1 (a &optional (b nil b-p))
  (list a b b-p))

(optional-sample-1 1)
(optional-sample-1 1 nil)
(optional-sample-1 1 2)
;; (1 NIL NIL)
;; *
;; (1 NIL T)
;; *
;; (1 2 T)
;; *

(defun optional-keyword-sample-1 (a &optional b c &key d e)
  (list a b c d e))

(optional-keyword-sample-1 1)
(optional-keyword-sample-1 1 2)
(optional-keyword-sample-1 1 2 3)
(optional-keyword-sample-1 1 2 3 :e 5)
;; (1 NIL NIL NIL NIL)
;; *
;; (1 2 NIL NIL NIL)
;; *
;; (1 2 3 NIL NIL)
;; *
;; (1 2 3 NIL 5)

(defun optional-keyword-sample-2 (a &optional b c d &key e f)
  (list a b c d e f))

(optional-keyword-sample-2 1 2 :e 1)
;; * (optional-keyword-sample-2 1 2 :e 1)

;; (1 2 :E 1 NIL NIL)

;;********************
(defmacro destructuring-sample-1 ((a b) (c d))
  `(list ',a ',b ',c ',d))

(destructuring-sample-1 (1 2) (3 4))
;; * (destructuring-sample-1 (1 2) (3 4))

;; (1 2 3 4)

(defmacro destructuring-sample-2 ((a &key b) (c &optional d))
  `(list ',a ',b ',c ',d))

(destructuring-sample-2 (1) (3))
(destructuring-sample-2 (1 :b 2) (3))
(destructuring-sample-2 (1) (3 4))
;; (1 NIL 3 NIL)
;; *
;; (1 2 3 NIL)
;; *
;; (1 NIL 3 4)
;; *

(defmacro destructuring-sample-3 ((a &key b) (c (d e)) &optional f)
  `(list ',a ',b ',c ',d ',e ',f))

(destructuring-sample-3 (1) (3 (4 5)))
;;(1 NIL 3 4 5 NIL)

(defmacro with-processes ((name
			   (pid num-processes)
			   (work-item work-queue)) &body body)
  (let ((process-fn (gensym))
	(items (gensym))
	(items-lock (gensym)))
    `(let ((,items (copy-list ,work-queue))
	   (,items-lock (make-lock)))
       (flet ((,process-fn (,pid)
		(let ((,work-item nil))
		  (loop
		     (with-lock-grabbed (,items-lock)
		       (setq ,work-item (pop ,items)))
		     (when (null ,work-item)
		       (return))
		     ,@body))))
	 (dotimes (i ,num-processes)
	   (process-run-function
	    (format nil "~A-~D" ,name i)
	    #',process-fn
	    i))))))

(with-processes ("Test"
		 (id 3)
		 (item '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))
  (format t "~&id ~D item ~A~%" id item)
  (sleep (random 1.0)))
;;doesn't work for make-lock not bound

(destructuring-bind ((a &key b) (c (d e) &optional f))
    '((1 :b 2) (3 (4 5) 6))
  (list a b c d e f))
;;(1 2 3 4 5 6)
