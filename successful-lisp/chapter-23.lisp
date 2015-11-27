(defun divide (numerator denominator)
  (when (zerop denominator)
    (error "Sorry, you can't divide by zero"))
  (/ numerator denominator))

(divide 4 3)
(divide 4 0)

;;********************

