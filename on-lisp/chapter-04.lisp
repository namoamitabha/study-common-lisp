;;4.1 Birth of a Utility
(defun all-nicknames (names)
  (if (null names)
      nil
      (nconc (nicknames (car names))
	          (all-nicknames (cdr names)))))
(mapcan #'nicknames people)

(defun bookshops (town)
  nil)

(let ((town (find-if #'bookshops towns)))
  (values town (bookshops town)))

(defun find-books (town)
  (if (null towns)
      nil
      (let ((shops (bookshops (car towns))))
	(if shops
	    (values (car towns) shops)
	    (find-books (cdr towns))))))

(defun f2 (fn lst)
  (if (null lst)
      nil
      (let ((val (funcall fn (car lst))))
	(if val
	    (values (car lst) val)
	    (find2 fn (cdr lst))))))
(find2 #'bookshops towns)

;;4.3
