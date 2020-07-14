;; easy way to return multiple values - (values)
(defun test (x y)
  (values (+ x y)
          (* x y)))

(defun mid-test (x)
  (test 10 30))

;; return a list based on one argument
(defun test-1 (x)
  (let ((tmp (test x (* x 2))))
    tmp))
(defun test-2 (x)
  (multiple-value-bind (a b) (test x (* x 2))
    (list a b)))

;; return as many values that are passed as args
(defun test-3 (&rest args)
  (values-list args))

;; takes a statement returning multiple values and converts them into a list
(multiple-value-list (test 20 30))
