stty -ixon # Disable XON/XOFF flow control
bindkey -v # vi-mode
KEYTIMEOUT=0

# Better vi-mode
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done
bindkey -a            cs  change-surround
bindkey -a            ds  delete-surround
bindkey -a            ys  add-surround
bindkey -M vicmd      'k' up-line-in-buffer # Do not go search history
bindkey -M visual     'S' add-surround
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Functions
bindkey '^a'     fzf-dirstack
bindkey '^e'     edit-command-line
bindkey '^f'     file-or-forwardchar
bindkey '^[[17~' bol-or-fdot # C-i -> F6
bindkey '^j'     down-line-or-beginning-search
bindkey '^k'     up-line-or-beginning-search
bindkey '^l'     clear-or-complete
bindkey '^n'     fzf-note
bindkey '^o'     eol-or-open
bindkey '^p'     fzf-z
bindkey '^r'     fzf-history
bindkey '^s'     autopair
bindkey '^t'     fzf-starstar
bindkey '^u'     kill-and-yank-buffer
bindkey '^z'     fg-bg
bindkey '^[OQ'   vi-backward-word # Remap <ctrl-;> to F2 and <ctrl-'> to F3
bindkey '^[OR'   vi-forward-word # This key can also trigger partial autocomplete
bindkey '^\\'    updir-onthefly
