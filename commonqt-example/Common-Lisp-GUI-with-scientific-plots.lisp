(require 'qt)
;;(ql:quickload :qt)

(defpackage :qt-approx
  (:use :cl :qt)
  (:export :approx-main))

(in-package :qt-approx)

(named-readtables:in-readtable :qt)

(defun find-child (object name)
  (let ((children (#_children object)))
    (or
     (loop for child in children
           when (equal name (#_objectName child))
             return child)
     (loop for child in children
             thereis (find-child child name)))))

(defclass approx-mainform ()
  ((buttonGroup :accessor buttonGroup)
   (spinBox :accessor spinBox)
   (tableWidget :accessor tableWidget)
   (gpstream :accessor gpstream)
   (gpprocess :accessor gpprocess))
  (:metaclass qt-class)
  (:qt-superclass "QWidget")
  (:slots ("recalc()" recalc))
  (:override ("closeEvent" close-event)))

(defmethod initialize-instance :after 
    ((instance approx-mainform) &key)
  (new instance)
  (#_setWindowTitle instance "Approximation of functions")
  (with-objects ((file (#_new QFile "mainform.ui"))
                 (loader (#_new QUiLoader)))
    (if (#_open file 1) 
        (let ((win (#_load loader file instance))
              (layout (#_new QVBoxLayout))
              (x11win (#_new QX11EmbedContainer)))   
          (#_addWidget layout win)
          (#_setLayout instance layout)
          (#_setMinimumSize x11win 400 300)
          (#_addWidget (find-child instance "splitter") 
                       x11win)
          (format t "~X" (#_winId x11win))
          (setf (gpprocess instance)
                (sb-ext:run-program "/usr/bin/gnuplot" 
                                    nil 
                                    :wait nil 
                                    :input :stream
                                    :output nil 
                                    :search t))
          (setf (gpstream instance)
                (sb-ext:process-input (gpprocess instance)))
          (format (gpstream instance)
                  "set terminal x11 window \"~X\"~% plot sin(x)~%"
                  (#_winId x11win))
          (force-output (gpstream instance))
          (setf (spinBox instance) (find-child win "spinBox"))
          (setf (tableWidget instance) (find-child win "tableWidget"))
          (with-slots (buttonGroup) instance
            (setf buttonGroup  (#_new QButtonGroup instance))		
            (#_addButton buttonGroup 
                         (find-child instance "radioButton") 0)
            (#_addButton buttonGroup 
                         (find-child instance "radioButton_2") 1)
            (#_addButton buttonGroup 
                         (find-child instance "radioButton_3") 2)
            (#_addButton buttonGroup 
                         (find-child instance "radioButton_4") 3)
            (connect buttonGroup "buttonClicked(int)"
                     instance "recalc()")
            (connect (find-child instance "spinBox") "valueChanged(int)"
                     instance "recalc()"))
          (recalc instance)
          (#_close file))
        (error "Couldn't open .ui file!"))))

(defun recalc(instance)
  (declare (optimize (debug 3)))
  (let* ((n (#_value (spinBox instance)))
         (k (#_checkedId (buttonGroup instance)))
         (x (make-array (1+ n) :element-type 'double-float))
         (f (make-array (1+ n) :element-type 'double-float))
         (fa (make-array (1+ n) :element-type 'double-float))
         (x1 (make-array 1025 :element-type 'double-float))
         (f1 (make-array 1025 :element-type 'double-float))
         (fa1 (make-array 1025 :element-type 'double-float))
         (er1 (make-array 1025 :element-type 'double-float))
         item)
    (dotimes (i (1+ n))
      (setf (aref x i) (/ (* 2.0d0 i) n)
            (aref f i) (case k
                         (0 (abs (1- (aref x i))))
                         (1 (+ 1 (expt (1- (aref x i)) 5)))
                         (2 (sin (* 10.0d0 (aref x i))))
                         (3 (expt 1.5d0 (aref x i))))))
    (replace fa f)
    ;; calculate the divided differences
    (do* ((j 1 (1+ j))
          (tmp1 (aref fa 0))
          (tmp2 (aref fa 1)))
         ((> j n))
      (setf tmp1 (aref fa (1- j))
            tmp2 (aref fa j))
      (do ((i j (1+ i)))
          ((> i n))
        (setf (aref fa i) (/ (- tmp2 tmp1) (- (aref x i) (aref x (- i j)))))
        (setf tmp1 tmp2)
        (if (< i n) (setf tmp2 (aref fa (1+ i))))))
    (#_setRowCount (tableWidget instance) (1+ n))
    (dotimes (i (1+ n))
      (setf item (#_new QTableWidgetItem (write-to-string (aref x i))))
      (#_setItem (tableWidget instance) i 0 item)
      (setf item (#_new QTableWidgetItem (write-to-string (aref f i))))
      (#_setItem (tableWidget instance) i 1 item)
      (setf item (#_new QTableWidgetItem (write-to-string (aref fa i))))
      (#_setItem (tableWidget instance) i 2 item))
    ;; doing the interpolation part
    (dotimes (i 1025)
      (setf (aref x1 i) (/ (* 2.2d0 i) 1024)
            (aref f1 i)
            (case k
              (0 (abs (1- (aref x1 i))))
              (1 (+ 1 (expt (1- (aref x1 i)) 5)))
              (2 (sin (* 10.0d0 (aref x1 i))))
              (3 (expt 1.5d0 (aref x1 i))))))
    (dotimes (i 1025)
      ;;approximation for f( x1[i] )
      (let ((dx (- (aref x1 i) (aref x 0))))
        (setf (aref fa1 i) (aref fa 0))
        (do ((j 1 (1+ j)))
            ((> j n) (setf (aref er1 i)
                           (abs (- (aref f1 i) (aref fa1 i)))))
          (incf (aref fa1 i) (* dx (aref fa j)))
          (setf dx (* dx (- (aref x1 i) (aref x j)))))))
    ;; sending the plotting commands to the gnuplot ptocess
    (format (gpstream instance)
            "plot '-' w lines title 'Exact', '-' w lines title 'Approx.', '-' w lines title 'Absolute err.'~%")
    (dotimes (i 1025)
      (format (gpstream instance) "~f ~f~%" (aref x1 i) (aref f1 i)))
    (format (gpstream instance) "e~%")
    (dotimes (i 1025)
      (format (gpstream instance) "~f ~f~%" (aref x1 i) (aref fa1 i)))
    (format (gpstream instance) "e~%")
    (dotimes (i 1025)
      (format (gpstream instance) "~f ~f~%" (aref x1 i) (aref er1 i)))
    (format (gpstream instance) "e~%")
    (force-output (gpstream instance))))

(defmethod close-event ((instance approx-mainform) close-event)
  (print "Close event")
  (sb-ext::process-kill (gpprocess instance) 9)
  (#_accept close-event))

(defun approx-main()
  (qt:ensure-smoke "qtuitools")
  (make-qapplication)
  (with-objects ((mainform (make-instance 'approx-mainform)))
    (#_show mainform)
    (#_exec *qapplication*)))
