#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

NVM_DIR="${HOME}/.nvm"

do_install() {
	if [[ -d "${NVM_DIR}" ]]; then
		info "[nvm] Already installed"
		return
	fi

	info "[nvm] Installation started..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
	success "[nvm] Installation done"
}

do_configure() {
	info "[nvm] Configuration started..."

	# Source nvm
	export NVM_DIR="${HOME}/.nvm"
	# shellcheck source=/dev/null
	[[ -s "${NVM_DIR}/nvm.sh" ]] && source "${NVM_DIR}/nvm.sh"

	# Install latest LTS node
	if command -v nvm &>/dev/null; then
		info "[nvm] Installing latest LTS Node.js..."
		nvm install --lts
		nvm use --lts
		nvm alias default 'lts/*'
		success "[nvm] Node.js LTS installed: $(node --version)"
	else
		error "[nvm] nvm not found, run install first"
	fi

	success "[nvm] Configuration done"
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
