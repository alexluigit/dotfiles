# TODO fzf-open --> fzf-music & fzf-video
# TODO fzf-vim -->  fzf-edit
# TODO fzf-git-checkout
# TODO fzf-ctrl-t
fzf-open() { fd -t f -L --ignore-file /Volumes/HDD/.fdignore . /Volumes/HDD | fzf -m | gxargs -ro -d '\n' open >/dev/null }
zle -N fzf-open

fzf-vim() {
  fd -t f -H -I --ignore-file ~/.fdignore . ~ | fzf -m | gxargs -ro -d '\n' nvim 2>&-
  zle reset-prompt 2>&1; zle-line-init 2>&1
}
zle -N fzf-vim

fzf-note() {
  local NPath="/Users/$USER/Documents/AllNotes/"
  fd -t f . $NPath | sed "s|$NPath||" | fzf -m --preview="bat -p --color=always $NPath{}" | sed "s|^|$NPath|" | gxargs -ro -d '\n' nvim
  zle reset-prompt 2>&1; zle-line-init 2>&1
}
zle -N fzf-note

fzf-cd() {
  local destination=$(fd -H -L -t d -d ${2:-5} . ${1:-/Volumes/HDD} | fzf --preview='tree -L 1 {}') 
  [[ ! -z "$destination" ]] && cd "$destination" 
  zle reset-prompt 2>&-
}
zle -N fzf-cd

fzf-project() { 
  local prefix="/Users/$USER/dev/"
  local destination=$(fd -H -t d -d 1 . ~/dev | sed "s|$prefix||" | fzf --preview="tree -L 1 $prefix{}" )
  [[ ! -z "$destination" ]] && cd "/Users/$USER/dev/$destination" 
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
