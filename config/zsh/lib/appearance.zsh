# Syntax highlighting
autoload -U colors && colors # Enable colors
italicize() { printf "%b%s%b" '\e[3m' "$@" '\e[23m' }
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold

# Cursor shape
zle-line-init() { echo -ne "\e[5 q" } # zle -K viins, initiate `vi insert` as keymap
preexec_functions+=(zle-line-init) # Init timer and beam shape cursor before every cmd
zle -N zle-line-init # Enable cursor shape when entering zsh
zle-keymap-select() { # Change cursor shape for different vi modes.
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[3 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] \
       || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Git
local staged unstaged untracked
git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2>/dev/null) || \
  ref=$(git rev-parse --short HEAD 2>/dev/null) || return 0
  parse_git_status
  echo "$staged$unstaged$untracked %{$reset_color%}%F{222}${${ref:u}#REFS/HEADS/}%f "
}
parse_git_status() {
  local STATUS
  STATUS=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $STATUS == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}";
  [[ $STATUS == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}";
  [[ $STATUS == *\?* ]] && untracked="%{$fg_bold[blue]%}";
}

# preexec() and precmd() are hook functions in zsh. (bash has precmd() but not preexec())
preexec_timer() { cmd_start=$(($(print -P %D{%s%6.})/1000)) }
precmd_timer() {
  [ $cmd_start ] && { local cmd_end=$(($(print -P %D{%s%6.})/1000)); \
  local time_ms=$((cmd_end-cmd_start))
  local time_sec=$(printf %.2f $(echo "$time_ms/1000" | bc -l))
  local time_min=$(printf %i $(echo "$time_sec/60" | bc -l))
  local time_min_tail=$(printf %i $(($time_sec-$time_min*60)))
  { [[ $time_sec -ge 1 ]] && [[ $time_min -eq 0 ]] } \
  && timer_result="%B$time_sec%b $(italicize sec)" \
  || timer_result="%B$time_ms%b $(italicize ms)"
  [[ $time_min -ge 1 ]] \
  && timer_result="%B$time_min%b $(italicize min) %B$time_min_tail%b $(italicize sec)"
  timer="%F{152} $timer_result %f" }
}
preexec_functions+=(preexec_timer); precmd_functions+=(precmd_timer)

# Seperate path with head and tail
chpwd_prompt () {
  local HPWD=${(%)${:-%~}} # $PWD with ~ abbreviations
  case $HPWD in
    "~" | "/home/$USER")
      cwd_head="%F{white}%B%b%f"; cwd_tail="";;
    "~/"*)
      local head=${HPWD%/*}
      local headabv=$(sed "s|^~/| |" <<< $head)
      [[ $headabv == "~" ]] && cwd_head="%F{white} %f" || cwd_head="%F{white}$headabv/%f"
      cwd_tail="%F{white}%B${HPWD##*/}%b%f";;
    "/home/$USER/"*)
      local head=${HPWD%/*}
      local headabv=$(sed "s|^/home/$USER| |" <<< $head)
      cwd_head="%F{white}$headabv/%f"; cwd_tail="%F{white}%B${HPWD##*/}%b%f";;
    *?/*)
      local head=$(sed "s|^/| |" <<< $HPWD)
      cwd_head="%F{white}${head%/*}/%f"; cwd_tail="%F{white}%B${head##*/}%b%f";;
    *)
      cwd_head="%F{white} %f"; cwd_tail="%F{white}%B${HPWD#/}%b%f";;
  esac
}

# Check background_job, super_user, exit code (Use ternary operators here)
local bg_jobs="%(1j.%{$fg_bold[red]%} .)"
local privileges="%(#.%{$fg_bold[red]%} .)"
local line_break=$'\n'%{$reset_color%}
local ret_status="%(?:%{$fg_bold[green]%} :%{$fg_bold[red]%} %s)"
PROMPT='$bg_jobs$privileges$cwd_head$cwd_tail $(git_prompt_info)$timer$line_break$ret_status'
# trigger the chpwd hooks once, this line should appear after the prompt definition
chpwd_functions+=(chpwd_prompt); cd .
