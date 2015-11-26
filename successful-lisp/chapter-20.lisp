`(The sum of 17 and 83 is ,(+ 17 83))

`(The sum of 17 and 83 is (+ 17 83))

(defmacro swap (a b)
  `(let ((temp ,a))
     (setf ,a ,b)
     (setf ,b temp)))

(let ((x 3)
      (y 7))
  (swap x y)
  (list x y))

(pprint (macroexpand-1 '(swap x y)))

;; * (pprint (macroexpand-1 '(swap x y)))

;; (LET ((TEMP X))
;;   (SETF X Y)
;;   (SETF Y TEMP))

(let (( c (cons 2 9)))
  (swap (car c) (cdr c))
  c)

(pprint (macroexpand-1 '(swap (car c) (cdr c))))


;; * (pprint (macroexpand-1 '(swap (car c) (cdr c))))

;; (LET ((TEMP (CAR C)))
;;   (SETF (CAR C) (CDR C))
;;   (SETF (CDR C) TEMP))

(let ((c (cons 2 9)))
  (LET ((TEMP (CAR C)))
    (SETF (CAR C) (CDR C))
    (SETF (CDR C) TEMP))
  c)

(defmacro sortf (place)
  `(setf ,place (sort ,place #'>)))

(let ((l (list 1 2 7 5 3)))
  (pprint l)
  (sortf l)
  l)

(defmacro togglef (place)
  `(setf ,place (not ,place)))

(let ((temp nil))
  (togglef temp)
  temp)

(let ((temp t))
  (togglef temp)
  temp)

(defmacro either (form1 form2)
  `(if (zerop (random 2))
       ,form1
       ,form2))

(either 1 2)
(either 5 2)

;;********************
