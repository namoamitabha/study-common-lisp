(defpackage on-lisp-ch05
  (:use
   :common-lisp))

(in-package on-lisp-ch05)

;;5.1 Common Lisp Evolves
(defun join (&rest args)
  (apply (joiner (car args)) args))

(defun joiner (obj)
  (typecase obj
    (cons #'append)
    (number #'+)))

(defun complement1 (fn)
  #'(lambda (&rest args) (not (apply fn args))))

;;5.2 Orthogonality
(defvar *!equive* (make-hash-table))

(defun ! (fn)
  (or (gethash fn *!equive*) fn))

(defun def! (fn fn!)
  (setf (gethash fn *!equive*) fn!))

(def! #'remove-if #'delete-if)


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


;;5.4 Composing Functions
(defun compose (&rest fns)
  (if fns
      (let ((fn1 (car (last fns)))
            (fns (butlast fns)))
        #'(lambda (&rest args)
            (reduce #'funcall fns
                    :from-end t
                    :initial-value (apply fn1 args))))
      #'identity))

(defun complement2 (pred)
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

;; (find-if #'(lambda (x)
;;              (and (signed x) (sealed x) (delivered x)))
;;          docs)

;; (find-if (fint #'signed #'sealed #'delivered) docs)

(defun fun (fn &rest fns)
  (if (null fns)
      fn
      (let ((chain (apply #'fun fns)))
        #'(lambda (x)
            (or (funcall fn x) (funcall chain x))))))

;;5.5 Recursion on Cdrs
