#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if claude --version; then
		info "[claude-code] Already $(claude --version) installed"
		return
	fi

	info "[claude-code] Installation started..."
	curl -fsSL https://claude.ai/install.sh | sh
	success "[claude-code] Installation done"
}

do_configure() {
	info "[claude-code] Configuration started..."
	ln -fs "$(pwd)/claude-code/settings.json" "${HOME}/.claude.json"
	success "[claude-code] Configuration done"
}

do_statusline() {
	info "[claude-code] Statusline setup started..."

	# Check if npm is available
	if ! command -v npm &>/dev/null; then
		error "[claude-code] npm not found, install nvm/node first"
		return 1
	fi

	# Install ccstatusline globally
	info "[claude-code] Installing ccstatusline..."
	npm install -g ccstatusline@latest

	# Link ccstatusline config
	mkdir -p "${HOME}/.config/ccstatusline"
	ln -fs "$(pwd)/claude-code/ccstatusline.json" "${HOME}/.config/ccstatusline/settings.json"

	success "[claude-code] Statusline setup done"
}

main() {
	command=$1
	case $command in
	"install")
		shift
		do_install "$@"
		;;
	"configure")
		shift
		do_configure "$@"
		;;
	"statusline")
		shift
		do_statusline "$@"
		;;
	*)
		error "$(basename "$0"): '$command' is not a valid command"
		;;
	esac
}

main "$@"
