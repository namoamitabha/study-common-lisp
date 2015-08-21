(defpackage client
  (:use common-lisp)
  (:import-from util1 func1)
  (:import-from util2 func2))

(in-package client)

(defun init () 'client-init)

(util1:init)
(util2:init)

(init)
(func1)
(func2)
