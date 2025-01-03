# Beam shape cursor before every cmd
zle-line-init() { echo -ne "\e[5 q"; } # '|' cursor
zle -N zle-line-init
preexec_functions+=(zle-line-init)

# PWD
_prompt_pwd=""
_chpwd_prompt () {
  local head=$(echo $PWD | eval "$NAVI_B") tail=""
  [[ ${head: -1} != " " ]] && { head=${head/$(basename $PWD)/}; tail="$(basename $PWD) "; }
  _prompt_pwd="$head%{$fg_bold[white]%}$tail$reset_color"
}
chpwd_functions+=(_chpwd_prompt)

# Timer
_prompt_timer_str=""
_prompt_timer_enabled=false
_preexec_timer() { cmd_start=$(($(print -P %D{%s%6.})/1000)); }
_precmd_timer() {
  local __italicize() { echo -ne "\e[3m$@\e[23m"; }
  [ $cmd_start ] && {
    local cmd_end=$(($(print -P %D{%s%6.})/1000))
    local t_ms=$((cmd_end-cmd_start))
    local t_sec=$(printf %.2f $(echo "$t_ms/1000" | bc -l))
    local t_min=$(printf %i $(echo "$t_sec/60" | bc -l))
    local t_min_tail=$(printf %i $(($t_sec-$t_min*60)))
    [[ $t_sec -ge 1 ]] && [[ $t_min -eq 0 ]] && t_res="%B$t_sec%b $(__italicize sec)" \
    || t_res="%B$t_ms%b $(__italicize ms)"
    [[ $t_min -ge 1 ]] && t_res="%B$t_min%b $(__italicize min) %B$t_min_tail%b $(__italicize sec)"
    $_prompt_timer_enabled && _prompt_timer_str="%F{152}| $t_res | %f" || _prompt_timer_str=""
  }
}
preexec_functions+=(_preexec_timer); precmd_functions+=(_precmd_timer)

# Git
_prompt_git_info() {
  local ref git_status staged unstaged untracked icon=${PROMPT_ICONS[git_status]}
  ref=$(git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [[ -n $ref ]] || return 0
  git_status=$(git status --porcelain | colrm 3 | uniq | paste -d: -s -)
  [[ $git_status == *[ADMR]\ * ]] && staged="%{$fg_bold[green]%}$icon";
  [[ $git_status == *\ [ADMR]* ]] && unstaged="%{$fg_bold[red]%}$icon";
  [[ $git_status == *\?* ]] && untracked="%{$fg_bold[blue]%}$icon";
  echo "$staged$unstaged$untracked %{$reset_color%}%F{222}${${ref:u}#REFS/HEADS/} %f"
}

# Vterm
_prompt_vterm_printf(){ printf "\e]%s\e\\" "$1"; } # vterm (emacs) helper
_prompt_vterm_index() {
  [[ -n $INSIDE_EMACS ]] && {
    local str="•"
    local index=$(emacsclient -e "(+vterm--get-index (window-buffer (selected-window)))")
    [[ "$index" -ge "1" ]] && { for i in $(seq 1 $index); do str+="•"; done; }
    echo "%{$fg_bold[blue]$str %}%{$reset_color%}"
  }
}
_prompt_vterm_end() { echo "%{$(_prompt_vterm_printf "51;A$(whoami)@$HOST:$(pwd)")%}"; }

# python's venv
_prompt_venv() {
  [[ -z $VIRTUAL_ENV ]] || [[ $VIRTUAL_ENV == "$XDG_DATA_HOME/python" ]] && return
  echo "%{$fg_bold[cyan][${PROMPT_ICONS[package]}] %}%{$reset_color%}"
}

# MISC
_prompt_bg_jobs() { echo "%(1j.%{$fg_bold[red]%}${PROMPT_ICONS[exclamation]} .)" }
_prompt_privileges() { echo "%(#.%{$fg_bold[red]%}${PROMPT_ICONS[fingerprint]} .)%{$reset_color%}" }
_prompt_reset_color() { [[ -z $1 ]] && echo %{$reset_color%} || echo $'\n'%{$reset_color%} }
_prompt_return_status() {
  local cursor_icon=${PROMPT_ICONS[play_button]}
  echo "%(?:%{$fg_bold[green]%}$cursor_icon :%{$fg_bold[red]%}$cursor_icon %s)"
}

# Setup prompt
PROMPT='$(_prompt_bg_jobs)$(_prompt_privileges)$_prompt_pwd\
$(_prompt_git_info)$(_prompt_venv)\
$(_prompt_vterm_index)$_prompt_timer_str$(_prompt_reset_color +\n)\
$(_prompt_return_status)$(_prompt_reset_color)$(_prompt_vterm_end)'
cd .
