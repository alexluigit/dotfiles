# Since EDITOR=nvim, if using bindkey -e,  zsh will turn on vi-mode automatically
bindkey -e
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Functions
bindkey '^a'     fzf-dirstack
bindkey '^e'     edit-command-line
bindkey '^f'     fcd-or-forwardchar
bindkey '^g'     fzf-dot
bindkey '^[[17~' beginning-of-line # C-i -> F6
bindkey '^[[B'   down-line-or-beginning-search # Down
bindkey '^[[A'   up-line-or-beginning-search # Up
bindkey '^l'     clear-or-complete
bindkey '^n'     fzf-note
bindkey '^o'     end-of-line
bindkey '^p'     forwardchar-or-open
bindkey '^r'     fzf-history
bindkey '^t'     fzf-starstar
bindkey '^u'     kill-and-yank-buffer
bindkey '^z'     fg-bg
bindkey '^[OQ'   vi-backward-word # Remap <ctrl-;> to F2 and <ctrl-'> to F3
bindkey '^[OR'   vi-forward-word # This key can also trigger partial autocomplete
bindkey '^\\'    updir-onthefly
