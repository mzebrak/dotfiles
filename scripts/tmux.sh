#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if tmux -V &>/dev/null; then
		info "[tmux] Already $(tmux -V) installed"
		return
	fi

	info "[tmux] Installation started..."
	sudo apt-get install -qq -y tmux
	success "[tmux] Installation done"
}

do_configure() {
	info "[tmux] Configuration started..."

	if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
		info "[tmux] Downloading tpm plugin manager..."
		git clone --quiet https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
	fi

	ln -fs "$(pwd)/tmux/tmux.conf" "${HOME}/.tmux.conf"
	success "[tmux] Configuration done"
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
