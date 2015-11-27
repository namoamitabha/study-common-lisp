(defun fibonacci (n)
  (if (<= n 1)
      1
      (+ (fibonacci (- n 2)) (fibonacci (1- n)))))

(advise fibonacci
	(when (zerop (first arglist)) (break))
	:when :before
	:name :break-on-zero)
