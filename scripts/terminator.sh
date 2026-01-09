#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if terminator --version &>/dev/null; then
		info "[terminator] Already installed"
		return
	fi

	info "[terminator] Installation started..."
	sudo apt-get install -qq -y terminator
	success "[terminator] Installation done"
}

do_configure() {
	info "[terminator] Configuration started..."

	mkdir -p "${HOME}/.config/terminator"
	mkdir -p "${HOME}/.local/share/nautilus/scripts"
	mkdir -p "${HOME}/.config/nautilus"

	ln -fs "$(pwd)/terminator/config" "${HOME}/.config/terminator/config"
	ln -fs "$(pwd)/nautilus/Terminal" "${HOME}/.local/share/nautilus/scripts/Terminal"
	ln -fs "$(pwd)/nautilus/scripts-accels" "${HOME}/.config/nautilus/scripts-accels"

	success "[terminator] Configuration done"
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
