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
(defvar *sin-tables* (make-hash-table))

(defun get-sin-table-and-increment (divisions)
  (let ((table (gethash divisions *sin-tables* :none))
	(increment (/ pi 2 divisions)))
    (when (eq table :none)
      (setq table
	    (setf (gethash divisions *sin-tables*)
		  (make-array (1+ divisions) :initial-element 1.0)))
      (dotimes (i divisions)
	(setf (aref table i)
	      (sin (* increment i)))))
    (values table increment)))

(defmacro lookup-sin (radians divisions)
  (multiple-value-bind (table increment)
      (get-sin-table-and-increment divisions)
    `(aref ,table (round ,radians ,increment))))

(pprint (macroexpand-1 '(lookup-sin (/ pi 4) 50)))

;; * (pprint (macroexpand-1 '(lookup-sin (/ pi 4) 50)))

;; (AREF
;;  #(0.0d0 0.03141075907812829d0 0.06279051952931337d0 0.09410831331851433d0
;;    0.12533323356430426d0 0.15643446504023087d0 0.18738131458572463d0
;;    0.21814324139654256d0 0.2486898871648548d0 0.2789911060392293d0
;;    0.3090169943749474d0 0.3387379202452914d0 0.368124552684678d0
;;    0.3971478906347806d0 0.4257792915650727d0 0.4539904997395468d0
;;    0.4817536741017153d0 0.5090414157503713d0 0.5358267949789967d0
;;    0.5620833778521306d0 0.5877852522924731d0 0.6129070536529765d0
;;    0.6374239897486897d0 0.6613118653236518d0 0.6845471059286887d0
;;    0.7071067811865476d0 0.7289686274214116d0 0.7501110696304596d0
;;    0.7705132427757893d0 0.7901550123756904d0 0.8090169943749475d0
;;    0.8270805742745618d0 0.8443279255020151d0 0.8607420270039436d0
;;    0.8763066800438637d0 0.8910065241883678d0 0.9048270524660196d0
;;    0.9177546256839811d0 0.9297764858882515d0 0.9408807689542256d0
;;    0.9510565162951535d0 0.9602936856769431d0 0.9685831611286311d0
;;    0.9759167619387474d0 0.9822872507286887d0 0.9876883405951378d0
;;    0.9921147013144779d0 0.99556196460308d0 0.9980267284282716d0
;;    0.9995065603657316d0 1.0)
;;  (ROUND (/ PI 4) 0.031415926535897934d0))
;; *

;; * (lookup-sin (/ pi 4) 50)

;; 0.7071067811865476d0

;;********************
(defmacro defsynonym (old-name new-name)
  `(defmacro ,new-name (&rest args)
     `(,',old-name ,@args)))

(defsynonym cons make-pair)
