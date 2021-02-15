;; -*- lexical-binding: t -*-
;; For a convenient editing experience, load this file into Emacs before you
;; start hacking on the project. It will handle making sure all the files
;; you need are loaded for you.

(defun replwm/get-files-to-load ()
  "Get the files we need Sly to evaluate."
  (interactive)
  (let ((system (getenv "REPLWM_SYSTEM_PATH"))
        (asdf (getenv "REPLWM_ASDF_PATH")))
    (unless (and system asdf)
      (error "Path environment variables not set. Please source the .envrc file."))
    (list system asdf)))

(defun replwm/load-project-package ()
  "Load the files which define our project into Sly."
  (sly-eval
   `(common-lisp:let ((files (common-lisp:list ,@(replwm/get-files-to-load))))
      (common-lisp:dolist (file files)
                          (common-lisp:load file))
      (asdf:load-system 'replwm/test))))

(add-hook 'sly-connected-hook 'replwm/load-project-package)
