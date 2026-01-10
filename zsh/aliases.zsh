alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias t="terminator"
alias gti="git"
alias l="exa --icons -Fg1"
alias ls="exa --icons -Fgx"
alias ll="exa --icons -Fgl"
alias llg="exa --icons -FglG"
alias la="exa --icons -Fgla"
alias lag="exa --icons -FglaG"
alias tree='exa --icons -FT'
alias e="xdg-open ."
alias c="clear"
alias cat="bat"
alias catt="bat --plain"
alias zz="z -"
alias fd="fdfind"
alias listen="lsof -i -P -n | grep LISTEN"
alias poelock="poetry lock --no-update"

# Docker container shortcuts
alias cexe="dexe clive"
alias wexe="dexe wax"
alias sexe="dexe schemas"

# dexe - docker execute
# Enter container interactively or run command from host.
# Usage:
#   dexe                - enter container shell
#   dexe clive          - enter clive project with venv (or use alias: cexe)
#   dexe clive pwd      - run command in clive from host
#   dexe clive uv run pytest  - run pytest via uv in clive
dexe() {
  local opts="-t"
  local env="export COLORTERM=truecolor TERM=xterm-256color"
  local shell='if command -v zsh >/dev/null; then zsh -l; else bash -l; fi'

  if [ $# -eq 0 ]; then
    ssh $opts docker "$env && $shell"
    return
  fi

  local project="$1"
  shift

  local init=""
  case "$project" in
    clive)   init="cd /workspace/clive && . venv/bin/activate" ;;
    wax)     init="cd /workspace/wax/python && . venv/bin/activate" ;;
    schemas) init="cd /workspace/schemas && . venv/bin/activate" ;;
    *)
      echo "Unknown project: $project"
      return 1
      ;;
  esac

  if [ $# -gt 0 ]; then
    ssh $opts docker "$env && $init && $*"
  else
    ssh $opts docker "$env && $init && $shell"
  fi
}
