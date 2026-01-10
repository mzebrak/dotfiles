#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

FZF_VERSION="${FZF_VERSION:=0.67.0}"
FZF_DIR="${HOME}/.fzf"

do_install() {
	if fzf --version &>/dev/null; then
		info "[fzf] Already $(fzf --version | cut -d' ' -f1) installed"
		return
	fi

	info "[fzf] Installation of ${FZF_VERSION} started..."
	git clone --quiet --depth 1 --branch "v${FZF_VERSION}" https://github.com/junegunn/fzf.git "${FZF_DIR}"
	"${FZF_DIR}/install" --no-bash --no-fish --key-bindings --completion --no-update-rc
	success "[fzf] Installation done"
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
