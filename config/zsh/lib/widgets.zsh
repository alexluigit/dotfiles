ctrl-f() { __file-manager }
ctrl-j() { __todolist }
ctrl-r() { __fzf-hist }
ctrl-s() { __autopairs }
ctrl-xx(){ __fzf-kill }
ctrl-y() { __yank-cmdline }
ctrl-\;(){ __fzf-navi z }
ctrl-t() { __fzf-comp-helper }
ctrl-k() { zle edit-command-line }
ctrl-tt(){ __fzf-open mpv "$DEV_VID_DIR[3]" }
ctrl-tn(){ __fzf-open nvim "$NOTE_DIR[3]" }
ctrl-te(){ __fzf-open mpv "$AUDIO_DIR[3]" }
ctrl-ti(){ __fzf-open sxiv "$PIC_DIR[3]" }
ctrl-to(){ __fzf-open mpv "$VID_DIR[3]" }
ctrl-\'(){ [[ $#LBUFFER -ne $#BUFFER ]] && zle end-of-line || zle autosuggest-accept }
ctrl-RT(){ [[ -n $BUFFER ]] && zle accept-line || __quick-sudo }
ctrl-i() { [[ -n $BUFFER ]] && zle backward-char || __fzf-dot }
ctrl-o() { [[ -n $BUFFER ]] && zle forward-char || __fzf-open }
ctrl-d() { [[ -n $BUFFER ]] && zle delete-char || __fzf-cd }
ctrl-h() { [[ -n $BUFFER ]] && zle backward-delete-char || __updir }
ctrl-l() { [[ -n $BUFFER ]] && zle vi-forward-word || zle clear-screen }
ctrl-p() { [[ -n $BUFFER ]] && zle vi-backward-word || __fzf-navi home }
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
  . $ZDOTDIR/user/dirs.zsh
  local cmd
  [[ $1 == 'z' ]] && { cmd=(z -l '|' awk \'{print \$2}\'); BEFORE_FNAVI=$B_FN_PLAIN } \
  || cmd=(fd -H -td --ignore-file $XDG_CONFIG_HOME/fd/root -c always . /)
  dest=$(eval "$cmd[@]" | eval "$BEFORE_FNAVI[@]" | fzf +s --tac --ansi | eval "$AFTER_FNAVI[@]")
  [[ -z $dest ]] && { zle reset-prompt; return } || cd $dest
  zle reset-prompt
}
__fzf-open() {
  [[ -z $HOME_DIR ]] && . $ZDOTDIR/user/dirs.zsh
  local openCmd=${1:-xdg-open}
  cd ~; fd -tf -H -L -c always --ignore-file $XDG_CONFIG_HOME/fd/${3:-ignore} \
  | eval "$BEFORE_FOPEN[@]" | fzf -m --ansi --preview="preview {}" --query=$2 \
  | eval "$AFTER_FOPEN[@]"  | xargs -ro -d '\n' $openCmd 2>&1
  cd -; zle reset-prompt; zle-line-init
}
__fzf-hist() {
  local selected num
  selected=($(fc -rl 1 | fzf +m))
  [[ -n "$selected" ]] && { num=$selected[1]; [[ -n "$num" ]] && zle vi-fetch-history -n $num }
  zle reset-prompt
}
__resume-jobs() { fg; zle reset-prompt; zle-line-init }
__fzf-cd() { local sel=$(ls -D | fzf); [[ -n $sel ]] && cd $sel; zle reset-prompt }
__fzf-dot() { __fzf-open nvim "$DOT_DIR[3]" "dot" }
__fzf-comp-helper() { BUFFER="$BUFFER**"; zle end-of-line; fzf-completion }
__fzf-kill() { BUFFER="kill -9 "; zle end-of-line; fzf-completion }
__updir() { cd ..; zle reset-prompt }
__file-manager() { BUFFER="vifmrun ."; zle accept-line }
__yank-cmdline() { echo -n "$BUFFER" | xclip -selection clipboard }
__todolist() { nvim ~/.cache/bujo/todo.md; zle-line-init }
__quick-sudo() { BUFFER="sudo !!"; zle accept-line }

__make-notes() { nvim ~/Documents/notes/draft/notes.md; zle-line-init }
__make-scripts() { nvim ~/Dev/alex.files/local/bin/new.sh; zle-line-init }
__fzf-clip() { }
