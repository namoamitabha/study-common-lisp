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


(defun most (fn lst)
  (if (null lst)
      (values nil nil)
      (let* ((wins (car lst))
             (max (funcall fn wins)))
        (dolist (obj (cdr lst))
          (let ((score (funcall fn obj)))
            (when (> score max)
              (setq wins obj
                    max score))))
        (values wins max))))

(assert (equal (most #'length '((a b) (a b c) (a) (a f g)))
               (values '(a b c) 3)))


(defun best (fn lst)
  (if (null lst)
      nil
      (let ((wins (car lst)))
        (dolist (obj (cdr lst))
          (if (funcall fn obj wins)
              (setq wins obj)))
        wins)))

(assert (equal (best #'> '(1 2 3 4 5)) 5))


(defun mostn (fn lst)
  (if (null lst)
      (values nil nil)
      (let ((result (list (car lst)))
            (max (funcall fn (car lst))))
        (dolist (obj (cdr lst))
          (let ((score (funcall fn obj)))
            (cond ((> score max)
                   (setq max score
                         result (list obj)))
                  ((= score max)
                   (push obj result)))))
        (values (nreverse result) max))))

(assert (equal (mostn #'length '((a b) (a b c) (a) (a f g)))
               (values '((a b c) (a f g)) 3)))


;;4.5 Mapping
(equal (mapcan #'(lambda (x y)
                   (if (null x) nil (list x y)))
               '(nil nil nil d e)
               '(1 2 3 4 5 6))
       '(d 4 e 5))

(equal (mapcan #'(lambda (x)
                   (and
                    (numberp x)
                    (list x)))
               '(a 1 b c 3 4 d 5))
       '(1 3 4 5))

(equal (mapcar #'car '((1 a) (2 b) (3 c)))
       '(1 2 3))
(equal (mapcar #'abs '(3 -4 2 -5 -6))
       '(3 4 2 5 6))
(equal (mapcar #'cons '(a b c) '(1 2 3))
       '((A . 1) (B . 2) (C . 3)))

(defun mapa-b (fn a b &optional (step 1))
  (do ((i a (+ i step))
       (result nil))
      ((> i b) (nreverse result))
    (push (funcall fn i) result)))

(assert (equal (mapa-b #'1+ -2 0 .5)
               '(-1 -0.5 0.0 0.5 1.0)))

;;(defun mapa-b (fn a b &optional (step 1))
;;  (map-> fn
;;         a
;;         #'(lambda (x) (> x b))
;;         #'(lambda (x) (+ x step))))

(defun map0-n (fn n)
  (mapa-b fn 0 n))

(assert (equal (map0-n #'1+ 5)
               '(1 2 3 4 5 6)))

(defun map1-n (fn n)
  (mapa-b fn 1 n))

(assert (equal (map1-n #'1+ 6)
               '(2 3 4 5 6 7)))

(defun map-> (fn start test-fn succ-fn)
  (do ((i start (funcall succ-fn i))
       (result nil))
      ((funcall test-fn i) (nreverse result))
    (push (funcall succ-fn i) result)))

(defun mappend (fn &rest lsts)
  (apply #'append (apply #'mapcar fn lsts)))

(defun mapcars (fn &rest lsts)
  (let ((result nil))
    (dolist (lst lsts)
      (dolist (obj lst)
        (push (funcall fn obj) result)))
    (nreverse result)))

(assert (equal (mapcars #'1+ '(1 2 3) '(4 5 6))
               '(2 3 4 5 6 7)))

(some #'= '(1 2 3 4 5)
      '(5 4 3 2 1))

;;?
(defun rmapcar (fn &rest args)
  (if (some #'atom args)
      (apply fn args)
      (apply #'mapcar
             #'(lambda (&rest args)
                 (apply #'rmapcar fn args))
             args)))

(equal (rmapcar #'princ '(1 2 (3 4 (5) 6) 7 (8 9)))
       '(1 2 (3 4 (5) 6) 7 (8 9)))

(equal (rmapcar #'+ '(1 (2 (3) 4)) '(10 (20 (30) 40)))
       '(11 (22 (33) 44)))


;;4.6 I/O
(defun readlist (&rest args)
  (values (read-from-string
           (concatenate 'string "("
                        (apply #'read-line args)
                        ")"))))
;;(readlist)
;;(readlist)
;;Call me "Ed"
;;(CALL ME "Ed")

(defun prompt (&rest args)
  (apply #'format *query-io* args)
  (read *query-io*))

;;(prompt "Enter a number between ~A and ~A.~%" 1 10)
;;(prompt "Enter a number between ~A and ~A.~%" 1 10)
;;Enter a number between 1 and 10.
;;3
;;3

(defun break-loop (fn quit &rest args)
  (format *query-io* "Entering break-loop.~%")
  (loop
    (let ((in (apply #'prompt args)))
      (if (funcall quit in)
          (return)
          (format *query-io* "~A~%" (funcall fn in))))))

;;(break-loop #'eval #'(lambda (x) (eq x :q)) ">> ")


;;4.7 Symbols and Strings
(defun mkstr (&rest args)
  (with-output-to-string (s)
    (dolist (a args)
      (princ a s))))
(assert (equal (mkstr pi " pieces of " 'pi)
               "3.141592653589793d0 pieces of PI"))

(defun symb (&rest args)
  (values (intern (apply #'mkstr args))))

(assert (eq (symb 'ar "Madi" #\L #\L 0)
            '|ARMadiLL0|))

(let ((s (symb '(a b))))
  (and (eq s '|(A B)|) (eq s '\(A\ B\))))

(defun reread (&rest args)
  (values (read-from-string (apply #'mkstr args))))

(defun explode (sym)
  (map 'list #'(lambda (c)
                 (intern (make-string 1
                                      :initial-element c)))
       (symbol-name sym)))

(assert (equal (explode 'bomb)
               '(B O M B)))
