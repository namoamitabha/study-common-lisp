(defstruct foo-struct a b c)

(let ((foo-1 (make-foo-struct :a 1 :b "two")))
  (print (foo-struct-a foo-1))
  (print (foo-struct-b foo-1))
  (values))


(defstruct (ship
	     (:print-function
	      (lambda (struct stream depth)
		(declare (ignore depth))
		(format stream "[ship ~A of ~A at (~D, ~D) moving (~D, ~D)]"
			(ship-name struct)
			(ship-player struct)
			(ship-x-pos struct)
			(ship-y-pos struct)
			(ship-x-vel struct)
			(ship-y-vel struct)))))
  (name "unnamed")
  player
  (x-pos 0.0)
  (y-pos 0.0)
  (x-vel 0.0)
  (y-vel 0.0))


(defstruct (ship
	     (:print-function
	      (lambda (struct stream depth)
		(declare (ignore depth))
		(print-unreadable-object (struct stream)
		  (format stream "[ship ~A of ~A at (~D, ~D) moving (~D, ~D)]"
			  (ship-name struct)
			  (ship-player struct)
			  (ship-x-pos struct)
			  (ship-y-pos struct)
			  (ship-x-vel struct)
			  (ship-y-vel struct))))))
  (name "unnamed")
  player
  (x-pos 0.0)
  (y-pos 0.0)
  (x-vel 0.0)
  (y-vel 0.0))

(make-ship :name "Excalibur"
	   :player "Dave"
	   :x-pos 100.0
	   :y-pos 221.0)

(make-ship :name "Proud Mary" :player 'CCR)

;;
(defstruct (bar (:type vector))
  a b c)

(make-bar)

(defstruct (bar
	     (:type vector)
	     :named)
  a b c)

(make-bar)

(defstruct (bar-list
	     (:type list)
	     :named)
  a b c)

(make-bar-list)

;;

(defstruct (galaxy-class-cruiser-ship
	     (:conc-name gcc-ship-))
  (name "unnamed")
  player
  (x-pos 0.0)
  (y-pos 0.0)
  (x-vel 0.0)
  (y-vel 0.0))

(let ((ship (make-galaxy-class-cruiser-ship)))
  (print (gcc-ship-x-pos ship))
  (print (gcc-ship-name ship))
  (values))

;;;;;
(defstruct (3d-point
	     (:constructor create-3d-point (x y z)))
  x y z)

(create-3d-point 1 -2 3)

;;;;;
(defstruct employee
  name department salary social-security-number telephone)

(make-employee)

(defstruct (manager
	     (:include employee))
  bonus direct-reports)

(make-manager)

(setq mgr (make-manager))

(setf (manager-name mgr) "Buzz")

(employee-name mgr)
