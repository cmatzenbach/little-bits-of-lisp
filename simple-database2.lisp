(defvar *db* nil)

; add an individual cd to the db
(defun add-record (cd)
  (push cd *db*))

;; function to make it easier to add items to db
(defun make-cd (title artist rating ripped)
   (list :title title :artist artist :rating rating :ripped ripped))

;; add values to db
(add-record (make-cd "Pink Moon" "Nick Drake" 5 t))
(add-record (make-cd "Highway 1961 Revisited" "Bob Dylan" 5 nil))
(add-record (make-cd "Either/Or" "Ellot Smith" 5 t))
(add-record (make-cd "Zen Arcade" "Husker Du" 4 t))
(add-record (make-cd "Grace" "Jeff Buckley" 5 nil))
(add-record (make-cd "Blonde on Blonde" "Bob Dylan" 5 nil))
(add-record (make-cd "Blood on the Tracks" "Bob Dylan" 5 nil))

;; display db into human readable format
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{a }"))
