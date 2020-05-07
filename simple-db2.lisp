(defvar *db* nil)

;; add data for cds
(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

;; show current db as list
(defun add-record (cd)
  (push cd *db*))

;; show current db in nicely formatted style
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))

;; get user to input cd information
(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

;; make new cd record by prompting users for info
(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]: ")))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
        (if (not (y-or-n-p "Another? [y/n]: "))
            (return))))
