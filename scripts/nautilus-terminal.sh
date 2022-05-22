#!/bin/bash

set -euo pipefail

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

MIN_TERM_HEIGHT=15

do_install() {
  info "[nautilus-terminal] Installation started..."

  sudo apt-get install -qq -y python3-pip python3-nautilus python3-psutil
  python3 -m pip install --user --upgrade nautilus_terminal
  python3 -m nautilus_terminal --install-user

  success "[nautilus-terminal] Installation done"
}

do_configure() {
  info "[nautilus-terminal][configure] Configuring dconf settings of nautilus-terminal started..."

  info "[nautilus-terminal][configure] Applying MesloLGS NF Regular font ..."
  dconf write /org/flozz/nautilus-terminal/custom-font "'MesloLGS NF Regular'"

  info "[nautilus-terminal][configure] Applying terminal bottom..."
  dconf write /org/flozz/nautilus-terminal/terminal-bottom true

  info "[nautilus-terminal][configure] Applying minimum terminal height of ${MIN_TERM_HEIGHT}..."
  dconf write /org/flozz/nautilus-terminal/min-terminal-height "${MIN_TERM_HEIGHT}"

  info "[nautilus-terminal][configure] Configuring dconf settings of nautilus-terminal done"

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
