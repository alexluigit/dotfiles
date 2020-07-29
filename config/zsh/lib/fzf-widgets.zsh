# TODO fzf-music
fzf-cd() {
  local drivePath="$HOME/Documents/Drive/"
  local dir="$1/"
  local defaultPath="$HOME/"
  local dest=$(fd -H -L -t d $2 --ignore-file $XDG_CONFIG_HOME/fd/fdignore . ${1:-$defaultPath} \
  | sed "s|^$drivePath|/media/HDD/|" | sed "s|^$dir||" | fzf --preview="tree -L 1 $dir{}")
  [[ -z "$dest" ]] && return || { cd "$dir$dest" && zle reset-prompt 2>/dev/null }
}
fzf-project() { fzf-cd ~/Dev -d1 }; zle -N fzf-project

fzf-open() {
  local dir="$1/" fdCmd="$2" previewCmd="$3" openCmd="$4"
  local dftFd="fd -t f -L --ignore-file $XDG_CONFIG_HOME/fd/fdignore"
  local dftDir="$HOME/" dftPreview="du -h" dftOpen=xdg-open
  eval "${fdCmd:-$dftFd} . '${dir:-$dftDir}'" | sed "s|^$dir||" \
  | fzf -m --preview="${previewCmd:-$dftPreview} '$dir'{}" \
  | sed "s|^|$dir|" | xargs -ro -d '\n' ${openCmd:-$dftOpen} 2>&1
  zle reset-prompt; zle-line-init
}
fzf-dot() {
  cd ~/Dev/Alex.files
  fzf-open ~/Dev/Alex.files \
  'fd -tf -H --ignore-file ~/.config/fd/dotignore' \
  'bat -p --color=always' 'nvim'
  cd -; zle reset-prompt; zle-line-init
}
zle -N fzf-dot
forwardchar-or-open() { [[ -n $BUFFER ]] && { zle forward-char; return } || fzf-open $PWD }
zle -N forwardchar-or-open
fzf-note() { fzf-open ~/Documents/AllNotes 'fd -tf' 'bat -p --color=always' nvim }
zle -N fzf-note

fzf-history() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=($(fc -rl 1 | FZF_DEFAULT_OPTS="-n2..,.. --tiebreak=index \
  --bind=ctrl-r:toggle-sort --query=${(qqq)LBUFFER} +m" "fzf" ))
  local ret=$?
  [[ -n "$selected" ]] && { num=$selected[1]; \
  [[ -n "$num" ]] && zle vi-fetch-history -n $num }
  zle reset-prompt
  return $ret
}
zle -N fzf-history

fzf-starstar() { BUFFER="$BUFFER**"; zle end-of-line; zle fzf-completion; }
zle -N fzf-starstar

fzf-dirstack() { dirs -v | awk '{ $1=""; print $0 }' | fzf; zle accept-line }
zle -N fzf-dirstack
