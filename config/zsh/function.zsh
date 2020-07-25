mkcd() { mkdir -p $@ && cd ${@:$#} }

fg-bg() { [[ $#BUFFER -eq 0 ]] && { fg; zle reset-prompt; zle-line-init } || zle push-input }
zle -N fg-bg # Use one key toggle fore/background

updir-onthefly() {
  [[ -z $BUFFER ]] && { cd ..; zle reset-prompt } \
  || { zle kill-whole-line && cd ..; zle reset-prompt; zle yank }}
zle -N updir-onthefly # Up a dir anytime

clear-or-complete() { [[ -z $BUFFER ]] && zle clear-screen || zle autosuggest-accept }
zle -N clear-or-complete # Smart C-l, accept autosuggestion while typing, otherwise clear screen
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(clear-or-complete)

tmux-automation() {
  # Make sure even pre-existing tmux sessions use the latest SSH_AUTH_SOCK. (Inspired by: https://gist.github.com/lann/6771001)
  local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
  [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ] && ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  # If provided with args, pass them through.
  [[ -n "$@" ]] && { env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"; return }
  # Check for .tmux file
  [ -x .tmux ] && { ./.tmux; return }
  # Attach to existing session, or create one, based on current directory.
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

unalias z
z() {
  [[ -z "$*" ]] && cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')" \
  || { _last_z_args="$@"; _z "$@" }
}
zz() { cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")" }
alias j=z; alias jj=zz
