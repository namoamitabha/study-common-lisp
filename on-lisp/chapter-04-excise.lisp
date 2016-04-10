;;4.3
(proclaim '(inline last1 single append1 conc1 mklist))

(defun last1 (lst)
  "Return last element value of list"
  (car (last lst)))

(assert (= (last1 '(1 2 3 4)) 4))
(assert (eq (last1 nil) nil))


(defun single (lst)
  "Whether list contains only one element"
  (if (null lst)
      nil
      (and (car lst) (null (cdr lst)))))

(assert (eq (single '(1 2 3 4)) nil))
(assert (eq (single nil) nil))
(assert (single '(1)))


(defun append1 (lst obj)
  "Attach a new element to the end of a list"
  (if (consp obj)
      (append lst obj)
      (append lst (list obj))))

(assert (equal (append1 '(1 2 3 4) 4) '(1 2 3 4 4)))
(assert (equal (append1 nil 4) '(4)))
(assert (equal (append1 '(1 2 3 4) '(4)) '(1 2 3 4 4)))


(defun conc1 (lst obj)
  "Attach a new element to the end of a list destructively"
  (if (listp obj)
      (nconc lst obj)
      (nconc lst (list obj))))

(assert (equal (conc1 '(1 2 3) 4) '(1 2 3 4)))
(assert (equal (conc1 nil '(1)) '(1)))
(assert (equal (conc1 '(1 2 3) '(4)) '(1 2 3 4)))


(defun mklist (obj)
  "Ensure obj is list"
  (if (consp obj)
      obj
      (list obj)))

(assert (listp (mklist 'a)))
(assert (listp (mklist '(a b))))
(assert (listp (mklist nil)))


;;longer filter group flatten prune
(defun longer (x y)
  "Compares two sequence and returns true if x is longer"
  (labels ((rev (x y)
	          (and (consp x)
		       (or (null y)
			     (rev (cdr x) (cdr y))))))
    (if (and (listp x) (listp y))
	(rev x y)
	(> (length x) (length y)))))

(assert (not (longer '(1 2) '(4 5 6))))
(assert (longer '(4 5 6) '(1 2)))
(assert (not (longer '(1 2) '(3 4))))

;;filter failed on test
(defun filter (fn lst)
  "Returns what some would have returned for successive cdrs of the list"
  (labels ((rev (lst acc)
	     (cond ((null lst) acc)
		   ((atom lst)
		    (let ((val (funcall fn lst)))
		      (format t "~A" val)
		      (if val (push val acc))))
		   (t
		    (rev (cdr lst) (rev (car lst) acc)))
		   )))
    (rev lst nil)))

(assert (equal (filter #'(lambda (x) (if (numberp x) (1+ x)))
	       '(a 1 2 b 3 c d 4))
	       '(2 3 4 5)))

(defun group (source n)
  "Group list source to sublist with length as n, left put to last sublist"
  (if (zerop n) (error "zero length"))
  (labels ((rev (source acc)
	          (let ((rest (nthcdr n source)))
		    (if (consp rest)
			(rev rest (cons (subseq source 0 n) acc))
			(nreverse (cons source acc))))))
    (if source (rev source nil) nil)))

(assert (equal (group '(a b c d e f g) 2) '((a b) (c d) (e f) (g))))
(assert (eq (group nil 2) nil))
;;(group '(a b) 0)
