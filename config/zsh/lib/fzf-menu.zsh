__entries() { for i in ${(@v)USER_DIRS}; do echo $i; done; }
__win_float() {
  local app=$1
  case $app in
    sxiv)    CLASS=Sxiv;    GUI=true;;
    zathura) CLASS=Zathura; GUI=true;;
    mpv)     CLASS=mpv;     GUI=true;;
    *)       CLASS=$app;;
  esac
  bspc rule -a $CLASS:$INSTANCE -o state=floating rectangle=$FLOAT_DIMENSION
}
__intercept() {
  ! $GUI && return
  floatwin_cache="$XDG_CACHE_HOME/floatwin/fmenu"
  xdo id -md -N $CLASS -n $INSTANCE > $floatwin_cache
}
__parse_opt() {
  OPT[2]+="$SYM_OFFSET"
  [[ ${OPT[3]} == "mpv" ]] && { FLAG=(--x11-name=$INSTANCE); return; }
  [[ ${OPT[3]} == "sxiv" ]] && { FLAG=(-N $INSTANCE); return; }
}

_fzf_open() {
  GUI=false
  local ignore dir="$1" app="$3"
  local fd_cmd="fd -tf -H -L -c always"
  local fzf_cmd=(fzf --height=100% -m --ansi --preview=\"preview {}\" --prompt=\"$2\")
  local xargs_cmd=("$app")
  [[ -n $FLAG ]] && xargs_cmd+=("${FLAG[@]}")
  [[ $dir='/' ]] && ignore=(--ignore-file ~/.config/fd/root); cd $dir
  local res=$(eval $fd_cmd $ignore | eval ${fzf_cmd[@]})
  [[ -n $EXEC_FROM_X ]] && __win_float $app && __intercept &
  [[ -n $res ]] && {
    _set_title $app; echo $res | xargs -ro -d '\n' ${xargs_cmd[@]}; _reset_title;
  }
  cd -; zle reset-prompt 2>/dev/null
  _exec_if_exist zle-line-init
}
_fzf_open_menu() {
  EXEC_FROM_X=$1
  INSTANCE="fmenu"
  OPT=($(__entries | fzf --height=100% --prompt="Open: " --with-nth 2,4..))
  [[ -n $OPT ]] && { __parse_opt; _fzf_open $OPT; } || zle reset-prompt 2>/dev/null
  [[ -n $EXEC_FROM_X ]] && bspc rule -r $CLASS 2>/dev/null
}
