#!/bin/bash

set -euo pipefail

ICON="docker"
sed -i "s/POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=.*/POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='${ICON}'/" ~/dotfiles/zsh/p10k.zsh
echo "Set icon to: ${ICON}"
