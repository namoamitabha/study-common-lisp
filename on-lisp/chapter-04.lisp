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

;;4.3 Operations on Lists
(proclaim '(inline last1 single append1 conc1 mklist))

(defun last1 (lst)
  (car (last lst)))

(defun single (lst)
  (and (consp lst) (not (cdr lst))))

(defun append1 (lst obj)
  (append lst (list obj)))

(defun conc1 (lst obj)
  (nconc lst (list obj)))

(defun mklist (obj)
  (if (listp obj) obj (list obj)))

(defun longer (x y)
  (labels ((compare (x y)
             (and (consp x)
                  (or (null y)
                      (compare (cdr x) (cdr y))))))
    (if (and (listp x) (listp y))
        (compare x y)
        (> (length x) (length y)))))

(defun filter (fn lst)
  (let ((acc nil))
    (dolist (x lst)
      (let ((val (funcall fn x)))
        (if val (push val acc))))
    (nreverse acc)))
(filter #'(lambda (x) (if (numberp x) (1+ x)))
	  '(a 1 2 b 3 c d 4))

(defun group (source n)
  (if (zerop n) (error "zero length"))
  (labels ((rec (source acc)
             (let ((rest (nthcdr n source)))
               (if (consp rest)
                   (rec rest (cons (subseq source 0 n) acc))
                   (nreverse (cons source acc))))))
    (rec source nil)))
(group '(a b c d e f g) 2)

(defun flatten (x)
  (labels ((rec (x acc)
             (cond ((null x) acc)
                   ((atom x) (cons x acc))
                   (t (rec (car x) (rec (cdr x) acc))))))
    (rec x nil)))

(flatten '(a (b c) ((d e) f)))

(defun prune (test tree)
  (labels ((rec (tree acc)
             (cond ((null tree) (nreverse acc))
                   ((consp (car tree))
                    (rec (cdr tree)
                         (cons (rec (car tree) nil) acc)))
                   (t (rec (cdr tree)
                           (if (funcall test (car tree))
                               acc
                               (cons (car tree) acc)))))))
    (rec tree nil)))

(prune #'evenp '(1 2 (3 (4 5) 6) 7 8 (9)))


;;4.4 Search

(defun before (x y lst &key (test #'eql))
  (and lst
       (let ((first (car lst)))
         (cond ((funcall test y first) nil)
               ((funcall test x first) lst)
               (t (before x y (cdr lst) :test test))))))

(assert (equal (before 'b 'd '(a b c d)) '(b c d)))
(assert (equal (before 'a 'b '(a)) '(a)))

(defun after (x y lst &key (test #'eql))
  (let ((rest (before y x lst :test test)))
    (and rest (member x rest :test test))))

(assert (equal (after 'a 'b '(b a d)) '(a d)))
(assert (not (after 'a 'b '(a))))

(defun duplicate (obj lst &key (test 'eql))
  (member obj (cdr (member obj lst :test test))
          :test test))

(assert (equal (duplicate 'a '(a b c a d)) '(a d)))

(defun split-if (fn lst)
  (let ((acc nil))
    (do ((src lst (cdr src)))
        ((or (null src) (funcall fn (car src)))
         (values (nreverse acc) src))
      (push (car src) acc))))

(assert (equal (split-if #'(lambda (x) (> x 4))
                         '(1 2 3 4 5 6 7 8 9 10))
               (values '(1 2 3 4) '(5 6 7 8 9 10))))
