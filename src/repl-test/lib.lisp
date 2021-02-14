(defpackage #:repl-test
  (:use #:common-lisp)
  (:export #:xtest #:test))

(defmacro xtest-values (exp)
  (declare (ignore exp))
  `:ignore)

(defmacro test-values (exp)
  `(handler-case (values (if ,exp :pass :fail) ',exp nil)
     (t (err) (values :error ',exp err))))

(defun handle-test-values (result s-exp err)
  (cond
    ((not (null err)) (format t "Form ~a errored: ~a~%" s-exp err))
    ((eq result :fail) (format t "Test-Values failed: ~a~%" s-exp)))
  result)

(defmacro xtest (exp &key (handler 'handle-test-values))
  (declare (ignore exp handler))
  `:ignore)

(defmacro test (exp &key (handler 'handle-test-values))
  `(multiple-value-bind (result s-exp err) (test-values ,exp)
     (,handler result s-exp (or err nil))))

;; TODO: Make this code:
;; (defsuite this-suite ((:before setup-fn) (:after teardown-fn))
;;   (test (= 3 4))
;;   (test (= 2 3))
;;   (format t "This is a side effect!~%")
;;   (xtest (= 2 3)))
;; Build a giant thunk which executes its body in order and agregates
;; its results into a struct. Then make this function:
;; (run-suites this-suite)
;; Aggregate all the results of the structs into one and report on them.
