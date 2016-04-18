(defpackage on-lisp.ch07
  (:use :common-lisp)
  (:export
   :nil!0
   :nil!
   :nil!1
   :nif
   :nif1
   :our-when
   :greet
   :memq
   :while
   :our-dolist))

(in-package :on-lisp.ch07)

;;7.2 backquote
(defun nil!0 (var)
  (setq var nil))

(defmacro nil! (var)
  (list 'setq var nil))

(defmacro nil!1 (var)
  `(setq ,var nil))

(defmacro nif (expr pos zero neg)
  `(case (truncate (signum ,expr))
     (1 ,pos)
     (0 ,zero)
     (-1 ,neg)))

(defmacro nif1 (expr pos zero neg)
  (list 'case
        (list 'truncate (list 'signum expr))
        (list 1 pos)
        (list 0 zero)
        (list -1 neg)))

;; >> (setq b '(1 2 3))
;; (1 2 3)
;; >> `(a ,b c)
;; (A (1 2 3) C)
;; >> `(a ,@b c)
;; (A 1 2 3 C)

(defmacro our-when (test &body body)
  `(if ,test
       (progn
         ,@body)))

(defun greet (name)
  `(hello ,name))

;;7.3 defining simple macros
(defmacro memq (obj lst)
  `(member ,obj ,lst :test #'eq))

(defmacro while (test &body body)
  `(do ()
       ((not ,test))
     ,@body))

;;7.4 Testing Macroexpansion
(pprint (macroexpand '(while (able) (laugh))))
;; (BLOCK NIL
;;   (LET ()
;;     (TAGBODY
;;       (GO #:G1052)
;;      #:G1051
;;       (TAGBODY (LAUGH))
;;       (PSETQ)
;;      #:G1052
;;       (UNLESS (NOT (ABLE)) (GO #:G1051))
;;       (RETURN-FROM NIL (PROGN)))))
(pprint (macroexpand-1 '(while (able) (laugh))))
;;(DO () ((NOT (ABLE))) (LAUGH))

(pprint (macroexpand-1 '(or x y)))
;; (LET ((#:G1048 X))
;;   (IF #:G1048
;;       #:G1048
;;       (OR Y)))

(defmacro mac (expr)
  `(pprint (macroexpand-1 ',expr)))

(mac '(or x y))

(setq exp (macroexpand-1 '(memq 'a '(a b c))))
(eval exp)

;; >> (setq exp (macroexpand-1 '(memq 'a '(a b c))))
;; (MEMBER 'A '(A B C) :TEST #'EQ)
;; >> (eval exp)
;; (A B C)

;;7.5 Destructuring in Parameter Lists
(equal (destructuring-bind (x (y) . z) '(a (b) c d)
         (list x y z))
       '(a b (c d)))

(defmacro our-dolist ((var list &optional result) &body body)
  `(progn
     (mapc #'(lambda (,var) ,@body)
           ,list)
     (let ((,var nil))
       ,result)))

(defmacro when-bind ((var expr) &body body)
  `(let ((,var ,expr))
     (when ,var
       ,@body)))

;;7.6 A Model of Macros
(defmacro our-expander (name)
  `(get ,name 'expander))

(defun our-macroexpand-1 (expr)
  (if (and (consp expr) (our-expander (car expr)))
      (funcall (our-expander (car expr)) expr)
      expr))

(defmacro our-defmacro (name parms &body body)
  (let ((g (gensym)))
    `(progn
       (setf (our-expander ',name)
             #'(lambda (,g)
                 (block ,name
                   (destructuring-bind ,parms (cdr ,g)
                     ,@body))))
       ',name)))