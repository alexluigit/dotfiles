n() { _set_title nvim; nvim $@; _reset_title; }
g() {  [[ -z $@ ]] && _inside_git_repo && _fugitive || git $@; }
mc() { mkdir -p $@ && cd ${@:$#}; } # make a dir and cd into it

# pacman
pas() { proxyon; res=($(fzf -m --preview="paru -Si {}" < ~/.local/share/paru/pkglist)); [[ -n $res ]] && paru $res; }
pau() { proxyon; paru "$@"; }
pal() { res=($(pacman -Qeq | fzf -m --preview="paru -Si {}")); [[ -n $res ]] && sudo pacman -Rns $res; }

# tmux automation
t() {
  local S_NAME=$(basename "${PWD//[.:]/_}")
  local S_CONFIG=$XDG_DATA_HOME/tmux$PWD
  [[ $1 == "edit" ]] && { mkdir -p $S_CONFIG; touch $S_CONFIG/tmux; chmod +x $S_CONFIG/tmux; nvim $S_CONFIG/tmux; return; }
  _switch() { [[ -n $TMUX ]] && tmux switch -t $1 2>/dev/null || tmux a -t $1; }
  [[ -n $@ ]] && { tmux $@; return; }
  HAS_SESSION=$(tmux has-session -t=$S_NAME 2>/dev/null)
  [ $? -eq 0 ] && _switch $S_NAME || { [ -x $S_CONFIG/tmux ] && { tmux new -s $S_NAME -d && $S_CONFIG/tmux $S_NAME && _switch $S_NAME; } \
  || tmux new -s $S_NAME -d && _switch $S_NAME; }
}
