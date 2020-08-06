# TODO fzf-music
bol-or-fdot() { [[ -n $BUFFER ]] && { zle beginning-of-line } || __fzf-dot }
eol-or-open() { [[ -n $BUFFER ]] && { zle end-of-line; return } || __fzf-open $PWD }
fzf-note() { __fzf-open ~/Documents/Notes 'fd -tf' nvim }
fzf-starstar() { BUFFER="$BUFFER**"; zle end-of-line; zle fzf-completion; }
fzf-dirstack() { dirs -v | awk '{ $1=""; print $0 }' | fzf; zle accept-line }
fzf-pac-sync() { sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}") }
fzf-yay-sync() { yay -Syy $(yay -Ssq | fzf -m --preview="yay -Si {}") }
fzf-pac-local() { sudo pacman -Rns $(pacman -Qeq | fzf -m --preview="pacman -Si {}") }
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
fzf-z() {
  local homepre="/home/alex"
  local drivepre="/media/HDD"
  dest=$(_z -l 2>&1 | sed '/\/home$\|\/$/d' | sed "s|\s$homepre|  |" \
  | sed "s|\s$drivepre|  |" | awk '{$1=""; print $0}' \
  | fzf +s --tac | sed "s|  |$drivepre|" | sed "s|  |$homepre|")
  [[ -z $dest ]] && return || cd $dest
  zle reset-prompt
}
fzf-cd() {
  local drivePath="$HOME/Documents/Drive/"
  local dir="$1/"
  local defaultPath="$HOME/"
  local dest=$(fd -H -L -t d $2 . ${1:-$defaultPath} \
  | sed "s|^$drivePath|/media/HDD/|" | sed "s|^$dir||" | fzf --preview="tree -L 1 $dir{}")
  [[ -z "$dest" ]] && return || { cd "$dir$dest" && zle reset-prompt 2>/dev/null }
}
__fzf-open() {
  local vpre="Documents/Drive/Video"
  local cpre="Documents/Drive/Camera"
  local dpre="Documents/Drive/Dev"
  local mpre="Documents/Drive/Music"
  local dir="${1:-/home/alex}/" fdCmd="${2:-fd -tf -L}" openCmd="${3:-xdg-open}"
  eval "$fdCmd . '$dir'" | sed "s|^$dir||" \
  | sed "s|^$vpre|   |" | sed "s|^$cpre|   |" | sed "s|^$dpre|   |" | sed "s|^$mpre|   |" \
  | fzf -m --preview="preview '$dir'{}" \
  | sed "s|^   |$vpre|" | sed "s|^   |$cpre|" | sed "s|^   |$dpre|" | sed "s|^   |$mpre|" \
  | sed "s|^|$dir|" | xargs -ro -d '\n' $openCmd 2>&1
  zle reset-prompt; zle-line-init
}
__fzf-dot() { cd ~/Dev/Alex.files; __fzf-open ~/Dev/Alex.files 'fd -tf -H' nvim; cd -; zle reset-prompt; }

zle -N bol-or-fdot
zle -N eol-or-open
zle -N fzf-note
zle -N fzf-starstar
zle -N fzf-dirstack
zle -N fzf-history
zle -N fzf-z
