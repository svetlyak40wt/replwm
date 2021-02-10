.PHONY: build
build: ## Compile the project.
	@ :

.PHONY: help
help: ## Display this help message and then exit.
	@ sbcl --script bin/help.lisp
