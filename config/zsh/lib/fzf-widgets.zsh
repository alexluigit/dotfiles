# Public
fzf-dev-vid() { __fzf-open '' '' '' " "}
fzf-note() { __fzf-open '' '' nvim " "}
fzf-dirstack() { __fzf-navi stack }
fzf-starstar() { BUFFER="$BUFFER **"; zle end-of-line; zle fzf-completion; }
del-or-fzfz() { [[ -n $BUFFER ]] && { zle delete-char; return } || __fzf-navi z }
eol-or-updir() { [[ -n $BUFFER ]] && { zle end-of-line; return } || { cd ..; zle reset-prompt } }
bol-or-inside() {
  if [[ -n $BUFFER ]]; then
    zle beginning-of-line
  elif [[ ${(%)${:-%~}} == '~' ]]; then
    cd ~/Dev/Alex.files; __fzf-open ~/Dev/Alex.files 'fd -tf -H' nvim; cd -; zle reset-prompt
  else
    __fzf-open $PWD 'fd -Htf' nvim
  fi
}

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

__fzf-navi() {
  local cmd colnr=2
  case $1 in
    "z") cmd=(_z -l);;
    "stack") cmd=(dirs -lv);;
    "home") cmd=(fd -H -L -t d . /home/alex); colnr=1;;
  esac
  local homepre="/home/alex/"
  local drivepre="/media/HDD/"
  dest=$("${cmd[@]}" 2>&1 | sed '/\/home\/alex$\|\/$\|\/home$/d' \
  | { [[ "$colnr" == 2 ]] && awk '{print $2}' || awk '{print $0}' } \
  | sed "s|$homepre| |" | sed "s|$drivepre| |" | sed "s|^\/| |" \
  | fzf +s --tac $FZF_DEFAULT_OPTS | sed "s| |\/|" | sed "s| |$drivepre|" | sed "s| |$homepre|")
  [[ -z $dest ]] && return || cd -P $dest
  zle reset-prompt
}

__fzf-open() {
  local dpre="Videos/dev/"
  local vpre="Videos/"
  local cpre="Pictures/"
  local mpre="Music/"
  local npre="Documents/notes/"
  local dir="${1:-/home/alex}/" fdCmd="${2:-fd -tf -L}" openCmd="${3:-xdg-open}"
  eval "$fdCmd . '$dir'" | sed "s|^$dir||" \
  | sed "s|^$dpre| |" | sed "s|^$cpre| |" | sed "s|^$vpre| |" | sed "s|^$mpre| |" | sed "s|^$npre| |" \
  | fzf $FZF_DEFAULT_OPTS -m --preview="preview '$dir'{}" --query=$4 \
  | sed "s|^ |$vpre|" | sed "s|^ |$cpre|" | sed "s|^ |$dpre|" | sed "s|^ |$mpre|" | sed "s|^ |$npre|" \
  | sed "s|^|$dir|" | xargs -ro -d '\n' $openCmd 2>&1
  zle reset-prompt; zle-line-init
}

zle -N bol-or-inside
zle -N eol-or-updir
zle -N del-or-fzfz
zle -N fzf-note
zle -N fzf-dev-vid
zle -N fzf-starstar
zle -N fzf-dirstack
zle -N fzf-history
