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

(define-test test-Constructing-New-Pathnames
    (:tag :unittest)
  (assert-true (make-pathname :directory '(:absolute "foo" "bar")
                              :name "baz"
                              :type ".txt"))
  (assert-equal #P"/foo/bar/baz.txt"
                (make-pathname ;;:device "c"
                               :directory '(:absolute "foo" "bar")
                               :name "baz"
                               :type "txt"))
  (assert-equal #P"backups/baz.txt"
                (make-pathname :directory '(:relative "backups")
                               :defaults #p"/foo/bar/baz.txt"))
  (assert-equal #P"/www/html/foo/bar.html"
                (merge-pathnames #p"foo/bar.html" #p"/www/html/"))
  (assert-equal #P"html/foo/bar.html"
                (merge-pathnames #p"foo/bar.html" #p"html/"))
  (assert-equal "html/foo/bar.html"
                (enough-namestring #p"/www/html/foo/bar.html" #p"/www/"))
  (assert-equal #P"www-backups/html/foo/bar.html"
                (merge-pathnames
                 (enough-namestring #p"/www/html/foo/bar.html" #p"/www/")
                 #p"www-backups/"))
  (assert-equal #P"foo.txt"
                (make-pathname :name "foo" :type "txt")))
