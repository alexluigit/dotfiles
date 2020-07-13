mkcd() { mkdir -p $@ && cd ${@:$#} } # As the name implies

# Use one key toggle fore/background
fg-bg() { [[ $#BUFFER -eq 0 ]] && { fg; zle reset-prompt; zle-line-init } || zle push-input }
zle -N fg-bg

# Up a dir anytime
updir-onthefly() {
  [[ -z $BUFFER ]] && { cd ..; zle reset-prompt } \
  || { zle kill-whole-line && cd ..; zle reset-prompt; zle yank }
}
zle -N updir-onthefly

# Smart C-l, accept autosuggestion while typing, otherwise clear screen (empty buffer)
smart-ctrl-l() { [[ -z $BUFFER ]] && zle clear-screen || zle autosuggest-accept }
zle -N smart-ctrl-l
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(smart-ctrl-l)

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
