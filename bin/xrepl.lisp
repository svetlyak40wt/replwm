(let ((xephyr (sb-ext:run-program "/usr/bin/Xephyr" (list ":1") :wait nil)))
  (sb-ext:run-program (or (sb-ext:posix-getenv "XREPL_SHELL")
                          (sb-ext:posix-getenv "SHELL"))
                      nil
                      :output t
                      :input t
                      :environment (list "DISPLAY=:1" "TERM=xterm"))
  (sb-ext:process-kill xephyr 15))
