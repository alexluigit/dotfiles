# TODO fzf-music
# TODO fzf-git

fzf-cd() {
  local destination=$(fd -H -L -t d . ${1:-/media/HDD} \
  | fzf --preview='tree -L 1 {}')
  [[ -n "$destination" ]] && cd "$destination"
  zle reset-prompt 2>/dev/null
}
smart-ctrl-f() { [[ -n $BUFFER ]] && { zle forward-char; return } || fzf-cd }
zle -N smart-ctrl-f

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

fzf-note() {
  local nPath="$HOME/Documents/AllNotes/"
  fd -t f . $nPath | sed "s|$nPath||" \
  | fzf -m --preview="bat -p --color=always $nPath{}" \
  | sed "s|^|$nPath|" | xargs -ro -d '\n' nvim
  zle reset-prompt 2>&1; zle-line-init 2>&1
}
smart-ctrl-n() { [[ -n $BUFFER ]] && { zle forward-word; return } || fzf-note }
zle -N smart-ctrl-n

fzf-open() {
  local fPath="/media/HDD/"
  fd -t f -L --ignore-file $fPath.fdignore . $fPath | sed "s|$fPath||" \
  | fzf -m --query=${(q)LBUFFER} --preview="du -h $fPath{}" \
  | sed "s|^|$fPath|" | xargs -ro -d '\n' xdg-open >/dev/null
}
zle -N fzf-open

fzf-project() {
  local prefix="$HOME/Dev/"
  local destination=$(fd -H -t d -d 1 . ~/Dev | sed "s|$prefix||" | fzf --preview="tree -L 1 $prefix{}" )
  [[ ! -z "$destination" ]] && cd "$prefix$destination"
  zle reset-prompt 2>&1; zle-line-init 2>&1
}
smart-ctrl-p() { [[ -n $BUFFER ]] && { zle backward-word; return } || fzf-project }
zle -N smart-ctrl-p

fzf-starstar() {
  BUFFER="$BUFFER**"
  zle end-of-line; zle fzf-completion;
}
zle -N fzf-starstar

# fzf-vim() {
#   fd -t f -H -I --ignore-file ~/.fdignore . ~ \
#   | fzf -m | xargs -ro -d '\n' nvim 2>&-
#   zle reset-prompt 2>&1; zle-line-init 2>&1
# }
# zle -N fzf-vim
