#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_configure() {
	info "[fd][configure] Creating config file symlink started..."

	mkdir -p "${HOME}/.config/fd/"
	ln -fs "$(pwd)/fd/ignore" "${HOME}/.config/fd/ignore"

	success "[fd][configure] Creating config file symlink done"
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
