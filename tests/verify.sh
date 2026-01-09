#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

FAILED=0

check_command() {
	local name="$1"
	local cmd="$2"
	local output

	if output=$(eval "$cmd" 2>&1 | head -1); then
		success "[verify] $name: $output"
	else
		error "[verify] $name: FAILED"
		FAILED=$((FAILED + 1))
	fi
}

check_command_optional() {
	local name="$1"
	local cmd="$2"
	local output

	if output=$(eval "$cmd" 2>&1 | head -1); then
		success "[verify] $name: $output"
	else
		warn "[verify] $name: not installed (optional)"
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
	info "[verify] Checking system tools versions..."
	check_command "zsh" "zsh --version"
	check_command "git" "git --version"
	check_command "curl" "curl -V | head -1 | cut -d' ' -f1-2"
	check_command "vim" "vim --version"
	check_command "tmux" "tmux -V"
	echo

	# Installed tools
	info "[verify] Checking installed tools versions..."
	check_command "bat" "bat --version"
	check_command "fd" "fdfind --version"
	check_command "fzf" "fzf --version"
	check_command "zoxide" "zoxide --version"
	check_command "delta" "delta --version"
	check_command "exa" "exa --version | head -2 | tail -1"
	check_command "uv" "uv --version"
	check_command "claude" "claude --version"
	echo

	# Config files (core)
	info "[verify] Checking config files (symlinks)..."
	check_file "gitconfig" "${HOME}/.gitconfig"
	check_file "zshrc" "${HOME}/.zshrc"
	check_file "bat config" "${HOME}/.config/bat/config"
	echo

	# Oh-My-Zsh
	info "[verify] Checking Oh-My-Zsh installation..."
	check_file "oh-my-zsh" "${HOME}/.oh-my-zsh/oh-my-zsh.sh"
	check_file "powerlevel10k" "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
	echo
}

do_verify_desktop() {
	info "[verify] === DESKTOP ==="
	echo

	# Desktop config files
	info "[verify] Checking desktop config files (symlinks)..."
	check_file "terminator config" "${HOME}/.config/terminator/config"
	echo
}

do_verify() {
	info "[verify] === CORE ==="
	echo
	do_verify_core
	do_verify_desktop
	print_summary
}

print_summary() {
	if [[ $FAILED -eq 0 ]]; then
		success "[verify] All checks passed!"
	else
		error "[verify] $FAILED check(s) failed!"
		exit 1
	fi
}

do_verify_addons() {
	info "[verify] === ADDONS ==="
	echo

	info "[verify] Checking addons versions..."
	# ccstatusline addon (requires nvm/node)
	check_command_optional "node" "node --version"
	check_command_optional "npm" "npm --version"
	check_command_optional "ccstatusline" "npm list -g ccstatusline 2>/dev/null | grep ccstatusline | sed 's/.*@//'"
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
