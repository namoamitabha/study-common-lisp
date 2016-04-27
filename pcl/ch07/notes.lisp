(if (> 2 3)
    "Yup"
    "Nope")

(if (> 2 3) "Yup")

(if (> 3 2) "Yup" "Nope")

(defmacro when0 (condition &rest body)
  `(if ,condition (progn ,@body)))

(defmacro unless0 (condition &rest body)
  `(if (not ,condition) (progn ,@body)))

(not nil)

(not (= 1 1))

(and (= 1 2) (= 3 3))

(or (= 1 2) (= 3 3))

(dolist (x '(1 2 3)) (print x))

(dolist (x '(1 2 3)) (print x) (if (evenp x) (return)))

(dotimes (i 4) (print i))

(dotimes (x 10)
  (dotimes (y 10)
    (format t "~3d " (* (1+ x) (1+ y))))
  (format t "~%"))

(do ((n 0 (1+ n))
     (cur 0 next)
     (next 1 (+ cur next)))
    ((= 10 n) cur)
  (print (list n cur next)))

(do ((i 0 (1+ i)))
    ((>= i 4))
  (print i))

(dotimes (i 4) (print i))

(defvar *some-future_date* (+ (get-universal-time) 2000))

(do ()
    ((> (get-universal-time) *some-future_date*))
  (format t "Waiting~%")
  (sleep 5))

(defvar *some-future_date* (+ (get-universal-time) 2000))

(loop
   (when (> (get-universal-time) *some-future_date*)
     (return))
   (format t "Waiting ...~%")
   (sleep 1))

(do ((nums nil) (i 1 (1+ i)))
    ((> i 10) (nreverse nums))
  (push i nums))

(loop for i from 1 to 10 collecting i)

(loop for x from 1 to 10 summing (expt x 2))

(loop for x across "the quick brown fox jumps over the lazy dog"
     counting (find x "aeiou"))

(loop for i below 10
   and a = 0 then b
   and b = 1 then (+ b a)
   finally (return a))
