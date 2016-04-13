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

;;5.3 Memoizing

(defun memoize (fn)
  (let ((cache (make-hash-table :test #'equal)))
    #'(lambda (&rest args)
        (multiple-value-bind (val win)
            (gethash args cache)
          (if win
              val
              (setf (gethash args cache)
                    (apply fn args)))))))

(setq slowid (memoize #'(lambda (x) (sleep 5) x)))

(time (funcall slowid 1))

(time (funcall slowid 1))

;;5.4 Composing Functions
(equal (last '(1 2 3)) '(3))
(equal (last '(a b c) 2) '(b c))
(equal (butlast '(1 2 3 4 5 6)) '(1 2 3 4 5))
(equal (butlast '(1 2 3 4 5 6) 3) '(1 2 3))

(equal (reduce #'* '(1 2 3 4 5)) 120)
(equal (reduce #'append '((1) (2)) :from-end t
                                   :initial-value '(i n i t))
       '(1 2 I N I T))
(equal (reduce #'list '(1 2 3 4)) '(((1 2) 3) 4))
(equal (reduce #'list '(1 2 3 4)
               :from-end t :initial-value 'foo)
       '(1 (2 (3 (4 foo)))))

(defun compose (&rest fns)
  (if fns
      (let ((fn1 (car (last fns)))
            (fns (butlast fns)))
        #'(lambda (&rest args)
            (reduce #'funcall fns
                    :from-end t
                    :initial-value (apply fn1 args))))
      #'identity))
(assert (equal (funcall (compose #'list #'1+) 1)
               '(2)))

(assert (equal (funcall #'(lambda (x) (list (1+ x))) 1)
               '(2)))

(assert (equal (funcall (compose #'1+ #'find-if) #'oddp '(2 3 4))
               4))

(assert (equal (funcall (compose #'list #'*) 1 2 3 4 5 6)
               '(720)))

(defun complement (pred)
  (compose #'not pred))

(defun fif (if then &optional else)
  #'(lambda (x)
      (if (funcall if x)
          (funcall then x)
          (if else (funcall else x)))))

;; (mapcar #'(lambda (x)
;;             (if (slave x)
;;                 (owner x)
;;                 (employer x))))

;;(mapcar (fif #'slave #'owner #'employer) people)

(defun fint (fn &rest fns)
  (if (null fns)
      fn
      (let ((chain (apply #'fint fns)))
        #'(lambda (x)
            (and (funcall fn x) (funcall chain x))))))

(find-if #'(lambda (x)
             (and (signed x) (sealed x) (delivered x)))
         docs)

(find-if (fint #'signed #'sealed #'delivered) docs)

(defun fun (fn &rest fns)
  (if (null fns)
      fn
      (let ((chain (apply #'fun fns)))
        #'(lambda (x)
            (or (funcall fn x) (funcall chain x))))))
