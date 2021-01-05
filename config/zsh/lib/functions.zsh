_set_title() { [[ -z $TMUX ]] && echo -ne "\e]2;$1\007" || tmux select-pane -m; }
_reset_title() { [[ -z $TMUX ]] && echo -ne "\e]2;Terminal\007" || tmux select-pane -M; }

_italic() { printf "%b%s%b" '\e[3m' "$@" '\e[23m'; }
_inside_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
_fugitive() { nvim -c "Gstatus | bd# | nmap <buffer>q <c-w>q"; }

__resume-jobs() { fg; zle reset-prompt; zle-line-init; }
__updir() { cd ..; zle reset-prompt; }
__yank-cmdline() { echo -n "$BUFFER" | xclip -selection clipboard; }
__todolist() { nvim ~/.cache/bujo/todo.md; zle-line-init; }
__quick-sudo() { BUFFER="sudo !!"; zle accept-line; }
__lf() {
  tmp="$(mktemp)"
  lfrun -last-dir-path="$tmp" "$@"
  [ -f "$tmp" ] && {
    dir="$(cat "$tmp")"; rm -f "$tmp"
    [ -d "$dir" ] && { [ "$dir" != "$(pwd)" ] && cd "$dir" }
  }
  zle reset-prompt; zle-line-init;
}
zbug() {}

__make-notes() { nvim ~/Documents/notes/draft/notes.md; zle-line-init; }
__make-scripts() { nvim ~/Dev/alex.files/local/bin/new.sh; zle-line-init; }
