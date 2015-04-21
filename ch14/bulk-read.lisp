(defvar *data* (make-array 15 :initial-element nil))
(values
 (read-sequence *data* 
		(make-string-input-stream "test string")) 
  *data*)
