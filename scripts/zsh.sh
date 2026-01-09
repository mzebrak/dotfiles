#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if zsh --version &>/dev/null; then
		info "[zsh] Already $(zsh --version) installed"
		return
	fi

	info "[zsh] Installation started..."
	sudo apt-get install -qq -y zsh
	success "[zsh] Installation done"
}

do_configure() {
	info "[zsh] Configuration started..."
	sudo chsh -s "$(which zsh)" "$USER"
	success "[zsh] Configuration done"
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
