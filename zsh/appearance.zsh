autoload -U colors && colors # Enable colors and change prompt
setopt PROMPT_SUBST
typeset -A ALEX
ALEX[ITALIC_ON]=$'\e[3m'
ALEX[ITALIC_OFF]=$'\e[23m'
# Init timer and beam shape cursor before every cmd
preexec() { echo -ne '\e[5 q'; cmd_start=$(($(print -P %D{%s%6.})/1000)) }
precmd() { [ $cmd_start ] && { local cmd_end=$(($(print -P %D{%s%6.})/1000)); elapsed=$((cmd_end-cmd_start)) }}
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
PROMPT="$(shell_level)$bg_jobs$privileges$ret_status$rc "

local cwd="%F{109}%~%f"
# timer="%{$ALEX[ITALIC_ON]%}$elapsed ms%{$ALEX[ITALIC_OFF]%}"
local staged="" 
local unstaged="" 
local untracked="" 
# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return 0
  parse_git_status
  echo "$staged$unstaged$untracked$rc %F{cyan}%B${${ref:u}#REFS/HEADS/}%b%f"
}
# Check staged/unstaged/untracked
function parse_git_status() {
  local STATUS
  STATUS=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $STATUS == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}ﬨ";
  [[ $STATUS == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}ﬨ";
  [[ $STATUS == *\?* ]] && untracked="%{$fg_bold[blue]%}ﬨ";
}
RPROMPT='%F{222}%{$ALEX[ITALIC_ON]%}$elapsed ms%{$ALEX[ITALIC_OFF]%}%f $(git_prompt_info) $cwd$rc'
# RPROMPT="$timer $(git_prompt_info) $cwd$rc"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold
