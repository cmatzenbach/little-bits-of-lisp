(defvar *test-name* nil)

;; prints result of unit test to user
(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form))

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
	 ,@body))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
      ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
      ,result)))

;; macro to do the check
(defmacro check (&body forms)
  `(combine-results
	 ,@(loop for f in forms collect `(report-result ,f ',f))))

;; macro to create test functions
(defmacro deftest (name params &body body)
  `(defun ,name ,params
	 (let ((*test-name* (append *test-name* (list',name))))
	   ,@body)))

(defun test-+ ()
  (let ((*test-name* 'test-+))
	(check
	  (= (+ 1 2) 3)
	  (= (+ 1 2 3) 6)
	  (= (+ -1 -3) -4))))

(defun test-* ()
  (let ((*test-name* 'test-*))
	(check
	  (= (* 2 2) 4)
	  (= (* 3 5) 15))))

(deftest test-+2 ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) -4)))

(defun test-arithmetic ()
  (combine-results
	(test-+)
	(test-*)))
(deftest test-arth ()
  (combine-results
	(test-+)
	(test-*)))
