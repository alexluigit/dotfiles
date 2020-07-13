# Use Emacs mode (since EDITOR=nvim, if using bindkey -e,  zsh will turn on vi-mode automatically)
bindkey -e
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Custom function keybind
bindkey "^\\" updir-onthefly
bindkey '^f'  smart-ctrl-f # Forward char       or  "find"
bindkey '^l'  smart-ctrl-l # Clear screen       or  "Line complete"
bindkey '^n'  smart-ctrl-n # Forward word       or  "Notes"
bindkey '^p'  smart-ctrl-p # Backward word      or  "Projects"
bindkey '^o'  fzf-open
bindkey '^r'  fzf-history
bindkey '^t'  fzf-starstar
bindkey '^z'  fg-bg

# Autosuggest small word
bindkey '^[OQ' vi-backward-word # Remap to ^;
bindkey '^[OR' vi-forward-word # Remap to ^'

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
