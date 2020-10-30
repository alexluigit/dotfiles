# Public
bol-or-fdot() { [[ -n $BUFFER ]] && { zle beginning-of-line } || __fzf-dot }
eol-or-open() { [[ -n $BUFFER ]] && { zle end-of-line; return } || __fzf-open $PWD }
del-or-fzfz() { [[ -n $BUFFER ]] && { zle delete-char; return } || __fzf-navi }
fzf-note() { __fzf-open ~/Documents/Notes 'fd -tf' nvim }
fzf-dirstack() { __fzf-navi stack }
fzf-starstar() { BUFFER="$BUFFER**"; zle end-of-line; zle fzf-completion; }
fzf-pac-sync() {
  local selected=$(pacman -Ssq | fzf $FZF_DEFAULT_OPTS -m --preview="pacman -Si {}")
  [[ -n $selected ]] && sudo pacman -Syy $selected
}
fzf-yay-sync() {
  local selected=$(cat ~/.config/yay/aurlist.txt | fzf $FZF_DEFAULT_OPTS -m --preview="yay -Si {}")
  [[ -n $selected ]] && yay -Syy $selected
}
fzf-pac-local() {
  local selected=$(pacman -Qeq | fzf $FZF_DEFAULT_OPTS -m --preview="pacman -Si {}")
  [[ -n $selected ]] && sudo pacman -Rns $selected
}
fzf-history() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=($(fc -rl 1 | FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index \
  --bind=ctrl-r:toggle-sort --query=${(qqq)LBUFFER} +m" "fzf" ))
  local ret=$?
  [[ -n "$selected" ]] && { num=$selected[1]; \
  [[ -n "$num" ]] && zle vi-fetch-history -n $num }
  zle reset-prompt
  return $ret
}
fzf-cd() {
  local drivePath="$HOME/Documents/Drive/"
  local dir="$1/"
  local defaultPath="$HOME/"
  local dest=$(fd -H -L -t d $2 . ${1:-$defaultPath} \
  | sed "s|^$drivePath|/media/HDD/|" | sed "s|^$dir||" | fzf $FZF_DEFAULT_OPTS --preview="tree -L 1 $dir{}")
  [[ -z "$dest" ]] && return || { cd "$dir$dest" && zle reset-prompt 2>/dev/null }
}

# Private
__fzf-navi() {
  [[ -z $1 ]] && local cmd=(_z -l) || local cmd=(dirs -lv)
  local homepre="/home/alex"
  local drivepre="/media/HDD"
  dest=$("${cmd[@]}" 2>&1 | sed '/\/home$\|\/$/d' | awk '{print $2}'\
  | sed "s|$homepre| |" | sed "s|$drivepre| |" \
  | fzf +s --tac $FZF_DEFAULT_OPTS | sed "s| |$drivepre|" | sed "s| |$homepre|")
  [[ -z $dest ]] && return || cd $dest
  zle reset-prompt
}
__fzf-open() {
  local vpre="Documents/Drive/Video"
  local cpre="Documents/Drive/Camera"
  local dpre="Documents/Drive/Dev"
  local mpre="Documents/Drive/Music"
  local dir="${1:-/home/alex}/" fdCmd="${2:-fd -tf -L}" openCmd="${3:-xdg-open}"
  eval "$fdCmd . '$dir'" | sed "s|^$dir||" \
  | sed "s|^$vpre|   |" | sed "s|^$cpre|   |" | sed "s|^$dpre|   |" | sed "s|^$mpre|   |" \
  | fzf $FZF_DEFAULT_OPTS -m --preview="preview '$dir'{}" \
  | sed "s|^   |$vpre|" | sed "s|^   |$cpre|" | sed "s|^   |$dpre|" | sed "s|^   |$mpre|" \
  | sed "s|^|$dir|" | xargs -ro -d '\n' $openCmd 2>&1
  zle reset-prompt; zle-line-init
}
__fzf-dot() { cd ~/Dev/Alex.files; __fzf-open ~/Dev/Alex.files 'fd -tf -H' nvim; cd -; zle reset-prompt; }

zle -N bol-or-fdot
zle -N eol-or-open
zle -N del-or-fzfz
zle -N fzf-note
zle -N fzf-starstar
zle -N fzf-dirstack
zle -N fzf-history
