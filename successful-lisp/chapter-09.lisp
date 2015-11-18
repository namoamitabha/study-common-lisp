;;********************
(let ((file-name ""))
  (catch 'test
    (unwind-protect
	 (progn
	   (print "a")
	   (throw 'test "done"))
      (print "clean resource"))
    (print "outer")))

;;********************
(defun block-demo (flag)
  (print 'before-outer)
  (block outer
    (print 'before-inner)
    (print (block inner
	     (if flag
		 (return-from outer 7)
		 (return-from inner 3))
	     (print 'never-print-this)))
    (print 'after-inner)
    t))
(block-demo t)
(block-demo nil)

(defun block-demo-2 (flag)
  (when flag
    (return-from block-demo-2 nil))
  t)

(block-demo-2 t)
(block-demo-2 nil)

;;********************
(let ((i 0))
  (loop
     (when (> i 5)
       (return))
     (print i)
     (incf i)))

(dotimes (i 10)
  (when (> i 3)
    (return t))
  (print i))

(dotimes (i 10)
  (when (> i 3)
    (return-from nil t))
  (print i))

;;********************
(defun bad-fn-a ()
  (bad-fn-b))

(defun bad-fn-b ()
  (bad-fn-c))

(defun bad-fn-c ()
  (return-from bad-fn-a))

;;(bad-fn-a)

;;********************
(defun fn-a ()
  (catch 'fn-a
    (print 'before-fn-b-call)
    (fn-b)
    (print 'after-fn-b-call)))

(defun fn-b ()
  (print 'before-fn-c-call)
  (fn-c)
  (print 'after-fn-c-call))

(defun fn-c ()
  (print 'before-throw)
  (throw 'fn-a 'done)
  (print 'after-throw))

;;********************
;;with-open-file
