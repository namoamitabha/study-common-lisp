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
