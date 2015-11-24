(let ((password nil)
      (secret nil))
  (defun set-password (new-password)
    (if password
	'|Can't - already set|
	(setq password new-password)))
  (defun change-password (old-password new-password)
    (if (eq old-password password)
	(setq password new-password)
	'|Not changed|))
  (defun set-secret (passwd new-secret)
    (if (eq passwd password)
	(setq secret new-secret)
	'|Wrong password|))
  (defun get-secret (passwd)
    (if (eq passwd password)
	secret
	'|Sorry|)))

;; * (get-secret 'sesame)

;; |Sorry|
;; * (set-password 'valetine)

;; VALETINE
;; * (set-secret 'sesame 'my-secret)

;; |Wrong password|
;; * (set-secret 'valetine 'my-secret)

;; MY-SECRET
;; * (get-secret 'fubar)

;; |Sorry|
;; * (get-secret 'valetine)

;; MY-SECRET
;; * (change-password 'fubar 'new-password)

;; |Not changed|
;; * (change-password 'valetine 'new-password)

;; NEW-PASSWORD
;; * (get-secret 'valetine)

;; |Sorry|


;;********************
(defun make-secret-keeper ()
  (let ((password nil)
	(secret nil))
    #'(lambda (operation &rest arguments)
	(ecase operation
	  (set-password
	   (let ((new-password (first arguments)))
	     (if password
		 '|Can't - already set|
		 (setq password new-password))))
	  (change-password
	   (let ((old-password (first arguments))
		 (new-passowrd (second arguments)))
	     (if (eq old-password password)
		 (setq password new-passowrd)
		 '|Not changed|)))
	  (set-secret
	   (let ((passwd (first arguments))
		 (new-secret (second arguments)))
	     (if (eq passwd password)
		 (setq secret new-secret)
		 '|Wrong password|)))
	  (get-secret
	   (let ((passwd (first arguments)))
	     (if (eq passwd password)
		 secret
		 '|Sorry|)))))))


;; * (defparameter secret-1 (make-secret-keeper))

;; SECRET-1
;; * (funcall secret-1 'set-password 'valentine)

;; VALENTINE
;; * (funcall secret-1 'set-secret 'valentine 'deep-dark)

;; DEEP-DARK
;; * (defparameter secret-2 (make-secret-keeper))

;; SECRET-2
;; * (funcall secret-2 'set-password 'body)

;; BODY
;; * (funcall secret-2 'set-secret 'body 'my-secret)

;; MY-SECRET
;; * (funcall secret-1 'get-secret 'valentine)

;; DEEP-DARK
;; * (funcall secret-2 'get-secret 'body)

;; MY-SECRET
;; * 
