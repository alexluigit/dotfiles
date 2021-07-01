__italic() { echo -ne "\e[3m$@\e[23m"; }

# Git
_git_prompt_info() {
  local ref git_status staged unstaged untracked
  ref=$(git symbolic-ref HEAD 2>/dev/null) || \
  ref=$(git rev-parse --short HEAD 2>/dev/null) || return 0
  git_status=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $git_status == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}";
  [[ $git_status == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}";
  [[ $git_status == *\?* ]] && untracked="%{$fg_bold[blue]%}";
  echo "$staged$unstaged$untracked %{$reset_color%}%F{222}${${ref:u}#REFS/HEADS/}%f"
}

# Hooks for timer
_preexec_timer() { cmd_start=$(($(print -P %D{%s%6.})/1000)); }
_precmd_timer() {
  [ $cmd_start ] && {
    local cmd_end=$(($(print -P %D{%s%6.})/1000))
    local t_ms=$((cmd_end-cmd_start))
    local t_sec=$(printf %.2f $(echo "$t_ms/1000" | bc -l))
    local t_min=$(printf %i $(echo "$t_sec/60" | bc -l))
    local t_min_tail=$(printf %i $(($t_sec-$t_min*60)))
    [[ $t_sec -ge 1 ]] && [[ $t_min -eq 0 ]] && t_res="%B$t_sec%b $(__italic sec)" \
    || t_res="%B$t_ms%b $(__italic ms)"
    [[ $t_min -ge 1 ]] && t_res="%B$t_min%b $(__italic min) %B$t_min_tail%b $(__italic sec)"
    timer="%F{152}  $t_res %f"
  }
}
preexec_functions+=(_preexec_timer); precmd_functions+=(_precmd_timer)

# Seperate path with head and tail
_chpwd_prompt () {
  cwd_tail="%{$fg_bold[$pwd_cr]%}$(basename $PWD) "
  local HPWD=${(%)${:-%~}} # $PWD with ~ abbreviations
  case $HPWD in
    "~" | "/home/$USER") cwd_head="%{$fg_bold[$pwd_cr]%}"; cwd_tail="";;
    "~/"*)
      local head=$(sed "s|^~/| |" <<< ${HPWD%/*})
      [[ $head == "~" ]] && cwd_head="%{$fg[$pwd_cr]%} " || cwd_head="%{$fg[$pwd_cr]$head/%}";;
    *?/*)
      local head=$(sed "s|^/| |" <<< $HPWD)
      cwd_head="%{$fg[$pwd_cr]${head%/*}/%}";;
    /) cwd_head="%{$fg[$pwd_cr]%} "; cwd_tail="";;
    *) cwd_head="%{$fg[$pwd_cr]%} ";;
  esac
}
chpwd_functions+=(_chpwd_prompt); cd .

# Setup prompt
local pwd_cr="white"
local bg_jobs="%(1j.%{$fg_bold[red]%} .)"
local privileges="%(#.%{$fg_bold[red]%} .)"
local line_break=$'\n'%{$reset_color%}
local ret_status="%(?:%{$fg_bold[green]%} :%{$fg_bold[red]%} %s)"
PROMPT='$bg_jobs$privileges$cwd_head$cwd_tail$(_git_prompt_info)$timer$line_break$ret_status'
