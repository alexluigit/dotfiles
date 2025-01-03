# See keylist at https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/src/prompt_toolkit/input/ansi_escape_sequences.py
# You can use 'cat' or 'read' to capture a key sequence. See: https://superuser.com/questions/997593/why-does-zsh-insert-a-when-i-press-the-delete-key
# For example: '^[' represents ESC(Escape)
stty -ixon # Disable XON/XOFF flow control
regbind () { zle -N $2; bindkey $1 $2; }
autoload -Uz edit-command-line; zle -N edit-command-line;

declare -gA AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' '<' '>' ' ' ' ')
_autopairs() {
  case $1 in
    "a") pair_l='<';;
    "b") pair_l='(';;
    "r") pair_l='[';;
    "c") pair_l='{';;
    "q") pair_l="'";;
    "Q") pair_l='"';;
  esac
  local pair_r=$AUTOPAIR_PAIRS[$pair_l]
  local last_l_ch=${LBUFFER: -1}
  local first_r_ch=${RBUFFER:0:1}
  should_not_insert_pair() {
    [[ -n $BUFFER ]] && { [[ $1 =~ 'Qq' ]] && [[ $last_l_ch != ' ' ]] }\
      || { [[ -n $RBUFFER ]] && [[ $first_r_ch != $pair_r ]] }
  }
  $(should_not_insert_pair) && BUFFER=$LBUFFER$pair_l$RBUFFER || RBUFFER=$pair_l$pair_r$RBUFFER
  zle forward-char
}
backspace() {
  local last_l_ch=${LBUFFER: -1}
  local first_r_ch=${RBUFFER:0:1}
  local maybe_pair_r=$AUTOPAIR_PAIRS[$last_l_ch]
  cursor_between_pair() { [[ -n $1 ]] && [[ $1 == $2 ]]; }
  $(cursor_between_pair $maybe_pair_r $first_r_ch) && zle delete-char
  zle backward-delete-char
}
history-cmds() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases
  local sel num
  sel=($(fc -rl 1 | fzf +m))
  [[ -n "$sel" ]] && { num=$sel[1]; [[ -n "$num" ]] && zle vi-fetch-history -n $num; }
  zle reset-prompt
}
yank-clipboard() {
  oldRBUF=$RBUFFER
  [[ "$(uname)" == "Darwin" ]] && RBUFFER=$(pbpaste) \
      || RBUFFER=$(xclip -o -selection clipboard);
  zle end-of-line
  RBUFFER=$oldRBUF
}
write-to-clipboard() {
  zle copy-region-as-kill;
  [[ "$(uname)" == "Darwin" ]] && print -rn $CUTBUFFER | pbcopy ||\
      print -rn $CUTBUFFER | xclip -i -selection clipboard;
}
find-all-dir()  { _fzf_navi; }
kill-line-or-proc()  { [[ -n $BUFFER ]] && zle kill-whole-line ||\
                           { BUFFER="kill -9 **"; zle end-of-line; fzf-completion; } }
fd-pwd()  { [[ "$(uname)" == "Darwin" ]] && _fzf_menu . open || _fzf_menu . xdg-open; }
z-goto()  { _fzf_navi z; }
updir() { cd ..; zle reset-prompt; }
fcd() { local sel=$(fd -c always -td . | fzf --ansi); [[ -n $sel ]] && cd $sel; zle reset-prompt; }
open-angle()   { _autopairs a; }
open-brace()   { _autopairs b; }
open-brket()   { _autopairs r; }
open-curly()   { _autopairs c; }
single-quote() { _autopairs q; }
double-quote() { _autopairs Q; }

bindkey -e
bindkey -M menuselect 'n' vi-down-line-or-history
bindkey -M menuselect 'p' vi-up-line-or-history
bindkey '^o'      backward-char
bindkey '^[OR'    forward-char             # F3  <ctrl> i
bindkey '^[OS'    backward-kill-word       # F4  <ctrl> Back
regbind '^[[15~'  kill-line-or-proc        # F5  <shift>Back
regbind '^[[17~'  fd-pwd                   # F6  <ctrl> /
regbind '^[[21~'  edit-command-line        # F10 <ctrl> ,
regbind '^[[23~'  _fzf_menu                # F11 <ctrl> .
regbind '^[[25~'  updir                    # F12 <ctrl> ;
regbind '^r'      history-cmds
regbind '^\\'     find-all-dir
regbind '^w'      write-to-clipboard
regbind '^y'      yank-clipboard
regbind '^z'      z-goto
regbind '^?'      backspace
regbind '<'       open-angle
regbind '('       open-brace
regbind '['       open-brket
regbind '{'       open-curly
regbind "'"       single-quote
regbind '"'       double-quote
