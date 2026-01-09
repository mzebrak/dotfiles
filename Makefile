include tests/test.mk

.DEFAULT_GOAL := all
.PHONY: git

# Main targets
all: system git terminal tools  ## Install everything (desktop)
core: system-core git terminal-core tools  ## Install core only (no GUI)

help: ## Display help
	@grep -hE '^[a-zA-Z_0-9%-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# System packages
system: system-install system-configure ## Install and configure system
system-core: system-install-core system-configure-core ## Install and configure system (core)
system-install: ## Install all system packages
	@./scripts/system.sh install
system-install-core: ## Install core system packages
	@./scripts/system.sh install-core
system-configure: ## Configure system (directories, fonts)
	@./scripts/system.sh configure
system-configure-core: ## Configure system (directories)
	@./scripts/system.sh configure-core

# Git
git: ## Configure git
	@./scripts/git.sh configure

# Terminal
terminal: terminal-core terminator ## Setup terminal
terminal-core: zsh ohmyzsh fzf tmux ## Setup terminal (core)
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
tmux: ## Configure tmux
	@./scripts/tmux.sh configure

# Tools
tools: exa bat fd delta zoxide uv nvm claude-code
exa: ## Install exa
	@./scripts/exa.sh install
bat: bat-install bat-configure ## Install and configure bat
bat-install: ## Install bat
	@./scripts/bat.sh install
bat-configure: ## Configure bat
	@./scripts/bat.sh configure
fd: ## Configure fd
	@./scripts/fd.sh configure
delta: ## Install delta (git diff viewer)
	@./scripts/delta.sh install
zoxide: ## Install zoxide
	@./scripts/zoxide.sh install
uv: ## Install uv
	@./scripts/uv.sh install
nvm: nvm-install nvm-configure ## Install nvm and Node.js LTS
nvm-install: ## Install nvm
	@./scripts/nvm.sh install
nvm-configure: ## Install Node.js LTS
	@./scripts/nvm.sh configure
claude-code: claude-code-install claude-code-configure ## Install and configure Claude Code
claude-code-install: ## Install Claude Code
	@./scripts/claude-code.sh install
claude-code-configure: ## Configure Claude Code
	@./scripts/claude-code.sh configure

# Addons (optional, run manually)
nautilus-terminal: nautilus-terminal-install nautilus-terminal-configure ## Addon: nautilus-terminal
nautilus-terminal-install: ## Install nautilus-terminal
	@./scripts/nautilus-terminal.sh install
nautilus-terminal-configure: ## Configure nautilus-terminal
	@./scripts/nautilus-terminal.sh configure
claude-code-statusline: nvm ## Addon: ccstatusline (requires nvm)
	@./scripts/claude-code.sh statusline
