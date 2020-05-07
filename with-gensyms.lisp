;; want: ((A (GENSYM)) (B (GENSYM)) (C (GENSYM)))
(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
	 ,@body))
