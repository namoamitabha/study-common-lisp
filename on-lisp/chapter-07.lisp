(defpackage on-lisp.ch07
  (:use :common-lisp)
  (:export
   :nil!0
   :nil!
   :nil!1
   :nif
   :nif1
   :our-when
   :greet))

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
