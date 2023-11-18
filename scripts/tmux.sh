#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_configure() {
	info "[tmux][configure] Downloading tpm plugin manager started..."
	if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
		git clone --quiet https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
	fi
	success "[tmux][configure] Downloading tpm plugin manager done"

	info "[tmux][configure] Creating config file symlink started..."
	ln -fs "$(pwd)/tmux/tmux.conf" "${HOME}/.tmux.conf"
	success "[tmux][configure] Creating config file symlink done"
}

main() {
	command=$1
	case $command in
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
