#! /usr/bin/sbcl --script
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
				       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))


(load "lisp-unit")
(use-package :lisp-unit)

(setq *print-summary* t)
(setq *print-failures* t)
(setq *print-errors* t)

(load "checks")
(load "checks-tests")

(run-tests)

;(print-failures *)

;(print-errors *)
