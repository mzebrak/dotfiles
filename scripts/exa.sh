#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

EXA_VERSION="${EXA_VERSION:=0.10.1}"

do_install() {
	if [[ "$(exa --version 2>/dev/null)" == *"${EXA_VERSION}"* ]]; then
		info "[exa] ${EXA_VERSION} already installed"
		return
	fi

	info "[exa] Installation of ${EXA_VERSION} stared..."
	local exa=/tmp/exa.zip
	download "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip" "${exa}"
	sudo unzip -q "${exa}" bin/exa -d /usr/local
	success "[exa] Installation done"
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
