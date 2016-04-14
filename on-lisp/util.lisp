(defpackage on-lisp.util
  (:use :common-lisp)
  (:export
   :mklist))

(in-package :on-lisp.util)

(defun mklist (obj)
  (if (listp obj) obj (list obj)))
