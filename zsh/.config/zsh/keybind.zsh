# Init CursorShape
zle-line-init() {
  echo -ne "\e[5 q" # zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
}
zle -N zle-line-init
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use Emacs mode (since EDITOR=nvim, if using bindkey -e,  zsh will turn on vi-mode automatically)
bindkey -e
bindkey '^f' delete-word
bindkey '^j' backward-kill-line
bindkey '^l' delete-char
bindkey '^b' beginning-of-line
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Mkdir and cd into immediately
function take() {
  mkdir -p $@ && cd ${@:$#}
}

updir_on_the_fly() {
  if [ -z $BUFFER ]; then 
    cd ..; zle reset-prompt 
  else 
    zle kill-whole-line && cd ..
    zle reset-prompt; zle yank
  fi
}
zle -N updir_on_the_fly
bindkey "^\\" updir_on_the_fly

fzf_open() {
  fd -t f -L --ignore-file /Volumes/HDD/.fdignore . /Volumes/HDD | fzf -m | gxargs -ro -d '\n' open >/dev/null
}
zle -N fzf_open
bindkey '^o' fzf_open

fzf_vim_open() {
  fd -t f -H -I . ~ | fzf -m | gxargs -ro -d '\n' nvim 2>&-
  zle reset-prompt; zle-line-init
}
zle -N fzf_vim_open
bindkey '^p' fzf_vim_open

fzf_cd() {
  # local dir=${PWD}
  # cd ~ ; cd "$(fd -H -t d | fzf --preview='tree -L 1 {}' --bind='space:toggle-preview' --preview-window=:hidden)"
  # cd ~ ; cd "$(fd -H -t d | fzf --preview='tree -L 1 {}')"
  local destination=$(fd -H -t d . / | fzf --preview='tree -L 1 {}') 
  [[ ! -z "$destination" ]] && cd "$destination" 
  # cd $(fd -H -t d . '/' | fzf --preview='tree -L 1 {}')
  # zle accept-line
  # [[ ${PWD} = $HOME ]] && cd $dir 
  zle reset-prompt
}
zle -N fzf_cd
bindkey '^t' fzf_cd

fzf-history-widget() {
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
zle     -N   fzf-history-widget
bindkey '^r' fzf-history-widget

function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg; zle reset-prompt; zle-line-init
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^z' fg-bg

# History searching base on what you already typed
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Edit the current command line in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# Autosuggest small word
bindkey '^[[1;5C' vi-forward-word
bindkey '^[[1;5D' vi-backward-word
