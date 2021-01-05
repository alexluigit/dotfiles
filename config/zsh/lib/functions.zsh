_set_title() { [[ -z $TMUX ]] && echo -ne "\e]2;$1\007" || tmux select-pane -m; }
_reset_title() { [[ -z $TMUX ]] && echo -ne "\e]2;Terminal\007" || tmux select-pane -M; }

_italic() { printf "%b%s%b" '\e[3m' "$@" '\e[23m'; }
_colorize() { echo "\x1b\[38;5;$1m$2\x1b\[0m"; }
_inside_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
_fugitive() { _set_title nvim; nvim -c "Gstatus | bd# | nmap <buffer>q <c-w>q"; _reset_title; }

_resume_jobs() { fg; zle reset-prompt; zle-line-init; }
_updir() { cd ..; zle reset-prompt; }
_yank_cmdline() { echo -n "$BUFFER" | xclip -selection clipboard; }
_quick-sudo() { BUFFER="sudo !!"; zle accept-line; }
_lf() {
  tmp="$(mktemp)"
  lfrun -last-dir-path="$tmp" "$@"
  [ -f "$tmp" ] && {
    dir="$(cat "$tmp")"; rm -f "$tmp"
    [ -d "$dir" ] && { [ "$dir" != "$(pwd)" ] && cd "$dir" }
  }
  zle reset-prompt; zle-line-init;
}
zbug() {}

_make-notes() { n ~/Documents/notes/draft/notes.md; }
_make-scripts() { n ~/Dev/alex.files/local/bin/new.sh; }
_todolist() { n ~/.cache/bujo/todo.md; }
