zle-line-init() { echo -ne "\e[5 q"; } # '|' cursor
_cursor_underline() { echo -ne "\e[3 q"; } # '_' cursor
zle-keymap-select() { # Change cursor shape for different vi modes.
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    _cursor_underline
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] \
       || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    zle-line-init
  fi
}
zle -N zle-line-init
zle -N zle-keymap-select
# preexec_functions+=(zle-line-init) # Init beam shape cursor before every cmd
