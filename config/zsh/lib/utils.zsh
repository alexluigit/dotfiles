_set_title() { echo -ne "\e]2;$1\007"; }
_reset_title() { echo -ne "\e]2;Alacritty\007"; }
_italic() { echo -ne "\e[3m$@\e[23m"; }
_inside_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
_fugitive() { _set_title nvim; nvim -c "Gstatus | bd# | nmap <buffer>q <c-w>q"; _reset_title; }
_resume_jobs() { fg; zle reset-prompt; zle-line-init; }
_updir() { cd ..; zle reset-prompt; }
_yank_cmdline() { echo -n "$BUFFER" | xclip -selection clipboard; }
declare -gA AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' '<' '>' ' ' ' ')
_autopairs() {
  local pair
  [ $1 == 'a' ] && pair='<'
  [ $1 == 'b' ] && pair='('
  [ $1 == 'r' ] && pair='['
  [ $1 == 'c' ] && pair='{'
  [ $1 == 'q' ] && pair="'"
  [ $1 == 'Q' ] && pair='"'
  RBUFFER=$pair$AUTOPAIR_PAIRS[$pair]$RBUFFER
  zle forward-char
}
_lf() {
  tmp="$(mktemp)"
  lfrun -last-dir-path="$tmp" "$@"
  [ -f "$tmp" ] && {
    dir="$(cat "$tmp")"; rm -f "$tmp"
    [ -d "$dir" ] && { [ "$dir" != "$(pwd)" ] && cd "$dir" }
  }
  zle reset-prompt; zle-line-init
}
_tmux_auto() { # tmux automation
  local S_NAME=$(basename "${PWD//[.:]/_}")
  local S_CONFIG=$XDG_DATA_HOME/tmux$PWD
  [[ $1 == "edit" ]] && { mkdir -p $S_CONFIG; touch $S_CONFIG/tmux; chmod +x $S_CONFIG/tmux; nvim $S_CONFIG/tmux; return; }
  _switch() { [[ -n $TMUX ]] && tmux switch -t $1 2>/dev/null || tmux a -t $1; }
  [[ -n $@ ]] && { tmux $@; return; }
  HAS_SESSION=$(tmux has-session -t=$S_NAME 2>/dev/null)
  [ $? -eq 0 ] && _switch $S_NAME || { [ -x $S_CONFIG/tmux ] && { tmux new -s $S_NAME -d && $S_CONFIG/tmux $S_NAME && _switch $S_NAME; } \
  || tmux new -s $S_NAME -d && _switch $S_NAME; }
}
_sudo_edit() {
  tmp_file=`mktemp --dry-run`
  cp "$1" "$tmp_file"
  nvim $tmp_file
  doas mv "$tmp_file" "$1"
}
vterm_printf() { # Emacs Vterm helper
  # if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
  #   # Tell tmux to pass the escape sequences through
  #   printf "\ePtmux;\e\e]%s\007\e\\" "$1"
  # elif [ "${TERM%%-*}" = "screen" ]; then
  #   # GNU screen (screen, screen-256color, screen-256color-bce)
  #   printf "\eP\e]%s\007\e\\" "$1"
  # else
    printf "\e]%s\e\\" "$1"
  # fi
}
