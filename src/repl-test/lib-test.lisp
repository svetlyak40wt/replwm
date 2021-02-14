(load "lib.lisp")

(assert (eql :ignore (xtest (= 2 3))))
(assert (eql :ignore (xtest (= 2 2))))
(assert (eql :ignore (xtest (error "hi"))))
(assert (eql :ignore (xcheck (= 2 3))))
(assert (eql :ignore (xcheck (= 2 2))))
(assert (eql :ignore (xcheck (error "hi"))))
(assert (eql :ignore (xcheck (error "hi") :handler bad-handler)))

(assert (eql :pass (test (= 2 2))))
(assert (eql :fail (test (= 2 3))))
(assert (eql :error (test (error "hi"))))
(assert (eql :error (handle-test-result :error '(error "hi") 3)))
(assert (eql :fail (handle-test-result :fail '(= 2 3) nil)))
(assert (eql :pass (handle-test-result :pass '(= 2 2) nil)))

(defun bad-handler (result s-exp err)
  (declare (ignore s-exp err))
  (case result
    (:pass "this passed")
    (:fail "this failed")
    (:error "this errored")))

(assert (string= "this passed" (check t :handler bad-handler)))
(assert (string= "this failed" (check nil :handler bad-handler)))
(assert (string= "this errored" (check (error "hi") :handler bad-handler)))
(assert (string= "potato"
                 (check (error "hi")
                        :handler (lambda (result s-exp err)
                                   (declare (ignore result s-exp err))
                                   "potato"))))


