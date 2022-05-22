#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_configure() {
  info "[terminator][configure] Creating config file symlink started..."

  ln -fs "$(pwd)/terminator/config" "${HOME}/.config/terminator/config"
  ln -fs "$(pwd)/nautilus/Terminal" "${HOME}/.local/share/nautilus/scripts/Terminal"
  ln -fs "$(pwd)/nautilus/scripts-accels" "${HOME}/.config/nautilus/scripts-accels"

  success "[terminator][configure] Creating config file symlink done"
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
