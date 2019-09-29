(defun foo (x)
  (when2 (> x 10) (print 'big)))
(defmacro when2 (condition &rest body)
  `(if ,condition (progn ,@body)))
