# Use Emacs mode (since EDITOR=nvim, if using bindkey -e,  zsh will turn on vi-mode automatically)
bindkey -e
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Custom function keybind
bindkey "^\\" updir-onthefly
bindkey '^o' fzf-open
bindkey '^n' fzf-note
bindkey '^p' fzf-project
bindkey '^r' fzf-history
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
# bindkey '^[[18;2~' vi-forward-word
# bindkey '^[[17;2~' vi-backward-word

bindkey '^[OQ' vi-backward-word
bindkey '^[OR' vi-forward-word

# delete-word
# backward-kill-line
# delete-char
# beginning-of-line
