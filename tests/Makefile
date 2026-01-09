test: build ## Run tests in Docker
	docker rm -f dotfiles-test || true
	docker run -t --name dotfiles-test dotfiles/test bash -c "make core && ./tests/verify.sh core"

build: ## Build docker image
	docker build -t dotfiles/test -f tests/Dockerfile .

verify: ## Verify all (desktop)
	@./tests/verify.sh all

verify-core: ## Verify core only
	@./tests/verify.sh core

verify-addons: ## Verify addons
	@./tests/verify.sh addons
