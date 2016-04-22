(require 'qt)

(defpackage :qt-kepler
 (:use :cl :qt)
 (:export :kepler-main))

(in-package :qt-kepler)
(named-readtables:in-readtable :qt)

(defclass orbit-view ()
  ((excentricity :initform 0.0d0 :accessor excentr)
   (excenttric-anomaly :initform 0.0d0 :accessor anomaly))
  (:metaclass qt-class)
  (:qt-superclass "QWidget")
  (:slots
   ("setExcAnomaly(double)" (lambda (instance newval)
                              (setf (anomaly instance) newval)
                              (#_update instance)))
   ("setExcentricity(double)" (lambda (instance newval)
                                (setf (excentr instance) newval)
                                (#_update instance))))
  (:override ("paintEvent" paint-event)))


(defmethod initialize-instance :after ((instance orbit-view) &key)
  (new instance)
  (#_setWindowTitle instance "Kepler's Orbit View"))

(defmethod paint-event((instance orbit-view) paint-event)
  (let* ((wd (#_width instance))
         (ht (#_height instance))
         (e (excentr instance))
         (EE (anomaly instance))
         (b (sqrt (- 1.0d0 (* e e)))))
    (with-objects ((painter (#_new QPainter instance))
                   (gradient (#_new QRadialGradient 
                                    0d0 0d0 400d0 (* 200d0 e) 0d0))
                   (black (#_new QColor 0 10 20))
                   (blue (#_new QColor 0 0 100))
                   (green (#_new QColor 0 200 0))
                   (yellow (#_new QColor 200 200 0))
                   (white (#_new QColor 200 200 200)))
      (#_setWindow painter (- (ash wd -1)) (- (ash ht -1)) wd ht)
      (#_setColorAt gradient 1.0d0 black)
      (#_setColorAt gradient 0.5d0 blue)
      (#_setColorAt gradient 0.0d0 white)
      (#_setBrush painter (#_new QBrush gradient))
      (#_drawEllipse painter -200 
                     (- (truncate (* 200 b))) 400 (truncate (* 400 b)))
      (#_setBrush painter (#_new QBrush yellow))
      (#_drawEllipse painter (- (truncate (* 200 e)) 20) 20 40 -40)
      (#_setBrush painter (#_new QBrush green))
      (#_drawEllipse painter 
                     (- (truncate (* 200 (cos EE))) 10)
                     (- 10 (truncate (* 200 b (sin EE)))) 20 -20))))

(defclass orbit-form () 
  ((running :initform nil :accessor running)
   (timerId :initform 0 :accessor timerId)
   (anomalySlider :accessor anomaly)
   (excentLineEdit :accessor excentLineEdit)
   (pushButton :accessor pushButton)
   (label3 :accessor label3)
   (label2 :accessor label2))
  (:signals ("eAnomalyChanged(double)")
   ("excentricityChanged(double)")
   ("orbitFormClosed()"))
  (:slots 
   ("on_anomalySlider_changed(int)" on-anomalySlider-changed)
   ("on_excentLineEdit_changed()" on-excentLineEdit-changed)
   ("on_button_clicked()" on-button-clicked))
  (:override ("timerEvent" timer-event)
             ("closeEvent" orbit-form-close))
  (:metaclass qt-class)
  (:qt-superclass "QWidget"))

(defmethod initialize-instance :after ((instance orbit-form) &key)
  (new instance)
  (#_setWindowTitle instance "Orbit Paramaters")
  (with-objects ((file (#_new QFile "orbitform.ui"))
                 (loader (#_new QUiLoader)))
    (if (#_open file 1)
        (let ((win (#_load loader file instance))
              (layout (#_new QVBoxLayout)))
          (#_addWidget layout win)
          (#_setLayout instance layout)
          (#_close file)
          (with-slots (label3 label2 anomalySlider excentLineEdit pushButton)
              instance 
            (setf label3 (find-child win "label_3")
                  label2 (find-child win "label_2")
                  anomalySlider (find-child win "anomalySlider")
                  pushButton (find-child win "pushButton")
                  excentLineEdit (find-child win "excentLineEdit"))
            (connect anomalySlider "valueChanged(int)" 
                     instance "on_anomalySlider_changed(int)")
            (connect excentLineEdit "textChanged(QString)" 
                     instance "on_excentLineEdit_changed()")
            (connect pushButton "pressed()" 
                     instance "on_button_clicked()")))
        (error "Couldn't open .ui file!"))))

(defun find-child (object name)
  (let ((children (#_children object)))
    (or
     (loop for child in children
           when (equal name (#_objectName child))
             return child)
     (loop for child in children
             thereis (find-child child name)))))

;; (defun kepler-main()
;;   (make-qapplication) 
;;   (with-objects ((ov (make-instance 'orbit-view)))
;;     (#_resize ov 460 430)
;;     (#_show ov) 
;;     (#_exec *qapplication*)))

(defun on-anomalySlider-changed(instance val)
  (declare (optimize debug))
  (let ((M (* val 1.7453292519943295769d-2)) ;; 2*PI/360
        (e (with-input-from-string 
               (in (substitute #\. #\, 
                               (#_text (excentLineEdit instance)))) 
             (read in))))    
    (multiple-value-bind (EE acc)
        (kepler-solve M e)
      (with-output-to-string (s)
        (format s "Mean anomaly = ~8,6f (~6,4f years)" M (/ val 360.0))
        (#_setText (label3 instance) (get-output-stream-string s)))
      (with-output-to-string (s)
        (format s "Excentric anomaly = ~8,6f (error = ~6,4e)" EE acc)
        (#_setText (label2 instance) (get-output-stream-string s)))
      (emit-signal instance "eAnomalyChanged(double)" EE))))

(defun on-excentLineEdit-changed (instance)
  (emit-signal instance "excentricityChanged(double)" 
               (with-input-from-string 
                   (in (substitute #\. #\, (#_text (excentLineEdit instance))))
                 (read in))))

(defun on-button-clicked (instance)
  (if (running instance)
      (progn ;;(print "Button clicked t")
        (#_setText (pushButton instance) "Start simulation")
        (setf (running instance) nil)
        (#_killTimer instance (timerId instance)))
      (progn ;;(print "Button clicked nil")
        (#_setText (pushButton instance) "Stop simulation")
        (setf (running instance) t)
        (setf (timerId instance) (#_startTimer instance 40)))))

(defmethod timer-event ((instance orbit-form) event)
  (if (eql (#_timerId event) (timerId instance))
      (with-slots (anomalySlider) instance
        (#_setValue anomalySlider (mod (1+ (#_value anomalySlider)) 1440)))))

(defmethod orbit-form-close ((instance orbit-form) event)
  (emit-signal instance "orbitFormClosed()")
  (print "close event occured")
  (#_accept event))

(defun kepler-solve(M e)
  (do* ((eee M E1)
        (E1 (+ M (* e (sin eee))) (+ M (* e (sin eee))))
        (i 0 (1+ i)))
       ((or (> i 1000)
            (< (abs (- E1 eee)) 1d-8))
        (values E1 (abs (- E1 eee))))))

(defun kepler-main()
  (qt:ensure-smoke "qtuitools")
  (make-qapplication)   
  (with-objects ((ov (make-instance 'orbit-view))
                 (of (make-instance 'orbit-form)))
    (#_resize ov 460 430)
    (#_show ov) (#_show of)
    (connect of "eAnomalyChanged(double)"
             ov "setExcAnomaly(double)")
    (connect of "excentricityChanged(double)"
             ov "setExcentricity(double)")
    (connect of "orbitFormClosed()" ov "close()")
    (#_exec *qapplication*)))
