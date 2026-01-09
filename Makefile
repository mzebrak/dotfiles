include tests/Makefile

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
git: git-install git-configure ## Install and configure git
git-install: ## Install git
	@./scripts/git.sh install
git-configure: ## Configure git
	@./scripts/git.sh configure

# Terminal
terminal: terminal-core terminator ## Setup terminal
terminal-core: zsh ohmyzsh fzf tmux ## Setup terminal (core)
zsh: zsh-install zsh-configure ## Install and configure zsh
zsh-install: ## Install zsh
	@./scripts/zsh.sh install
zsh-configure: ## Configure zsh
	@./scripts/zsh.sh configure
ohmyzsh: ohmyzsh-install ohmyzsh-configure ## Install and configure Oh My Zsh
ohmyzsh-install: ## Install Oh My Zsh
	@./scripts/ohmyzsh.sh install
ohmyzsh-configure: ## Configure Oh My Zsh
	@./scripts/ohmyzsh.sh configure
fzf: ## Install FZF
	@./scripts/fzf.sh install
tmux: tmux-install tmux-configure ## Install and configure tmux
tmux-install: ## Install tmux
	@./scripts/tmux.sh install
tmux-configure: ## Configure tmux
	@./scripts/tmux.sh configure
terminator: terminator-install terminator-configure ## Install and configure Terminator
terminator-install: ## Install Terminator
	@./scripts/terminator.sh install
terminator-configure: ## Configure Terminator
	@./scripts/terminator.sh configure

# Tools
tools: exa bat fd delta zoxide uv nvm claude-code
exa: ## Install exa
	@./scripts/exa.sh install
bat: bat-install bat-configure ## Install and configure bat
bat-install: ## Install bat
	@./scripts/bat.sh install
bat-configure: ## Configure bat
	@./scripts/bat.sh configure
fd: fd-install fd-configure ## Install and configure fd
fd-install: ## Install fd
	@./scripts/fd.sh install
fd-configure: ## Configure fd
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
claude-code: ## Install Claude Code
	@./scripts/claude-code.sh install

# Addons (optional, run manually)
nautilus-terminal: nautilus-terminal-install nautilus-terminal-configure ## Addon: nautilus-terminal
nautilus-terminal-install: ## Install nautilus-terminal
	@./scripts/nautilus-terminal.sh install
nautilus-terminal-configure: ## Configure nautilus-terminal
	@./scripts/nautilus-terminal.sh configure
claude-code-statusline: nvm ## Addon: ccstatusline (requires nvm)
	@./scripts/claude-code.sh statusline
