(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))

(do-primes (p 0 19)
  (format t "~d " p))


(do ((p (next-prime 0) (next-prime (1+ p))))
    ((> p 19))
  (format t "~d " p))

(defmacro do-primes (var-and-range &rest body)
  (let ((var (first var-and-range))
	(start (second var-and-range))
	(end (third var-and-range)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	 ((> ,var ,end))
       ,@body)))

(defmacro do-primes-1 ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
       ((> ,var ,end))
     ,@body))

(do-primes-1 (p 0 19)
  (format t "~d " p))

(defmacro do-primes-a ((var start end) &body body)
  (append '(do)
	  (list (list (list var
			    (list 'next-prime start)
			    (list 'next-prime (list '1+ var)))))
	  (list (list (list '> var end)))
	  body))

(macroexpand-1 '(do-primes-a (p 0 19) (format t "~d " p)))

(macroexpand-1 '(do-primes-1 (p 0 19) (format t "~d " p)))

(macroexpand '(do-primes-1 (p 0 19) (format t "~d " p)))

(macroexpand-1 '(do-primes-1 (p 0 (random 100)) (format t "~d " p)))

(defmacro do-primes ((var start end) &body body)
  `(do ((ending-value ,end)
	(,var (next-prime ,start) (next-prime (1+ ,var))))
       ((> ,var ending-value))
     ,@body))

(defmacro do-primes ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	(ending-value ,end))
       ((> ,var ending-value))
     ,@body))

(do-primes (ending-value 0 10)
  (print ending-value))

(let ((ending-value 0))
  (do-primes (p 0 10)
    (incf ending-value p))
  ending-value)

(macroexpand-1 '(do-primes (ending-value 0 10) (print ending-value)))

(macroexpand-1 '(let ((ending-value 0))
		 (do-primes (p 0 10)
		   (incf ending-value p))
		 ending-value))

(defmacro do-primes ((var start end) &body body)
  (let ((ending-value-name (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
       ,@body)))

(defmacro do-primes ((var start end) &body body)
  (with-gensyms (ending-value-name)
    `(do ((,var (next-prime, start) (next-prime (1+ ,var)))
	  (,ending-value-name ,end))
	 ((> ,var ,ending-value-name))
       ,@body)))

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(loop for n in '(a b c) collect `(,n (gensym)))

(defmacro do-primes ((var start end) &body body)
  (once-only (start end)
	     `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
		  ((> ,var ,end))
		,@body)))


(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
	  ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
		,@body)))))
