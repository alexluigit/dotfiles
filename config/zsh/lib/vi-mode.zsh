stty -ixon # Disable XON/XOFF flow control
autoload -Uz move-line-in-buffer
autoload -Uz select-quoted select-bracketed
autoload -Uz surround
autoload -Uz edit-command-line
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-in-buffer move-line-in-buffer; zle -N down-line-in-buffer move-line-in-buffer
zle -N select-quoted; zle -N select-bracketed
zle -N delete-surround surround; zle -N add-surround surround; zle -N change-surround surround
zle -N edit-command-line
zle -N up-line-or-beginning-search; zle -N down-line-or-beginning-search
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do; bindkey -M $m $c select-quoted; done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do; bindkey -M $m $c select-bracketed; done
done
bindkey -v # vi-mode
bindkey -a            'cs'          change-surround
bindkey -a            'ds'          delete-surround
bindkey -a            'ys'          add-surround
bindkey -a            \'            vi-forward-char
bindkey -M vicmd      'e'           up-line-in-buffer # Do not go search history
bindkey -M vicmd      'n'           down-line-in-buffer
bindkey -M visual     'S'           add-surround
bindkey -M menuselect 'h'           vi-backward-char
bindkey -M menuselect 'e'           vi-up-line-or-history
bindkey -M menuselect  \'           vi-forward-char
bindkey -M menuselect 'n'           vi-down-line-or-history
bindkey               '^e'          up-line-or-beginning-search
bindkey               '^n'          down-line-or-beginning-search
