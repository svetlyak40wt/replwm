(in-package #:replwm)

(defmacro forever (&body code)
  `(do () (nil) ,@code))

(defun main ()
  (forever
    (format t "hi~%")))

