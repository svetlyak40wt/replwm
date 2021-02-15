(defpackage #:repl-wm
  (:use #:common-lisp)
  (:export #:forever))

(defpackage #:repl-wm-tests
  (:use #:common-lisp #:repl-wm #:wm-test))
