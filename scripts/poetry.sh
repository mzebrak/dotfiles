#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

POETRY_VERSION="${POETRY_VERSION:=2.1.3}"

do_install() {
	if poetry --version &>/dev/null; then
		info "[poetry] Already $(poetry --version) installed"
		return
	fi

	info "[poetry] Installation of ${POETRY_VERSION} started..."
	curl -sSL https://install.python-poetry.org | python3 - --version "${POETRY_VERSION}"
	success "[poetry] Installation done"
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
