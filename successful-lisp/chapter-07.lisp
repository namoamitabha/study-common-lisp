(defclass empty-object () ())

(make-instance 'empty-object)

(find-class 'empty-object)

(make-instance (find-class 'empty-object))

;;********************
(defclass 3d-point () (x y z))

(defstruct 3d-point-struct x y z)

(let ((a-point (make-instance '3d-point)))
  (setf (slot-value a-point 'x) 2)
  (slot-value a-point 'x))
;;********************
(defclass 3d-point ()
  ((x :accessor point-x)
  (y :accessor point-y)
  (z :accessor point-z)))

(let ((a-point (make-instance '3d-point)))
  (setf (point-x a-point) "x")
  (point-x a-point))

;;********************
(defclass 3d-point ()
  ((x :reader get-x :writer set-x)
   (y :reader get-y :writer set-y)
   (z :reader get-z :writer set-z)))

(let ((a-point (make-instance '3d-point)))
  (set-z "z" a-point)
  (get-z a-point))

;;********************
(defclass sphere ()
  ((x :accessor x)
   (y :accessor y)
   (z :accessor z)
   (radius :accessor radius)
   (volume :reader volume)
   (translate :writer translate)))

(defmethod volume ((object sphere))
  (* 4/3 pi (expt (radius object) 3)))

(defmethod radius ((new-radius number) (object sphere))
  (setf (slot-value object 'radius) new-radius)
  (setf (slot-value object 'volume)
	(* 4/3 pi (expt new-radius 3))))

;;********************
(defclass 2d-object () ())

(defclass 2d-centered-object (2d-object)
  ((x :accessor x)
   (y :accessor y)
   (orientation :accessor orientation)))

(defclass oval (2d-centered-object)
  ((axis-1 :accessor axis-1)
   (axis-2 :accessor axis-2)))

(let ((oval-0 (make-instance 'oval)))
  (setf (axis-1 oval-0) "oval-0-axis-1")
  (print (axis-1 oval-0))
  (setf (x oval-0) "oval-0-x")
  (print (x oval-0)))

(defclass regular-polygon (2d-centered-object)
  ((n-sides :accessor number-of-sides)
   (size :accessor size)))

(let ((regular-0 (make-instance 'regular-polygon)))
  (setf (number-of-sides regular-0) "regular-0-n-sides")
  (print (number-of-sides regular-0))
  (setf (x regular-0) "regular-0-x")
  (print (x regular-0)))

;;********************

;;********************
(defclass 3d-point ()
  ((x :accessor point-x :initform 0)
   (y :accessor point-y :initform 0)
   (z :accessor point-z :initform 0)))
 
(let ((a-point (make-instance '3d-point)))
  (print (point-x a-point)))

(defclass 3d-point ()
  ((x :accessor point-x :initform 0 :initarg :x)
   (y :accessor point-y :initform 0 :initarg :y)
   (z :accessor point-z :initform 0 :initarg :z)))
 
(let ((a-point (make-instance '3d-point :x "x" :y "y" :z "z")))
  (print (point-x a-point)))

(defclass 3d-point ()
  ((x :accessor point-x :initform 0 :initarg :x
      :documentation "x coordinate" :type real)
   (y :accessor point-y :initform 0 :initarg :y
      :documentation "y coordinate" :type real)
   (z :accessor point-z :initform 0 :initarg :z
      :documentation "z coordinate" :type real)))
 
(let ((a-point (make-instance '3d-point :x "x" :y "y" :z "z")))
  (print (point-x a-point)))
