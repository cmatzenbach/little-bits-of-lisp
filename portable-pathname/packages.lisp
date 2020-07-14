;; gets a list of files in a directory and determines whether a file or directory with a given name exists

(in-package :cl-user)

(defpackage :portable-pathname
  (:use common-lisp)
  (:export
   :component-present-p
   :directory-pathname-p
   :pathname-as-directory
   :list-directory
   :file-exists-p
   :directory-pathname-p
   :file-pathname-p
   :pathname-as-directory
   :pathname-as-file
   :walk-directory
   :directory-p
   :file-p))

(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

(defun directory-pathname-p (p)
  (and
   (not (component-present-p (pathname-name p)))
   (not (component-present-p (pathname-type p)))
   p))

(defmacro matzyreverse (text)
  (reverse text))

(defun pathname-as-directory (name)
  (let ((pathname (pathname name)))
	(when (wild-pathname-p pathname)
	  (error "Can't reliably ocnvert wild pathnames."))
	(if (not (directory-pathname-p name))
		(name-pathname
		 :directory (append (or (pathname-directory pathname) (list :relative))
							(list (file-namestring pathname)))
		 :name nil
		 :type nil
		 :defaults pathname)
		pathname)))
