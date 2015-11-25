(defun safe-elt (sequence index)
  (and (< -1 index (length sequence))
       (values (elt sequence index) t)))

(safe-elt #(1 2 3) 3)

(elt #(1 2 3) 3)

(safe-elt #(1 2 3) 2)

;;********************
(boole boole-and 15 7)
(boole boole-ior 2 3)
(boole boole-set 99 55)
(boole boole-andc2 7 4)

;;********************
(logtest 7 16)
(logtest 15 5)

(logbitp 0 16)
(logbitp 4 16)
(logbitp 0 -2)
(logbitp 77 -2)

(logcount 35)
(logcount -2)
(logcount -1)
(logcount 0)

;;********************
#*0010101
(length #*0010101)
(bit-and #*00110100 #*10101010)
(bit-ior #*00110100 #*10101010)
(bit-not #*00110100)

(bit #*01001 1)
(let ((bv (copy-seq #*00000)))
  (setf (bit bv 3) 1)
  bv)

;;********************
(setq bs (byte 5 3))
(byte-size bs)
(byte-position bs)

(ldb (byte 8 8) 258)
(ldb (byte 8 0) 258)
(ldb (byte 8 1) 258)
(dpb 3 (byte 8 8) 0)
(dpb 1 (byte 1 5) 1)

(ldb-test (byte 3 2) 3)
(ldb-test (byte 3 2) 9)
(ldb-test (byte 3 2) 34)

(integer-length 69)
(integer-length 4)
(integer-length -1)
(integer-length 0)
(integer-length -5)

(ash 75 0)
(ash 31 1)
(ash -7 1)
(ash 32 8)
(ash -1 8)
(ash 16 -1)
(ash 11 -1)
(ash 32 -8)
(ash 99 -2)
(ash -99 -2)
