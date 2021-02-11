.PHONY: build
build: ## Compile the project.
	@ :

.PHONY: xrepl
xrepl: ## Open Xephyr in display :1 and a shell for running programs there.
	@ sbcl --script bin/xrepl.lisp

.PHONY: help
help: ## Display this help message and then exit.
	@ sbcl --script bin/help.lisp
