#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

NODE_VERSION="${NODE_VERSION:=v24.12.0}"

do_install() {
	if ! command -v fnm &>/dev/null; then
		error "[node] fnm not found, install fnm first"
		return 1
	fi

	if node --version &>/dev/null; then
		info "[node] Already $(node --version) installed"
		return
	fi

	info "[node] Installation of Node.js ${NODE_VERSION} started..."
	fnm install "${NODE_VERSION}"
	fnm default "${NODE_VERSION}"
	eval "$(fnm env --shell bash)"
	success "[node] Installation done: $(node --version)"
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
