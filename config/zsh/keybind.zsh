# See keylist at https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/prompt_toolkit/input/ansi_escape_sequences.py
stty -ixon # Disable XON/XOFF flow control
autoload -Uz edit-command-line; zle -N edit-command-line
regbind () { zle -N $2; bindkey $1 $2; }
bindkey -e
bindkey -M menuselect 'n' vi-down-line-or-history
bindkey -M menuselect 'p' vi-up-line-or-history
regbind '^[[15~' find-all-dir # <ctrl-return> -> F5
regbind '^f'     fcd
regbind '^[e'    edit-command-line
regbind '^[k'    kill-proc
regbind '^[[17~' backward-char-or-fd-pwd # <ctrl-i> -> F6
regbind '^[r'    history-cmds
regbind '^o'     forward-char-or-fmenu
regbind '^[t'    z-goto
regbind '^\\'    updir
regbind '^y'     yank
regbind '^z'     fg-bg
regbind '^?'     backspace
regbind '<'      open-angle
regbind '('      open-brace
regbind '['      open-brket
regbind '{'      open-curly
regbind "'"      single-quote
regbind '"'      double-quote

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

backspace() { zle backward-delete-char; }
history-cmds() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases
  local sel num
  sel=($(fc -rl 1 | fzf +m))
  [[ -n "$sel" ]] && { num=$sel[1]; [[ -n "$num" ]] && zle vi-fetch-history -n $num; }
  zle reset-prompt
}
find-all-dir()  { _fzf_navi; }
kill-proc() { BUFFER="kill -9 "; zle end-of-line; fzf-completion; }
backward-char-or-fd-pwd()  { [[ -n $BUFFER ]] && zle forward-char || _fzf_menu . xdg-open; }
forward-char-or-fmenu()  { [[ -n $BUFFER ]] && zle backward-char || _fzf_menu; }
z-goto()  { _fzf_navi z; }
updir() { cd ..; zle reset-prompt; }
yank() { oldRBUF=$RBUFFER; RBUFFER=$(xclip -o -selection clipboard); zle end-of-line; RBUFFER=$oldRBUF; }
fg-bg()  { [[ -n $BUFFER ]] && zle push-input || { fg; zle reset-prompt; zle-line-init; } }
fcd() { local sel=$(fd -c always -td . | fzf --ansi); [[ -n $sel ]] && cd $sel; zle reset-prompt; }
open-angle()   { _autopairs a; }
open-brace()   { _autopairs b; }
open-brket()   { _autopairs r; }
open-curly()   { _autopairs c; }
single-quote() { _autopairs q; }
double-quote() { _autopairs Q; }
