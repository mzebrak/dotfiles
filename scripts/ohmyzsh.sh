#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${ZSH}/custom"

do_install() {
  if [[ -d "${ZSH}" ]]; then
    info "[ohmyzsh] Already installed"
    return
  fi

  info "[ohmyzsh] Installing started..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
  success "[ohmyzsh] Installing done"
}

do_configure() {
  info "[ohmyzsh][configure] Downloading plugins started..."
  declare -A plugins=(
    ["plugins/F-Sy-H"]="https://github.com/z-shell/F-Sy-H.git"
    ["plugins/zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
    ["plugins/zsh-completions"]="https://github.com/zsh-users/zsh-completions"
    ["plugins/fzf-tab"]="https://github.com/Aloxaf/fzf-tab"
    ["plugins/you-should-use"]="https://github.com/MichaelAquilina/zsh-you-should-use"
    ["plugins/zsh-docker-aliases"]="https://github.com/akarzim/zsh-docker-aliases.git"
    ["themes/powerlevel10k"]="https://github.com/romkatv/powerlevel10k"
  )
  for path in "${!plugins[@]}"; do
    if [[ ! -d "${ZSH_CUSTOM}/$path" ]]; then
      info "[ohmyzsh][configure] Cloning ${plugins[$path]} into ${ZSH_CUSTOM}/$path ..."
      git clone -q "${plugins[$path]}" "${ZSH_CUSTOM}/$path"
      success "[ohmyzsh][configure] ${plugins[$path]} successfully downloaded"
    else
      info "[ohmyzsh][configure] ${plugins[$path]} already exists, skipping..."
    fi
  done
  success "[ohmyzsh][configure] Downloading plugins done"

  info "[ohmyzsh][configure] Creating symlinks started..."
  ln -fs "$(pwd)/zsh/p10k.zsh" "${ZSH_CUSTOM}/p10k.zsh"
  ln -fs "$(pwd)/zsh/aliases.zsh" "${ZSH_CUSTOM}/aliases.zsh"
  ln -fs "$(pwd)/zsh/zshrc" "${HOME}/.zshrc"
  ln -fs "$(pwd)/zsh/zshenv" "${HOME}/.zshenv"
  success "[ohmyzsh][configure] Creating symlinks done"
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
