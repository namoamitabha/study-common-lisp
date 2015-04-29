;; Utility: if Bordeaux Threads are available make the function call in a
;; separate process and return from try-make-thread immediately.
(defun try-make-thread (name function)
  #+bordeaux-threads
  (bt:make-thread function :name name)
  #-bordeaux-threads
  (funcall function))


(defun handle-request (stream)
  (let ((line (read-line stream)))
    (format stream "You said: ~a" line))
  (terpri stream)
  (force-output stream))


;; Create a passive/listening socket and pass this to run-server. Guarantee
;; that the socket will be released when the server halts.
(defvar *server* nil)
(defun start-server (port)
  (let ((socket (usocket:socket-listen usocket:*wildcard-host*
				       port
				       :reuse-address t)))
    (setf *server*
	  (try-make-thread (format nil "Port ~a server" port)
			   (lambda ()
			     (unwind-protect
				  (run-server socket)
			       (usocket:socket-close socket)))))))
;; To stop the server we kill its process. The unwind-protect above ensures
;; that the socket will be closed.
#+bordeaux-threads
(defun stop-server ()
  (let ((server (shiftf *server* nil)))
    (when server
      (bt:destroy-thread server))))

;; Loop around, waiting for incoming connections. Each time one arrives,
;; call usocket:socket-stream to create a bidirectional stream and pass
;; this to handle-request, asynchronously if possible. Guarantee that the
;; stream will be closed when handle-request exits. For now, just call the
;; simple handler we defined earlier. We’ll redefine that later.

(defun run-server (socket)
  (loop
     (usocket:wait-for-input socket)
     (let ((stream (usocket:socket-stream (usocket:socket-accept socket))))
       (try-make-thread (format nil "Request handler for ~s" stream)
			(lambda ()
			  (with-open-stream (stream stream)
			    (handle-request stream)))))))


