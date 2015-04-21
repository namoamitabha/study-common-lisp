(loop
     (print "looping...")
   (sleep 1))

(loop for x from 1 to 10 collecting x)

(loop for x from 1 to 10 summing (expt x 2))

(loop for x across "the quick brown fox jumps over the lazy dog"
     counting (find x "aeiou"))


