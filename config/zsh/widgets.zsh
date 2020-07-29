autoload -U edit-command-line; zle -N edit-command-line
autoload -U up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search; zle -N down-line-or-beginning-search

kill-and-yank-buffer() { echo -n "$BUFFER" | xclip -selection clipboard; zle kill-whole-line }
zle -N kill-and-yank-buffer

fcd-or-forwardchar() { [[ -z $BUFFER ]] && lf || zle forward-char }
zle -N fcd-or-forwardchar

fg-bg() { [[ $#BUFFER -eq 0 ]] && { fg; zle reset-prompt; zle-line-init } || zle push-input }
zle -N fg-bg # Use one key toggle fore/background

updir-onthefly() {
  [[ -z $BUFFER ]] && { cd ..; zle reset-prompt } \
  || { zle kill-whole-line && cd ..; zle reset-prompt; zle yank }}
zle -N updir-onthefly # Up a dir anytime

clear-or-complete() { [[ -z $BUFFER ]] && zle clear-screen || zle autosuggest-accept }
zle -N clear-or-complete # Smart C-l, accept autosuggestion while typing, otherwise clear screen
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(clear-or-complete)
