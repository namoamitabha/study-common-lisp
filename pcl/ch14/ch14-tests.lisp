             (defpackage pcl-ch14-tests
  (:use :common-lisp :pcl-ch14 :lisp-unit))

(in-package :pcl-ch14-tests)

(define-test test-sample
    (:tag :unittest)
  (assert-true t)
  (assert-true (my-true)))

(define-test test-How-Pathnames-Represent-Filenames
    (:tag :unittest)
  (let ((pathname "/foo/bar/baz.txt"))
    (assert-equal '(:ABSOLUTE "foo" "bar")
                  (pathname-directory pathname))
    (assert-equal "baz"
                  (pathname-name pathname))
    (assert-equal "txt"
                  (pathname-type pathname)))
  (assert-equal #P"/foo/bar/baz.txt"
                (pathname "/foo/bar/baz.txt"))
  (assert-equal "/foo/bar/baz.txt"
                (namestring #P"/foo/bar/baz.txt"))
  (assert-equal "/foo/bar/"
                (directory-namestring #P"/foo/bar/baz.txt"))
  (assert-equal "baz.txt"
                (file-namestring #P"/foo/bar/baz.txt")))
