(defun keyword-sample-1 (a b c &key d e f)
  (list a b c d e f))

(keyword-sample-1 1 2 3)
(keyword-sample-1 1 2 3 :d 4)
(keyword-sample-1 1 2 3 :e 5)
(keyword-sample-1 1 2 3 :f 6 :d 4 :e 5)
;; (1 2 3 NIL NIL NIL)
;; * 
;; (1 2 3 4 NIL NIL)
;; * 
;; (1 2 3 NIL 5 NIL)
;; * 
;; (1 2 3 4 5 6)
;; * 

;;********************
(defun keyword-sample-2 (a &key (b 77) (c 88))
  (list a b c))

(keyword-sample-2 1)
(keyword-sample-2 1 :c 3)

;; (1 77 88)
;; * 
;; (1 77 3)
;; * 

(defun keyword-sample-3 (a &key (b nil b-p) (c 53 c-p))
  (list a b b-p c c-p))

(keyword-sample-3 1)
(keyword-sample-3 1 :b 74)
(keyword-sample-3 1 :b nil)
(keyword-sample-3 1 :c 9)
;; (1 NIL NIL 53 NIL)
;; * 
;; (1 74 T 53 NIL)
;; * 
;; (1 NIL T 53 NIL)
;; * 
;; (1 NIL NIL 9 T)
;; * 

(defun optional-sample-1 (a &optional (b nil b-p))
  (list a b b-p))

(optional-sample-1 1)
(optional-sample-1 1 nil)
(optional-sample-1 1 2)
;; (1 NIL NIL)
;; * 
;; (1 NIL T)
;; * 
;; (1 2 T)
;; * 

(defun optional-keyword-sample-1 (a &optional b c &key d e)
  (list a b c d e))

(optional-keyword-sample-1 1)
(optional-keyword-sample-1 1 2)
(optional-keyword-sample-1 1 2 3)
(optional-keyword-sample-1 1 2 3 :e 5)
;; (1 NIL NIL NIL NIL)
;; * 
;; (1 2 NIL NIL NIL)
;; * 
;; (1 2 3 NIL NIL)
;; * 
;; (1 2 3 NIL 5)

(defun optional-keyword-sample-2 (a &optional b c d &key e f)
  (list a b c d e f))

(optional-keyword-sample-2 1 2 :e 1)
;; * (optional-keyword-sample-2 1 2 :e 1)

;; (1 2 :E 1 NIL NIL)

;;********************
