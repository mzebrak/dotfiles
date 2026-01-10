#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

DELTA_VERSION="${DELTA_VERSION:=0.18.2}"

do_install() {
	if delta --version &>/dev/null; then
		info "[delta] Already $(delta --version | head -1) installed"
		return
	fi

	info "[delta] Installation of ${DELTA_VERSION} started..."
	local tmp_deb="/tmp/git-delta_${DELTA_VERSION}_amd64.deb"
	curl -sL "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -o "${tmp_deb}"
	sudo dpkg -i "${tmp_deb}"
	rm -f "${tmp_deb}"
	success "[delta] Installation done"
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
