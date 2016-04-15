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

(load "util.lisp")

(load "chapter-05.lisp")
(load "chapter-05.tests.lisp")

(lisp-unit:run-tests :all :on-lisp.ch05.tests)

(load "chapter-07.lisp")
(load "chapter-07.tests.lisp")

(lisp-unit:run-tests :all :on-lisp.ch07.tests)
