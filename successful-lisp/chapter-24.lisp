(defparameter *s*
  (make-array 0
	      :element-type 'character
	      :adjustable t
	      :fill-pointer 0))
(format *s* "Hello~%")

(format *s* "Goodbye")

(setf (fill-pointer *s*) 0)

(format *s* "A new beginning")

;;error: error in FORMAT: 7 is not of type CHARACTER.
;;(format nil "~:C" 7)

(format nil "~R" 7)

(format nil "~R" 376)

(format nil "~@R" 1999)

(format nil "~D time~:P, ~D fl~:@P" 1 1)

(format nil "~D time~:P, ~D fl~:@P" 3 4)

(format t "~&Name~20TExtension~{~&~A~20T~A~}"
	'("Joe" 3215 "Mary" 3246 "Fred" 3222 "Dave" 3232 "Joseph" 3212))

(format t "~[Lisp 1.5~;MACLISP~;PSL~;Common Lisp~]" 2)

(format t "My computer ~:[doesn't~;does~] like lisp." t)

(format t "My computer ~:[doesn't~;does~] like lisp." nil)

(format nil "~{~@[~A ~]~}" '(1 2 nil 3 t nil 4 nil))

(format t "~{~&~VD~}" '(5 37 10 253 15 9847 10 559 5 12))
