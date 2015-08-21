(defpackage util1
  (:export init func1 func2)
  (:use common-lisp))
(in-package util1)

(defun init () 'util1-init)

(defun func1 () 'util1-func1)

(defun func2 () 'util1-func2)

