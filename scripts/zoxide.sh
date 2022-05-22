#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if zoxide --version; then
		info "[zoxide] Already $(zoxide --version) installed"
		return
	fi

	info "[zoxide] Installation stared..."
	curl -sS https://webinstall.dev/zoxide | bash
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
