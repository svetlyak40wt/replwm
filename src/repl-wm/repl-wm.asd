(asdf:defsystem #:repl-wm
  :serial t
  :components ((:file "packages.lisp")
               (:file "repl-wm.lisp")))

(asdf:defsystem #:repl-wm/test
  :serial t
  :components ((:file "packages.lisp")
               (:file "repl-wm.lisp")
               (:file "repl-wm-tests.lisp")))

