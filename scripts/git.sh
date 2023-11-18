#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

DELTA_VERSION="${DELTA_VERSION:=0.16.5}"

do_configure() {
	info "[git][configure] Creating config file symlink started..."
	ln -fs "$(pwd)/git/gitconfig" "${HOME}/.gitconfig"
	success "[git][configure] Creating config file symlink done"

	info "[git][configure] Creating a commit-template file started..."
	touch "$(pwd)/git/commit-template"
	success "[git][configure] Creating a commit-template file done"

	info "[git][configure][delta] Delta installation started..."
	local delta=/tmp/delta.deb
	download "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" "${delta}"
	sudo dpkg -i "${delta}"
	success "[git][configre][delta] Installation done"

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
