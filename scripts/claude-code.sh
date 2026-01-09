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
	mkdir -p "${HOME}/.claude"
	ln -fs "$(pwd)/claude-code/settings.json" "${HOME}/.claude/settings.json"
	success "[claude-code] Configuration done"
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
	*)
		error "$(basename "$0"): '$command' is not a valid command"
		;;
	esac
}

main "$@"
