#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

REPOS_DIR="/repos"
FONTS_DIR="$HOME/.local/share/fonts"

CORE_PACKAGES=(
	ack
	build-essential
	cmake
	curl
	fontconfig
	git-revise
	htop
	httpie
	jq
	ncurses-term
	neovim
	python3
	python3-pip
	python3-venv
	rsync
	shellcheck
	tldr
	unrar
	unzip
	wget
)

DESKTOP_PACKAGES=(
	dconf-editor
	gnome-tweaks
)

do_install() {
	do_install_core
	do_install_desktop
}

do_install_core() {
	info "[system] Installing core packages started..."
	export DEBIAN_FRONTEND=noninteractive
	sudo apt-add-repository -y ppa:neovim-ppa/stable
	sudo apt-get update -qq
	sudo apt-get install -qq -y "${CORE_PACKAGES[@]}"
	success "[system] Install core packages done"
}

do_install_desktop() {
	info "[system] Installing desktop packages started..."
	export DEBIAN_FRONTEND=noninteractive
	sudo apt-get install -qq -y "${DESKTOP_PACKAGES[@]}"
	success "[system] Install desktop packages done"
}

do_configure() {
	do_configure_core
	do_configure_desktop
}

do_configure_core() {
	info "[system][configure] Creating directories started..."
	info "[system][configure][directories] Repositories"
	sudo install -d -m 0755 -o "${USER}" -g "${USER}" "${REPOS_DIR}"

	info "[system][configure][directories] User binaries directory"
	install -d -m 0755 -o "${USER}" -g "${USER}" "$HOME/bin"
	success "[system][configure] Creating directories done"
}

do_configure_desktop() {
	info "[system][configure][directories] User Fonts"
	install -d -m 0755 -o "${USER}" -g "${USER}" "${FONTS_DIR}"

	# Font: MesloLGL Nerd Font Mono
	# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo/L/Regular/complete
	info "[system][configure] Installing patched fonts started..."
	local install_dir="/tmp/nerd-fonts"
	rm -rf "${install_dir}" && mkdir -p "${install_dir}"
	git clone -q --filter=blob:none --sparse "https://github.com/ryanoasis/nerd-fonts.git" "${install_dir}"
	(
		cd "${install_dir}"
		git sparse-checkout add patched-fonts/Meslo/L/Regular
		find . -type f -name '*.ttf' ! -name '*Windows*' -exec cp "{}" "${FONTS_DIR}" \;
	)
	sudo fc-cache -f
	success "[system][configure] Installing patched fonts done"
}

main() {
	command=$1
	case $command in
	"install")
		shift
		do_install "$@"
		;;
	"install-core")
		shift
		do_install_core "$@"
		;;
	"install-desktop")
		shift
		do_install_desktop "$@"
		;;
	"configure")
		shift
		do_configure "$@"
		;;
	"configure-core")
		shift
		do_configure_core "$@"
		;;
	"configure-desktop")
		shift
		do_configure_desktop "$@"
		;;
	*)
		error "$(basename "$0"): '$command' is not a valid command"
		;;
	esac
}

main "$@"
