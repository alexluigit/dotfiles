__entries() { for i in ${(@v)USER_DIRS}; do echo $i; done; }
__win_float() {
  local app=$1 class
  case $app in
    sxiv) class=Sxiv;;
    zathura) class=Zathura;;
    *) class=$app;;
  esac
  bspc rule -a $class -o state=floating rectangle=$FLOAT_DIMENSION
}

_fzf_open() {
  local ignore
  local fd_cmd="fd -tf -H -L -c always"
  local fzf_cmd=(fzf --height=100% -m --ansi --preview=\"preview {}\" --prompt=\"$2\")
  [[ $1='/' ]] && ignore=(--ignore-file ~/.config/fd/root); cd $1
  [[ -n $EXEC_FROM_X ]] && __win_float $3
  local res=($(eval $fd_cmd $ignore | eval ${fzf_cmd[@]}))
  [[ -n $res ]] && { _set_title $3; echo $res | xargs -ro -d '\n' $3 2>&1; _reset_title; }
  cd -; zle reset-prompt 2>/dev/null
  _exec_if_exist zle-line-init
}

_fzf_open_menu() {
  EXEC_FROM_X=$1
  local res=($(__entries | fzf --height=100% --prompt="Open: " --with-nth 2,4))
  [[ -n $res ]] && { res[2]+=" "; _fzf_open $res; } || zle reset-prompt 2>/dev/null
}
