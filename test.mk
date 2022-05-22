test: build ## Run tests
	docker rm -f dotfiles-test
	docker run -t --name dotfiles-test dotfiles/test make testable

build: ## Build a docker image
	docker build -t dotfiles/test .
