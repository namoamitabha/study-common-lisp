(defun one-shot-server (port)
  (let ((socket (usocket:socket-listen usocket:*wildcard-host*
				       port
				       :reuse-address t)))
    (usocket:wait-for-input socket)
    (let ((stream (usocket:socket-stream (usocket:socket-accept socket))))
      (handle-request stream)
      (close stream)
      (usocket:socket-close socket))))

(defun handle-request (stream)
  (let ((line (read-line stream)))
    (format stream "You said: ~a" line))
  (terpri stream)
  (force-output stream))
