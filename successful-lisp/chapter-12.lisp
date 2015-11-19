(mapcar #'atom (list 1 '(2) "foo" nil))

(mapcar #'+ (list 1 2 3) (list 4 5 6))

(mapc #'(lambda (x y) (print (* x y)))
      (list 1 0 2) (list 3 4 5))

(mapcan #'list (list 1 2 3) (list 4 5 6))

(mapcan #'(lambda (a b) (list (cons a b)))
	(list 1 2 3) (list 4 5 6))
;;********************
(maplist #'list (list 1 2 3) (list 4 5 6))

(mapl #'(lambda (x y) (print (append x y)))
      (list 1 2 3) (list 4 5 6))

(mapcon #'list (list 1 2 3) (list 4 5 6))

;;********************
(map nil #'+ (list 1 2 3) (list 4 5 6))

(map 'list #'+ (list 1 2 3) (list 4 5 6))

(map 'vector #'+ (list 1 2 3) (list 4 5 6))

(map '(vector number 3) #'+ (list 1 2 3) (list 4 5 6))

(let ((a (make-sequence 'list 3)))
  (print a)
  (map-into a #'+ (list 1 2 3) (list 4 5 6))
  a)

(let ((a (make-sequence 'vector 3)))
  (print a)
  (map-into a #'+ (list 1 2 3) (list 4 5 6))
  a)

(let ((a (make-sequence 'list 3 :initial-element 9)))
  (print a)
  (map-into a #'+ (list 1 2 3) (list 4 5 6))
  a)

;;********************
(append '(1) nil '(3) '(4))

(defun filter-even-numbers (numbers)
  (mapcan #'(lambda (n) (when (evenp n) (list n)))
	  numbers))

(filter-even-numbers (list 1 2 3 4 5 6 7 8))

(defun filter-evenly-divisible (numerators denominators)
  (mapcan #'(lambda (n d)
	      (if (zerop (mod n d))
		  (list (list n d))
		  nil))
	  numerators denominators))

(filter-evenly-divisible (list 7 8 9 10 11 12)
			 (list 1 4 5 5 2 3))

(some #'(lambda (n) (or (< n 0) (> n 100))) (list 0 1 99 100))

(some #'(lambda (n) (or (< n 0) (> n 100))) (list -1 0 1 99 100))

(every #'(lambda (w) (>= (length w) 5)) (list "bears" "bulls" "racoon"))

(every #'(lambda (w) (>= (length w) 5)) (list "bears" "cat" "racoon"))

(some #'> (list 0 1 2 3 4 5) (list 0 0 3 2 6))

(reduce #'* (list 1 2 3 4 5))

(reduce #'- (list 10 2 3 1))
