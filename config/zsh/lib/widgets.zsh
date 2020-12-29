ctrl-f() { lfrun .; zle-line-init  }
ctrl-j() { __todolist }
ctrl-r() { __fzf-hist }
ctrl-s() { __autopairs }
ctrl-xx(){ __fzf-kill }
ctrl-y() { __yank-cmdline }
ctrl-p(){ __fzf-navi z }
ctrl-t() { __fzf-comp-helper }
ctrl-b() { zbug }
ctrl-k() { zle edit-command-line }
ctrl-\'(){ [[ $#LBUFFER -ne $#BUFFER ]] && zle end-of-line || zle autosuggest-accept }
ctrl-RT(){ [[ -n $BUFFER ]] && zle accept-line || __quick-sudo }
ctrl-i() { [[ -n $BUFFER ]] && zle backward-char || __fzf-open . "Edit: " nvim }
ctrl-o() { [[ -n $BUFFER ]] && zle forward-char || __fzf-open-menu }
ctrl-d() { [[ -n $BUFFER ]] && zle delete-char || __fzf-cd }
ctrl-h() { [[ -n $BUFFER ]] && zle backward-delete-char || __updir }
ctrl-l() { [[ -n $BUFFER ]] && zle vi-backward-word || zle clear-screen }
ctrl-\;(){ [[ -n $BUFFER ]] && zle vi-forward-word || __fzf-navi home }
ctrl-z() { [[ -n $BUFFER ]] && zle push-input || __resume-jobs }
backspace() { zle vi-backward-delete-char }

typeset -gA AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' '<' '>' ' ' ' ')
__autopairs() {
  read -sk RES
  [ $RES == 'a' ] && RES='<'
  [ $RES == 'c' ] && RES='{'
  [ $RES == 'b' ] && RES='('
  [ $RES == 'q' ] && RES='"'
  RBUFFER=$RES$AUTOPAIR_PAIRS[$RES]$RBUFFER
  zle forward-char
}

__fzf-navi() {
  [[ $1 == 'z' ]] && { local CMD=(z -l '|' awk \'{print \$2}\') } \
  || { local CMD=(fd -H -td --ignore-file $XDG_CONFIG_HOME/fd/root . /) }
  dest=$(eval "$CMD" | eval "$NAVI_B" | fzf +s --tac --ansi | eval "$NAVI_A")
  [[ -z $dest ]] && { zle reset-prompt; return } || cd $dest
  zle reset-prompt
}

__fzf-open() {
  local ignore
  [[ $1='/' ]] && ignore=(--ignore-file ~/.config/fd/root)
  cd $1; fd -tf -H -L -c always $ignore \
  | fzf -m --ansi --preview="preview {}" --prompt=$2 | xargs -ro -d '\n' ${3:-xdg-open} 2>&1
  cd -; zle reset-prompt; zle-line-init
}

__fzf-hist() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases
  local selected num
  selected=($(fc -rl 1 | fzf +m))
  [[ -n "$selected" ]] && { num=$selected[1]; [[ -n "$num" ]] && zle vi-fetch-history -n $num }
  zle reset-prompt
}

__fzf-open-menu() {
  local res=($(for i in ${(@v)USER_DIRS}; do echo $i; done | fzf --prompt="Open: " --with-nth 2,4));
  [[ -n $res ]] && { res[2]+=" "; __fzf-open $res } || zle reset-prompt
}

__resume-jobs() { fg; zle reset-prompt; zle-line-init }
__fzf-cd() { local sel=$(ls -D | fzf --ansi); [[ -n $sel ]] && cd $sel; zle reset-prompt }
__fzf-comp-helper() { BUFFER="$BUFFER**"; zle end-of-line; fzf-completion }
__fzf-kill() { BUFFER="kill -9 "; zle end-of-line; fzf-completion }
__updir() { cd ..; zle reset-prompt }
__yank-cmdline() { echo -n "$BUFFER" | xclip -selection clipboard }
__todolist() { nvim ~/.cache/bujo/todo.md; zle-line-init }
__quick-sudo() { BUFFER="sudo !!"; zle accept-line }
zbug() {}

__make-notes() { nvim ~/Documents/notes/draft/notes.md; zle-line-init }
__make-scripts() { nvim ~/Dev/alex.files/local/bin/new.sh; zle-line-init }
__fzf-clip() { }
