ZDOTDIR="/home/$USER/.config/zsh"
zle-line-init() { echo -ne "\e[5 q"; } # '|' cursor
zle-keymap-select() { # Change cursor shape for different vi modes.
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne "\e[3 q" # '_' underline
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] \
       || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    zle-line-init
  fi
}
zle -N zle-line-init
zle -N zle-keymap-select
preexec_functions+=(zle-line-init) # Init beam shape cursor before every cmd

# Following aliases are available in nvim since in .zshenv
alias twf="twf --bind='n::tree:next,e::tree:prev,h::tree:close,i::tree:open,ctrl-n::preview:down,ctrl-e::preview:up' --previewCmd='bat -p --color=always {}'"
