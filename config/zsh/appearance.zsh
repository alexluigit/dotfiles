##-------------------------------------------------------------------##
#                         Syntax highlighting                         #
##-------------------------------------------------------------------##
typeset -A ALEX
ALEX[ITALIC_ON]=$'\e[3m'
ALEX[ITALIC_OFF]=$'\e[23m'
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold

##-------------------------------------------------------------------##
#                            Cursor shape                             #
##-------------------------------------------------------------------##
zle-line-init() { echo -ne "\e[5 q" } # zle -K viins, initiate `vi insert` as keymap
preexec_functions+=(zle-line-init) # Init timer and beam shape cursor before every cmd
zle -N zle-line-init # Enable cursor shape when entering zsh

##-------------------------------------------------------------------##
#                          Prompt basic info                          #
##-------------------------------------------------------------------##
# Handle shell level for X / tmux / tmux-auto / vim-term / su mode
shell_level() {
  local shlv=$SHLVL
  [[ -n "$TMUX" ]] && { shlv=$((shlv-1)); export ZLE_RPROMPT_INDENT=0 }
  [[ -n $(ps aux | grep '[.]/.tmux') ]] && shlv=$((shlv-1))
  [[ -n "$VIMRUNTIME" ]] && shlv=$((shlv-1))
  [[ -n "$(pidof Xorg)" ]] && shlv=$((shlv-1))
  [[ $(whoami) = "root" ]] && shlv=$((shlv-1))
  [[ $shlv -gt 1 ]] && echo "%F{yellow}%B[$shlv]%b%f " || echo ""
}
# Check background_job, super_user, exit code (Use ternary operators here)
local bg_jobs="%(1j.%{$fg_bold[magenta]%} .)"
local privileges="%(#.%{$fg_bold[red]%} .)"
local ret_status="%(?:%{$fg_bold[green]%} :%{$fg_bold[red]%} %s)"
PROMPT="$(shell_level)$bg_jobs$privileges$ret_status%{$reset_color%} "

##-------------------------------------------------------------------##
#                                 Git                                 #
##-------------------------------------------------------------------##
# Outputs current branch info
local staged unstaged untracked
git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return 0
  parse_git_status
  echo "$staged$unstaged$untracked %F{109}%B${${ref:u}#REFS/HEADS/}%b%f"
}
# Check staged/unstaged/untracked
parse_git_status() {
  local STATUS
  STATUS=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $STATUS == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}ﬨ";
  [[ $STATUS == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}ﬨ";
  [[ $STATUS == *\?* ]] && untracked="%{$fg_bold[blue]%}ﬨ";
}

##-------------------------------------------------------------------##
#                                Timer                                #
##-------------------------------------------------------------------##
# preexec() and precmd() are hook functions in zsh. (bash has precmd() but not preexec())
preexec_timer() { cmd_start=$(($(print -P %D{%s%6.})/1000)) }
precmd_timer() {
  [ $cmd_start ] && { local cmd_end=$(($(print -P %D{%s%6.})/1000)); \
  local time_ms=$((cmd_end-cmd_start))
  local time_sec=$(printf %.2f $(echo "$time_ms/1000" | bc -l))
  local time_min=$(printf %i $(echo "$time_sec/60" | bc -l))
  local time_min_tail=$(printf %i $(($time_sec-$time_min*60)))
  { [[ $time_sec -ge 1 ]] && [[ $time_min -eq 0 ]] } && timer_result="$time_sec sec" || timer_result="$time_ms ms"
  [[ $time_min -ge 1 ]] && timer_result="$time_min m $time_min_tail s"
  timer="%F{222}%{$ALEX[ITALIC_ON]%}$timer_result %{$ALEX[ITALIC_OFF]%}%f" }
}
preexec_functions+=(preexec_timer); precmd_functions+=(precmd_timer)

##-------------------------------------------------------------------##
#                              Nice PWD                               #
##-------------------------------------------------------------------##
# Seperate path with head and tail
chpwd_prompt () {
  local HPWD=${(%)${:-%~}} # $PWD with ~ abbreviations
  [[ $HPWD == *?/* ]] && { cwd_head="%F{223}%{$ALEX[ITALIC_ON]%}${HPWD%/*}/%{$ALEX[ITALIC_OFF]%}%f" \
  cwd_tail="%F{white}%B${HPWD##*/}%b%f" } || { cwd_head="%F{white}%B$HPWD%b%f"; cwd_tail="" }
}
RPROMPT='$timer $(git_prompt_info) $cwd_head$cwd_tail'
# chpwd_functions are hook funcs that will be exec after pwd change
# Add to chpwd hook and trigger the chpwd hooks once, this line should appear after the prompt definition
chpwd_functions+=(chpwd_prompt); cd .
