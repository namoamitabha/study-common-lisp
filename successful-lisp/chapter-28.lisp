(defun sum-list-bad-1 (list)
  (let ((result 0))
    (dotimes (i (length list))
      (incf result (elt list i)))
    result))

;; (let ((list (make-list 10000 :initial-element 1)))
;;   (time (sum-list-bad-1 list)))
;; Evaluation took:
;;   0.288 seconds of real time
;;   0.288000 seconds of total run time (0.288000 user, 0.000000 system)
;;   100.00% CPU
;;   716,786,722 processor cycles
;;   0 bytes consed
  
;; 10000

;; (let ((list (make-list 100000 :initial-element 1)))
;;   (time (sum-list-bad-1 list)))

;; Evaluation took:
;;   24.731 seconds of real time
;;   24.772000 seconds of total run time (24.772000 user, 0.000000 system)
;;   100.17% CPU
;;   61,687,885,404 processor cycles
;;   91,288 bytes consed
  
;; 100000

(defun sum-list-bad-2 (list)
  (labels ((do-sum (rest-list sum)
             (if (null rest-list)
                 sum
                 (do-sum (rest rest-list) (+ sum (first rest-list))))))
    (do-sum list 0)))

;; (let ((list (make-list 10000 :initial-element 1)))
;;   (time (sum-list-bad-2 list)))

;; Evaluation took:
;;   0.000 seconds of real time
;;   0.000000 seconds of total run time (0.000000 user, 0.000000 system)
;;   100.00% CPU
;;   127,032 processor cycles
;;   0 bytes consed
  
;; 10000

;; (let ((list (make-list 100000 :initial-element 1)))
;;   (time (sum-list-bad-2 list)))

;; Evaluation took:
;;   0.001 seconds of real time
;;   0.004000 seconds of total run time (0.004000 user, 0.000000 system)
;;   400.00% CPU
;;   1,164,202 processor cycles
;;   0 bytes consed
  
;; 100000

(defun sum-list-bad-3 (list)
  (declare (optimize (debug 3)))
  (labels ((do-sum (rest-list sum)
             (if (null rest-list)
                 sum
                 (do-sum (rest rest-list) (+ sum (first rest-list))))))
    (do-sum list 0)))

;; (let ((list (make-list 10000 :initial-element 1)))
;;   (time (sum-list-bad-3 list)))

;; Evaluation took:
;;   0.001 seconds of real time
;;   0.000000 seconds of total run time (0.000000 user, 0.000000 system)
;;   0.00% CPU
;;   1,416,763 processor cycles
;;   0 bytes consed
  
;; 10000

;; (let ((list (make-list 100000 :initial-element 1)))
;;   (time (sum-list-bad-3 list)))

;; Evaluation took:
;;   0.002 seconds of real time
;;   0.000000 seconds of total run time (0.000000 user, 0.000000 system)
;;   0.00% CPU
;;   5,606,863 processor cycles
;;   0 bytes consed
  
;; 100000

(defun  sum-list-good (list)
  (let ((sum 0))
    (do ((list list (rest list)))
        ((endp list) sum)
      (incf sum (first list)))))

;; (let ((list (make-list 10000 :initial-element 1)))
;;   (time (sum-list-good list)))

;; Evaluation took:
;;   0.000 seconds of real time
;;   0.000000 seconds of total run time (0.000000 user, 0.000000 system)
;;   100.00% CPU
;;   318,487 processor cycles
;;   0 bytes consed
  
;; 10000

;; (let ((list (make-list 100000 :initial-element 1)))
;;   (time (sum-list-good list)))

;; Evaluation took:
;;   0.001 seconds of real time
;;   0.000000 seconds of total run time (0.000000 user, 0.000000 system)
;;   0.00% CPU
;;   2,244,145 processor cycles
;;   0 bytes consed
  
;; 100000
