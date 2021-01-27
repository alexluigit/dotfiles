_set_title() { echo -ne "\e]2;$1\007"; }
_reset_title() { echo -ne "\e]2;Terminal\007"; }
_italic() { echo -ne "\e[3m$@\e[23m"; }
_inside_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
_fugitive() { _set_title nvim; nvim -c "Gstatus | bd# | nmap <buffer>q <c-w>q"; _reset_title; }
_resume_jobs() { fg; zle reset-prompt; zle-line-init; }
_updir() { cd ..; zle reset-prompt; }
_yank_cmdline() { echo -n "$BUFFER" | xclip -selection clipboard; }
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
