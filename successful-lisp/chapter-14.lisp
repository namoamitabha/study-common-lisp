(defmethod op2 ((x number) (y number))
  (format t "method1: x=~a,y=~a~%" x y))

(defmethod op2 ((x float) (y float))
  (format t "method2: x=~a, y=~a~%" x y))

(defmethod op2 ((x integer) (y integer))
  (format t "method3: x=~a, y=~a~%" x y))

(defmethod op2 ((x float) (y number))
  (format t "method4: x=~a, y=~a~%" x y))

(defmethod op2 ((x number) (y float))
  (format t "method5: x=~a, y=~a~%" x y))

(OP2 11 23)

(OP2 13 2.9)

(OP2 8.3 4/5)

(OP2 5/8 11/3)

;; method3: x=11, y=23
;; NIL
;; * method5: x=13, y=2.9
;; NIL
;; * method4: x=8.3, y=4/5
;; NIL
;; * method1: x=5/8,y=11/3
;; NIL

;;********************
(defmethod Xop2 ((x number) (y number))
  (format t "method1: x=~a, y=~a~%" x y))

(defmethod Xop2 ((x float) (y number))
  (format t "method2: x=~a, y=~a~%" x y))

(defmethod Xop2 ((x number) (y float))
  (format t "method3: x=~a, y=~a~%" x y))

(Xop2 5.3 4.1)

;; * (Xop2 5.3 4.1)
;; method2: x=5.3, y=4.1
;; NIL

;;********************
(defmethod idiv ((numerator integer)
		(denominator integer))
	  (values (floor numerator denominator)))

(defmethod idiv ((numerator integer)
		 (denominator (eql 0)))
	  nil)

(idiv 4 3)
(idiv 6 2)
(idiv 4 0)


;; * (idiv 4 3)
;; (idiv 6 2)
;; (idiv 4 0)


;; 1
;; * 
;; 3
;; * 
;; NIL
;; * 

;;********************
(defclass c1 () ())
(defclass c2 () ())
(defclass c3 (c1) ())
(defclass c4 (c2) ())
(defclass c5 (c3 c2) ())
(defclass c6 (c5 c1) ())
(defclass c7 (c4 c3) ())

(class-precedence-list (find-class 'c6))

;;doesn't work:(sb-mop::class-precedence-list (find-class 'c6))
;;(sb-mop::class-precedence-list (find-class 'c6))
;;ref:http://stackoverflow.com/questions/32550584/unbound-slot-when-obtaining-class-precedence-list

;;fix
;; * (sb-mop:finalize-inheritance (find-class 'c6))

;; NIL
;; * (sb-mop:class-finalized-p (find-class 'c6))

;; T
;; * (sb-mop:finalize-inheritance (find-class 'c6))

;; NIL
;; * (sb-mop:class-finalized-p (find-class 'c6))

;; T
;; * (sb-mop:class-precedence-list (find-class 'c6))

;; (#<STANDARD-CLASS C6> #<STANDARD-CLASS C5> #<STANDARD-CLASS C3>
;;  #<STANDARD-CLASS C1> #<STANDARD-CLASS C2> #<STANDARD-CLASS STANDARD-OBJECT>
;;  #<SB-PCL::SLOT-CLASS SB-PCL::SLOT-OBJECT> #<SB-PCL:SYSTEM-CLASS T>)
;; * 

;;********************
(defmethod combo1 ((x number))
		   (print 'primary) 1)

(defmethod combo1 :before ((x integer))
  (print 'before-integer) 2)

(defmethod combo1 :before ((x rational))
  (print 'before-rational) 3)

(defmethod combo1 :after ((x integer))
  (print 'after-integer) 4)

(defmethod combo1 :after ((x rational))
  (print 'after-rational) 5)

(combo1 17)


;; * (combo1 17)

;; BEFORE-INTEGER 
;; BEFORE-RATIONAL 
;; PRIMARY 
;; AFTER-RATIONAL 
;; AFTER-INTEGER 
;; 1


;; * (combo1 4/5)

;; BEFORE-RATIONAL 
;; PRIMARY 
;; AFTER-RATIONAL 
;; 1

;;********************
(defmethod combo2 ((x number))
  (print 'primary) 1)

(defmethod combo2 :before ((x integer))
  (print 'before-integer) 2)

(defmethod combo2 :before ((x rational))
  (print 'before-rational) 3)

(defmethod combo2 :after ((x integer))
  (print 'after-integer) 4)

(defmethod combo2 :after ((x rational))
  (print 'after-rational) 5)

(defmethod combo2 :around ((x float))
  (print 'around-float-before-call-next-method)
  (let ((result (call-next-method (float (truncate x)))))
    (print 'around-float-after-call-next-method)
    result))

(defmethod combo2 :around ((x complex))
  (print 'sorry) nil)

(defmethod combo2 :around ((x number))
  (print 'around-number-before-call-next-method)
  (print (call-next-method))
  (print 'around-number-after-call-next-method)
  99)

;; * (combo2 17)

;; AROUND-NUMBER-BEFORE-CALL-NEXT-METHOD 
;; BEFORE-INTEGER 
;; BEFORE-RATIONAL 
;; PRIMARY 
;; AFTER-RATIONAL 
;; AFTER-INTEGER 
;; 1 
;; AROUND-NUMBER-AFTER-CALL-NEXT-METHOD 
;; 99
;; * 

;; * (combo2 4/5)

;; AROUND-NUMBER-BEFORE-CALL-NEXT-METHOD 
;; BEFORE-RATIONAL 
;; PRIMARY 
;; AFTER-RATIONAL 
;; 1 
;; AROUND-NUMBER-AFTER-CALL-NEXT-METHOD 
;; 99
;; * 


;; * (combo2 82.3)

;; AROUND-FLOAT-BEFORE-CALL-NEXT-METHOD 
;; AROUND-NUMBER-BEFORE-CALL-NEXT-METHOD 
;; PRIMARY 
;; 1 
;; AROUND-NUMBER-AFTER-CALL-NEXT-METHOD 
;; AROUND-FLOAT-AFTER-CALL-NEXT-METHOD 
;; 99
;; * 


;; * (combo2 #c(1.0 -1.0))

;; SORRY 
;; NIL
;; * 

(defmethod combo2 :around ((x float))
  (call-next-method (floor x)))

(combo2 45.9)


;; * (combo2 45.9)

;; AROUND-NUMBER-BEFORE-CALL-NEXT-METHOD 
;; PRIMARY 
;; 1 
;; AROUND-NUMBER-AFTER-CALL-NEXT-METHOD 
;; 99
;; * 
