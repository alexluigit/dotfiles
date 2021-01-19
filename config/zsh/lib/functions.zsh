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
  zle reset-prompt; zle-line-init;
}
_make-notes() { n ~/Documents/notes/draft/notes.md; }
_todolist() { n ~/.cache/bujo/todo.md; }
zbug() {}
