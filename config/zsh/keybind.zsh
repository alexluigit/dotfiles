# Use Emacs mode (since EDITOR=nvim, if using bindkey -e,  zsh will turn on vi-mode automatically)
bindkey -e
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# TODO:clipboard
# smart keys
bindkey "^\\"    updir-onthefly
bindkey '^f'     fcd-or-find
bindkey '^[[17~' backwardchar-or-edit # Ramap <C-i> to F6
bindkey '^o'     forwardchar-or-open
bindkey '^z'     fg-bg
bindkey '^l'     clear-or-complete
bindkey '^[OQ'   vi-backward-word # Remap <ctrl-;> to F2 and <ctrl-'> to F3
bindkey '^[OR'   vi-forward-word # This key can also trigger partial autocomplete

bindkey '^n'  fzf-note
bindkey '^p'  fzf-project
bindkey '^r'  fzf-history
bindkey '^t'  fzf-starstar

# History searching base on what you already typed
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search
bindkey '^k' up-line-or-beginning-search

# Edit current command in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# delete-word
# backward-kill-line
# beginning-of-line
