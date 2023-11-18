#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

FZF_DIR="${HOME}/.fzf"

do_install() {
	if is_installed fzf; then
		info "[fzf] Already installed $(fzf --version). Updating..."
		(
			cd "${FZF_DIR}"
			git pull --quiet
			./install --bin
		)
		success "[fzf] Updating done"
		return
	fi

	info "[fzf] Installing started..."
	if [[ ! -d "${FZF_DIR}" ]]; then
		git clone --quiet --depth 1 https://github.com/junegunn/fzf.git "${FZF_DIR}"
		"${FZF_DIR}/install" --no-bash --no-fish --key-bindings --completion --no-update-rc
	fi
  success "[fzf] Installing done"
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
