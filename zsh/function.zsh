autoload -Uz bracketed-paste-magic # auto escape url
zle -N bracketed-paste bracketed-paste-magic

zle-line-init() { echo -ne "\e[5 q" } # zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
zle -N zle-line-init
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

mkcd() { mkdir -p $@ && cd ${@:$#} }
fg-bg() { [[ $#BUFFER -eq 0 ]] && { fg; zle reset-prompt; zle-line-init } || zle push-input }
zle -N fg-bg

updir-onthefly() {
  if [ -z $BUFFER ]; then 
    cd ..; zle reset-prompt 
  else 
    zle kill-whole-line && cd ..
    zle reset-prompt; zle yank
  fi
}
zle -N updir-onthefly

tmux-automation() {
  emulate -L zsh
  # Make sure even pre-existing tmux sessions use the latest SSH_AUTH_SOCK. (Inspired by: https://gist.github.com/lann/6771001)
  local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
  [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ] && ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  # If provided with args, pass them through.
  if [[ -n "$@" ]]; then
    env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"
    return
  fi
  # Check for .tmux file (poor man's Tmuxinator).
  if [ -x .tmux ]; then
    # Prompt the first time we see a given .tmux file before running it.
    local DIGEST="$(openssl sha -sha512 .tmux)"
    if ! grep -q "$DIGEST" ~/..tmux.digests 2> /dev/null; then
      cat .tmux
      read -k 1 -r 'REPLY?Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
      echo
      if [[ $REPLY =~ ^[Tt]$ ]]; then
        echo "$DIGEST" >> ~/..tmux.digests
        ./.tmux
        return
      fi
    else
      ./.tmux
      return
    fi
  fi
  # Attach to existing session, or create one, based on current directory.
  local SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
  env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}
