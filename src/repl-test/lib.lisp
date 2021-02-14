(defpackage #:repl-test
  (:use #:common-lisp)
  (:export #:test #:xtest #:check #:xcheck))

(defmacro xtest (exp)
  (declare (ignore exp))
  `:ignore)

(defmacro test (exp)
  `(handler-case (values (if ,exp :pass :fail) ',exp nil)
     (t (err) (values :error ',exp err))))

(defun handle-test-result (result s-exp err)
  (cond
    ((not (null err)) (format t "Form ~a errored: ~a~%" s-exp err))
    ((eq result :fail) (format t "Test failed: ~a~%" s-exp)))
  result)

(defmacro xcheck (exp &key (handler 'handle-test-result))
  (declare (ignore exp handler))
  `:ignore)

(defmacro check (exp &key (handler 'handle-test-result))
  `(multiple-value-bind (result s-exp err) (test ,exp)
     (,handler result s-exp (or err nil))))

;; TODO: Make this code:
;; (defsuite this-suite ((:before setup-fn) (:after teardown-fn))
;;   (check (= 3 4))
;;   (check (= 2 3))
;;   (format t "This is a side effect!~%")
;;   (xcheck (= 2 3)))
;; Build a giant thunk which executes its body in order and agregates
;; its results into a struct. Then make this function:
;; (run-suites this-suite)
;; Aggregate all the results of the structs into one and report on them.
