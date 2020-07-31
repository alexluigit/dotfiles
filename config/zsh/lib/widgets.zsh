autoload -U edit-command-line; zle -N edit-command-line
autoload -U up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search; zle -N down-line-or-beginning-search

kill-and-yank-buffer() { echo -n "$BUFFER" | xclip -selection clipboard; zle kill-whole-line }
zle -N kill-and-yank-buffer

file-or-forwardchar() { [[ -z $BUFFER ]] && { BUFFER="vifmrun ."; zle accept-line } || zle forward-char }
zle -N file-or-forwardchar

fg-bg() { [[ $#BUFFER -eq 0 ]] && { fg; zle reset-prompt; zle-line-init } || zle push-input }
zle -N fg-bg

updir-onthefly() {
  [[ -z $BUFFER ]] && { cd ..; zle reset-prompt } \
  || { zle kill-whole-line && cd ..; zle reset-prompt; zle yank }}
zle -N updir-onthefly # Up a dir anytime

clear-or-complete() { [[ -z $BUFFER ]] && zle clear-screen || zle autosuggest-accept }
zle -N clear-or-complete # Smart C-l, accept autosuggestion while typing, otherwise clear screen
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(clear-or-complete)

mkcd() { mkdir -p $@ && cd ${@:$#} }

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
