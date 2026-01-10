#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

ZOXIDE_VERSION="${ZOXIDE_VERSION:=0.9.8}"

do_install() {
	if zoxide --version &>/dev/null; then
		info "[zoxide] Already $(zoxide --version) installed"
		return
	fi

	info "[zoxide] Installation of ${ZOXIDE_VERSION} started..."
	curl -sSfL "https://raw.githubusercontent.com/ajeetdsouza/zoxide/refs/tags/v${ZOXIDE_VERSION}/install.sh" | sh
	success "[zoxide] Installation done"
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
