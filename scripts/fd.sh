#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if fdfind --version &>/dev/null; then
		info "[fd] Already $(fdfind --version | head -1) installed"
		return
	fi

	info "[fd] Installation started..."
	sudo apt-get install -qq -y fd-find
	success "[fd] Installation done"
}

do_configure() {
	info "[fd] Configuration started..."
	mkdir -p "${HOME}/.config/fd/"
	ln -fs "$(pwd)/fd/ignore" "${HOME}/.config/fd/ignore"
	success "[fd] Configuration done"
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
