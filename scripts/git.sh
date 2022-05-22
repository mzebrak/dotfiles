#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

do_configure() {
  info "[git][configure] Creating config file symlink started..."
  ln -fs "$(pwd)/git/gitconfig" "${HOME}/.gitconfig"
  success "[git][configure] Creating config file symlink done"

  info "[git][configure] Creating a commit-template file started..."
  touch "$(pwd)/git/commit-template"
  success "[git][configure] Creating a commit-template file done"
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
