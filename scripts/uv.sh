#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

UV_VERSION="${UV_VERSION:=0.9.24}"

do_install() {
	if uv --version &>/dev/null; then
		info "[uv] Already $(uv --version) installed"
		return
	fi

	info "[uv] Installation of ${UV_VERSION} started..."
	curl -LsSf "https://astral.sh/uv/${UV_VERSION}/install.sh" | sh
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
