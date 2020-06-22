# Meta syntax
autoload -U colors && colors # Enable colors and change prompt
setopt PROMPT_SUBST
typeset -A ALEX
ALEX[ITALIC_ON]=$'\e[3m'
ALEX[ITALIC_OFF]=$'\e[23m'
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold
# Handle shell level for no-tmux, default-tmux, tmux-automation sessions
function shell_level() { 
  local shlv
  [[ -z "$TMUX" ]] &&  shlv=$SHLVL || \
  { export ZLE_RPROMPT_INDENT=0; [[ -z $(ps aux | grep '[.]/.tmux') ]] && \
  shlv=$(($SHLVL - 1)) || shlv=$(($SHLVL - 2)) };
  [[ shlv -gt 1 ]] && echo "%F{yellow}%B[$shlv]%b%f " || echo ""
}
# Check background_job, super_user, exit code (Use ternary operators here)
local bg_jobs="%(1j.%{$fg_bold[magenta]%} .)"
local privileges="%(#.%{$fg_bold[red]%} .)"
local ret_status="%(?:%{$fg_bold[cyan]%} :%{$fg_bold[red]%} %s)"
PROMPT="$(shell_level)$bg_jobs$privileges$ret_status%{$reset_color%} "
# Outputs current branch info in prompt format
local staged unstaged untracked
function git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return 0
  parse_git_status
  echo "$staged$unstaged$untracked %F{cyan}%B${${ref:u}#REFS/HEADS/}%b%f"
}
# Check staged/unstaged/untracked
function parse_git_status() {
  local STATUS
  STATUS=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $STATUS == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}ﬨ";
  [[ $STATUS == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}ﬨ";
  [[ $STATUS == *\?* ]] && untracked="%{$fg_bold[blue]%}ﬨ";
}
# Init timer and beam shape cursor before every cmd 
# NOTE: preexec() and precmd() are hook functions in zsh. (bash has precmd() but not preexec())
preexec() { echo -ne '\e[5 q'; cmd_start=$(($(print -P %D{%s%6.})/1000)) }
precmd() { 
  [ $cmd_start ] && { local cmd_end=$(($(print -P %D{%s%6.})/1000)); \
  timer="%F{222}%{$ALEX[ITALIC_ON]%}$((cmd_end-cmd_start)) ms%{$ALEX[ITALIC_OFF]%}%f" }
}
RPROMPT='$timer $(git_prompt_info) $cwd_head$cwd_tail'
# Seperate path with head and tail
function chpwd_prompt () {
  local HPWD=${(%)${:-%~}} # $PWD with ~ abbreviations
  [[ $HPWD == *?/* ]] && { cwd_head="%F{109}%{$ALEX[ITALIC_ON]%}${HPWD%/*}/%{$ALEX[ITALIC_OFF]%}%f" \
  cwd_tail="%F{109}%B${HPWD##*/}%b%f" } || { cwd_head="%F{109}%B$HPWD%b%f"; cwd_tail="" }
}
# NOTE: chpwd_functions are hook funcs that will exec after pwd change  
# Add to chpwd hook and trigger the chpwd hooks once, this line should appear after the prompt definition
chpwd_functions+=(chpwd_prompt); cd .
