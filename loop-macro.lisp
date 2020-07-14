(defpackage #:lil-bits-of-lisp
  (:use :cl))
;; (in-package #:lil-bits-of-lisp)

;; symbols to try out
(defparameter *anumbers* '(1 2 3 4 5 6 7 8 9 10))
(defparameter *snumbers* '(10 9 8 7 6 5 4 3 2 1))
(defparameter *symbols* '(a b c d e f))
(defparameter *pairs* '((a 1) (b 2) (c 3) (d 4) (e 5)))
(defparameter *triples* '((a 1 1) (b 2 4) (c 3 9) (d 4 16) (e 5 25)))

;; simple counting loop macros to run
(loop :for i :below 5 :collect i)
(loop :for i :from 1 :upto 5 collect i)
(loop :for i :from 1 :downto -15 :collect i)
(loop :for i :upto 4 :collect i)
(loop :for i :upto 3 :collect i)
(loop :for i :from 1 :upto 15 :by 2 :collect i)
(loop :for i :from 1 :upto 60 :by 2 :collect i)
(loop :for i :from 1 :downto -20 :by 2 :collect i)

;; collect values as loop passes over; works for single or mult values
(loop :for i :in *symbols* :collect i)
(loop :for i :in *anumbers* :collect (* i i))
(loop :for i :in *anumbers* :for j :in *snumbers* :collect (list i j))
(loop :for i :in *anumbers* :for j :in *symbols* :collect (list i j))
(loop :for i :in *pairs* :for j :in *triples* :collect (list i j))

;; don't always need to use :collect, sometimes don't want to store result (do will never store result and will always return nil)
;; print out all numbers in numbers list and returns nil
(loop :for i :in *anumbers* :do (print i))

;; can have multiple forms in a do statement; didn't do anything with data
(loop :for i :in *anumbers* :do
  (print "hi")
  (print "more here")
  (print "weeee"))

;; can have nested do loops, runs through inner loop before next interation on outer loop (do clause is used - therefore result is still nil)
(loop :for i :in *anumbers* :do
   (loop :for j :in *symbols* :do (print (list i j))))

;; use the outer loop as a "control mechanism" for what is collected in second loop
(loop :for i :in *anumbers* :collect
   (loop :for j :in *symbols* :collect j))

;; if we want to append sublists together, swap out :collect call on outer loop for :append
(loop :for i :in *anumbers* :append
   (loop :for j :in *symbols* :collect j))

;; mathy operations
;; can check if number is odd/even during loop (awkward)
(loop :for i :in *anumbers* :if (oddp i) :collect i)
;; can also collect sum (add)
(loop :for i :in *anumbers* :if (oddp i) :sum i)
;; do straight math in a for loop
(loop :for i :in *anumbers*
      :for s = (* i i)
      :sum s)
;; could've got the same thing doing this:
(loop :for i :in *anumbers*
			:sum (* i i))

;; we can create an internal variable with :into
(loop :for i :in *anumbers* :if (oddp i) :sum i :into a)
;; to do something with it, need to return the value
(loop :for i :in *anumbers* :if (oddp i) :sum i :into a :finally (return a))

;; loop that will sum all the odd and even numbers and then return them
;; both in a list, with the odd numbers first
(loop :for i :in *anumbers*
      :if (oddp i) :sum i :into odd-nums
        :else :sum i :into even-nums
      :finally (return (list odd-nums even-nums)))

;; collect elements of a vector
(loop :for i :being :the :elements :of #(1 2 3) :collect i)
;; collect elements of a string
(loop :for i :being :the :elements :of "Once upon a time" :collect i)

;; destructuring
(loop :for (x y) :in *pairs* :collect (list x y))
(loop :for (x y) :in *pairs* :do (print x) (print y))
(loop :for (x y) :in *pairs* :collect (list x (* y y)))
;; destructure sublists and only collect one item from each!
(loop :for (x) :in *pairs* :collect x)
(loop :for (x y z) :in *triples* :collect (list x (* y y) z))
;; we can take as many items as we want, here leaving out the third
(loop :for (x y) :in *triples* :collect (list x (* y y)))
;; we don't have enough values, but it won't throw an error - just pass nil
(loop :for (x y z) :in *pairs* :collect (list x (* y y) z))
(loop :for (x . y) :in *triples* :collect (list x y))
