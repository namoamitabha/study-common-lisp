(defpackage on-lisp.ch05
  (:use :common-lisp :on-lisp.util)
  (:export
   :join
   :joiner
   :complement1
   :!
   :memoize
   :compose
   :fif
   :fint
   :fun
   :lrec
   :our-copy-tree
   :count-leaves
   :flatten
   :rfind-if
   :ttrav
   :trec))

(in-package on-lisp.ch05)

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
(defun lrec (rec &optional base)
  (labels ((self (lst)
             (if (null lst)
                 (if (functionp base)
                     (funcall base)
                     base)
                 (funcall rec (car lst)
                          #'(lambda () (self (cdr lst)))))))
    #'self))

;;5.6 Recursion on Subtrees
(setq x '(a b)
            listx (list x 1))
(eq x (car (copy-list listx)))
(eq x (car (copy-tree listx)))

(defun our-copy-tree (tree)
  (if (atom tree)
      tree
      (cons (our-copy-tree (car tree))
            (if (cdr tree) (our-copy-tree (cdr tree))))))

(defun count-leaves (tree)
  (if (atom tree)
      1
      (+ (count-leaves (car tree))
         (or (if (cdr tree) (count-leaves (cdr tree)))
             1))))

(defun flatten (tree)
  (if (atom tree)
      (mklist tree)
      (nconc (flatten (car tree))
             (if (cdr tree) (flatten (cdr tree))))))

(defun rfind-if (fn tree)
  (if (atom tree)
      (and (funcall fn tree) tree)
      (or (rfind-if fn (car tree))
          (if (cdr tree) (rfind-if fn (cdr tree))))))

(defun ttrav (rec &optional (base #'identity))
  (labels ((self (tree)
             (if (atom tree)
                 (if (functionp base)
                     (funcall base)
                     base)
                 (funcall rec
                          (self (car tree))
                          (if (cdr tree)
                              (self (cdr tree)))))))
    #'self))

(defun trec (rec &optional (base #'identity))
  (labels ((self (tree)
             (if (atom tree)
                 (if (functionp base)
                     (funcall base)
                     base)
                 (funcall rec tree
                          #'(lambda () (self (car tree)))
                          #'(lambda () (if (cdr tree)
                                           (self (cdr tree))))))))
    #'self))
