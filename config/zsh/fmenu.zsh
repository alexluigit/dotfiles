__colorize_sym() { echo -ne "\e[38;5;$1""m""$2""\e[0m"; }

NAVI_B=(sed '"'); NAVI_A=(sed '"')
declare -a dir_index=(`for d in ${(@k)USER_DIRS[@]}; do echo $d; done | sort`)
declare -a sys_index=(`echo ${(@k)SYS_DIRS} | tr ' ' '\n' | sort`)
for i in $sys_index; do
  local dir_info=(`echo ${SYS_DIRS[$i]}`)
  local path_d=${dir_info[1]} sym_d=${dir_info[2]} color_d=${dir_info[3]}
  local sym_c=$(__colorize_sym "$color_d" "$sym_d")
  NAVI_B+=("s|^$path_d|$sym_c${SYM_OFFSET:- }|g;")
  NAVI_A+=("s|^$sym_d${SYM_OFFSET:- }|$path_d|g;")
done
NAVI_B+=('"'); NAVI_A+=('"');

_fzf_navi() {
  [[ $1 == 'z' ]] && { local CMD=(z -l '|' awk \'{print \$2}\') REV='--tac'; } \
  || { local CMD=(fd -H -td --ignore-file $XDG_CONFIG_HOME/fd/root . /); }
  dest=$(eval "$CMD" | eval "$NAVI_B" | fzf --ansi $REV | eval "$NAVI_A")
  [[ -z $dest ]] && { zle reset-prompt; return; } || { cd $dest; zle reset-prompt; }
}

_fzf_menu() {
  _entries() { for i in ${dir_index[@]}; do echo ${USER_DIRS[$i]}; done; }
  _parse_opt() { OPT[2]+="${SYM_OFFSET:- }"; }
  _fzf_open() {
    local ignore dir="$1" app="$3"
    local fd_cmd=(fd -tf -H -L -c always)
    local fzf_cmd=(fzf --height=100% -m --ansi --preview=\"preview {}\" --prompt=\"$2\")
    local xargs_cmd=(xargs -ro -d \'\\n\' "$app")
    [[ $dir='/' ]] && ignore=(--ignore-file ~/.config/fd/root); cd $dir
    local res=`eval ${fd_cmd[@]} ${ignore[@]} | eval ${fzf_cmd[@]}`
    local detach=$([[ $app =~ ".*vim|emacs(client)?" ]] || echo " & disown")
    [[ -n $res ]] && IFS='' && {
      echo $res | eval "${xargs_cmd[@]} $detach"
    }; unset IFS
    cd -; zle reset-prompt 2>/dev/null; zle-line-init 2>/dev/null
  }
  OPT=(`_entries | fzf --height=100% --prompt="Open: " --with-nth 2,4..`)
  [[ -n $OPT ]] && { _parse_opt; _fzf_open ${OPT[@]}; } || zle reset-prompt 2>/dev/null
}

f() {
  case $1 in
      "")    _fzf_menu $@;;
      "nav") _fzf_navi ${@:2};;
  esac
}
