autoload -U colors && colors # Enable colors and change prompt
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
PROMPT_DIRTY=" %{$fg[red]%} "
PROMPT_CLEAN=" %{$fg[blue]%} "

# -------------------------------- Cursor shape ----------------------------------
zle-line-init() {
    # zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}
# --------------------------------------------------------------------------------
