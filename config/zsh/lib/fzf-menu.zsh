__entries() { for i in ${(@v)USER_DIRS}; do echo $i; done; }
__win_float() {
  local app=$1
  case $app in
    sxiv)    CLASS=Sxiv:$CLASSNAME;;
    zathura) CLASS=Zathura;;
    mpv)     CLASS=mpv:$CLASSNAME;;
    *)       CLASS=$app;;
  esac
  bspc rule -a $CLASS -o state=floating rectangle=$FLOAT_DIMENSION
}
_fzf_open() {
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

__intercept() {
  local time_out=20 timer=0
  floatwin_cache="$XDG_CACHE_HOME/floatwin/fmenu"
  while (($timer <= $time_out)); do
    sleep .5; wid=$(xdotool search --onlyvisible --classname $CLASSNAME)
    [[ -n "$wid" ]] && echo "$wid" > $floatwin_cache && break
    timer=$((timer + 1))
  done
}

__parse_opt() {
  OPT[2]+="$SYM_OFFSET"
  [[ ${OPT[3]} == "mpv" ]] && { FLAG=(--x11-name=$CLASSNAME); return; }
  [[ ${OPT[3]} == "sxiv" ]] && { FLAG=(-N $CLASSNAME); return; }
}

_fzf_open_menu() {
  EXEC_FROM_X=$1
  CLASSNAME="fmenu"
  OPT=($(__entries | fzf --height=100% --prompt="Open: " --with-nth 2,4..))
  [[ -n $OPT ]] && { __parse_opt; _fzf_open $OPT; } || zle reset-prompt 2>/dev/null
  [[ -n $EXEC_FROM_X ]] && bspc rule -r $CLASS 2>/dev/null
}
