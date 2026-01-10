# [mzebrak's](https://github.com/mzebrak) dotfiles

[![Build Status](https://github.com/mzebrak/dotfiles/actions/workflows/test.yaml/badge.svg)](https://github.com/mzebrak/dotfiles/actions/workflows/test.yaml)

Personal dotfiles for Ubuntu/Pop!_OS. Automated setup for development environment.

## Table of Contents

- [Installation](#installation)
- [Testing](#testing)
- [What's included](#whats-included)
  - [System](#system)
  - [Git](#git)
  - [Terminal](#terminal)
  - [Tools](#tools)
  - [Addons](#addons)
- [Customization](#customization)
  - [Font](#font)
  - [Powerlevel10k](#powerlevel10k)
  - [Zsh plugins](#zsh-plugins)
  - [Open terminal in Nautilus](#open-terminal-in-nautilus)

---

## Installation

```bash
make all      # Full install (desktop)
make core     # Core only (no GUI)
make help     # Show all available targets
```

## Testing

```bash
make test          # Run tests in Docker container
make verify        # Verify installation (desktop)
make verify-core   # Verify installation (core only)
```

## What's included

### System
`make system`

| Package | Description |
|---------|-------------|
| ack | Code search tool |
| build-essential | C/C++ compiler and build tools |
| cmake | Cross-platform build system |
| curl, wget | Download utilities |
| fontconfig | Font configuration |
| git-revise | Rebase alternative for git |
| htop | Interactive process viewer |
| httpie | User-friendly HTTP client |
| jq | JSON processor |
| ncurses-term | Terminal type definitions |
| neovim | Modern vim editor |
| python3, pip, venv | Python with package manager |
| rsync | File synchronization |
| shellcheck | Shell script linter |
| tldr | Simplified man pages |
| unrar, unzip | Archive extraction |

**Desktop only:** gnome-tweaks, dconf-editor

### Git
`make git`

Latest version installed via PPA:
```bash
sudo add-apt-repository ppa:git-core/ppa -y
```

### Terminal
`make terminal`

| Tool | Description |
|------|-------------|
| zsh | Shell |
| [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) | Zsh framework |
| [powerlevel10k](https://github.com/romkatv/powerlevel10k) | Zsh theme |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| terminator | Terminal emulator (desktop only) |

### Tools
`make tools`

| Tool | Description |
|------|-------------|
| [bat](https://github.com/sharkdp/bat) | Modern `cat` replacement |
| [claude-code](https://claude.ai/code) | Claude Code CLI |
| [delta](https://github.com/dandavison/delta) | Git diff viewer |
| [exa](https://github.com/ogham/exa) | Modern `ls` replacement |
| [fd](https://github.com/sharkdp/fd) | Modern `find` replacement |
| [fnm](https://github.com/Schniz/fnm) | Fast Node Manager |
| [node](https://nodejs.org/) | Node.js (installed via fnm) |
| [poetry](https://python-poetry.org/) | Python dependency manager |
| [uv](https://github.com/astral-sh/uv) | Fast Python package manager |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` command |

### Addons
Optional, run manually.

| Addon | Command |
|-------|---------|
| claude-code-statusline | `make claude-code-statusline` |

---

## Customization

### Font
Terminal & PyCharm font: **MesloLGL Nerd Font Mono** (installed by `make system-configure`)

### Powerlevel10k
OS icon can be changed in `zsh/p10k.zsh`:
```bash
POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='home'
```

### Zsh plugins
Plugins are configured in [`scripts/ohmyzsh.sh`](scripts/ohmyzsh.sh) and installed to `~/.oh-my-zsh/custom/plugins/`.

More plugins: [ohmyzsh/plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/plugins)

### Open terminal in Nautilus
Automatically configured by `make terminator`. Press F12 in Nautilus to open Terminator, or right-click → Open In Terminal.

> **Note:** Does not work on Ubuntu 20.10 (Nautilus 3.38). Source: [askubuntu.com](https://askubuntu.com/a/1079882)
