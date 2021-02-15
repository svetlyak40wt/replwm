(in-package #:repl-wm-tests)

(defun check-forever ()
  (let ((el 5))
    (forever
      (if (> el 0) (decf el) (return-from check-forever el)))))

(test (= 0 (check-forever)))
