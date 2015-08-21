3
;; Lesson 3

;;let
(let ((a 3)
      (b 4)
      (* (+ a b) c)))

(let ((p 52.8)
      (q 35.9)
      (r (f 12.07))))

(setq a 89)

(let ((a 3))
  (+ a 2))

(setq w 77)

(let ((w 8)
      (x w))
  (+ w x))


;;let*
(setq u 37)

(let* ((v 4)
       (u v))
  (+ u v))


;;cond
(let ((a 1)
      (b 2)
      (c 1)
      (d 1))
  (cond ((eql a b) 1)
	((eql a c) "First form" 2)
	((eql a d) 3)))

(let ((a 32))
  (cond ((eql a 13) "An unlucky number")
	((eql a 99) "A lucky number")
	(t "Nothing special about this number")))


;;quote
(setq a 97)


;;Lesson 4

;;cons

;;list
(let ((a :this)
      (b :and)
      (c :that))
  (list a 1 b c 2))


;;first and rest


;;lesson 5

;;a symbol can name a value

;;lesson 7

;;defun
(defun secret-number (the-number)
  (let ((the-secret 37))
    (cond ((= the-number the-secret) 'that-is-the-secret-number)
	  ((< the-number the-secret) 'too-low)
	  ((> the-number the-secret) 'too-high))))

(defun my-calculation (a b c x)
  (+ (* a (* x x)) (* b x) c))

;;lambda

(lambda (a b c x)
  (+ (* a (* x x)) (* b x) c))

((lambda (a b c x)
   (+ (* a (* x x)) (* b x) c))
 3 2 7 5)

;;lesson 8
;;defmacro
(defmacro setq-literal (place literal)
  `(setq ,place ',literal))


(defmacro  reverse-cons (rest first)
  `(cons ,first ,rest))


;;lesson 9

(values)

(values :this)

(values :this :that)


(multiple-value-bind (a b c) (values 2 3 5)
  (+ a b c))

(multiple-value-bind (a b c) (values 2 3 5 'x 'y)
  (+ a b c))

(multiple-value-bind (a b c) (values 2 3)
  (+ a b c))

(multiple-value-bind  (w x y z) (values :left :righ)
  (list w x y z))

(let ((a 1)
      (b 2))
  (values a b))

(cond (nil 97)
      (t (values 9 4)))

(defun foo (p q)
  (values (list :p p) (list :q q)))

((lambda (r s)
   (values r s)) 7 8)


;;lesson 10

(/ 1 3)

(+ (/ 7 11) (/ 13 31))

(defun factorial (n)
  (cond ((= n 0) 1)
       (t (* n (factorial (- n 1))))))

(factorial 100)
(factorial 1000000)

(float (/ 1 3))
;; TODO: it is :0.33333334
;; but why result on book is : 0.333333333333
;; how to control it?

(* (float (/ 1 10)) (float (/ 1 10)))
;; actual result: 0.010000001
;; TODO: why book's result is : 0.010000000000000002


(+ (float (/ 1 100) (* (float (/ 1 10)) (float (/ 1 10)))))
;; actual result: 0.01
;; TODO: book expected result is : 0.020000000000000004

(+ (float (/ 1 100)) (float (/ 1 100)))

(+ 1/100 1/100)

(* 3 7 10.0)

(- 1.0 1)
;; actual result: 0.0

(+ 1/3 2/3 0.0)
;; actual result:: 1.0

(+ 1/3 2/3)
;; actual result: 1

;;array
(setq a1 (make-array '(3 4)))
;; #2A(
;;     (0 0 0 0)
;;     (0 0 0 0)
;;     (0 0 0 0))

(setf (aref a1 0 0) (list 'element 0 0))

(setf (aref a1 1 0) (list 'element 1 0))

(setf (aref a1 2 0) (list 'element 2 0))

;; #2A(((ELEMENT 0 0) 0 0 0)
;;     ((ELEMENT 1 0) 0 0 0)
;;     ((ELEMENT 2 0) 0 0 0))

(aref a1 0 0)

(setf (aref a1 0 0) pi)

(setf (aref a1 1 0) "hello")


;;cector
(setq v1 (make-array '(3)))

(make-array 3)

(setf (aref v1 0) :zero)

(setf (aref v1 1) :one)

(vector 34 22 30)

(setf v2 (vector 1 2 3 4 5))

(setf (elt v2 0) :zero)


;;string
(setq s1 "hello, there.")

(setf (elt s1 0) #\H)

(setf (elt s1 12) #\!)

(string 'a-symbol)

(string #\G)


;;symbol
(setf (get 'object-1 'color) 'red)

(setf (get 'object-1 'size) 'large)

(setf (get 'object-1 'shape) 'round)

(setf (get 'object-1 'position) '(on table))

(setf (get 'object-1 'weight) 13)

(symbol-plist 'object-1)

(get 'object-1 'color)


;;structure

(defstruct struct-1 color size shape position weight)

(setq object-2 (make-struct-1
		 :size 'small
		 :color 'green
		 :weight 10
		 :shape 'square))

(struct-1-color object-2)

(struct-1-size object-2)

(struct-1-weight object-2)

(struct-1-shape object-2)

(struct-1-position object-2)

(setf (struct-1-position object-2) '(under table))


;; type information

(type-of 123)

(type-of 3333333333333333333399999999999999999999999999999)

(type-of "hello world")

(type-of 'fubar)

(type-of '(a b c))


;;hashtable

(setq ht1 (make-hash-table ))

(gethash 'quux ht1)

(setf (gethash 'quux ht1) 'quux-value)

(setf (gethash 'gronk ht1) nil)

(gethash 'gronk ht1)

;;lesson 11


;; open and close
(setq out-stream (open "my-temp-file" :direction :output))

(print 'abc out-stream)

(close out-stream)

(setq in-stream (open "my-temp-file" :direction :input))

(read in-stream)

(close in-stream)

;;lesson 12
(defun open-bracket-macro-character (stream char)
  `',(read-delimited-list #\] stream t))

(set-macro-character #\[ #'open-bracket-macro-character)

(set-macro-character #\] (get-macro-character #\)))

[1 2 3 4 5 6]
