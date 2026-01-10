#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

FNM_VERSION="${FNM_VERSION:=v1.38.1}"

do_install() {
	if fnm --version &>/dev/null; then
		info "[fnm] Already $(fnm --version) installed"
		return
	fi

	info "[fnm] Installation of ${FNM_VERSION} started..."
	curl -fsSL https://fnm.vercel.app/install | bash -s -- -r "${FNM_VERSION}" --skip-shell
	success "[fnm] Installation done"
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
