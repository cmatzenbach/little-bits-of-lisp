;; want macro to result in:
;; (do-primes (p 0 19)
;;  (format t "~d " p))

;; test if given number is prime
(defun primep (number)
  (when (> number 1)
	(loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))

;; non-macro, do solution
(do ((p (next-prime 0) (next-prime (1+ p))))
    ((> p 19))
  (format t "~d " p))

;; macro for do form
(defmacro do-prime (arg-list &rest body)
  (let ((var (first arg-list))
		(start (second arg-list))
		(end (third arg-list)))
	`(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
		 ((> ,var ,end))
	  ,@body)))

;; body version
(defmacro do-prime2 ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	   ((> ,var ,end))
	 ,@body))

;; leak-proof macro
(defmacro do-prime3 ((var start end) &body body)
  (let ((ending-value-name (gensym)))
	`(do ((,var (next-prime ,start) (next-prime (1+ ,var)))
		  (,ending-value-name ,end))
		 ((> ,var ,ending-value-name))
	   ,@body)))
