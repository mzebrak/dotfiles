#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_configure() {
  info "[tig][configure] Creating config file symlink started..."
  ln -fs "$(pwd)/tig/tigrc" "${HOME}/.tigrc"
  success "[tig][configure] Creating config file symlink done"
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
