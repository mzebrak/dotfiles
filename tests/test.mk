test: build ## Run tests in Docker
	docker rm -f dotfiles-test || true
	docker run -t --name dotfiles-test dotfiles/test make testable verify

test-local: ## Run verification on local system (no install)
	@./tests/verify.sh all

verify: ## Verify all installations
	@./tests/verify.sh all

verify-optional: ## Verify optional tools (ccstatusline addon)
	@./tests/verify.sh optional

build: ## Build a docker image
	docker build -t dotfiles/test -f tests/Dockerfile .
