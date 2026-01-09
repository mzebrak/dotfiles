#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

FAILED=0

check_command() {
	local name="$1"
	local cmd="$2"

	if eval "$cmd" &>/dev/null; then
		success "[verify] $name: OK"
	else
		error "[verify] $name: FAILED"
		FAILED=$((FAILED + 1))
	fi
}

check_file() {
	local name="$1"
	local file="$2"

	if [[ -f $file ]] || [[ -L $file ]]; then
		success "[verify] $name: OK"
	else
		error "[verify] $name: FAILED (file not found: $file)"
		FAILED=$((FAILED + 1))
	fi
}

do_verify_core() {
	info "[verify] Starting core verification..."
	echo

	# System tools
	info "[verify] Checking system tools..."
	check_command "zsh" "zsh --version"
	check_command "git" "git --version"
	check_command "curl" "curl --version"
	check_command "vim" "vim --version"
	check_command "tmux" "tmux -V"
	echo

	# Installed tools
	info "[verify] Checking installed tools..."
	check_command "bat" "bat --version"
	check_command "fd" "fdfind --version"
	check_command "fzf" "fzf --version"
	check_command "zoxide" "zoxide --version"
	check_command "delta" "delta --version"
	check_command "exa" "exa --version"
	check_command "uv" "uv --version"
	check_command "claude" "claude --version"
	echo

	# Config files (core)
	info "[verify] Checking config files..."
	check_file "gitconfig" "${HOME}/.gitconfig"
	check_file "zshrc" "${HOME}/.zshrc"
	check_file "bat config" "${HOME}/.config/bat/config"
	check_file "claude-code config" "${HOME}/.claude.json"
	echo

	# Oh-My-Zsh
	info "[verify] Checking Oh-My-Zsh..."
	check_file "oh-my-zsh" "${HOME}/.oh-my-zsh/oh-my-zsh.sh"
	check_file "powerlevel10k" "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
	echo

	# Summary
	if [[ $FAILED -eq 0 ]]; then
		success "[verify] All checks passed!"
	else
		error "[verify] $FAILED check(s) failed!"
		exit 1
	fi
}

do_verify() {
	do_verify_core

	# Desktop config files
	info "[verify] Checking desktop config files..."
	check_file "terminator config" "${HOME}/.config/terminator/config"
	echo

	# Summary
	if [[ $FAILED -eq 0 ]]; then
		success "[verify] All checks passed!"
	else
		error "[verify] $FAILED check(s) failed!"
		exit 1
	fi
}

do_verify_addons() {
	info "[verify] Checking addons..."
	echo

	# ccstatusline addon (requires nvm/node)
	check_command "node" "node --version" || true
	check_command "npm" "npm --version" || true
	check_command "ccstatusline" "ccstatusline --version" || true
	check_file "ccstatusline config" "${HOME}/.config/ccstatusline/settings.json" || true
	echo
}

main() {
	command=${1:-"all"}
	case $command in
	"all")
		do_verify
		;;
	"core")
		do_verify_core
		;;
	"addons")
		do_verify_addons
		;;
	*)
		error "$(basename "$0"): '$command' is not a valid command"
		;;
	esac
}

main "$@"
