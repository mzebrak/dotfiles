#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if uv --version; then
		info "[uv] Already $(uv --version) installed"
		return
	fi

	info "[uv] Installation started..."
	curl -LsSf https://astral.sh/uv/install.sh | sh
	success "[uv] Installation done"
}

main() {
	command=$1
	case $command in
	"install")
		shift
		do_install "$@"
		;;
	*)
		error "$(basename "$0"): '$command' is not a valid command"
		;;
	esac
}

main "$@"
