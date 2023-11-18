include test.mk

.DEFAULT_GOAL := all
.PHONY: git

all: system git terminal nautilus-terminal tools  ## Install and configure everything (default)
testable: system git terminal nautilus-terminal-install tools  ## Install and configure everything that could be tested
help: ## Display help
	@grep -hE '^[a-zA-Z_0-9%-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

system: system-install system-configure ## Install and configure
system-install: ## Install system packages
	@./scripts/system.sh install
system-configure: ## Create directories, install fonts, etc.
	@./scripts/system.sh configure

git: ## Configure git
	@./scripts/git.sh configure

terminal: zsh ohmyzsh fzf terminator## Setup the terminal
zsh: ## Configure zsh
	@./scripts/zsh.sh configure
ohmyzsh: ohmyzsh-install ohmyzsh-configure ## Install and configure Oh My Zsh
ohmyzsh-install: ## Install Oh My Zsh
	@./scripts/ohmyzsh.sh install
ohmyzsh-configure: ## Configure Oh My Zsh
	@./scripts/ohmyzsh.sh configure
fzf: ## Install FZF
	@./scripts/fzf.sh install
terminator: ## Configure Terminator
	@./scripts/terminator.sh configure
nautilus-terminal: nautilus-terminal-install nautilus-terminal-configure ## Install and configure nautilus-terminal
nautilus-terminal-install: ## install nautilus-terminal
	@./scripts/nautilus-terminal.sh install
nautilus-terminal-configure: ## Configure nautilus-terminal
	@./scripts/nautilus-terminal.sh configure

tools: exa bat fd zoxide
exa: ## Install exa
	@./scripts/exa.sh install
bat: bat-install bat-configure ## Install and configure bat
bat-install: ## Install bat
	@./scripts/bat.sh install
bat-configure: ## Configure bat
	@./scripts/bat.sh configure
zoxide: ## Install zoxide
	@./scripts/zoxide.sh install
