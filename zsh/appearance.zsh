# TODO add display element for superuser, nested shell
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
local bg_jobs="%(1j.%{$fg_bold[yellow]%}! .)"
PROMPT='$ret_status $bg_jobs%{$reset_color%}%{$fg_bold[cyan]%}${PWD/#$HOME/~}  '

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "$(parse_git_dirty)$PROMPT_PREFIX${ref#refs/heads/}$PROMPT_SUFFIX"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS
  STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo "$PROMPT_DIRTY"
  else
    echo "$PROMPT_CLEAN"
  fi
}

setopt PROMPT_SUBST
RPROMPT='$(git_prompt_info)%{$reset_color%}'

PROMPT_PREFIX=" "
PROMPT_SUFFIX="%{$reset_color%}"
PROMPT_DIRTY=" %{$fg[magenta]%} "
PROMPT_CLEAN=" %{$fg[blue]%} "

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold
