#! /usr/bin/sbcl --script

(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
				       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(load "../../lisp-unit.lisp")

(use-package :lisp-unit)

(setq *print-summary* t)
(setq *print-failures* t)
(setq *print-errors* t)

(load "ch12.lisp")
(load "ch12-tests.lisp")

(lisp-unit:run-tests :all :pcl-ch12-tests)
