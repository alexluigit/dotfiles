__italic() { echo -ne "\e[3m$@\e[23m"; }

# Git
_git_prompt_info() {
  local ref git_status staged unstaged untracked
  ref=$(git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [[ -n $ref ]] || return 0
  git_status=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $git_status == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}";
  [[ $git_status == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}";
  [[ $git_status == *\?* ]] && untracked="%{$fg_bold[blue]%}";
  echo "$staged$unstaged$untracked %{$reset_color%}%F{222}${${ref:u}#REFS/HEADS/} %f"
}

# Timer
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
    $TIMER_PROMPT && timer="%F{152}| $t_res | %f" || timer=""
  }
}
preexec_functions+=(_preexec_timer); precmd_functions+=(_precmd_timer)

# PWD
_chpwd_prompt () {
  local head=$(echo $PWD | eval "$NAVI_B") tail=""
  [[ ${head: -1} != " " ]] && { head=${head/$(basename $PWD)/}; tail="$(basename $PWD) "; }
  pwd_str="$head%{$fg_bold[white]%}$tail$reset_color"
}
chpwd_functions+=(_chpwd_prompt)

# Vterm
_vterm_index() {
  [[ -n $INSIDE_EMACS ]] && {
    local str="•"
    local index=$(emacsclient -e "(+vterm--get-index (window-buffer (selected-window)))")
    [[ "$index" -ge "1" ]] && { for i in $(seq 1 $index); do str+="•"; done; }
    echo "%{$fg_bold[blue]$str %}%{$reset_color%}"
  }
}
_vterm_end() { echo "%{$(vterm_printf "51;A$(whoami)@$HOST:$(pwd)")%}"; }

# Anaconda
_conda_env() {
  ! $CONDA_PROMPT || [[ -z $CONDA_DEFAULT_ENV ]] || [[ $CONDA_DEFAULT_ENV == "base" ]] && return
  echo "%{$fg_bold[cyan][] %}%{$reset_color%}"
}

# Setup prompt
local bg_jobs="%(1j.%{$fg_bold[red]%} .)"
local privileges="%(#.%{$fg_bold[red]%} .)%{$reset_color%}"
local line_break=$'\n'%{$reset_color%}
local ret_status="%(?:%{$fg_bold[green]%} :%{$fg_bold[red]%} %s)"
PROMPT='$bg_jobs$privileges$pwd_str$(_git_prompt_info)$(_conda_env)$(_vterm_index)$timer\
        $line_break$ret_status$(_vterm_end)'
cd .
