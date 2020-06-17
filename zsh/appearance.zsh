autoload -U colors && colors # Enable colors and change prompt
setopt PROMPT_SUBST
# Handle shell level for no-tmux, default-tmux, tmux-automation sessions
function shell_level() { 
  local shlv
  [[ -z "$TMUX" ]] &&  shlv=$SHLVL || \
  { export ZLE_RPROMPT_INDENT=0; [[ -z $(ps aux | grep '[.]/.tmux') ]] && \
  shlv=$(($SHLVL - 1)) || shlv=$(($SHLVL - 2)) };
  [[ shlv -gt 1 ]] && echo "[$shlv] " || echo ""
}
local bg_jobs="%(1j.%{$fg_bold[yellow]%} .)"
local privileges="%(#.%{$fg_bold[yellow]%} .)"
local ret_status="%(?:%{$fg_bold[green]%} :%{$fg_bold[red]%} %s)"
local rc="%{$reset_color%}"
PROMPT='$(shell_level)$bg_jobs$privileges$ret_status$rc '

local cwd="%F{109}%~%f"
local staged="" 
local unstaged="" 
local untracked="" 
# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return 0
  parse_git_status
  echo "$staged$unstaged$untracked$rc %F{green}%B${${ref:u}#REFS/HEADS/}%b%f"
}
# Check staged/unstaged/untracked
function parse_git_status() {
  local STATUS
  STATUS=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $STATUS == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}ﬨ";
  [[ $STATUS == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}ﬨ";
  [[ $STATUS == *\?* ]] && untracked="%{$fg_bold[blue]%}ﬨ";
}
RPROMPT='$(git_prompt_info) $cwd$rc'

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold
