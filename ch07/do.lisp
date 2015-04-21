(print 
 (do ((n 0 (1+ n))
      (cur 0 next)
      (next 1 (+ cur next)))
     ((= 10 n) cur)))


(do ((i 0 (1+ i)))
    ((>= i 4))
  (print i))

(setq *some-future-date* 3638686605)

(do ()
    ((> (get-universal-time) *some-future-date*))
  (format t "Waiting 5s~%")
  (sleep 5))
