(dolist 
    (x '(1 2 3)) 
  (print x))

(dolist
    (x '(1 2 3 4 5 6 7 8 9 10))
  (print x)
  (if (evenp x)
      (return)))
