;;concatenate
*(concatenate 'list)

NIL
* (concatenate 'vector)

#()
* (concatenate 'list '(1 2 3) '(4 5))

(1 2 3 4 5)
* (concatenate 'vector #(1 2 3) #(4 5))

#(1 2 3 4 5)
* (concatenate 'list #(1 2 3) #(4 5))

(1 2 3 4 5)
* (concatenate 'list #(1 2 3) '(4 5))

(1 2 3 4 5)
* (concatenate 'vector #(1 2 3) '(4 5))

#(1 2 3 4 5)
* (concatenate 'list "hello")

(#\h #\e #\l #\l #\o)

;;elt subseq

* (elt '(1 2 3 4 5) 1)

2
* (subseq '(1 2 3 4 5) 2)

(3 4 5)
* (let ((l '(1 2 3 4 5)))
    (subseq l 2 (length l)))

(3 4 5)

* (subseq #(#\a #\b #\c #\d #\e) 2 4)

#(#\c #\d)
* (copy-seq '(a b c))

(A B C)

* (count 3 '((1 2 3) (2 3 1) (3 1 2) (2 1 3) (1 3 2) (3 2 1)) :key #'second)

2

* (count-if #'(lambda (n) (< 3 n)) '(1 2 3 4 5 6 7))

4

* (count 3 '(1 2 3 4 5 6 7) :test #'eql)

1

* (fill (list 1 1 2 3 5 8) 7)

(7 7 7 7 7 7)

* (fill (list 1 1 2 3 5 8) '(a b))

((A B) (A B) (A B) (A B) (A B) (A B))


* (mismatch "banana" "bananananono")

6
*(mismatch "." "...hello") 
(mismatch "." "...hello") 

1

* (sort (list 9 3 5 4 8 7 1 2 0 6) #'>)

(9 8 7 6 5 4 3 2 1 0)

* (sort (list 9 3 5 4 8 7 1 2 0 6) #'<)

(0 1 2 3 4 5 6 7 8 9)
