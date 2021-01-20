declare -a dir_index=(`echo ${(@k)USER_DIRS[@]} | sort`)
__wm_set_rule() { bspc rule -a $CLASS:$INSTANCE -o state=floating 2>&1 >/dev/null; }
__entries() { for i in ${dir_index[@]}; do echo ${USER_DIRS[$i]}; done; }
__win_float() {
  local app=$1
  case $app in
    sxiv)    CLASS=Sxiv;    GUI=true;;
    zathura) CLASS=Zathura; GUI=true;;
    mpv)     CLASS=mpv;     GUI=true;;
    *)       CLASS=$app;;
  esac
  __wm_set_rule
}
__intercept() {
  target=~/.cache/floatwin/fmenu
  local new_wid=$(xdo id -md -N $CLASS -n $INSTANCE | tee -a $target)
  wid=$new_wid
  W=$(sed -n 1p $target) H=$(sed -n 2p $target)
  X=$(sed -n 3p $target) Y=$(sed -n 4p $target)
  xdotool windowmap $wid windowmove $wid $X $Y windowsize $wid $W $H
}
__parse_opt() {
  OPT[2]+="$SYM_OFFSET"
  [[ ${OPT[3]} == "mpv" ]] && { FLAG=(--x11-name=$INSTANCE); return; }
  [[ ${OPT[3]} == "sxiv" ]] && { FLAG=(-N $INSTANCE); return; }
}

_fzf_open() {
  GUI=false
  local ignore dir="$1" app="$3"
  local fd_cmd=(fd -tf -H -L -c always)
  local fzf_cmd=(fzf --height=100% -m --ansi --preview=\"preview {}\" --prompt=\"$2\")
  local xargs_cmd=("$app")
  [[ -n $FLAG ]] && xargs_cmd+=("${FLAG[@]}")
  [[ $dir='/' ]] && ignore=(--ignore-file ~/.config/fd/root); cd $dir
  local res=`eval ${fd_cmd[@]} ${ignore[@]} | eval ${fzf_cmd[@]}`
  "$EXEC_FROM_X" && __win_float "$app"
  "$GUI" && __intercept &
  [[ -n $res ]] && {
    _set_title $app; IFS=''; echo $res | xargs -ro -d '\n' ${xargs_cmd[@]}; _reset_title;
  }; unset IFS
  cd -; zle reset-prompt 2>/dev/null
  _exec_if_exist zle-line-init
}
_fzf_open_menu() {
  EXEC_FROM_X=${1:-false}
  INSTANCE="fmenu"
  OPT=(`__entries | fzf --height=100% --prompt="Open: " --with-nth 2,4..`)
  [[ -n $OPT ]] && { __parse_opt; _fzf_open ${OPT[@]}; } || zle reset-prompt 2>/dev/null
}
