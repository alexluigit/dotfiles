autoload -Uz bracketed-paste-magic # auto escape url
zle -N bracketed-paste bracketed-paste-magic

zle-line-init() { echo -ne "\e[5 q" } # zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
zle -N zle-line-init
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

mkcd() { mkdir -p $@ && cd ${@:$#} }

updir-onthefly() {
  if [ -z $BUFFER ]; then 
    cd ..; zle reset-prompt 
  else 
    zle kill-whole-line && cd ..
    zle reset-prompt; zle yank
  fi
}
zle -N updir-onthefly

# TODO fzf-open --> fzf-music & fzf-video
# TODO fzf-vim -->  fzf-edit
# TODO fzf-git-checkout
fzf-open() { fd -t f -L --ignore-file /Volumes/HDD/.fdignore . /Volumes/HDD | fzf -m | gxargs -ro -d '\n' open >/dev/null }
zle -N fzf-open

fzf-vim() {
  fd -t f -H -I --ignore-file ~/.fdignore . ~ | fzf -m | gxargs -ro -d '\n' nvim 2>&-
  zle reset-prompt 2>&1; zle-line-init 2>&1
}
zle -N fzf-vim

fzf-note() {
  local NPath='/Users/simon/Documents/AllNotes/'
  fd -t f . $NPath | sed "s|$NPath||" | fzf -m --preview="bat -p --color=always $NPath{}" | sed "s|^|$NPath|" | gxargs -ro -d '\n' nvim
  zle reset-prompt 2>&1; zle-line-init 2>&1
}
zle -N fzf-note

fzf-cd() {
  local destination=$(fd -H -t d -d ${2:-5} . ${1:-/} | fzf --preview='tree -L 1 {}') 
  [[ ! -z "$destination" ]] && cd "$destination" 
  zle reset-prompt 2>&-
}
zle -N fzf-cd

fzf-project() { 
  local prefix="/Users/$USER/dev/"
  local destination=$(fd -H -t d -d 1 . ~/dev | sed "s|$prefix||" | fzf --preview="tree -L 1 $prefix{}" )
  [[ ! -z "$destination" ]] && cd "/Users/simon/dev/$destination" 
  zle reset-prompt 2>&1; zle-line-init 2>&1
}
zle -N fzf-project

fzf-history() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 |
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" "fzf" ) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle -N fzf-history

fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg; zle reset-prompt; zle-line-init
  else
    zle push-input
  fi
}
zle -N fg-bg

tmux-automation() {
  emulate -L zsh
  # Make sure even pre-existing tmux sessions use the latest SSH_AUTH_SOCK.
  # (Inspired by: https://gist.github.com/lann/6771001)
  local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
  if [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  fi
  # If provided with args, pass them through.
  if [[ -n "$@" ]]; then
    env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"
    return
  fi
  # Check for .tmux file (poor man's Tmuxinator).
  if [ -x .tmux ]; then
    # Prompt the first time we see a given .tmux file before running it.
    local DIGEST="$(openssl sha512 .tmux)"
    if ! grep -q "$DIGEST" ~/.local/..tmux.digests 2> /dev/null; then
      cat .tmux
      read -k 1 -r \
        'REPLY?Trust (and run) this .tmux file? (y = trust, otherwise = skip) '
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "$DIGEST" >> ~/.local/..tmux.digests
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
