(load "lib.lisp")

(assert (eql :ignore (xtest-values (= 2 3))))
(assert (eql :ignore (xtest-values (= 2 2))))
(assert (eql :ignore (xtest-values (error "hi"))))
(assert (eql :ignore (xtest (= 2 3))))
(assert (eql :ignore (xtest (= 2 2))))
(assert (eql :ignore (xtest (error "hi"))))
(assert (eql :ignore (xtest (error "hi") :handler bad-handler)))

(assert (eql :pass (test-values (= 2 2))))
(assert (eql :fail (test-values (= 2 3))))
(assert (eql :error (test-values (error "hi"))))
(assert (eql :error (handle-test-values :error '(error "hi") 3)))
(assert (eql :fail (handle-test-values :fail '(= 2 3) nil)))
(assert (eql :pass (handle-test-values :pass '(= 2 2) nil)))

(defun bad-handler (result s-exp err)
  (declare (ignore s-exp err))
  (case result
    (:pass "this passed")
    (:fail "this failed")
    (:error "this errored")))

(assert (string= "this passed" (test t :handler bad-handler)))
(assert (string= "this failed" (test nil :handler bad-handler)))
(assert (string= "this errored" (test (error "hi") :handler bad-handler)))
(assert (string= "potato"
                 (test (error "hi")
                        :handler (lambda (result s-exp err)
                                   (declare (ignore result s-exp err))
                                   "potato"))))


