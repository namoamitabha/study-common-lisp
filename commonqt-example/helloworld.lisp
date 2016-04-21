(ql:quickload :qt)
(in-package :qt)
(named-readtables:in-readtable :qt)

(defclass hello-world-app () ()
  (:metaclass qt-class)
  (:qt-superclass "QWidget"))

(defmethod initialize-instance :after
    ((instance hello-world-app) &key)
  (new instance))

(defmethod initialize-instance :after
    ((instance hello-world-app) &key)
  (new instance)
  (#_setGeometry instance 200 200 300 300)
  (#_setWindowTitle instance "Hello World"))

(make-qapplication)

(with-main-window (window (make-instance 'hello-world-app)))
