#!/usr/bin/env zsh

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# remove prefix
zstyle ':fzf-tab:*' prefix ''

## Whether to automatically insert a space after the result.
zstyle ':fzf-tab:*' insert-space false

# The preview command used by fzf-tab (show file or directory contents on completion)
zstyle ':fzf-tab:complete:*:*' fzf-preview '(bat --color=always --pager=never ${realpath} || exa --icons -Fgla $realpath) 2>/dev/null'

zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# show systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# environment variable
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# git
zstyle ':fzf-tab:complete:git-*:*' fzf-preview 'git show $word'

test -f "${HOME}/.fzf.zsh" && source "${HOME}/.fzf.zsh"
