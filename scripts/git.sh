#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_install() {
	if git --version &>/dev/null; then
		info "[git] Already $(git --version) installed"
		return
	fi

	info "[git] Installation started..."
	sudo apt-add-repository -y ppa:git-core/ppa
	sudo apt-get update -qq
	sudo apt-get install -qq -y git
	success "[git] Installation done"
}

do_configure() {
	info "[git] Configuration started..."
	ln -fs "$(pwd)/git/gitconfig" "${HOME}/.gitconfig"
	touch "$(pwd)/git/commit-template"
	success "[git] Configuration done"
}

main() {
	command=$1
	case $command in
	"install")
		shift
		do_install "$@"
		;;
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
