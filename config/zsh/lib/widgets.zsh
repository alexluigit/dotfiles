yank-buffer() { echo -n "$BUFFER" | xclip -selection clipboard; }
file-or-forwardchar() { [[ -z $BUFFER ]] && { BUFFER="vifmrun ."; zle accept-line } || zle forward-char; }
fg-bg() { [[ $#BUFFER -eq 0 ]] && { fg; zle reset-prompt; zle-line-init } || zle push-input }
updir-onthefly() { [[ -z $BUFFER ]] && { cd ..; zle reset-prompt } \
  || { zle kill-whole-line && cd ..; zle reset-prompt; zle yank }}
clear-or-complete() { [[ -z $BUFFER ]] && zle clear-screen || zle autosuggest-accept }
newnote() { nvim ~/Documents/Notes/notes.md }
newnote-or-edit-cmd() { [[ -z $BUFFER ]] && newnote; zle-line-init  || zle edit-command-line }

mkcd() { mkdir -p $@ && cd ${@:$#} }

typeset -gA AUTOPAIR_PAIRS
AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' '<' '>' ' ' ' ')
autopair() {
  read -sk RES
  [ $RES == 'a' ] && RES='<'
  [ $RES == 'c' ] && RES='{'
  [ $RES == 'b' ] && RES='('
  [ $RES == 'q' ] && RES='"'
  RBUFFER=$RES$AUTOPAIR_PAIRS[$RES]$RBUFFER
  zle forward-char
}

tmux-automation() {
  # https://gist.github.com/lann/6771001
  local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
  [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ] && ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  [[ -n "$@" ]] && { env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"; return }
  [ -x .tmux ] && { ./.tmux; return }
  local SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
  env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}

ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else; echo "'$1' is not a valid file"; fi
}

zle -N yank-buffer
zle -N file-or-forwardchar
zle -N fg-bg
zle -N updir-onthefly
zle -N clear-or-complete; ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(clear-or-complete)
zle -N autopair
zle -N newnote-or-edit-cmd
autoload -Uz move-line-in-buffer; zle -N up-line-in-buffer move-line-in-buffer
autoload -Uz select-quoted; zle -N select-quoted
autoload -Uz select-bracketed; zle -N select-bracketed
autoload -Uz surround; zle -N delete-surround surround; zle -N add-surround surround; zle -N change-surround surround
autoload -Uz edit-command-line; zle -N edit-command-line
autoload -Uz up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search; zle -N down-line-or-beginning-search
