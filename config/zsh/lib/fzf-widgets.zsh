__fnavi_init() {
  colorize_sym() { echo "\x1b\[38;5;$1m$2\x1b\[0m"; }
  NAVI_B=(sed '"'); NAVI_A=(sed '"')
  declare -a dir_index=(`echo ${(@k)SYS_DIRS} | tr ' ' '\n' | sort`)
  for i in $dir_index; do
    local dir_info=(`echo ${SYS_DIRS[$i]}`)
    local path_d=${dir_info[1]} sym_d=${dir_info[2]} color_d=${dir_info[3]}
    local sym_c=$(colorize_sym "$color_d" "$sym_d")
    NAVI_B+=("s|^$path_d|$sym_c$SYM_OFFSET|g;")
    NAVI_A+=("s|^$sym_d$SYM_OFFSET|$path_d|g;")
  done
  unset -f colorize_sym
  NAVI_B+=('"'); NAVI_A+=('"');
}; __fnavi_init

_fzf_navi() {
  [[ $1 == 'z' ]] && { local CMD=(z -l '|' awk \'{print \$2}\') REV='--tac'; } \
  || { local CMD=(fd -H -td --ignore-file $XDG_CONFIG_HOME/fd/root . /); }
  dest=$(eval "$CMD" | eval "$NAVI_B" | fzf --ansi $REV | eval "$NAVI_A")
  [[ -z $dest ]] && { zle reset-prompt; return; } || { cd $dest; zle reset-prompt; }
}

_fzf_hist() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases
  local sel num
  sel=($(fc -rl 1 | fzf +m))
  [[ -n "$sel" ]] && { num=$sel[1]; [[ -n "$num" ]] && zle vi-fetch-history -n $num; }
  zle reset-prompt
}

_fzf_cd() { local sel=$(ls -D | fzf --ansi); [[ -n $sel ]] && cd $sel; zle reset-prompt; }
_fzf_comp_helper() { BUFFER="$BUFFER**"; zle end-of-line; fzf-completion; }
_fzf_kill() { BUFFER="kill -9 "; zle end-of-line; fzf-completion; }
_fzf-clip() { }
